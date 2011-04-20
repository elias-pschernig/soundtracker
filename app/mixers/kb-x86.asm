
kb-x86.o:     file format elf32-i386

Disassembly of section .text:

00000000 <kb_x86_setnumch>:
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	50                   	push   %eax
       4:	50                   	push   %eax
       5:	8b 55 08             	mov    0x8(%ebp),%edx
       8:	8d 42 ff             	lea    0xffffffff(%edx),%eax
       b:	83 f8 1f             	cmp    $0x1f,%eax
       e:	77 08                	ja     18 <kb_x86_setnumch+0x18>
      10:	89 15 08 00 00 00    	mov    %edx,0x8
      16:	c9                   	leave  
      17:	c3                   	ret    
      18:	83 ec 0c             	sub    $0xc,%esp
      1b:	68 08 00 00 00       	push   $0x8
      20:	68 00 00 00 00       	push   $0x0
      25:	6a 68                	push   $0x68
      27:	68 1a 00 00 00       	push   $0x1a
      2c:	6a 00                	push   $0x0
      2e:	e8 fc ff ff ff       	call   2f <kb_x86_setnumch+0x2f>
      33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      39:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000040 <kb_x86_get_channel_struct>:
      40:	8d 14 40             	lea    (%eax,%eax,2),%edx
      43:	55                   	push   %ebp
      44:	c1 e2 05             	shl    $0x5,%edx
      47:	89 e5                	mov    %esp,%ebp
      49:	8d 82 20 00 00 00    	lea    0x20(%edx),%eax
      4f:	f6 40 10 10          	testb  $0x10,0x10(%eax)
      53:	74 06                	je     5b <kb_x86_get_channel_struct+0x1b>
      55:	8d 82 20 0c 00 00    	lea    0xc20(%edx),%eax
      5b:	5d                   	pop    %ebp
      5c:	c3                   	ret    
      5d:	8d 76 00             	lea    0x0(%esi),%esi

00000060 <kb_x86_updatesample>:
      60:	55                   	push   %ebp
      61:	31 d2                	xor    %edx,%edx
      63:	89 e5                	mov    %esp,%ebp
      65:	b9 3f 00 00 00       	mov    $0x3f,%ecx
      6a:	56                   	push   %esi
      6b:	53                   	push   %ebx
      6c:	8b 75 08             	mov    0x8(%ebp),%esi
      6f:	eb 06                	jmp    77 <kb_x86_updatesample+0x17>
      71:	83 c2 60             	add    $0x60,%edx
      74:	49                   	dec    %ecx
      75:	78 2d                	js     a4 <kb_x86_updatesample+0x44>
      77:	39 b2 20 00 00 00    	cmp    %esi,0x20(%edx)
      7d:	75 f2                	jne    71 <kb_x86_updatesample+0x11>
      7f:	8b 9a 30 00 00 00    	mov    0x30(%edx),%ebx
      85:	f6 c3 04             	test   $0x4,%bl
      88:	74 e7                	je     71 <kb_x86_updatesample+0x11>
      8a:	8b 46 10             	mov    0x10(%esi),%eax
      8d:	39 82 24 00 00 00    	cmp    %eax,0x24(%edx)
      93:	74 13                	je     a8 <kb_x86_updatesample+0x48>
      95:	83 e3 fb             	and    $0xfffffffb,%ebx
      98:	89 9a 30 00 00 00    	mov    %ebx,0x30(%edx)
      9e:	83 c2 60             	add    $0x60,%edx
      a1:	49                   	dec    %ecx
      a2:	79 d3                	jns    77 <kb_x86_updatesample+0x17>
      a4:	5b                   	pop    %ebx
      a5:	5e                   	pop    %esi
      a6:	5d                   	pop    %ebp
      a7:	c3                   	ret    
      a8:	8b 46 04             	mov    0x4(%esi),%eax
      ab:	39 82 2c 00 00 00    	cmp    %eax,0x2c(%edx)
      b1:	75 e2                	jne    95 <kb_x86_updatesample+0x35>
      b3:	8b 82 28 00 00 00    	mov    0x28(%edx),%eax
      b9:	3b 06                	cmp    (%esi),%eax
      bb:	75 d8                	jne    95 <kb_x86_updatesample+0x35>
      bd:	89 82 28 00 00 00    	mov    %eax,0x28(%edx)
      c3:	85 c0                	test   %eax,%eax
      c5:	74 aa                	je     71 <kb_x86_updatesample+0x11>
      c7:	8b 9a 60 00 00 00    	mov    0x60(%edx),%ebx
      cd:	8b 46 08             	mov    0x8(%esi),%eax
      d0:	39 c3                	cmp    %eax,%ebx
      d2:	72 08                	jb     dc <kb_x86_updatesample+0x7c>
      d4:	8b 46 0c             	mov    0xc(%esi),%eax
      d7:	39 c3                	cmp    %eax,%ebx
      d9:	72 96                	jb     71 <kb_x86_updatesample+0x11>
      db:	48                   	dec    %eax
      dc:	89 82 60 00 00 00    	mov    %eax,0x60(%edx)
      e2:	c7 82 64 00 00 00 ff 	movl   $0x7fffffff,0x64(%edx)
      e9:	ff ff 7f 
      ec:	eb 83                	jmp    71 <kb_x86_updatesample+0x11>
      ee:	89 f6                	mov    %esi,%esi

000000f0 <kb_x86_setmixformat>:
      f0:	55                   	push   %ebp
      f1:	89 e5                	mov    %esp,%ebp
      f3:	83 7d 08 10          	cmpl   $0x10,0x8(%ebp)
      f7:	0f 94 c0             	sete   %al
      fa:	25 ff 00 00 00       	and    $0xff,%eax
      ff:	5d                   	pop    %ebp
     100:	c3                   	ret    
     101:	eb 0d                	jmp    110 <kb_x86_setstereo>
     103:	90                   	nop    
     104:	90                   	nop    
     105:	90                   	nop    
     106:	90                   	nop    
     107:	90                   	nop    
     108:	90                   	nop    
     109:	90                   	nop    
     10a:	90                   	nop    
     10b:	90                   	nop    
     10c:	90                   	nop    
     10d:	90                   	nop    
     10e:	90                   	nop    
     10f:	90                   	nop    

00000110 <kb_x86_setstereo>:
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	8b 55 08             	mov    0x8(%ebp),%edx
     116:	5d                   	pop    %ebp
     117:	85 d2                	test   %edx,%edx
     119:	0f 95 c0             	setne  %al
     11c:	25 ff 00 00 00       	and    $0xff,%eax
     121:	c3                   	ret    
     122:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
     129:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000130 <kb_x86_setmixfreq>:
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	8b 45 08             	mov    0x8(%ebp),%eax
     136:	5d                   	pop    %ebp
     137:	25 ff ff 00 00       	and    $0xffff,%eax
     13c:	a3 0c 00 00 00       	mov    %eax,0xc
     141:	c3                   	ret    
     142:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000150 <kb_x86_setampfactor>:
     150:	55                   	push   %ebp
     151:	89 e5                	mov    %esp,%ebp
     153:	d9 05 00 00 00 00    	flds   0x0
     159:	d8 4d 08             	fmuls  0x8(%ebp)
     15c:	5d                   	pop    %ebp
     15d:	d9 1d 60 00 00 00    	fstps  0x60
     163:	c3                   	ret    
     164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <kb_x86_getclipflag>:
     170:	55                   	push   %ebp
     171:	a1 10 00 00 00       	mov    0x10,%eax
     176:	89 e5                	mov    %esp,%ebp
     178:	5d                   	pop    %ebp
     179:	c3                   	ret    
     17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000180 <kb_x86_reset>:
     180:	55                   	push   %ebp
     181:	89 e5                	mov    %esp,%ebp
     183:	83 ec 0c             	sub    $0xc,%esp
     186:	68 00 18 00 00       	push   $0x1800
     18b:	6a 00                	push   $0x0
     18d:	68 20 00 00 00       	push   $0x20
     192:	e8 fc ff ff ff       	call   193 <kb_x86_reset+0x13>
     197:	c7 05 10 00 00 00 00 	movl   $0x0,0x10
     19e:	00 00 00 
     1a1:	31 c0                	xor    %eax,%eax
     1a3:	83 c4 10             	add    $0x10,%esp
     1a6:	d9 05 04 00 00 00    	flds   0x4
     1ac:	d9 05 08 00 00 00    	flds   0x8
     1b2:	50                   	push   %eax
     1b3:	db 04 24             	fildl  (%esp)
     1b6:	dc 0d 00 00 00 00    	fmull  0x0
     1bc:	83 c4 04             	add    $0x4,%esp
     1bf:	d9 c2                	fld    %st(2)
     1c1:	d9 c9                	fxch   %st(1)
     1c3:	d9 5d fc             	fstps  0xfffffffc(%ebp)
     1c6:	d9 45 fc             	flds   0xfffffffc(%ebp)
     1c9:	d9 c0                	fld    %st(0)
     1cb:	d8 c9                	fmul   %st(1),%st
     1cd:	d9 ca                	fxch   %st(2)
     1cf:	d8 c9                	fmul   %st(1),%st
     1d1:	d9 c2                	fld    %st(2)
     1d3:	de ca                	fmulp  %st,%st(2)
     1d5:	d9 c2                	fld    %st(2)
     1d7:	d9 c0                	fld    %st(0)
     1d9:	d9 c3                	fld    %st(3)
     1db:	dc 0d 08 00 00 00    	fmull  0x8
     1e1:	d9 cd                	fxch   %st(5)
     1e3:	d8 c0                	fadd   %st(0),%st
     1e5:	d9 c9                	fxch   %st(1)
     1e7:	dc 0d 18 00 00 00    	fmull  0x18
     1ed:	d9 cd                	fxch   %st(5)
     1ef:	d8 c2                	fadd   %st(2),%st
     1f1:	d9 ca                	fxch   %st(2)
     1f3:	d8 cf                	fmul   %st(7),%st
     1f5:	d9 ca                	fxch   %st(2)
     1f7:	d8 e3                	fsub   %st(3),%st
     1f9:	d9 1c 85 00 00 00 00 	fstps  0x0(,%eax,4)
     200:	d9 c3                	fld    %st(3)
     202:	dc 0d 10 00 00 00    	fmull  0x10
     208:	de e5                	fsubp  %st,%st(5)
     20a:	d9 e8                	fld1   
     20c:	de c5                	faddp  %st,%st(5)
     20e:	d9 cc                	fxch   %st(4)
     210:	d9 1c 85 00 00 00 00 	fstps  0x0(,%eax,4)
     217:	d9 c2                	fld    %st(2)
     219:	d8 cd                	fmul   %st(5),%st
     21b:	d9 cb                	fxch   %st(3)
     21d:	d8 ce                	fmul   %st(6),%st
     21f:	d9 cb                	fxch   %st(3)
     221:	de c4                	faddp  %st,%st(4)
     223:	de ea                	fsubrp %st,%st(2)
     225:	de c2                	faddp  %st,%st(2)
     227:	d9 1c 85 00 00 00 00 	fstps  0x0(,%eax,4)
     22e:	d9 1c 85 00 00 00 00 	fstps  0x0(,%eax,4)
     235:	40                   	inc    %eax
     236:	3d ff 00 00 00       	cmp    $0xff,%eax
     23b:	0f 8e 71 ff ff ff    	jle    1b2 <kb_x86_reset+0x32>
     241:	dd d8                	fstp   %st(0)
     243:	dd d8                	fstp   %st(0)
     245:	c9                   	leave  
     246:	c3                   	ret    
     247:	89 f6                	mov    %esi,%esi
     249:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000250 <kb_x86_startnote>:
     250:	55                   	push   %ebp
     251:	89 e5                	mov    %esp,%ebp
     253:	56                   	push   %esi
     254:	53                   	push   %ebx
     255:	8b 45 08             	mov    0x8(%ebp),%eax
     258:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     25b:	e8 e0 fd ff ff       	call   40 <kb_x86_get_channel_struct>
     260:	89 c1                	mov    %eax,%ecx
     262:	8b 70 10             	mov    0x10(%eax),%esi
     265:	89 18                	mov    %ebx,(%eax)
     267:	83 e6 10             	and    $0x10,%esi
     26a:	89 70 10             	mov    %esi,0x10(%eax)
     26d:	8b 43 10             	mov    0x10(%ebx),%eax
     270:	89 41 04             	mov    %eax,0x4(%ecx)
     273:	8b 43 04             	mov    0x4(%ebx),%eax
     276:	89 41 0c             	mov    %eax,0xc(%ecx)
     279:	8b 03                	mov    (%ebx),%eax
     27b:	c7 41 40 00 00 00 00 	movl   $0x0,0x40(%ecx)
     282:	89 41 08             	mov    %eax,0x8(%ecx)
     285:	c7 41 44 00 00 00 00 	movl   $0x0,0x44(%ecx)
     28c:	c7 41 20 00 00 00 00 	movl   $0x0,0x20(%ecx)
     293:	8b 03                	mov    (%ebx),%eax
     295:	83 f8 01             	cmp    $0x1,%eax
     298:	74 36                	je     2d0 <kb_x86_startnote+0x80>
     29a:	83 f8 02             	cmp    $0x2,%eax
     29d:	74 36                	je     2d5 <kb_x86_startnote+0x85>
     29f:	ba 00 00 00 00       	mov    $0x0,%edx
     2a4:	83 ce 0c             	or     $0xc,%esi
     2a7:	b8 00 00 80 3f       	mov    $0x3f800000,%eax
     2ac:	c7 41 1c 01 00 00 00 	movl   $0x1,0x1c(%ecx)
     2b3:	c7 41 2c 00 00 00 00 	movl   $0x0,0x2c(%ecx)
     2ba:	89 51 54             	mov    %edx,0x54(%ecx)
     2bd:	89 41 50             	mov    %eax,0x50(%ecx)
     2c0:	89 51 58             	mov    %edx,0x58(%ecx)
     2c3:	89 51 5c             	mov    %edx,0x5c(%ecx)
     2c6:	89 71 10             	mov    %esi,0x10(%ecx)
     2c9:	5b                   	pop    %ebx
     2ca:	5e                   	pop    %esi
     2cb:	5d                   	pop    %ebp
     2cc:	c3                   	ret    
     2cd:	8d 76 00             	lea    0x0(%esi),%esi
     2d0:	83 ce 01             	or     $0x1,%esi
     2d3:	eb ca                	jmp    29f <kb_x86_startnote+0x4f>
     2d5:	83 ce 02             	or     $0x2,%esi
     2d8:	eb c5                	jmp    29f <kb_x86_startnote+0x4f>
     2da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002e0 <kb_x86_stopnote>:
     2e0:	55                   	push   %ebp
     2e1:	89 e5                	mov    %esp,%ebp
     2e3:	56                   	push   %esi
     2e4:	53                   	push   %ebx
     2e5:	83 ec 10             	sub    $0x10,%esp
     2e8:	8b 45 08             	mov    0x8(%ebp),%eax
     2eb:	8d 14 40             	lea    (%eax,%eax,2),%edx
     2ee:	c1 e2 05             	shl    $0x5,%edx
     2f1:	8d 9a 20 00 00 00    	lea    0x20(%edx),%ebx
     2f7:	e8 44 fd ff ff       	call   40 <kb_x86_get_channel_struct>
     2fc:	89 c1                	mov    %eax,%ecx
     2fe:	8b 40 10             	mov    0x10(%eax),%eax
     301:	a8 04                	test   $0x4,%al
     303:	74 73                	je     378 <kb_x86_stopnote+0x98>
     305:	39 d9                	cmp    %ebx,%ecx
     307:	74 7c                	je     385 <kb_x86_stopnote+0xa5>
     309:	8b 73 10             	mov    0x10(%ebx),%esi
     30c:	83 e6 ef             	and    $0xffffffef,%esi
     30f:	89 73 10             	mov    %esi,0x10(%ebx)
     312:	8b 59 10             	mov    0x10(%ecx),%ebx
     315:	83 cb 20             	or     $0x20,%ebx
     318:	89 59 10             	mov    %ebx,0x10(%ecx)
     31b:	d9 7d f6             	fnstcw 0xfffffff6(%ebp)
     31e:	db 05 0c 00 00 00    	fildl  0xc
     324:	dc 0d 20 00 00 00    	fmull  0x20
     32a:	66 8b 45 f6          	mov    0xfffffff6(%ebp),%ax
     32e:	b4 0c                	mov    $0xc,%ah
     330:	66 89 45 f4          	mov    %ax,0xfffffff4(%ebp)
     334:	d9 6d f4             	fldcw  0xfffffff4(%ebp)
     337:	df 7d e8             	fistpll 0xffffffe8(%ebp)
     33a:	d9 6d f6             	fldcw  0xfffffff6(%ebp)
     33d:	8b 5d e8             	mov    0xffffffe8(%ebp),%ebx
     340:	85 db                	test   %ebx,%ebx
     342:	75 3c                	jne    380 <kb_x86_stopnote+0xa0>
     344:	c7 41 2c 01 00 00 00 	movl   $0x1,0x2c(%ecx)
     34b:	d9 ee                	fldz   
     34d:	d9 c0                	fld    %st(0)
     34f:	8b 41 2c             	mov    0x2c(%ecx),%eax
     352:	31 d2                	xor    %edx,%edx
     354:	d9 51 38             	fsts   0x38(%ecx)
     357:	d9 51 3c             	fsts   0x3c(%ecx)
     35a:	d9 c9                	fxch   %st(1)
     35c:	d8 61 24             	fsubs  0x24(%ecx)
     35f:	d9 c9                	fxch   %st(1)
     361:	52                   	push   %edx
     362:	50                   	push   %eax
     363:	d8 61 28             	fsubs  0x28(%ecx)
     366:	df 2c 24             	fildll (%esp)
     369:	dc fa                	fdivr  %st,%st(2)
     36b:	83 c4 08             	add    $0x8,%esp
     36e:	de f9                	fdivrp %st,%st(1)
     370:	d9 c9                	fxch   %st(1)
     372:	d9 59 30             	fstps  0x30(%ecx)
     375:	d9 59 34             	fstps  0x34(%ecx)
     378:	83 c4 10             	add    $0x10,%esp
     37b:	5b                   	pop    %ebx
     37c:	5e                   	pop    %esi
     37d:	5d                   	pop    %ebp
     37e:	c3                   	ret    
     37f:	90                   	nop    
     380:	89 59 2c             	mov    %ebx,0x2c(%ecx)
     383:	eb c6                	jmp    34b <kb_x86_stopnote+0x6b>
     385:	83 c8 10             	or     $0x10,%eax
     388:	89 41 10             	mov    %eax,0x10(%ecx)
     38b:	eb 85                	jmp    312 <kb_x86_stopnote+0x32>
     38d:	8d 76 00             	lea    0x0(%esi),%esi

