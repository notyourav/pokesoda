; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   rom7.asm - stuff

	DEFSECT ".rom7", CODE AT 038000H
	SECT ".rom7"
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38000
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38008
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38010
	DB 00h, 00h, 00h, 00h ; 38018
	ASCIZ "33Z[\]^_`a3399bcdefghi99" ; 3801c
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38035
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3803d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38045
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3804d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38055
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3805d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38065
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3806d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38075
	ASCIZ "333456jkl333999:;mnop999" ; 3807c
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38095
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3809d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 380a5
	DB 00h, 00h, 00h, 00h, 7Fh, 80h, 81h, 82h ; 380ad
	DB 83h, 84h, 85h
global pool_0380B8
pool_0380B8:
	DB 00h, 00h, 00h, 00h, 00h
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 380bd
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 380c5
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 380cd
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 380d5
	ASCIZ "33qrstuvw333999xyz{|}~99" ; 380dc
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 380f5
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 380fd
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38105
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3810d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38115
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3811d
	DB 00h, 00h, 00h, 80h, 81h, 82h, 83h, 00h ; 38125
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 84h ; 3812d
	DB 85h, 86h, 87h, 00h, 00h, 00h, 00h, 00h ; 38135
	DB 00h, 00h, 00h, 88h, 89h, 8Ah, 8Bh, 00h ; 3813d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38145
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3814d
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 38155
	DB 00h, 00h, 00h, 2Fh, 2Fh, 2Fh, 2Fh, 8Ch ; 3815d
	DB 8Dh, 8Eh, 8Fh, 2Fh, 2Fh, 2Fh, 2Fh, 00h ; 38165
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3816d
	DB 00h, 00h, 00h, 18h, 18h, 18h, 18h, 18h ; 38175
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 3817d
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 38185
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 3818d
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 38195
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 3819d
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 381a5
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 381ad
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 381b5
	DB 18h, 18h, 18h, 0F4h, 0F4h, 0F4h, 0F4h, 0F0h ; 381bd
	DB 0F1h, 0F2h, 0F3h, 0F4h, 0F4h, 0F4h, 0F4h, 18h ; 381c5
	DB 18h, 18h, 18h, 18h, 18h, 18h, 18h, 18h ; 381cd
	DB 18h, 18h, 18h, 00h, 01h, 01h, 01h, 01h ; 381d5
	DB 01h, 01h, 01h, 01h, 01h, 01h, 06h, 09h ; 381dd
	DB 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch ; 381e5
	DB 0Ch, 0Ch, 09h, 09h ; 381ed
	ASCII "qrs" ; 381f1
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 09h ; 381f4
	DB 09h, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch ; 381fc
	DB 0Ch, 0Ch, 0Ch, 09h, 09h, 08h, 87h, 88h ; 38204
	DB 89h, 8Ah, 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 09h ; 3820c
	DB 09h, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch, 0Ch ; 38214
	DB 0Ch, 0Ch, 0Ch, 09h, 17h, 01h, 01h, 01h ; 3821c
	DB 01h, 01h, 01h, 01h, 01h, 01h, 01h ; 38224
	ASCII "A" ; 3822b
	DB 0Ch, 0Ch, 1Eh, 1Fh ; 3822c
	ASCII "2" ; 38230
	DB 0Ch ; 38231
	ASCII "34F" ; 38232
	DB 0Ch, 0Ch, 0Ch ; 38235
	ASCII "8`" ; 38238
	DB 0CEh ; 3823a
	ASCII "D" ; 3823b
	DB 01h, 0FAh, 0C3h, 0FEh, 0FFh, 0B0h, 0FFh, 0CEh ; 3823c
	ASCII "D" ; 38244
	DB 06h, 0FAh ; 38245
	ASCII "G" ; 38247
	DB 0CEh ; 38248
	ASCII "D" ; 38249
	DB 06h, 93h, 0FAh, 0CFh, 0D8h, 0CEh ; 3824a
	ASCII "D" ; 38250
	DB 04h, 0CEh ; 38251
	ASCII "L" ; 38253
	DB 05h, 0C3h, 02h, 00h, 0F8h ; 38254
	ASCII "G" ; 38259
	DB 0CEh ; 3825a
	ASCII "D" ; 3825b
	DB 07h, 93h, 0F8h, 0CFh, 0DBh, 0F8h, 0CFh, 0E6h ; 3825c
	DB 0C1h, 07h, 00h, 8Eh, 0E7h, 0F6h, 0C3h, 02h ; 38264
	DB 00h, 0F8h, 0CFh, 0D8h, 0CEh ; 3826c
	ASCII "D" ; 38271
	DB 08h, 0CEh ; 38272
	ASCII "L" ; 38274
	DB 09h, 0C3h, 02h, 00h, 0F8h, 0CFh, 0D8h, 0CEh ; 38275
	ASCII "D" ; 3827d
	DB 0Ah, 0CEh ; 3827e
	ASCII "L" ; 38280
	DB 0Bh, 0C3h, 02h, 00h, 0F8h
; ---------------------- ; 38281
loc_0x038286:
	LD A,[IX+08h] ; 38286
	ADD A,[IY] ; 38289
	LD [IX+08h],A ; 3828a
	INC IY ; 3828d
	LD A,[IX+09h] ; 3828e
	ADD A,[IY] ; 38291
	LD [IX+09h],A ; 38292
	INC IY ; 38295
	RET
; ---------------------- ; 38296
loc_0x038297:
	LD A,[164Dh] ; 38297
	AND A,A ; 3829b
	JRS Z,loc_0x0382A0 ; 3829c
	INC IY ; 3829e
	RET
; ---------------------- ; 3829f
loc_0x0382A0:
	LD A,[1AB6h] ; 382a0
	AND A,A ; 382a4
	JRS Z,loc_0x0382AC ; 382a5
	LD A,[IY] ; 382a7
	LD [14FAh],A ; 382a8
loc_0x0382AC:
	INC IY ; 382ac
	RET
; ---------------------- ; 382ad
	ASCII "G" ; 382ae
	DB 0CEh, 0D4h, 0F4h, 14h, 93h, 0F8h, 0CEh ; 382af
	ASCII "D" ; 382b6
	DB 04h, 0CEh ; 382b7
	ASCII "L" ; 382b9
	DB 05h, 0F8h
; ---------------------- ; 382ba
loc_0x0382BC:
	LD [IX+02h],A ; 382bc
	LD [IX+03h],B ; 382bf
	LD A,#01h ; 382c2
	LD [IX+06h],A ; 382c4
	RET
; ---------------------- ; 382c7
loc_0x0382C8:
	LD [IX+02h],A ; 382c8
	LD [IX+03h],B ; 382cb
	LD A,#01h ; 382ce
	LD [IX+06h],A ; 382d0
	LD BA,#82EFh ; 382d3
	LD [IX+04h],A ; 382d6
	LD [IX+05h],B ; 382d9
	RET
; ---------------------- ; 382dc
	DB 0CEh ; 382dd
	ASCII "T" ; 382de
	DB 04h, 0CEh, 5Ch, 05h, 0CEh ; 382df
	ASCII "D" ; 382e4
	DB 02h, 0CEh ; 382e5
	ASCII "L" ; 382e7
	DB 03h, 0B0h, 01h, 0CEh ; 382e8
	ASCII "D" ; 382ec
	DB 06h, 0F8h, 0F8h, 3Eh, 82h ; 382ed
	ASCII "8" ; 382f2
	DB 82h
; ---------------------- ; 382f3
global loc_0x0382F4
loc_0x0382F4:
	LD IY,#0000h ; 382f4
	LD HL,#1916h ; 382f7
	LD EP,#00h ; 382fa
	LD B,#10h ; 382fd
	LD IX,#0018h ; 382ff
loc_0x038302:
	LD [HL],IY ; 38302
	ADD HL,IX ; 38304
	DJR NZ,loc_0x038302 ; 38306
	RET
; ---------------------- ; 38308
loc_0x038309:
	LD [IX],IY ; 38309
	LD [IX+08h],L ; 3830b
	LD [IX+09h],H ; 3830e
	LD A,[IY+02h] ; 38311
	LD B,[IY+03h] ; 38314
	LD [IX+04h],A ; 38317
	LD [IX+05h],B ; 3831a
	LD A,[IY+04h] ; 3831d
	LD B,[IY+05h] ; 38320
	LD [IX+02h],A ; 38323
	LD [IX+03h],B ; 38326
	XOR A,A ; 38329
	LD [IX+07h],A ; 3832a
	LD [IX+0Ch],A ; 3832d
	LD [IX+0Dh],A ; 38330
	LD [IX+0Ah],A ; 38333
	LD [IX+0Bh],A ; 38336
	LD [IX+0Fh],A ; 38339
	LD [IX+10h],A ; 3833c
	LD [IX+11h],A ; 3833f
	LD [IX+12h],A ; 38342
	LD [IX+13h],A ; 38345
	LD [IX+14h],A ; 38348
	LD [IX+15h],A ; 3834b
	POP BA ; 3834e
	LD [IX+16h],A ; 3834f
	LD [IX+17h],B ; 38352
	LD A,#01h ; 38355
	LD [IX+06h],A ; 38357
	LD A,#03h ; 3835a
	LD [IX+0Eh],A ; 3835c
	LD HL,[IY] ; 3835f
	ADD IY,#0006h ; 38361
	CARS loc_0x038369 ; 38364
	POP IX ; 38366
	POP IP ; 38367
	RET
; ---------------------- ; 38368
loc_0x038369:
	JP HL
; ---------------------- ; 38369
global loc_0x03836A
loc_0x03836A:
	PUSH IP ; 3836a
	PUSH IX ; 3836b
	PUSH BA ; 3836c
	LD YP,#03h ; 3836d
	LD IX,#1916h ; 38370
	LD XP,#00h ; 38373
	LD EP,#00h ; 38376
	LD B,#10h ; 38379
loc_0x03837B:
	LD A,[IX] ; 3837b
	OR A,[IX+01h] ; 3837c
	JRS Z,loc_0x038309 ; 3837f
	ADD IX,#0018h ; 38381
	DJR NZ,loc_0x03837B ; 38384
	POP BA ; 38386
	POP IX ; 38387
	POP IP ; 38388
	RET
; ---------------------- ; 38389
loc_0x03838A:
	PUSH IP ; 3838a
	PUSH IX ; 3838b
	PUSH BA ; 3838c
	LD YP,#03h ; 3838d
	LD IX,#1916h ; 38390
	LD XP,#00h ; 38393
	LD EP,#00h ; 38396
	LD B,#10h ; 38399
loc_0x03839B:
	LD A,[IX] ; 3839b
	OR A,[IX+01h] ; 3839c
	JRS Z,loc_0x0383AC ; 3839f
	LD A,[IX+08h] ; 383a1
	LD B,[IX+09h] ; 383a4
	CP BA,HL ; 383a7
	JRL Z,loc_0x0383C2 ; 383a9
loc_0x0383AC:
	ADD IX,#0018h ; 383ac
	DJR NZ,loc_0x03839B ; 383af
	LD IX,#1916h ; 383b1
	LD B,#10h ; 383b4
loc_0x0383B6:
	LD A,[IX] ; 383b6
	OR A,[IX+01h] ; 383b7
	JRL Z,loc_0x038309 ; 383ba
	ADD IX,#0018h ; 383bd
	DJR NZ,loc_0x0383B6 ; 383c0
loc_0x0383C2:
	POP BA ; 383c2
	POP IX ; 383c3
	POP IP ; 383c4
	RET
; ---------------------- ; 383c5
global loc_0x0383C6
loc_0x0383C6:
	LD YP,#03h ; 383c6
	LD IX,#1916h ; 383c9
	LD XP,#00h ; 383cc
	LD EP,#00h ; 383cf
	LD B,#10h ; 383d2
loc_0x0383D4:
	PUSH B ; 383d4
	LD A,[IX] ; 383d6
	OR A,[IX+01h] ; 383d7
	JRS Z,loc_0x038426 ; 383da
	LD L,[IX+04h] ; 383dc
	LD H,[IX+05h] ; 383df
	CARS loc_0x03842E ; 383e2
	LD HL,IX ; 383e4
	ADD HL,#0006h ; 383e6
	DEC [HL] ; 383e9
	JRS NZ,loc_0x038426 ; 383ea
	LD L,[IX+02h] ; 383ec
	LD H,[IX+03h] ; 383ef
	LD IY,HL ; 383f2
loc_0x0383F4:
	LD YP,#03h ; 383f4
	LD BA,[IY] ; 383f7
	ADD IY,#0002h ; 383f9
	BIT B,#80h ; 383fc
	JRS Z,loc_0x038410 ; 383fe
	LD HL,BA ; 38400
	CARS loc_0x03842E ; 38402
	JRS loc_0x0383F4
; ---------------------- ; 38404
loc_0x038406:
	LD BA,IY ; 38406
	LD [IX+02h],A ; 38408
	LD [IX+03h],B ; 3840b
	JRS loc_0x038426
; ---------------------- ; 3840e
loc_0x038410:
	LD [IX+06h],A ; 38410
	LD BA,[IY] ; 38413
	LD [IX+0Ch],A ; 38415
	LD [IX+0Dh],B ; 38418
	ADD IY,#0002h ; 3841b
	LD BA,IY ; 3841e
	LD [IX+02h],A ; 38420
	LD [IX+03h],B ; 38423
loc_0x038426:
	ADD IX,#0018h ; 38426
	POP B ; 38429
	DJR NZ,loc_0x0383D4 ; 3842b
	RET
; ---------------------- ; 3842d
loc_0x03842E:
	JP HL
; ---------------------- ; 3842e
global loc_0x03842F
loc_0x03842F:
	LD HL,#164Dh ; 3842f
	BIT [HL],#01h ; 38432
	JRL Z,loc_0x03852D ; 38434
	JRL loc_0x03843A
; ---------------------- ; 38437
loc_0x03843A:
	LD IX,#1916h ; 3843a
	LD XP,#00h ; 3843d
	LD EP,#00h ; 38440
	LD B,#10h ; 38443
