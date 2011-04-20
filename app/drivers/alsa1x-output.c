/*
 * The Real SoundTracker - ALSA 1.0.x (output) driver, pcm
 *                       - requires ALSA 1.0.0 or newer
 *
 * Copyright (C) 2006 Yury Aliaev
 * The principles were taken from alsa 0.5 driver:
 * regards to Kai Vehmanen :-)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#include <config.h>

#if DRIVER_ALSA_09x

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <unistd.h>
#include <alsa/asoundlib.h>
#include <sys/time.h>

#include <gtk/gtk.h>
#include <glib/gprintf.h>

#include "i18n.h"
#include "driver-inout.h"
#include "mixer.h"
#include "errors.h"
#include "gui-subs.h"
#include "preferences.h"

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API

typedef struct _device_capabilities {
    guint minfreq, maxfreq;
    snd_pcm_uframes_t minbufsize, maxbufsize;
} device_capabilities;

enum {
    MONO8 = 0,
    STEREO8,
    MONO16,
    STEREO16,
    NUM_FORMATS
};

#define PARAMS_TO_ADDRESS(d) d->stereo + d->bits/4 - 2

typedef struct _alsa_driver {
    GtkWidget *configwidget;
    GtkWidget *alsa_device;
    GtkWidget *prefs_resolution_w[2];
    GtkWidget *prefs_channels_w[2];
    GtkWidget *prefs_mixfreq;
    GtkWidget *bufsizespin, *bufsizelabel, *periodspin, *periodlabel, *estimatelabel;

    GtkTreeModel *model;

    guint playrate;
    guint stereo;
    guint bits;
    guint buffer_size; /* The exponent of 2: real_buffer_size = 2 ^ buffer_size */
    snd_pcm_uframes_t persizemin, persizemax;
    guint num_periods; /* The exponent of 2, see buffer_size */

    gchar *device;
    device_capabilities devcap[NUM_FORMATS];
    gboolean can8, can16, canmono, canstereo, signedness8, signedness16;

    snd_pcm_t *soundfd;
    snd_output_t *output;
    snd_pcm_hw_params_t *hwparams;
    snd_pcm_sw_params_t *swparams;
    void *sndbuf;
    gpointer polltag;
    struct pollfd *pfd;
    gboolean firstpoll;

    guint p_mixfreq;
    snd_pcm_uframes_t p_fragsize;
    guint mf;

    double outtime;
    double playtime;

    gboolean verbose;
    gboolean hwtest;
    guint minfreq_old, maxfreq_old, address_old, bufsize_old;
} alsa_driver;

static const int mixfreqs[] = { 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000 };
#define NUM_FREQS sizeof(mixfreqs) / sizeof(mixfreqs[0])

static void	prefs_bufsize_changed		(GtkWidget *w, alsa_driver *d);
static void	prefs_periods_changed		(GtkWidget *w, alsa_driver *d);
static void	prefs_channels_changed		(GtkWidget *w, alsa_driver *d);
static void	prefs_resolution_changed	(GtkWidget *w, alsa_driver *d);

/* Put all gui_hlp_.* (and some other) functions into the separate file app/drivers/gui_helpers.c
   before writing alsa1x-input driver -- mutabor */

static void
alsa_error (const gchar *msg, gint err)
{
    static char buf[256];
    g_sprintf(buf, "%s: %s\n", _(msg), snd_strerror(err));
    error_error(buf);
}

static inline void
gui_hlp_set_radio_active (GtkWidget **radiobutton, guint i)
{
    if(GTK_WIDGET_IS_SENSITIVE(radiobutton[i]))
	gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(radiobutton[i]), TRUE);
}

typedef struct _compare_data {
    guint value;
    gint number;
} compare_data;

static gboolean
compare_func (GtkTreeModel *model, GtkTreePath *path, GtkTreeIter *iter, gpointer data)
{
    compare_data *cmp_data = (compare_data*)data;
    guint cur_val;

    gtk_tree_model_get(model, iter, 0, &cur_val, -1);

    if(cur_val == cmp_data->value) {
	gint *indices = gtk_tree_path_get_indices(path);

	cmp_data->number = indices[0];
	return TRUE; /* The desired element is found */
    }

    return FALSE;
}

static gboolean
gui_hlp_set_list_item (GtkWidget *combobox, GtkTreeModel *model, guint item)
{
    compare_data cmp_data;

    cmp_data.value = item;
    cmp_data.number = -1;
    gtk_tree_model_foreach(model, compare_func, &cmp_data);

    if(cmp_data.number >= 0) {
	gtk_combo_box_set_active(GTK_COMBO_BOX(combobox), cmp_data.number);
	return TRUE;
    }

    return FALSE;
}

typedef struct _str_cmp_data {
    const gchar *str;
    gboolean success;
    GtkComboBox *combobox;
} str_cmp_data;

static gboolean
str_cmp_func (GtkTreeModel *model, GtkTreePath *path, GtkTreeIter *iter, gpointer data)
{
    gchar *item_str = NULL;
    str_cmp_data *scd = (str_cmp_data *)data;

    gtk_tree_model_get(model, iter, 0, &item_str, -1);
    if(!item_str)
	return TRUE; /* Aborting due to error */

    if(!g_ascii_strcasecmp(item_str, scd->str)) {
	scd->success = TRUE;
	gtk_combo_box_set_active_iter(scd->combobox, iter);
	g_free(item_str);
	return TRUE;
    }

    g_free(item_str);
    return FALSE;
}