00000390 <kb_x86_setsmplpos>:
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	56                   	push   %esi
     394:	53                   	push   %ebx
     395:	8b 45 08             	mov    0x8(%ebp),%eax
     398:	8b 75 0c             	mov    0xc(%ebp),%esi
     39b:	e8 a0 fc ff ff       	call   40 <kb_x86_get_channel_struct>
     3a0:	89 c1                	mov    %eax,%ecx
     3a2:	8b 00                	mov    (%eax),%eax
     3a4:	85 c0                	test   %eax,%eax
     3a6:	74 38                	je     3e0 <kb_x86_setsmplpos+0x50>
     3a8:	8b 59 10             	mov    0x10(%ecx),%ebx
     3ab:	85 db                	test   %ebx,%ebx
     3ad:	74 31                	je     3e0 <kb_x86_setsmplpos+0x50>
     3af:	39 70 04             	cmp    %esi,0x4(%eax)
     3b2:	76 30                	jbe    3e4 <kb_x86_setsmplpos+0x54>
     3b4:	89 da                	mov    %ebx,%edx
     3b6:	89 71 40             	mov    %esi,0x40(%ecx)
     3b9:	c1 ea 03             	shr    $0x3,%edx
     3bc:	85 f6                	test   %esi,%esi
     3be:	0f 95 c0             	setne  %al
     3c1:	25 ff 00 00 00       	and    $0xff,%eax
     3c6:	c7 41 44 00 00 00 00 	movl   $0x0,0x44(%ecx)
     3cd:	c7 41 1c 01 00 00 00 	movl   $0x1,0x1c(%ecx)
     3d4:	85 d0                	test   %edx,%eax
     3d6:	74 08                	je     3e0 <kb_x86_setsmplpos+0x50>
     3d8:	83 cb 40             	or     $0x40,%ebx
     3db:	89 59 10             	mov    %ebx,0x10(%ecx)
     3de:	89 f6                	mov    %esi,%esi
     3e0:	5b                   	pop    %ebx
     3e1:	5e                   	pop    %esi
     3e2:	5d                   	pop    %ebp
     3e3:	c3                   	ret    
     3e4:	83 e3 10             	and    $0x10,%ebx
     3e7:	89 59 10             	mov    %ebx,0x10(%ecx)
     3ea:	eb f4                	jmp    3e0 <kb_x86_setsmplpos+0x50>
     3ec:	8d 74 26 00          	lea    0x0(%esi),%esi

000003f0 <kb_x86_setsmplend>:
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	53                   	push   %ebx
     3f4:	8b 45 08             	mov    0x8(%ebp),%eax
     3f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     3fa:	e8 41 fc ff ff       	call   40 <kb_x86_get_channel_struct>
     3ff:	8b 10                	mov    (%eax),%edx
     401:	85 d2                	test   %edx,%edx
     403:	74 1b                	je     420 <kb_x86_setsmplend+0x30>
     405:	8b 48 10             	mov    0x10(%eax),%ecx
     408:	85 c9                	test   %ecx,%ecx
     40a:	74 14                	je     420 <kb_x86_setsmplend+0x30>
     40c:	8b 48 40             	mov    0x40(%eax),%ecx
     40f:	85 c9                	test   %ecx,%ecx
     411:	75 05                	jne    418 <kb_x86_setsmplend+0x28>
     413:	39 5a 04             	cmp    %ebx,0x4(%edx)
     416:	76 08                	jbe    420 <kb_x86_setsmplend+0x30>
     418:	89 58 20             	mov    %ebx,0x20(%eax)
     41b:	90                   	nop    
     41c:	8d 74 26 00          	lea    0x0(%esi),%esi
     420:	5b                   	pop    %ebx
     421:	5d                   	pop    %ebp
     422:	c3                   	ret    
     423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     429:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000430 <kb_x86_setfreq>:
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	83 ec 38             	sub    $0x38,%esp
     436:	d9 45 0c             	flds   0xc(%ebp)
     439:	8b 45 08             	mov    0x8(%ebp),%eax
     43c:	d9 5d c8             	fstps  0xffffffc8(%ebp)
     43f:	e8 fc fb ff ff       	call   40 <kb_x86_get_channel_struct>
     444:	db 05 0c 00 00 00    	fildl  0xc
     44a:	d9 45 c8             	flds   0xffffffc8(%ebp)
     44d:	de f1                	fdivp  %st,%st(1)
     44f:	d9 7d f6             	fnstcw 0xfffffff6(%ebp)
     452:	66 8b 55 f6          	mov    0xfffffff6(%ebp),%dx
     456:	80 e6 f3             	and    $0xf3,%dh
     459:	80 ce 04             	or     $0x4,%dh
     45c:	66 89 55 f4          	mov    %dx,0xfffffff4(%ebp)
     460:	d9 6d f4             	fldcw  0xfffffff4(%ebp)
     463:	d9 c0                	fld    %st(0)
     465:	d9 fc                	frndint 
     467:	d9 6d f6             	fldcw  0xfffffff6(%ebp)
     46a:	d9 5d f0             	fstps  0xfffffff0(%ebp)
     46d:	d9 7d ee             	fnstcw 0xffffffee(%ebp)
     470:	66 8b 55 ee          	mov    0xffffffee(%ebp),%dx
     474:	31 c9                	xor    %ecx,%ecx
     476:	d9 45 f0             	flds   0xfffffff0(%ebp)
     479:	b6 0c                	mov    $0xc,%dh
     47b:	66 89 55 ec          	mov    %dx,0xffffffec(%ebp)
     47f:	d9 6d ec             	fldcw  0xffffffec(%ebp)
     482:	df 7d e0             	fistpll 0xffffffe0(%ebp)
     485:	d9 6d ee             	fldcw  0xffffffee(%ebp)
     488:	8b 55 e0             	mov    0xffffffe0(%ebp),%edx
     48b:	89 50 48             	mov    %edx,0x48(%eax)
     48e:	8b 50 48             	mov    0x48(%eax),%edx
     491:	51                   	push   %ecx
     492:	52                   	push   %edx
     493:	df 2c 24             	fildll (%esp)
     496:	de e9                	fsubrp %st,%st(1)
     498:	83 c4 08             	add    $0x8,%esp
     49b:	d9 05 0c 00 00 00    	flds   0xc
     4a1:	de c9                	fmulp  %st,%st(1)
     4a3:	d9 6d ec             	fldcw  0xffffffec(%ebp)
     4a6:	df 7d e0             	fistpll 0xffffffe0(%ebp)
     4a9:	d9 6d ee             	fldcw  0xffffffee(%ebp)
     4ac:	8b 55 e0             	mov    0xffffffe0(%ebp),%edx
     4af:	89 50 4c             	mov    %edx,0x4c(%eax)
     4b2:	c9                   	leave  
     4b3:	c3                   	ret    
     4b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     4ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004c0 <kb_x86_redo_vol_fields>:
     4c0:	55                   	push   %ebp
     4c1:	89 c1                	mov    %eax,%ecx
     4c3:	89 e5                	mov    %esp,%ebp
     4c5:	56                   	push   %esi
     4c6:	53                   	push   %ebx
     4c7:	83 ec 10             	sub    $0x10,%esp
     4ca:	d9 40 18             	flds   0x18(%eax)
     4cd:	d9 e8                	fld1   
     4cf:	d8 e1                	fsub   %st(1),%st
     4d1:	d9 40 14             	flds   0x14(%eax)
     4d4:	dc c9                	fmul   %st,%st(1)
     4d6:	de ca                	fmulp  %st,%st(2)
     4d8:	d9 ee                	fldz   
     4da:	d9 c9                	fxch   %st(1)
     4dc:	d9 5d f4             	fstps  0xfffffff4(%ebp)
     4df:	d9 45 f4             	flds   0xfffffff4(%ebp)
     4e2:	d9 ca                	fxch   %st(2)
     4e4:	d9 50 3c             	fsts   0x3c(%eax)
     4e7:	d9 ca                	fxch   %st(2)
     4e9:	d9 50 38             	fsts   0x38(%eax)
     4ec:	dd e1                	fucom  %st(1)
     4ee:	df e0                	fnstsw %ax
     4f0:	f6 c4 01             	test   $0x1,%ah
     4f3:	75 0b                	jne    500 <kb_x86_redo_vol_fields+0x40>
     4f5:	d9 e8                	fld1   
     4f7:	dd e9                	fucomp %st(1)
     4f9:	df e0                	fnstsw %ax
     4fb:	f6 c4 05             	test   $0x5,%ah
     4fe:	74 24                	je     524 <kb_x86_redo_vol_fields+0x64>
     500:	dd d8                	fstp   %st(0)
     502:	dd d8                	fstp   %st(0)
     504:	dd d8                	fstp   %st(0)
     506:	83 ec 0c             	sub    $0xc,%esp
     509:	68 54 00 00 00       	push   $0x54
     50e:	68 10 00 00 00       	push   $0x10
     513:	68 57 01 00 00       	push   $0x157
     518:	68 1a 00 00 00       	push   $0x1a
     51d:	6a 00                	push   $0x0
     51f:	e8 fc ff ff ff       	call   520 <kb_x86_redo_vol_fields+0x60>
     524:	d9 ca                	fxch   %st(2)
     526:	dd e1                	fucom  %st(1)
     528:	df e0                	fnstsw %ax
     52a:	dd d9                	fstp   %st(1)
     52c:	f6 c4 01             	test   $0x1,%ah
     52f:	75 0b                	jne    53c <kb_x86_redo_vol_fields+0x7c>
     531:	d9 e8                	fld1   
     533:	dd e9                	fucomp %st(1)
     535:	df e0                	fnstsw %ax
     537:	f6 c4 05             	test   $0x5,%ah
     53a:	74 18                	je     554 <kb_x86_redo_vol_fields+0x94>
     53c:	dd d8                	fstp   %st(0)
     53e:	dd d8                	fstp   %st(0)
     540:	83 ec 0c             	sub    $0xc,%esp
     543:	68 88 00 00 00       	push   $0x88
     548:	68 10 00 00 00       	push   $0x10
     54d:	68 58 01 00 00       	push   $0x158
     552:	eb c4                	jmp    518 <kb_x86_redo_vol_fields+0x58>
     554:	f6 41 10 08          	testb  $0x8,0x10(%ecx)
     558:	74 0f                	je     569 <kb_x86_redo_vol_fields+0xa9>
     55a:	d9 c9                	fxch   %st(1)
     55c:	d9 59 24             	fstps  0x24(%ecx)
     55f:	d9 59 28             	fstps  0x28(%ecx)
     562:	8d 65 f8             	lea    0xfffffff8(%ebp),%esp
     565:	5b                   	pop    %ebx
     566:	5e                   	pop    %esi
     567:	5d                   	pop    %ebp
     568:	c3                   	ret    
     569:	db 05 0c 00 00 00    	fildl  0xc
     56f:	d9 7d f2             	fnstcw 0xfffffff2(%ebp)
     572:	dc 0d 28 00 00 00    	fmull  0x28
     578:	66 8b 45 f2          	mov    0xfffffff2(%ebp),%ax
     57c:	b4 0c                	mov    $0xc,%ah
     57e:	66 89 45 f0          	mov    %ax,0xfffffff0(%ebp)
     582:	d9 6d f0             	fldcw  0xfffffff0(%ebp)
     585:	df 7d e8             	fistpll 0xffffffe8(%ebp)
     588:	d9 6d f2             	fldcw  0xfffffff2(%ebp)
     58b:	8b 5d e8             	mov    0xffffffe8(%ebp),%ebx
     58e:	85 db                	test   %ebx,%ebx
     590:	75 2c                	jne    5be <kb_x86_redo_vol_fields+0xfe>
     592:	c7 41 2c 01 00 00 00 	movl   $0x1,0x2c(%ecx)
     599:	d9 c9                	fxch   %st(1)
     59b:	8b 41 2c             	mov    0x2c(%ecx),%eax
     59e:	31 d2                	xor    %edx,%edx
     5a0:	d8 61 24             	fsubs  0x24(%ecx)
     5a3:	d9 c9                	fxch   %st(1)
     5a5:	52                   	push   %edx
     5a6:	50                   	push   %eax
     5a7:	d8 61 28             	fsubs  0x28(%ecx)
     5aa:	df 2c 24             	fildll (%esp)
     5ad:	dc fa                	fdivr  %st,%st(2)
     5af:	83 c4 08             	add    $0x8,%esp
     5b2:	de f9                	fdivrp %st,%st(1)
     5b4:	d9 c9                	fxch   %st(1)
     5b6:	d9 59 30             	fstps  0x30(%ecx)
     5b9:	d9 59 34             	fstps  0x34(%ecx)
     5bc:	eb a4                	jmp    562 <kb_x86_redo_vol_fields+0xa2>
     5be:	89 59 2c             	mov    %ebx,0x2c(%ecx)
     5c1:	eb d6                	jmp    599 <kb_x86_redo_vol_fields+0xd9>
     5c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000005d0 <kb_x86_setvolume>:
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	50                   	push   %eax
     5d4:	50                   	push   %eax
     5d5:	8b 45 08             	mov    0x8(%ebp),%eax
     5d8:	e8 63 fa ff ff       	call   40 <kb_x86_get_channel_struct>
     5dd:	8b 55 0c             	mov    0xc(%ebp),%edx
     5e0:	89 50 14             	mov    %edx,0x14(%eax)
     5e3:	c9                   	leave  
     5e4:	e9 d7 fe ff ff       	jmp    4c0 <kb_x86_redo_vol_fields>
     5e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