loc_0x038445:
	PUSH B ; 38445
	LD A,[IX] ; 38447
	OR A,[IX+01h] ; 38448
	JRL Z,loc_0x038523 ; 3844b
	XOR A,A ; 3844e
	LD [IX+12h],A ; 3844f
	LD HL,[1661h] ; 38452
	LD A,[IX+08h] ; 38455
	ADD A,[IX+0Ah] ; 38458
	LD B,#00h ; 3845b
	CP HL,BA ; 3845d
	JRL NC,loc_0x038523 ; 3845f
	ADD HL,#000Dh ; 38462
	LD A,[IX+08h] ; 38465
	LD B,#00h ; 38468
	CP BA,HL ; 3846a
	JRL NC,loc_0x038523 ; 3846c
	LD A,[IX+0Ah] ; 3846f
	LD [IX+11h],A ; 38472
	LD A,[IX+08h] ; 38475
	LD [IX+0Fh],A ; 38478
	XOR A,A ; 3847b
	LD [IX+13h],A ; 3847c
	LD A,[IX+08h] ; 3847f
	LD B,#00h ; 38482
	LD HL,[1661h] ; 38484
	SUB HL,BA ; 38487
	JRS C,loc_0x03849D ; 38489
	LD [IX+13h],L ; 3848b
	LD B,L ; 3848e
	LD A,[IX+11h] ; 3848f
	SUB A,B ; 38492
	LD [IX+11h],A ; 38493
	LD A,[IX+0Fh] ; 38496
	ADD A,B ; 38499
	LD [IX+0Fh],A ; 3849a
loc_0x03849D:
	LD HL,[1661h] ; 3849d
	ADD HL,#000Eh ; 384a0
	LD A,[IX+08h] ; 384a3
	ADD A,[IX+0Ah] ; 384a6
	LD B,#00h ; 384a9
	SUB BA,HL ; 384ab
	JRS C,loc_0x0384B7 ; 384ad
	LD B,A ; 384af
	LD A,[IX+11h] ; 384b0
	SUB A,B ; 384b3
	LD [IX+11h],A ; 384b4
loc_0x0384B7:
	LD A,[IX+0Ah] ; 384b7
	SUB A,[IX+11h] ; 384ba
	LD [IX+15h],A ; 384bd
	LD HL,[1663h] ; 384c0
	LD A,[IX+09h] ; 384c3
	ADD A,[IX+0Bh] ; 384c6
	LD B,#00h ; 384c9
	CP HL,BA ; 384cb
	JRS NC,loc_0x038523 ; 384cd
	ADD HL,#0009h ; 384cf
	LD A,[IX+09h] ; 384d2
	LD B,#00h ; 384d5
	CP BA,HL ; 384d7
	JRS NC,loc_0x038523 ; 384d9
	LD A,[IX+0Bh] ; 384db
	LD [IX+12h],A ; 384de
	LD A,[IX+09h] ; 384e1
	LD [IX+10h],A ; 384e4
	XOR A,A ; 384e7
	LD [IX+14h],A ; 384e8
	LD A,[IX+09h] ; 384eb
	LD B,#00h ; 384ee
	LD HL,[1663h] ; 384f0
	SUB HL,BA ; 384f3
	JRS C,loc_0x038509 ; 384f5
	LD [IX+14h],L ; 384f7
	LD B,L ; 384fa
	LD A,[IX+12h] ; 384fb
	SUB A,B ; 384fe
	LD [IX+12h],A ; 384ff
	LD A,[IX+10h] ; 38502
	ADD A,B ; 38505
	LD [IX+10h],A ; 38506
loc_0x038509:
	LD HL,[1663h] ; 38509
	ADD HL,#000Ah ; 3850c
	LD A,[IX+09h] ; 3850f
	ADD A,[IX+0Bh] ; 38512
	LD B,#00h ; 38515
	SUB BA,HL ; 38517
	JRS C,loc_0x038523 ; 38519
	LD B,A ; 3851b
	LD A,[IX+12h] ; 3851c
	SUB A,B ; 3851f
	LD [IX+12h],A ; 38520
loc_0x038523:
	ADD IX,#0018h ; 38523
	POP B ; 38526
	DEC B ; 38528
	JRL NZ,loc_0x038445 ; 38529
	RET
; ---------------------- ; 3852c
loc_0x03852D:
	RET
; ---------------------- ; 3852d
global loc_0x03852E
loc_0x03852E:
	LD HL,#164Dh ; 3852e
	BIT [HL],#01h ; 38531
	JRL Z,loc_0x0385AE ; 38533
	JRL loc_0x038539
; ---------------------- ; 38536
loc_0x038539:
	LD IX,#1916h ; 38539
	LD XP,#00h ; 3853c
	LD EP,#00h ; 3853f
	LD B,#10h ; 38542
loc_0x038544:
	PUSH B ; 38544
	LD A,[IX] ; 38546
	OR A,[IX+01h] ; 38547
	JRS Z,loc_0x0385A6 ; 3854a
	LD A,[IX+12h] ; 3854c
	AND A,A ; 3854f
	JRS Z,loc_0x0385A6 ; 38550
	LD A,[IX+0Ch] ; 38552
	LD B,[IX+0Dh] ; 38555
	LD IY,BA ; 38558
	LD A,[IX+0Eh] ; 3855a
	LD YP,A ; 3855d
	LD A,[IX+0Ah] ; 3855f
	LD L,[IX+14h] ; 38562
	MLT ; 38565
	LD A,[IX+13h] ; 38567
	LD B,#00h ; 3856a
	ADD HL,BA ; 3856c
	ADD IY,HL ; 3856e
	LD A,[IX+10h] ; 38570
	SUB A,[1663h] ; 38573
	LD L,#10h ; 38576
	MLT ; 38578
	LD A,[IX+0Fh] ; 3857a
	SUB A,[1661h] ; 3857d
	LD B,#00h ; 38580
	ADD HL,BA ; 38582
	ADD HL,#1360h ; 38584
	LD A,[IX+12h] ; 38587
	AND A,#0Fh ; 3858a
loc_0x03858C:
	PUSH HL ; 3858c
	LD B,[IX+11h] ; 3858d
	AND B,#0Fh ; 38590
loc_0x038593:
	LD [HL],[IY] ; 38593
	INC IY ; 38594
	INC HL ; 38595
	DJR NZ,loc_0x038593 ; 38596
	LD L,[IX+15h] ; 38598
	LD H,#00h ; 3859b
	ADD IY,HL ; 3859d
	POP HL ; 3859f
	ADD HL,#0010h ; 385a0
	DEC A ; 385a3
	JRS NZ,loc_0x03858C ; 385a4
loc_0x0385A6:
	ADD IX,#0018h ; 385a6
	POP B ; 385a9
	DJR NZ,loc_0x038544 ; 385ab
	RET
; ---------------------- ; 385ad
loc_0x0385AE:
	LD IX,#1916h ; 385ae
	LD XP,#00h ; 385b1
	LD EP,#00h ; 385b4
	LD B,#10h ; 385b7
loc_0x0385B9:
	PUSH B ; 385b9
	LD A,[IX] ; 385bb
	OR A,[IX+01h] ; 385bc
	JRS Z,loc_0x0385FF ; 385bf
	LD A,[IX+0Ah] ; 385c1
	OR A,[IX+0Bh] ; 385c4
	JRS Z,loc_0x0385FF ; 385c7
	LD A,[IX+0Ch] ; 385c9
	LD B,[IX+0Dh] ; 385cc
	LD IY,BA ; 385cf
	LD A,[IX+0Eh] ; 385d1
	LD YP,A ; 385d4
	LD A,[IX+09h] ; 385d6
	LD L,#18h ; 385d9
	MLT ; 385db
	LD A,[IX+08h] ; 385dd
	LD B,#00h ; 385e0
	ADD HL,BA ; 385e2
	ADD HL,#1360h ; 385e4
	LD A,[IX+0Bh] ; 385e7
	AND A,#0Fh ; 385ea
loc_0x0385EC:
	PUSH HL ; 385ec
	LD B,[IX+0Ah] ; 385ed
	AND B,#0Fh ; 385f0
loc_0x0385F3:
	LD [HL],[IY] ; 385f3
	INC IY ; 385f4
	INC HL ; 385f5
	DJR NZ,loc_0x0385F3 ; 385f6
	POP HL ; 385f8
	ADD HL,#0018h ; 385f9
	DEC A ; 385fc
	JRS NZ,loc_0x0385EC ; 385fd
loc_0x0385FF:
	ADD IX,#0018h ; 385ff
	POP B ; 38602
	DJR NZ,loc_0x0385B9 ; 38604
	RET
; ---------------------- ; 38606
	DB 92h, 90h, 90h, 94h, 90h, 90h, 90h, 90h ; 38607
	DB 90h, 90h, 90h, 90h, 93h, 90h, 90h, 91h ; 3860f
	DB 92h, 90h, 90h, 94h, 90h, 95h, 95h, 90h ; 38617
	DB 90h, 95h, 95h, 90h, 93h, 90h, 90h, 91h ; 3861f
	ASCII "M" ; 38627
	DB 82h, 0EFh, 82h ; 38628
	ASCII "n" ; 3862b
	DB 82h, 05h, 06h ; 3862c
	ASCII "z" ; 3862f
	DB 82h, 04h, 04h ; 38630
	ASCII "Y" ; 38633
	DB 82h, 08h, 24h, 00h, 07h, 86h, 12h, 00h ; 38634
	DB 17h, 86h ; 3863c
	ASCII "G" ; 3863e
	DB 82h, 12h, 5Fh, 82h ; 3863f
	ASCII "6" ; 38643
	DB 86h ; 38644
	ASCII "8" ; 38645
	DB 82h, 3Eh, 82h, 0EFh, 82h, 0EFh, 82h, 27h ; 38646
	DB 86h, 80h, 80h, 80h, 80h, 81h, 81h, 81h ; 3864e
	DB 81h, 82h, 82h, 82h, 82h, 83h, 83h, 83h ; 38656
	DB 83h ; 3865e
	ASCII "M" ; 3865f
	DB 82h, 0EFh, 82h ; 38660
	ASCII "z" ; 38663
	DB 82h, 02h, 02h, 24h, 00h ; 38664
	ASCII "O" ; 38669
	DB 86h, 24h, 00h ; 3866a
	ASCII "S" ; 3866d
	DB 86h, 24h, 00h ; 3866e
	ASCII "W" ; 38671
	DB 86h, 24h, 00h, 5Bh, 86h, 5Fh, 82h ; 38672
	ASCII "g" ; 38679
	DB 86h ; 3867a
	ASCII "8" ; 3867b
	DB 82h, 3Eh, 82h, 0EFh, 82h, 0EFh, 82h, 5Fh ; 3867c
	DB 86h ; 38684
	ASCII "z" ; 38685
	DB 82h, 08h, 01h, 01h, 00h, 0A0h, 1Ah, 5Fh ; 38686
	DB 82h, 89h, 86h, 0CEh, 0C7h, 00h, 0C7h, 0A0h ; 3868e
	DB 1Ah, 0B0h, 27h, 0CEh ; 38696
	ASCII "E" ; 3869a
	DB 02h, 0B0h, 22h, 0CEh ; 3869b
	ASCII "E" ; 3869f
	DB 05h, 0F8h
; ---------------------- ; 386a0
loc_0x0386A2:
	PUSH IP ; 386a2
	LD A,#00h ; 386a3
	LD [IX+0Eh],A ; 386a5
	LD YP,#00h ; 386a8
	LD IY,#1AA0h ; 386ab
	LD A,[167Eh] ; 386ae
	UPCK ; 386b2
	OR A,#30h ; 386b3
	LD [IY+01h],A ; 386b5
	OR B,#30h ; 386b8
	LD [IY],B ; 386bb
	LD A,[167Dh] ; 386bc
	UPCK ; 386c0
	OR A,#30h ; 386c1
	LD [IY+04h],A ; 386c3
	OR B,#30h ; 386c6
	LD [IY+03h],B ; 386c9
	LD A,[167Ch] ; 386cc
	UPCK ; 386d0
	OR A,#30h ; 386d1
	LD [IY+07h],A ; 386d3
	OR B,#30h ; 386d6
	LD [IY+06h],B ; 386d9
	POP IP ; 386dc
	RET
; ---------------------- ; 386dd
loc_0x0386DE:
	INC HL ; 386de
	INC [HL] ; 386df
	PUSH IX ; 386e0
	INC [HL] ; 386e1
	INC [BR:86h] ; 386e2
	LD [HL],[IX] ; 386e4
	INC L ; 386e5
	ADD A,A ; 386e6
	ADD A,[IX] ; 386e7
	LD [BR:82h],L ; 386e8
	ADC A,B ; 386ea
	ADD A,B ; 386eb
	XOR A,[IX] ; 386ec
	INC L ; 386ed
	LD BA,#1AA8h ; 386ee
	LD [IX+0Ch],A ; 386f1
	LD [IX+0Dh],B ; 386f4
	LD A,#00h ; 386f7
	LD [IX+0Eh],A ; 386f9
	PUSH IP ; 386fc
	PUSH IX ; 386fd
	LD A,[168Dh] ; 386fe
	LD L,#11h ; 38702
	MLT ; 38704
	ADD HL,#153Ah ; 38706
	LD IX,HL ; 38709
	LD IY,#1AA8h ; 3870b
	LD YP,#00h ; 3870e
	LD A,[IX+03h] ; 38711
	UPCK ; 38714
	ADD BA,#3030h ; 38715
	LD [IY+00h],B ; 38718
	LD [IY+01h],A ; 3871b
	LD A,[IX+02h] ; 3871e
	UPCK ; 38721
	ADD BA,#3030h ; 38722
	LD [IY+02h],B ; 38725
	LD [IY+03h],A ; 38728
	LD A,[IX+01h] ; 3872b
	UPCK ; 3872e
	ADD BA,#3030h ; 3872f
	LD [IY+04h],B ; 38732
	LD [IY+05h],A ; 38735
	LD A,[IX+00h] ; 38738
	UPCK ; 3873b
	ADD BA,#3030h ; 3873c
	LD [IY+06h],B ; 3873f
	LD [IY+07h],A ; 38742
	LD A,[IX+-1h] ; 38745
	AND A,#0Fh ; 38748
	OR A,#10h ; 3874a
	LD [IY+08h],A ; 3874c
	POP IX ; 3874f
	LD A,#01h ; 38750
	LD [IX+06h],A ; 38752
	POP IP ; 38755
	RET