static void
gui_hlp_combo_box_prepend_text_or_set_active (GtkComboBox *combobox, const gchar *text, gboolean force_active)
{
    str_cmp_data scd;

    GtkTreeModel *model = gtk_combo_box_get_model(combobox);

    scd.str = text;
    scd.success = FALSE;
    scd.combobox = combobox;
    gtk_tree_model_foreach(model, str_cmp_func, &scd);

    if(!scd.success) {
	gtk_combo_box_prepend_text(combobox, text);
	if(force_active)
	    gtk_combo_box_set_active(combobox, 0);
    }
}

static void
set_highest_possible (GtkWidget **radiobutton, guint number)
{
    guint i;

    for(i = number - 1; i >= 0; i--) {
	if(GTK_WIDGET_IS_SENSITIVE(radiobutton[i])) {
	    gtk_toggle_button_set_active(GTK_TOGGLE_BUTTON(radiobutton[i]), TRUE);
	    break;
	}
    }
}

static void
update_freqs_list (alsa_driver *d, gboolean set_highest)
{
    GtkTreeIter iter;
    guint i;

    guint address = PARAMS_TO_ADDRESS(d);
    guint minfreq = d->devcap[address].minfreq;
    guint maxfreq = d->devcap[address].maxfreq;

    if(d->bits == 0)
	return;
    if((minfreq == d->minfreq_old) && (maxfreq == d->maxfreq_old))
	return;

    gui_list_clear_with_model(d->model);

    for(i = 0; i < NUM_FREQS; i++) {
	if((mixfreqs[i] >= minfreq) &&
	   (mixfreqs[i] < maxfreq)) {
	    gtk_list_store_append(GTK_LIST_STORE(d->model), &iter);
	    gtk_list_store_set(GTK_LIST_STORE(d->model), &iter, 0, mixfreqs[i], -1);
	}
    }
    gtk_list_store_append(GTK_LIST_STORE(d->model), &iter);
    gtk_list_store_set(GTK_LIST_STORE(d->model), &iter, 0, maxfreq, -1);
    if(set_highest)
	d->playrate = maxfreq;

    d->minfreq_old = minfreq;
    d->maxfreq_old = maxfreq;
}

static void
update_bufsize_range (alsa_driver *d)
{
    guint j = 0, k = 0;
    guint i;
    guint address = PARAMS_TO_ADDRESS(d);

    if(d->bits == 0)
	return;

    i = d->devcap[address].maxbufsize;
    while((i = i >> 1))
	j++;

    i = d->devcap[address].minbufsize;
    while((i = i >> 1))
	k++;
    if((1 << k) - d->devcap[address].minbufsize)
	k++;

    gtk_spin_button_set_range(GTK_SPIN_BUTTON(d->bufsizespin), k, j);
    if(d->hwtest)
        prefs_bufsize_changed(NULL, d);
}

static inline void
set_highest_freq (alsa_driver *d)
{
    /* It's a nasty Gtk+ hack, GtkListStore->length is marked 'private' but I don't know how to
       implement this another way -- mutab0r */
    gtk_combo_box_set_active(GTK_COMBO_BOX(d->prefs_mixfreq), GTK_LIST_STORE(d->model)->length - 1);
}

static inline void
set_max_spin(GtkWidget *spinbtn)
{
    gtk_spin_button_set_value(GTK_SPIN_BUTTON(spinbtn),
			      gtk_spin_button_get_adjustment(GTK_SPIN_BUTTON(spinbtn))->upper);
}

static inline void
update_periods_range (alsa_driver *d)
{
    guint i = 0;
    snd_pcm_uframes_t bufsize = 1 << d->buffer_size;
    guint permin = MAX(bufsize / d->persizemax, 2);
    guint permax = bufsize / d->persizemin;

    while((permin = permin >> 1))
	i++;
    permin = i;

    i = 0;
    while((permax = permax >> 1))
	i++;
    permax = i;

    gtk_spin_button_set_range(GTK_SPIN_BUTTON(d->periodspin), permin, permax);
    if(d->hwtest)
        prefs_periods_changed(NULL, d);
}

static void
update_estimate (alsa_driver *d)
{
    char *buf;
    snd_pcm_uframes_t periodsize = (1 << d->buffer_size) / (1 << d->num_periods);

    buf = g_strdup_printf(_("Estimated audio delay: %f milliseconds"), 1000 * (double)periodsize / (double)d->playrate);
    gtk_label_set_text(GTK_LABEL(d->estimatelabel), buf);

    g_free(buf);
}

static void
update_controls (alsa_driver *d)
{
    gtk_widget_set_sensitive(d->prefs_resolution_w[0], d->can8);
    gtk_widget_set_sensitive(d->prefs_resolution_w[1], d->can16);
    set_highest_possible(d->prefs_resolution_w, sizeof(d->prefs_resolution_w) / sizeof(d->prefs_resolution_w[0]));
    gtk_widget_set_sensitive(d->prefs_channels_w[0], d->canmono);
    gtk_widget_set_sensitive(d->prefs_channels_w[1], d->canstereo);
    set_highest_possible(d->prefs_channels_w, sizeof(d->prefs_channels_w) / sizeof(d->prefs_channels_w[0]));

    /* To be sure that all fields are initialized */
    prefs_channels_changed(NULL, d);
    prefs_resolution_changed(NULL, d);
    update_freqs_list(d, TRUE);
    set_highest_freq(d);
    update_bufsize_range(d);
    set_max_spin(d->bufsizespin);
}