000005f0 <kb_x86_setpanning>:
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	50                   	push   %eax
     5f4:	50                   	push   %eax
     5f5:	8b 45 08             	mov    0x8(%ebp),%eax
     5f8:	e8 43 fa ff ff       	call   40 <kb_x86_get_channel_struct>
     5fd:	d9 e8                	fld1   
     5ff:	d8 45 0c             	fadds  0xc(%ebp)
     602:	d8 0d 10 00 00 00    	fmuls  0x10
     608:	d9 58 18             	fstps  0x18(%eax)
     60b:	e8 b0 fe ff ff       	call   4c0 <kb_x86_redo_vol_fields>
     610:	c9                   	leave  
     611:	c3                   	ret    
     612:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
     619:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000620 <kb_x86_setchcutoff>:
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	83 ec 18             	sub    $0x18,%esp
     626:	d9 45 0c             	flds   0xc(%ebp)
     629:	8b 45 08             	mov    0x8(%ebp),%eax
     62c:	d9 5d e8             	fstps  0xffffffe8(%ebp)
     62f:	e8 0c fa ff ff       	call   40 <kb_x86_get_channel_struct>
     634:	d9 ee                	fldz   
     636:	d9 45 e8             	flds   0xffffffe8(%ebp)
     639:	d9 c9                	fxch   %st(1)
     63b:	89 c2                	mov    %eax,%edx
     63d:	dd e1                	fucom  %st(1)
     63f:	df e0                	fnstsw %ax
     641:	f6 c4 45             	test   $0x45,%ah
     644:	75 0f                	jne    655 <kb_x86_setchcutoff+0x35>
     646:	dd d9                	fstp   %st(1)
     648:	b8 00 00 80 3f       	mov    $0x3f800000,%eax
     64d:	d9 5a 54             	fstps  0x54(%edx)
     650:	89 42 50             	mov    %eax,0x50(%edx)
     653:	c9                   	leave  
     654:	c3                   	ret    
     655:	d9 c9                	fxch   %st(1)
     657:	dd e1                	fucom  %st(1)
     659:	df e0                	fnstsw %ax
     65b:	dd d9                	fstp   %st(1)
     65d:	f6 c4 05             	test   $0x5,%ah
     660:	75 1e                	jne    680 <kb_x86_setchcutoff+0x60>
     662:	d9 e8                	fld1   
     664:	dd e9                	fucomp %st(1)
     666:	df e0                	fnstsw %ax
     668:	f6 c4 05             	test   $0x5,%ah
     66b:	75 33                	jne    6a0 <kb_x86_setchcutoff+0x80>
     66d:	d9 5a 50             	fstps  0x50(%edx)
     670:	c7 42 54 00 00 00 00 	movl   $0x0,0x54(%edx)
     677:	c9                   	leave  
     678:	c3                   	ret    
     679:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
     680:	dd d8                	fstp   %st(0)
     682:	83 ec 0c             	sub    $0xc,%esp
     685:	68 23 00 00 00       	push   $0x23
     68a:	68 27 00 00 00       	push   $0x27
     68f:	68 85 01 00 00       	push   $0x185
     694:	68 1a 00 00 00       	push   $0x1a
     699:	6a 00                	push   $0x0
     69b:	e8 fc ff ff ff       	call   69c <kb_x86_setchcutoff+0x7c>
     6a0:	dd d8                	fstp   %st(0)
     6a2:	83 ec 0c             	sub    $0xc,%esp
     6a5:	68 2f 00 00 00       	push   $0x2f
     6aa:	68 27 00 00 00       	push   $0x27
     6af:	68 86 01 00 00       	push   $0x186
     6b4:	eb de                	jmp    694 <kb_x86_setchcutoff+0x74>
     6b6:	8d 76 00             	lea    0x0(%esi),%esi
     6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

000006c0 <kb_x86_setchreso>:
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	50                   	push   %eax
     6c4:	50                   	push   %eax
     6c5:	8b 45 08             	mov    0x8(%ebp),%eax
     6c8:	e8 73 f9 ff ff       	call   40 <kb_x86_get_channel_struct>
     6cd:	d9 ee                	fldz   
     6cf:	d9 45 0c             	flds   0xc(%ebp)
     6d2:	89 c2                	mov    %eax,%edx
     6d4:	da e9                	fucompp 
     6d6:	df e0                	fnstsw %ax
     6d8:	f6 c4 05             	test   $0x5,%ah
     6db:	75 36                	jne    713 <kb_x86_setchreso+0x53>
     6dd:	d9 e8                	fld1   
     6df:	d9 45 0c             	flds   0xc(%ebp)
     6e2:	d9 c9                	fxch   %st(1)
     6e4:	da e9                	fucompp 
     6e6:	df e0                	fnstsw %ax
     6e8:	f6 c4 05             	test   $0x5,%ah
     6eb:	75 08                	jne    6f5 <kb_x86_setchreso+0x35>
     6ed:	d9 45 0c             	flds   0xc(%ebp)
     6f0:	d9 5a 54             	fstps  0x54(%edx)
     6f3:	c9                   	leave  
     6f4:	c3                   	ret    
     6f5:	83 ec 0c             	sub    $0xc,%esp
     6f8:	68 3b 00 00 00       	push   $0x3b
     6fd:	68 3a 00 00 00       	push   $0x3a
     702:	68 93 01 00 00       	push   $0x193
     707:	68 1a 00 00 00       	push   $0x1a
     70c:	6a 00                	push   $0x0
     70e:	e8 fc ff ff ff       	call   70f <kb_x86_setchreso+0x4f>
     713:	83 ec 0c             	sub    $0xc,%esp
     716:	68 47 00 00 00       	push   $0x47
     71b:	68 3a 00 00 00       	push   $0x3a
     720:	68 92 01 00 00       	push   $0x192
     725:	eb e0                	jmp    707 <kb_x86_setchreso+0x47>
     727:	89 f6                	mov    %esi,%esi
     729:	8d bc 27 00 00 00 00 	lea    0x0(%edi),%edi