; ---------------------- ; 38756
	DB 0EEh, 86h, 0FCh, 86h, 0E4h, 86h ; 38757
	ASCII "M" ; 3875d
	DB 82h ; 3875e
	ASCII "k" ; 3875f
	DB 87h ; 38760
	ASCII "n" ; 38761
	DB 82h, 00h, 07h ; 38762
	ASCII "z" ; 38765
	DB 82h, 0Ch, 01h, 3Eh, 82h
; ---------------------- ; 38766
loc_0x03876B:
	LD A,#01h ; 3876b
	LD [IX+06h],A ; 3876d
	LD A,[168Dh] ; 38770
	LD L,#11h ; 38774
	MLT ; 38776
	ADD HL,#1539h ; 38778
	LD A,[HL] ; 3877b
	AND A,A ; 3877c
	JRS Z,loc_0x0387A5 ; 3877d
	CP A,#01h ; 3877f
	JRS Z,loc_0x038787 ; 38781
	CP A,#05h ; 38783
	JRS Z,loc_0x038796 ; 38785
loc_0x038787:
	LD A,#03h ; 38787
	LD [IX+0Eh],A ; 38789
	LD HL,#87C8h ; 3878c
	LD [IX+0Ch],L ; 3878f
	LD [IX+0Dh],H ; 38792
	RET
; ---------------------- ; 38795
loc_0x038796:
	LD A,#03h ; 38796
	LD [IX+0Eh],A ; 38798
	LD HL,#87BCh ; 3879b
	LD [IX+0Ch],L ; 3879e
	LD [IX+0Dh],H ; 387a1
	RET
; ---------------------- ; 387a4
loc_0x0387A5:
	LD A,#00h ; 387a5
	LD [IX+0Eh],A ; 387a7
	LD A,[168Dh] ; 387aa
	LD L,#11h ; 387ae
	MLT ; 387b0
	ADD HL,#153Eh ; 387b2
	LD [IX+0Ch],L ; 387b5
	LD [IX+0Dh],H ; 387b8
	RET
; ---------------------- ; 387bb
	DB 0F0h, 0F1h, 0F2h, 0F3h, 0F4h, 0F5h, 0F6h, 0F7h ; 387bc
	DB 20h, 20h, 20h, 20h, 0F8h, 0F9h, 0FAh, 0FBh ; 387c4
	DB 0FCh, 0FDh, 0FEh, 0FFh, 20h, 20h, 20h, 20h ; 387cc

global data_387d4
data_387d4:
	ASCII "k" ; 387d4
	DB 87h ; 387d5
	ASCII "k" ; 387d6
	DB 87h, 5Dh, 87h
; ---------------------- ; 387d7
loc_0x0387DA:
	LD A,[15AAh] ; 387da
	LD B,[15ABh] ; 387de

global loc_0x0387E2
loc_0x0387E2:

	AND A,#03h ; 387e2
	JRS NZ,loc_0x0387ED ; 387e4
	CP B,#02h ; 387e6
	JRS NZ,loc_0x0387ED ; 387e9
	LD B,#0Dh ; 387eb
loc_0x0387ED:
	LD A,B ; 387ed
	LD IY,#87FAh ; 387ee
	LD YP,#03h ; 387f1
	LD B,#00h ; 387f4
	ADD IY,BA ; 387f6
	LD A,[IY] ; 387f8
	RET
; ---------------------- ; 387f9
	DB 00h, 1Fh, 1Ch, 1Fh, 1Eh, 1Fh, 1Eh, 1Fh ; 387fa
	DB 1Fh, 1Eh, 1Fh, 1Eh, 1Fh, 1Dh
; ---------------------- ; 38802
loc_0x038808:
	PUSH IP ; 38808
	PUSH IX ; 38809
loc_0x03880A:
	LD A,[1ABAh] ; 3880a
	LD B,#00h ; 3880e
	LD IX,#8849h ; 38810
	LD XP,#03h ; 38813
	ADD IX,BA ; 38816
	LD A,[IY] ; 38818
	INC A ; 38819
	CP A,[IX] ; 3881a
	JRS NZ,loc_0x038821 ; 3881b
	ADD IX,#0006h ; 3881d
	LD A,[IX] ; 38820
loc_0x038821:
	LD [IY],A ; 38821
	LD A,[1ABAh] ; 38822
	CP A,#02h ; 38826
	JRS NZ,loc_0x03883A ; 38828
	CARL loc_0x0387DA ; 3882a
	CP A,[15ACh] ; 3882d
	JRS NC,loc_0x038846 ; 38830
	LD A,#01h ; 38832
	LD [15ACh],A ; 38834
	JRS loc_0x038846
; ---------------------- ; 38838
loc_0x03883A:
	CARL loc_0x0387DA ; 3883a
	CP A,[15ACh] ; 3883d
	JRS NC,loc_0x038846 ; 38840
	LD [15ACh],A ; 38842
loc_0x038846:
	POP IX ; 38846
	POP IP ; 38847
	RET
; ---------------------- ; 38848
	ASCII "d" ; 38849
	DB 0Dh, 20h, 18h, 3Ch, 3Ch, 01h, 01h, 01h ; 3884a
	DB 00h, 00h, 00h
; ---------------------- ; 38852
loc_0x038855:
	PUSH IP ; 38855
	PUSH IX ; 38856
	LD A,[1ABAh] ; 38857
	LD B,#00h ; 3885b
	LD IX,#887Eh ; 3885d
	LD XP,#03h ; 38860
	ADD IX,BA ; 38863
	LD A,[IY] ; 38865
	DEC A ; 38866
	CP A,[IX] ; 38867
	JRS NZ,loc_0x03886E ; 38868
	ADD IX,#0006h ; 3886a
	LD A,[IX] ; 3886d
loc_0x03886E:
	LD [IY],A ; 3886e
	CARL loc_0x0387DA ; 3886f
	CP A,[15ACh] ; 38872
	JRS NC,loc_0x03887B ; 38875
	LD [15ACh],A ; 38877
loc_0x03887B:
	POP IX ; 3887b
	POP IP ; 3887c
	RET
; ---------------------- ; 3887d
	DB 00h, 00h, 00h, 0FFh, 0FFh, 0FFh ; 3887e
	ASCII "c" ; 38884
	DB 0Ch, 1Fh, 17h, 3Bh, 3Bh
; ---------------------- ; 38885
loc_0x03888A:
	PUSH IX ; 3888a
	LD A,[1ABAh] ; 3888b
	CP A,#06h ; 3888f
	JRS Z,loc_0x0388AD ; 38891
	LD B,#00h ; 38893
	LD IY,#15AAh ; 38895
	LD YP,#00h ; 38898
	ADD IY,BA ; 3889b
	LD HL,#1645h ; 3889d
	BIT [HL],#08h ; 388a0
	CARL NZ,loc_0x038808 ; 388a2
	LD HL,#1645h ; 388a5
	BIT [HL],#10h ; 388a8
	CARL NZ,loc_0x038855 ; 388aa
loc_0x0388AD:
	POP IX ; 388ad
	RET
; ---------------------- ; 388ae
	ASCII "n" ; 388af
	DB 82h, 03h, 05h ; 388b0
	ASCII "z" ; 388b3
	DB 82h, 08h, 01h, 01h, 00h, 0A0h, 1Ah, 5Fh ; 388b4
	DB 82h, 0B7h, 88h, 0CEh, 0C7h, 00h, 0C7h, 0A0h ; 388bc
	DB 1Ah, 0B0h ; 388c4
	ASCII "A" ; 388c6
	DB 0CEh ; 388c7
	ASCII "E" ; 388c8
	DB 02h, 0B0h ; 388c9
	ASCII "D" ; 388cb
	DB 0CEh ; 388cc
	ASCII "E" ; 388cd
	DB 05h, 0F8h, 0A6h, 0B0h, 00h, 0CEh ; 388ce
	ASCII "D" ; 388d4
	DB 0Eh, 0CEh, 0C7h, 00h, 0C7h, 0A0h, 1Ah, 0CEh ; 388d5
	DB 0D0h, 0ADh, 15h, 0F2h, 93h, 9Ch, 02h, 60h ; 388dd
	DB 0CEh ; 388e5
	ASCII "E" ; 388e6
	DB 01h ; 388e7
	ASCII "A" ; 388e8
	DB 02h, 60h ; 388e9
	ASCII "p" ; 388eb
loc_0x0388EC:
	LD A,[15AEh] ; 388ec
	CARL loc_0x002575 ; 388f0
	ADD A,#60h ; 388f3
	LD [IY+04h],A ; 388f5
	LD A,B ; 388f8
	ADD A,#60h ; 388f9
	LD [IY+03h],A ; 388fb
	LD A,[15AFh] ; 388fe
	CARL loc_0x002575 ; 38902
	ADD A,#60h ; 38905
	LD [IY+07h],A ; 38907
	LD A,B ; 3890a
	ADD A,#60h ; 3890b
	LD [IY+06h],A ; 3890d
	POP IP ; 38910
	RET
; ---------------------- ; 38911
	DB 0BFh, 88h, 0D0h, 88h, 0AFh, 88h ; 38912
	ASCII "n" ; 38918
	DB 82h, 03h, 03h ; 38919
	ASCII "z" ; 3891c
	DB 82h, 08h, 01h, 01h, 00h, 98h, 1Ah, 5Fh ; 3891d
	DB 82h, 20h, 89h, 0CEh, 0C7h, 00h, 0C7h, 98h ; 38925
	DB 1Ah, 0B0h, 29h, 0CEh ; 3892d
	ASCII "E" ; 38931
	DB 02h, 0B0h, 29h, 0CEh ; 38932
	ASCII "E" ; 38936
	DB 05h, 0F8h, 0A6h, 0F2h ; 38937
	ASCII "N" ; 3893b
	DB 0FFh, 0B0h, 00h, 0CEh ; 3893c
	ASCII "D" ; 38940
	DB 0Eh, 0CEh, 0C7h, 00h, 0C7h, 98h, 1Ah, 0CEh ; 38941
	DB 0D0h, 0AAh, 15h, 0F2h, 27h, 9Ch, 02h, 60h ; 38949
	DB 0CEh ; 38951
	ASCII "E" ; 38952
	DB 01h ; 38953
	ASCII "A" ; 38954
	DB 02h, 60h ; 38955
	ASCII "p" ; 38957
loc_0x038958:
	LD A,[15ABh] ; 38958
	CARL loc_0x002575 ; 3895c
	ADD A,#60h ; 3895f
	LD [IY+04h],A ; 38961
	LD A,B ; 38964
	ADD A,#60h ; 38965
	LD [IY+03h],A ; 38967
	LD A,[15ACh] ; 3896a
	CARL loc_0x002575 ; 3896e
	ADD A,#60h ; 38971
	LD [IY+07h],A ; 38973
	LD A,B ; 38976
	ADD A,#60h ; 38977
	LD [IY+06h],A ; 38979
	POP IP ; 3897c
	RET
; ---------------------- ; 3897d
	DB 28h, 89h ; 3897e
	ASCII "9" ; 38980
	DB 89h, 18h, 89h, 0CEh, 40h, 16h, 0CEh, 0D4h ; 38981
	DB 0B2h, 1Ah, 0CEh, 40h, 17h, 0CEh, 0D4h, 0B1h ; 38989
	DB 1Ah, 0F8h
; ---------------------- ; 38991
loc_0x038993:
	LD EP,#00h ; 38993
	LD HL,#1645h ; 38996
	LD A,[1AB1h] ; 38999
	BIT [HL],#20h ; 3899d
	JRS Z,loc_0x0389A2 ; 3899f
	DEC A ; 389a1
loc_0x0389A2:
	BIT [HL],#40h ; 389a2
	JRS Z,loc_0x0389A7 ; 389a4
	INC A ; 389a6
loc_0x0389A7:
	AND A,#0Fh ; 389a7
	OR A,#30h ; 389a9
	LD [1AB1h],A ; 389ab
	LD A,[1AB2h] ; 389af
	BIT [HL],#10h ; 389b3
	JRS Z,loc_0x0389B8 ; 389b5
	DEC A ; 389b7
loc_0x0389B8:
	BIT [HL],#08h ; 389b8
	JRS Z,loc_0x0389BD ; 389ba
	INC A ; 389bc
loc_0x0389BD:
	AND A,#0Fh ; 389bd
	OR A,#30h ; 389bf
	LD [1AB2h],A ; 389c1
	LD A,#01h ; 389c5
	LD [IX+06h],A ; 389c7
	RET
; ---------------------- ; 389ca
	DB 0C4h, 0B1h, 1Ah, 0CEh ; 389cb
	ASCII "D" ; 389cf
	DB 0Ch, 0CEh ; 389d0
	ASCII "L" ; 389d2
	DB 0Dh, 0B0h, 00h, 0CEh ; 389d3
	ASCII "D" ; 389d7
	DB 0Eh, 0F8h, 0CBh, 89h ; 389d8
	ASCII "M" ; 389dc
	DB 82h, 93h, 89h ; 389dd
	ASCII "n" ; 389e0
	DB 82h, 05h, 04h ; 389e1
	ASCII "z" ; 389e4
	DB 82h, 02h, 01h, 3Eh, 82h, 84h, 89h, 0EFh ; 389e5
	DB 82h, 0DAh, 89h, 0C4h, 0B1h, 1Ah, 0CEh ; 389ed
	ASCII "D" ; 389f4
	DB 0Ch, 0CEh ; 389f5
	ASCII "L" ; 389f7
	DB 0Dh, 0B0h, 00h, 0CEh ; 389f8
	ASCII "D" ; 389fc
	DB 0Eh, 0F8h, 0B8h, 0B1h, 1Ah, 22h, 0Fh, 0CEh ; 389fd
	DB 0B0h, 0Fh, 0C0h ; 38a05
	ASCII "00" ; 38a08
	DB 0BCh, 0B1h, 1Ah, 0B8h, 0B3h, 1Ah, 22h, 0Fh ; 38a0a
	DB 0CEh, 0B0h, 0Fh, 0C0h ; 38a12
	ASCII "00" ; 38a16
	DB 0BCh, 0B3h, 1Ah, 0F8h