/* Only update controls, do not set the highest values */
static void
update_controls_a (alsa_driver *d)
{
    gtk_widget_set_sensitive(d->prefs_resolution_w[0], d->can8);
    gtk_widget_set_sensitive(d->prefs_resolution_w[1], d->can16);
    gui_hlp_set_radio_active(d->prefs_resolution_w, d->bits / 8 - 1);

    gtk_widget_set_sensitive(d->prefs_channels_w[0], d->canmono);
    gtk_widget_set_sensitive(d->prefs_channels_w[1], d->canstereo);
    gui_hlp_set_radio_active(d->prefs_channels_w, d->stereo);

    update_freqs_list(d, FALSE);
    if(!gui_hlp_set_list_item(d->prefs_mixfreq, d->model, d->playrate))
	set_highest_freq(d);

    update_bufsize_range(d);
    gtk_spin_button_set_value(GTK_SPIN_BUTTON(d->bufsizespin), d->buffer_size);

    update_periods_range(d);
    gtk_spin_button_set_value(GTK_SPIN_BUTTON(d->periodspin), d->num_periods);
}

static gint
pcm_open_and_load_hwparams(alsa_driver *d)
{
    gint err;

    if((err = snd_pcm_open(&(d->soundfd), d->device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
	alsa_error(N_("ALSA device opening error"), err);
	return -1;
    }
    if((err = snd_pcm_hw_params_any(d->soundfd, d->hwparams)) < 0) {
	alsa_error(N_("hw params obtaining error"), err);
	snd_pcm_close(d->soundfd);
	return -1;
    }
    return 0;
}

static void
check_period_sizes (alsa_driver *d)
{
    /* Almost everything (luckily except sampling frequency) can affect period size: buffer size,
       format, channel numbers... So we need to recheck it after at least one of the parameters is
       changed -- mutab0r */
    gint err;
    guint address = PARAMS_TO_ADDRESS(d);

    /* The procedure is time-consuming and may cause audio system lock. So be sure if we really
       need it before starting... -- mutab0r */
    if(d->bits == 0)
	return;
    if((address == d->address_old) && (d->buffer_size == d->bufsize_old))
	return;

    if(pcm_open_and_load_hwparams(d) < 0)
	return;

    if((err = snd_pcm_hw_params_set_format(d->soundfd, d->hwparams,
				    (d->bits - 8) ? d->signedness16 ? SND_PCM_FORMAT_S16 : SND_PCM_FORMAT_U16 :
						    d->signedness8 ? SND_PCM_FORMAT_S8 : SND_PCM_FORMAT_U8)) < 0) {
	alsa_error(N_("Unable to set audio format"), err);
	snd_pcm_close(d->soundfd);
	return;
    }
    if((err = snd_pcm_hw_params_set_channels(d->soundfd, d->hwparams, d->stereo + 1)) < 0) {
	alsa_error(N_("Unable to set channels number"), err);
	snd_pcm_close(d->soundfd);
	return;
    }
    if(snd_pcm_hw_params_set_buffer_size(d->soundfd, d->hwparams, 1 << d->buffer_size) < 0) {
	/* Some soundcards report wrong maximal buffer size (maybe alsa bug). So we should try
	   to downscale its value before the reporting an error. The spinbutton still may display
	   the wrong number, but actually the correct value will be implemented.*/
	while((--d->buffer_size) >= 8)
	    if(!snd_pcm_hw_params_set_buffer_size(d->soundfd, d->hwparams, 1 << d->buffer_size))
		break;
	if(d->buffer_size < 8) {
	    error_error(N_("Unable to set appropriate buffer size"));
	    snd_pcm_close(d->soundfd);
	    return;
	}
    }

    snd_pcm_close(d->soundfd);

    if ((err = snd_pcm_hw_params_get_period_size_min(d->hwparams, &(d->persizemin), 0)) < 0) {
	alsa_error(N_("Unable to get minimal period size"), err);
	return;
    }
    if ((err = snd_pcm_hw_params_get_period_size_max(d->hwparams, &(d->persizemax), 0)) < 0) {
	alsa_error(N_("Unable to get maximal period size"), err);
	return;
    }

    update_periods_range(d);
    update_estimate(d);

    d->address_old = address;
    d->bufsize_old = d->buffer_size;
}

static gint
set_rates (alsa_driver *d, guint channels, guint format)
{
    guint ratemin, ratemax;
    snd_pcm_uframes_t bufsizemin, bufsizemax;
    gint err;

    if((err = snd_pcm_hw_params_set_channels(d->soundfd, d->hwparams, channels)) < 0) {
	alsa_error(N_("Unable to set channles number"), err);
	return -1;
    }
    if((err = snd_pcm_hw_params_get_rate_min(d->hwparams, &ratemin, 0)) < 0) {
	alsa_error(N_("Unable to get minimal sample rate"), err);
	return -1;
    }
    d->devcap[format].minfreq = MAX(ratemin, 8000);

    if((err = snd_pcm_hw_params_get_rate_max(d->hwparams, &ratemax, 0)) < 0) {
	alsa_error(N_("Unable to get maximal sample rate"), err);
	return -1;
    }
    d->devcap[format].maxfreq = MIN(ratemax, 96000);

    if((err = snd_pcm_hw_params_get_buffer_size_min(d->hwparams, &bufsizemin)) < 0) {
	alsa_error(N_("Unable to get minimal buffer size"), err);
	return -1;
    }
    d->devcap[format].minbufsize = MAX(bufsizemin, 256);

    if((err = snd_pcm_hw_params_get_buffer_size_max(d->hwparams, &bufsizemax)) < 0) {
	alsa_error(N_("Unable to get maximal buffer size"), err);
	return -1;
    }
    d->devcap[format].maxbufsize = bufsizemax;

    return 0;
}

static void
device_test (GtkWidget *w, alsa_driver *d)
{
    guint chmin, chmax, i;
    gint err;
    gchar *new_device;

    d->can8 = FALSE;
    d->can16 = FALSE;
    d->canmono = FALSE;
    d->canstereo = FALSE;
    d->signedness8 = FALSE;
    d->signedness16 = FALSE;

    new_device = gtk_combo_box_get_active_text(GTK_COMBO_BOX(d->alsa_device));
    if(g_ascii_strcasecmp(d->device, new_device)) {
	g_free(d->device);
	d->device = g_strdup(new_device);
	gui_hlp_combo_box_prepend_text_or_set_active(GTK_COMBO_BOX(d->alsa_device), d->device, FALSE);
    }

    for(i = 0; i < NUM_FORMATS; i++){
	d->devcap[i].minfreq = 8000;
	d->devcap[i].maxfreq = 44100;
	d->devcap[i].minbufsize = 256;
    }
    d->devcap[MONO8].maxbufsize = 65536;
    d->devcap[STEREO8].maxbufsize = 32768;
    d->devcap[MONO16].maxbufsize = 32768;
    d->devcap[STEREO16].maxbufsize = 16384;

    if(pcm_open_and_load_hwparams(d) < 0)
	return;

    if(!snd_pcm_hw_params_test_format(d->soundfd, d->hwparams, SND_PCM_FORMAT_U8)) {
	d->can8 = TRUE;
    }
    if(!snd_pcm_hw_params_test_format(d->soundfd, d->hwparams, SND_PCM_FORMAT_S8)) {
	d->can8 = TRUE;
	d->signedness8 = TRUE;
    }
    if(!snd_pcm_hw_params_test_format(d->soundfd, d->hwparams, SND_PCM_FORMAT_U16)) {
	d->can16 = TRUE;
    }
    if(!snd_pcm_hw_params_test_format(d->soundfd, d->hwparams, SND_PCM_FORMAT_S16)) {
	d->can16 = TRUE;
	d->signedness16 = TRUE;
    }

    if((err = snd_pcm_hw_params_get_channels_min(d->hwparams, &chmin)) < 0) {
	alsa_error(N_("Unable to get minimal channels number"), err);
	snd_pcm_close(d->soundfd);
	return;
    }
    if((err = snd_pcm_hw_params_get_channels_max(d->hwparams, &chmax)) < 0) {
	alsa_error(N_("Unable to get maximal channels number"), err);
	snd_pcm_close(d->soundfd);
	return;
    }
    if(chmin > 2) {
	error_error("Both mono and stereo are not supported by ALSA device!!!");
	snd_pcm_close(d->soundfd);
	return;
    }
    if(chmin == 1)
	d->canmono = TRUE;
    if(chmax >= 2)
	d->canstereo = TRUE;

    if(d->can8) {
	if((err = snd_pcm_hw_params_set_format(d->soundfd, d->hwparams,
					d->signedness8 ? SND_PCM_FORMAT_S8 : SND_PCM_FORMAT_U8)) < 0) {
	    alsa_error(N_("Unable to set audio format"), err);
	    snd_pcm_close(d->soundfd);
	    return;
	}
	if(d->canmono) {
	    if(set_rates(d, 1, MONO8) < 0) {
		snd_pcm_close(d->soundfd);
		return;
	    }
	}

	if(d->canstereo) {
	    snd_pcm_close(d->soundfd);
	    if(pcm_open_and_load_hwparams(d) < 0)
		return;
	    if(set_rates(d, 2, STEREO8) < 0) {
		snd_pcm_close(d->soundfd);
		return;
	    }
	}
    }

    if(d->can16) {
	snd_pcm_close(d->soundfd);
	if(pcm_open_and_load_hwparams(d) < 0)
	    return;
	if((err = snd_pcm_hw_params_set_format(d->soundfd, d->hwparams,
					d->signedness16 ? SND_PCM_FORMAT_S16 : SND_PCM_FORMAT_U16)) < 0) {
	    alsa_error(N_("Unable to set audio format"), err);
	    snd_pcm_close(d->soundfd);
	    return;
	}
	if(d->canmono) {
	    if(set_rates(d, 1, MONO16) < 0) {
		snd_pcm_close(d->soundfd);
		return;
	    }
	}
	if(d->canstereo) {
	    snd_pcm_close(d->soundfd);
	    if(pcm_open_and_load_hwparams(d) < 0)
		return;
	    if(set_rates(d, 2, STEREO16) < 0) {
		snd_pcm_close(d->soundfd);
		return;
	    }
	}
    }

    snd_pcm_close(d->soundfd);
    update_controls(d);
}

static void
prefs_channels_changed (GtkWidget *w, alsa_driver *d)
{
    gint curr;
    
    if((curr = find_current_toggle(d->prefs_channels_w,
				   sizeof(d->prefs_channels_w) / sizeof(d->prefs_channels_w[0]))) < 0)
	return;
    d->stereo = curr;

    if(d->hwtest) {
        update_freqs_list(d, TRUE);
	update_bufsize_range(d);
        set_highest_freq(d);
	set_max_spin(d->bufsizespin);
	check_period_sizes(d);
    }
}

static void
prefs_resolution_changed (GtkWidget *w, alsa_driver *d)
{
    gint curr;
    
    if((curr = find_current_toggle(d->prefs_resolution_w,
				   sizeof(d->prefs_resolution_w) / sizeof(d->prefs_resolution_w[0]))) < 0)
	return;
    d->bits = (curr + 1) * 8;

    if(d->hwtest) {
        update_freqs_list(d, TRUE);
	update_bufsize_range(d);
        set_highest_freq(d);
	set_max_spin(d->bufsizespin);
	check_period_sizes(d);
    }
}

static void
prefs_mixfreq_changed (GtkWidget *w, alsa_driver *d)
{
    GtkTreeIter iter;

    if(!gtk_combo_box_get_active_iter(GTK_COMBO_BOX(d->prefs_mixfreq), &iter))
	return;
    gtk_tree_model_get(d->model, &iter, 0, &d->playrate, -1);
    update_estimate(d);
}

static void
prefs_bufsize_changed (GtkWidget *w, alsa_driver *d)
{
    gchar *expression;

    d->buffer_size = gtk_spin_button_get_value_as_int(GTK_SPIN_BUTTON(d->bufsizespin));

    expression = g_strdup_printf(_(" = %u samples"), 1 << d->buffer_size);
    gtk_label_set_text(GTK_LABEL(d->bufsizelabel), expression);
    g_free(expression);

    if(d->hwtest)
        check_period_sizes(d);
}

static void
prefs_periods_changed (GtkWidget *w, alsa_driver *d)
{
    gchar *expression;

    d->num_periods = gtk_spin_button_get_value_as_int(GTK_SPIN_BUTTON(d->periodspin));

    expression = g_strdup_printf(_(" = %u"), 1 << d->num_periods);
    gtk_label_set_text(GTK_LABEL(d->periodlabel), expression);
    g_free(expression);

    update_estimate(d);
}

static void
prefs_init_from_structure (alsa_driver *d)
{
    d->hwtest = FALSE;
    gui_hlp_combo_box_prepend_text_or_set_active(GTK_COMBO_BOX(d->alsa_device), d->device, TRUE);
    update_controls_a(d);
    d->hwtest = TRUE;
}

static void
alsa_make_config_widgets (alsa_driver *d)
{
    GtkWidget *thing, *mainbox, *box2;
    GtkListStore *ls;
    GtkCellRenderer *cell;

    static const char *resolutionlabels[] = { "8 bits", "16 bits", NULL };
    static const char *channelslabels[] = { "Mono", "Stereo", NULL };

    d->configwidget = mainbox = gtk_vbox_new(FALSE, 2);

    thing = gtk_label_new(_("These changes won't take effect until you restart playing."));
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(mainbox), thing, FALSE, TRUE, 0);
    
    thing = gtk_hseparator_new();
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(mainbox), thing, FALSE, TRUE, 0);

    box2 = gtk_hbox_new(FALSE, 4);
    gtk_widget_show(box2);
    gtk_box_pack_start(GTK_BOX(mainbox), box2, FALSE, TRUE, 0);

    thing = gtk_label_new(_("Device:"));
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    thing = gtk_button_new_with_label("Test");
    gtk_widget_show(thing);
    gtk_box_pack_end(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    g_signal_connect(thing, "clicked",
		     G_CALLBACK(device_test), d);
    d->alsa_device = gtk_combo_box_entry_new_text();
    gtk_widget_show(d->alsa_device);
    gtk_box_pack_end(GTK_BOX(box2), d->alsa_device, FALSE, TRUE, 0);

    box2 = gtk_hbox_new(FALSE, 4);
    gtk_widget_show(box2);
    gtk_box_pack_start(GTK_BOX(mainbox), box2, FALSE, TRUE, 0);

    thing = gtk_label_new(_("Resolution:"));
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    add_empty_hbox(box2);
    make_radio_group_full(resolutionlabels, box2, d->prefs_resolution_w, FALSE, TRUE, (void(*)())prefs_resolution_changed, d);

    box2 = gtk_hbox_new(FALSE, 4);
    gtk_widget_show(box2);
    gtk_box_pack_start(GTK_BOX(mainbox), box2, FALSE, TRUE, 0);

    thing = gtk_label_new(_("Channels:"));
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    add_empty_hbox(box2);
    make_radio_group_full(channelslabels, box2, d->prefs_channels_w, FALSE, TRUE, (void(*)())prefs_channels_changed, d);

    box2 = gtk_hbox_new(FALSE, 4);
    gtk_widget_show(box2);
    gtk_box_pack_start(GTK_BOX(mainbox), box2, FALSE, TRUE, 0);

    thing = gtk_label_new(_("Frequency [Hz]:"));
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    ls = gtk_list_store_new(1, G_TYPE_UINT);
    d->model = GTK_TREE_MODEL(ls);
    thing = d->prefs_mixfreq = gtk_combo_box_new_with_model(GTK_TREE_MODEL(ls));
    g_object_unref(ls);
    cell = gtk_cell_renderer_text_new();
    gtk_cell_layout_pack_start(GTK_CELL_LAYOUT(thing), cell, TRUE);
    gtk_cell_layout_set_attributes(GTK_CELL_LAYOUT(thing), cell, "text", 0, NULL);
    gtk_box_pack_end(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    gtk_widget_show(thing);
    g_signal_connect(thing, "changed",
		     G_CALLBACK(prefs_mixfreq_changed), d);

    box2 = gtk_hbox_new(FALSE, 4);
    gtk_widget_show(box2);
    gtk_box_pack_start(GTK_BOX(mainbox), box2, FALSE, TRUE, 0);

    thing = gtk_label_new(_("Buffer Size:"));
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    add_empty_hbox(box2);

    thing = gtk_label_new("2^");
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);

    d->bufsizespin = thing = gtk_spin_button_new_with_range(8.0, 16.0, 1.0);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    gtk_widget_show(thing);
    g_signal_connect(thing, "value-changed",
			G_CALLBACK(prefs_bufsize_changed), d);

    d->bufsizelabel = thing = gtk_label_new(" = ");
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    gtk_widget_show(thing);

    box2 = gtk_hbox_new(FALSE, 4);
    gtk_widget_show(box2);
    gtk_box_pack_start(GTK_BOX(mainbox), box2, FALSE, TRUE, 0);

    thing = gtk_label_new(_("Number of Periods:"));
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    add_empty_hbox(box2);

    thing = gtk_label_new("2^");
    gtk_widget_show(thing);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);

    d->periodspin = thing = gtk_spin_button_new_with_range(1.0, 4.0, 1.0);
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    gtk_widget_show(thing);
    g_signal_connect(thing, "value-changed",
			G_CALLBACK(prefs_periods_changed), d);

    d->periodlabel = thing = gtk_label_new(" = ");
    gtk_box_pack_start(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    gtk_widget_show(thing);

    box2 = gtk_hbox_new(FALSE, 4);
    gtk_widget_show(box2);
    gtk_box_pack_start(GTK_BOX(mainbox), box2, FALSE, TRUE, 0);

    d->estimatelabel = thing = gtk_label_new("");
    gtk_box_pack_end(GTK_BOX(box2), thing, FALSE, TRUE, 0);
    gtk_widget_show(thing);
}

static GtkWidget *
alsa_getwidget (void *dp)
{
    alsa_driver * const d = dp;

    prefs_init_from_structure(d);

    return d->configwidget;
}

static void
alsa_poll_ready_playing (gpointer data,
			gint source,
			GdkInputCondition condition)
{
    alsa_driver * const d = data;
    snd_pcm_sframes_t w;
    struct timeval tv;

    if(!d->firstpoll) {
        w = snd_pcm_writei(d->soundfd, d->sndbuf, d->p_fragsize);
	if(d->verbose)
	    g_print("Written: %li from %li samples\n", w, d->p_fragsize);
        if(w != d->p_fragsize) {
	    if(w < 0) {
		fprintf(stderr, "driver_alsa2: write() returned -1.\n--- \"%s\"\n", snd_strerror(w));
	    } else {
		fprintf(stderr, "driver_alsa2: write not completely done.\n");
	    }
	}
    
	gettimeofday(&tv, NULL);
	d->outtime = tv.tv_sec + tv.tv_usec / 1e6;
        d->playtime += (double) d->p_fragsize / d->p_mixfreq;//!!!
    }

    d->firstpoll = FALSE;

    audio_mix(d->sndbuf, d->p_fragsize, d->p_mixfreq, d->mf);
}

static void *
alsa_new (void)
{
    guint i;
    gint err;
    alsa_driver *d = g_new(alsa_driver, 1);

    d->device = g_strdup("hw:0,0");
    d->bits = 8;
    d->stereo = 0;
    d->buffer_size = 14;
    d->playrate = 44100;
    d->minfreq_old = 0;
    d->maxfreq_old = 0;
    d->address_old = 0;
    d->bufsize_old = 0;
    d->num_periods = 1;
    d->can8 = TRUE;
    d->can16 = TRUE;
    d->canmono = TRUE;
    d->canstereo = TRUE;
    d->signedness8 = FALSE;
    d->signedness16 = TRUE;
    d->persizemin = 256;
    d->persizemax = 8192;

    for(i = 0; i < NUM_FORMATS; i++) {
	d->devcap[i].minfreq = 22050;
	d->devcap[i].maxfreq = 44100;
	d->devcap[i].minbufsize = 512;
	d->devcap[i].maxbufsize = 16384;
    }

    d->soundfd = 0;
    d->sndbuf = NULL;
    d->polltag = NULL;
    d->pfd = NULL;

    d->verbose = FALSE;
    d->hwtest = TRUE;

    if((err = snd_output_stdio_attach(&(d->output), stdout,0)) < 0) {
	alsa_error(N_("Error attaching sound output"), err);
	return NULL;
    }

    snd_pcm_hw_params_malloc(&(d->hwparams));
    snd_pcm_sw_params_malloc(&(d->swparams));
    alsa_make_config_widgets(d);

    return d;
}

static void
alsa_destroy (void *dp)
{
    alsa_driver * const d = dp;

    gtk_widget_destroy(d->configwidget);

    g_free(dp);
}

static void
alsa_release (void *dp)
{
    alsa_driver * const d = dp;

    if(d->sndbuf) {
        free(d->sndbuf);
	d->sndbuf = NULL;
    }

    audio_poll_remove(d->polltag);
    d->polltag = NULL;
    if(d->pfd) {
        free(d->pfd);
	d->pfd = NULL;
    }

    if(d->soundfd != 0) {
      snd_pcm_drop(d->soundfd);
      snd_pcm_close(d->soundfd);
      d->soundfd = 0;
    }
}

static gboolean
alsa_open (void *dp)
{
    alsa_driver * const d = dp;
    gint mf, err, pers;

    if(pcm_open_and_load_hwparams(d) < 0)
	goto out;

    // ---
    // Set non-blocking mode.
    // ---

    d->outtime = 0;

    // --
    // Set channel parameters
    // --
    if((err = snd_pcm_hw_params_set_access(d->soundfd, d->hwparams, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0){
	alsa_error(N_("Unable to set access"), err);
	goto out;
    }

    if((err = snd_pcm_hw_params_set_format(d->soundfd, d->hwparams,
				    (d->bits - 8) ? d->signedness16 ? SND_PCM_FORMAT_S16 : SND_PCM_FORMAT_U16 :
						    d->signedness8 ? SND_PCM_FORMAT_S8 : SND_PCM_FORMAT_U8) < 0)) {
	alsa_error(N_("Unable to set audio format"), err);
	goto out;
    }
    /* Handle endianess aspects. TODO! */
    switch(d->bits) {
	case 16:
	    mf = d->signedness16 ? ST_MIXER_FORMAT_S16_LE : ST_MIXER_FORMAT_U16_LE;
	    break;
	case 8:
	default:
	    mf = d->signedness8 ? ST_MIXER_FORMAT_S8 : ST_MIXER_FORMAT_U8;
	    break;
    }

    if((err = snd_pcm_hw_params_set_channels(d->soundfd, d->hwparams, d->stereo + 1)) < 0) {
	alsa_error(N_("Unable to set channels number"), err);
	goto out;
    }
    if((d->stereo)) {
	mf |= ST_MIXER_FORMAT_STEREO;
    }
    d->mf = mf;

    d->p_mixfreq = d->playrate;
    if ((err = snd_pcm_hw_params_set_rate_near(d->soundfd, d->hwparams, &(d->p_mixfreq), NULL)) < 0) {
	alsa_error(N_("Unable to set sample rate"), err);
	goto out;
    }

    if(snd_pcm_hw_params_set_buffer_size(d->soundfd, d->hwparams, 1 << d->buffer_size) < 0) {
	/* Some soundcards report wrong maximal buffer size (maybe alsa bug). So we should try
	   to downscale its value before the reporting an error. The spinbutton still may display
	   the wrong number, but actually the correct value will be implemented.*/
	while((--d->buffer_size) >= 8)
	    if(!snd_pcm_hw_params_set_buffer_size(d->soundfd, d->hwparams, 1 << d->buffer_size))
		break;
	if(d->buffer_size < 8) {
	    error_error(N_("Unable to set appropriate buffer size"));
	    goto out;
	}
    }
    pers = 1 << d->num_periods;
    if ((err = snd_pcm_hw_params_set_periods_near(d->soundfd, d->hwparams, &pers, NULL)) < 0) {
	alsa_error(N_("Unable to set periods number"), err);
	goto out;
    }
    if ((err = snd_pcm_hw_params_get_period_size(d->hwparams, &(d->p_fragsize), NULL)) < 0) {
	alsa_error(N_("Unable to get period size"), err);
	goto out;
    }

    if((err = snd_pcm_hw_params(d->soundfd, d->hwparams))) {
	alsa_error(N_("Error setting hw parameters"), err);
	goto out;
    }

    /* The following piece of code is directly c_n_p'ed from the ALSA pcm example (whith a little adopting) */
    /* get the current swparams */
    err = snd_pcm_sw_params_current(d->soundfd, d->swparams);
    if (err < 0) {
            alsa_error(N_("Unable to determine current swparams for playback"), err);
	    goto out;
    }
    /* start the transfer when the buffer is full */
    err = snd_pcm_sw_params_set_start_threshold(d->soundfd, d->swparams, d->p_fragsize);
    if (err < 0) {
            alsa_error(N_("Unable to set start threshold mode for playback"), err);
	    goto out;
    }
    /* allow the transfer when at least period_size samples can be processed */
    err = snd_pcm_sw_params_set_avail_min(d->soundfd, d->swparams, d->p_fragsize);
    if (err < 0) {
            alsa_error(N_("Unable to set avail min for playback"), err);
	    goto out;
    }
    /* align all transfers to 1 sample */
    err = snd_pcm_sw_params_set_xfer_align(d->soundfd, d->swparams, 1);
    if (err < 0) {
            alsa_error(N_("Unable to set transfer align for playback"), err);
	    goto out;
    }
    /* write the parameters to the playback device */
    err = snd_pcm_sw_params(d->soundfd, d->swparams);
    if (err < 0) {
            alsa_error(N_("Unable to set sw params for playback"), err);
	    goto out;
    }

    err = snd_pcm_prepare(d->soundfd);
    if (err < 0) {
            alsa_error(N_("Unable to prepare playback"), err);
	    goto out;
    }
    // ---
    // Get buffering parameters
    // ---
   
    if(d->verbose)
        snd_pcm_dump(d->soundfd, d->output);
    d->sndbuf = calloc((d->stereo + 1) * (d->bits / 8), d->p_fragsize);

    d->pfd = malloc(sizeof(struct pollfd));
    if ((err = snd_pcm_poll_descriptors(d->soundfd, d->pfd, 1)) < 0) {
        alsa_error(N_("Unable to obtain poll descriptors for playback"), err);
        goto out;
    }

    d->polltag = audio_poll_add(d->pfd->fd, GDK_INPUT_WRITE, alsa_poll_ready_playing, d);

    d->playtime = 0;
    d->firstpoll = TRUE;

    return TRUE;

  out:
    alsa_release(dp);
    return FALSE;
}

static double
alsa_get_play_time (void *dp)
{
    alsa_driver * const d = dp;
    struct timeval tv;
    double curtime;

    //    snd_pcm_channel_status_t status;
    //    snd_pcm_channel_status(d->soundfd, &status);
    //    curtime = status.stime.tv_sec + status.stime.tv_usec / 1e6;

    gettimeofday(&tv, NULL);
    curtime = tv.tv_sec + tv.tv_usec / 1e6;

    return d->playtime + curtime - d->outtime - d->num_periods * ((double) d->p_fragsize / d->p_mixfreq);
    //!!! This has a lotsa problems!!!
}

static inline int
alsa_get_play_rate (void *d)
{
    alsa_driver * const dp = d;
    return (int)dp->playrate;
}


static gboolean
load_dev_func(gchar *devname, gpointer data)
{
    alsa_driver *d = (alsa_driver *)data;

    gui_hlp_combo_box_prepend_text_or_set_active(GTK_COMBO_BOX(d->alsa_device), devname, FALSE);
    g_free(devname);

    return FALSE;
}

static gboolean
alsa_loadsettings (void *dp,
		  prefs_node *f)
{
    alsa_driver * const d = dp;
    guint i;
    gchar buf[32];

    //!!! Port all preferences to gchar, gint, etc...
    if(prefs_get_string(f, "alsa1x-device", buf)) {
	g_free(d->device);
        d->device = g_strdup(buf);
    }

    prefs_get_int(f, "alsa1x-resolution", &d->bits);
    prefs_get_int(f, "alsa1x-stereo", &d->stereo);
    prefs_get_int(f, "alsa1x-playrate", &d->playrate);
    prefs_get_int(f, "alsa1x-buffer_size", &d->buffer_size);
    prefs_get_int(f, "alsa1x-num_periods", &d->num_periods);
    prefs_get_int(f, "alsa1x-can_8", &d->can8);
    prefs_get_int(f, "alsa1x-can_16", &d->can16);
    prefs_get_int(f, "alsa1x-can_mono", &d->canmono);
    prefs_get_int(f, "alsa1x-can_stereo", &d->canstereo);
    prefs_get_int(f, "alsa1x-signedness_8", &d->signedness8);
    prefs_get_int(f, "alsa1x-signedness_16", &d->signedness16);
    prefs_get_int(f, "alsa1x-period_size_min", (int *)&d->persizemin);
    prefs_get_int(f, "alsa1x-period_size_max", (int *)&d->persizemax);

    for(i = 0; i < NUM_FORMATS; i++) {
	g_sprintf(buf, "alsa1x-devcap[%u].minfreq", i);
	prefs_get_int(f, buf, &d->devcap[i].minfreq);
	g_sprintf(buf, "alsa1x-devcap[%u].maxfreq", i);
	prefs_get_int(f, buf, &d->devcap[i].maxfreq);
	g_sprintf(buf, "alsa1x-devcap[%u].minbufsize", i);
	prefs_get_int(f, buf, (int *)&d->devcap[i].minbufsize);
	g_sprintf(buf, "alsa1x-devcap[%u].maxbufsize", i);
	prefs_get_int(f, buf, (int *)&d->devcap[i].maxbufsize);
    }

    prefs_get_int(f, "alsa1x-verbose", (int *)&d->verbose);
    prefs_get_str_array(f, "alsa1x-device-list", load_dev_func, d);
    gtk_combo_box_set_active(GTK_COMBO_BOX(d->alsa_device), 0);

    prefs_init_from_structure(d);

    return TRUE;
}

typedef struct _svd_data {
    prefs_node *f;
    guint counter;
} svd_data;

static gboolean
save_dev_func (GtkTreeModel *model, GtkTreePath *path, GtkTreeIter *iter, gpointer data)
{
    svd_data *sdd = (svd_data *)data;
    gchar *item_str = NULL;

    if(sdd->counter++ >= 10)
	return TRUE;

    gtk_tree_model_get(model, iter, 0, &item_str, -1);
    if(!item_str)
	return TRUE; /* Aborting due to error */

    prefs_put_string(sdd->f, "alsa1x-device-list", item_str);
    g_free(item_str);
    return FALSE;
}

static gboolean
alsa_savesettings (void *dp,
		  prefs_node *f)
{
    alsa_driver * const d = dp;
    guint i;
    gchar buf[32];
    svd_data savedev_data;

    prefs_put_string(f, "alsa1x-device", d->device);

    prefs_put_int(f, "alsa1x-resolution", d->bits);
    prefs_put_int(f, "alsa1x-stereo", d->stereo);
    prefs_put_int(f, "alsa1x-playrate", d->playrate);
    prefs_put_int(f, "alsa1x-buffer_size", d->buffer_size);
    prefs_put_int(f, "alsa1x-num_periods", d->num_periods);
    prefs_put_int(f, "alsa1x-can_8", d->can8);
    prefs_put_int(f, "alsa1x-can_16", d->can16);
    prefs_put_int(f, "alsa1x-can_mono", d->canmono);
    prefs_put_int(f, "alsa1x-can_stereo", d->canstereo);
    prefs_put_int(f, "alsa1x-signedness_8", d->signedness8);
    prefs_put_int(f, "alsa1x-signedness_16", d->signedness16);
    prefs_put_int(f, "alsa1x-period_size_min", d->persizemin);
    prefs_put_int(f, "alsa1x-period_size_max", d->persizemax);

    for(i = 0; i < NUM_FORMATS; i++) {
	g_sprintf(buf, "alsa1x-devcap[%u].minfreq", i);
	prefs_put_int(f, buf, d->devcap[i].minfreq);
	g_sprintf(buf, "alsa1x-devcap[%u].maxfreq", i);
	prefs_put_int(f, buf, d->devcap[i].maxfreq);
	g_sprintf(buf, "alsa1x-devcap[%u].minbufsize", i);
	prefs_put_int(f, buf, d->devcap[i].minbufsize);
	g_sprintf(buf, "alsa1x-devcap[%u].maxbufsize", i);
	prefs_put_int(f, buf, d->devcap[i].maxbufsize);
    }

    prefs_put_int(f, "alsa1x-verbose", d->verbose);

    savedev_data.f = f;
    savedev_data.counter = 0;
    gtk_tree_model_foreach(gtk_combo_box_get_model(GTK_COMBO_BOX(d->alsa_device)), save_dev_func, &savedev_data);

    return TRUE;
}

st_io_driver driver_out_alsa1x = {
    { "ALSA-1.0.x Output",

      alsa_new,
      alsa_destroy,

      alsa_open,
      alsa_release,

      alsa_getwidget,
      alsa_loadsettings,
      alsa_savesettings,
    },

    alsa_get_play_time,
    alsa_get_play_rate
};

#endif /* DRIVER_ALSA */