00000730 <kb_x86_call_mixer>:
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	56                   	push   %esi
     734:	89 c6                	mov    %eax,%esi
     736:	53                   	push   %ebx
     737:	8b 45 08             	mov    0x8(%ebp),%eax
     73a:	89 d3                	mov    %edx,%ebx
     73c:	85 c0                	test   %eax,%eax
     73e:	75 09                	jne    749 <kb_x86_call_mixer+0x19>
     740:	8b 42 40             	mov    0x40(%edx),%eax
     743:	83 c8 04             	or     $0x4,%eax
     746:	89 42 40             	mov    %eax,0x40(%edx)
     749:	83 ec 0c             	sub    $0xc,%esp
     74c:	53                   	push   %ebx
     74d:	e8 fc ff ff ff       	call   74e <kb_x86_call_mixer+0x1e>
     752:	8b 03                	mov    (%ebx),%eax
     754:	89 46 24             	mov    %eax,0x24(%esi)
     757:	8b 43 04             	mov    0x4(%ebx),%eax
     75a:	89 46 28             	mov    %eax,0x28(%esi)
     75d:	8d 65 f8             	lea    0xfffffff8(%ebp),%esp
     760:	5b                   	pop    %ebx
     761:	5e                   	pop    %esi
     762:	5d                   	pop    %ebp
     763:	c3                   	ret    
     764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     76a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000770 <kb_x86_mix>:
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	57                   	push   %edi
     774:	56                   	push   %esi
     775:	53                   	push   %ebx
     776:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
     77c:	8b 45 0c             	mov    0xc(%ebp),%eax
     77f:	39 05 04 00 00 00    	cmp    %eax,0x4
     785:	0f 82 0b 0e 00 00    	jb     1596 <kb_x86_mix+0xe26>
     78b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     78e:	8b 3d 00 00 00 00    	mov    0x0,%edi
     794:	c1 e1 03             	shl    $0x3,%ecx
     797:	31 c0                	xor    %eax,%eax
     799:	fc                   	cld    
     79a:	c1 e9 02             	shr    $0x2,%ecx
     79d:	f3 ab                	repz stos %eax,%es:(%edi)
     79f:	c7 85 7c ff ff ff 00 	movl   $0x0,0xffffff7c(%ebp)
     7a6:	00 00 00 
     7a9:	c7 85 10 ff ff ff 20 	movl   $0x20,0xffffff10(%ebp)
     7b0:	00 00 00 
     7b3:	eb 29                	jmp    7de <kb_x86_mix+0x6e>
     7b5:	8b bd 7c ff ff ff    	mov    0xffffff7c(%ebp),%edi
     7bb:	8b b5 10 ff ff ff    	mov    0xffffff10(%ebp),%esi
     7c1:	47                   	inc    %edi
     7c2:	83 c6 60             	add    $0x60,%esi
     7c5:	89 bd 7c ff ff ff    	mov    %edi,0xffffff7c(%ebp)
     7cb:	89 b5 10 ff ff ff    	mov    %esi,0xffffff10(%ebp)
     7d1:	83 bd 7c ff ff ff 3f 	cmpl   $0x3f,0xffffff7c(%ebp)
     7d8:	0f 8f 80 0d 00 00    	jg     155e <kb_x86_mix+0xdee>
     7de:	8b 85 7c ff ff ff    	mov    0xffffff7c(%ebp),%eax
     7e4:	8b 0d 00 00 00 00    	mov    0x0,%ecx
     7ea:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     7ed:	83 e0 1f             	and    $0x1f,%eax
     7f0:	89 8d 78 ff ff ff    	mov    %ecx,0xffffff78(%ebp)
     7f6:	89 9d 74 ff ff ff    	mov    %ebx,0xffffff74(%ebp)
     7fc:	c7 85 70 ff ff ff 00 	movl   $0x0,0xffffff70(%ebp)
     803:	00 00 00 
     806:	3b 05 08 00 00 00    	cmp    0x8,%eax
     80c:	7d a7                	jge    7b5 <kb_x86_mix+0x45>
     80e:	8b 5d 10             	mov    0x10(%ebp),%ebx
     811:	85 db                	test   %ebx,%ebx
     813:	74 2a                	je     83f <kb_x86_mix+0xcf>
     815:	83 bd 7c ff ff ff 1f 	cmpl   $0x1f,0xffffff7c(%ebp)
     81c:	7e 0f                	jle    82d <kb_x86_mix+0xbd>
     81e:	8b b5 10 ff ff ff    	mov    0xffffff10(%ebp),%esi
     824:	f6 86 10 f4 ff ff 10 	testb  $0x10,0xfffff410(%esi)
     82b:	74 12                	je     83f <kb_x86_mix+0xcf>
     82d:	8b 7d 10             	mov    0x10(%ebp),%edi
     830:	8b 55 14             	mov    0x14(%ebp),%edx
     833:	8b 04 87             	mov    (%edi,%eax,4),%eax
     836:	8d 04 50             	lea    (%eax,%edx,2),%eax
     839:	89 85 70 ff ff ff    	mov    %eax,0xffffff70(%ebp)
     83f:	8b 8d 10 ff ff ff    	mov    0xffffff10(%ebp),%ecx
     845:	8b 71 10             	mov    0x10(%ecx),%esi
     848:	f7 c6 04 00 00 00    	test   $0x4,%esi
     84e:	75 30                	jne    880 <kb_x86_mix+0x110>
     850:	8b 8d 70 ff ff ff    	mov    0xffffff70(%ebp),%ecx
     856:	85 c9                	test   %ecx,%ecx
     858:	0f 84 57 ff ff ff    	je     7b5 <kb_x86_mix+0x45>
     85e:	8b 45 0c             	mov    0xc(%ebp),%eax
     861:	01 c0                	add    %eax,%eax
     863:	52                   	push   %edx
     864:	50                   	push   %eax
     865:	8b 85 70 ff ff ff    	mov    0xffffff70(%ebp),%eax
     86b:	6a 00                	push   $0x0
     86d:	50                   	push   %eax
     86e:	e8 fc ff ff ff       	call   86f <kb_x86_mix+0xff>
     873:	83 c4 10             	add    $0x10,%esp
     876:	e9 3a ff ff ff       	jmp    7b5 <kb_x86_mix+0x45>
     87b:	90                   	nop    
     87c:	8d 74 26 00          	lea    0x0(%esi),%esi
     880:	f7 c6 08 00 00 00    	test   $0x8,%esi
     886:	74 7d                	je     905 <kb_x86_mix+0x195>
     888:	f7 c6 40 00 00 00    	test   $0x40,%esi
     88e:	74 69                	je     8f9 <kb_x86_mix+0x189>
     890:	db 05 0c 00 00 00    	fildl  0xc
     896:	d9 7d 8e             	fnstcw 0xffffff8e(%ebp)
     899:	dc 0d 30 00 00 00    	fmull  0x30
     89f:	66 8b 45 8e          	mov    0xffffff8e(%ebp),%ax
     8a3:	b4 0c                	mov    $0xc,%ah
     8a5:	66 89 45 8c          	mov    %ax,0xffffff8c(%ebp)
     8a9:	d9 6d 8c             	fldcw  0xffffff8c(%ebp)
     8ac:	df 7d 80             	fistpll 0xffffff80(%ebp)
     8af:	d9 6d 8e             	fldcw  0xffffff8e(%ebp)
     8b2:	8b 55 80             	mov    0xffffff80(%ebp),%edx
     8b5:	85 d2                	test   %edx,%edx
     8b7:	0f 85 48 06 00 00    	jne    f05 <kb_x86_mix+0x795>
     8bd:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     8c3:	c7 43 2c 01 00 00 00 	movl   $0x1,0x2c(%ebx)
     8ca:	8b 85 10 ff ff ff    	mov    0xffffff10(%ebp),%eax
     8d0:	31 d2                	xor    %edx,%edx
     8d2:	d9 ee                	fldz   
     8d4:	89 c1                	mov    %eax,%ecx
     8d6:	d9 50 24             	fsts   0x24(%eax)
     8d9:	d9 58 28             	fstps  0x28(%eax)
     8dc:	8b 40 2c             	mov    0x2c(%eax),%eax
     8df:	52                   	push   %edx
     8e0:	50                   	push   %eax
     8e1:	df 2c 24             	fildll (%esp)
     8e4:	d9 41 38             	flds   0x38(%ecx)
     8e7:	d8 f1                	fdiv   %st(1),%st
     8e9:	d9 c9                	fxch   %st(1)
     8eb:	83 c4 08             	add    $0x8,%esp
     8ee:	d8 79 3c             	fdivrs 0x3c(%ecx)
     8f1:	d9 c9                	fxch   %st(1)
     8f3:	d9 59 30             	fstps  0x30(%ecx)
     8f6:	d9 59 34             	fstps  0x34(%ecx)
     8f9:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     8ff:	83 e6 f7             	and    $0xfffffff7,%esi
     902:	89 73 10             	mov    %esi,0x10(%ebx)
     905:	8b b5 10 ff ff ff    	mov    0xffffff10(%ebp),%esi
     90b:	8b 36                	mov    (%esi),%esi
     90d:	89 b5 18 ff ff ff    	mov    %esi,0xffffff18(%ebp)
     913:	8b 46 14             	mov    0x14(%esi),%eax
     916:	85 c0                	test   %eax,%eax
     918:	0f 84 dc 0c 00 00    	je     15fa <kb_x86_mix+0xe8a>
     91e:	8b 3d 00 00 00 00    	mov    0x0,%edi
     924:	85 ff                	test   %edi,%edi
     926:	0f 85 40 0b 00 00    	jne    146c <kb_x86_mix+0xcfc>
     92c:	8b 75 0c             	mov    0xc(%ebp),%esi
     92f:	85 f6                	test   %esi,%esi
     931:	0f 84 e4 05 00 00    	je     f1b <kb_x86_mix+0x7ab>
     937:	8b bd 10 ff ff ff    	mov    0xffffff10(%ebp),%edi
     93d:	8b 77 10             	mov    0x10(%edi),%esi
     940:	f7 c6 04 00 00 00    	test   $0x4,%esi
     946:	0f 84 cf 05 00 00    	je     f1b <kb_x86_mix+0x7ab>
     94c:	d9 47 24             	flds   0x24(%edi)
     94f:	d9 47 28             	flds   0x28(%edi)
     952:	d9 47 58             	flds   0x58(%edi)
     955:	d9 47 5c             	flds   0x5c(%edi)
     958:	e9 dc 03 00 00       	jmp    d39 <kb_x86_mix+0x5c9>
     95d:	8d 76 00             	lea    0x0(%esi),%esi
     960:	8b 95 10 ff ff ff    	mov    0xffffff10(%ebp),%edx
     966:	8b 8d 10 ff ff ff    	mov    0xffffff10(%ebp),%ecx
     96c:	8b 42 30             	mov    0x30(%edx),%eax
     96f:	89 45 a0             	mov    %eax,0xffffffa0(%ebp)
     972:	8b 42 34             	mov    0x34(%edx),%eax
     975:	89 45 a4             	mov    %eax,0xffffffa4(%ebp)
     978:	8b 41 44             	mov    0x44(%ecx),%eax
     97b:	89 45 ac             	mov    %eax,0xffffffac(%ebp)
     97e:	8b 59 1c             	mov    0x1c(%ecx),%ebx
     981:	89 9d 1c ff ff ff    	mov    %ebx,0xffffff1c(%ebp)
     987:	4b                   	dec    %ebx
     988:	0f 84 37 05 00 00    	je     ec5 <kb_x86_mix+0x755>
     98e:	8b 8d 50 ff ff ff    	mov    0xffffff50(%ebp),%ecx
     994:	8b 9d 54 ff ff ff    	mov    0xffffff54(%ebp),%ebx
     99a:	f7 d9                	neg    %ecx
     99c:	83 d3 00             	adc    $0x0,%ebx
     99f:	89 4d b4             	mov    %ecx,0xffffffb4(%ebp)
     9a2:	f7 db                	neg    %ebx
     9a4:	89 5d b0             	mov    %ebx,0xffffffb0(%ebp)
     9a7:	8b 95 10 ff ff ff    	mov    0xffffff10(%ebp),%edx
     9ad:	8b 85 70 ff ff ff    	mov    0xffffff70(%ebp),%eax
     9b3:	d9 e8                	fld1   
     9b5:	d9 42 54             	flds   0x54(%edx)
     9b8:	89 45 d4             	mov    %eax,0xffffffd4(%ebp)
     9bb:	8b bd 78 ff ff ff    	mov    0xffffff78(%ebp),%edi
     9c1:	d9 55 c8             	fsts   0xffffffc8(%ebp)
     9c4:	d9 42 50             	flds   0x50(%edx)
     9c7:	dd e2                	fucom  %st(2)
     9c9:	df e0                	fnstsw %ax
     9cb:	dd da                	fstp   %st(2)
     9cd:	d9 c9                	fxch   %st(1)
     9cf:	80 e4 45             	and    $0x45,%ah
     9d2:	80 f4 40             	xor    $0x40,%ah
     9d5:	89 7d b8             	mov    %edi,0xffffffb8(%ebp)
     9d8:	d9 5d c4             	fstps  0xffffffc4(%ebp)
     9db:	d9 ca                	fxch   %st(2)
     9dd:	d9 55 cc             	fsts   0xffffffcc(%ebp)
     9e0:	d9 cc                	fxch   %st(4)
     9e2:	d9 55 d0             	fsts   0xffffffd0(%ebp)
     9e5:	0f 85 eb 04 00 00    	jne    ed6 <kb_x86_mix+0x766>
     9eb:	d9 ee                	fldz   
     9ed:	d9 cb                	fxch   %st(3)
     9ef:	dd eb                	fucomp %st(3)
     9f1:	df e0                	fnstsw %ax
     9f3:	dd da                	fstp   %st(2)
     9f5:	80 e4 45             	and    $0x45,%ah
     9f8:	80 f4 40             	xor    $0x40,%ah
     9fb:	0f 85 d7 04 00 00    	jne    ed8 <kb_x86_mix+0x768>
     a01:	c7 45 d8 00 00 00 00 	movl   $0x0,0xffffffd8(%ebp)
     a08:	8b 85 70 ff ff ff    	mov    0xffffff70(%ebp),%eax
     a0e:	85 c0                	test   %eax,%eax
     a10:	74 09                	je     a1b <kb_x86_mix+0x2ab>
     a12:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
     a15:	83 c8 10             	or     $0x10,%eax
     a18:	89 45 d8             	mov    %eax,0xffffffd8(%ebp)
     a1b:	8b 85 6c ff ff ff    	mov    0xffffff6c(%ebp),%eax
     a21:	85 c0                	test   %eax,%eax
     a23:	74 09                	je     a2e <kb_x86_mix+0x2be>
     a25:	8b 45 d8             	mov    0xffffffd8(%ebp),%eax
     a28:	83 c8 20             	or     $0x20,%eax
     a2b:	89 45 d8             	mov    %eax,0xffffffd8(%ebp)
     a2e:	83 bd 1c ff ff ff 01 	cmpl   $0x1,0xffffff1c(%ebp)
     a35:	0f 84 0a 05 00 00    	je     f45 <kb_x86_mix+0x7d5>
     a3b:	83 bd 1c ff ff ff ff 	cmpl   $0xffffffff,0xffffff1c(%ebp)
     a42:	0f 84 9f 06 00 00    	je     10e7 <kb_x86_mix+0x977>
     a48:	dd d8                	fstp   %st(0)
     a4a:	dd d8                	fstp   %st(0)
     a4c:	dd d8                	fstp   %st(0)
     a4e:	dd d8                	fstp   %st(0)
     a50:	83 bd 1c ff ff ff 01 	cmpl   $0x1,0xffffff1c(%ebp)
     a57:	0f 84 af 06 00 00    	je     110c <kb_x86_mix+0x99c>
     a5d:	8b 8d 68 ff ff ff    	mov    0xffffff68(%ebp),%ecx
     a63:	8b 85 50 ff ff ff    	mov    0xffffff50(%ebp),%eax
     a69:	f7 e1                	mul    %ecx
     a6b:	8b bd 54 ff ff ff    	mov    0xffffff54(%ebp),%edi
     a71:	31 db                	xor    %ebx,%ebx
     a73:	0f af f9             	imul   %ecx,%edi
     a76:	8b 8d 50 ff ff ff    	mov    0xffffff50(%ebp),%ecx
     a7c:	89 d6                	mov    %edx,%esi
     a7e:	0f af cb             	imul   %ebx,%ecx
     a81:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
     a87:	01 fe                	add    %edi,%esi
     a89:	8b 85 48 ff ff ff    	mov    0xffffff48(%ebp),%eax
     a8f:	01 ce                	add    %ecx,%esi
     a91:	2b 85 f8 fe ff ff    	sub    0xfffffef8(%ebp),%eax
     a97:	89 b5 fc fe ff ff    	mov    %esi,0xfffffefc(%ebp)
     a9d:	8b 95 4c ff ff ff    	mov    0xffffff4c(%ebp),%edx
     aa3:	8b 9d 68 ff ff ff    	mov    0xffffff68(%ebp),%ebx
     aa9:	1b 95 fc fe ff ff    	sbb    0xfffffefc(%ebp),%edx
     aaf:	89 9d 34 ff ff ff    	mov    %ebx,0xffffff34(%ebp)
     ab5:	89 d0                	mov    %edx,%eax
     ab7:	8b 95 18 ff ff ff    	mov    0xffffff18(%ebp),%edx
     abd:	8b 4a 08             	mov    0x8(%edx),%ecx
     ac0:	83 c1 03             	add    $0x3,%ecx
     ac3:	89 8d 20 ff ff ff    	mov    %ecx,0xffffff20(%ebp)
     ac9:	39 c1                	cmp    %eax,%ecx
     acb:	0f 8e 3f 01 00 00    	jle    c10 <kb_x86_mix+0x4a0>
     ad1:	8b 42 08             	mov    0x8(%edx),%eax
     ad4:	8b b5 48 ff ff ff    	mov    0xffffff48(%ebp),%esi
     ada:	83 c0 03             	add    $0x3,%eax
     add:	8b bd 4c ff ff ff    	mov    0xffffff4c(%ebp),%edi
     ae3:	89 c2                	mov    %eax,%edx
     ae5:	31 c0                	xor    %eax,%eax
     ae7:	29 c6                	sub    %eax,%esi
     ae9:	8b 9d 50 ff ff ff    	mov    0xffffff50(%ebp),%ebx
     aef:	19 d7                	sbb    %edx,%edi
     af1:	89 f0                	mov    %esi,%eax
     af3:	8b b5 54 ff ff ff    	mov    0xffffff54(%ebp),%esi
     af9:	56                   	push   %esi
     afa:	53                   	push   %ebx
     afb:	57                   	push   %edi
     afc:	50                   	push   %eax
     afd:	e8 fc ff ff ff       	call   afe <kb_x86_mix+0x38e>
     b02:	83 c4 10             	add    $0x10,%esp
     b05:	40                   	inc    %eax
     b06:	89 85 34 ff ff ff    	mov    %eax,0xffffff34(%ebp)
     b0c:	85 c0                	test   %eax,%eax
     b0e:	0f 8e fa 0a 00 00    	jle    160e <kb_x86_mix+0xe9e>
     b14:	8b 85 34 ff ff ff    	mov    0xffffff34(%ebp),%eax
     b1a:	8b bd 54 ff ff ff    	mov    0xffffff54(%ebp),%edi
     b20:	89 c2                	mov    %eax,%edx
     b22:	89 c1                	mov    %eax,%ecx
     b24:	c1 fa 1f             	sar    $0x1f,%edx
     b27:	8b 85 50 ff ff ff    	mov    0xffffff50(%ebp),%eax
     b2d:	89 d3                	mov    %edx,%ebx
     b2f:	f7 e1                	mul    %ecx
     b31:	0f af f9             	imul   %ecx,%edi
     b34:	8b 8d 50 ff ff ff    	mov    0xffffff50(%ebp),%ecx
     b3a:	89 d6                	mov    %edx,%esi
     b3c:	0f af cb             	imul   %ebx,%ecx
     b3f:	01 fe                	add    %edi,%esi
     b41:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
     b47:	01 ce                	add    %ecx,%esi
     b49:	8b bd 4c ff ff ff    	mov    0xffffff4c(%ebp),%edi
     b4f:	89 b5 fc fe ff ff    	mov    %esi,0xfffffefc(%ebp)
     b55:	8b b5 48 ff ff ff    	mov    0xffffff48(%ebp),%esi
     b5b:	2b b5 f8 fe ff ff    	sub    0xfffffef8(%ebp),%esi
     b61:	8b 85 20 ff ff ff    	mov    0xffffff20(%ebp),%eax
     b67:	1b bd fc fe ff ff    	sbb    0xfffffefc(%ebp),%edi
     b6d:	89 c2                	mov    %eax,%edx
     b6f:	31 c0                	xor    %eax,%eax
     b71:	39 d7                	cmp    %edx,%edi
     b73:	0f 8f 4f 0a 00 00    	jg     15c8 <kb_x86_mix+0xe58>
     b79:	7c 08                	jl     b83 <kb_x86_mix+0x413>
     b7b:	39 c6                	cmp    %eax,%esi
     b7d:	0f 83 45 0a 00 00    	jae    15c8 <kb_x86_mix+0xe58>
     b83:	8b 85 34 ff ff ff    	mov    0xffffff34(%ebp),%eax
     b89:	8b bd 54 ff ff ff    	mov    0xffffff54(%ebp),%edi
     b8f:	48                   	dec    %eax
     b90:	89 c1                	mov    %eax,%ecx
     b92:	89 c3                	mov    %eax,%ebx
     b94:	c1 fb 1f             	sar    $0x1f,%ebx
     b97:	8b 85 50 ff ff ff    	mov    0xffffff50(%ebp),%eax
     b9d:	f7 e1                	mul    %ecx
     b9f:	0f af f9             	imul   %ecx,%edi
     ba2:	8b 8d 50 ff ff ff    	mov    0xffffff50(%ebp),%ecx
     ba8:	89 d6                	mov    %edx,%esi
     baa:	0f af cb             	imul   %ebx,%ecx
     bad:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
     bb3:	01 fe                	add    %edi,%esi
     bb5:	8b 95 48 ff ff ff    	mov    0xffffff48(%ebp),%edx
     bbb:	01 ce                	add    %ecx,%esi
     bbd:	8b 9d 18 ff ff ff    	mov    0xffffff18(%ebp),%ebx
     bc3:	2b 95 f8 fe ff ff    	sub    0xfffffef8(%ebp),%edx
     bc9:	89 b5 fc fe ff ff    	mov    %esi,0xfffffefc(%ebp)
     bcf:	8b 8d 4c ff ff ff    	mov    0xffffff4c(%ebp),%ecx
     bd5:	1b 8d fc fe ff ff    	sbb    0xfffffefc(%ebp),%ecx
     bdb:	8b 43 08             	mov    0x8(%ebx),%eax
     bde:	83 c0 03             	add    $0x3,%eax
     be1:	31 f6                	xor    %esi,%esi
     be3:	39 c1                	cmp    %eax,%ecx
     be5:	0f 8c fb 09 00 00    	jl     15e6 <kb_x86_mix+0xe76>
     beb:	7f 08                	jg     bf5 <kb_x86_mix+0x485>
     bed:	39 f2                	cmp    %esi,%edx
     bef:	0f 82 f1 09 00 00    	jb     15e6 <kb_x86_mix+0xe76>
     bf5:	8b b5 68 ff ff ff    	mov    0xffffff68(%ebp),%esi
     bfb:	39 b5 34 ff ff ff    	cmp    %esi,0xffffff34(%ebp)
     c01:	76 0d                	jbe    c10 <kb_x86_mix+0x4a0>
     c03:	89 b5 34 ff ff ff    	mov    %esi,0xffffff34(%ebp)
     c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi
     c10:	8b bd 18 ff ff ff    	mov    0xffffff18(%ebp),%edi
     c16:	8b 95 14 ff ff ff    	mov    0xffffff14(%ebp),%edx
     c1c:	83 ec 0c             	sub    $0xc,%esp
     c1f:	8b 8d 34 ff ff ff    	mov    0xffffff34(%ebp),%ecx
     c25:	8b 47 10             	mov    0x10(%edi),%eax
     c28:	89 4d bc             	mov    %ecx,0xffffffbc(%ebp)
     c2b:	6a 00                	push   $0x0
     c2d:	8d 04 50             	lea    (%eax,%edx,2),%eax
     c30:	89 45 a8             	mov    %eax,0xffffffa8(%ebp)
     c33:	8d 55 98             	lea    0xffffff98(%ebp),%edx
     c36:	8b 85 10 ff ff ff    	mov    0xffffff10(%ebp),%eax
     c3c:	e8 ef fa ff ff       	call   730 <kb_x86_call_mixer>
     c41:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     c47:	d9 45 98             	flds   0xffffff98(%ebp)
     c4a:	8b 03                	mov    (%ebx),%eax
     c4c:	8b 55 a8             	mov    0xffffffa8(%ebp),%edx
     c4f:	d9 53 24             	fsts   0x24(%ebx)
     c52:	d9 45 9c             	flds   0xffffff9c(%ebp)
     c55:	8b 48 10             	mov    0x10(%eax),%ecx
     c58:	83 c4 10             	add    $0x10,%esp
     c5b:	d9 53 28             	fsts   0x28(%ebx)
     c5e:	d9 45 cc             	flds   0xffffffcc(%ebp)
     c61:	29 ca                	sub    %ecx,%edx
     c63:	d9 53 58             	fsts   0x58(%ebx)
     c66:	d1 fa                	sar    %edx
     c68:	d9 45 d0             	flds   0xffffffd0(%ebp)
     c6b:	89 53 40             	mov    %edx,0x40(%ebx)
     c6e:	8b 95 34 ff ff ff    	mov    0xffffff34(%ebp),%edx
     c74:	8b 45 ac             	mov    0xffffffac(%ebp),%eax
     c77:	d9 53 5c             	fsts   0x5c(%ebx)
     c7a:	89 43 44             	mov    %eax,0x44(%ebx)
     c7d:	8b 85 6c ff ff ff    	mov    0xffffff6c(%ebp),%eax
     c83:	85 c0                	test   %eax,%eax
     c85:	74 59                	je     ce0 <kb_x86_mix+0x570>
     c87:	8b b5 10 ff ff ff    	mov    0xffffff10(%ebp),%esi
     c8d:	8b 46 2c             	mov    0x2c(%esi),%eax
     c90:	29 d0                	sub    %edx,%eax
     c92:	89 46 2c             	mov    %eax,0x2c(%esi)
     c95:	85 c0                	test   %eax,%eax
     c97:	75 47                	jne    ce0 <kb_x86_mix+0x570>
     c99:	dd da                	fstp   %st(2)
     c9b:	dd da                	fstp   %st(2)
     c9d:	8b 46 38             	mov    0x38(%esi),%eax
     ca0:	89 85 04 ff ff ff    	mov    %eax,0xffffff04(%ebp)
     ca6:	d9 85 04 ff ff ff    	flds   0xffffff04(%ebp)
     cac:	8b 46 3c             	mov    0x3c(%esi),%eax
     caf:	d9 56 24             	fsts   0x24(%esi)
     cb2:	89 85 04 ff ff ff    	mov    %eax,0xffffff04(%ebp)
     cb8:	d9 85 04 ff ff ff    	flds   0xffffff04(%ebp)
     cbe:	8b 46 10             	mov    0x10(%esi),%eax
     cc1:	d9 56 28             	fsts   0x28(%esi)
     cc4:	a8 20                	test   $0x20,%al
     cc6:	0f 84 2c 02 00 00    	je     ef8 <kb_x86_mix+0x788>
     ccc:	d9 ca                	fxch   %st(2)
     cce:	d9 c9                	fxch   %st(1)
     cd0:	d9 cb                	fxch   %st(3)
     cd2:	d9 c9                	fxch   %st(1)
     cd4:	83 e0 10             	and    $0x10,%eax
     cd7:	89 46 10             	mov    %eax,0x10(%esi)
     cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ce0:	8b 85 74 ff ff ff    	mov    0xffffff74(%ebp),%eax
     ce6:	8b bd 78 ff ff ff    	mov    0xffffff78(%ebp),%edi
     cec:	29 d0                	sub    %edx,%eax
     cee:	89 85 74 ff ff ff    	mov    %eax,0xffffff74(%ebp)
     cf4:	8d 3c d7             	lea    (%edi,%edx,8),%edi
     cf7:	8b 85 70 ff ff ff    	mov    0xffffff70(%ebp),%eax
     cfd:	89 bd 78 ff ff ff    	mov    %edi,0xffffff78(%ebp)
     d03:	85 c0                	test   %eax,%eax
     d05:	74 0f                	je     d16 <kb_x86_mix+0x5a6>
     d07:	8b 85 70 ff ff ff    	mov    0xffffff70(%ebp),%eax
     d0d:	8d 04 50             	lea    (%eax,%edx,2),%eax
     d10:	89 85 70 ff ff ff    	mov    %eax,0xffffff70(%ebp)
     d16:	8b 85 74 ff ff ff    	mov    0xffffff74(%ebp),%eax
     d1c:	85 c0                	test   %eax,%eax
     d1e:	0f 84 ef 01 00 00    	je     f13 <kb_x86_mix+0x7a3>
     d24:	8b 95 10 ff ff ff    	mov    0xffffff10(%ebp),%edx
     d2a:	8b 72 10             	mov    0x10(%edx),%esi
     d2d:	f7 c6 04 00 00 00    	test   $0x4,%esi
     d33:	0f 84 da 01 00 00    	je     f13 <kb_x86_mix+0x7a3>
     d39:	8b 85 10 ff ff ff    	mov    0xffffff10(%ebp),%eax
     d3f:	8b 8d 74 ff ff ff    	mov    0xffffff74(%ebp),%ecx
     d45:	89 8d 68 ff ff ff    	mov    %ecx,0xffffff68(%ebp)
     d4b:	8b 50 2c             	mov    0x2c(%eax),%edx
     d4e:	85 d2                	test   %edx,%edx
     d50:	0f 95 c0             	setne  %al
     d53:	25 ff 00 00 00       	and    $0xff,%eax
     d58:	89 85 6c ff ff ff    	mov    %eax,0xffffff6c(%ebp)
     d5e:	85 c0                	test   %eax,%eax
     d60:	74 10                	je     d72 <kb_x86_mix+0x602>
     d62:	89 95 68 ff ff ff    	mov    %edx,0xffffff68(%ebp)
     d68:	39 ca                	cmp    %ecx,%edx
     d6a:	76 06                	jbe    d72 <kb_x86_mix+0x602>
     d6c:	89 8d 68 ff ff ff    	mov    %ecx,0xffffff68(%ebp)
     d72:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     d78:	c7 85 64 ff ff ff 00 	movl   $0x0,0xffffff64(%ebp)
     d7f:	00 00 00 
     d82:	8b 4b 20             	mov    0x20(%ebx),%ecx
     d85:	85 c9                	test   %ecx,%ecx
     d87:	75 17                	jne    da0 <kb_x86_mix+0x630>
     d89:	f7 c6 03 00 00 00    	test   $0x3,%esi
     d8f:	74 0f                	je     da0 <kb_x86_mix+0x630>
     d91:	c7 85 64 ff ff ff 01 	movl   $0x1,0xffffff64(%ebp)
     d98:	00 00 00 
     d9b:	90                   	nop    
     d9c:	8d 74 26 00          	lea    0x0(%esi),%esi
     da0:	8b 9d 64 ff ff ff    	mov    0xffffff64(%ebp),%ebx
     da6:	c7 85 60 ff ff ff 00 	movl   $0x0,0xffffff60(%ebp)
     dad:	00 00 00 
     db0:	85 db                	test   %ebx,%ebx
     db2:	74 12                	je     dc6 <kb_x86_mix+0x656>
     db4:	f7 c6 02 00 00 00    	test   $0x2,%esi
     dba:	74 0a                	je     dc6 <kb_x86_mix+0x656>
     dbc:	c7 85 60 ff ff ff 01 	movl   $0x1,0xffffff60(%ebp)
     dc3:	00 00 00 
     dc6:	8b bd 10 ff ff ff    	mov    0xffffff10(%ebp),%edi
     dcc:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     dd2:	89 8d 44 ff ff ff    	mov    %ecx,0xffffff44(%ebp)
     dd8:	8b 3f                	mov    (%edi),%edi
     dda:	8b 5b 40             	mov    0x40(%ebx),%ebx
     ddd:	89 9d 14 ff ff ff    	mov    %ebx,0xffffff14(%ebp)
     de3:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     de9:	8b 47 08             	mov    0x8(%edi),%eax
     dec:	89 bd 18 ff ff ff    	mov    %edi,0xffffff18(%ebp)
     df2:	89 c2                	mov    %eax,%edx
     df4:	31 c0                	xor    %eax,%eax
     df6:	89 95 5c ff ff ff    	mov    %edx,0xffffff5c(%ebp)
     dfc:	8b 95 10 ff ff ff    	mov    0xffffff10(%ebp),%edx
     e02:	89 85 58 ff ff ff    	mov    %eax,0xffffff58(%ebp)
     e08:	8b 42 48             	mov    0x48(%edx),%eax
     e0b:	89 c2                	mov    %eax,%edx
     e0d:	31 c0                	xor    %eax,%eax
     e0f:	89 85 50 ff ff ff    	mov    %eax,0xffffff50(%ebp)
     e15:	8b 43 4c             	mov    0x4c(%ebx),%eax
     e18:	89 95 54 ff ff ff    	mov    %edx,0xffffff54(%ebp)
     e1e:	31 d2                	xor    %edx,%edx
     e20:	01 85 50 ff ff ff    	add    %eax,0xffffff50(%ebp)
     e26:	8b 43 40             	mov    0x40(%ebx),%eax
     e29:	11 95 54 ff ff ff    	adc    %edx,0xffffff54(%ebp)
     e2f:	89 c2                	mov    %eax,%edx
     e31:	31 c0                	xor    %eax,%eax
     e33:	89 95 4c ff ff ff    	mov    %edx,0xffffff4c(%ebp)
     e39:	89 85 48 ff ff ff    	mov    %eax,0xffffff48(%ebp)
     e3f:	8b 43 44             	mov    0x44(%ebx),%eax
     e42:	31 d2                	xor    %edx,%edx
     e44:	01 85 48 ff ff ff    	add    %eax,0xffffff48(%ebp)
     e4a:	11 95 4c ff ff ff    	adc    %edx,0xffffff4c(%ebp)
     e50:	85 c9                	test   %ecx,%ecx
     e52:	75 1c                	jne    e70 <kb_x86_mix+0x700>
     e54:	8b 8d 64 ff ff ff    	mov    0xffffff64(%ebp),%ecx
     e5a:	85 c9                	test   %ecx,%ecx
     e5c:	0f 84 82 00 00 00    	je     ee4 <kb_x86_mix+0x774>
     e62:	8b 4f 0c             	mov    0xc(%edi),%ecx
     e65:	89 8d 44 ff ff ff    	mov    %ecx,0xffffff44(%ebp)
     e6b:	90                   	nop    
     e6c:	8d 74 26 00          	lea    0x0(%esi),%esi
     e70:	d9 cb                	fxch   %st(3)
     e72:	8b 85 44 ff ff ff    	mov    0xffffff44(%ebp),%eax
     e78:	89 c2                	mov    %eax,%edx
     e7a:	31 c0                	xor    %eax,%eax
     e7c:	89 95 3c ff ff ff    	mov    %edx,0xffffff3c(%ebp)
     e82:	8b 95 6c ff ff ff    	mov    0xffffff6c(%ebp),%edx
     e88:	89 85 38 ff ff ff    	mov    %eax,0xffffff38(%ebp)
     e8e:	85 d2                	test   %edx,%edx
     e90:	d9 55 98             	fsts   0xffffff98(%ebp)
     e93:	d9 ca                	fxch   %st(2)
     e95:	d9 55 9c             	fsts   0xffffff9c(%ebp)
     e98:	0f 85 c2 fa ff ff    	jne    960 <kb_x86_mix+0x1f0>
     e9e:	8b 8d 10 ff ff ff    	mov    0xffffff10(%ebp),%ecx
     ea4:	b8 00 00 00 00       	mov    $0x0,%eax
     ea9:	89 45 a0             	mov    %eax,0xffffffa0(%ebp)
     eac:	89 45 a4             	mov    %eax,0xffffffa4(%ebp)
     eaf:	8b 41 44             	mov    0x44(%ecx),%eax
     eb2:	89 45 ac             	mov    %eax,0xffffffac(%ebp)
     eb5:	8b 59 1c             	mov    0x1c(%ecx),%ebx
     eb8:	89 9d 1c ff ff ff    	mov    %ebx,0xffffff1c(%ebp)
     ebe:	4b                   	dec    %ebx
     ebf:	0f 85 c9 fa ff ff    	jne    98e <kb_x86_mix+0x21e>
     ec5:	8b 41 48             	mov    0x48(%ecx),%eax
     ec8:	89 45 b0             	mov    %eax,0xffffffb0(%ebp)
     ecb:	8b 41 4c             	mov    0x4c(%ecx),%eax
     ece:	89 45 b4             	mov    %eax,0xffffffb4(%ebp)
     ed1:	e9 d1 fa ff ff       	jmp    9a7 <kb_x86_mix+0x237>
     ed6:	dd da                	fstp   %st(2)
     ed8:	c7 45 d8 08 00 00 00 	movl   $0x8,0xffffffd8(%ebp)
     edf:	e9 24 fb ff ff       	jmp    a08 <kb_x86_mix+0x298>
     ee4:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     eea:	8b 5b 0c             	mov    0xc(%ebx),%ebx
     eed:	89 9d 44 ff ff ff    	mov    %ebx,0xffffff44(%ebp)
     ef3:	e9 78 ff ff ff       	jmp    e70 <kb_x86_mix+0x700>
     ef8:	d9 ca                	fxch   %st(2)
     efa:	d9 c9                	fxch   %st(1)
     efc:	d9 cb                	fxch   %st(3)
     efe:	d9 c9                	fxch   %st(1)
     f00:	e9 db fd ff ff       	jmp    ce0 <kb_x86_mix+0x570>
     f05:	8b bd 10 ff ff ff    	mov    0xffffff10(%ebp),%edi
     f0b:	89 57 2c             	mov    %edx,0x2c(%edi)
     f0e:	e9 b7 f9 ff ff       	jmp    8ca <kb_x86_mix+0x15a>
     f13:	dd d8                	fstp   %st(0)
     f15:	dd d8                	fstp   %st(0)
     f17:	dd d8                	fstp   %st(0)
     f19:	dd d8                	fstp   %st(0)
     f1b:	a1 00 00 00 00       	mov    0x0,%eax
     f20:	85 c0                	test   %eax,%eax
     f22:	0f 84 8d f8 ff ff    	je     7b5 <kb_x86_mix+0x45>
     f28:	8b 8d 10 ff ff ff    	mov    0xffffff10(%ebp),%ecx
     f2e:	83 ec 0c             	sub    $0xc,%esp
     f31:	8b 01                	mov    (%ecx),%eax
     f33:	8b 40 14             	mov    0x14(%eax),%eax
     f36:	50                   	push   %eax
     f37:	ff 15 0c 00 00 00    	call   *0xc
     f3d:	83 c4 10             	add    $0x10,%esp
     f40:	e9 70 f8 ff ff       	jmp    7b5 <kb_x86_mix+0x45>
     f45:	8b 85 44 ff ff ff    	mov    0xffffff44(%ebp),%eax
     f4b:	83 e8 03             	sub    $0x3,%eax
     f4e:	3b 85 14 ff ff ff    	cmp    0xffffff14(%ebp),%eax
     f54:	0f 8f ee fa ff ff    	jg     a48 <kb_x86_mix+0x2d8>
     f5a:	8b 85 60 ff ff ff    	mov    0xffffff60(%ebp),%eax
     f60:	85 c0                	test   %eax,%eax
     f62:	0f 84 89 03 00 00    	je     12f1 <kb_x86_mix+0xb81>
     f68:	8b 9d 10 ff ff ff    	mov    0xffffff10(%ebp),%ebx
     f6e:	31 d2                	xor    %edx,%edx
     f70:	31 c9                	xor    %ecx,%ecx
     f72:	8b 73 40             	mov    0x40(%ebx),%esi
     f75:	8b 43 44             	mov    0x44(%ebx),%eax
     f78:	89 f7                	mov    %esi,%edi
     f7a:	31 f6                	xor    %esi,%esi
     f7c:	01 c6                	add    %eax,%esi
     f7e:	11 d7                	adc    %edx,%edi
     f80:	8b 95 18 ff ff ff    	mov    0xffffff18(%ebp),%edx
     f86:	8b 42 0c             	mov    0xc(%edx),%eax
     f89:	89 c2                	mov    %eax,%edx
     f8b:	31 c0                	xor    %eax,%eax
     f8d:	89 85 28 ff ff ff    	mov    %eax,0xffffff28(%ebp)
     f93:	89 95 2c ff ff ff    	mov    %edx,0xffffff2c(%ebp)
     f99:	83 85 28 ff ff ff ff 	addl   $0xffffffff,0xffffff28(%ebp)
     fa0:	83 95 2c ff ff ff ff 	adcl   $0xffffffff,0xffffff2c(%ebp)
     fa7:	83 cb ff             	or     $0xffffffff,%ebx
     faa:	eb 5a                	jmp    1006 <kb_x86_mix+0x896>
     fac:	8d 74 26 00          	lea    0x0(%esi),%esi
     fb0:	2b b5 28 ff ff ff    	sub    0xffffff28(%ebp),%esi
     fb6:	8b 8d 10 ff ff ff    	mov    0xffffff10(%ebp),%ecx
     fbc:	89 f0                	mov    %esi,%eax
     fbe:	c7 41 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%ecx)
     fc5:	1b bd 2c ff ff ff    	sbb    0xffffff2c(%ebp),%edi
     fcb:	c7 85 1c ff ff ff ff 	movl   $0xffffffff,0xffffff1c(%ebp)
     fd2:	ff ff ff 
     fd5:	f7 e3                	mul    %ebx
     fd7:	89 d1                	mov    %edx,%ecx
     fd9:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
     fdf:	29 f1                	sub    %esi,%ecx
     fe1:	8b b5 28 ff ff ff    	mov    0xffffff28(%ebp),%esi
     fe7:	29 f9                	sub    %edi,%ecx
     fe9:	03 b5 f8 fe ff ff    	add    0xfffffef8(%ebp),%esi
     fef:	89 8d fc fe ff ff    	mov    %ecx,0xfffffefc(%ebp)
     ff5:	8b bd 2c ff ff ff    	mov    0xffffff2c(%ebp),%edi
     ffb:	13 bd fc fe ff ff    	adc    0xfffffefc(%ebp),%edi
    1001:	b9 01 00 00 00       	mov    $0x1,%ecx
    1006:	83 bd 1c ff ff ff 01 	cmpl   $0x1,0xffffff1c(%ebp)
    100d:	0f 94 c0             	sete   %al
    1010:	25 ff 00 00 00       	and    $0xff,%eax
    1015:	ba 01 00 00 00       	mov    $0x1,%edx
    101a:	3b bd 2c ff ff ff    	cmp    0xffffff2c(%ebp),%edi
    1020:	7f 12                	jg     1034 <kb_x86_mix+0x8c4>
    1022:	0f 8c 8e 00 00 00    	jl     10b6 <kb_x86_mix+0x946>
    1028:	3b b5 28 ff ff ff    	cmp    0xffffff28(%ebp),%esi
    102e:	0f 82 82 00 00 00    	jb     10b6 <kb_x86_mix+0x946>
    1034:	85 c2                	test   %eax,%edx
    1036:	0f 85 74 ff ff ff    	jne    fb0 <kb_x86_mix+0x840>
    103c:	83 bd 1c ff ff ff ff 	cmpl   $0xffffffff,0xffffff1c(%ebp)
    1043:	0f 94 c0             	sete   %al
    1046:	25 ff 00 00 00       	and    $0xff,%eax
    104b:	ba 01 00 00 00       	mov    $0x1,%edx
    1050:	3b bd 5c ff ff ff    	cmp    0xffffff5c(%ebp),%edi
    1056:	7c 0a                	jl     1062 <kb_x86_mix+0x8f2>
    1058:	7f 66                	jg     10c0 <kb_x86_mix+0x950>
    105a:	3b b5 58 ff ff ff    	cmp    0xffffff58(%ebp),%esi
    1060:	73 5e                	jae    10c0 <kb_x86_mix+0x950>
    1062:	85 c2                	test   %eax,%edx
    1064:	74 60                	je     10c6 <kb_x86_mix+0x956>
    1066:	2b b5 58 ff ff ff    	sub    0xffffff58(%ebp),%esi
    106c:	8b 95 10 ff ff ff    	mov    0xffffff10(%ebp),%edx
    1072:	89 f0                	mov    %esi,%eax
    1074:	c7 42 1c 01 00 00 00 	movl   $0x1,0x1c(%edx)
    107b:	1b bd 5c ff ff ff    	sbb    0xffffff5c(%ebp),%edi
    1081:	c7 85 1c ff ff ff 01 	movl   $0x1,0xffffff1c(%ebp)
    1088:	00 00 00 
    108b:	f7 e3                	mul    %ebx
    108d:	89 d1                	mov    %edx,%ecx
    108f:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
    1095:	29 f1                	sub    %esi,%ecx
    1097:	8b b5 58 ff ff ff    	mov    0xffffff58(%ebp),%esi
    109d:	29 f9                	sub    %edi,%ecx
    109f:	03 b5 f8 fe ff ff    	add    0xfffffef8(%ebp),%esi
    10a5:	89 8d fc fe ff ff    	mov    %ecx,0xfffffefc(%ebp)
    10ab:	8b bd 5c ff ff ff    	mov    0xffffff5c(%ebp),%edi
    10b1:	e9 45 ff ff ff       	jmp    ffb <kb_x86_mix+0x88b>
    10b6:	31 d2                	xor    %edx,%edx
    10b8:	e9 77 ff ff ff       	jmp    1034 <kb_x86_mix+0x8c4>
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
    10c0:	31 d2                	xor    %edx,%edx
    10c2:	85 c2                	test   %eax,%edx
    10c4:	75 a0                	jne    1066 <kb_x86_mix+0x8f6>
    10c6:	85 c9                	test   %ecx,%ecx
    10c8:	0f 84 79 02 00 00    	je     1347 <kb_x86_mix+0xbd7>
    10ce:	d9 ca                	fxch   %st(2)
    10d0:	d9 cb                	fxch   %st(3)
    10d2:	d9 c9                	fxch   %st(1)
    10d4:	8b 95 10 ff ff ff    	mov    0xffffff10(%ebp),%edx
    10da:	89 72 44             	mov    %esi,0x44(%edx)
    10dd:	89 7a 40             	mov    %edi,0x40(%edx)
    10e0:	31 d2                	xor    %edx,%edx
    10e2:	e9 96 fb ff ff       	jmp    c7d <kb_x86_mix+0x50d>
    10e7:	8b 95 18 ff ff ff    	mov    0xffffff18(%ebp),%edx
    10ed:	8b 42 08             	mov    0x8(%edx),%eax
    10f0:	83 c0 03             	add    $0x3,%eax
    10f3:	3b 85 14 ff ff ff    	cmp    0xffffff14(%ebp),%eax
    10f9:	0f 8f 5b fe ff ff    	jg     f5a <kb_x86_mix+0x7ea>
    10ff:	dd d8                	fstp   %st(0)
    1101:	dd d8                	fstp   %st(0)
    1103:	dd d8                	fstp   %st(0)
    1105:	dd d8                	fstp   %st(0)
    1107:	e9 51 f9 ff ff       	jmp    a5d <kb_x86_mix+0x2ed>
    110c:	8b 8d 68 ff ff ff    	mov    0xffffff68(%ebp),%ecx
    1112:	8b 85 50 ff ff ff    	mov    0xffffff50(%ebp),%eax
    1118:	f7 e1                	mul    %ecx
    111a:	8b bd 54 ff ff ff    	mov    0xffffff54(%ebp),%edi
    1120:	31 db                	xor    %ebx,%ebx
    1122:	0f af f9             	imul   %ecx,%edi
    1125:	8b 8d 50 ff ff ff    	mov    0xffffff50(%ebp),%ecx
    112b:	89 d6                	mov    %edx,%esi
    112d:	0f af cb             	imul   %ebx,%ecx
    1130:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
    1136:	01 fe                	add    %edi,%esi
    1138:	8b 95 48 ff ff ff    	mov    0xffffff48(%ebp),%edx
    113e:	01 ce                	add    %ecx,%esi
    1140:	01 95 f8 fe ff ff    	add    %edx,0xfffffef8(%ebp)
    1146:	89 b5 fc fe ff ff    	mov    %esi,0xfffffefc(%ebp)
    114c:	8b 8d 4c ff ff ff    	mov    0xffffff4c(%ebp),%ecx
    1152:	8b 85 44 ff ff ff    	mov    0xffffff44(%ebp),%eax
    1158:	11 8d fc fe ff ff    	adc    %ecx,0xfffffefc(%ebp)
    115e:	83 e8 03             	sub    $0x3,%eax
    1161:	8b 9d fc fe ff ff    	mov    0xfffffefc(%ebp),%ebx
    1167:	89 d9                	mov    %ebx,%ecx
    1169:	8b 9d 68 ff ff ff    	mov    0xffffff68(%ebp),%ebx
    116f:	89 9d 34 ff ff ff    	mov    %ebx,0xffffff34(%ebp)
    1175:	39 c8                	cmp    %ecx,%eax
    1177:	0f 87 4f 01 00 00    	ja     12cc <kb_x86_mix+0xb5c>
    117d:	8b 85 38 ff ff ff    	mov    0xffffff38(%ebp),%eax
    1183:	8b 95 3c ff ff ff    	mov    0xffffff3c(%ebp),%edx
    1189:	2b 85 48 ff ff ff    	sub    0xffffff48(%ebp),%eax
    118f:	8b 8d 54 ff ff ff    	mov    0xffffff54(%ebp),%ecx
    1195:	1b 95 4c ff ff ff    	sbb    0xffffff4c(%ebp),%edx
    119b:	03 85 50 ff ff ff    	add    0xffffff50(%ebp),%eax
    11a1:	13 95 54 ff ff ff    	adc    0xffffff54(%ebp),%edx
    11a7:	83 c0 ff             	add    $0xffffffff,%eax
    11aa:	83 d2 fc             	adc    $0xfffffffc,%edx
    11ad:	8b bd 50 ff ff ff    	mov    0xffffff50(%ebp),%edi
    11b3:	51                   	push   %ecx
    11b4:	57                   	push   %edi
    11b5:	52                   	push   %edx
    11b6:	50                   	push   %eax
    11b7:	e8 fc ff ff ff       	call   11b8 <kb_x86_mix+0xa48>
    11bc:	83 c4 10             	add    $0x10,%esp
    11bf:	85 c0                	test   %eax,%eax
    11c1:	89 85 34 ff ff ff    	mov    %eax,0xffffff34(%ebp)
    11c7:	0f 8e 7d 04 00 00    	jle    164a <kb_x86_mix+0xeda>
    11cd:	8b b5 34 ff ff ff    	mov    0xffffff34(%ebp),%esi
    11d3:	8b 85 50 ff ff ff    	mov    0xffffff50(%ebp),%eax
    11d9:	89 f7                	mov    %esi,%edi
    11db:	8b 8d 50 ff ff ff    	mov    0xffffff50(%ebp),%ecx
    11e1:	c1 ff 1f             	sar    $0x1f,%edi
    11e4:	f7 e6                	mul    %esi
    11e6:	89 fb                	mov    %edi,%ebx
    11e8:	8b bd 54 ff ff ff    	mov    0xffffff54(%ebp),%edi
    11ee:	0f af fe             	imul   %esi,%edi
    11f1:	0f af cb             	imul   %ebx,%ecx
    11f4:	89 d6                	mov    %edx,%esi
    11f6:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
    11fc:	01 fe                	add    %edi,%esi
    11fe:	8b 85 f8 fe ff ff    	mov    0xfffffef8(%ebp),%eax
    1204:	01 ce                	add    %ecx,%esi
    1206:	03 85 48 ff ff ff    	add    0xffffff48(%ebp),%eax
    120c:	89 b5 fc fe ff ff    	mov    %esi,0xfffffefc(%ebp)
    1212:	8b b5 38 ff ff ff    	mov    0xffffff38(%ebp),%esi
    1218:	8b 95 fc fe ff ff    	mov    0xfffffefc(%ebp),%edx
    121e:	8b bd 3c ff ff ff    	mov    0xffffff3c(%ebp),%edi
    1224:	13 95 4c ff ff ff    	adc    0xffffff4c(%ebp),%edx
    122a:	83 ee 00             	sub    $0x0,%esi
    122d:	83 df 03             	sbb    $0x3,%edi
    1230:	39 fa                	cmp    %edi,%edx
    1232:	0f 82 fe 03 00 00    	jb     1636 <kb_x86_mix+0xec6>
    1238:	77 08                	ja     1242 <kb_x86_mix+0xad2>
    123a:	39 f0                	cmp    %esi,%eax
    123c:	0f 82 f4 03 00 00    	jb     1636 <kb_x86_mix+0xec6>
    1242:	8b 85 34 ff ff ff    	mov    0xffffff34(%ebp),%eax
    1248:	8b bd 54 ff ff ff    	mov    0xffffff54(%ebp),%edi
    124e:	48                   	dec    %eax
    124f:	89 c1                	mov    %eax,%ecx
    1251:	89 c3                	mov    %eax,%ebx
    1253:	8b 85 50 ff ff ff    	mov    0xffffff50(%ebp),%eax
    1259:	f7 e1                	mul    %ecx
    125b:	0f af f9             	imul   %ecx,%edi
    125e:	c1 fb 1f             	sar    $0x1f,%ebx
    1261:	8b 8d 50 ff ff ff    	mov    0xffffff50(%ebp),%ecx
    1267:	0f af cb             	imul   %ebx,%ecx
    126a:	89 d6                	mov    %edx,%esi
    126c:	89 85 f8 fe ff ff    	mov    %eax,0xfffffef8(%ebp)
    1272:	01 fe                	add    %edi,%esi
    1274:	8b 85 38 ff ff ff    	mov    0xffffff38(%ebp),%eax
    127a:	01 ce                	add    %ecx,%esi
    127c:	8b bd 4c ff ff ff    	mov    0xffffff4c(%ebp),%edi
    1282:	89 b5 fc fe ff ff    	mov    %esi,0xfffffefc(%ebp)
    1288:	8b b5 48 ff ff ff    	mov    0xffffff48(%ebp),%esi
    128e:	03 b5 f8 fe ff ff    	add    0xfffffef8(%ebp),%esi
    1294:	8b 95 3c ff ff ff    	mov    0xffffff3c(%ebp),%edx
    129a:	13 bd fc fe ff ff    	adc    0xfffffefc(%ebp),%edi
    12a0:	83 e8 00             	sub    $0x0,%eax
    12a3:	83 da 03             	sbb    $0x3,%edx
    12a6:	39 d7                	cmp    %edx,%edi
    12a8:	0f 87 74 03 00 00    	ja     1622 <kb_x86_mix+0xeb2>
    12ae:	72 08                	jb     12b8 <kb_x86_mix+0xb48>
    12b0:	39 c6                	cmp    %eax,%esi
    12b2:	0f 83 6a 03 00 00    	jae    1622 <kb_x86_mix+0xeb2>
    12b8:	8b 95 68 ff ff ff    	mov    0xffffff68(%ebp),%edx
    12be:	39 95 34 ff ff ff    	cmp    %edx,0xffffff34(%ebp)
    12c4:	76 06                	jbe    12cc <kb_x86_mix+0xb5c>
    12c6:	89 95 34 ff ff ff    	mov    %edx,0xffffff34(%ebp)
    12cc:	8b 8d 18 ff ff ff    	mov    0xffffff18(%ebp),%ecx
    12d2:	8b 9d 14 ff ff ff    	mov    0xffffff14(%ebp),%ebx
    12d8:	83 ec 0c             	sub    $0xc,%esp
    12db:	8b b5 34 ff ff ff    	mov    0xffffff34(%ebp),%esi
    12e1:	8b 41 10             	mov    0x10(%ecx),%eax
    12e4:	89 75 bc             	mov    %esi,0xffffffbc(%ebp)
    12e7:	6a 01                	push   $0x1
    12e9:	8d 04 58             	lea    (%eax,%ebx,2),%eax
    12ec:	e9 3f f9 ff ff       	jmp    c30 <kb_x86_mix+0x4c0>
    12f1:	8b 85 64 ff ff ff    	mov    0xffffff64(%ebp),%eax
    12f7:	85 c0                	test   %eax,%eax
    12f9:	0f 84 98 01 00 00    	je     1497 <kb_x86_mix+0xd27>
    12ff:	8b 8d 18 ff ff ff    	mov    0xffffff18(%ebp),%ecx
    1305:	8b 9d 18 ff ff ff    	mov    0xffffff18(%ebp),%ebx
    130b:	8b 95 14 ff ff ff    	mov    0xffffff14(%ebp),%edx
    1311:	8b 41 0c             	mov    0xc(%ecx),%eax
    1314:	8b 7b 08             	mov    0x8(%ebx),%edi
    1317:	89 c1                	mov    %eax,%ecx
    1319:	29 f9                	sub    %edi,%ecx
    131b:	39 c2                	cmp    %eax,%edx
    131d:	72 28                	jb     1347 <kb_x86_mix+0xbd7>
    131f:	90                   	nop    
    1320:	89 d0                	mov    %edx,%eax
    1322:	8b b5 10 ff ff ff    	mov    0xffffff10(%ebp),%esi
    1328:	29 c8                	sub    %ecx,%eax
    132a:	8b bd 18 ff ff ff    	mov    0xffffff18(%ebp),%edi
    1330:	89 46 40             	mov    %eax,0x40(%esi)
    1333:	89 c2                	mov    %eax,%edx
    1335:	3b 47 0c             	cmp    0xc(%edi),%eax
    1338:	73 e6                	jae    1320 <kb_x86_mix+0xbb0>
    133a:	d9 ca                	fxch   %st(2)
    133c:	d9 cb                	fxch   %st(3)
    133e:	d9 c9                	fxch   %st(1)
    1340:	31 d2                	xor    %edx,%edx
    1342:	e9 36 f9 ff ff       	jmp    c7d <kb_x86_mix+0x50d>
    1347:	dd d8                	fstp   %st(0)
    1349:	dd d8                	fstp   %st(0)
    134b:	dd d8                	fstp   %st(0)
    134d:	dd d8                	fstp   %st(0)
    134f:	8b 8d 64 ff ff ff    	mov    0xffffff64(%ebp),%ecx
    1355:	0b 8d 60 ff ff ff    	or     0xffffff60(%ebp),%ecx
    135b:	74 15                	je     1372 <kb_x86_mix+0xc02>
    135d:	8b b5 18 ff ff ff    	mov    0xffffff18(%ebp),%esi
    1363:	8b 9d 14 ff ff ff    	mov    0xffffff14(%ebp),%ebx
    1369:	3b 5e 0c             	cmp    0xc(%esi),%ebx
    136c:	0f 83 ef 02 00 00    	jae    1661 <kb_x86_mix+0xef1>
    1372:	8b b5 60 ff ff ff    	mov    0xffffff60(%ebp),%esi
    1378:	85 f6                	test   %esi,%esi
    137a:	0f 84 46 01 00 00    	je     14c6 <kb_x86_mix+0xd56>
    1380:	8b b5 1c ff ff ff    	mov    0xffffff1c(%ebp),%esi
    1386:	8d 7d 90             	lea    0xffffff90(%ebp),%edi
    1389:	83 fe ff             	cmp    $0xffffffff,%esi
    138c:	0f 84 fc 01 00 00    	je     158e <kb_x86_mix+0xe1e>
    1392:	8b 85 18 ff ff ff    	mov    0xffffff18(%ebp),%eax
    1398:	8b 8d 1c ff ff ff    	mov    0xffffff1c(%ebp),%ecx
    139e:	01 c9                	add    %ecx,%ecx
    13a0:	8b 95 14 ff ff ff    	mov    0xffffff14(%ebp),%edx
    13a6:	8b 40 10             	mov    0x10(%eax),%eax
    13a9:	89 8d f4 fe ff ff    	mov    %ecx,0xfffffef4(%ebp)
    13af:	89 85 24 ff ff ff    	mov    %eax,0xffffff24(%ebp)
    13b5:	b9 03 00 00 00       	mov    $0x3,%ecx
    13ba:	8b 9d 24 ff ff ff    	mov    0xffffff24(%ebp),%ebx
    13c0:	83 fe 01             	cmp    $0x1,%esi
    13c3:	66 8b 04 53          	mov    (%ebx,%edx,2),%ax
    13c7:	66 89 07             	mov    %ax,(%edi)
    13ca:	0f 84 ae 00 00 00    	je     147e <kb_x86_mix+0xd0e>
    13d0:	8b 9d 18 ff ff ff    	mov    0xffffff18(%ebp),%ebx
    13d6:	4a                   	dec    %edx
    13d7:	3b 53 08             	cmp    0x8(%ebx),%edx
    13da:	7d 06                	jge    13e2 <kb_x86_mix+0xc72>
    13dc:	42                   	inc    %edx
    13dd:	be 01 00 00 00       	mov    $0x1,%esi
    13e2:	8b 9d f4 fe ff ff    	mov    0xfffffef4(%ebp),%ebx
    13e8:	01 df                	add    %ebx,%edi
    13ea:	49                   	dec    %ecx
    13eb:	79 cd                	jns    13ba <kb_x86_mix+0xc4a>
    13ed:	c7 45 bc 01 00 00 00 	movl   $0x1,0xffffffbc(%ebp)
    13f4:	83 bd 1c ff ff ff 01 	cmpl   $0x1,0xffffff1c(%ebp)
    13fb:	0f 84 1e 01 00 00    	je     151f <kb_x86_mix+0xdaf>
    1401:	8d 45 90             	lea    0xffffff90(%ebp),%eax
    1404:	83 ec 0c             	sub    $0xc,%esp
    1407:	83 c0 06             	add    $0x6,%eax
    140a:	8d 55 98             	lea    0xffffff98(%ebp),%edx
    140d:	89 45 a8             	mov    %eax,0xffffffa8(%ebp)
    1410:	8b 85 10 ff ff ff    	mov    0xffffff10(%ebp),%eax
    1416:	6a 00                	push   $0x0
    1418:	8d 5d e8             	lea    0xffffffe8(%ebp),%ebx
    141b:	e8 10 f3 ff ff       	call   730 <kb_x86_call_mixer>
    1420:	8b 45 a8             	mov    0xffffffa8(%ebp),%eax
    1423:	29 d8                	sub    %ebx,%eax
    1425:	8b b5 10 ff ff ff    	mov    0xffffff10(%ebp),%esi
    142b:	83 c0 52             	add    $0x52,%eax
    142e:	8b 9d 14 ff ff ff    	mov    0xffffff14(%ebp),%ebx
    1434:	d1 f8                	sar    %eax
    1436:	83 c4 10             	add    $0x10,%esp
    1439:	01 d8                	add    %ebx,%eax
    143b:	89 46 40             	mov    %eax,0x40(%esi)
    143e:	8b bd 10 ff ff ff    	mov    0xffffff10(%ebp),%edi
    1444:	8b 45 ac             	mov    0xffffffac(%ebp),%eax
    1447:	d9 45 98             	flds   0xffffff98(%ebp)
    144a:	ba 01 00 00 00       	mov    $0x1,%edx
    144f:	89 47 44             	mov    %eax,0x44(%edi)
    1452:	d9 57 24             	fsts   0x24(%edi)
    1455:	d9 45 9c             	flds   0xffffff9c(%ebp)
    1458:	d9 57 28             	fsts   0x28(%edi)
    145b:	d9 45 cc             	flds   0xffffffcc(%ebp)
    145e:	d9 57 58             	fsts   0x58(%edi)
    1461:	d9 45 d0             	flds   0xffffffd0(%ebp)
    1464:	d9 57 5c             	fsts   0x5c(%edi)
    1467:	e9 11 f8 ff ff       	jmp    c7d <kb_x86_mix+0x50d>
    146c:	83 ec 0c             	sub    $0xc,%esp
    146f:	50                   	push   %eax
    1470:	ff 15 04 00 00 00    	call   *0x4
    1476:	83 c4 10             	add    $0x10,%esp
    1479:	e9 ae f4 ff ff       	jmp    92c <kb_x86_mix+0x1bc>
    147e:	8b 85 18 ff ff ff    	mov    0xffffff18(%ebp),%eax
    1484:	42                   	inc    %edx
    1485:	3b 50 0c             	cmp    0xc(%eax),%edx
    1488:	0f 82 54 ff ff ff    	jb     13e2 <kb_x86_mix+0xc72>
    148e:	83 ce ff             	or     $0xffffffff,%esi
    1491:	4a                   	dec    %edx
    1492:	e9 4b ff ff ff       	jmp    13e2 <kb_x86_mix+0xc72>
    1497:	8b 85 44 ff ff ff    	mov    0xffffff44(%ebp),%eax
    149d:	39 85 14 ff ff ff    	cmp    %eax,0xffffff14(%ebp)
    14a3:	0f 82 9e fe ff ff    	jb     1347 <kb_x86_mix+0xbd7>
    14a9:	d9 ca                	fxch   %st(2)
    14ab:	d9 cb                	fxch   %st(3)
    14ad:	d9 c9                	fxch   %st(1)
    14af:	8b 95 10 ff ff ff    	mov    0xffffff10(%ebp),%edx
    14b5:	83 e6 10             	and    $0x10,%esi
    14b8:	89 72 10             	mov    %esi,0x10(%edx)
    14bb:	8b 95 68 ff ff ff    	mov    0xffffff68(%ebp),%edx
    14c1:	e9 b7 f7 ff ff       	jmp    c7d <kb_x86_mix+0x50d>
    14c6:	8b b5 18 ff ff ff    	mov    0xffffff18(%ebp),%esi
    14cc:	8b 95 14 ff ff ff    	mov    0xffffff14(%ebp),%edx
    14d2:	b9 03 00 00 00       	mov    $0x3,%ecx
    14d7:	8b 5e 10             	mov    0x10(%esi),%ebx
    14da:	8d 75 90             	lea    0xffffff90(%ebp),%esi
    14dd:	66 8b 04 53          	mov    (%ebx,%edx,2),%ax
    14e1:	42                   	inc    %edx
    14e2:	66 89 06             	mov    %ax,(%esi)
    14e5:	3b 95 44 ff ff ff    	cmp    0xffffff44(%ebp),%edx
    14eb:	7c 18                	jl     1505 <kb_x86_mix+0xd95>
    14ed:	8b 85 64 ff ff ff    	mov    0xffffff64(%ebp),%eax
    14f3:	85 c0                	test   %eax,%eax
    14f5:	74 64                	je     155b <kb_x86_mix+0xdeb>
    14f7:	8b bd 18 ff ff ff    	mov    0xffffff18(%ebp),%edi
    14fd:	8b 47 0c             	mov    0xc(%edi),%eax
    1500:	2b 47 08             	sub    0x8(%edi),%eax
    1503:	29 c2                	sub    %eax,%edx
    1505:	83 c6 02             	add    $0x2,%esi
    1508:	49                   	dec    %ecx
    1509:	79 d2                	jns    14dd <kb_x86_mix+0xd6d>
    150b:	c7 45 bc 01 00 00 00 	movl   $0x1,0xffffffbc(%ebp)
    1512:	83 bd 1c ff ff ff 01 	cmpl   $0x1,0xffffff1c(%ebp)
    1519:	0f 85 e2 fe ff ff    	jne    1401 <kb_x86_mix+0xc91>
    151f:	83 ec 0c             	sub    $0xc,%esp
    1522:	8d 45 90             	lea    0xffffff90(%ebp),%eax
    1525:	89 45 a8             	mov    %eax,0xffffffa8(%ebp)
    1528:	8d 55 98             	lea    0xffffff98(%ebp),%edx
    152b:	8b 85 10 ff ff ff    	mov    0xffffff10(%ebp),%eax
    1531:	6a 01                	push   $0x1
    1533:	e8 f8 f1 ff ff       	call   730 <kb_x86_call_mixer>
    1538:	8b 45 a8             	mov    0xffffffa8(%ebp),%eax
    153b:	8d 55 90             	lea    0xffffff90(%ebp),%edx
    153e:	8b b5 14 ff ff ff    	mov    0xffffff14(%ebp),%esi
    1544:	29 d0                	sub    %edx,%eax
    1546:	8b 8d 10 ff ff ff    	mov    0xffffff10(%ebp),%ecx
    154c:	d1 f8                	sar    %eax
    154e:	83 c4 10             	add    $0x10,%esp
    1551:	01 f0                	add    %esi,%eax
    1553:	89 41 40             	mov    %eax,0x40(%ecx)
    1556:	e9 e3 fe ff ff       	jmp    143e <kb_x86_mix+0xcce>
    155b:	4a                   	dec    %edx
    155c:	eb a7                	jmp    1505 <kb_x86_mix+0xd95>
    155e:	8b 1d 60 00 00 00    	mov    0x60,%ebx
    1564:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1567:	8b 55 08             	mov    0x8(%ebp),%edx
    156a:	a1 00 00 00 00       	mov    0x0,%eax
    156f:	53                   	push   %ebx
    1570:	51                   	push   %ecx
    1571:	52                   	push   %edx
    1572:	50                   	push   %eax
    1573:	e8 fc ff ff ff       	call   1574 <kb_x86_mix+0xe04>
    1578:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    157b:	8b 75 08             	mov    0x8(%ebp),%esi
    157e:	a3 10 00 00 00       	mov    %eax,0x10
    1583:	8d 65 f4             	lea    0xfffffff4(%ebp),%esp
    1586:	8d 04 9e             	lea    (%esi,%ebx,4),%eax
    1589:	5b                   	pop    %ebx
    158a:	5e                   	pop    %esi
    158b:	5f                   	pop    %edi
    158c:	5d                   	pop    %ebp
    158d:	c3                   	ret    
    158e:	8d 7d 96             	lea    0xffffff96(%ebp),%edi
    1591:	e9 fc fd ff ff       	jmp    1392 <kb_x86_mix+0xc22>
    1596:	83 ec 0c             	sub    $0xc,%esp
    1599:	8b 35 00 00 00 00    	mov    0x0,%esi
    159f:	56                   	push   %esi
    15a0:	e8 fc ff ff ff       	call   15a1 <kb_x86_mix+0xe31>
    15a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    15a8:	89 d0                	mov    %edx,%eax
    15aa:	89 15 04 00 00 00    	mov    %edx,0x4
    15b0:	c1 e0 03             	shl    $0x3,%eax
    15b3:	89 04 24             	mov    %eax,(%esp)
    15b6:	e8 fc ff ff ff       	call   15b7 <kb_x86_mix+0xe47>
    15bb:	83 c4 10             	add    $0x10,%esp
    15be:	a3 00 00 00 00       	mov    %eax,0x0
    15c3:	e9 c3 f1 ff ff       	jmp    78b <kb_x86_mix+0x1b>
    15c8:	83 ec 0c             	sub    $0xc,%esp
    15cb:	68 bc 00 00 00       	push   $0xbc
    15d0:	68 56 00 00 00       	push   $0x56
    15d5:	68 9d 02 00 00       	push   $0x29d
    15da:	68 1a 00 00 00       	push   $0x1a
    15df:	6a 00                	push   $0x0
    15e1:	e8 fc ff ff ff       	call   15e2 <kb_x86_mix+0xe72>
    15e6:	83 ec 0c             	sub    $0xc,%esp
    15e9:	68 28 01 00 00       	push   $0x128
    15ee:	68 56 00 00 00       	push   $0x56
    15f3:	68 9e 02 00 00       	push   $0x29e
    15f8:	eb e0                	jmp    15da <kb_x86_mix+0xe6a>
    15fa:	83 ec 0c             	sub    $0xc,%esp
    15fd:	68 53 00 00 00       	push   $0x53
    1602:	68 4b 00 00 00       	push   $0x4b
    1607:	68 e7 02 00 00       	push   $0x2e7
    160c:	eb cc                	jmp    15da <kb_x86_mix+0xe6a>
    160e:	83 ec 0c             	sub    $0xc,%esp
    1611:	68 64 00 00 00       	push   $0x64
    1616:	68 56 00 00 00       	push   $0x56
    161b:	68 9c 02 00 00       	push   $0x29c
    1620:	eb b8                	jmp    15da <kb_x86_mix+0xe6a>
    1622:	83 ec 0c             	sub    $0xc,%esp
    1625:	68 98 01 00 00       	push   $0x198
    162a:	68 56 00 00 00       	push   $0x56
    162f:	68 8a 02 00 00       	push   $0x28a
    1634:	eb a4                	jmp    15da <kb_x86_mix+0xe6a>
    1636:	83 ec 0c             	sub    $0xc,%esp
    1639:	68 f0 01 00 00       	push   $0x1f0
    163e:	68 56 00 00 00       	push   $0x56
    1643:	68 89 02 00 00       	push   $0x289
    1648:	eb 90                	jmp    15da <kb_x86_mix+0xe6a>
    164a:	83 ec 0c             	sub    $0xc,%esp
    164d:	68 64 00 00 00       	push   $0x64
    1652:	68 56 00 00 00       	push   $0x56
    1657:	68 88 02 00 00       	push   $0x288
    165c:	e9 79 ff ff ff       	jmp    15da <kb_x86_mix+0xe6a>
    1661:	83 ec 0c             	sub    $0xc,%esp
    1664:	68 74 00 00 00       	push   $0x74
    1669:	68 56 00 00 00       	push   $0x56
    166e:	68 3b 02 00 00       	push   $0x23b
    1673:	e9 62 ff ff ff       	jmp    15da <kb_x86_mix+0xe6a>
    1678:	90                   	nop    
    1679:	8d b4 26 00 00 00 00 	lea    0x0(%esi),%esi