; ---------------------- ; 38a18
loc_0x038A1C:
	LD EP,#00h ; 38a1c
	LD HL,#1645h ; 38a1f
	LD A,[1AB1h] ; 38a22
	BIT [HL],#20h ; 38a26
	JRS Z,loc_0x038A2B ; 38a28
	DEC A ; 38a2a
loc_0x038A2B:
	BIT [HL],#40h ; 38a2b
	JRS Z,loc_0x038A30 ; 38a2d
	INC A ; 38a2f
loc_0x038A30:
	AND A,#0Fh ; 38a30
	OR A,#30h ; 38a32
	LD [1AB1h],A ; 38a34
	LD A,[1AB2h] ; 38a38
	BIT [HL],#10h ; 38a3c
	JRS Z,loc_0x038A41 ; 38a3e
	DEC A ; 38a40
loc_0x038A41:
	BIT [HL],#08h ; 38a41
	JRS Z,loc_0x038A46 ; 38a43
	INC A ; 38a45
loc_0x038A46:
	AND A,#0Fh ; 38a46
	OR A,#30h ; 38a48
	LD [1AB2h],A ; 38a4a
	LD A,#01h ; 38a4e
	LD [IX+06h],A ; 38a50
	BIT [HL],#01h ; 38a53
	JRS Z,loc_0x038A66 ; 38a55
	LD BA,#82EFh ; 38a57
	LD [IX+04h],A ; 38a5a
	LD [IX+05h],B ; 38a5d
	CARL loc_0x0022D4 ; 38a60
	CARL loc_0x00228F ; 38a63
loc_0x038A66:
	RET
; ---------------------- ; 38a66
	DB 0F8h ; 38a67
	ASCII "n" ; 38a68
	DB 82h, 04h, 04h ; 38a69
	ASCII "z" ; 38a6c
	DB 82h, 04h, 01h, 3Eh, 82h, 0F0h, 89h, 0FFh ; 38a6d
	DB 89h ; 38a75
	ASCII "h" ; 38a76
	DB 8Ah ; 38a77
	ASCII "8" ; 38a78
	DB 0CEh, 0D4h ; 38a79
	ASCII "v" ; 38a7b
	DB 1Bh, 0CEh, 0D4h ; 38a7c
	ASCII "w" ; 38a7f
	DB 1Bh, 0B0h, 00h, 0CEh ; 38a80
	ASCII "D" ; 38a84
	DB 08h, 0B0h, 02h, 0CEh ; 38a85
	ASCII "D" ; 38a89
	DB 09h, 0C4h ; 38a8a
	ASCII "e" ; 38a8c
	DB 8Ch, 0BCh, 7Bh, 1Bh, 0F8h
; ---------------------- ; 38a8d
loc_0x038A92:
	LD A,[1643h] ; 38a92
	BIT A,#01h ; 38a96
	JRS NZ,loc_0x038AAE ; 38a98
	BIT A,#40h ; 38a9a
	JRS NZ,loc_0x038AA6 ; 38a9c
	BIT A,#20h ; 38a9e
	JRS Z,loc_0x038AE0 ; 38aa0
	LD A,#00h ; 38aa2
	JRS loc_0x038AA8
; ---------------------- ; 38aa4
loc_0x038AA6:
	LD A,#01h ; 38aa6
loc_0x038AA8:
	LD [1B7Ah],A ; 38aa8
	JRS loc_0x038AE0
; ---------------------- ; 38aac
loc_0x038AAE:
	LD A,[1AB6h] ; 38aae
	AND A,A ; 38ab2
	JRS Z,loc_0x038ABB ; 38ab3
	LD A,#01h ; 38ab5
	LD [14FAh],A ; 38ab7
loc_0x038ABB:
	PUSH IP ; 38abb
	PUSH IY ; 38abc
	LD IY,[1B7Bh] ; 38abd
	LD YP,#03h ; 38ac0
	INC IY ; 38ac3
	LD A,[1B7Ah] ; 38ac4
	CP A,#00h ; 38ac8
	JRS Z,loc_0x038AD0 ; 38aca
	LD IY,[IY] ; 38acc
	JRS loc_0x038AD2
; ---------------------- ; 38ace
loc_0x038AD0:
	INC IY ; 38ad0
	INC IY ; 38ad1
loc_0x038AD2:
	LD [1B7Bh],IY ; 38ad2
	POP IY ; 38ad5
	POP IP ; 38ad6
	CARL loc_0x038AE1 ; 38ad7
	LD A,#02h ; 38ada
	LD [1B7Ah],A ; 38adc
loc_0x038AE0:
	RET
; ---------------------- ; 38ae0
loc_0x038AE1:
	LD A,#05h ; 38ae1
	LD [1B7Dh],A ; 38ae3
	LD BA,#8C47h ; 38ae7
	CARL loc_0x0382BC ; 38aea
	XOR A,A ; 38aed
	LD [1B77h],A ; 38aee
	LD [1B76h],A ; 38af2
	LD [1B7Eh],A ; 38af6
	RET
; ---------------------- ; 38afa
loc_0x038AFB:
	LD A,[1B77h] ; 38afb
	OR A,A ; 38aff
	JRS Z,loc_0x038B11 ; 38b00
	CP A,#82h ; 38b02
	JRS NZ,loc_0x038B10 ; 38b04
	LD BA,[1B7Bh] ; 38b06
	INC BA ; 38b09
	LD [1B7Bh],BA ; 38b0a
	CARL loc_0x038AE1 ; 38b0d
loc_0x038B10:
	RET
; ---------------------- ; 38b10
loc_0x038B11:
	LD HL,#1B76h ; 38b11
	LD A,[HL] ; 38b14
	OR A,A ; 38b15
	JRS Z,loc_0x038B24 ; 38b16
	DEC [HL] ; 38b18
	JRS Z,loc_0x038B24 ; 38b19
	LD A,[1642h] ; 38b1b
	BIT A,#02h ; 38b1f
	JRS NZ,loc_0x038B24 ; 38b21
	RET
; ---------------------- ; 38b23
loc_0x038B24:
	PUSH IP ; 38b24
	PUSH IY ; 38b25
	LD IY,[1B7Bh] ; 38b26
	LD YP,#03h ; 38b29
loc_0x038B2C:
	LD [1B7Bh],IY ; 38b2c
	LD A,[IY] ; 38b2f
	OR A,A ; 38b30
	JRS Z,loc_0x038B56 ; 38b31
	CP A,#0FAh ; 38b33
	JRS Z,loc_0x038B60 ; 38b35
	CP A,#0FBh ; 38b37
	JRS Z,loc_0x038B65 ; 38b39
	CP A,#0FDh ; 38b3b
	JRS Z,loc_0x038B7F ; 38b3d
	CP A,#0FCh ; 38b3f
	JRS Z,loc_0x038B83 ; 38b41
	CP A,#0FEh ; 38b43
	JRS NZ,loc_0x038B99 ; 38b45
	LD A,#00h ; 38b47
	LD [IX+08h],A ; 38b49
	LD A,[IX+09h] ; 38b4c
	INC A ; 38b4f
	LD [IX+09h],A ; 38b50
	INC IY ; 38b53
	JRS loc_0x038B2C
; ---------------------- ; 38b54
loc_0x038B56:
	LD A,[IX+08h] ; 38b56
	INC A ; 38b59
	LD [IX+08h],A ; 38b5a
	INC IY ; 38b5d
	JRS loc_0x038B2C
; ---------------------- ; 38b5e
loc_0x038B60:
	INC IY ; 38b60
	LD IY,[IY] ; 38b61
	JRS loc_0x038B2C
; ---------------------- ; 38b63
loc_0x038B65:
	LD A,#02h ; 38b65
	LD [IX+08h],A ; 38b67
	LD A,#00h ; 38b6a
	LD [1B7Ah],A ; 38b6c
	LD A,#03h ; 38b70
	LD [IX+0Eh],A ; 38b72
	LD BA,#8C0Bh ; 38b75
	CARL loc_0x0382BC ; 38b78
	LD A,#03h ; 38b7b
	JRS loc_0x038B85
; ---------------------- ; 38b7d
loc_0x038B7F:
	LD A,#01h ; 38b7f
	JRS loc_0x038B85
; ---------------------- ; 38b81
loc_0x038B83:
	LD A,#02h ; 38b83
loc_0x038B85:
	LD [1B77h],A ; 38b85
	LD A,[IX+09h] ; 38b89
	LD [1B74h],A ; 38b8c
	LD A,[IX+08h] ; 38b90
	LD [1B75h],A ; 38b93
	JRS loc_0x038BBF
; ---------------------- ; 38b97
loc_0x038B99:
	LD [1B79h],A ; 38b99
	LD A,[IX+08h] ; 38b9d
	INC A ; 38ba0
	LD [IX+08h],A ; 38ba1
	LD A,#00h ; 38ba4
	LD [IX+0Eh],A ; 38ba6
	LD BA,#8C23h ; 38ba9
	CARL loc_0x0382BC ; 38bac
	INC IY ; 38baf
	LD [1B7Bh],IY ; 38bb0
	LD A,#09h ; 38bb3
	LD [1B76h],A ; 38bb5
	LD A,#01h ; 38bb9
	LD [1B78h],A ; 38bbb
loc_0x038BBF:
	POP IY ; 38bbf
	POP IP ; 38bc0
	RET
; ---------------------- ; 38bc1
	DB 0C5h, 7Eh, 1Bh ; 38bc2
	ASCII "E(" ; 38bc5
	DB 0E6h, 05h, 8Eh, 0E6h, 02h, 0F8h, 0B5h, 02h ; 38bc7
	DB 0A6h, 0A3h, 0C5h, 81h, 13h, 0C7h, 91h, 13h ; 38bcf
	DB 0CEh, 0C7h, 00h, 0B1h, 04h, 0CFh, 0B1h, 0B1h ; 38bd7
	DB 07h ; 38bdf
	ASCII "Gh" ; 38be0
	DB 93h, 91h, 0F5h, 0FBh, 0C4h, 09h, 00h, 0CFh ; 38be2
	ASCII "B" ; 38bea
	DB 0CFh, 20h, 0CFh, 0B5h, 0F5h, 0ECh ; 38beb
	ASCII "8" ; 38bf1
	DB 0B1h, 07h ; 38bf2
	ASCII "h" ; 38bf4
	DB 0F5h, 0FEh, 0ABh, 0AEh, 0C5h, 7Dh, 1Bh, 8Eh ; 38bf5
	DB 0E7h, 0Ch, 0B0h, 03h, 0CEh ; 38bfd
	ASCII "D" ; 38c02
	DB 0Eh, 0C4h ; 38c03
	ASCII "1" ; 38c05
	DB 8Ch, 0F2h, 0B3h, 0F6h, 0F8h ; 38c06
	ASCII "M" ; 38c0b
	DB 82h, 92h, 8Ah ; 38c0c
	ASCII "z" ; 38c0f
	DB 82h, 06h, 01h, 01h, 00h, 1Dh, 8Ch ; 38c10
	ASCII "z" ; 38c17
	DB 82h, 00h, 00h, 3Eh, 82h, 1Ah, 02h, 00h ; 38c18
	DB 02h, 02h, 04h ; 38c20
	ASCII "z" ; 38c23
	DB 82h, 01h, 01h, 01h, 00h ; 38c24
	ASCII "y" ; 38c29
	DB 1Bh ; 38c2a
	ASCII "z" ; 38c2b
	DB 82h, 00h, 00h, 3Eh, 82h ; 38c2c
	ASCII "M" ; 38c31
	DB 82h, 0FBh, 8Ah ; 38c32
	ASCII "z" ; 38c35
	DB 82h, 0Ch, 05h ; 38c36
	ASCII "n" ; 38c39
	DB 82h, 00h, 02h, 01h, 00h, 0B8h ; 38c3a
	ASCII "zz" ; 38c40
	DB 82h, 00h, 00h, 3Eh, 82h ; 38c42
	ASCII "M" ; 38c47
	DB 82h, 0C2h, 8Bh, 3Eh, 82h ; 38c48
	ASCII "M" ; 38c4d
	DB 82h, 0FBh, 8Ah ; 38c4e
	ASCII "z" ; 38c51
	DB 82h, 0Ch, 05h ; 38c52
	ASCII "n" ; 38c55
	DB 82h, 00h, 02h, 01h, 00h, 0B8h ; 38c56
	ASCII "z>" ; 38c5c
	DB 82h ; 38c5e

global pool_038C5F
pool_038C5F:
	ASCII "x" ; 38c5f
	DB 8Ah, 0FBh, 8Ah, 0F0h, 82h ; 38c60
	ASCII "r" ; 38c65
	DB 0A0h, 5Eh, 0E4h, 85h, 0FEh, 00h, 00h, 00h ; 38c66
	DB 00h ; 38c6e
	ASCII "c]d" ; 38c6f
	DB 0FEh, 05h, 2Ch, 28h, 0EAh, 0FEh, 0FBh, 7Eh ; 38c72
	DB 8Ch, 0FAh, 83h, 8Ch, 26h ; 38c7a
	ASCII "P" ; 38c7f
	DB 0Ch ; 38c80
	ASCII "M" ; 38c81
	DB 0FCh, 05h, 2Ch, 28h, 0FDh, 0FEh ; 38c82
	ASCII "z" ; 38c88
	DB 82h, 0Bh, 01h, 01h, 00h ; 38c89
	ASCII "E" ; 38c8e
	DB 1Bh, 5Fh, 82h, 8Ch, 8Ch, 0C5h ; 38c8f
	ASCII "E" ; 38c95
	DB 1Bh, 0CEh, 0D1h, 0DAh, 1Ah, 0CEh, 0BCh, 28h ; 38c96
	DB 0E4h, 03h, 0B1h, 28h, 0CEh, 8Dh, 0CEh, 8Dh ; 38c9e
	DB 0CEh, 8Dh, 0CEh, 0BCh, 00h, 0E6h, 06h, 0B5h ; 38ca6
	DB 0Ch, 91h, 0F5h, 0FCh, 0CEh, 0D0h, 0DAh, 1Ah ; 38cae
	ASCII "2(" ; 38cb6
	DB 0E4h, 03h, 0B0h, 28h, 22h, 07h, 28h, 0E6h ; 38cb8
	DB 05h, 02h, 04h ; 38cc0
	ASCII "h" ; 38cc3
	DB 91h, 0B0h, 04h, 0D5h ; 38cc4
	ASCII "J" ; 38cc8
	DB 1Bh, 0E5h, 05h ; 38cc9
	ASCII "h" ; 38ccc
	DB 91h, 0F1h, 0F8h, 0CEh, 0D0h ; 38ccd
	ASCII "B" ; 38cd2
	DB 16h, 96h, 02h, 0E6h, 16h, 0CEh, 0D0h, 14h ; 38cd3
	DB 1Bh ; 38cdb
	ASCII "2" ; 38cdc
	DB 01h, 0E6h, 0Eh, 0B9h, 1Fh, 16h, 0D5h, 0DEh ; 38cdd
	DB 88h, 0E7h, 06h, 0F2h ; 38ce5
	ASCIZ "R" ; 38ce9
	DB 0F1h, 3Ch, 0C5h ; 38ceb
	ASCII "J" ; 38cee
	DB 1Bh, 0B5h, 03h, 0C5h ; 38cef
	ASCII "K" ; 38cf3
	DB 1Bh, 0CEh, 0D1h, 0DBh, 1Ah, 0CEh, 0BCh, 08h ; 38cf4
	DB 0E4h, 03h, 0B1h, 08h, 0CEh, 8Dh, 0CEh, 0BCh ; 38cfc
	DB 00h, 0E6h, 06h, 0B5h, 0Eh, 91h, 0F5h, 0FCh
