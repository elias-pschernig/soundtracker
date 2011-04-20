
/*
 * The Real SoundTracker - clock re-implementation (header)
 *
 * Copyright (C) 2006 Miroslav Shatlev, Yury Aliaev
 * !!!clarify from where this was taken
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

#ifndef _CLOCK_H
#define _CLOCK_H

#include <gtk/gtk.h>
#include <sys/time.h>


#define CLOCK_TYPE				(clock_get_type ())
#define CLOCK(obj)				(G_TYPE_CHECK_INSTANCE_CAST((obj), CLOCK_TYPE, Clock))

typedef struct _Clock Clock;
typedef struct _ClockClass ClockClass;

struct _Clock {
	GtkLabel widget;
	gint timer_id;
	gint update_interval;
	time_t seconds;
	time_t stopped;
	gchar *fmt;
	struct tm *tm;
};

struct _ClockClass {
	GtkLabelClass parent_class;
};

guint clock_get_type(void);
GtkWidget *clock_new(void);
void clock_set_format(Clock *clock, const gchar *fmt);
void clock_set_seconds(Clock *clock, time_t seconds);
void clock_start(Clock *clock);
void clock_stop(Clock *clock);

#endif /* _CLOCK_H */