00001680 <kb_x86_dumpstatus>:
    1680:	55                   	push   %ebp
    1681:	89 e5                	mov    %esp,%ebp
    1683:	56                   	push   %esi
    1684:	53                   	push   %ebx
    1685:	31 db                	xor    %ebx,%ebx
    1687:	8b 75 08             	mov    0x8(%ebp),%esi
    168a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1690:	89 d8                	mov    %ebx,%eax
    1692:	e8 a9 e9 ff ff       	call   40 <kb_x86_get_channel_struct>
    1697:	89 c2                	mov    %eax,%edx
    1699:	f6 40 10 04          	testb  $0x4,0x10(%eax)
    169d:	74 26                	je     16c5 <kb_x86_dumpstatus+0x45>
    169f:	8b 00                	mov    (%eax),%eax
    16a1:	8b 4a 40             	mov    0x40(%edx),%ecx
    16a4:	89 04 de             	mov    %eax,(%esi,%ebx,8)
    16a7:	85 c9                	test   %ecx,%ecx
    16a9:	78 25                	js     16d0 <kb_x86_dumpstatus+0x50>
    16ab:	8b 02                	mov    (%edx),%eax
    16ad:	8b 40 04             	mov    0x4(%eax),%eax
    16b0:	39 c1                	cmp    %eax,%ecx
    16b2:	72 03                	jb     16b7 <kb_x86_dumpstatus+0x37>
    16b4:	8d 48 ff             	lea    0xffffffff(%eax),%ecx
    16b7:	89 4c de 04          	mov    %ecx,0x4(%esi,%ebx,8)
    16bb:	43                   	inc    %ebx
    16bc:	83 fb 1f             	cmp    $0x1f,%ebx
    16bf:	7e cf                	jle    1690 <kb_x86_dumpstatus+0x10>
    16c1:	5b                   	pop    %ebx
    16c2:	5e                   	pop    %esi
    16c3:	5d                   	pop    %ebp
    16c4:	c3                   	ret    
    16c5:	c7 04 de 00 00 00 00 	movl   $0x0,(%esi,%ebx,8)
    16cc:	eb ed                	jmp    16bb <kb_x86_dumpstatus+0x3b>
    16ce:	89 f6                	mov    %esi,%esi
    16d0:	31 c9                	xor    %ecx,%ecx
    16d2:	eb e3                	jmp    16b7 <kb_x86_dumpstatus+0x37>
    16d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    16da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000016e0 <kb_x86_loadchsettings>:
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	56                   	push   %esi
    16e4:	53                   	push   %ebx
    16e5:	8b 75 08             	mov    0x8(%ebp),%esi
    16e8:	3b 35 08 00 00 00    	cmp    0x8,%esi
    16ee:	7c 20                	jl     1710 <kb_x86_loadchsettings+0x30>
    16f0:	83 ec 0c             	sub    $0xc,%esp
    16f3:	68 8e 00 00 00       	push   $0x8e
    16f8:	68 65 00 00 00       	push   $0x65
    16fd:	68 2d 03 00 00       	push   $0x32d
    1702:	68 1a 00 00 00       	push   $0x1a
    1707:	6a 00                	push   $0x0
    1709:	e8 fc ff ff ff       	call   170a <kb_x86_loadchsettings+0x2a>
    170e:	89 f6                	mov    %esi,%esi
    1710:	83 ec 0c             	sub    $0xc,%esp
    1713:	56                   	push   %esi
    1714:	e8 fc ff ff ff       	call   1715 <kb_x86_loadchsettings+0x35>
    1719:	89 c3                	mov    %eax,%ebx
    171b:	89 f0                	mov    %esi,%eax
    171d:	e8 1e e9 ff ff       	call   40 <kb_x86_get_channel_struct>
    1722:	83 c4 10             	add    $0x10,%esp
    1725:	89 c2                	mov    %eax,%edx
    1727:	8b 03                	mov    (%ebx),%eax
    1729:	89 02                	mov    %eax,(%edx)
    172b:	8b 43 04             	mov    0x4(%ebx),%eax
    172e:	89 42 04             	mov    %eax,0x4(%edx)
    1731:	8b 43 08             	mov    0x8(%ebx),%eax
    1734:	89 42 08             	mov    %eax,0x8(%edx)
    1737:	8b 4a 10             	mov    0x10(%edx),%ecx
    173a:	8b 43 0c             	mov    0xc(%ebx),%eax
    173d:	83 e1 10             	and    $0x10,%ecx
    1740:	89 42 0c             	mov    %eax,0xc(%edx)
    1743:	8b 43 14             	mov    0x14(%ebx),%eax
    1746:	89 42 14             	mov    %eax,0x14(%edx)
    1749:	8b 43 18             	mov    0x18(%ebx),%eax
    174c:	89 42 18             	mov    %eax,0x18(%edx)
    174f:	8b 43 1c             	mov    0x1c(%ebx),%eax
    1752:	89 42 1c             	mov    %eax,0x1c(%edx)
    1755:	8b 43 20             	mov    0x20(%ebx),%eax
    1758:	89 42 20             	mov    %eax,0x20(%edx)
    175b:	8b 43 24             	mov    0x24(%ebx),%eax
    175e:	89 42 40             	mov    %eax,0x40(%edx)
    1761:	8b 43 28             	mov    0x28(%ebx),%eax
    1764:	89 42 44             	mov    %eax,0x44(%edx)
    1767:	8b 43 2c             	mov    0x2c(%ebx),%eax
    176a:	89 42 48             	mov    %eax,0x48(%edx)
    176d:	8b 43 30             	mov    0x30(%ebx),%eax
    1770:	89 42 4c             	mov    %eax,0x4c(%edx)
    1773:	8b 43 34             	mov    0x34(%ebx),%eax
    1776:	89 42 50             	mov    %eax,0x50(%edx)
    1779:	8b 43 38             	mov    0x38(%ebx),%eax
    177c:	8b 5b 10             	mov    0x10(%ebx),%ebx
    177f:	89 42 54             	mov    %eax,0x54(%edx)
    1782:	89 d8                	mov    %ebx,%eax
    1784:	83 e0 01             	and    $0x1,%eax
    1787:	09 c1                	or     %eax,%ecx
    1789:	89 c8                	mov    %ecx,%eax
    178b:	83 c8 08             	or     $0x8,%eax
    178e:	f6 c3 02             	test   $0x2,%bl
    1791:	75 1d                	jne    17b0 <kb_x86_loadchsettings+0xd0>
    1793:	83 e3 04             	and    $0x4,%ebx
    1796:	74 03                	je     179b <kb_x86_loadchsettings+0xbb>
    1798:	83 c8 04             	or     $0x4,%eax
    179b:	89 42 10             	mov    %eax,0x10(%edx)
    179e:	8d 65 f8             	lea    0xfffffff8(%ebp),%esp
    17a1:	89 d0                	mov    %edx,%eax
    17a3:	5b                   	pop    %ebx
    17a4:	5e                   	pop    %esi
    17a5:	5d                   	pop    %ebp
    17a6:	e9 15 ed ff ff       	jmp    4c0 <kb_x86_redo_vol_fields>
    17ab:	90                   	nop    
    17ac:	8d 74 26 00          	lea    0x0(%esi),%esi
    17b0:	89 c8                	mov    %ecx,%eax
    17b2:	83 c8 0a             	or     $0xa,%eax
    17b5:	eb dc                	jmp    1793 <kb_x86_loadchsettings+0xb3>