; ---------------------- ; 38d04
loc_0x038D0C:
	LD A,[1ADBh] ; 38d0c
	CP A,#08h ; 38d10
	JRS C,loc_0x038D16 ; 38d12
	LD A,#08h ; 38d14
loc_0x038D16:
	BIT A,#01h ; 38d16
	JRS Z,loc_0x038D1D ; 38d18
	LD [HL],#0Dh ; 38d1a
	INC HL ; 38d1c
loc_0x038D1D:
	LD A,#01h ; 38d1d
loc_0x038D1F:
	CP HL,#1B4Fh ; 38d1f
	JRS NC,loc_0x038D28 ; 38d22
	LD [HL],A ; 38d24
	INC HL ; 38d25
	JRS loc_0x038D1F
; ---------------------- ; 38d26
loc_0x038D28:
	LD A,#0Fh ; 38d28
	LD [1B4Fh],A ; 38d2a
	LD A,[1AB5h] ; 38d2e
	OR A,A ; 38d32
	JRS Z,loc_0x038D3B ; 38d33
	LD A,#10h ; 38d35
	LD [1B4Fh],A ; 38d37
loc_0x038D3B:
	RET
; ---------------------- ; 38d3b
loc_0x038D3C:
	PUSH IP ; 38d3c
	PUSH IX ; 38d3d
	LD IX,#15AAh ; 38d3e
	LD XP,#00h ; 38d41
	CARL loc_0x004706 ; 38d44
	LD A,[15ADh] ; 38d47
	CARL loc_0x002575 ; 38d4b
	ADD A,#14h ; 38d4e
	LD [1B4Bh],A ; 38d50
	LD A,B ; 38d54
	ADD A,#14h ; 38d55
	LD [1B4Ah],A ; 38d57
	LD A,[15AEh] ; 38d5b
	CARL loc_0x002575 ; 38d5f
	ADD A,#14h ; 38d62
	LD [1B4Eh],A ; 38d64
	LD A,B ; 38d68
	ADD A,#14h ; 38d69
	LD [1B4Dh],A ; 38d6b
	LD A,#01h ; 38d6f
	LD [1B4Ch],A ; 38d71
	LD A,[1671h] ; 38d75
	AND A,#10h ; 38d79
	JRS Z,loc_0x038D83 ; 38d7b
	LD A,#1Eh ; 38d7d
	LD [1B4Ch],A ; 38d7f
loc_0x038D83:
	POP IX ; 38d83
	POP IP ; 38d84
	RET
; ---------------------- ; 38d85
	DB 0B0h, 00h, 0CEh ; 38d86
	ASCII "D" ; 38d89
	DB 0Eh, 0B0h, 03h, 0CEh, 0D4h ; 38d8a
	ASCII "J" ; 38d8f
	DB 1Bh, 0F8h, 86h, 8Dh, 94h, 8Ch, 88h, 8Ch ; 38d90
	ASCII "z" ; 38d98
	DB 82h, 04h, 02h, 0C2h, 8Dh, 0A2h, 8Dh, 0AAh ; 38d99
	DB 8Dh, 24h, 00h, 0B2h, 8Dh, 5Fh, 82h, 9Ch ; 38da1
	DB 8Dh, 24h, 00h, 0BAh, 8Dh, 5Fh, 82h, 9Ch ; 38da9
	DB 8Dh, 80h, 81h, 82h, 83h, 84h, 85h, 86h ; 38db1
	DB 87h, 88h, 89h, 8Ah, 8Bh, 8Ch, 8Dh, 8Eh ; 38db9
	DB 8Fh, 0CEh, 0D0h, 0D9h, 1Ah, 96h, 80h, 0E6h ; 38dc1
	DB 0Ah, 0C3h, 0FEh, 0FFh, 0B0h, 01h, 0CEh ; 38dc9
	ASCII "D" ; 38dd0
	DB 06h, 0FAh
; ---------------------- ; 38dd1
loc_0x038DD3:
	PUSH IP ; 38dd3
	PUSH IY ; 38dd4
	PUSH IX ; 38dd5
	LD IX,#15AAh ; 38dd6
	LD XP,#00h ; 38dd9
	CARL loc_0x004706 ; 38ddc
	POP IX ; 38ddf
	POP IY ; 38de0
	POP IP ; 38de1
	LD A,[15ADh] ; 38de2
	CP A,#06h ; 38de6
	JRS C,loc_0x038DEE ; 38de8
	CP A,#12h ; 38dea
	JRS C,loc_0x038DF1 ; 38dec
loc_0x038DEE:
	ADD IY,#0002h ; 38dee
loc_0x038DF1:
	LD IY,[IY] ; 38df1
	RET
; ---------------------- ; 38df3
	DB 0EFh, 82h, 0EFh, 82h, 98h, 8Dh ; 38df4
	ASCII "z" ; 38dfa
	DB 82h, 0Ch, 07h, 14h, 8Eh, 0Ch, 8Eh, 04h ; 38dfb
	DB 8Eh, 01h, 00h ; 38e03
	ASCII "Lz_" ; 38e06
	DB 82h, 0FEh, 8Dh, 01h, 00h, 0ECh ; 38e09
	ASCII "y_" ; 38e0f
	DB 82h, 0FEh, 8Dh, 0CEh, 0D0h, 0D9h, 1Ah, 96h ; 38e11
	DB 80h, 0E7h, 0Ch, 0F1h, 0Ah, 0C3h, 0FEh, 0FFh ; 38e19
	DB 0B0h, 01h, 0CEh ; 38e21
	ASCII "D" ; 38e24
	DB 06h, 0FAh, 22h, 7Fh, 0CEh, 0D4h, 0D9h, 1Ah ; 38e25
	DB 0B1h, 03h, 28h, 0E6h, 06h, 0B1h, 03h, 0C3h ; 38e2d
	DB 02h, 00h, 0CEh ; 38e35
	ASCII "L" ; 38e38
	DB 0Eh, 0CFh, 0DBh, 0F8h, 0EFh, 82h, 0EFh, 82h ; 38e39
	DB 0FAh, 8Dh ; 38e41
	ASCII "z" ; 38e43
	DB 82h, 0Ch, 07h, 99h, 8Eh ; 38e44
	ASCII "M" ; 38e49
	DB 8Eh ; 38e4a
	ASCII "U" ; 38e4b
	DB 8Eh, 24h, 00h, 23h, 8Fh, 5Fh, 82h ; 38e4c
	ASCII "C" ; 38e53
	DB 8Eh, 08h, 00h, 0A3h, 90h, 5Fh, 82h ; 38e54
	ASCII "C" ; 38e5b
	DB 8Eh ; 38e5c
	ASCII "z" ; 38e5d
	DB 82h, 0Ch, 07h, 99h, 8Eh ; 38e5e
	ASCII "g" ; 38e63
	DB 8Eh ; 38e64
	ASCII "o" ; 38e65
	DB 8Eh, 24h, 00h, 83h, 8Fh, 5Fh, 82h, 5Dh ; 38e66
	DB 8Eh, 08h, 00h, 03h, 91h, 5Fh, 82h, 5Dh ; 38e6e
	DB 8Eh ; 38e76
	ASCII "z" ; 38e77
	DB 82h, 0Ch, 07h, 99h, 8Eh, 81h, 8Eh, 8Dh ; 38e78
	DB 8Eh, 08h, 00h, 0E3h, 8Fh, 08h, 00h ; 38e80
	ASCII "C" ; 38e87
	DB 90h, 5Fh, 82h ; 38e88
	ASCII "w" ; 38e8b
	DB 8Eh, 08h, 00h ; 38e8c
	ASCII "c" ; 38e8f
	DB 91h, 08h, 00h, 0C3h, 91h, 5Fh, 82h ; 38e90
	ASCII "w" ; 38e97
	DB 8Eh
; ---------------------- ; 38e98
loc_0x038E99:
	PUSH IP ; 38e99
	PUSH IY ; 38e9a
	PUSH IX ; 38e9b
	LD IX,#15AAh ; 38e9c
	LD XP,#00h ; 38e9f
	CARL loc_0x004706 ; 38ea2
	POP IX ; 38ea5
	POP IY ; 38ea6
	POP IP ; 38ea7
	LD A,[15ADh] ; 38ea8
	CP A,#06h ; 38eac
	JRS C,loc_0x038EB4 ; 38eae
	CP A,#12h ; 38eb0
	JRS C,loc_0x038EB7 ; 38eb2
loc_0x038EB4:
	ADD IY,#0002h ; 38eb4
loc_0x038EB7:
	LD IY,[IY] ; 38eb7
	RET
; ---------------------- ; 38eb9
loc_0x038EBA:
	PUSH IP ; 38eba
	PUSH IY ; 38ebb
	LD A,[1AD7h] ; 38ebc
	ADD A,A ; 38ec0
	LD B,#00h ; 38ec1
	LD IY,#8ED3h ; 38ec3
	LD YP,#03h ; 38ec6
	ADD IY,BA ; 38ec9
	LD BA,[IY] ; 38ecb
	POP IY ; 38ecd
	POP IP ; 38ece
	CARL loc_0x0382BC ; 38ecf
	RET
; ---------------------- ; 38ed2
	ASCII "C" ; 38ed3
	DB 8Eh, 5Dh, 8Eh ; 38ed4
	ASCII "w" ; 38ed7
	DB 8Eh, 0BAh, 8Eh, 0EFh, 82h, 0F0h, 82h
; ---------------------- ; 38ed8
global loc_0x038EDF
loc_0x038EDF:
	LD HL,#1B81h ; 38edf
	LD A,[1642h] ; 38ee2
	BIT A,#04h ; 38ee6
	JRS Z,loc_0x038F07 ; 38ee8
	INC [HL] ; 38eea
	LD A,[HL] ; 38eeb
	CP A,#48h ; 38eec
	JRS C,loc_0x038F16 ; 38eee
	LD [HL],#00h ; 38ef0
	LD A,#01h ; 38ef2
	LD [1B82h],A ; 38ef4
	LD A,[1AB5h] ; 38ef8
	XOR A,#0FFh ; 38efc
	LD [1AB5h],A ; 38efe
	CARL loc_0x0026C6 ; 38f02
	JRS loc_0x038F16
; ---------------------- ; 38f05
loc_0x038F07:
	LD [HL],#00h ; 38f07
	LD A,[1644h] ; 38f09
	BIT A,#04h ; 38f0d
	JRS NZ,loc_0x038F16 ; 38f0f
	XOR A,A ; 38f11
	LD [1B82h],A ; 38f12
loc_0x038F16:
	RET
; ---------------------- ; 38f16
	DB 02h, 04h, 04h, 04h, 04h, 04h, 03h, 01h ; 38f17
	DB 01h, 01h, 01h, 01h, 20h, 21h, 22h, 23h ; 38f1f
	DB 24h, 25h, 26h, 27h, 28h, 29h, 2Ah, 2Bh ; 38f27
	ASCII "0123456789:;@ABCDEFGHIJKPQRSTUVWXYZ[`abcdefghijkpqrstuvwxyz{" ; 38f2f
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 38f6b
	DB 88h, 89h, 8Ah, 8Bh, 02h, 04h, 04h, 04h ; 38f73
	DB 04h, 04h, 03h, 01h, 01h, 01h, 01h, 01h ; 38f7b
	DB 20h, 21h, 22h, 23h, 24h, 25h, 26h, 27h ; 38f83
	DB 28h, 29h, 2Ah, 2Bh ; 38f8b
	ASCII "0123456789:;@ABCDEFGHIJKPQRSTUVWXYZ[`abcdefghijkpqrstuvwxyz{" ; 38f8f
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 38fcb
	DB 88h, 89h, 8Ah, 8Bh, 02h, 04h, 04h, 04h ; 38fd3
	DB 04h, 04h, 03h, 01h, 01h, 01h, 01h, 01h ; 38fdb
	DB 20h, 21h, 22h, 23h, 24h, 25h, 26h, 27h ; 38fe3
	DB 28h, 29h, 2Ah, 2Bh ; 38feb
	ASCII "0123456789:;@ABCDEFGHIJKPQRSTUVWXYZ[`abcdefghijkpqrstuvwxyz{" ; 38fef
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 3902b
	DB 88h, 89h, 8Ah, 8Bh, 02h, 04h, 04h, 04h ; 39033
	DB 04h, 04h, 03h, 01h, 01h, 01h, 01h, 01h ; 3903b
	DB 20h, 21h, 22h, 23h, 24h, 25h, 26h, 27h ; 39043
	DB 28h, 29h, 2Ah, 2Bh ; 3904b
	ASCII "0123456789:;@ABCDEFGHIJKPQRSTUVWXYZ[`abcdefg,-jkpqrstuvw<=z{" ; 3904f
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 3908b
	ASCII "LM" ; 39093
	DB 8Ah, 8Bh, 02h, 04h, 04h, 04h, 04h, 04h ; 39095
	DB 03h, 01h, 01h, 01h, 01h, 01h, 90h, 91h ; 3909d
	DB 92h, 93h, 94h, 95h, 96h, 97h, 98h, 99h ; 390a5
	DB 9Ah, 9Bh, 0A0h, 0A1h, 0A2h, 0A3h, 0A4h, 0A5h ; 390ad
	DB 0A6h, 0A7h, 0A8h, 0A9h, 0AAh, 0ABh, 0B0h, 0B1h ; 390b5
	DB 0B2h, 0B3h, 0B4h, 0B5h, 0B6h, 0B7h, 0B8h, 0B9h ; 390bd
	DB 0BAh, 0BBh, 0C0h, 0C1h, 0C2h, 0C3h, 0C4h, 0C5h ; 390c5
	DB 0C6h, 0C7h, 0C8h, 0C9h, 0CAh, 0CBh, 0D0h, 0D1h ; 390cd
	DB 0D2h, 0D3h, 0D4h, 0D5h, 0D6h, 0D7h, 0D8h, 0D9h ; 390d5
	DB 0DAh, 0DBh ; 390dd
	ASCII "pqrstuvwxyz{" ; 390df
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 390eb
	DB 88h, 89h, 8Ah, 8Bh, 02h, 04h, 04h, 04h ; 390f3
	DB 04h, 04h, 03h, 01h, 01h, 01h, 01h, 01h ; 390fb
	DB 90h, 91h, 92h, 93h, 94h, 95h, 96h, 97h ; 39103
	DB 98h, 99h, 9Ah, 9Bh, 0A0h, 0A1h, 0A2h, 0A3h ; 3910b
	DB 0A4h, 0A5h, 0A6h, 0A7h, 0A8h, 0A9h, 0AAh, 0ABh ; 39113
	DB 0B0h, 0B1h, 0B2h, 0B3h, 0B4h, 0B5h, 0B6h, 0B7h ; 3911b
	DB 0B8h, 0B9h, 0BAh, 0BBh, 0C0h, 0C1h, 0C2h, 0C3h ; 39123
	DB 0C4h, 0C5h, 0C6h, 0C7h, 0C8h, 0C9h, 0CAh, 0CBh ; 3912b
	DB 0D0h, 0D1h, 0D2h, 0D3h, 0D4h, 0D5h, 0D6h, 0D7h ; 39133
	DB 0D8h, 0D9h, 0DAh, 0DBh ; 3913b
	ASCII "pqrstuvwxyz{" ; 3913f
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 3914b
	DB 88h, 89h, 8Ah, 8Bh, 02h, 04h, 04h, 04h ; 39153
	DB 04h, 04h, 03h, 01h, 01h, 01h, 01h, 01h ; 3915b
	DB 90h, 91h, 92h, 93h, 94h, 95h, 96h, 97h ; 39163
	DB 98h, 99h, 9Ah, 9Bh, 0A0h, 0A1h, 0A2h, 0A3h ; 3916b
	DB 0A4h, 0A5h, 0A6h, 0A7h, 0A8h, 0A9h, 0AAh, 0ABh ; 39173
	DB 0B0h, 0B1h, 0B2h, 0B3h, 0B4h, 0B5h, 0B6h, 0B7h ; 3917b
	DB 0B8h, 0B9h, 0BAh, 0BBh, 0C0h, 0C1h, 0C2h, 0C3h ; 39183
	DB 0C4h, 0C5h, 0C6h, 0C7h, 0C8h, 0C9h, 0CAh, 0CBh ; 3918b
	DB 0D0h, 0D1h, 0D2h, 0D3h, 0D4h, 0D5h, 0D6h, 0D7h ; 39193
	DB 0D8h, 0D9h, 0DAh, 0DBh ; 3919b
	ASCII "pqrstuvwxyz{" ; 3919f
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 391ab
	DB 88h, 89h, 8Ah, 8Bh, 02h, 04h, 04h, 04h ; 391b3
	DB 04h, 04h, 03h, 01h, 01h, 01h, 01h, 01h ; 391bb
	DB 90h, 91h, 92h, 93h, 94h, 95h, 96h, 97h ; 391c3
	DB 98h, 99h, 9Ah, 9Bh, 0A0h, 0A1h, 0A2h, 0A3h ; 391cb
	DB 0A4h, 0A5h, 0A6h, 0A7h, 0A8h, 0A9h, 0AAh, 0ABh ; 391d3
	DB 0B0h, 0B1h, 0B2h, 0B3h, 0B4h, 0B5h, 0B6h, 0B7h ; 391db
	DB 0B8h, 0B9h, 0BAh, 0BBh, 0C0h, 0C1h, 0C2h, 0C3h ; 391e3
	DB 0C4h, 0C5h, 0C6h, 0C7h, 0C8h, 0C9h, 0CAh, 0CBh ; 391eb
	DB 0D0h, 0D1h, 0D2h, 0D3h, 0D4h, 0D5h, 0D6h, 0D7h ; 391f3
	DB 2Ch, 2Dh, 0DAh, 0DBh ; 391fb
	ASCII "pqrstuvw<=z{" ; 391ff
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 3920b
	ASCII "LM" ; 39213
	DB 8Ah, 8Bh ; 39215
	ASCII "z" ; 39217
	DB 82h, 03h, 03h ; 39218
	ASCII "P" ; 3921b
	DB 92h, 23h, 92h, 29h, 92h, 2Fh, 92h, 01h ; 3921c
	DB 00h ; 39224
	ASCII "5" ; 39225
	DB 92h ; 39226
	ASCII "8" ; 39227
	DB 82h, 01h, 00h ; 39228
	ASCII "G" ; 3922b
	DB 92h ; 3922c
	ASCII "8" ; 3922d
	DB 82h, 01h, 00h, 3Eh, 92h ; 3922e
	ASCII "8" ; 39233
	DB 82h, 40h ; 39234
	ASCII "ABCDEFGHIJKLMNOPQRSTUVWXYZ" ; 39236
	DB 0CEh, 0D0h, 0D7h, 1Ah, 0F3h ; 39250
	ASCIZ "o" ; 39255
	DB 0EFh, 82h, 0EFh, 82h, 17h, 92h ; 39257
	ASCII "z" ; 3925d
	DB 82h, 0Ch, 02h, 0C1h, 92h ; 3925e
	ASCII "s" ; 39263
	DB 92h, 89h, 92h, 91h, 92h, 99h, 92h, 0A1h ; 39264
	DB 92h, 0A9h, 92h, 0B1h, 92h, 0B9h, 92h, 0CDh ; 3926c
	DB 92h ; 39274
	ASCII "y" ; 39275
	DB 92h, 81h, 92h, 01h, 00h, 60h, 7Bh, 5Fh ; 39276
	DB 82h ; 3927e
	ASCII "a" ; 3927f
	DB 92h, 01h, 00h, 20h, 7Ch, 5Fh, 82h ; 39280
	ASCII "a" ; 39287
	DB 92h, 01h, 00h ; 39288
	ASCII "x{_" ; 3928b
	DB 82h ; 3928e
	ASCII "a" ; 3928f
	DB 92h, 01h, 00h, 90h, 7Bh, 5Fh, 82h ; 39290
	ASCII "a" ; 39297
	DB 92h, 01h, 00h, 0A8h, 7Bh, 5Fh, 82h ; 39298
	ASCII "a" ; 3929f
	DB 92h, 01h, 00h, 0C0h, 7Bh, 5Fh, 82h ; 392a0
	ASCII "a" ; 392a7
	DB 92h, 01h, 00h, 0D8h, 7Bh, 5Fh, 82h ; 392a8
	ASCII "a" ; 392af
	DB 92h, 01h, 00h, 0F0h, 7Bh, 5Fh, 82h ; 392b0
	ASCII "a" ; 392b7
	DB 92h, 01h, 00h, 08h, 7Ch, 5Fh, 82h ; 392b8
	ASCII "a" ; 392bf
	DB 92h, 0CEh, 0D0h, 0Ah, 1Bh, 00h, 0B1h, 00h ; 392c0
	DB 0CFh ; 392c8
	ASCII "B" ; 392c9
	DB 0CFh, 0DBh, 0F8h, 0CEh, 0D0h ; 392ca
	ASCII "m" ; 392cf
	DB 1Bh, 28h, 0E7h, 04h, 0C3h, 02h, 00h, 0CFh ; 392d0
	DB 0DBh, 0F8h, 0B0h, 03h, 0CEh ; 392d8
	ASCII "D" ; 392dd
	DB 0Eh, 0F8h, 0DAh, 92h, 0EFh, 82h, 5Dh, 92h ; 392de
	DB 0F6h, 92h ; 392e6
	ASCII "z" ; 392e8
	DB 82h, 08h, 01h ; 392e9
	ASCII "n" ; 392ec
	DB 82h, 04h, 04h, 01h, 00h, 2Eh, 1Bh, 3Eh ; 392ed
	DB 82h, 0CEh, 0D1h, 0DDh, 1Ah, 0C5h, 2Eh, 1Bh ; 392f5
	DB 0B0h, 08h, 0B5h, 04h, 91h, 88h, 0E7h, 0FBh ; 392fd
	DB 0C5h, 2Eh, 1Bh, 0CEh, 0C4h, 03h, 0F2h, 0A9h ; 39305
	DB 0FFh, 0F8h, 1Fh, 93h ; 3930d
	ASCII "z" ; 39311
	DB 82h, 08h, 01h ; 39312
	ASCII "n" ; 39315
	DB 82h, 04h, 05h, 01h, 00h, 2Eh, 1Bh, 3Eh ; 39316
	DB 82h, 0CEh, 0D1h, 0DFh, 1Ah, 0F3h, 0D5h, 0FFh ; 3931e
	ASCII "6" ; 39326
	DB 93h ; 39327
	ASCII "z" ; 39328
	DB 82h, 08h, 01h ; 39329
	ASCII "n" ; 3932c
	DB 82h, 04h, 06h, 01h, 00h, 2Eh, 1Bh, 3Eh ; 3932d
	DB 82h, 0CEh, 0D1h, 0E1h, 1Ah, 0F3h, 0BEh, 0FFh ; 39335
	ASCII "M" ; 3933d
	DB 93h ; 3933e
	ASCII "z" ; 3933f
	DB 82h, 08h, 01h ; 39340
	ASCII "n" ; 39343
	DB 82h, 04h, 07h, 01h, 00h, 2Eh, 1Bh, 3Eh ; 39344
	DB 82h, 0CEh, 0D1h, 0E3h, 1Ah, 0F3h, 0A7h, 0FFh ; 3934c
	DB 0A6h, 0A3h, 0CEh, 0D0h ; 39354
	ASCII "E" ; 39358
	DB 16h, 22h ; 39359
	ASCII "x2 " ; 3935b
	DB 0E6h, 0Dh ; 3935e
	ASCII "2@" ; 39360
	DB 0E7h ; 39362
	ASCII "6" ; 39363
	DB 0CEh, 0C4h, 02h, 0F2h, 0C3h, 1Ch, 0F1h, 07h ; 39364
	DB 0CEh, 0C4h, 02h, 0F2h, 0D1h, 1Ch, 0CEh, 0D0h ; 3936c
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 04h, 0CEh ; 39374
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 2Dh, 1Bh ; 3937c
	ASCII "2" ; 39383
	DB 03h, 0E4h, 13h, 12h, 03h, 00h, 0B1h, 00h ; 39384
	DB 0C7h, 9Ch, 93h, 0CEh, 0C7h, 03h, 0CFh ; 3938c
	ASCII "B" ; 39393
	DB 0CFh, 0D8h, 0F2h, 24h, 0EFh, 0ABh, 0AEh, 0F8h ; 39394
	DB 0E6h, 92h, 0Fh, 93h, 26h, 93h, 3Dh, 93h ; 3939c
	DB 0B0h, 00h, 0CEh ; 393a4
	ASCII "D" ; 393a7
	DB 0Eh, 0F8h, 0A4h, 93h ; 393a8
	ASCII "T" ; 393ac
	DB 93h, 0F0h, 82h ; 393ad
	ASCII "z" ; 393b0
	DB 82h, 04h, 01h, 01h, 00h ; 393b1
	ASCII "E" ; 393b6
	DB 1Bh, 5Fh, 82h, 0B4h, 93h
; ---------------------- ; 393b7
loc_0x0393BC:
	LD A,#00h ; 393bc
	LD [IX+0Eh],A ; 393be
	LD A,[1AE9h] ; 393c1
	CARL loc_0x0023D8 ; 393c5
	LD B,[1AEAh] ; 393c8
	AND A,B ; 393cc
	JRS NZ,loc_0x0393DE ; 393cd
	LD HL,#1B45h ; 393cf
	LD [HL],#18h ; 393d2
	INC HL ; 393d4
	LD [HL],#0B0h ; 393d5
	INC HL ; 393d7
	LD [HL],#0B1h ; 393d8
	INC HL ; 393da
	LD [HL],#18h ; 393db
	RET
; ---------------------- ; 393dd
loc_0x0393DE:
	LD A,[1AE9h] ; 393de
	LD NB,#02h ; 393e2
	CARL loc_0x012476 ; 393e5
	ADD A,A ; 393e8
	ADD A,A ; 393e9
	ADD A,#0C0h ; 393ea
	LD HL,#1B45h ; 393ec
	LD B,#04h ; 393ef
loc_0x0393F1:
	LD [HL],A ; 393f1
	INC HL ; 393f2
	INC A ; 393f3
	DJR NZ,loc_0x0393F1 ; 393f4
	RET
; ---------------------- ; 393f6
global pool_0393F7
pool_0393F7:
	DB 0BCh, 93h, 0C1h, 93h, 0B0h, 93h
; ---------------------- ; 393f7
loc_0x0393FD:
	LD A,#00h ; 393fd
	LD [IX+0Eh],A ; 393ff
	LD A,[1B2Ch] ; 39402
	LD B,[1B97h] ; 39406
	LD NB,#03h ; 3940a
	CARL loc_0x018FAF ; 3940d
	JRS NZ,loc_0x039421 ; 39410
	LD HL,#1B45h ; 39412
	LD [HL],#18h ; 39415
	INC HL ; 39417
	LD [HL],#0B0h ; 39418
	INC HL ; 3941a
	LD [HL],#0B1h ; 3941b
	INC HL ; 3941d
	LD [HL],#18h ; 3941e
	RET
; ---------------------- ; 39420
loc_0x039421:
	LD A,[1B97h] ; 39421
	LD B,A ; 39425
	ADD A,A ; 39426
	ADD A,B ; 39427
	SWAP A ; 39428
	ADD A,#20h ; 39429
	LD B,A ; 3942b
	LD A,[1B2Ch] ; 3942c
	ADD A,A ; 39430
	ADD A,A ; 39431
	ADD A,B ; 39432
	LD HL,#1B45h ; 39433
	LD B,#04h ; 39436
loc_0x039438:
	LD [HL],A ; 39438
	INC HL ; 39439
	INC A ; 3943a
	DJR NZ,loc_0x039438 ; 3943b
	RET
; ---------------------- ; 3943d
	DB 0FDh, 93h, 02h, 94h, 0B0h, 93h ; 3943e
	ASCII "z" ; 39444
	DB 82h, 04h, 01h, 01h, 00h ; 39445
	ASCII "N" ; 3944a
	DB 94h, 3Eh, 82h, 14h, 15h, 16h, 17h ; 3944b
	ASCII "z" ; 39452
	DB 82h, 04h, 01h, 01h, 00h, 5Ch, 94h, 3Eh ; 39453
	DB 82h, 18h, 19h, 1Ah, 1Bh ; 3945b
	ASCII "z" ; 39460
	DB 82h, 04h, 01h, 01h, 00h ; 39461
	ASCII "j" ; 39466
	DB 94h, 3Eh, 82h, 1Ch, 1Dh, 1Eh, 1Fh, 0CEh ; 39467
	DB 0D0h, 97h, 1Bh, 88h, 0E6h, 09h, 88h, 0E6h ; 3946f
	DB 0Bh, 0C4h ; 39477
	ASCII "D" ; 39479
	DB 94h, 0F1h, 09h, 0C4h ; 3947a
	ASCII "R" ; 3947e
	DB 94h, 0F1h, 04h, 0C4h, 60h, 94h, 0F2h ; 3947f
	ASCII "5" ; 39486
	DB 0EEh, 0F8h, 0EFh, 82h ; 39487
	ASCII "n" ; 3948b
	DB 94h, 0F0h, 82h ; 3948c
	ASCII "z" ; 3948f
	DB 82h, 08h, 01h, 01h, 00h ; 39490
	ASCII "E" ; 39495
	DB 1Bh, 5Fh, 82h, 93h, 94h, 0B0h, 00h, 0CEh ; 39496
	ASCII "D" ; 3949e
	DB 0Eh, 0CEh, 0D0h, 0D5h, 1Ah, 00h, 00h, 00h ; 3949f
	DB 02h, 20h, 0C5h ; 394a7
	ASCII "E" ; 394aa
	DB 1Bh, 0B1h, 08h ; 394ab
	ASCII "h" ; 394ae
	DB 91h, 80h, 0F5h, 0FCh, 0F8h, 9Bh, 94h, 0A0h ; 394af
	DB 94h, 8Fh, 94h ; 394b7
	ASCII "z" ; 394ba
	DB 82h, 0Ch, 02h, 01h, 00h, 0E8h, 7Dh ; 394bb
	ASCII "8" ; 394c2
	DB 82h
; ---------------------- ; 394c3
loc_0x0394C4:
	LD A,[1B80h] ; 394c4
	OR A,A ; 394c8
	JRS NZ,loc_0x0394F1 ; 394c9
	LD A,[1643h] ; 394cb
	BIT A,#7Bh ; 394cf
	JRS Z,loc_0x0394F1 ; 394d1
	LD A,[1AB6h] ; 394d3
	AND A,A ; 394d7
	JRS Z,loc_0x0394E0 ; 394d8
	LD A,#01h ; 394da
	LD [14FAh],A ; 394dc
loc_0x0394E0:
	LD A,#01h ; 394e0
	LD [1B80h],A ; 394e2
	LD A,#03h ; 394e6
	LD [IX+0Eh],A ; 394e8
	LD BA,#94BAh ; 394eb
	CARL loc_0x0382C8 ; 394ee
loc_0x0394F1:
	RET
; ---------------------- ; 394f1
	DB 0EFh, 82h, 0C4h, 94h, 0F0h, 82h ; 394f2
	ASCII "z" ; 394f8
	DB 82h, 01h, 01h, 01h, 00h ; 394f9
	ASCII "E" ; 394fe
	DB 1Bh, 5Fh, 82h, 0FCh, 94h, 0B0h, 00h, 0CEh ; 394ff
	ASCII "D" ; 39507
	DB 0Eh, 0B1h ; 39508
	ASCII "0" ; 3950a
	DB 0CEh, 0D0h, 0D4h, 1Ah ; 3950b
	ASCII "2" ; 3950f
	DB 10h, 0E4h, 03h, 0B1h, 02h, 01h, 0CEh, 0D4h ; 39510
	ASCII "E" ; 39518
	DB 1Bh, 0F8h, 04h, 95h, 09h, 95h, 0F8h, 94h ; 39519
	ASCII "z" ; 39521
	DB 82h, 02h, 01h, 01h, 00h ; 39522
	ASCII "P" ; 39527
	DB 1Bh, 5Fh, 82h, 25h, 95h, 0B0h, 00h, 0CEh ; 39528
	ASCII "D" ; 39530
	DB 0Eh, 0F8h, 0A6h, 0A2h, 0C6h, 0F3h, 1Ah, 0CEh ; 39531
	DB 0C6h, 00h, 0C5h, 8Ah, 1Bh, 0B1h, 07h ; 39539
	ASCII "n" ; 39540
	DB 92h, 91h, 0F5h, 0FCh, 0C6h, 0AAh, 15h, 0CEh ; 39541
	DB 0C6h, 00h, 0F2h, 0B9h, 0B1h, 0C6h, 0AFh, 15h ; 39549
	DB 0CEh, 0C6h, 00h, 0CEh, 0C4h, 01h, 0F2h, 97h ; 39551
	DB 1Dh, 0C6h, 83h, 1Bh, 0CEh, 40h, 00h ; 39559
	ASCII "2" ; 39560
	DB 0FFh, 0E6h ; 39561
	ASCII "C" ; 39563
	DB 0CEh, 40h, 01h ; 39564
	ASCII "2" ; 39567
	DB 04h, 0E5h, 3Ch, 28h, 0E6h ; 39568
	ASCII "4H" ; 3956d
	DB 0B0h, 00h, 0CFh, 0B1h, 0CFh, 0B0h, 0CEh, 0D0h ; 3956f
	DB 0ABh, 15h, 11h, 0E4h, 04h, 28h, 0E7h, 07h ; 39577
	DB 02h, 0Ch, 0C5h, 0AAh, 15h, 8Eh ; 3957f
	ASCII "H" ; 39585
	DB 0CEh, 0D0h, 0AAh, 15h, 0CEh, 0C4h, 07h, 0F2h ; 39586
	ASCII "S" ; 3958e
	DB 0F2h, 0CFh, 0B5h, 01h, 0CFh, 0B5h, 0F5h, 0DBh ; 3958f
	DB 0CEh ; 39597
	ASCII "H" ; 39598
	DB 02h, 01h ; 39599
	ASCII "2c" ; 3959b
	DB 0E5h, 08h, 0F1h, 08h, 0CEh, 40h, 02h, 0F1h ; 3959d
	DB 03h, 0B0h ; 395a5
	ASCII "c" ; 395a7
	DB 80h ; 395a8
	ASCII "2c" ; 395a9
	DB 0E4h, 03h, 0B0h ; 395ab
	ASCII "c" ; 395ae
	DB 0F2h, 0C4h, 8Fh, 02h, 0B5h, 0CEh, 0D4h ; 395af
	ASCII "Q" ; 395b6
	DB 1Bh ; 395b7
	ASCII "A" ; 395b8
	DB 02h, 0B5h ; 395b9
	ASCII "2" ; 395bb
	DB 0B5h, 0E7h, 03h, 0B0h, 00h, 0CEh, 0D4h ; 395bc
	ASCII "P" ; 395c3
	DB 1Bh, 0AAh, 0AEh, 0F8h, 2Dh, 95h ; 395c4
	ASCII "3" ; 395ca
	DB 95h, 21h, 95h ; 395cb
	ASCII "n" ; 395ce
	DB 82h, 03h, 00h ; 395cf
	ASCII "z" ; 395d2
	DB 82h, 05h, 01h, 01h, 00h, 0ACh, 1Bh, 5Fh ; 395d3
	DB 82h, 0D6h, 95h, 0C4h, 0ACh, 1Bh, 0CEh ; 395db
	ASCII "D" ; 395e2
	DB 0Ch, 0CEh ; 395e3
	ASCII "L" ; 395e5
	DB 0Dh, 0B0h, 00h, 0CEh ; 395e6
	ASCII "D" ; 395ea
	DB 0Eh, 0F8h, 0F8h, 0DEh, 95h, 0EDh, 95h, 0CEh ; 395eb
	DB 95h, 3Eh, 82h ; 395f3
	ASCII "n" ; 395f6
	DB 82h, 00h, 02h ; 395f7
	ASCII "z" ; 395fa
	DB 82h, 0Ch, 06h, 01h, 00h, 0B8h, 0B1h, 3Eh ; 395fb
	DB 82h ; 39603
	ASCII "n" ; 39604
	DB 82h, 00h, 02h ; 39605
	ASCII "z" ; 39608
	DB 82h, 0Ch, 06h, 01h, 00h, 18h, 0B2h, 3Eh ; 39609
	DB 82h, 0CEh, 0D0h, 0B4h, 1Bh, 0CEh ; 39611
	ASCII "D" ; 39617
	DB 16h, 0B0h, 06h, 0CEh ; 39618
	ASCII "D" ; 3961c
	DB 0Eh, 0F8h, 0CEh, 0D0h, 0B4h, 1Bh, 0CEh ; 3961d
	ASCII "0" ; 39624
	DB 16h, 0E7h, 02h, 0F8h, 0CEh, 0D0h, 0B4h, 1Bh ; 39625
	DB 0CEh ; 3962d
	ASCII "D" ; 3962e
	DB 16h, 0CEh, 80h, 0B1h, 00h, 0C7h, 3Fh, 96h ; 3962f
	DB 0CFh ; 39637
	ASCII "B" ; 39638
	DB 0CFh, 0D8h, 0F2h, 7Fh, 0ECh, 0F8h, 0F6h, 95h ; 39639
	DB 04h, 96h, 12h, 96h, 1Fh, 96h, 0F4h, 95h ; 39641
	DB 0A6h, 0A2h, 0A3h, 0F2h, 86h, 8Ch, 0F2h, 3Eh ; 39649
	DB 8Ch, 0C4h, 0F2h, 82h, 0F2h ; 39651
	ASCII "q" ; 39656
	DB 0ECh, 0ABh, 0AAh, 0AEh, 0F8h, 0A6h, 0A2h, 0A3h ; 39657
	DB 0F2h, 8Dh, 8Ch, 0F2h, 2Bh, 8Ch, 0C4h, 0F2h ; 3965f
	DB 82h, 0F2h, 5Eh, 0ECh, 0ABh, 0AAh, 0AEh, 0F8h ; 39667
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3966f
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 39677
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3967f
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 39687
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3968f
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 39697
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 3969f
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 396a7
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 396af
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 396b7
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 396bf
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 396c7
	DB 0A6h, 0A2h, 0A3h, 0CFh, 0D9h, 0C3h, 02h, 00h ; 396cf
	DB 0CFh, 0DBh, 0CEh, 0C4h, 07h, 0F2h, 8Ch, 0ECh ; 396d7
	DB 0ABh, 0AAh, 0AEh, 0C3h, 04h, 00h, 0F8h, 0A6h ; 396df
	DB 0A2h, 0A3h, 0CFh, 0D9h, 0C3h, 02h, 00h, 0CFh ; 396e7
	DB 0DBh, 0CEh, 0C4h, 02h, 0F2h, 8Fh, 04h, 0ABh ; 396ef
	DB 0AAh, 0AEh, 0C3h, 04h, 00h, 0F8h, 0CFh, 0D8h ; 396f7
	DB 0BCh, 98h, 1Bh, 0C3h, 02h, 00h, 0F8h, 0CFh ; 396ff
	DB 0D8h, 0BCh, 9Ah, 1Bh, 0C3h, 02h, 00h, 0F8h ; 39707
	DB 0CFh, 0D8h, 0BCh, 9Ch, 1Bh, 0C3h, 02h, 00h ; 3970f
	DB 0F8h, 0B8h, 98h, 1Bh, 0CEh ; 39717
	ASCII "D" ; 3971c
	DB 0Ah, 0CEh ; 3971d
	ASCII "L" ; 3971f
	DB 0Bh, 0B8h, 9Ah, 1Bh, 0BCh, 9Ch, 1Bh, 0CEh ; 39720
	ASCII "D" ; 39728
	DB 08h, 0CEh ; 39729
	ASCII "L" ; 3972b
	DB 09h, 0F8h, 0B8h, 98h, 1Bh, 0CEh ; 3972c
	ASCII "D" ; 39732
	DB 0Ah, 0CEh ; 39733
	ASCII "L" ; 39735
	DB 0Bh, 0B8h, 9Ch, 1Bh, 0CEh ; 39736
	ASCII "D" ; 3973b
	DB 08h, 0CEh ; 3973c
	ASCII "L" ; 3973e
	DB 09h, 0F8h, 0CFh, 0D8h, 0BCh, 9Eh, 1Bh, 0C3h ; 3973f
	DB 02h, 00h, 0B0h, 01h, 0CEh, 0D4h, 0A0h, 1Bh ; 39747
	DB 0C4h, 0Bh, 98h, 0CEh ; 3974f
	ASCII "D" ; 39753
	DB 04h, 0CEh ; 39754
	ASCII "L" ; 39756
	DB 05h, 0B0h, 0FFh, 0CEh ; 39757
	ASCII "D" ; 3975b
	DB 06h, 0C5h, 0A5h, 1Bh, 0CEh, 2Dh, 01h, 0FAh ; 3975c
	DB 0A6h, 0A2h, 0A3h, 0C5h, 00h, 00h, 0C7h, 0FDh ; 39764
	DB 11h, 0CEh, 0C4h, 02h, 0F2h, 12h, 04h, 0ABh ; 3976c
	DB 0AAh, 0AEh, 0F8h, 0A6h, 0A2h, 0A3h, 0C5h, 00h ; 39774
	DB 00h, 0C7h, 0E3h, 11h, 0CEh, 0C4h, 02h, 0F2h ; 3977c
	DB 0FFh, 03h, 0ABh, 0AAh, 0AEh, 0F8h, 0C5h, 0A5h ; 39784
	DB 1Bh, 95h, 02h, 0EEh, 0Ah, 00h, 0B0h, 01h ; 3978c
	DB 0CEh ; 39794
	ASCII "D" ; 39795
	DB 06h, 0C3h, 0FEh, 0FFh, 0FAh, 0F8h, 0CEh, 0D0h ; 39796
	DB 0A6h, 1Bh ; 3979e
	ASCII "2" ; 397a0
	DB 0FFh, 0E6h, 0Ah, 0B1h, 00h, 0CEh, 80h, 0CFh ; 397a1
	ASCII "B" ; 397a9
	DB 0CFh, 0DBh, 0F8h, 0C3h, 0FEh, 0FFh, 0B0h, 01h ; 397aa
	DB 0CEh ; 397b2
	ASCII "D" ; 397b3
	DB 06h, 0FAh ; 397b4
	ASCII "G" ; 397b6
	DB 0CEh ; 397b7
	ASCII "D" ; 397b8
	DB 0Ah, 0C3h, 01h, 00h, 0F8h ; 397b9
	ASCII "G" ; 397be
	DB 0CEh ; 397bf
	ASCII "D" ; 397c0
	DB 0Bh, 0C3h, 01h, 00h, 0F8h, 0A3h, 0CEh, 0D0h ; 397c1
	DB 0A8h, 1Bh, 0B1h, 00h, 0C7h, 0DCh, 97h, 0CFh ; 397c9
	ASCII "BG" ; 397d1
	DB 0CEh, 0D4h, 0A9h, 1Bh, 0ABh, 0CEh ; 397d3
	ASCII "D" ; 397d9
	DB 0Bh, 0F8h, 08h, 08h, 08h, 03h, 04h, 06h ; 397da
	DB 02h, 06h, 0CEh, 0D0h, 0A8h, 1Bh, 0B1h, 00h ; 397e2
	DB 0CEh, 80h, 0CFh ; 397ea
	ASCII "B" ; 397ed
	DB 0CFh, 0DBh, 0F8h, 0B0h, 01h, 0CEh, 0D4h, 0A0h ; 397ee
	DB 1Bh, 0F8h, 0C5h ; 397f6
	ASCII "B" ; 397f9
	DB 16h, 95h, 02h, 0E6h, 07h, 0C5h, 0A0h, 1Bh ; 397fa
	DB 0B5h, 01h, 0F8h, 0C5h, 0A0h, 1Bh, 0B5h, 03h ; 39802
	DB 0F8h, 0C5h, 0A0h, 1Bh, 8Eh, 0E6h, 0Eh, 0B0h ; 3980a
	DB 0FFh, 0CEh ; 39812
	ASCII "D" ; 39814
	DB 06h ; 39815
	ASCII "8" ; 39816
	DB 0CEh ; 39817
	ASCII "D" ; 39818
	DB 0Ah, 0CEh ; 39819
	ASCII "D" ; 3981b
	DB 0Bh, 0F8h, 0F2h, 0D8h, 0FFh
; ---------------------- ; 3981c
loc_0x039821:
	PUSH IP ; 39821
	LD IY,[1B9Eh] ; 39822
	LD A,[IX+0Eh] ; 39825
	LD YP,A ; 39828
	LD A,[IY] ; 3982a
	POP IP ; 3982b
	CP A,#0F0h ; 3982c
	JRS C,loc_0x039847 ; 3982e
	AND A,#0Fh ; 39830
	SLA A ; 39832
	LD B,#00h ; 39834
	LD IY,#9932h ; 39836
	ADD IY,BA ; 39839
	LD HL,[IY] ; 3983b
	JP HL
; ---------------------- ; 3983d
loc_0x03983E:
	LD BA,[1B9Eh] ; 3983e
	INC BA ; 39841
	LD [1B9Eh],BA ; 39842
	JRS loc_0x039821
; ---------------------- ; 39845
loc_0x039847:
	LD BA,[1B9Eh] ; 39847
	LD [IX+0Ch],A ; 3984a
	LD [IX+0Dh],B ; 3984d
	INC BA ; 39850
	LD [1B9Eh],BA ; 39851
	LD A,#01h ; 39854
	LD [IX+0Ah],A ; 39856
	LD [IX+0Bh],A ; 39859
	LD BA,[1B9Ch] ; 3985c
	LD [IX+08h],A ; 3985f
	LD [IX+09h],B ; 39862
	INC A ; 39865
	LD [1B9Ch],BA ; 39866
	RET
; ---------------------- ; 39869
	DB 0F3h, 0D2h, 0FFh, 0B8h, 9Eh, 1Bh, 0BCh, 0A1h ; 3986a
	DB 1Bh, 0CEh, 40h, 0Eh, 0CEh, 0D4h, 0A3h, 1Bh ; 39872
	DB 0C4h, 0ACh, 1Bh, 0BCh, 9Eh, 1Bh, 0B0h, 00h ; 3987a
	DB 0CEh ; 39882
	ASCII "D" ; 39883
	DB 0Eh, 0CEh, 0C4h, 03h, 0F2h, 2Ah ; 39884
	ASCII "O" ; 3988a
	DB 0F3h, 0BAh, 0FFh
; ---------------------- ; 3988b
loc_0x03988E:
	LD BA,[1B9Eh] ; 3988e
	LD [1BA1h],BA ; 39891
	LD A,[IX+0Eh] ; 39894
	LD [1BA3h],A ; 39897
	LD A,[1BB2h] ; 3989b
	CP A,#01h ; 3989f
	JRS Z,loc_0x0398AA ; 398a1
	CP A,#02h ; 398a3
	JRS Z,loc_0x0398B3 ; 398a5
	JRL loc_0x039847
; ---------------------- ; 398a7
loc_0x0398AA:
	LD BA,#0A53Fh ; 398aa
	LD [1B9Eh],BA ; 398ad
	JRL loc_0x039847
; ---------------------- ; 398b0
loc_0x0398B3:
	LD BA,#0A542h ; 398b3
	LD [1B9Eh],BA ; 398b6
	JRL loc_0x039847
; ---------------------- ; 398b9
loc_0x0398BC:
	LD BA,[1B9Eh] ; 398bc
	LD [1BA1h],BA ; 398bf
	LD A,[IX+0Eh] ; 398c2
	LD [1BA3h],A ; 398c5
	LD A,[1AD7h] ; 398c9
	LD B,#00h ; 398cd
	SLA A ; 398cf
	LD IY,#98DEh ; 398d1
	ADD IY,BA ; 398d4
	LD BA,[IY] ; 398d6
	LD [1B9Eh],BA ; 398d8
	JRL loc_0x039847
; ---------------------- ; 398db
	ASCII "F" ; 398de
	DB 0A5h ; 398df
	ASCII "K" ; 398e0
	DB 0A5h ; 398e1
	ASCII "O" ; 398e2
	DB 0A5h, 0F3h ; 398e3
	ASCII "X" ; 398e5
	DB 0FFh, 0B8h, 0A1h, 1Bh, 0BCh, 9Eh, 1Bh, 0CEh ; 398e6
	DB 0D0h, 0A3h, 1Bh, 0CEh ; 398ee
	ASCII "D" ; 398f2
	DB 0Eh, 0F3h ; 398f3
	ASCII "H" ; 398f5
	DB 0FFh
; ---------------------- ; 398f6
loc_0x0398F7:
	LD A,[1B9Ah] ; 398f7
	LD [1B9Ch],A ; 398fb
	LD A,[1B9Dh] ; 398ff
	INC A ; 39903
	CP A,[1B99h] ; 39904
	JRS NZ,loc_0x03990D ; 39907
	LD A,[1B9Bh] ; 39909
loc_0x03990D:
	LD [1B9Dh],A ; 3990d
	JRL loc_0x03983E
; ---------------------- ; 39911
	DB 0C4h, 0EFh, 82h, 0CEh ; 39914
	ASCII "D" ; 39918
	DB 04h, 0CEh ; 39919
	ASCII "L" ; 3991b
	DB 05h ; 3991c
	ASCII "8" ; 3991d
	DB 0CEh ; 3991e
	ASCII "D" ; 3991f
	DB 0Ah, 0CEh ; 39920
	ASCII "D" ; 39922
	DB 0Bh, 0B0h, 01h, 0CEh ; 39923
	ASCII "D" ; 39927
	DB 06h, 0C5h, 0A5h, 1Bh, 0CEh, 25h, 0FEh, 0F3h ; 39928
	ASCII "8" ; 39930
	DB 0FFh ; 39931
	ASCII "m" ; 39932
	DB 98h, 8Eh, 98h, 0BCh, 98h ; 39933
	ASCII "j" ; 39938
	DB 98h ; 39939
	ASCII "j" ; 3993a
	DB 98h ; 3993b
	ASCII "j" ; 3993c
	DB 98h ; 3993d
	ASCII "j" ; 3993e
	DB 98h ; 3993f
	ASCII "j" ; 39940
	DB 98h ; 39941
	ASCII "j" ; 39942
	DB 98h ; 39943
	ASCII "j" ; 39944
	DB 98h ; 39945
	ASCII "j" ; 39946
	DB 98h ; 39947
	ASCII "j" ; 39948
	DB 98h, 0E4h, 98h, 0E7h, 98h, 0F7h, 98h, 14h ; 39949
	DB 99h, 0F1h, 97h, 0EFh, 82h ; 39951
	ASCII "F" ; 39956
	DB 9Ah, 0FDh, 96h, 08h, 08h, 06h, 97h, 00h ; 39957
	DB 00h, 0Fh, 97h, 00h, 00h, 18h, 97h, 01h ; 3995f
	DB 00h ; 39967
	ASCII "o" ; 39968
	DB 96h ; 39969
	ASCII "A" ; 3996a
	DB 97h, 99h, 0A4h ; 3996b
	ASCII "d" ; 3996e
	DB 97h, 8Ah, 97h, 18h, 97h, 01h, 00h ; 3996f
	ASCII "o" ; 39976
	DB 96h ; 39977
	ASCII "A" ; 39978
	DB 97h, 0B6h, 0A4h ; 39979
	ASCII "d" ; 3997c
	DB 97h, 8Ah, 97h, 18h, 97h, 01h, 00h ; 3997d
	ASCII "o" ; 39984
	DB 96h ; 39985
	ASCII "A" ; 39986
	DB 97h, 0CFh, 0A4h ; 39987
	ASCII "w" ; 3998a
	DB 97h, 8Ah, 97h, 18h, 97h, 01h, 00h ; 3998b
	ASCII "o" ; 39992
	DB 96h ; 39993
	ASCII "A" ; 39994
	DB 97h, 18h, 0A5h, 2Eh, 97h, 0BEh, 97h, 01h ; 39995
	DB 01h, 00h ; 3999d
	ASCII "7" ; 3999f
	DB 0A5h, 0E6h, 96h, 00h, 00h, 0D3h, 12h, 9Ch ; 399a0
	DB 97h, 0ADh, 99h, 8Eh, 99h, 18h, 97h, 01h ; 399a8
	DB 00h ; 399b0
	ASCII "o" ; 399b1
	DB 96h ; 399b2
	ASCII "A" ; 399b3
	DB 97h, 18h, 0A5h, 0CFh, 96h, 00h, 04h, 40h ; 399b4
	DB 9Ah, 0E6h, 96h, 00h, 00h ; 399bc
	ASCII "R" ; 399c1
	DB 13h, 9Ch, 97h, 0CBh, 99h, 0CFh, 99h, 0D3h ; 399c2
	DB 99h, 5Fh, 82h, 0D7h, 99h, 5Fh, 82h, 0D7h ; 399ca
	DB 99h, 5Fh, 82h, 0D7h, 99h, 18h, 97h, 01h ; 399d2
	DB 00h ; 399da
	ASCII "o" ; 399db
	DB 96h, 0E6h, 96h, 00h, 00h, 0D3h, 12h, 9Ch ; 399dc
	DB 97h, 0E9h, 99h, 0ADh, 99h, 18h, 97h, 01h ; 399e4
	DB 00h ; 399ec
	ASCII "o" ; 399ed
	DB 96h ; 399ee
	ASCII "A" ; 399ef
	DB 97h, 26h, 0A5h ; 399f0
	ASCII "d" ; 399f3
	DB 97h, 8Ah, 97h, 5Fh, 82h ; 399f4
	ASCII "d" ; 399f9
	DB 99h ; 399fa
	ASCII "8" ; 399fb
	DB 82h, 01h, 00h, 40h, 0A6h, 3Eh, 82h, 01h ; 399fc
	DB 00h, 7Ch, 0A6h, 3Eh, 82h, 01h, 00h, 0B8h ; 39a04
	DB 0A6h, 3Eh, 82h, 0C4h, 0Ch, 04h, 0CEh ; 39a0c
	ASCII "D" ; 39a13
	DB 0Ah, 0CEh ; 39a14
	ASCII "L" ; 39a16
	DB 0Bh, 0F8h, 0C5h ; 39a17
	ASCII "C" ; 39a1a
	DB 16h, 95h, 01h, 0E7h, 14h, 0CEh, 0D0h, 0A7h ; 39a1b
	DB 1Bh, 0CEh, 80h, 0B1h, 00h, 0C7h, 3Ah, 9Ah ; 39a23
	DB 0CFh ; 39a2b
	ASCII "B" ; 39a2c
	DB 0CFh, 0D8h, 0F2h, 8Bh, 0E8h, 0F8h, 0C4h, 0F2h ; 39a2d
	DB 82h, 0F2h, 90h, 0E8h, 0F8h, 0FDh, 99h, 03h ; 39a35
	DB 9Ah, 09h, 9Ah, 0Fh, 9Ah, 19h, 9Ah, 0FDh ; 39a3d
	DB 99h, 0FDh, 96h ; 39a45

	INCLUDE "dialogue.asm"