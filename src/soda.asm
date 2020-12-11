; これはテキストエディタを強制的にSHIFT JISモードにするために使われる日本語の一行です。

include "src/global.inc"

DEFSECT ".ram", CODE AT 1000H
SECT ".ram"

screenbuf: DS 2F8h
unk2F8: DS 8h
sprite_oam: DS 60h
tilemap: DS 100h

DEFSECT ".rom0", CODE AT 2100H
SECT ".rom0"
; ----------------------

	ASCII "MN"

; ---------------------- ; 2100
reset_vector:

	LD NB, #00h
	JRL __START

; ---------------------- ; 2105
prc_frame_copy_irq:

	LD NB, #00h
	JRL IRQ_FrameCopy

; ---------------------- ; 210b
prc_render_irq:

	LD NB, #00h
	JRL IRQ_Render

; ---------------------- ; 2111
timer_2h_underflow_irq:

	LD NB, #00h
	JRL IRQ_Timer2HI_Underflow

; ---------------------- ; 2117
timer_2l_underflow_irq:

	LD NB, #00h
	JRL IRQ_Timer2LO_Underflow

; ---------------------- ; 211d
timer_1h_underflow_irq:

	LD NB, #00h
	JRL IRQ_Timer1HI_Underflow

; ---------------------- ; 2123
timer_1l_underflow_irq:

	LD NB, #00h
	JRL IRQ_Timer1LO_Underflow

; ---------------------- ; 2129
timer_3h_underflow_irq:

	LD NB, #00h
	JRL IRQ_Timer3HI_Underflow

; ---------------------- ; 212f
timer_3_cmp_irq:

	LD NB, #00h
	JRL IRQ_Timer3Cmp

; ---------------------- ; 2135
timer_32hz_irq:

	LD NB, #00h
	JRL IRQ_Timer_32hz

; ---------------------- ; 213b
timer_8hz_irq:

	LD NB, #00h
	JRL IRQ_Timer_8hz

; ---------------------- ; 2141
timer_2hz_irq:

	LD NB, #00h
	JRL IRQ_Timer_2hz

; ---------------------- ; 2147
timer_1hz_irq:

	LD NB, #00h
	JRL IRQ_Timer_1hz

; ---------------------- ; 214d
ir_rx_irq:

	LD NB, #00h
	JRL IRQ_IR

; ---------------------- ; 2153
shake_irq:

	LD NB, #00h
	JRL IRQ_Shake

; ---------------------- ; 2159
key_power_irq:

	LD NB, #00h
	JRL loc_0x003571

; ---------------------- ; 215f
key_right_irq:

	LD NB, #00h
	JRL IRQ_KeyRight

; ---------------------- ; 2165
key_left_irq:

	LD NB, #00h
	JRL IRQ_KeyLeft

; ---------------------- ; 216b
key_down_irq:

	LD NB, #00h
	JRL IRQ_KeyDown

; ---------------------- ; 2171
key_up_irq:

	LD NB, #00h
	JRL IRQ_KeyUp

; ---------------------- ; 2177
key_c_irq:

	LD NB, #00h
	JRL IRQ_KeyC

; ---------------------- ; 217d
key_b_irq:

	LD NB, #00h
	JRL IRQ_KeyB

; ---------------------- ; 2183
key_a_irq:

	LD NB, #00h
	JRL IRQ_KeyA

; ---------------------- ; 2189
unknown_irq0:

	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A

; ---------------------- ; 2191
unknown_irq1:

	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A

; ---------------------- ; 2197
unknown_irq2:

	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A

; ---------------------- ; 219d
cartridge_irq:

	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A
	ADD A, A

; ---------------------- ; 21a3
	ASCII "NINTENDO" ; 21a4
	ASCII "MSDJ"
	ASCIZ "ｿﾀﾞﾃﾔｻﾝ"

	DB 00h, 00h, 00h, 00h

	ASCIZ "2P" ; 21bc

	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 21bf
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h ; 21c7
	DB 00h ; 21cf

; ---------------------- ; 21cf
loc_0x0021D0:

	XOR A, A

	LD [1687h], A

	PUSH L
	PUSH B
	MLT
	
	LD [1685h], HL
	
	POP A
	POP L
	MLT

	LD BA, [1686h]
	ADD BA, HL
	LD [1686h], BA

	LD BA, [1685h]
	LD L, [1687h]

	RET

; ---------------------- ; 21f3
loc_0x0021F4:

	; something to do with sleep mode?
	LD EP, #00h
	AND [BR:23h], #0BFh

	RET

; ---------------------- ; 21fa
loc_0x0021FB:

	LD EP, #00h

	; IRQ stuff
	LD A, [BR:20h]
	AND A, #3Fh
	OR A, #40h

	LD [BR:20h], A
	OR [BR:23h], #40h

	LD A, [BR:20h]
	AND A, #0FCh

	LD [BR:20h], A
	AND [BR:23h], #0FDh

	LD A, [BR:20h]
	AND A, #0CFh
	OR A, #20h
	LD [BR:20h], A
	OR [BR:23h], #20h

	LD A, [BR:21h]
	AND A, #3Fh
	OR A, #80h
	LD [BR:21h], A

	LD A, [1AB8h]
	AND A, A
	JRS Z, loc_0x00223A

	OR [BR:24h], #20h

	; 256hz timer enable
	OR [BR:40h], #02h
	LD A, #01h
	LD [163Ah], A

	JRS loc_0x002242

loc_0x00223A:

	AND [BR:24h],#0DFh ; 223a
	XOR A,A ; 223d
	LD [163Ah],A ; 223e

loc_0x002242:

	RET

; ---------------------- ; 2242
loc_0x002243:

	PUSH SC
	AND SC, #00111111b
	OR SC,  #10000000b

	PUSH EP

	LD EP, #00h

	; Set module address
	LD [1611h], HL
	LD [1613h], B

	POP EP
	POP SC

	RET

; ---------------------- ; 2255
loc_0x002256:

	PUSH SC ; 2256
	AND SC,#3Fh ; 2257
	OR SC,#80h ; 2259

	PUSH EP ; 225b

	LD EP,#00h ; 225c

	LD [1617h],HL ; 225f
	LD [1619h],B ; 2262

	POP EP ; 2266
	POP SC ; 2267

	RET

; ---------------------- ; 2266
loc_0x002269:

	PUSH SC ; 2269

	AND SC,#3Fh ; 226a
	OR SC,#80h ; 226c

	PUSH EP ; 226e

	LD EP,#00h ; 226f

	LD [161Ah],HL ; 2272
	LD [161Ch],B ; 2275

	POP EP ; 2279
	POP SC ; 227a

	RET

; ---------------------- ; 227b
loc_0x00227C:

	PUSH SC ; 227c

	AND SC,#3Fh ; 227d
	OR SC,#80h ; 227f

	PUSH EP ; 2281

	LD EP,#00h ; 2282

	LD [161Fh],HL ; 2285
	LD [1621h],B ; 2288

	POP EP ; 228c
	POP SC ; 228d

	RET

; ---------------------- ; 228e
loc_0x00228F:

	PUSH SC ; 228f

	AND SC,#3Fh ; 2290
	OR SC,#80h ; 2292

	PUSH EP ; 2294

	LD EP,#00h ; 2295

	LD [1622h],HL ; 2298
	LD [1624h],B ; 229b

	POP EP ; 229f

	LD IY,#141Dh ; 22a0
	LD NB,#02h ; 22a3
	CARL loc_0x011B84 ; 22a6

	POP SC ; 22a9

	RET

; ---------------------- ; 22aa
loc_0x0022AB:

	PUSH SC ; 22ab

	AND SC,#3Fh ; 22ac
	OR SC,#80h ; 22ae

	PUSH EP ; 22b0

	LD EP,#00h ; 22b1

	LD [1622h],HL ; 22b4
	LD [1624h],B ; 22b7

	POP EP ; 22bb

	LD IY,#14E8h ; 22bc
	LD NB,#02h ; 22bf
	CARL loc_0x011B84 ; 22c2

	POP SC ; 22c5

	RET

; ---------------------- ; 22c6
loc_0x0022C7:

	PUSH EP ; 22c7

	LD EP,#00h ; 22c8

	LD [1625h],HL ; 22cb
	LD [1627h],B ; 22ce

	POP EP ; 22d2

	RET

; ---------------------- ; 22d3
loc_0x0022D4:

	PUSH EP ; 22d4

	LD EP,#00h ; 22d5

	LD HL,[1625h] ; 22d8
	LD B,[1627h] ; 22db

	POP EP ; 22df

	RET

; ---------------------- ; 22e0
loc_0x0022E1:

	PUSH EP ; 22e1

	LD EP,#00h ; 22e2

	LD [1628h],HL ; 22e5
	LD [162Ah],B ; 22e8

	POP EP ; 22ec

	RET

; ---------------------- ; 22ed
loc_0x0022EE:

	PUSH EP ; 22ee

	LD EP,#00h ; 22ef

	LD HL,[1628h] ; 22f2
	LD B,[162Ah] ; 22f5

	POP EP ; 22f9

	RET

; ---------------------- ; 22f5
DoCurrentProc:

	LD EP,#00h ; 22fb
	LD HL,[1611h] ; 22fe
	LD A,[1613h] ; 2301

	LD NB,A ; 2305
	JP HL

; ---------------------- ; 2307
loc_0x002308:

	LD EP,#00h ; 2308
	LD HL,[1617h] ; 230b
	LD A,[1619h] ; 230e

	LD NB,A ; 2312
	JP HL

; ---------------------- ; 2314
loc_0x002315:

	LD EP,#00h ; 2315
	LD HL,[161Ah] ; 2318
	LD A,[161Ch] ; 231b

	LD NB,A ; 231f
	JP HL

; ---------------------- ; 2321
Main:

	LD EP,#00h ; 2322
	LD HL,[161Fh] ; 2325
	LD A,[1621h] ; 2328

	LD NB,A ; 232c
	JP HL

; ---------------------- ; 232e

; wait for PRC counter
WaitNextFrame:

	LD HL,#208Ah ; 232f

loc_0x002332:

	CP [HL],#41h ; 2332
	JRS C,loc_0x002332 ; 2335

	RET

; ---------------------- ; 2337
loc_0x002338:

	CARL WaitNextFrame ; 2338

	LD [BR:80h],#00h ; 233b

	RET

; ---------------------- ; 233e
loc_0x00233F:

	CARL WaitNextFrame ; 233f

	LD [BR:80h],#08h ; 2342

	RET

; ---------------------- ; 2345
loc_0x002346:

	LD HL, #1672h
	LD [HL], #01h

vblank_loop:

	BIT [HL], #0FFh
	JRS NZ, vblank_loop

	RET

; ---------------------- ; 234f
loc_0x002350:

	LD [IY], L
	INC IY

	DEC BA
	JRS NZ, loc_0x002350

	RET

; ----------------------
loc_0x002356:

	LD [IY],[IX] ; 2356

	INC IX ; 2357
	INC IY ; 2358

	DEC BA ; 2359

	JRS NZ,loc_0x002356 ; 235a

	RET

; ---------------------- ; 235c
loc_0x00235D:

	LD EP,#00h ; 235d
	LD XP,#00h ; 2360

	LD HL,#163Ch ; 2363
	LD IX,#163Bh ; 2366
	LD [IX],[HL] ; 2369

	LD A,[BR:52h] ; 236a
	XOR A,#0FFh ; 236c

	LD [HL],A ; 236e
	XOR A,[IX] ; 236f

	LD B,A ; 2370

	AND A,[HL] ; 2371
	LD [163Dh],A ; 2372

	LD A,B ; 2376

	AND A,[IX] ; 2377
	LD [163Eh],A ; 2378

	CP [HL],[IX] ; 237c
	JRS NZ,loc_0x0023A1 ; 237e

	LD A,[1640h] ; 2380
	DEC A ; 2384

	LD [1640h],A ; 2385
	JRS NZ,loc_0x00239A ; 2389

	LD A,[1648h] ; 238b
	LD [1640h],A ; 238f

	LD A,[HL] ; 2393
	LD [163Fh],A ; 2394

	JRS loc_0x0023B1

loc_0x00239A:

	XOR A,A ; 239a

	LD [163Fh],A ; 239b

	JRS loc_0x0023B1

loc_0x0023A1:

	LD A,[1647h] ; 23a1
	LD [1640h],A ; 23a5

	LD A,[163Dh] ; 23a9
	LD [163Fh],A ; 23ad

loc_0x0023B1:

	LD HL,#166Bh ; 23b1
	BIT [HL],#04h ; 23b4
	JRS Z,loc_0x0023CB ; 23b6

	LD BA,[163Bh] ; 23b8
	LD [1641h],BA ; 23bb

	LD BA,[163Dh] ; 23be
	LD [1643h],BA ; 23c1

	LD BA,[163Fh] ; 23c4
	LD [1645h],BA ; 23c7

	RET

loc_0x0023CB:

	LD BA,#0000h ; 23cb

	LD [1641h],BA ; 23ce
	LD [1643h],BA ; 23d1
	LD [1645h],BA ; 23d4

	RET

; ---------------------- ; 23d7
loc_0x0023D8:

	PUSH EP ; 23d8

	LD B,#00h ; 23d9

	ADD BA,BA ; 23db
	LD HL,BA ; 23dd

	ADD HL,#23E9h ; 23df
	LD EP,#00h ; 23e2

	LD BA,[HL] ; 23e5

	POP EP ; 23e7

	RET

; ---------------------- ; 23e8
	DB 01h, 00h, 02h, 00h, 04h, 00h, 08h, 00h ; 23e9
	DB 10h, 00h, 20h, 00h, 40h, 00h, 80h, 00h ; 23f1
	DB 00h, 01h, 00h, 02h, 00h, 04h, 00h, 08h ; 23f9
	DB 00h, 10h, 00h, 20h, 00h, 40h, 00h, 80h
; ---------------------- ; 2401
loc_0x002409:

	PUSH EP ; 2409

	LD EP,#02h ; 240a
	LD H,#00h ; 240d

	ADD HL,HL ; 240f
	ADD HL,#4A80h ; 2411

	LD BA,[HL] ; 2414

	POP EP ; 2416

	RET

; ---------------------- ; 2417
loc_0x002418:

	PUSH EP ; 2418

	LD EP,#02h ; 2419
	LD H,#00h ; 241c

	ADD HL,HL ; 241e
	ADD HL,#4A00h ; 2420

	LD BA,[HL] ; 2423

	POP EP ; 2425

	RET

; ---------------------- ; 2426
loc_0x002427:

	PUSH EP ; 2427

	LD EP,#02h ; 2428
	LD H,#00h ; 242b

	LD BA,HL ; 242d
	ADD HL,BA ; 242f
	ADD HL,BA ; 2431
	ADD HL,#4E43h ; 2433

	LD BA,[HL] ; 2436

	INC HL ; 2438
	INC HL ; 2439
	LD L,[HL] ; 243a

	LD H,#00h ; 243b

	POP EP ; 243d

	RET

; ---------------------- ; 243e
loc_0x00243F:

	PUSH EP ; 243f

	LD EP,#02h ; 2440
	LD H,#00h ; 2443

	LD BA,HL ; 2445
	ADD HL,BA ; 2447
	ADD HL,BA ; 2449
	ADD HL,#4D83h ; 244b

	LD BA,[HL] ; 244e

	INC HL ; 2450
	INC HL ; 2451
	LD L,[HL] ; 2452

	LD H,#00h ; 2453

	POP EP ; 2455

	RET

; ---------------------- ; 2456
loc_0x002457:

	PUSH EP ; 2457

	LD EP,#02h ; 2458
	LD H,#00h ; 245b
	ADD HL,#4C80h ; 245d

	LD A,[HL] ; 2460

	SRL A ; 2461
	SRL A ; 2463

	POP EP ; 2465

	RET
; ---------------------- ; 2466
loc_0x002467:

	LD HL,BA ; 2467

	BIT A,#80h ; 2469
	JRS Z,loc_0x00246F ; 246b

	NEG A ; 246d

loc_0x00246F:

	BIT B,#80h ; 246f
	JRS Z,loc_0x002475 ; 2471

	NEG B ; 2473

loc_0x002475:

	AND L,#80h ; 2475
	JRS Z,loc_0x0024B9 ; 2478

	LD L,#00h ; 247a
	AND H,#80h ; 247c
	JRS Z,loc_0x00249C ; 247f

	CP A,B ; 2481
	JRS Z,loc_0x002499 ; 2482

	JRS C,loc_0x00248F ; 2484

	LD H,B ; 2486
	DIV ; 2487

	CARL loc_0x002457 ; 2489

	ADD A,#0C0h ; 248c

	RET

loc_0x00248F:

	LD H,A ; 248f
	LD A,B ; 2490
	DIV ; 2491

	CARL loc_0x002457 ; 2493

	NEG A ; 2496

	RET

loc_0x002499:

	LD A,#0E0h ; 2499

	RET

loc_0x00249C:

	CP A,B ; 249c
	JRS Z,loc_0x0024B6 ; 249d

	JRS C,loc_0x0024AC ; 249f

	LD H,B ; 24a1
	DIV ; 24a2

	CARL loc_0x002457 ; 24a4

	NEG A ; 24a7
	ADD A,#0C0h ; 24a9

	RET

loc_0x0024AC:

	LD H,A ; 24ac
	LD A,B ; 24ad
	DIV ; 24ae

	CARL loc_0x002457 ; 24b0

	ADD A,#80h ; 24b3

	RET

loc_0x0024B6:

	LD A,#0A0h ; 24b6

	RET

loc_0x0024B9:

	LD L,#00h ; 24b9
	AND H,#80h ; 24bb
	JRS Z,loc_0x0024DB ; 24be

	CP A,B ; 24c0
	JRS Z,loc_0x0024D8 ; 24c1

	JRS C,loc_0x0024D0 ; 24c3

	LD H,B ; 24c5
	DIV ; 24c6

	CARL loc_0x002457 ; 24c8

	NEG A ; 24cb
	ADD A,#40h ; 24cd

	RET

loc_0x0024D0:

	LD H,A ; 24d0
	LD A,B ; 24d1
	DIV ; 24d2

	CARL loc_0x002457 ; 24d4

	RET

loc_0x0024D8:

	LD A,#20h ; 24d8

	RET

loc_0x0024DB:

	CP A,B ; 24db
	JRS Z,loc_0x0024F5 ; 24dc

	JRS C,loc_0x0024E9 ; 24de

	LD H,B ; 24e0
	DIV ; 24e1

	CARL loc_0x002457 ; 24e3

	ADD A,#40h ; 24e6

	RET

loc_0x0024E9:

	LD H,A ; 24e9
	LD A,B ; 24ea
	DIV ; 24eb

	CARL loc_0x002457 ; 24ed

	NEG A ; 24f0
	ADD A,#80h ; 24f2

	RET

loc_0x0024F5:

	LD A,#60h ; 24f5

	RET
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

loc_0x0024F8_pool:
	DB  1,  2,  4,  8,  16,  32,  64, 128

loc_0x002500_pool:
	DB -2, -3, -5, -9, -17, -33, -65, -129, -96

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   Args:
;     HL: base addr
;      A: index
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x002509:

	PUSH IP
	PUSH IY

	LD YP, #00h

	PUSH A

	SRL A
	SRL A
	SRL A

	LD B, #00h

	; HL = HL + (A * 8)
	ADD HL, BA

	POP A

	AND A, #07h
	LD B, #00h
	
	; IY = pool + (A % 8)
	LD IY, #loc_0x0024F8_pool
	ADD IY, BA

	; A = *HL & *IY
	LD A, [HL]
	AND A, [IY]

	POP IY
	POP IP

	; clobber??
	POP BA

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   Args:
;     HL: base addr
;      A: index
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x00252B:

	PUSH A
	PUSH IP
	PUSH IY

	LD YP, #00h

	PUSH A

	SRL A
	SRL A
	SRL A

	; HL = HL + (A * 8)
	LD B, #00h
	ADD HL, BA

	POP A

	AND A, #07h
	LD B, #00h

	; IY = pool + (A % 8)
	LD IY, #loc_0x0024F8_pool
	ADD IY, BA

	; *HL |= *IY
	OR [HL], [IY]

	POP IY
	POP IP

	POP A

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   Args:
;     HL: base addr
;      A: index
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x002550:

	PUSH A

	PUSH IP
	PUSH IY

	LD YP, #00h

	PUSH A

	SRL A
	SRL A
	SRL A

	; HL = HL + (A * 8)
	LD B, #00h
	ADD HL, BA

	POP A

	AND A, #07h
	LD B, #00h

	; IY = pool + (A % 8)
	LD IY, #loc_0x002500_pool
	ADD IY, BA

	; *HL |= *IY
	AND [HL], [IY]

	POP IY
	POP IP

	POP A

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Divides by 10
;   Args:
;      A: value
;   Returns:
;      A: remainder, lo nibble
;      B: quotient, lo nibble
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x002575:

	PUSH HL

	LD L, A

	LD H, #00
	LD A, #10
	DIV

	LD A, H
	LD B, L

	AND A, #15
	AND B, #15

	POP HL

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   Args:
;      A: index
;     IY: base addr
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x002586:

	LD B,#00h
	ADD IY,BA
	ADD IY,BA

	LD HL, [IY]

	JP HL

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Copies 32 bit value and increase IY
;   Args: 
;   L, H: lo
;   A, B: hi
;     IY: destination
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x00258F:

	LD [IY+0], L
	LD [IY+1], H
	LD [IY+2], A
	LD [IY+3], B

	ADD IY, #4

	RET

; ---------------------- ; 259e
loc_0x00259F:

	LD IY, #screenbuf
	LD YP, #00h
	LD L, #00h
	LD BA, #0300h
	CARL loc_0x002350

	RET

; ---------------------- ; 25ad
loc_0x0025AE:

	LD IY, #tilemap
	LD YP, #00h
	LD L, #00h
	LD BA, #0180h
	CARL loc_0x002350

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Zero memory until reaching end address
;   Args:
;     IY: end address
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x0025BD:

	XOR A, A
	LD HL, #tilemap

loc_0x0025C1:

	LD [HL], A
	INC HL
	INC A

	; HL - IY
	CP HL, IY
	JRS NZ, loc_0x0025C1

	RET

; ---------------------- ; 25c8
loc_0x0025C9:

	LD IY, #1420h
	JRS loc_0x0025BD

loc_0x0025CE:

	LD IY, #1420h
	JRS loc_0x0025BD

loc_0x0025D3:

	LD IY, #14E0h
	JRS loc_0x0025BD

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Zero out 8 evenly spaced 12 byte chunks
;   Args:
;     IY: distance between chunks
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x0025D8:

	XOR A, A

	LD HL, #tilemap
	
	LD B, #8

loc_0x0025DE:

	PUSH B

	LD B, #12

loc_0x0025E2:

	LD [HL], A
	INC HL

	INC A
	DJR NZ, loc_0x0025E2

	ADD HL, IY

	POP B
	DJR NZ, loc_0x0025DE

	RET

; ---------------------- ; 25ed
loc_0x0025EE:

	LD IY, #0
	JRS loc_0x0025D8

loc_0x0025F3:

	LD IY, #4
	JRS loc_0x0025D8

loc_0x0025F8:

	LD IY, #12
	JRS loc_0x0025D8

; ---------------------- ; 25fb
loc_0x0025FD:

	LD IY, #tilemap
	LD YP, #00h

loc_0x002603:

	PUSH B

loc_0x002605:

	LD [IY], [IX]

	INC IX

	INC IY
	DJR NZ, loc_0x002605

	POP B

	ADD IY, HL

	DEC A
	JRS NZ, loc_0x002603

	RET

; ---------------------- ; 2611
loc_0x002612:

	LD BA,#0C08h ; 2612
	LD HL,#0000h ; 2615

	JRS loc_0x0025FD

loc_0x00261A:

	LD BA,#0C10h ; 261a
	LD HL,#0000h ; 261d

	JRS loc_0x0025FD

loc_0x002622:

	LD BA,#0C08h ; 2622
	LD HL,#0004h ; 2625

	JRS loc_0x0025FD

loc_0x00262A:

	LD BA,#100Ch ; 262a
	LD HL,#0000h ; 262d

	JRS loc_0x0025FD

loc_0x002632:

	LD BA,#0C08h ; 2632
	LD HL,#000Ch ; 2635

	JRS loc_0x0025FD

loc_0x00263A:

	LD BA,#1808h ; 263a
	LD HL,#0000h ; 263d

	JRS loc_0x0025FD

loc_0x002642:

	LD BA,#0C08h ; 2642
	LD HL,#000Ch ; 2645

	JRS loc_0x0025FD

loc_0x00264A:

	LD BA,#1810h ; 264a
	LD HL,#0000h ; 264d

	JRS loc_0x0025FD

loc_0x002652:

	PUSH BA ; 2652

	LD A,#18h ; 2653
	SUB A,B ; 2655

	LD H,#00h ; 2656
	LD L,A ; 2658

	POP BA ; 2659

	JRS loc_0x0025FD

; ---------------------- ; 2659
loc_0x00265C:

	LD B,[1666h] ; 265c
	LD A,B ; 2660
	AND A,#03h ; 2661
	LD [1AB6h],A ; 2663

	SRL B ; 2667
	SRL B ; 2669
	LD A,B ; 266b
	AND A,#07h ; 266c
	LD [1AB7h],A ; 266e

	SRL B ; 2672
	SRL B ; 2674
	SRL B ; 2676
	AND A,#01h ; 2678
	LD [1AB8h],A ; 267a

	RET

; ---------------------- ; 267e
loc_0x00267F:

	PUSH ALE ; 267f

	CARL loc_0x005AB0 ; 2681

	LD [164Ah],BA ; 2684

	POP ALE ; 2687

	LD BA,[164Ah] ; 2689

	RET

; ---------------------- ; 268c
	DB 0CFh, 0B9h, 0F2h, 0F6h ; 268d
	ASCII "3" ; 2691
	DB 0BCh ; 2692
	ASCII "J" ; 2693
	DB 16h, 0CFh, 0BDh, 0B8h ; 2694
	ASCII "J" ; 2698
	DB 16h, 0F8h
; ---------------------- ; 2699
loc_0x00269B:

	PUSH ALE ; 269b

	CARL loc_0x005AC9 ; 269d

	LD [164Ah],BA ; 26a0

	POP ALE ; 26a3

	LD BA,[164Ah] ; 26a5

	RET

; ---------------------- ; 26a8
loc_0x0026A9:

	PUSH ALE ; 26a9

	CARL loc_0x00424F ; 26ab

	LD [164Ah],BA ; 26ae

	POP ALE ; 26b1

	LD BA,[164Ah] ; 26b3

	RET

; ---------------------- ; 26b6
loc_0x0026B7:

	LD A,[1665h] ; 26b7
	BIT A,#04h ; 26bb
	JRS Z,loc_0x0026C5 ; 26bd

	LD A,#0FFh ; 26bf
	LD [1AB5h],A ; 26c1

loc_0x0026C5:

	RET

; ---------------------- ; 26c5
loc_0x0026C6:

	LD EP,#00h ; 26c6
	LD A,[1AB5h] ; 26c9
	AND A,A ; 26cd
	JRS NZ,loc_0x0026FB ; 26ce

	PUSH IP ; 26d0
	PUSH IY ; 26d1

	LD A,[1AB6h] ; 26d2
	LD B,#00h ; 26d6

	LD IY,#2705h ; 26d8
	LD YP,#00h ; 26db
	ADD IY,BA ; 26de
	LD A,[IY] ; 26e0
	LD [1508h],A ; 26e1

	LD A,[1AB7h] ; 26e5
	LD B,#00h ; 26e9

	LD IY,#2708h ; 26eb
	LD YP,#00h ; 26ee
	ADD IY,BA ; 26f1
	LD A,[IY] ; 26f3
	LD [1507h],A ; 26f4

	POP IY ; 26f8
	POP IP ; 26f9

	RET

; ---------------------- ; 26fa
loc_0x0026FB:

	XOR A,A ; 26fb
	LD [1508h],A ; 26fc
	LD [1507h],A ; 2700

	RET

; ---------------------- ; 2704
	DB 00h, 01h, 03h, 00h, 81h, 83h, 01h, 03h ; 2705
	DB 0CFh, 0B9h, 0F2h, 2Eh, 1Ch, 0BCh ; 270d
	ASCII "J" ; 2713
	DB 16h, 0CFh, 0BDh, 0B8h ; 2714
	ASCII "J" ; 2718
	DB 16h, 0F8h, 0CFh, 0B9h, 0F2h ; 2719
	ASCII "n" ; 271e
	DB 1Ch, 0BCh ; 271f
	ASCII "J" ; 2721
	DB 16h, 0CFh, 0BDh, 0B8h ; 2722
	ASCII "J" ; 2726
	DB 16h, 0F8h, 0CFh, 0B9h, 0F2h ; 2727
	ASCII "2" ; 272c
	DB 1Dh, 0BCh ; 272d
	ASCII "J" ; 272f
	DB 16h, 0CFh, 0BDh, 0B8h ; 2730
	ASCII "J" ; 2734
	DB 16h, 0F8h, 0CFh, 0B9h, 0F2h, 0A4h, 1Dh, 0BCh ; 2735
	ASCII "J" ; 273d
	DB 16h, 0CFh, 0BDh, 0B8h ; 273e
	ASCII "J" ; 2742
	DB 16h, 0F8h
; ---------------------- ; 2743
loc_0x002745:

	PUSH ALE ; 2745

	CARL loc_0x0044F5 ; 2747

	LD [164Ah],BA ; 274a

	POP ALE ; 274d

	LD BA,[164Ah] ; 274f

	RET

; ---------------------- ; 2752
	DB 0B2h, 11h, 0CEh, 0D8h, 0CFh, 0E9h, 0C2h ; 2753
	ASCII "9" ; 275a
	DB 15h, 0A2h, 0C2h, 01h, 00h, 0CEh, 0C6h, 00h ; 275b
	DB 0F2h, 0A8h, 0FFh, 0AAh, 0CEh, 0C6h, 00h, 0CEh ; 2763
	ASCIZ "D" ; 276b
	DB 0F8h, 0C6h ; 276d
	ASCII "9" ; 276f
	DB 15h ; 2770
	ASCII "8" ; 2771
	DB 0CFh, 0B0h, 0A2h, 0C2h, 01h, 00h, 0CEh, 0C6h ; 2772
	DB 00h, 0F2h, 90h, 0FFh, 0AAh, 0CEh, 0C6h, 00h ; 277a
	DB 0CEh ; 2782
	ASCIZ "D" ; 2783
	DB 0CFh, 0B4h, 0C2h, 11h, 00h, 80h ; 2785
	ASCII "2" ; 278b
	DB 06h, 0E7h, 0E4h, 0F8h, 0C5h, 3Ah, 15h, 0CEh ; 278c
	DB 0C5h, 00h, 0B0h, 00h, 0CFh, 0B0h, 0A1h, 0C6h ; 2794
	DB 0ACh, 21h, 0CEh, 0C6h, 00h, 0B1h, 10h, 0CEh ; 279c
	ASCII "6" ; 27a4
	DB 0E7h, 07h, 91h, 92h, 0F5h, 0F9h, 0F1h, 10h ; 27a5
	DB 0A9h, 0CFh, 0B4h, 0C1h, 11h, 00h, 80h ; 27ad
	ASCII "2" ; 27b4
	DB 06h, 0E7h, 0E1h, 0B0h, 0FFh, 20h, 0F8h ; 27b5
	ASCII "8" ; 27bc
	DB 0A9h, 0CFh, 0B4h, 0F8h, 0A6h, 0A3h, 0C7h ; 27bd
	ASCII "9" ; 27c4
	DB 15h, 0CEh, 0C7h, 00h, 0B1h, 00h, 0CEh ; 27c5
	ASCIZ "A" ; 27cc
	ASCII "2" ; 27ce
	DB 05h, 0E6h, 0Fh, 0C3h, 11h, 00h, 81h, 0CEh ; 27cf
	DB 0BCh, 06h, 0E7h, 0F1h, 0ABh, 0AEh, 0B0h, 0FFh ; 27d7
	DB 0F8h, 0ABh, 0AEh ; 27df
	ASCII "A" ; 27e2
	DB 0F8h, 0B2h, 11h, 0CEh, 0D8h, 0CFh, 0EDh, 0C3h ; 27e3
	DB 3Ah, 15h, 0CEh, 0C7h, 00h, 0B1h, 10h ; 27eb
	ASCII "v" ; 27f2
	DB 92h, 93h, 0F5h, 0FCh, 0F8h, 0B2h, 11h, 0CEh ; 27f3
	DB 0D8h, 0CFh, 0E9h, 0C2h, 3Ah, 15h, 0CEh, 0C6h ; 27fb
	DB 00h, 0F2h, 15h, 0FFh, 0F8h, 0C6h, 0ACh, 21h ; 2803
	DB 0CEh, 0C6h, 00h, 0CFh, 0D0h, 0BCh, 9Fh, 15h ; 280b
	DB 0C2h, 02h, 00h, 0CFh, 0D0h, 0BCh, 0A1h, 15h ; 2813
	DB 0C4h, 00h, 00h, 0BCh, 0A3h, 15h, 0C4h, 0B5h ; 281b
	DB 1Ah, 0BCh, 0A5h, 15h, 0B0h, 00h, 0CEh, 0D4h ; 2823
	DB 0A7h, 15h, 0C4h ; 282b
	ASCIZ "Z" ; 282e
	DB 0BCh, 0A8h, 15h, 0CEh, 0D0h, 8Ch, 16h ; 2830
	ASCII "2" ; 2837
	DB 0FFh, 0E6h, 0Bh, 0C6h, 9Fh, 15h, 0CEh, 0C6h ; 2838
	DB 00h, 0F2h, 0F4h, 0FEh, 0F8h ; 2840
	ASCII "8" ; 2845
	DB 0F8h
; ---------------------- ; 2846
loc_0x002847:

	PUSH IY ; 2847
	PUSH IX ; 2848

	LD IY,#0058h ; 2849
	LD HL,#1AB5h ; 284c
	LD IX,#0000h ; 284f
	LD B,#00h ; 2852

loc_0x002854:

	LD A,[HL] ; 2854
	ADD IX,BA ; 2855
	INC HL ; 2857
	DEC IY ; 2858
	JRS NZ,loc_0x002854 ; 2859

	LD [1B0Dh],IX ; 285b

	POP IX ; 285e
	POP IY ; 285f

	RET

; ---------------------- ; 2860
	DB 0A3h, 0A2h, 0C7h ; 2861
	ASCIZ "X" ; 2864
	DB 0C5h, 0B5h, 1Ah, 0C6h, 00h, 00h, 0B1h, 00h ; 2866
	ASCII "E" ; 286e
	DB 0CFh, 40h, 91h, 9Bh, 0E7h, 0FAh, 0B9h, 0Dh ; 286f
	DB 1Bh, 0CFh, 3Ah, 0AAh, 0ABh, 0F8h
; ---------------------- ; 2877
loc_0x00287D:

	CARL loc_0x002847 ; 287d
	LD IX,#21ACh ; 2880
	LD XP,#00h ; 2883
	LD BA,[IX] ; 2886
	LD [159Fh],BA ; 2888

	ADD IX,#0002h ; 288b

	LD BA,[IX] ; 288e
	LD [15A1h],BA ; 2890

	LD BA,#0000h ; 2893
	LD [15A3h],BA ; 2896

	LD BA,#1AB5h ; 2899
	LD [15A5h],BA ; 289c

	LD A,#00h ; 289f
	LD [15A7h],A ; 28a1

	LD BA,#005Ah ; 28a5
	LD [15A8h],BA ; 28a8

	LD A,[168Ch] ; 28ab
	CP A,#0FFh ; 28af
	JRS Z,loc_0x0028BD ; 28b1

	LD IX,#159Fh ; 28b3
	LD XP,#00h ; 28b6

	CARL loc_0x002745 ; 28b9

	RET

; ---------------------- ; 28bc
loc_0x0028BD:

	XOR A,A ; 28bd

	RET

; ---------------------- ; 28be
	DB 0A0h, 0F2h, 85h, 0FFh, 0C6h, 0ACh, 21h, 0CEh ; 28bf
	DB 0C6h, 00h, 0CFh, 0D0h, 0BCh, 9Fh, 15h, 0C2h ; 28c7
	DB 02h, 00h, 0CFh, 0D0h, 0BCh, 0A1h, 15h, 0C4h ; 28cf
	DB 00h, 00h, 0BCh, 0A3h, 15h, 0C4h, 0B5h, 1Ah ; 28d7
	DB 0BCh, 0A5h, 15h, 0B0h, 00h, 0CEh, 0D4h, 0A7h ; 28df
	DB 15h, 0A8h, 0BCh, 0A8h, 15h, 0CEh, 0D0h, 8Ch ; 28e7
	DB 16h ; 28ef
	ASCII "2" ; 28f0
	DB 0FFh, 0E6h ; 28f1
	ASCII "J" ; 28f3
	DB 0C6h, 9Fh, 15h, 0CEh, 0C6h, 00h, 0F2h ; 28f4
	ASCII "I" ; 28fb
	DB 0FEh, 0C6h, 0ACh, 21h, 0CEh, 0C6h, 00h, 0CFh ; 28fc
	DB 0D0h, 0BCh, 9Fh, 15h, 0C2h, 02h, 00h, 0CFh ; 2904
	DB 0D0h, 0BCh, 0A1h, 15h, 0C4h, 0Dh, 1Bh, 0D0h ; 290c
	DB 0B5h, 1Ah, 0BCh, 0A3h, 15h, 0C4h, 0Dh, 1Bh ; 2914
	DB 0BCh, 0A5h, 15h, 0B0h, 00h, 0CEh, 0D4h, 0A7h ; 291c
	DB 15h, 0C4h, 08h, 00h, 0BCh, 0A8h, 15h, 0CEh ; 2924
	DB 0D0h, 8Ch, 16h ; 292c
	ASCII "2" ; 292f
	DB 0FFh, 0E6h, 0Bh, 0C6h, 9Fh, 15h, 0CEh, 0C6h ; 2930
	DB 00h, 0F2h, 0Ah, 0FEh, 0F8h ; 2938
	ASCII "8" ; 293d
	DB 0F8h, 0CFh, 0B0h, 0B2h, 11h, 0CEh, 0D8h, 0CFh ; 293e
	DB 0E9h, 0C2h, 3Ah, 15h, 0CEh, 0C6h, 00h, 0A2h ; 2946
	DB 0F2h, 0D9h, 0FDh, 0ABh, 0CFh, 0B5h ; 294e
	ASCII "8" ; 2954
	DB 0CFh, 0B0h, 0CFh, 0B1h, 0A3h ; 2955
	ASCII "1" ; 295a
	DB 0E6h, 20h, 0B2h, 11h, 0CEh, 0D8h, 0C1h, 3Ah ; 295b
	DB 15h, 0CEh, 0C6h, 00h, 0CEh, 0C7h, 00h, 0CEh ; 2963
	DB 0C5h, 00h, 0CFh, 0E9h, 0B1h, 10h, 0CEh ; 296b
	ASCII "7" ; 2972
	DB 0E7h, 08h, 91h, 93h, 0F5h, 0F9h, 0F2h, 0AEh ; 2973
	DB 0FDh, 0ABh, 0CFh, 0B5h, 0CFh, 0B4h, 80h ; 297b
	ASCII "2" ; 2982
	DB 06h, 0E7h, 0D0h, 0F8h
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   called every frame

	sleep_timeout EQU 5460h
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x002987:

	; flag
	LD HL,#166Bh ; 2987
	BIT [HL],#01h ; 298a
	JRS Z,loc_0x0029BD ; 298c

	LD A,[163Ch] ; 298e
	CP A,#07h ; 2992
	JRS NZ,loc_0x0029B2 ; 2994

	LD HL,#166Ch ; 2996
	BIT [HL],#01h ; 2999
	JRS NZ,loc_0x0029BD ; 299b

	LD HL,#166Ah ; 299d
	INC [HL] ; 29a0

	CP [HL],#12h ; 29a1
	JRS NZ,loc_0x0029BD ; 29a4

	LD HL,#166Ch ; 29a6
	OR [HL],#01h ; 29a9

	LD NB,#00h ; 29ac
	JRL loc_0x002BE3

; ---------------------- ; 29af
loc_0x0029B2:

	XOR A,A ; 29b2
	LD [166Ah],A ; 29b3

	LD HL,#166Ch ; 29b7
	AND [HL],#0FEh ; 29ba

loc_0x0029BD:

	; load input register
	LD A,[BR:52h] ; 29bd

	; clear upper bits, leave only A button
	XOR A,#0FFh ; 29bf

	LD [1649h],A ; 29c1

	; was A pressed?
	LD A,[1649h] ; 29c5
	AND A,A ; 29c9
	JRS Z,Timeout_A_NotPressed ; 29ca

	; A pressed
	LD BA,#0000h ; 29cc
	LD [1667h],BA ; 29cf
	JRS Timeout_A_Pressed

Timeout_A_NotPressed:

	LD BA,[1667h] ; 29d4
	INC BA ; 29d7
	LD [1667h],BA ; 29d8

	; did we reach the number of timeout frames?
	CP BA, #sleep_timeout
	JRL Z, Timeout_Sleep

Timeout_A_Pressed:

	LD HL, #1649h ; 29e1
	BIT [HL], #80h ; 29e4
	JRS Z, loc_0x0029F2 ; 29e6

	LD HL ,#1669h ; 29e8
	INC [HL] ; 29eb
	CP [HL], #02h ; 29ec

	JRS Z, Timeout_Sleep ; 29ef

	RET

; ---------------------- ; 29f1
loc_0x0029F2:

	XOR A,A ; 29f2
	
	; simulate power press?
	LD [1669h], A
	LD HL, #166Ch
	AND [HL], #11110001b

	RET

; ---------------------- ; 29fd
Timeout_Sleep:

	LD HL,#166Bh ; 29fe
	BIT [HL],#02h ; 2a01
	JRL NZ,loc_0x002A4E ; 2a03

	LD HL,#166Bh ; 2a06
	BIT [HL],#08h ; 2a09
	JRL NZ,loc_0x002ABB ; 2a0b

	LD HL,#166Ch ; 2a0e
	BIT [HL],#04h ; 2a11
	JRS NZ,loc_0x002A4D ; 2a13

	OR [HL],#04h ; 2a15

	LD A,[1AB6h] ; 2a18
	AND A,A ; 2a1c
	JRS Z,loc_0x002A25 ; 2a1d

	LD A,#21h ; 2a1f
	LD [14FAh],A ; 2a21

loc_0x002A25:

	CARL WaitNextFrame ; 2a25
	CARL loc_0x0021F4 ; 2a28
	CARL loc_0x002338 ; 2a2b

	XOR A,A ; 2a2e
	CARL loc_0x00269B ; 2a2f
	CARL loc_0x003B77 ; 2a32

	LD A,#00h ; 2a35
	LD B,#00h ; 2a37
	CARL loc_0x0026A9 ; 2a39
	CARL loc_0x00287D ; 2a3c
	CARL loc_0x004B13 ; 2a3f
	CARL loc_0x0059F6 ; 2a42
	CARL loc_0x00422C ; 2a45
	CARL loc_0x0046A4 ; 2a48

	INT [48h] ; 2a4b

loc_0x002A4D:

	RET

; ---------------------- ; 2a4d
loc_0x002A4E:

	LD HL,#166Ch ; 2a4e
	BIT [HL],#02h ; 2a51
	JRL NZ,loc_0x002ABA ; 2a53

	OR [HL],#02h ; 2a56
	LD BA,#0000h ; 2a59
	LD [1669h],A ; 2a5c
	LD [1667h],BA ; 2a60

	LD A,[1AB6h] ; 2a63
	AND A,A ; 2a67
	JRS Z,loc_0x002A70 ; 2a68

	LD A,#21h ; 2a6a
	LD [14FAh],A ; 2a6c

loc_0x002A70:

	CARL WaitNextFrame ; 2a70

	LD A,#00h ; 2a73
	LD B,#00h ; 2a75
	CARL loc_0x0026A9 ; 2a77
	CARL loc_0x0021F4 ; 2a7a
	CARL loc_0x003B77 ; 2a7d

	XOR A,A ; 2a80
	CARL loc_0x00269B ; 2a81
	CARL loc_0x00287D ; 2a84

	INT [42h] ; 2a87
	LD EP,#00h ; 2a89

	LD A,[BR:52h] ; 2a8c
	XOR A,#0FFh ; 2a8e
	LD [1665h],A ; 2a90

	CARL loc_0x0026B7 ; 2a94
	CARL loc_0x0026C6 ; 2a97
	CARL WaitNextFrame ; 2a9a

	LD A,#12h ; 2a9d
	CARL loc_0x00269B ; 2a9f

	LD B,#24h ; 2aa2

loc_0x002AA4:

	PUSH B ; 2aa4
	CARL WaitNextFrame ; 2aa6
	POP B ; 2aa9

	DJR NZ,loc_0x002AA4 ; 2aab

	CARL WaitNextFrame ; 2aad

	LD A,[1B0Fh] ; 2ab0
	CARL loc_0x00269B ; 2ab4
	CARL loc_0x0021FB ; 2ab7

loc_0x002ABA:

	RET

; ---------------------- ; 2aba
loc_0x002ABB:
	LD HL,#166Ch ; 2abb
	BIT [HL],#08h ; 2abe
	JRL NZ,loc_0x002BDB ; 2ac0
	
	OR [HL],#08h ; 2ac3
	LD BA,#0000h ; 2ac6
	LD [1669h],A ; 2ac9
	LD [1667h],BA ; 2acd

	LD A,[1AB6h] ; 2ad0
	AND A,A ; 2ad4
	JRS Z,loc_0x002ADD ; 2ad5
	
	LD A,#21h ; 2ad7
	LD [14FAh],A ; 2ad9

loc_0x002ADD:

	CARL WaitNextFrame ; 2add

	LD A,#00h ; 2ae0
	LD B,#00h ; 2ae2
	CARL loc_0x0026A9 ; 2ae4
	CARL loc_0x0021F4 ; 2ae7
	CARL loc_0x003B77 ; 2aea

	XOR A,A ; 2aed
	CARL loc_0x00269B ; 2aee

	LD A,[1B2Bh] ; 2af1
	CP A,#00h ; 2af5
	JRS Z,loc_0x002B0F ; 2af7

	CP A,#04h ; 2af9
	JRS NZ,loc_0x002B09 ; 2afb

	LD NB,#02h ; 2afd
	CARL loc_0x012F7C ; 2b00

	LD NB,#02h ; 2b03
	CARL loc_0x013612 ; 2b06

loc_0x002B09:

	LD NB,#02h ; 2b09
	CARL loc_0x012FE8 ; 2b0c

loc_0x002B0F:

	XOR A,A ; 2b0f
	LD [1B2Bh],A ; 2b10
	LD NB,#03h ; 2b14
	CARL loc_0x018BC5 ; 2b17
	CARL loc_0x00287D ; 2b1a

	LD EP,#00h ; 2b1d
	LD BR,#20h ; 2b20

loc_0x002B22:
	BIT [BR:52h],#80h ; 2b22
	JRS Z,loc_0x002B22 ; 2b25

	AND [BR:23h],#00h ; 2b27
	AND [BR:24h],#03h ; 2b2a
	AND [BR:25h],#00h ; 2b2d
	AND [BR:26h],#0BFh ; 2b30
	OR [BR:29h],#80h ; 2b33
	OR [BR:25h],#80h ; 2b36
	OR [BR:21h],#3Bh ; 2b39
	XOR A,A ; 2b3c
	LD [161Dh],A ; 2b3d

	LD HL,#2BF2h ; 2b41
	LD B,#00h ; 2b44
	CARL loc_0x002269 ; 2b46

	LD [BR:30h],#80h ; 2b49
	LD BA,#0FFFFh ; 2b4c
	LD [2032h],BA ; 2b4f

	LD [BR:18h],#0Fh ; 2b52
	OR [BR:19h],#11h ; 2b55
	LD [BR:27h],#08h ; 2b58
	OR [BR:20h],#08h ; 2b5b
	OR [BR:23h],#08h ; 2b5e
	OR [BR:30h],#04h ; 2b61
	OR [BR:30h],#02h ; 2b64
	AND [BR:80h],#0F7h ; 2b67

	INT [44h] ; 2b6a
	INT [56h] ; 2b6c

	AND [BR:25h],#7Fh ; 2b6e
	AND [BR:21h],#0F3h ; 2b71
	AND [BR:23h],#0FBh ; 2b74
	AND [BR:20h],#0F3h ; 2b77

	LD A,[161Dh] ; 2b7a
	OR A,A ; 2b7e
	JRS Z,loc_0x002BA1 ; 2b7f

	LD NB,#03h ; 2b81
	CARL loc_0x018A86 ; 2b84

	LD [1B2Bh],A ; 2b87
	OR A,A ; 2b8b
	JRS Z,loc_0x002B22 ; 2b8c

	LD A,[15ADh] ; 2b8e
	CP A,#07h ; 2b92
	JRS C,loc_0x002B9A ; 2b94

	CP A,#15h ; 2b96
	JRS C,loc_0x002BA6 ; 2b98

loc_0x002B9A:

	XOR A,A ; 2b9a
	LD [1B2Bh],A ; 2b9b
	JRS loc_0x002B22
; ---------------------- ; 2b9f
loc_0x002BA1:

	LD HL,#8639h ; 2ba1
	JRS loc_0x002BB5
; ---------------------- ; 2ba4
loc_0x002BA6:

	LD NB,#03h ; 2ba6
	CARL loc_0x018DBB ; 2ba9

	LD BA,#5190h ; 2bac
	LD [1667h],BA ; 2baf
	LD HL,#86B8h ; 2bb2

loc_0x002BB5:

	LD B,#03h ; 2bb5
	CARL loc_0x00227C ; 2bb7

	LD EP,#00h ; 2bba
	LD A,[BR:52h] ; 2bbd
	XOR A,#0FFh ; 2bbf
	LD [1665h],A ; 2bc1

	CARL loc_0x0026B7 ; 2bc5
	CARL loc_0x0026C6 ; 2bc8
	CARL loc_0x003B86 ; 2bcb

	XOR A,A ; 2bce
	LD [1642h],A ; 2bcf
	LD [1645h],A ; 2bd3
	LD [1643h],A ; 2bd7

loc_0x002BDB:

	RET

; ---------------------- ; 2bdb
	DB 0F2h ; 2bdc
	ASCII "a" ; 2bdd
	DB 0F7h, 0F2h, 1Ah, 0F6h, 0F8h
; ---------------------- ; 2bde
loc_0x002BE3:

	AND SC,#3Fh ; 2be3
	OR SC,#80h ; 2be5
	LD HL,#9E15h ; 2be7
	LD B,#03h ; 2bea
	CARL loc_0x00228F ; 2bec

	AND SC,#3Fh ; 2bef

	RET

; ---------------------- ; 2bf1
	DB 0B0h, 01h, 0CEh, 0D4h, 1Dh, 16h, 0F8h, 0CEh ; 2bf2
	DB 0C5h, 00h ; 2bfa
	ASCII "8" ; 2bfc
	DB 0CEh, 0D4h ; 2bfd
	ASCII "N" ; 2bff
	DB 16h, 0CEh, 0D4h ; 2c00
	ASCII "O" ; 2c03
	DB 16h, 0C4h, 00h, 00h, 0BCh ; 2c04
	ASCII "T" ; 2c09
	DB 16h, 0CEh, 0D4h ; 2c0a
	ASCII "V" ; 2c0d
	DB 16h, 0C4h, 00h, 00h, 0BCh ; 2c0e
	ASCII "Y" ; 2c13
	DB 16h, 0BCh, 5Bh, 16h, 0D0h, 10h, 00h, 0BCh ; 2c14
	DB 5Dh, 16h, 0BCh, 5Fh, 16h, 0F8h
loc_0x002C22:
	DB 0A6h, 0A3h ; 2c1c
	DB 0CEh, 0C5h, 00h, 0CEh, 0D4h ; 2c24
	ASCII "N" ; 2c29
	DB 16h, 0CEh, 0D5h ; 2c2a
	ASCII "O" ; 2c2d
	DB 16h ; 2c2e
	ASCII "2" ; 2c2f
	DB 19h, 0E5h, 0Ah, 0CEh, 0BCh, 11h, 0E5h, 05h ; 2c30
	DB 0B0h, 00h, 0F1h, 03h, 0B0h, 01h, 0CEh, 0D4h ; 2c38
	ASCII "M" ; 2c40
	DB 16h, 0BEh ; 2c41
	ASCII "T" ; 2c43
	DB 16h, 0CEh, 0CAh, 0CEh, 0D4h ; 2c44
	ASCII "V" ; 2c49
	DB 16h, 0CEh, 0D0h ; 2c4a
	ASCII "N" ; 2c4d
	DB 16h, 0B1h, 00h, 0CEh, 80h, 0CEh, 91h, 0CEh ; 2c4e
	DB 80h, 0CEh, 91h, 0CEh, 80h, 0CEh, 91h, 0D0h ; 2c56
	DB 60h, 00h, 0BCh ; 2c5e
	ASCII "P" ; 2c61
	DB 16h, 0CEh, 0D0h ; 2c62
	ASCII "O" ; 2c65
	DB 16h, 0B1h, 00h, 0CEh, 80h, 0CEh, 91h, 0CEh ; 2c66
	DB 80h, 0CEh, 91h, 0CEh, 80h, 0CEh, 91h, 0D0h ; 2c6e
	DB 40h, 00h, 0BCh ; 2c76
	ASCII "R" ; 2c79
	DB 16h, 0ABh, 0AEh, 0F8h, 0A6h, 0A3h, 0CEh, 0C5h ; 2c7a
	DB 00h, 0CFh, 0B1h, 0B1h, 00h, 0CEh, 80h, 0CEh ; 2c82
	DB 91h, 0CEh, 80h, 0CEh, 91h, 0CEh, 80h, 0CEh ; 2c8a
	DB 91h, 0D0h, 60h, 00h, 0BCh ; 2c92
	ASCII "P" ; 2c97
	DB 16h, 0CFh, 0B4h, 0B1h, 00h, 0CEh, 80h, 0CEh ; 2c98
	DB 91h, 0CEh, 80h, 0CEh, 91h, 0CEh, 80h, 0CEh ; 2ca0
	DB 91h, 0D0h, 40h, 00h, 0BCh ; 2ca8
	ASCII "R" ; 2cad
	DB 16h, 0C4h, 18h, 10h, 0CEh, 0D4h ; 2cae
	ASCII "N" ; 2cb4
	DB 16h, 0CEh, 0D5h ; 2cb5
	ASCII "O" ; 2cb8
	DB 16h, 0BEh ; 2cb9
	ASCII "T" ; 2cbb
	DB 16h, 0CEh, 0CAh, 0CEh, 0D4h ; 2cbc
	ASCII "V" ; 2cc1
	DB 16h, 0ABh, 0AEh, 0F8h, 0B8h, 5Bh, 16h, 0CEh ; 2cc2
	DB 8Dh, 0CEh, 98h, 0CEh, 8Dh, 0CEh, 98h, 0CEh ; 2cca
	DB 8Dh, 0CEh, 98h, 0CEh, 0D2h ; 2cd2
	ASCII "N" ; 2cd7
	DB 16h, 0CEh, 0D8h, 0CFh, 0E9h ; 2cd8
	ASCII "A" ; 2cdd
	DB 0CEh, 0D2h ; 2cde
	ASCII "N" ; 2ce0
	DB 16h, 0CEh, 0D8h ; 2ce1
	ASCII "Z" ; 2ce4
	DB 0B2h, 00h, 0CFh, 22h, 0B8h ; 2ce5
	ASCII "Y" ; 2cea
	DB 16h, 0CEh, 8Dh, 0CEh, 98h, 0CEh, 8Dh, 0CEh ; 2ceb
	DB 98h, 0CEh, 8Dh, 0CEh, 98h, 0CFh, 20h, 0B8h ; 2cf3
	ASCII "T" ; 2cfb
	DB 16h, 0CFh, 20h, 0BDh ; 2cfc
	ASCII "W" ; 2d00
	DB 16h, 0CEh, 0D0h ; 2d01
	ASCII "Y" ; 2d04
	DB 16h, 22h, 07h, 0CEh, 0D4h ; 2d05
	ASCII "3" ; 2d0a
	DB 16h, 0CEh, 0D0h, 5Bh, 16h, 22h, 07h, 0CEh ; 2d0b
	DB 0D4h ; 2d13
	ASCII "2" ; 2d14
	DB 16h, 0F8h, 0CEh, 0C5h, 00h, 0B8h ; 2d15
	ASCII "T" ; 2d1b
	DB 16h, 29h, 2Dh ; 2d1c
	ASCII "V" ; 2d1f
	DB 16h, 0E6h ; 2d20
	ASCII "I" ; 2d22
	DB 0BAh ; 2d23
	ASCII "W" ; 2d24
	DB 16h, 0CEh, 0D0h ; 2d25
	ASCII "V" ; 2d28
	DB 16h, 0CEh, 0CEh, 0C7h, 60h, 13h, 0CEh, 0C7h ; 2d29
	DB 00h, 0CEh, 0D2h ; 2d31
	ASCII "N" ; 2d34
	DB 16h, 0B3h, 00h, 0D1h, 0Ch, 00h, 0B0h, 09h ; 2d35
	ASCII "v" ; 2d3d
	DB 92h, 93h ; 2d3e
	ASCII "v" ; 2d40
	DB 92h, 93h ; 2d41
	ASCII "v" ; 2d43
	DB 92h, 93h ; 2d44
	ASCII "v" ; 2d46
	DB 92h, 93h ; 2d47
	ASCII "v" ; 2d49
	DB 92h, 93h ; 2d4a
	ASCII "v" ; 2d4c
	DB 92h, 93h ; 2d4d
	ASCII "v" ; 2d4f
	DB 92h, 93h ; 2d50
	ASCII "v" ; 2d52
	DB 92h, 93h ; 2d53
	ASCII "v" ; 2d55
	DB 92h, 93h ; 2d56
	ASCII "v" ; 2d58
	DB 92h, 93h ; 2d59
	ASCII "v" ; 2d5b
	DB 92h, 93h ; 2d5c
	ASCII "v" ; 2d5e
	DB 92h, 93h ; 2d5f
	ASCII "v" ; 2d61
	DB 93h, 93h, 93h, 93h, 0CFh ; 2d62
	ASCII "A" ; 2d67
	DB 88h, 0E7h, 0D3h, 0F8h
; ---------------------- ; 2d68
MainLoop:
	CARL Main ; 2d6c
	JRS MainLoop
	RET
; ---------------------- ; 2D71
	LD EP, #00h

	LD A, [IY+00h]
	LD [166Bh], A

	; set PRC rate
	LD A, [IY+01h]
	INT [7Eh]

	LD A, [IY+02h]
	LD [162Bh], A
	
	LD A, [IY+03h]
	LD B, [IY+04h]
	LD [162Ch], BA
	
	LD A, [IY+05h]
	LD [162Eh], A

	LD A, [IY+06h]
	LD B, [IY+07h]
	LD [162Fh], BA

	LD A, [IY+05h]
	LD [1631h], A

	XOR A, A
	LD [1632h], A
	LD [1633h], A

	LD A, [IY+09h]
	LD B, [IY+0Ah]
	LD [1634h], BA

	LD A, [IY+0Bh]
	LD [1636h], A

	LD A, [IY+0Ch]
	LD B, [IY+0Dh]
	LD [1637h], BA

	LD A, [IY+0Eh]
	LD [1639h], A

	LD L, [IY+0Fh]
	LD H, [IY+10h]
	LD B, [IY+11h]
	CARL loc_0x002243
	
	LD L, [IY+12h]
	LD H, [IY+13h]
	LD B, [IY+14h]
	CARL loc_0x00227C

	LD L, [IY+15h]
	LD H, [IY+16h]
	CP HL, #0000h
	JRS Z, loc_0x002DFA
	
	LD B, [IY+17h]
	CARL loc_0x0022E1

loc_0x002DFA:

	LD L, [IY+18h]
	LD H, [IY+19h]
	CP HL, #0000h
	JRS Z, loc_0x002E0B

	LD B, [IY+1Ah]
	CARL loc_0x0022C7

loc_0x002E0B:

	LD A, [IY+1Bh]
	LD [1647h], A

	LD A, [IY+1Ch]
	LD [1648h], A

	LD A, [IY+1Dh]
	CP A, #0FFh
	JRS Z, loc_0x002E24

	LD [14F4h], A

loc_0x002E24:

	LD L, [IY+1Eh]
	LD H, [IY+1Fh]
	LD A, [IY+20h]
	CP HL, #0000h
	JRS Z, loc_0x0002E46

	PUSH IP
	PUSH IY
	
	LD A, [IY+21h]
	LD B, [IY+22h]
	LD IX, BA
	LD A, [IY+23h]
	LD XP, A
	CARL loc_0x002E62
	
	POP IY
	POP IP

loc_0x0002E46:

	LD A, [IY+21h]
	LD B, [IY+22h]
	LD IX, BA

	LD A, [IY+23h]
	LD XP, A

	LD A, [IY+24h]
	LD B, [IY+25h]
	CP BA, #0000h
	JRS Z, loc_0x002E61
	
	CARL loc_0x002C22

loc_0x002E61:

	RET

; ---------------------- ; 2E62
loc_0x002E62:
	DB 0CEh, 0CCh, 0F4h

loc_0x002E65:
	DB 0CEh, 0C5h, 00h, 0CEh ; 2e61
	DB 0D0h, 2Bh, 16h ; 2e69
	ASCII "x" ; 2e6c
	DB 80h, 0B8h ; 2e6d
	ASCII "2" ; 2e6f
	DB 16h, 0BCh, 85h, 20h, 0C5h ; 2e70
	ASCII "q" ; 2e75
	DB 16h, 95h, 01h, 0E7h, 1Bh, 0B8h, 2Ch, 16h ; 2e76
	DB 0BCh, 82h, 20h, 0CEh, 0D0h, 2Eh, 16h ; 2e7e
	ASCII "x" ; 2e85
	DB 84h, 0B8h ; 2e86
	ASCII "4" ; 2e88
	DB 16h, 0BCh, 87h, 20h, 0CEh, 0D0h ; 2e89
	ASCII "6" ; 2e8f
	DB 16h ; 2e90
	ASCII "x" ; 2e91
	DB 89h, 0F1h, 19h, 0B8h, 2Fh, 16h, 0BCh, 82h ; 2e92
	DB 20h, 0CEh, 0D0h ; 2e9a
	ASCII "1" ; 2e9d
	DB 16h ; 2e9e
	ASCII "x" ; 2e9f
	DB 84h, 0B8h ; 2ea0
	ASCII "7" ; 2ea2
	DB 16h, 0BCh, 87h, 20h, 0CEh, 0D0h ; 2ea3
	ASCII "9" ; 2ea9
	DB 16h ; 2eaa
	ASCII "x" ; 2eab
	DB 89h, 0CEh, 0D0h, 3Ah, 16h ; 2eac
	ASCII "x@" ; 2eb1
	DB 0F8h
; ---------------------- ; 2eb3
global __START
__START:

	CARL minlib_splash_screen

	CPL B
	LD [1665h], B
	LD [1666h], H

	AND SC,#3Fh
	OR SC,#80h
	LD BR,#20h

	XOR A, A
	LD EP, A
	LD XP, A
	LD YP, A
	AND SC, #0CFh

	; Load subprogram
	LD HL, #2D71h
	LD B, #00h
	CARL loc_0x002243
	
	CARL loc_0x00265C
	CARL loc_0x0042CB
	CARL loc_0x00422C
	CARL minlib_reset_audio_registers
	CARL loc_0x00267F

	LD [1B0Fh], A
	LD NB, #03h
	CARL loc_0x018000

	LD NB, #03h
	CARL loc_0x01801C

	LD NB, #03h
	CARL loc_0x018035

	AND SC, #3Fh

	LD HL, #3608h
	LD B, #00h
	LD [161Fh], HL
	LD [1621h], B

	LD NB, #00h
	JRL MainLoop

; ---------------------- ; 2f0e
loc_0x002F11:
	LD HL,#1675h ; 2f11
	INC [HL] ; 2f14
	RET
; ---------------------- ; 2f15
loc_0x002F16:
	LD HL,#1672h ; 2f16
	BIT [HL],#0FFh ; 2f19
	JRL Z,loc_0x002F11 ; 2f1b
	LD [HL],#00h ; 2f1e
	LD NB,#07h ; 2f20
	CARL loc_0x03852E ; 2f23
	LD NB,#02h ; 2f26
	CARL loc_0x011D05 ; 2f29
	CARL loc_0x002E65 ; 2f2c
	AND SC,#3Fh ; 2f2f
	LD EP,#00h ; 2f31
	LD HL,#1671h ; 2f34
	INC [HL] ; 2f37
	LD HL,#1676h ; 2f38
	LD A,[HL] ; 2f3b
	LD [1677h],A ; 2f3c
	LD [HL],#00h ; 2f40
	LD HL,#15B1h ; 2f42
	LD [190Fh],HL ; 2f45
	LD NB,#00h ; 2f48
	CARL loc_0x00235D ; 2f4b
	LD NB,#02h ; 2f4e
	CARL loc_0x011BA5 ; 2f51
	LD NB,#02h ; 2f54
	CARL loc_0x011C7B ; 2f57
	LD NB,#02h ; 2f5a
	CARL loc_0x011CF5 ; 2f5d
	LD NB,#07h ; 2f60
	CARL loc_0x0383C6 ; 2f63
	LD NB,#07h ; 2f66
	CARL loc_0x03842F ; 2f69
	RET
; ---------------------- ; 2f6c
loc_0x002F6D:
	LD HL,#1672h ; 2f6d
	BIT [HL],#0FFh ; 2f70
	JRL Z,loc_0x002F11 ; 2f72
	LD [HL],#00h ; 2f75
	LD NB,#07h ; 2f77
	CARL loc_0x03852E ; 2f7a
	LD NB,#02h ; 2f7d
	CARL loc_0x011D05 ; 2f80
	CARL loc_0x002E65 ; 2f83
	AND SC,#3Fh ; 2f86
	LD EP,#00h ; 2f88

	LD HL, #1671h
	INC [HL]

	LD HL, #1676h
	LD A, [HL]
	LD [1677h], A
	LD [HL], #00h

	LD HL, #15B1h
	LD [190Fh], HL

	LD NB, #00h
	CARL 235Dh

	LD NB, #07h
	CARL 8EDFh

	LD NB, #02h 
	CARL 9BA5h

	LD NB, #02h
	CARL 9C7Bh

	LD NB, #02h
	CARL 9CF5h

	LD NB, #07h
	CARL 83C6h

	LD NB, #07h
	CARL 842Fh

	RET

; ---------------------- ; 2F6D
Module_Gameplay:
	LD HL, #1672h
	BIT [HL], #0FFh
	JRL Z, loc_0x002F11

	; 3852E
	LD [HL], #00h
	LD NB, #07h
	CARL loc_0x03852E

	LD NB, #02h
	CARL loc_0x009D05
	CARL loc_0x002E65

	AND SC, #3Fh

	LD EP, #00h
	LD HL, #1671h
	INC [HL]

	LD HL, #1676h
	LD A, [HL]
	LD [1677h], A
	LD [HL], #00h

	LD HL, #15B1h
	LD [190Fh], HL

	LD NB, #00h
	CARL loc_0x00235D

	LD NB, #07h
	CARL loc_0x008EDF

	LD NB, #02h
	CARL loc_0x009ECF

	LD NB, #02h
	CARL loc_0x009C7B

	LD NB, #02h
	CARL loc_0x009CF5

	LD NB, #07h
	CARL loc_0x0083C6

	LD NB, #07h
	CARL loc_0x00842F

	RET

; ---------------------- ; 2eb3
	DB 0C5h ; 3026
	ASCII "r" ; 3028
	DB 16h, 95h, 0FFh, 0EEh, 0E3h, 0FEh, 0B5h, 00h ; 3029
	DB 0CEh, 0C4h, 07h, 0F2h, 0F8h ; 3031
	ASCII "T" ; 3036
	DB 0CEh, 0C4h, 02h, 0F2h, 0C9h ; 3037
	ASCII "l" ; 303c
	DB 0F2h, 26h, 0FEh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 303d
	DB 0C5h ; 3045
	ASCII "q" ; 3046
	DB 16h, 86h, 0C5h ; 3047
	ASCII "v" ; 304a
	DB 16h ; 304b
	ASCII "E" ; 304c
	DB 0CEh, 0D4h ; 304d
	ASCII "w" ; 304f
	DB 16h, 0B5h, 00h, 0C5h, 0B1h, 15h, 0BDh, 0Fh ; 3050
	DB 19h, 0CEh, 0C4h, 00h, 0F2h, 0FFh, 0F2h, 0CEh ; 3058
	DB 0C4h, 07h, 0F2h, 7Bh, 5Eh, 0CEh, 0C4h, 02h ; 3060
	DB 0F2h ; 3068
	ASCII "en" ; 3069
	DB 0CEh, 0C4h, 02h, 0F2h, 99h ; 306b
	ASCII "h" ; 3070
	DB 0CEh, 0C4h, 02h, 0F2h, 7Fh ; 3071
	ASCII "l" ; 3076
	DB 0CEh, 0C4h, 07h, 0F2h ; 3077
	ASCII "JS" ; 307b
	DB 0CEh, 0C4h, 07h, 0F2h, 0ADh ; 307d
	ASCII "S" ; 3082
	DB 0C5h ; 3083
	ASCII "r" ; 3084
	DB 16h, 95h, 0FFh, 0EEh, 87h, 0FEh, 0B5h, 00h ; 3085
	DB 0CEh, 0C4h, 07h, 0F2h, 9Ch ; 308d
	ASCII "T" ; 3092
	DB 0CEh, 0C4h, 02h, 0F2h ; 3093
	ASCII "ml" ; 3097
	DB 0F2h, 0CAh, 0FDh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 3099
	DB 0C5h ; 30a1
	ASCII "q" ; 30a2
	DB 16h, 86h, 0C5h ; 30a3
	ASCII "v" ; 30a6
	DB 16h ; 30a7
	ASCII "E" ; 30a8
	DB 0CEh, 0D4h ; 30a9
	ASCII "w" ; 30ab
	DB 16h, 0B5h, 00h, 0C5h, 0B1h, 15h, 0BDh, 0Fh ; 30ac
	DB 19h, 0CEh, 0C4h, 00h, 0F2h, 0A3h, 0F2h, 0CEh ; 30b4
	DB 0C4h, 07h, 0F2h, 1Fh, 5Eh, 0CEh, 0C4h, 02h ; 30bc
	DB 0F2h, 09h ; 30c4
	ASCII "n" ; 30c6
	DB 0CEh, 0C4h, 02h, 0F2h, 0A9h ; 30c7
	ASCII "g" ; 30cc
	DB 0CEh, 0C4h, 02h, 0F2h, 23h ; 30cd
	ASCII "l" ; 30d2
	DB 0CEh, 0C4h, 07h, 0F2h, 0EEh ; 30d3
	ASCII "R" ; 30d8
	DB 0CEh, 0C4h, 07h, 0F2h ; 30d9
	ASCII "QS" ; 30dd
	DB 0F8h, 0C5h ; 30df
	ASCII "r" ; 30e1
	DB 16h, 95h, 0FFh, 0EEh, 2Ah, 0FEh, 0B5h, 00h ; 30e2
	DB 0CEh, 0C4h, 00h, 0F2h, 28h, 0FCh, 0CEh, 0C4h ; 30ea
	DB 07h, 0F2h ; 30f2
	ASCII "9T" ; 30f4
	DB 0CEh, 0C4h, 02h, 0F2h, 0Ah ; 30f6
	ASCII "l" ; 30fb
	DB 0F2h ; 30fc
	ASCII "g" ; 30fd
	DB 0FDh, 9Ch, 3Fh, 0CEh, 0C5h, 00h, 0C5h ; 30fe
	ASCII "q" ; 3105
	DB 16h, 86h, 0C5h ; 3106
	ASCII "v" ; 3109
	DB 16h ; 310a
	ASCII "E" ; 310b
	DB 0CEh, 0D4h ; 310c
	ASCII "w" ; 310e
	DB 16h, 0B5h, 00h, 0C5h, 0B1h, 15h, 0BDh, 0Fh ; 310f
	DB 19h, 0CEh, 0C4h, 00h, 0F2h, 40h, 0F2h, 0CEh ; 3117
	DB 0C4h, 02h, 0F2h, 82h ; 311f
	ASCII "j" ; 3123
	DB 0CEh, 0C4h, 02h, 0F2h ; 3124
	ASCII "Rk" ; 3128
	DB 0CEh, 0C4h, 02h, 0F2h, 0C6h ; 312a
	ASCII "k" ; 312f
	DB 0CEh, 0C4h, 00h, 0F2h, 91h, 0FBh, 0CEh, 0C4h ; 3130
	DB 07h, 0F2h, 8Bh ; 3138
	ASCII "R" ; 313b
	DB 0CEh, 0C4h, 07h, 0F2h, 0EEh ; 313c
	ASCII "R" ; 3141
	DB 0F8h, 0C5h ; 3142
	ASCII "r" ; 3144
	DB 16h, 95h, 0FFh, 0EEh, 0C7h, 0FDh, 0B5h, 00h ; 3145
	DB 0CEh, 0C4h, 07h, 0F2h, 0DCh ; 314d
	ASCII "S" ; 3152
	DB 0CEh, 0C4h, 02h, 0F2h, 0ADh ; 3153
	ASCII "k" ; 3158
	DB 0F2h, 0Ah, 0FDh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 3159
	DB 0C5h ; 3161
	ASCII "q" ; 3162
	DB 16h, 86h, 0C5h ; 3163
	ASCII "v" ; 3166
	DB 16h ; 3167
	ASCII "E" ; 3168
	DB 0CEh, 0D4h ; 3169
	ASCII "w" ; 316b
	DB 16h, 0B5h, 00h, 0B9h ; 316c
	ASCII "m" ; 3170
	DB 16h, 0BDh, 0Fh, 19h, 0CEh, 0C4h, 00h, 0F2h ; 3171
	DB 0E3h, 0F1h, 0CEh, 0C4h, 02h, 0F2h, 25h ; 3179
	ASCII "j" ; 3180
	DB 0CEh, 0C4h, 02h, 0F2h, 07h ; 3181
	ASCII "e" ; 3186
	DB 0CEh, 0C4h, 02h, 0F2h ; 3187
	ASCII "De" ; 318b
	DB 0CEh, 0C4h, 02h, 0F2h, 9Dh ; 318d
	ASCII "e" ; 3192
	DB 0CEh, 0C4h, 02h, 0F2h, 5Dh ; 3193
	ASCII "k" ; 3198
	DB 0CEh, 0C4h, 07h, 0F2h, 28h ; 3199
	ASCII "R" ; 319e
	DB 0CEh, 0C4h, 07h, 0F2h, 8Bh ; 319f
	ASCII "R" ; 31a4
	DB 0F8h, 0C5h ; 31a5
	ASCII "r" ; 31a7
	DB 16h, 95h, 0FFh, 0EEh ; 31a8
	ASCII "d" ; 31ac
	DB 0FDh, 0B5h, 00h, 0CEh, 0C4h, 00h, 0F2h ; 31ad
	ASCII "b" ; 31b4
	DB 0FBh, 0CEh, 0C4h, 07h, 0F2h ; 31b5
	ASCII "sS" ; 31ba
	DB 0CEh, 0C4h, 02h, 0F2h ; 31bc
	ASCII "Dk" ; 31c0
	DB 0F2h, 0A1h, 0FCh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 31c2
	DB 0C5h ; 31ca
	ASCII "q" ; 31cb
	DB 16h, 86h, 0C5h ; 31cc
	ASCII "v" ; 31cf
	DB 16h ; 31d0
	ASCII "E" ; 31d1
	DB 0CEh, 0D4h ; 31d2
	ASCII "w" ; 31d4
	DB 16h, 0B5h, 00h, 0B9h ; 31d5
	ASCII "m" ; 31d9
	DB 16h, 0BDh, 0Fh, 19h, 0CEh, 0C4h, 00h, 0F2h ; 31da
	ASCII "z" ; 31e2
	DB 0F1h, 0CEh, 0C4h, 02h, 0F2h, 0BCh ; 31e3
	ASCII "i" ; 31e9
	DB 0CEh, 0C4h, 02h, 0F2h, 9Eh ; 31ea
	ASCII "d" ; 31ef
	DB 0CEh, 0C4h, 02h, 0F2h, 0DBh ; 31f0
	ASCII "d" ; 31f5
	DB 0CEh, 0C4h, 02h, 0F2h ; 31f6
	ASCII "4e" ; 31fa
	DB 0CEh, 0C4h, 02h, 0F2h, 0F4h ; 31fc
	ASCII "j" ; 3201
	DB 0CEh, 0C4h, 00h, 0F2h, 0BFh, 0FAh, 0CEh, 0C4h ; 3202
	DB 07h, 0F2h, 0B9h ; 320a
	ASCII "Q" ; 320d
	DB 0CEh, 0C4h, 07h, 0F2h, 1Ch ; 320e
	ASCII "R" ; 3213
	DB 0F8h, 0C5h ; 3214
	ASCII "r" ; 3216
	DB 16h, 95h, 0FFh, 0EEh, 0F5h, 0FCh, 0B5h, 00h ; 3217
	DB 0CEh, 0C4h, 02h, 0F2h, 0E1h ; 321f
	ASCII "j" ; 3224
	DB 0F2h, 3Eh, 0FCh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 3225
	DB 0C5h ; 322d
	ASCII "q" ; 322e
	DB 16h, 86h, 0C5h ; 322f
	ASCII "v" ; 3232
	DB 16h ; 3233
	ASCII "E" ; 3234
	DB 0CEh, 0D4h ; 3235
	ASCII "w" ; 3237
	DB 16h, 0B5h, 00h, 0B9h ; 3238
	ASCII "m" ; 323c
	DB 16h, 0BDh, 0Fh, 19h, 0CEh, 0C4h, 02h, 0F2h ; 323d
	DB 5Fh ; 3245
	ASCII "i" ; 3246
	DB 0CEh, 0C4h, 02h, 0F2h ; 3247
	ASCII "Ad" ; 324b
	DB 0CEh, 0C4h, 02h, 0F2h, 7Eh ; 324d
	ASCII "d" ; 3252
	DB 0CEh, 0C4h, 02h, 0F2h, 0D7h ; 3253
	ASCII "d" ; 3258
	DB 0CEh, 0C4h, 02h, 0F2h, 97h ; 3259
	ASCII "j" ; 325e
	DB 0F8h, 0C5h ; 325f
	ASCII "r" ; 3261
	DB 16h, 95h, 0FFh, 0EEh, 0AAh, 0FCh, 0B5h, 00h ; 3262
	DB 0CEh, 0C4h, 00h, 0F2h, 0A8h, 0FAh, 0CEh, 0C4h ; 326a
	DB 02h, 0F2h, 90h ; 3272
	ASCII "j" ; 3275
	DB 0F2h, 0EDh, 0FBh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 3276
	DB 0C5h ; 327e
	ASCII "q" ; 327f
	DB 16h, 86h, 0C5h ; 3280
	ASCII "v" ; 3283
	DB 16h ; 3284
	ASCII "E" ; 3285
	DB 0CEh, 0D4h ; 3286
	ASCII "w" ; 3288
	DB 16h, 0B5h, 00h, 0B9h ; 3289
	ASCII "m" ; 328d
	DB 16h, 0BDh, 0Fh, 19h, 0CEh, 0C4h, 02h, 0F2h ; 328e
	DB 0Eh ; 3296
	ASCII "i" ; 3297
	DB 0CEh, 0C4h, 02h, 0F2h, 0F0h ; 3298
	ASCII "c" ; 329d
	DB 0CEh, 0C4h, 02h, 0F2h, 2Dh ; 329e
	ASCII "d" ; 32a3
	DB 0CEh, 0C4h, 02h, 0F2h, 86h ; 32a4
	ASCII "d" ; 32a9
	DB 0CEh, 0C4h, 02h, 0F2h ; 32aa
	ASCII "Fj" ; 32ae
	DB 0CEh, 0C4h, 00h, 0F2h, 11h, 0FAh, 0CEh, 0C4h ; 32b0
	DB 07h, 0F2h ; 32b8
	ASCII "tQ" ; 32ba
	DB 0F8h, 0C5h ; 32bc
	ASCII "r" ; 32be
	DB 16h, 95h, 0FFh, 0EEh ; 32bf
	ASCII "M" ; 32c3
	DB 0FCh, 0B5h, 00h, 0C5h ; 32c4
	ASCII "M" ; 32c8
	DB 16h, 0CEh ; 32c9
	ASCIZ "5" ; 32cb
	DB 0E6h, 07h, 0CEh, 0C4h, 00h, 0F2h ; 32cd
	ASCII "C" ; 32d3
	DB 0FAh, 0CEh, 0C4h, 02h, 0F2h, 2Bh ; 32d4
	ASCII "j" ; 32da
	DB 0F2h, 88h, 0FBh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 32db
	DB 0C5h ; 32e3
	ASCII "q" ; 32e4
	DB 16h, 86h, 0C5h ; 32e5
	ASCII "v" ; 32e8
	DB 16h ; 32e9
	ASCII "E" ; 32ea
	DB 0CEh, 0D4h ; 32eb
	ASCII "w" ; 32ed
	DB 16h, 0B5h, 00h, 0C5h, 0B1h, 15h, 0BDh, 0Fh ; 32ee
	DB 19h, 0CEh, 0C4h, 00h, 0F2h ; 32f6
	ASCII "a" ; 32fb
	DB 0F0h, 0CEh, 0C4h, 02h, 0F2h, 0A3h ; 32fc
	ASCII "h" ; 3302
	DB 0CEh, 0C4h, 02h, 0F2h, 85h ; 3303
	ASCII "c" ; 3308
	DB 0CEh, 0C4h, 02h, 0F2h, 0C2h ; 3309
	ASCII "c" ; 330e
	DB 0CEh, 0C4h, 02h, 0F2h, 1Bh ; 330f
	ASCII "d" ; 3314
	DB 0CEh, 0C4h, 02h, 0F2h, 0DBh ; 3315
	ASCII "i" ; 331a
	DB 0C5h ; 331b
	ASCII "M" ; 331c
	DB 16h, 0CEh ; 331d
	ASCIZ "5" ; 331f
	DB 0E6h, 07h, 0CEh, 0C4h, 00h, 0F2h, 9Eh, 0F9h ; 3321
	DB 0CEh, 0C4h, 07h, 0F2h, 01h ; 3329
	ASCII "Q" ; 332e
	DB 0F8h, 0C5h ; 332f
	ASCII "r" ; 3331
	DB 16h, 95h, 0FFh, 0EEh, 0DAh, 0FBh, 0B5h, 00h ; 3332
	DB 0CEh, 0C4h, 07h, 0F2h, 0EFh ; 333a
	ASCII "Q" ; 333f
	DB 0CEh, 0C4h, 02h, 0F2h, 0C0h ; 3340
	ASCII "i" ; 3345
	DB 0F2h, 1Dh, 0FBh, 9Ch, 3Fh, 0CEh, 0C5h, 00h ; 3346
	DB 0C5h ; 334e
	ASCII "q" ; 334f
	DB 16h, 86h, 0C5h ; 3350
	ASCII "v" ; 3353
	DB 16h ; 3354
	ASCII "E" ; 3355
	DB 0CEh, 0D4h ; 3356
	ASCII "w" ; 3358
	DB 16h, 0B5h, 00h, 0B9h ; 3359
	ASCII "m" ; 335d
	DB 16h, 0BDh, 0Fh, 19h, 0CEh, 0C4h, 00h, 0F2h ; 335e
	DB 0F6h, 0EFh, 0CEh, 0C4h, 07h, 0F2h ; 3366
	ASCII "r[" ; 336c
	DB 0CEh, 0C4h, 02h, 0F2h ; 336e
	ASCII "2h" ; 3372
	DB 0CEh, 0C4h, 02h, 0F2h, 02h ; 3374
	ASCII "i" ; 3379
	DB 0CEh, 0C4h, 02h, 0F2h ; 337a
	ASCII "vi" ; 337e
	DB 0CEh, 0C4h, 07h, 0F2h ; 3380
	ASCII "AP" ; 3384
	DB 0CEh, 0C4h, 07h, 0F2h, 0A4h ; 3386
	ASCII "P" ; 338b
	DB 0F2h, 02h, 00h, 0F8h, 0CEh, 0D0h, 0CAh, 1Ah ; 338c
	DB 0C7h, 9Eh ; 3394
	ASCII "3" ; 3396
	DB 0CEh, 0C7h, 00h, 0F2h, 0EAh, 0F1h, 0F8h, 0A4h ; 3397
	ASCII "3K4" ; 339f
	DB 0C6h ; 33a2
	ASCII "38" ; 33a3
	DB 0CEh, 0D4h, 0B4h, 15h, 0CEh, 0D4h, 0B8h, 15h ; 33a5
	DB 0CEh, 0D4h, 0BCh, 15h, 0CEh, 0D4h, 0C0h, 15h ; 33ad
	DB 0CEh, 0D4h, 0C4h, 15h, 0CEh, 0D4h, 0C8h, 15h ; 33b5
	DB 0CEh, 0D4h, 0CCh, 15h, 0CEh, 0D4h, 0D0h, 15h ; 33bd
	DB 0F8h, 0A6h, 0A2h, 0C6h, 0AAh, 15h, 0CEh, 0C6h ; 33c5
	DB 00h, 0F2h ; 33cd
	ASCII "6" ; 33cf
	DB 13h, 0AAh, 0AEh, 0B1h, 10h, 0B0h ; 33d0
	ASCII "X" ; 33d6
	DB 0BCh, 0B1h, 15h, 0B0h, 5Ch, 0BCh, 0B5h, 15h ; 33d7
	DB 0B0h, 60h, 0BCh, 0B9h, 15h, 0B0h ; 33df
	ASCII "d" ; 33e5
	DB 0BCh, 0BDh, 15h, 0B0h ; 33e6
	ASCII "h" ; 33ea
	DB 0BCh, 0C1h, 15h, 0B0h, 08h, 0CEh, 0D4h, 0B4h ; 33eb
	DB 15h, 0CEh, 0D4h, 0B8h, 15h, 0CEh, 0D4h, 0C0h ; 33f3
	DB 15h, 0CEh, 0D4h, 0C4h, 15h, 0B1h, 08h, 0C5h ; 33fb
	ASCII "D" ; 3403
	DB 1Bh ; 3404
	ASCII "E" ; 3405
	DB 80h ; 3406
	ASCII "2" ; 3407
	DB 12h, 0E4h, 0Ah, 0B1h, 00h ; 3408
	ASCII "2$" ; 340d
	DB 0E4h, 04h, 0B1h, 08h ; 340f
	ASCII "8h" ; 3413
	DB 0CEh, 0D5h, 0BCh, 15h ; 3415
	ASCII "8" ; 3419
	DB 0CEh, 0D4h, 0C8h, 15h, 0CEh, 0D4h, 0CCh, 15h ; 341a
	DB 0CEh, 0D4h, 0D0h, 15h, 0CEh, 0D0h, 0ADh, 15h ; 3422
	DB 0F2h ; 342a
	ASCII "I" ; 342b
	DB 0F1h, 0CEh, 0D5h, 0B3h, 15h, 0CEh, 0D4h, 0B7h ; 342c
	DB 15h, 0B0h, 0Ah, 0CEh, 0D4h, 0BBh, 15h, 0CEh ; 3434
	DB 0D0h, 0AEh, 15h, 0F2h ; 343c
	ASCII "4" ; 3440
	DB 0F1h, 0CEh, 0D5h, 0BFh, 15h, 0CEh, 0D4h, 0C3h ; 3441
	DB 15h, 0F8h, 0A6h, 0A2h, 0C6h, 0AAh, 15h, 0CEh ; 3449
	DB 0C6h, 00h, 0F2h, 0B1h, 12h, 0AAh, 0AEh, 0B1h ; 3451
	DB 10h, 0B0h ; 3459
	ASCII "L" ; 345b
	DB 0BCh, 0B1h, 15h, 0B0h ; 345c
	ASCII "P" ; 3460
	DB 0BCh, 0B5h, 15h, 0B0h ; 3461
	ASCII "T" ; 3465
	DB 0BCh, 0B9h, 15h, 0B0h ; 3466
	ASCII "X" ; 346a
	DB 0BCh, 0BDh, 15h, 0B0h, 5Ch, 0BCh, 0C1h, 15h ; 346b
	DB 0B0h, 60h, 0BCh, 0C5h, 15h, 0B0h ; 3473
	ASCII "d" ; 3479
	DB 0BCh, 0C9h, 15h, 0B0h ; 347a
	ASCII "h" ; 347e
	DB 0BCh, 0CDh, 15h, 0B0h, 08h, 0CEh, 0D4h, 0B4h ; 347f
	DB 15h, 0CEh, 0D4h, 0B8h, 15h, 0CEh, 0D4h, 0BCh ; 3487
	DB 15h, 0CEh, 0D4h, 0C0h, 15h, 0CEh, 0D4h, 0C4h ; 348f
	DB 15h, 0CEh, 0D4h, 0C8h, 15h, 0CEh, 0D4h, 0CCh ; 3497
	DB 15h, 0CEh, 0D4h, 0D0h, 15h, 0CEh, 0D0h, 0AAh ; 349f
	DB 15h, 0F2h, 0CBh, 0F0h, 0CEh, 0D5h, 0B3h, 15h ; 34a7
	DB 0CEh, 0D4h, 0B7h, 15h, 0CEh, 0D0h, 0ABh, 15h ; 34af
	DB 0F2h, 0BCh, 0F0h, 0CEh, 0D5h, 0BFh, 15h, 0CEh ; 34b7
	DB 0D4h, 0C3h, 15h, 0CEh, 0D0h, 0ACh, 15h, 0F2h ; 34bf
	DB 0ADh, 0F0h, 0CEh, 0D5h, 0CBh, 15h, 0CEh, 0D4h ; 34c7
	DB 0CFh, 15h, 0B0h, 0Bh, 0CEh, 0D4h, 0BBh, 15h ; 34cf
	DB 0CEh, 0D4h, 0C7h, 15h, 0F8h, 0F8h
; ---------------------- ; 34d7
IRQ_FrameCopy:

	RETE

; ---------------------- ; 34DE
IRQ_Render:

	PUSH ALE
	XOR A, A
	LD EP, A

	; disable interrupt
	LD BR, #20h
	LD [BR:27h], #40h

	LD XP, A
	LD YP, A

	AND SC, #(OFF_D & OFF_U)

	; increase frame count
	LD BA, [166Fh]
	INC BA
	LD [166Fh], BA

	CARL DoCurrentProc
	CARL loc_0x002987

	POP ALE

	RETE

; ---------------------- ; 34fd
	DB 0CFh, 0B9h ; 34fe
	ASCII "8" ; 3500
	DB 0CEh, 0CDh, 0B4h, 20h, 0DDh, 27h, 20h, 0CEh ; 3501
	DB 0CEh, 0CEh, 0CFh, 9Ch, 0CFh, 0F2h, 0ADh, 06h ; 3509
	DB 0CFh, 0BDh, 0F9h
; ---------------------- ; 3511
IRQ_Timer2LO_Underflow:

	RETE

; ---------------------- ; 3514
IRQ_Timer1HI_Underflow:

	PUSH ALE ; 3515

	XOR A,A ; 3517
	LD EP,A ; 3518
	LD BR,#20h ; 351a
	LD [BR:27h],#08h ; 351c

	LD XP,A ; 351f
	LD YP,A ; 3521

	AND SC,#0CFh ; 3523

	CARL loc_0x002315 ; 3525

	POP ALE ; 3528

	RETE

; ---------------------- ; 352a
IRQ_Timer1LO_Underflow:

	PUSH ALE ; 352b

	XOR A,A ; 352d
	LD EP,A ; 352e
	LD BR,#20h ; 3530
	LD [BR:27h],#04h ; 3532

	LD XP,A ; 3535
	LD YP,A ; 3537

	AND SC,#0CFh ; 3539

	CARL loc_0x002308 ; 353b

	POP ALE ; 353e

	RETE

; ---------------------- ; 3540
	DB 0CFh, 0B9h ; 3541
	ASCII "8" ; 3543
	DB 0CEh, 0CDh, 0B4h, 20h, 0DDh, 27h, 02h, 0CEh ; 3544
	DB 0CEh, 0CEh, 0CFh, 9Ch, 0CFh, 0F2h ; 354c
	ASCII "2" ; 3552
	DB 0Bh, 0CFh, 0BDh, 0F9h
; ---------------------- ; 3553
IRQ_Timer3Cmp:

	RETE

; ---------------------- ; 3557


IRQ_Timer_32hz:

	PUSH ALE

	; A = callee page?
	XOR A,A
	LD EP, A
	LD BR, #20h
	LD [BR:28h], #20h

	LD XP, A
	LD YP, A

	AND SC, #(OFF_D & OFF_U)

	CARL handle32hz

	POP ALE

	RETE

; ---------------------- ; 356d
IRQ_Timer_8hz:

	RETE

; ---------------------- ; 356e
IRQ_Timer_2hz:

	RETE

; ---------------------- ; 356f
IRQ_Timer_1hz:

	RETE

; ---------------------- ; 3570
loc_0x003571:

	PUSH ALE ; 3571

	XOR A,A ; 3573
	LD EP,A ; 3574
	LD BR,#20h ; 3576
	OR [BR:29h],#80h ; 3578

	LD XP,A ; 357b
	LD YP,A ; 357d

	AND SC,#0CFh ; 357f

	LD A,#0FFh ; 3581
	LD [1BCAh],A ; 3583

	POP ALE ; 3587

	RETE

; ---------------------- ; 3589
IRQ_KeyRight:

	RETE

; ---------------------- ; 358a
IRQ_KeyLeft:

	RETE

; ---------------------- ; 358b
IRQ_KeyDown:

	RETE

; ---------------------- ; 358c
IRQ_KeyUp:

	RETE

; ---------------------- ; 358d
IRQ_KeyC:

	RETE

; ---------------------- ; 358e
IRQ_KeyB:

	PUSH ALE ; 358f

	XOR A,A ; 3591
	LD EP,A ; 3592
	LD BR,#20h ; 3594
	OR [BR:29h],#02h ; 3596

	LD XP,A ; 3599
	LD YP,A ; 359b

	AND SC,#0CFh ; 359d

	LD A,#0FFh ; 359f
	LD [1BCAh],A ; 35a1

	POP ALE ; 35a5

	RETE

; ---------------------- ; 35a7
	DB 0F9h
; ---------------------- ; 35a8
IRQ_KeyA:

	RETE

; ---------------------- ; 35a9
IRQ_IR:

	RETE

; ---------------------- ; 35aa
IRQ_Shake:

	PUSH ALE ; 35ab

	XOR A,A ; 35ad
	LD EP,A ; 35ae
	LD BR,#20h ; 35b0
	LD [BR:2Ah],#40h ; 35b2

	LD XP,A ; 35b5
	LD YP,A ; 35b7

	AND SC,#0CFh ; 35b9

	LD HL,#1676h ; 35bb
	INC [HL] ; 35be
	JRS NZ,loc_0x0035C3 ; 35bf

	LD [HL],#0FFh ; 35c1

loc_0x0035C3:

	POP ALE ; 35c3

	RETE

; ---------------------- ; 35c5
	DB 0CFh, 0B9h, 0CEh, 0D0h, 8Ch, 16h, 0F2h ; 35c6
	ASCII "q" ; 35cd
	DB 0F3h, 0CFh, 0BDh, 0CFh, 0B9h, 0C6h, 0ACh, 21h ; 35ce
	DB 0CEh, 0C6h, 00h, 0CEh, 0D0h, 8Ch, 16h, 0F2h ; 35d6
	DB 05h, 0F2h, 0CEh, 0D0h, 8Ch, 16h, 0F2h, 12h ; 35de
	DB 0F2h, 0F2h, 94h, 0F2h, 0CEh, 0D0h, 8Ch, 16h ; 35e6
	DB 0F2h ; 35ee
	ASCII "c" ; 35ef
	DB 0F1h, 0CFh, 0BDh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah ; 35f0
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 35f8
	DB 14h, 0F2h, 0D1h, 0ECh, 0F2h, 89h, 0ECh, 0F8h ; 3600
	DB 0F2h, 0EAh, 0EBh, 0F2h, 2Bh, 0EDh ; 3608
	ASCII "8" ; 360e
	DB 0CEh, 0D4h, 8Dh, 16h, 0C5h ; 360f
	ASCII "k" ; 3614
	DB 16h, 0CEh, 25h, 0FEh, 0CEh, 25h, 0FDh, 0F2h ; 3615
	ASCII "P" ; 361d
	DB 0F1h, 0F2h ; 361e
	ASCII "o" ; 3620
	DB 0F1h, 0CEh, 0D4h, 8Bh, 16h, 0EFh ; 3621
	ASCIZ "4" ; 3627
	DB 0CEh, 0D4h, 8Ch, 16h, 0F2h, 0D9h, 0F1h, 20h ; 3629
	DB 0E7h, 15h, 0F2h, 2Ch, 0F2h, 0E7h, 10h, 0F2h ; 3631
	DB 7Dh, 0F0h, 0F2h, 89h, 0F0h, 0C5h, 88h, 83h ; 3639
	DB 0B1h, 03h, 0F2h ; 3641
	ASCII "7" ; 3644
	DB 0ECh, 0F8h, 0B0h, 0FFh, 0CEh, 0D4h, 8Ch, 16h ; 3645
	DB 0CEh, 0C4h, 03h, 0F2h, 0E3h ; 364d
	ASCII "I" ; 3652
	DB 0C5h, 0ACh ; 3653
	ASCII "6" ; 3655
	DB 0B1h, 00h, 0F2h, 22h, 0ECh, 0F8h, 0B0h, 0FFh ; 3656
	DB 0CEh, 0D4h, 8Ch, 16h, 0F2h, 5Dh, 0F1h ; 365e
	ASCII "2" ; 3665
	DB 0FFh, 0E6h, 11h, 0CEh, 0D4h, 8Ch, 16h, 0F2h ; 3666
	ASCII "b" ; 366e
	DB 0FFh, 0C5h, 88h, 83h, 0B1h, 03h, 0F2h, 05h ; 366f
	DB 0ECh, 0F8h, 0CEh, 0D4h, 8Ch, 16h, 0C5h, 9Fh ; 3677
	ASCII "7" ; 367f
	DB 0B1h, 00h, 0F2h, 0F8h, 0EBh, 0F8h, 04h, 04h ; 3680
	DB 0Eh, 40h, 1Fh, 02h, 40h, 1Fh, 02h, 00h ; 3688
	DB 14h, 02h, 00h, 14h, 02h ; 3690
	ASCIZ "m/" ; 3695
	DB 0E6h ; 3698
	ASCIZ "6" ; 3699
	DB 00h, 00h, 00h, 18h ; 369b
	ASCIZ "7" ; 369f
	DB 18h, 08h, 00h, 0EEh, 25h, 00h, 00h, 00h ; 36a1
	DB 00h, 00h, 00h, 0F2h ; 36a9
	ASCII "F" ; 36ad
	DB 0EBh, 0F2h, 87h, 0ECh, 0CEh, 0C4h, 02h, 0F2h ; 36ae
	DB 25h ; 36b6
	ASCII "d" ; 36b7
	DB 0CEh, 0C4h, 00h, 0F2h, 3Ch, 0F5h, 0CEh, 0C4h ; 36b8
	DB 07h, 0F2h ; 36c0
	ASCII "1L" ; 36c2
	DB 0C7h, 86h ; 36c4
	ASCII "6" ; 36c6
	DB 0CEh, 0C7h, 00h, 0F2h, 0A6h, 0F6h, 0C7h, 12h ; 36c7
	DB 00h, 0CEh, 0C4h, 02h, 0F2h, 0AFh ; 36cf
	ASCII "d" ; 36d5
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0A6h ; 36d6
	ASCII "d" ; 36de
	DB 0F2h, 5Eh, 0ECh, 0F2h, 17h, 0EBh, 0F8h, 0F2h ; 36df
	DB 5Eh, 0ECh, 0C5h ; 36e7
	ASCII "C" ; 36ea
	DB 16h, 95h, 01h, 0EFh, 04h, 0FFh, 0F8h, 04h ; 36eb
	DB 04h, 0Eh, 40h, 22h, 02h, 40h, 22h, 02h ; 36f3
	DB 00h, 14h, 02h, 00h, 14h, 02h ; 36fb
	ASCIZ "m/" ; 3701
	ASCIZ "R7" ; 3704
	DB 00h, 00h, 00h ; 3707
	ASCII "h" ; 370a
	DB 83h, 03h, 18h, 08h, 0FFh, 0EEh, 25h, 00h ; 370b
	DB 00h, 00h, 00h, 00h, 00h, 0F2h, 0DAh, 0EAh ; 3713
	DB 0F2h, 1Bh, 0ECh, 0CEh, 0C4h, 02h, 0F2h, 0B9h ; 371b
	ASCII "c" ; 3723
	DB 0CEh, 0C4h, 00h, 0F2h, 0D0h, 0F4h, 0CEh, 0C4h ; 3724
	DB 07h, 0F2h, 0C5h ; 372c
	ASCII "K" ; 372f
	DB 0C7h, 0F2h ; 3730
	ASCII "6" ; 3732
	DB 0CEh, 0C7h, 00h, 0F2h, 3Ah, 0F6h, 0C7h, 12h ; 3733
	DB 00h, 0CEh, 0C4h, 02h, 0F2h ; 373b
	ASCII "Cd" ; 3740
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 3Ah ; 3742
	ASCII "d" ; 374a
	DB 0F2h, 0F2h, 0EBh, 0F2h, 0ABh, 0EAh, 0F8h, 0F2h ; 374b
	DB 0F2h, 0EBh, 0C5h ; 3753
	ASCII "C" ; 3756
	DB 16h, 95h, 01h, 0E7h, 02h, 0F8h, 0CEh, 0D0h ; 3757
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 375f
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 8Bh, 16h, 0CEh ; 3767
	DB 0D4h, 8Ch, 16h, 0F2h, 60h, 0EBh, 0F2h, 18h ; 376f
	DB 0EBh, 0F8h, 04h, 04h, 0Eh, 40h, 25h, 02h ; 3777
	DB 40h, 25h, 02h, 00h, 14h, 02h, 00h, 14h ; 377f
	DB 02h ; 3787
	ASCIZ "m/" ; 3788
	DB 0D9h ; 378b
	ASCIZ "7" ; 378c
	DB 00h, 00h, 00h, 0Bh ; 378e
	ASCIZ "8" ; 3792
	DB 18h, 08h, 00h, 0EEh, 25h, 00h, 00h, 00h ; 3794
	DB 00h, 00h, 00h, 0F2h ; 379c
	ASCII "S" ; 37a0
	DB 0EAh, 0F2h, 94h, 0EBh, 0CEh, 0C4h, 02h, 0F2h ; 37a1
	ASCII "2c" ; 37a9
	DB 0CEh, 0C4h, 00h, 0F2h ; 37ab
	ASCII "I" ; 37af
	DB 0F4h, 0CEh, 0C4h, 07h, 0F2h, 3Eh ; 37b0
	ASCII "K" ; 37b6
	DB 0C7h ; 37b7
	ASCII "y7" ; 37b8
	DB 0CEh, 0C7h, 00h, 0F2h, 0B3h, 0F5h, 0C7h, 12h ; 37ba
	DB 00h, 0CEh, 0C4h, 02h, 0F2h, 0BCh ; 37c2
	ASCII "c" ; 37c8
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0B3h ; 37c9
	ASCII "c" ; 37d1
	DB 0F2h ; 37d2
	ASCII "k" ; 37d3
	DB 0EBh, 0F2h, 24h, 0EAh, 0F8h, 0F2h ; 37d4
	ASCII "k" ; 37da
	DB 0EBh, 0C5h ; 37db
	ASCII "C" ; 37dd
	DB 16h, 95h, 01h, 0EFh, 11h, 0FEh, 0F8h, 04h ; 37de
	DB 04h, 0Eh, 40h ; 37e6
	ASCII "4" ; 37e9
	DB 02h, 40h ; 37ea
	ASCII "4" ; 37ec
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 37ed
	ASCIZ "m/" ; 37f4
	ASCIZ "K8" ; 37f7
	DB 0E5h, 3Ah, 00h, 0B2h ; 37fa
	ASCIZ "8" ; 37fe
	DB 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h, 00h ; 3800
	DB 00h, 00h, 00h, 0F2h, 0E7h, 0E9h, 0F2h, 28h ; 3808
	DB 0EBh, 0CEh, 0C4h, 02h, 0F2h, 0C6h ; 3810
	ASCII "b" ; 3816
	DB 0CEh, 0C4h, 00h, 0F2h, 0DDh, 0F3h, 0CEh, 0C4h ; 3817
	DB 07h, 0F2h, 0D2h ; 381f
	ASCII "J" ; 3822
	DB 0C7h, 0E5h ; 3823
	ASCII "7" ; 3825
	DB 0CEh, 0C7h, 00h, 0F2h ; 3826
	ASCII "G" ; 382a
	DB 0F5h, 0B0h, 00h, 0CEh, 0D4h, 8Eh, 16h, 0C7h ; 382b
	ASCIZ "Q" ; 3833
	DB 0CEh, 0C4h, 02h, 0F2h ; 3835
	ASCII "Jc" ; 3839
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 383b
	ASCII "Ac" ; 3842
	DB 0F2h, 0F9h, 0EAh, 0F2h, 0B2h, 0E9h, 0F8h, 0F2h ; 3844
	DB 0F9h, 0EAh, 0C5h ; 384c
	ASCII "C" ; 384f
	DB 16h, 95h, 01h, 0E7h, 09h, 0C5h ; 3850
	ASCII "C" ; 3856
	DB 16h, 95h, 02h, 0E7h, 1Dh, 0F8h, 0CEh, 0D0h ; 3857
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 385f
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 8Eh, 16h, 20h ; 3867
	DB 0E7h, 15h, 0F2h ; 386f
	ASCII "a" ; 3872
	DB 0EAh, 0F2h, 19h, 0EAh, 0F8h, 0CEh, 0D0h, 0B6h ; 3873
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h ; 387b
	DB 0FAh, 14h, 0F2h ; 3883
	ASCII "g" ; 3886
	DB 0EAh, 0F2h, 05h, 0EAh, 0F8h, 04h, 04h, 0Eh ; 3887
	DB 40h, 28h, 02h, 40h, 28h, 02h, 00h, 14h ; 388f
	DB 02h, 00h, 14h, 02h ; 3897
	ASCIZ "m/" ; 389b
	DB 0ECh ; 389e
	ASCIZ "8" ; 389f
	DB 00h, 00h, 00h, 1Eh ; 38a1
	ASCIZ "9" ; 38a5
	DB 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h, 00h ; 38a7
	DB 00h, 00h, 00h, 0F2h, 40h, 0E9h, 0F2h, 81h ; 38af
	DB 0EAh, 0CEh, 0C4h, 02h, 0F2h, 1Fh ; 38b7
	ASCII "b" ; 38bd
	DB 0CEh, 0C4h, 00h, 0F2h ; 38be
	ASCII "6" ; 38c2
	DB 0F3h, 0CEh, 0C4h, 07h, 0F2h, 2Bh ; 38c3
	ASCII "J" ; 38c9
	DB 0C7h, 8Ch ; 38ca
	ASCII "8" ; 38cc
	DB 0CEh, 0C7h, 00h, 0F2h, 0A0h, 0F4h, 0C7h, 12h ; 38cd
	DB 00h, 0CEh, 0C4h, 02h, 0F2h, 0A9h ; 38d5
	ASCII "b" ; 38db
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0A0h ; 38dc
	ASCII "b" ; 38e4
	DB 0F2h ; 38e5
	ASCII "X" ; 38e6
	DB 0EAh, 0F2h, 11h, 0E9h, 0F8h, 0F2h ; 38e7
	ASCII "X" ; 38ed
	DB 0EAh, 0C5h ; 38ee
	ASCII "C" ; 38f0
	DB 16h, 95h, 01h, 0EFh, 0FEh, 0FCh, 0F8h, 04h ; 38f1
	DB 04h, 3Eh, 40h, 17h, 02h, 40h, 17h, 02h ; 38f9
	DB 00h, 14h, 02h, 00h, 14h, 02h ; 3901
	ASCIZ "m/" ; 3907
	ASCIZ "a9" ; 390a
	DB 0Bh ; 390d
	ASCIZ "8" ; 390e
	DB 0C1h ; 3910
	ASCIZ "9" ; 3911
	DB 18h, 08h, 0FFh ; 3913
	ASCIZ "B&" ; 3916
	DB 0C3h ; 3919
	ASCII "R" ; 391a
	DB 02h, 0Ch, 08h, 0F2h, 0D4h, 0E8h, 0F2h, 15h ; 391b
	DB 0EAh, 0CEh, 0C4h, 02h, 0F2h, 0B3h ; 3923
	ASCII "a" ; 3929
	DB 0CEh, 0C4h, 00h, 0F2h, 0CAh, 0F2h, 0CEh, 0C4h ; 392a
	DB 07h, 0F2h, 0BFh ; 3932
	ASCII "I" ; 3935
	DB 0C7h, 0F8h ; 3936
	ASCII "8" ; 3938
	DB 0CEh, 0C7h, 00h, 0F2h ; 3939
	ASCII "4" ; 393d
	DB 0F4h, 0C7h, 0D4h, 87h, 0CEh, 0C4h, 07h, 0F2h ; 393e
	DB 23h ; 3946
	ASCII "J" ; 3947
	DB 0C7h, 0B0h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 3948
	ASCII "4b" ; 394f
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 2Bh ; 3951
	ASCII "b" ; 3959
	DB 0F2h, 0E3h, 0E9h, 0F2h, 9Ch, 0E8h, 0F8h, 0F2h ; 395a
	DB 0E3h, 0E9h, 0C5h ; 3962
	ASCII "C" ; 3965
	DB 16h, 95h, 01h, 0E7h, 09h, 0C5h ; 3966
	ASCII "C" ; 396c
	DB 16h, 95h, 02h, 0E7h, 16h, 0F8h, 0CEh, 0D0h ; 396d
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 3975
	DB 0D4h, 0FAh, 14h, 0F2h ; 397d
	ASCII "R" ; 3981
	DB 0E9h, 0F2h, 0Ah, 0E9h, 0F8h, 0CEh, 0D0h, 0B6h ; 3982
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h ; 398a
	DB 0FAh, 14h, 0F2h ; 3992
	ASCII "X" ; 3995
	DB 0E9h, 0F2h, 0F6h, 0E8h, 0F8h, 04h, 04h, 3Eh ; 3996
	DB 40h, 17h, 02h, 40h, 17h, 02h, 00h, 14h ; 399e
	DB 02h, 00h, 14h, 02h ; 39a6
	ASCIZ "m/" ; 39aa
	DB 0Ah, 3Ah, 00h, 1Eh ; 39ad
	ASCIZ "9" ; 39b1
	ASCII "h" ; 39b3
	DB 83h, 03h, 18h, 08h, 0FFh ; 39b4
	ASCIZ "B&" ; 39b9
	DB 23h ; 39bc
	ASCII "S" ; 39bd
	DB 02h, 0Ch, 08h, 0F2h ; 39be
	ASCII "1" ; 39c2
	DB 0E8h, 0F2h ; 39c3
	ASCII "r" ; 39c5
	DB 0E9h, 0CEh, 0C4h, 02h, 0F2h, 10h ; 39c6
	ASCII "a" ; 39cc
	DB 0CEh, 0C4h, 00h, 0F2h, 27h, 0F2h, 0CEh, 0C4h ; 39cd
	DB 07h, 0F2h, 1Ch ; 39d5
	ASCII "I" ; 39d8
	DB 0C7h, 9Bh ; 39d9
	ASCII "9" ; 39db
	DB 0CEh, 0C7h, 00h, 0F2h, 91h, 0F3h, 0C7h, 0D4h ; 39dc
	DB 87h, 0CEh, 0C4h, 07h, 0F2h, 80h ; 39e4
	ASCII "I" ; 39ea
	DB 0B0h, 01h, 0CEh, 0D4h, 8Eh, 16h, 0C7h ; 39eb
	ASCIZ "Q" ; 39f2
	DB 0CEh, 0C4h, 02h, 0F2h, 8Bh ; 39f4
	ASCII "a" ; 39f9
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 82h ; 39fa
	ASCII "a" ; 3a02
	DB 0F2h, 3Ah, 0E9h, 0F2h, 0F3h, 0E7h, 0F8h, 0F2h ; 3a03
	DB 3Ah, 0E9h, 0C5h ; 3a0b
	ASCII "C" ; 3a0e
	DB 16h, 95h, 01h, 0E7h, 09h, 0C5h ; 3a0f
	ASCII "C" ; 3a15
	DB 16h, 95h, 02h, 0E7h, 25h, 0F8h, 0CEh, 0D0h ; 3a16
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 3a1e
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 8Eh, 16h, 20h ; 3a26
	DB 0E7h, 1Dh, 0CEh, 0D0h, 8Dh, 16h, 0CEh, 0D4h ; 3a2e
	DB 8Ch, 16h, 0F2h, 9Ah, 0E8h, 0F2h ; 3a36
	ASCII "R" ; 3a3c
	DB 0E8h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 3a3d
	DB 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 3a45
	DB 0A0h, 0E8h, 0F2h, 3Eh, 0E8h, 0F8h, 04h, 04h ; 3a4d
	DB 0Eh, 40h, 2Eh, 02h, 40h, 2Eh, 02h, 00h ; 3a55
	DB 14h, 02h, 00h, 14h, 02h ; 3a5d
	ASCIZ "m/" ; 3a62
	DB 0B3h, 3Ah, 00h, 00h, 00h, 00h, 0E5h, 3Ah ; 3a65
	DB 00h, 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h ; 3a6d
	DB 00h, 00h, 00h, 00h, 0F2h ; 3a75
	ASCII "y" ; 3a7a
	DB 0E7h, 0F2h, 0BAh, 0E8h, 0CEh, 0C4h, 02h, 0F2h ; 3a7b
	ASCII "X`" ; 3a83
	DB 0CEh, 0C4h, 00h, 0F2h ; 3a85
	ASCII "o" ; 3a89
	DB 0F1h, 0CEh, 0C4h, 07h, 0F2h ; 3a8a
	ASCII "dH" ; 3a8f
	DB 0C7h ; 3a91
	ASCII "S:" ; 3a92
	DB 0CEh, 0C7h, 00h, 0F2h, 0D9h, 0F2h, 0C7h, 12h ; 3a94
	DB 00h, 0CEh, 0C4h, 02h, 0F2h, 0E2h, 60h, 0C7h ; 3a9c
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0D9h, 60h ; 3aa4
	DB 0F2h, 91h, 0E8h, 0F2h ; 3aac
	ASCII "J" ; 3ab0
	DB 0E7h, 0F8h, 0F2h, 91h, 0E8h, 0C5h ; 3ab1
	ASCII "C" ; 3ab7
	DB 16h, 95h, 01h, 0EFh ; 3ab8
	ASCII "7" ; 3abc
	DB 0FBh, 0F8h, 04h, 04h, 0Eh, 40h, 2Bh, 02h ; 3abd
	DB 40h, 2Bh, 02h, 00h, 14h, 02h, 00h, 14h ; 3ac5
	DB 02h ; 3acd
	ASCIZ "m/" ; 3ace
	DB 1Fh, 3Bh, 00h, 00h, 00h, 00h, 88h, 83h ; 3ad1
	DB 03h, 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h ; 3ad9
	DB 00h, 00h, 00h, 00h, 0F2h, 0Dh, 0E7h, 0F2h ; 3ae1
	ASCII "N" ; 3ae9
	DB 0E8h, 0CEh, 0C4h, 02h, 0F2h, 0ECh, 5Fh, 0CEh ; 3aea
	DB 0C4h, 00h, 0F2h, 03h, 0F1h, 0CEh, 0C4h, 07h ; 3af2
	DB 0F2h, 0F8h ; 3afa
	ASCII "G" ; 3afc
	DB 0C7h, 0BFh, 3Ah, 0CEh, 0C7h, 00h, 0F2h ; 3afd
	ASCII "m" ; 3b04
	DB 0F2h, 0C7h, 12h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 3b05
	ASCII "v`" ; 3b0d
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 3b0f
	ASCII "m`" ; 3b16
	DB 0F2h, 25h, 0E8h, 0F2h, 0DEh, 0E6h, 0F8h, 0F2h ; 3b18
	DB 25h, 0E8h, 0C5h ; 3b20
	ASCII "C" ; 3b23
	DB 16h, 95h, 01h, 0EFh, 0CBh, 0FAh, 0F8h
; ---------------------- ; 3b24



    include "minlib-1.35.asm"


    include "minlib-data.asm"


	DB 0B3h, 0F1h, 0A4h, 0C1h, 81h ; 69a5
	DB 98h, 2Dh ; 69aa
	ASCII "I-I-I-I-I" ; 69ac
	DB 0C3h, 10h, 11h, 12h, 15h ; 69b5
	ASCII "II" ; 69ba
	DB 0C1h, 2Ah ; 69bc
	ASCII "I*I*I*I*I" ; 69be
	DB 0C3h, 0Dh, 10h, 12h, 11h ; 69c7
	ASCII "II" ; 69cc
	DB 0C0h, 2Dh ; 69ce
	ASCII "I*I-/I" ; 69d0
	DB 82h ; 69d6
	ASCII "0" ; 69d7
	DB 81h ; 69d8
	ASCII "0/I-I*I12I3I4I64I" ; 69d9
	DB 0C1h, 28h ; 69ea
	ASCII "I" ; 69ec
	DB 0C2h, 1Ch ; 69ed
	ASCII "I" ; 69ef
	DB 0C3h, 10h ; 69f0
	ASCII "I" ; 69f2
	DB 0C3h, 15h ; 69f3
	ASCII "I" ; 69f5
	DB 19h ; 69f6
	ASCII "I" ; 69f7
	DB 1Ch ; 69f8
	ASCII "I" ; 69f9
	DB 15h, 19h ; 69fa
	ASCII "I" ; 69fc
	DB 1Ch ; 69fd
	ASCII "I" ; 69fe
	DB 15h, 19h ; 69ff
	ASCII "I" ; 6a01
	DB 1Ch ; 6a02
	ASCII "I" ; 6a03
	DB 17h ; 6a04
	ASCII "I" ; 6a05
	DB 1Ah ; 6a06
	ASCII "I" ; 6a07
	DB 1Eh ; 6a08
	ASCII "I" ; 6a09
	DB 17h, 1Ah ; 6a0a
	ASCII "I" ; 6a0c
	DB 1Eh ; 6a0d
	ASCII "I" ; 6a0e
	DB 17h, 1Ah ; 6a0f
	ASCII "I" ; 6a11
	DB 1Eh ; 6a12
	ASCII "I" ; 6a13
	DB 15h ; 6a14
	ASCII "I" ; 6a15
	DB 19h ; 6a16
	ASCII "I" ; 6a17
	DB 1Ch ; 6a18
	ASCII "I" ; 6a19
	DB 15h, 19h ; 6a1a
	ASCII "I" ; 6a1c
	DB 1Ch ; 6a1d
	ASCII "I" ; 6a1e
	DB 15h, 19h ; 6a1f
	ASCII "I" ; 6a21
	DB 1Ch ; 6a22
	ASCII "I" ; 6a23
	DB 17h ; 6a24
	ASCII "I" ; 6a25
	DB 1Ah ; 6a26
	ASCII "I" ; 6a27
	DB 1Eh ; 6a28
	ASCII "I" ; 6a29
	DB 17h, 1Ah ; 6a2a
	ASCII "I" ; 6a2c
	DB 1Eh ; 6a2d
	ASCII "I" ; 6a2e
	DB 17h, 1Ah ; 6a2f
	ASCII "I" ; 6a31
	DB 1Eh ; 6a32
	ASCII "I" ; 6a33
	DB 0C0h, 21h ; 6a34
	ASCII "I%I(I!%I(I!%I(I#I&I*I#&I*I#&I*I" ; 6a36
	DB 0C3h, 21h ; 6a55
	ASCII "I%I(I!%I(I!$I#I" ; 6a57
	DB 15h, 15h, 15h, 15h ; 6a66
	ASCII "IIII" ; 6a6a
	DB 15h, 15h, 15h, 15h ; 6a6e
	ASCII "IIII" ; 6a72
	DB 0F2h, 0F7h ; 6a76
	ASCII "j" ; 6a78
	DB 0F8h ; 6a79
	ASCII "j#kBkUkhk" ; 6a7a
	DB 93h ; 6a83
	ASCII "k" ; 6a84
	DB 0A6h ; 6a85
	ASCII "k" ; 6a86
	DB 0B9h ; 6a87
	ASCII "kzl" ; 6a88
	DB 8Dh ; 6a8b
	ASCII "l" ; 6a8c
	DB 0B8h ; 6a8d
	ASCII "l%m8m?mXm}m" ; 6a8e
	DB 0F6h ; 6a99
	ASCII "m" ; 6a9a
	DB 0C9h ; 6a9b
	ASCII "n" ; 6a9c
	DB 0F4h ; 6a9d
	ASCII "n" ; 6a9e
	DB 0FBh ; 6a9f
	ASCII "nxq" ; 6aa0
	DB 0BCh ; 6aa3
	ASCII "q" ; 6aa4
	DB 0DBh ; 6aa5
	ASCII "q" ; 6aa6
	DB 06h ; 6aa7
	ASCII "rOr" ; 6aa8
	DB 0A4h ; 6aab
	ASCII "r" ; 6aac
	DB 0C3h ; 6aad
	ASCII "r" ; 6aae
	DB 0D6h ; 6aaf
	ASCII "rmv" ; 6ab0
	DB 0B6h ; 6ab3
	ASCII "v" ; 6ab4
	DB 0E7h ; 6ab5
	ASCII "v" ; 6ab6
	DB 84h ; 6ab7
	ASCII "w" ; 6ab8
	DB 0BBh ; 6ab9
	ASCII "w" ; 6aba
	DB 0C2h ; 6abb
	ASCII "w" ; 6abc
	DB 11h ; 6abd
	ASCII "x" ; 6abe
	DB 84h ; 6abf
	ASCII "x" ; 6ac0
	DB 8Bh ; 6ac1
	ASCII "x" ; 6ac2
	DB 92h ; 6ac3
	ASCII "x" ; 6ac4
	DB 99h ; 6ac5
	ASCII "x" ; 6ac6
	DB 0A0h ; 6ac7
	ASCII "x" ; 6ac8
	DB 0A7h ; 6ac9
	ASCII "x" ; 6aca
	DB 0AEh ; 6acb
	ASCII "x" ; 6acc
	DB 0B5h ; 6acd
	ASCII "x" ; 6ace
	DB 0BCh ; 6acf
	ASCII "x" ; 6ad0
	DB 0C3h ; 6ad1
	ASCII "x" ; 6ad2
	DB 0CAh ; 6ad3
	ASCII "x" ; 6ad4
	DB 0D1h ; 6ad5
	ASCII "x" ; 6ad6
	DB 0D8h ; 6ad7
	ASCII "x" ; 6ad8
	DB 0DFh ; 6ad9
	ASCII "x" ; 6ada
	DB 0E6h ; 6adb
	ASCII "x" ; 6adc
	DB 0EDh ; 6add
	ASCII "x" ; 6ade
	DB 0F4h ; 6adf
	ASCII "x" ; 6ae0
	DB 0FBh ; 6ae1
	ASCII "x" ; 6ae2
	DB 02h ; 6ae3
	ASCII "y" ; 6ae4
	DB 09h ; 6ae5
	ASCII "y" ; 6ae6
	DB 10h ; 6ae7
	ASCII "y" ; 6ae8
	DB 17h ; 6ae9
	ASCII "y" ; 6aea
	DB 1Eh ; 6aeb
	ASCII "y%y,y3y:yAy" ; 6aec
	DB 0FFh, 03h, 02h, 80h, 07h, 0C0h, 03h, 00h ; 6af7
	DB 02h, 00h, 00h, 00h, 00h, 03h, 02h, 00h ; 6aff
	DB 0Fh, 80h, 07h, 00h, 02h, 00h, 00h, 00h ; 6b07
	DB 00h, 01h, 02h, 80h, 07h, 0C0h, 03h, 00h ; 6b0f
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6b17
	DB 0Fh, 80h, 07h, 0FFh, 01h, 02h, 00h, 1Eh ; 6b1f
	DB 0F8h, 01h, 03h, 02h, 00h, 00h, 00h, 00h ; 6b27
	DB 03h, 02h, 0B8h, 1Ah, 40h, 06h, 00h, 0Ah ; 6b2f
	DB 00h, 00h, 00h, 00h, 03h, 02h, 00h, 1Eh ; 6b37
	DB 0F8h, 01h, 0FFh, 03h, 06h, 00h, 2Dh ; 6b3f
	ASCIZ "P" ; 6b46
	DB 00h, 04h, 00h, 00h, 00h, 00h, 03h, 06h ; 6b48
	DB 00h, 2Dh, 28h, 00h, 0FFh, 03h, 02h, 0D8h ; 6b50
	DB 11h, 0F8h, 01h, 00h, 02h, 00h, 00h, 00h ; 6b58
	DB 00h, 03h, 02h, 00h, 0Fh, 40h, 06h, 0FFh ; 6b60
	DB 01h, 02h, 00h, 0Fh, 80h, 07h, 00h, 01h ; 6b68
	DB 00h, 00h, 00h, 00h, 01h, 02h, 0E8h, 0Bh ; 6b70
	DB 0F4h, 05h, 00h, 01h, 00h, 00h, 00h, 00h ; 6b78
	DB 03h, 02h, 00h, 0Ah, 00h, 05h, 00h, 01h ; 6b80
	DB 00h, 00h, 00h, 00h, 03h, 02h, 80h, 07h ; 6b88
	DB 0C0h, 03h, 0FFh, 03h, 01h, 3Eh, 07h, 0E7h ; 6b90
	DB 03h, 00h, 06h, 00h, 00h, 00h, 00h, 03h ; 6b98
	DB 01h, 0C0h, 05h, 0E8h, 03h, 0FFh, 03h, 01h ; 6ba0
	DB 0C0h, 05h, 0E8h, 03h, 00h, 06h, 00h, 00h ; 6ba8
	DB 00h, 00h, 03h, 01h, 3Eh, 07h, 0E7h, 03h ; 6bb0
	DB 0FFh, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6bb8
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6bc0
	DB 05h, 80h, 02h, 00h, 02h, 00h, 00h, 00h ; 6bc8
	DB 00h, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6bd0
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6bd8
	DB 05h, 80h, 02h, 00h, 02h, 00h, 00h, 00h ; 6be0
	DB 00h, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6be8
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6bf0
	DB 05h, 80h, 02h, 00h, 02h, 00h, 00h, 00h ; 6bf8
	DB 00h, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6c00
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6c08
	DB 05h, 80h, 02h, 00h, 20h, 00h, 00h, 00h ; 6c10
	DB 00h, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6c18
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6c20
	DB 05h, 80h, 02h, 00h, 02h, 00h, 00h, 00h ; 6c28
	DB 00h, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6c30
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6c38
	DB 05h, 80h, 02h, 00h, 02h, 00h, 00h, 00h ; 6c40
	DB 00h, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6c48
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6c50
	DB 05h, 80h, 02h, 00h, 02h, 00h, 00h, 00h ; 6c58
	DB 00h, 01h, 02h, 0ECh, 03h, 0F6h, 01h, 00h ; 6c60
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 00h ; 6c68
	DB 05h, 80h, 02h, 00h, 02h, 00h, 00h, 00h ; 6c70
	DB 00h, 0FFh, 01h, 02h ; 6c78
	ASCII "o" ; 6c7c
	DB 0Bh, 0CFh, 01h, 00h, 02h, 00h, 00h, 00h ; 6c7d
	DB 00h, 01h, 02h, 0CAh, 0Ah, 7Dh, 01h, 0FFh ; 6c85
	DB 01h, 02h, 00h, 1Eh, 0D6h, 03h, 00h, 02h ; 6c8d
	DB 00h, 00h, 00h, 00h, 01h, 02h, 80h, 16h ; 6c95
	DB 0D0h, 02h, 00h, 02h, 00h, 00h, 00h, 00h ; 6c9d
	DB 01h, 02h, 00h, 0Fh, 0E0h, 01h, 01h, 02h ; 6ca5
	DB 00h, 00h, 00h, 00h, 03h, 02h, 40h, 0Bh ; 6cad
	DB 0D0h, 02h, 0FFh, 03h, 01h, 0F8h, 2Ah, 0E7h ; 6cb5
	DB 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h, 03h ; 6cbd
	DB 01h ; 6cc5
	ASCII "P-" ; 6cc6
	DB 0E8h, 03h, 03h, 01h, 7Ch, 2Eh, 0E8h, 03h ; 6cc8
	DB 03h, 01h, 0A8h, 2Fh, 0E8h, 03h, 03h, 01h ; 6cd0
	DB 7Ch, 2Eh, 0E8h, 03h, 03h, 01h ; 6cd8
	ASCII "P-" ; 6cde
	DB 0E8h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 6ce0
	DB 03h, 01h, 0F8h, 2Ah, 0E7h, 03h, 03h, 01h ; 6ce8
	DB 0E4h, 25h, 0C7h, 00h, 03h, 01h, 0B2h, 25h ; 6cf0
	ASCIZ "d" ; 6cf8
	DB 03h, 01h, 80h, 25h ; 6cfa
	ASCIZ "d" ; 6cfe
	DB 03h, 01h ; 6d00
	ASCIZ "N%d" ; 6d02
	DB 03h, 01h, 1Ch, 25h ; 6d06
	ASCIZ "d" ; 6d0a
	DB 03h, 01h ; 6d0c
	ASCIZ "N%d" ; 6d0e
	DB 03h, 01h, 80h, 25h ; 6d12
	ASCIZ "d" ; 6d16
	DB 03h, 01h, 0B2h, 25h ; 6d18
	ASCIZ "d" ; 6d1c
	DB 03h, 01h, 0E4h, 25h, 0C7h, 00h, 0FFh, 01h ; 6d1e
	DB 02h, 3Bh, 02h ; 6d26
	ASCIZ "U" ; 6d29
	DB 00h, 04h, 00h, 00h, 00h, 00h, 01h, 01h ; 6d2b
	DB 0E0h, 01h, 28h, 00h, 0FFh, 01h, 01h, 87h ; 6d33
	DB 0Bh, 0D6h, 04h, 0FFh, 01h, 01h, 5Eh, 02h ; 6d3b
	DB 2Fh, 01h, 00h, 04h, 00h, 00h, 00h, 00h ; 6d43
	DB 01h, 01h, 5Eh, 02h, 2Fh, 01h, 01h, 01h ; 6d4b
	DB 5Eh, 02h, 2Fh, 01h, 0FFh, 01h, 02h ; 6d53
	ASCII "P" ; 6d5a
	DB 0Fh, 90h, 01h, 00h, 02h, 00h, 00h, 00h ; 6d5b
	DB 00h, 01h, 02h, 0C4h, 0Dh, 90h, 01h, 00h ; 6d63
	DB 02h, 00h, 00h, 00h, 00h, 01h, 02h, 0D0h ; 6d6b
	DB 0Ch, 0D8h, 01h, 00h, 02h, 00h, 00h, 00h ; 6d73
	DB 00h, 0FFh, 01h, 01h, 0D4h, 03h, 1Eh, 00h ; 6d7b
	DB 01h, 01h, 0FCh, 03h, 1Eh, 00h, 01h, 01h ; 6d83
	ASCII "8" ; 6d8b
	DB 04h, 1Eh, 00h, 01h, 01h, 60h, 04h, 1Eh ; 6d8c
	DB 00h, 01h, 01h, 88h, 04h, 1Eh, 00h, 01h ; 6d94
	DB 01h, 0B0h, 04h, 1Eh, 00h, 00h, 04h, 00h ; 6d9c
	DB 00h, 00h, 00h, 01h, 01h, 0D4h, 03h, 1Eh ; 6da4
	DB 00h, 01h, 01h, 0FCh, 03h, 1Eh, 00h, 01h ; 6dac
	DB 01h ; 6db4
	ASCII "8" ; 6db5
	DB 04h, 1Eh, 00h, 01h, 01h, 60h, 04h, 1Eh ; 6db6
	DB 00h, 01h, 01h, 88h, 04h, 1Eh, 00h, 01h ; 6dbe
	DB 01h, 0B0h, 04h, 1Eh, 00h, 00h, 04h, 00h ; 6dc6
	DB 00h, 00h, 00h, 01h, 01h, 0D4h, 03h, 1Eh ; 6dce
	DB 00h, 01h, 01h, 0FCh, 03h, 1Eh, 00h, 01h ; 6dd6
	DB 01h ; 6dde
	ASCII "8" ; 6ddf
	DB 04h, 1Eh, 00h, 01h, 01h, 60h, 04h, 1Eh ; 6de0
	DB 00h, 01h, 01h, 88h, 04h, 1Eh, 00h, 01h ; 6de8
	DB 01h, 0B0h, 04h, 1Eh, 00h, 0FFh, 01h, 02h ; 6df0
	DB 0D0h, 01h, 0E8h, 00h, 01h, 02h, 0DAh, 01h ; 6df8
	DB 0ECh, 00h, 01h, 02h, 0E4h, 01h, 0F2h, 00h ; 6e00
	DB 01h, 02h, 0EBh, 01h, 0F5h, 00h, 01h, 02h ; 6e08
	DB 0FEh, 01h, 0FFh, 00h, 01h, 02h, 12h, 02h ; 6e10
	DB 09h, 01h, 01h, 02h ; 6e18
	ASCII "0" ; 6e1c
	DB 02h, 1Dh, 01h, 01h, 02h ; 6e1d
	ASCII "N" ; 6e22
	DB 02h, 27h, 01h, 01h, 02h ; 6e23
	ASCII "l" ; 6e28
	DB 02h ; 6e29
	ASCII "6" ; 6e2a
	DB 01h, 01h, 02h, 94h, 02h ; 6e2b
	ASCII "J" ; 6e30
	DB 01h, 01h, 02h, 0BCh, 02h, 5Eh, 01h, 01h ; 6e31
	DB 02h, 0E4h, 02h ; 6e39
	ASCII "r" ; 6e3c
	DB 01h, 01h, 02h, 16h, 03h, 8Bh, 01h, 01h ; 6e3d
	DB 02h ; 6e45
	ASCII "H" ; 6e46
	DB 03h, 0A4h, 01h, 01h, 02h ; 6e47
	ASCII "z" ; 6e4c
	DB 03h, 0BDh, 01h, 01h, 02h, 0B6h, 03h, 0DBh ; 6e4d
	DB 01h, 01h, 02h, 0F2h, 03h, 0F9h, 01h, 01h ; 6e55
	DB 02h, 24h, 04h, 12h, 02h, 01h, 02h ; 6e5d
	ASCII "t" ; 6e64
	DB 04h, 3Ah, 02h, 01h, 02h, 0C4h, 04h ; 6e65
	ASCII "b" ; 6e6c
	DB 02h, 01h, 02h, 14h, 05h, 8Ah, 02h, 01h ; 6e6d
	DB 02h ; 6e75
	ASCII "x" ; 6e76
	DB 05h, 0BCh, 02h, 01h, 02h, 0DCh, 05h, 0EEh ; 6e77
	DB 02h, 01h, 02h, 40h, 06h, 20h, 03h, 01h ; 6e7f
	DB 02h ; 6e87
	ASCII "r" ; 6e88
	DB 06h ; 6e89
	ASCII "9" ; 6e8a
	DB 03h, 01h, 02h, 08h, 07h, 84h, 03h, 01h ; 6e8b
	DB 02h, 9Eh, 07h, 0CFh, 03h, 01h, 02h, 98h ; 6e93
	DB 08h ; 6e9b
	ASCII "L" ; 6e9c
	DB 04h, 01h, 02h, 92h, 09h, 0C9h, 04h, 01h ; 6e9d
	DB 02h, 8Ch, 0Ah ; 6ea5
	ASCII "F" ; 6ea8
	DB 05h, 01h, 02h, 0B8h, 0Bh, 0DCh, 05h, 01h ; 6ea9
	DB 02h, 0ACh, 0Dh, 0D6h, 06h, 01h, 02h, 0A0h ; 6eb1
	DB 0Fh, 0D0h, 07h, 01h, 02h, 94h, 11h, 0CAh ; 6eb9
	DB 08h, 01h, 02h, 88h, 13h, 0C4h, 09h, 0FFh ; 6ec1
	DB 01h, 01h, 1Ch, 1Eh ; 6ec9
	ASCII "N" ; 6ecd
	DB 04h, 01h, 01h ; 6ece
	ASCII "R" ; 6ed1
	DB 1Dh, 0B4h, 07h, 01h, 01h, 88h, 1Ch, 0F5h ; 6ed2
	DB 06h, 00h, 04h, 00h, 00h, 00h, 00h, 03h ; 6eda
	DB 01h, 3Ch, 18h ; 6ee2
	ASCII "N" ; 6ee5
	DB 04h, 03h, 01h, 0DEh, 16h, 0CCh, 03h, 03h ; 6ee6
	DB 01h, 60h, 15h, 0Dh, 03h, 0FFh, 01h, 01h ; 6eee
	ASCII "9" ; 6ef6
	DB 11h, 0E8h, 03h, 0FFh, 01h, 02h, 7Eh, 26h ; 6ef7
	DB 0E7h, 03h, 03h, 02h, 96h, 22h, 0E7h, 03h ; 6eff
	DB 03h, 02h, 0AEh, 1Eh, 0E7h, 03h, 00h, 08h ; 6f07
	DB 00h, 00h, 00h, 00h, 01h, 02h, 0C6h, 1Ah ; 6f0f
	DB 0E7h, 03h, 03h, 02h, 60h, 15h, 0E8h, 03h ; 6f17
	DB 03h, 02h, 0DEh, 16h, 0E7h, 03h, 00h, 08h ; 6f1f
	DB 00h, 00h, 00h, 00h, 01h, 02h, 0AEh, 1Eh ; 6f27
	DB 0E7h, 03h, 03h, 02h, 0C6h, 1Ah, 0E7h, 03h ; 6f2f
	DB 03h, 02h, 0C6h, 1Ah, 0E7h, 03h, 00h, 08h ; 6f37
	DB 00h, 00h, 00h, 00h, 01h, 02h, 0DEh, 16h ; 6f3f
	DB 0E7h, 03h, 03h, 02h ; 6f47
	ASCII "x" ; 6f4b
	DB 11h, 0E8h, 03h, 03h, 02h, 0F6h, 12h, 0E7h ; 6f4c
	DB 03h, 00h, 08h, 00h, 00h, 00h, 00h, 01h ; 6f54
	DB 02h, 7Eh, 26h, 0E7h, 03h, 03h, 02h, 96h ; 6f5c
	DB 22h, 0E7h, 03h, 03h, 02h, 0AEh, 1Eh, 0E7h ; 6f64
	DB 03h, 00h, 08h, 00h, 00h, 00h, 00h, 01h ; 6f6c
	DB 02h, 0C6h, 1Ah, 0E7h, 03h, 03h, 02h, 60h ; 6f74
	DB 15h, 0E8h, 03h, 03h, 02h, 0DEh, 16h, 0E7h ; 6f7c
	DB 03h, 00h, 08h, 00h, 00h, 00h, 00h, 03h ; 6f84
	DB 02h, 0F8h, 2Ah, 0E7h, 03h, 03h, 01h, 24h ; 6f8c
	DB 2Ch, 0E8h, 03h, 03h, 02h ; 6f94
	ASCII "P-" ; 6f99
	DB 0E8h, 03h, 03h, 01h, 7Ch, 2Eh, 0E8h, 03h ; 6f9b
	DB 03h, 02h, 0A8h, 2Fh, 0E8h, 03h, 03h, 01h ; 6fa3
	DB 7Ch, 2Eh, 0E8h, 03h, 03h, 02h ; 6fab
	ASCII "P-" ; 6fb1
	DB 0E8h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 6fb3
	DB 03h, 02h, 0F8h, 2Ah, 0E7h, 03h, 03h, 01h ; 6fbb
	DB 2Ah, 26h, 0C7h, 00h, 03h, 02h, 80h, 25h ; 6fc3
	ASCIZ "d" ; 6fcb
	DB 03h, 01h, 1Ch, 25h ; 6fcd
	ASCIZ "d" ; 6fd1
	DB 03h, 02h, 80h, 25h ; 6fd3
	ASCIZ "d" ; 6fd7
	DB 03h, 01h, 0E4h, 25h, 0C7h, 00h, 00h, 07h ; 6fd9
	DB 00h, 00h, 00h, 00h, 03h, 02h, 0F8h, 2Ah ; 6fe1
	DB 0E7h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 6fe9
	DB 03h, 02h ; 6ff1
	ASCII "P-" ; 6ff3
	DB 0E8h, 03h, 03h, 01h, 7Ch, 2Eh, 0E8h, 03h ; 6ff5
	DB 03h, 02h, 0A8h, 2Fh, 0E8h, 03h, 03h, 01h ; 6ffd
	DB 7Ch, 2Eh, 0E8h, 03h, 03h, 02h ; 7005
	ASCII "P-" ; 700b
	DB 0E8h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 700d
	DB 03h, 02h, 0F8h, 2Ah, 0E7h, 03h, 03h, 01h ; 7015
	DB 2Ah, 26h, 0C7h, 00h, 03h, 02h, 80h, 25h ; 701d
	ASCIZ "d" ; 7025
	DB 03h, 01h, 1Ch, 25h ; 7027
	ASCIZ "d" ; 702b
	DB 03h, 02h, 80h, 25h ; 702d
	ASCIZ "d" ; 7031
	DB 03h, 01h, 0E4h, 25h, 0C7h, 00h, 00h, 07h ; 7033
	DB 00h, 00h, 00h, 00h, 03h, 02h, 0F8h, 2Ah ; 703b
	DB 0E7h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 7043
	DB 03h, 02h ; 704b
	ASCII "P-" ; 704d
	DB 0E8h, 03h, 03h, 01h, 7Ch, 2Eh, 0E8h, 03h ; 704f
	DB 03h, 02h, 0A8h, 2Fh, 0E8h, 03h, 03h, 01h ; 7057
	DB 7Ch, 2Eh, 0E8h, 03h, 03h, 02h ; 705f
	ASCII "P-" ; 7065
	DB 0E8h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 7067
	DB 03h, 02h, 0F8h, 2Ah, 0E7h, 03h, 03h, 01h ; 706f
	DB 2Ah, 26h, 0C7h, 00h, 03h, 02h, 80h, 25h ; 7077
	ASCIZ "d" ; 707f
	DB 03h, 01h, 1Ch, 25h ; 7081
	ASCIZ "d" ; 7085
	DB 03h, 02h, 80h, 25h ; 7087
	ASCIZ "d" ; 708b
	DB 03h, 01h, 0E4h, 25h, 0C7h, 00h, 00h, 07h ; 708d
	DB 00h, 00h, 00h, 00h, 03h, 02h, 0F8h, 2Ah ; 7095
	DB 0E7h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 709d
	DB 03h, 02h ; 70a5
	ASCII "P-" ; 70a7
	DB 0E8h, 03h, 03h, 01h, 7Ch, 2Eh, 0E8h, 03h ; 70a9
	DB 03h, 02h, 0A8h, 2Fh, 0E8h, 03h, 03h, 01h ; 70b1
	DB 7Ch, 2Eh, 0E8h, 03h, 03h, 02h ; 70b9
	ASCII "P-" ; 70bf
	DB 0E8h, 03h, 03h, 01h, 24h, 2Ch, 0E8h, 03h ; 70c1
	DB 03h, 02h, 0F8h, 2Ah, 0E7h, 03h, 03h, 01h ; 70c9
	DB 2Ah, 26h, 0C7h, 00h, 03h, 02h, 80h, 25h ; 70d1
	ASCIZ "d" ; 70d9
	DB 03h, 01h, 1Ch, 25h ; 70db
	ASCIZ "d" ; 70df
	DB 03h, 02h, 80h, 25h ; 70e1
	ASCIZ "d" ; 70e5
	DB 03h, 01h, 0E4h, 25h, 0C7h, 00h, 00h, 07h ; 70e7
	DB 00h, 00h, 00h, 00h, 00h, 07h, 00h, 00h ; 70ef
	DB 00h, 00h, 03h, 01h ; 70f7
	ASCII "V" ; 70fb
	DB 13h, 0C3h, 05h, 03h, 01h, 18h, 15h, 0A4h ; 70fc
	DB 06h, 03h, 01h ; 7104
	ASCII "X" ; 7107
	DB 1Bh, 0C4h, 09h, 01h, 01h, 0ECh, 13h, 0Eh ; 7108
	DB 06h, 01h, 01h, 18h, 15h, 0A4h, 06h, 01h ; 7110
	DB 01h ; 7118
	ASCII "X" ; 7119
	DB 1Bh, 0DCh, 05h, 01h, 01h ; 711a
	ASCII "8" ; 711f
	DB 18h ; 7120
	ASCII "L" ; 7121
	DB 04h, 01h, 01h, 18h, 15h, 0BCh, 02h, 01h ; 7122
	DB 01h, 0ECh, 13h, 26h, 02h, 00h, 04h, 00h ; 712a
	DB 00h, 00h, 00h, 00h, 04h, 00h, 00h, 00h ; 7132
	DB 00h, 00h, 04h, 00h, 00h, 00h, 00h, 00h ; 713a
	DB 04h, 00h, 00h, 00h, 00h, 03h, 01h, 0C1h ; 7142
	DB 0Eh ; 714a
	ASCII "j" ; 714b
	DB 05h, 03h, 01h, 26h, 0Bh, 0D0h, 03h, 03h ; 714c
	DB 01h ; 7154
	ASCII "6" ; 7155
	DB 08h, 27h, 02h, 01h, 01h, 0C1h, 0Eh ; 7156
	ASCII "j" ; 715d
	DB 05h, 01h, 01h, 84h, 0Ch ; 715e
	ASCII "N" ; 7163
	DB 04h, 01h, 01h ; 7164
	ASCII "U" ; 7167
	DB 09h, 0BBh, 02h, 01h, 01h ; 7168
	ASCII "6" ; 716d
	DB 08h, 27h, 02h, 01h, 01h, 87h, 07h, 0D0h ; 716e
	DB 01h, 0FFh, 01h, 02h, 0D4h, 03h ; 7176
	ASCIZ "d" ; 717c
	DB 03h, 01h, 0E8h, 03h ; 717e
	ASCIZ "f" ; 7182
	DB 01h, 02h, 0FCh, 03h, 0D0h, 03h, 03h, 01h ; 7184
	DB 10h, 04h, 0BBh, 02h, 01h, 02h ; 718c
	ASCII "8" ; 7192
	DB 04h, 27h, 02h, 01h, 01h ; 7193
	ASCII "L" ; 7198
	DB 04h, 0D0h, 01h, 01h, 02h, 60h, 04h, 82h ; 7199
	DB 01h, 01h, 01h ; 71a1
	ASCII "t" ; 71a4
	DB 04h ; 71a5
	ASCIZ "f" ; 71a6
	DB 01h, 02h, 88h, 04h, 0D0h, 03h, 01h, 01h ; 71a8
	DB 9Ch, 04h, 0BBh, 02h, 01h, 01h, 0B0h, 04h ; 71b0
	DB 0D0h, 01h, 0FFh, 0FFh, 01h, 02h, 0D4h, 03h ; 71b8
	ASCIZ "d" ; 71c0
	DB 03h, 01h, 0E8h, 03h ; 71c2
	ASCIZ "f" ; 71c6
	DB 00h, 0Ch, 00h, 00h, 00h, 00h, 01h, 02h ; 71c8
	DB 0D4h, 03h ; 71d0
	ASCIZ "d" ; 71d2
	DB 03h, 01h, 0E8h, 03h ; 71d4
	ASCIZ "f" ; 71d8
	DB 0FFh, 01h, 02h, 98h ; 71da
	ASCII "X" ; 71de
	DB 01h, 00h, 01h, 02h, 8Eh ; 71df
	ASCII "X" ; 71e4
	DB 01h, 00h, 01h, 02h ; 71e5
	ASCII "zX" ; 71e9
	DB 01h, 00h, 01h, 02h, 60h ; 71eb
	ASCII "1" ; 71f0
	DB 01h, 00h, 01h, 02h ; 71f1
	ASCII "L1" ; 71f5
	DB 01h, 00h, 01h, 02h ; 71f7
	ASCII "l%" ; 71fb
	DB 01h, 00h, 01h, 02h ; 71fd
	ASCII "X%" ; 7201
	DB 01h, 00h, 0FFh, 03h, 01h, 00h ; 7203
	ASCIZ "xd" ; 7209
	DB 03h, 01h, 60h ; 720c
	ASCIZ "qf" ; 720f
	DB 03h, 01h, 00h ; 7212
	ASCIZ "xd" ; 7215
	DB 03h, 01h, 60h ; 7218
	ASCIZ "qf" ; 721b
	DB 03h, 01h, 00h ; 721e
	ASCIZ "xd" ; 7221
	DB 03h, 01h, 60h ; 7224
	ASCIZ "qf" ; 7227
	DB 03h, 01h, 00h ; 722a
	ASCIZ "xd" ; 722d
	DB 03h, 01h, 60h ; 7230
	ASCIZ "qf" ; 7233
	DB 03h, 01h, 00h ; 7236
	ASCIZ "xd" ; 7239
	DB 03h, 01h, 60h ; 723c
	ASCIZ "qf" ; 723f
	DB 03h, 01h, 00h ; 7242
	ASCIZ "xd" ; 7245
	DB 03h, 01h, 60h ; 7248
	ASCIZ "qf" ; 724b
	DB 0FFh, 01h, 01h, 0D4h, 03h ; 724e
	ASCIZ "2" ; 7253
	DB 01h, 01h, 20h, 03h ; 7255
	ASCIZ "R" ; 7259
	DB 01h, 01h, 0EEh, 02h, 28h, 00h, 01h, 01h ; 725b
	DB 0BCh, 02h, 16h, 00h, 00h, 03h, 00h, 00h ; 7263
	DB 00h, 00h, 01h, 01h, 0D4h, 03h ; 726b
	ASCIZ "2" ; 7271
	DB 01h, 01h, 20h, 03h ; 7273
	ASCIZ "R" ; 7277
	DB 01h, 01h, 0EEh, 02h, 28h, 00h, 01h, 01h ; 7279
	DB 0BCh, 02h, 16h, 00h, 00h, 03h, 00h, 00h ; 7281
	DB 00h, 00h, 01h, 01h, 0D4h, 03h ; 7289
	ASCIZ "2" ; 728f
	DB 01h, 01h, 20h, 03h ; 7291
	ASCIZ "R" ; 7295
	DB 01h, 01h, 0EEh, 02h, 28h, 00h, 01h, 01h ; 7297
	DB 0BCh, 02h, 16h, 00h, 0FFh, 01h, 01h, 0E0h ; 729f
	DB 01h, 16h, 00h, 00h, 02h, 00h, 00h, 00h ; 72a7
	DB 00h, 01h, 01h, 5Eh, 02h, 17h, 00h, 00h ; 72af
	DB 02h, 00h, 00h, 00h, 00h, 01h, 01h, 28h ; 72b7
	DB 03h, 16h, 00h, 0FFh, 01h, 01h, 0C0h, 03h ; 72bf
	DB 0E0h, 01h, 00h, 01h, 00h, 00h, 00h, 00h ; 72c7
	DB 01h, 01h, 0C0h, 03h, 0E0h, 01h, 0FFh, 01h ; 72cf
	DB 01h, 10h, 27h ; 72d7
	ASCIZ "d" ; 72da
	DB 01h, 01h, 0DEh, 26h ; 72dc
	ASCIZ "d" ; 72e0
	DB 01h, 01h, 0ACh, 26h ; 72e2
	ASCIZ "d" ; 72e6
	DB 01h, 01h ; 72e8
	ASCIZ "z&d" ; 72ea
	DB 01h, 01h ; 72ee
	ASCIZ "H&d" ; 72f0
	DB 01h, 01h, 16h, 26h ; 72f4
	ASCIZ "d" ; 72f8
	DB 01h, 01h, 0E4h, 25h ; 72fa
	ASCIZ "d" ; 72fe
	DB 01h, 01h, 0B2h, 25h ; 7300
	ASCIZ "d" ; 7304
	DB 01h, 01h, 80h, 25h ; 7306
	ASCIZ "d" ; 730a
	DB 01h, 01h ; 730c
	ASCIZ "N%d" ; 730e
	DB 01h, 01h, 1Ch, 25h ; 7312
	ASCIZ "d" ; 7316
	DB 01h, 01h, 0EAh, 24h ; 7318
	ASCIZ "d" ; 731c
	DB 01h, 01h, 0B8h, 24h ; 731e
	ASCIZ "d" ; 7322
	DB 01h, 01h, 86h, 24h ; 7324
	ASCIZ "d" ; 7328
	DB 01h, 01h ; 732a
	ASCIZ "T$d" ; 732c
	DB 01h, 01h, 22h, 24h ; 7330
	ASCIZ "d" ; 7334
	DB 01h, 01h, 0F0h, 23h ; 7336
	ASCIZ "d" ; 733a
	DB 01h, 01h, 0BEh, 23h ; 733c
	ASCIZ "d" ; 7340
	DB 01h, 01h, 8Ch, 23h ; 7342
	ASCIZ "d" ; 7346
	DB 01h, 01h, 28h, 23h ; 7348
	ASCIZ "d" ; 734c
	DB 01h, 01h, 0F6h, 22h ; 734e
	ASCIZ "d" ; 7352
	DB 01h, 01h, 0C4h, 22h ; 7354
	ASCIZ "d" ; 7358
	DB 01h, 01h, 92h, 22h ; 735a
	ASCIZ "d" ; 735e
	DB 01h, 01h, 60h, 22h ; 7360
	ASCIZ "d" ; 7364
	DB 01h, 01h, 2Eh, 22h ; 7366
	ASCIZ "d" ; 736a
	DB 01h, 01h, 0FCh, 21h ; 736c
	ASCIZ "d" ; 7370
	DB 01h, 01h, 0CAh, 21h ; 7372
	ASCIZ "d" ; 7376
	DB 01h, 01h, 98h, 21h ; 7378
	ASCIZ "d" ; 737c
	DB 01h, 01h ; 737e
	ASCIZ "f!d" ; 7380
	DB 01h, 01h ; 7384
	ASCIZ "4!d" ; 7386
	DB 01h, 01h, 02h, 21h ; 738a
	ASCIZ "d" ; 738e
	DB 01h, 01h, 0D0h, 20h ; 7390
	ASCIZ "d" ; 7394
	DB 01h, 01h, 9Eh, 20h ; 7396
	ASCIZ "d" ; 739a
	DB 01h, 01h ; 739c
	ASCIZ "l d" ; 739e
	DB 01h, 01h, 3Ah, 20h ; 73a2
	ASCIZ "d" ; 73a6
	DB 01h, 01h, 08h, 20h ; 73a8
	ASCIZ "d" ; 73ac
	DB 01h, 01h, 0D6h, 1Fh ; 73ae
	ASCIZ "d" ; 73b2
	DB 01h, 01h, 0A4h, 1Fh ; 73b4
	ASCIZ "d" ; 73b8
	DB 01h, 01h, 40h, 1Fh ; 73ba
	ASCIZ "d" ; 73be
	DB 01h, 01h, 0Eh, 1Fh ; 73c0
	ASCIZ "d" ; 73c4
	DB 01h, 01h, 0DCh, 1Eh ; 73c6
	ASCIZ "d" ; 73ca
	DB 01h, 01h, 0AAh, 1Eh ; 73cc
	ASCIZ "d" ; 73d0
	DB 01h, 01h ; 73d2
	ASCII "x" ; 73d4
	DB 1Eh ; 73d5
	ASCIZ "d" ; 73d6
	DB 01h, 01h ; 73d8
	ASCII "F" ; 73da
	DB 1Eh ; 73db
	ASCIZ "d" ; 73dc
	DB 01h, 01h, 14h, 1Eh ; 73de
	ASCIZ "d" ; 73e2
	DB 01h, 01h, 0E2h, 1Dh ; 73e4
	ASCIZ "d" ; 73e8
	DB 01h, 01h, 0B0h, 1Dh ; 73ea
	ASCIZ "d" ; 73ee
	DB 01h, 01h, 7Eh, 1Dh ; 73f0
	ASCIZ "d" ; 73f4
	DB 01h, 01h ; 73f6
	ASCII "L" ; 73f8
	DB 1Dh ; 73f9
	ASCIZ "d" ; 73fa
	DB 01h, 01h, 1Ah, 1Dh ; 73fc
	ASCIZ "d" ; 7400
	DB 01h, 01h, 0E8h, 1Ch ; 7402
	ASCIZ "d" ; 7406
	DB 01h, 01h, 0B6h, 1Ch ; 7408
	ASCIZ "d" ; 740c
	DB 01h, 01h, 84h, 1Ch ; 740e
	ASCIZ "d" ; 7412
	DB 01h, 01h ; 7414
	ASCII "R" ; 7416
	DB 1Ch ; 7417
	ASCIZ "d" ; 7418
	DB 01h, 01h, 20h, 1Ch ; 741a
	ASCIZ "d" ; 741e
	DB 01h, 01h, 0EEh, 1Bh ; 7420
	ASCIZ "d" ; 7424
	DB 01h, 01h, 0BCh, 1Bh ; 7426
	ASCIZ "d" ; 742a
	DB 01h, 01h ; 742c
	ASCII "X" ; 742e
	DB 1Bh ; 742f
	ASCIZ "d" ; 7430
	DB 01h, 01h, 26h, 1Bh ; 7432
	ASCIZ "d" ; 7436
	DB 01h, 01h, 0F4h, 1Ah ; 7438
	ASCIZ "d" ; 743c
	DB 01h, 01h, 0C2h, 1Ah ; 743e
	ASCIZ "d" ; 7442
	DB 01h, 01h, 90h, 1Ah ; 7444
	ASCIZ "d" ; 7448
	DB 01h, 01h, 5Eh, 1Ah ; 744a
	ASCIZ "d" ; 744e
	DB 01h, 01h, 2Ch, 1Ah ; 7450
	ASCIZ "d" ; 7454
	DB 01h, 01h, 0FAh, 19h ; 7456
	ASCIZ "d" ; 745a
	DB 01h, 01h, 0C8h, 19h ; 745c
	ASCIZ "d" ; 7460
	DB 01h, 01h, 96h, 19h ; 7462
	ASCIZ "d" ; 7466
	DB 01h, 01h ; 7468
	ASCII "d" ; 746a
	DB 19h ; 746b
	ASCIZ "d" ; 746c
	DB 01h, 01h ; 746e
	ASCII "2" ; 7470
	DB 19h ; 7471
	ASCIZ "d" ; 7472
	DB 01h, 01h, 00h, 19h ; 7474
	ASCIZ "d" ; 7478
	DB 01h, 01h, 0CEh, 18h ; 747a
	ASCIZ "d" ; 747e
	DB 01h, 01h, 9Ch, 18h ; 7480
	ASCIZ "d" ; 7484
	DB 01h, 01h ; 7486
	ASCII "j" ; 7488
	DB 18h ; 7489
	ASCIZ "d" ; 748a
	DB 01h, 01h ; 748c
	ASCII "8" ; 748e
	DB 18h ; 748f
	ASCIZ "d" ; 7490
	DB 01h, 01h, 06h, 18h ; 7492
	ASCIZ "d" ; 7496
	DB 01h, 01h, 0D4h, 17h ; 7498
	ASCIZ "d" ; 749c
	DB 01h, 01h ; 749e
	ASCII "p" ; 74a0
	DB 17h ; 74a1
	ASCIZ "d" ; 74a2
	DB 01h, 02h, 3Eh, 17h ; 74a4
	ASCIZ "d" ; 74a8
	DB 01h, 02h, 0Ch, 17h ; 74aa
	ASCIZ "d" ; 74ae
	DB 01h, 02h, 0DAh, 16h ; 74b0
	ASCIZ "d" ; 74b4
	DB 01h, 02h, 0A8h, 16h ; 74b6
	ASCIZ "d" ; 74ba
	DB 01h, 02h ; 74bc
	ASCII "v" ; 74be
	DB 16h ; 74bf
	ASCIZ "d" ; 74c0
	DB 01h, 02h ; 74c2
	ASCII "D" ; 74c4
	DB 16h ; 74c5
	ASCIZ "d" ; 74c6
	DB 01h, 02h, 12h, 16h ; 74c8
	ASCIZ "d" ; 74cc
	DB 01h, 02h, 0E0h, 15h ; 74ce
	ASCIZ "d" ; 74d2
	DB 01h, 02h, 0AEh, 15h ; 74d4
	ASCIZ "d" ; 74d8
	DB 01h, 02h, 7Ch, 15h ; 74da
	ASCIZ "d" ; 74de
	DB 01h, 02h ; 74e0
	ASCII "J" ; 74e2
	DB 15h ; 74e3
	ASCIZ "d" ; 74e4
	DB 01h, 02h, 18h, 15h ; 74e6
	ASCIZ "d" ; 74ea
	DB 01h, 02h, 0E6h, 14h ; 74ec
	ASCIZ "d" ; 74f0
	DB 01h, 02h, 0B4h, 14h ; 74f2
	ASCIZ "d" ; 74f6
	DB 01h, 02h, 82h, 14h ; 74f8
	ASCIZ "d" ; 74fc
	DB 01h, 02h ; 74fe
	ASCII "P" ; 7500
	DB 14h ; 7501
	ASCIZ "d" ; 7502
	DB 01h, 02h, 1Eh, 14h ; 7504
	ASCIZ "d" ; 7508
	DB 01h, 02h, 0ECh, 13h ; 750a
	ASCIZ "d" ; 750e
	DB 01h, 02h, 88h, 13h ; 7510
	ASCIZ "d" ; 7514
	DB 01h, 02h ; 7516
	ASCII "V" ; 7518
	DB 13h ; 7519
	ASCIZ "d" ; 751a
	DB 01h, 02h, 24h, 13h ; 751c
	ASCIZ "d" ; 7520
	DB 01h, 02h, 0F2h, 12h ; 7522
	ASCIZ "d" ; 7526
	DB 01h, 02h, 0C0h, 12h ; 7528
	ASCIZ "d" ; 752c
	DB 01h, 02h, 8Eh, 12h ; 752e
	ASCIZ "d" ; 7532
	DB 01h, 02h, 5Ch, 12h ; 7534
	ASCIZ "d" ; 7538
	DB 01h, 02h, 2Ah, 12h ; 753a
	ASCIZ "d" ; 753e
	DB 01h, 02h, 0F8h, 11h ; 7540
	ASCIZ "d" ; 7544
	DB 01h, 02h, 0C6h, 11h ; 7546
	ASCIZ "d" ; 754a
	DB 01h, 02h, 94h, 11h ; 754c
	ASCIZ "d" ; 7550
	DB 01h, 02h ; 7552
	ASCII "b" ; 7554
	DB 11h ; 7555
	ASCIZ "d" ; 7556
	DB 01h, 02h ; 7558
	ASCII "0" ; 755a
	DB 11h ; 755b
	ASCIZ "d" ; 755c
	DB 01h, 02h, 0FEh, 10h ; 755e
	ASCIZ "d" ; 7562
	DB 01h, 02h, 0CCh, 10h ; 7564
	ASCIZ "d" ; 7568
	DB 01h, 02h, 9Ah, 10h ; 756a
	ASCIZ "d" ; 756e
	DB 01h, 02h ; 7570
	ASCII "h" ; 7572
	DB 10h ; 7573
	ASCIZ "d" ; 7574
	DB 01h, 02h ; 7576
	ASCII "6" ; 7578
	DB 10h ; 7579
	ASCIZ "d" ; 757a
	DB 01h, 02h, 04h, 10h ; 757c
	ASCIZ "d" ; 7580
	DB 01h, 02h, 0A0h, 0Fh ; 7582
	ASCIZ "d" ; 7586
	DB 01h, 02h ; 7588
	ASCII "n" ; 758a
	DB 0Fh ; 758b
	ASCIZ "d" ; 758c
	DB 01h, 02h, 3Ch, 0Fh ; 758e
	ASCIZ "d" ; 7592
	DB 01h, 02h, 0Ah, 0Fh ; 7594
	ASCIZ "d" ; 7598
	DB 01h, 02h, 0D8h, 0Eh ; 759a
	ASCIZ "d" ; 759e
	DB 01h, 02h, 0A6h, 0Eh ; 75a0
	ASCIZ "d" ; 75a4
	DB 01h, 02h ; 75a6
	ASCII "t" ; 75a8
	DB 0Eh ; 75a9
	ASCIZ "d" ; 75aa
	DB 01h, 02h ; 75ac
	ASCII "B" ; 75ae
	DB 0Eh ; 75af
	ASCIZ "d" ; 75b0
	DB 01h, 02h, 10h, 0Eh ; 75b2
	ASCIZ "d" ; 75b6
	DB 01h, 02h, 0DEh, 0Dh ; 75b8
	ASCIZ "d" ; 75bc
	DB 01h, 02h, 0ACh, 0Dh ; 75be
	ASCIZ "d" ; 75c2
	DB 01h, 02h ; 75c4
	ASCII "z" ; 75c6
	DB 0Dh ; 75c7
	ASCIZ "d" ; 75c8
	DB 01h, 02h ; 75ca
	ASCII "H" ; 75cc
	DB 0Dh ; 75cd
	ASCIZ "d" ; 75ce
	DB 01h, 02h, 16h, 0Dh ; 75d0
	ASCIZ "d" ; 75d4
	DB 01h, 02h, 0E4h, 0Ch ; 75d6
	ASCIZ "d" ; 75da
	DB 01h, 02h, 0B2h, 0Ch ; 75dc
	ASCIZ "d" ; 75e0
	DB 01h, 02h, 80h, 0Ch ; 75e2
	ASCIZ "d" ; 75e6
	DB 01h, 02h ; 75e8
	ASCII "N" ; 75ea
	DB 0Ch ; 75eb
	ASCIZ "d" ; 75ec
	DB 01h, 02h, 1Ch, 0Ch ; 75ee
	ASCIZ "d" ; 75f2
	DB 01h, 02h, 0B8h, 0Bh ; 75f4
	ASCIZ "d" ; 75f8
	DB 01h, 02h, 86h, 0Bh ; 75fa
	ASCIZ "d" ; 75fe
	DB 01h, 02h ; 7600
	ASCII "T" ; 7602
	DB 0Bh ; 7603
	ASCIZ "d" ; 7604
	DB 01h, 02h, 22h, 0Bh ; 7606
	ASCIZ "d" ; 760a
	DB 01h, 02h, 0F0h, 0Ah ; 760c
	ASCIZ "d" ; 7610
	DB 01h, 02h, 0BEh, 0Ah ; 7612
	ASCIZ "d" ; 7616
	DB 01h, 02h, 8Ch, 0Ah ; 7618
	ASCIZ "d" ; 761c
	DB 01h, 02h ; 761e
	ASCII "Z" ; 7620
	DB 0Ah ; 7621
	ASCIZ "d" ; 7622
	DB 01h, 02h, 28h, 0Ah ; 7624
	ASCIZ "d" ; 7628
	DB 01h, 02h, 0F6h, 09h ; 762a
	ASCIZ "d" ; 762e
	DB 01h, 02h, 0C4h, 09h ; 7630
	ASCIZ "d" ; 7634
	DB 01h, 02h, 92h, 09h ; 7636
	ASCIZ "d" ; 763a
	DB 01h, 02h, 60h, 09h ; 763c
	ASCIZ "d" ; 7640
	DB 01h, 02h, 2Eh, 09h ; 7642
	ASCIZ "d" ; 7646
	DB 01h, 02h, 0FCh, 08h ; 7648
	ASCIZ "d" ; 764c
	DB 01h, 02h, 0CAh, 08h ; 764e
	ASCIZ "d" ; 7652
	DB 01h, 02h, 98h, 08h ; 7654
	ASCIZ "d" ; 7658
	DB 01h, 02h ; 765a
	ASCII "f" ; 765c
	DB 08h ; 765d
	ASCIZ "d" ; 765e
	DB 01h, 02h ; 7660
	ASCII "4" ; 7662
	DB 08h ; 7663
	ASCIZ "d" ; 7664
	DB 01h, 02h, 0D0h, 07h ; 7666
	ASCIZ "d" ; 766a
	DB 0FFh, 03h, 02h ; 766c
	ASCII "X" ; 766f
	DB 1Bh, 0ACh, 0Dh, 03h, 02h ; 7670
	ASCII "L" ; 7675
	DB 1Dh, 0A6h, 0Eh, 03h, 02h, 20h, 1Ch, 10h ; 7676
	DB 0Eh, 03h, 02h ; 767e
	ASCII "X" ; 7681
	DB 1Bh, 0ACh, 0Dh, 03h, 02h, 00h, 19h, 80h ; 7682
	DB 0Ch, 03h, 02h, 0A8h, 16h ; 768a
	ASCII "T" ; 768f
	DB 0Bh, 01h, 02h ; 7690
	ASCII "X" ; 7693
	DB 1Bh, 0ACh, 0Dh, 01h, 02h ; 7694
	ASCII "L" ; 7699
	DB 1Dh, 0A6h, 0Eh, 01h, 02h, 20h, 1Ch, 10h ; 769a
	DB 0Eh, 01h, 02h ; 76a2
	ASCII "X" ; 76a5
	DB 1Bh, 0ACh, 0Dh, 01h, 02h, 00h, 19h, 80h ; 76a6
	DB 0Ch, 01h, 02h, 0A8h, 16h ; 76ae
	ASCII "T" ; 76b3
	DB 0Bh, 0FFh, 03h, 02h, 0E8h, 03h ; 76b4
	ASCIZ "d" ; 76ba
	DB 03h, 02h, 0B0h, 04h ; 76bc
	ASCIZ "d" ; 76c0
	DB 03h, 02h, 0DCh, 05h ; 76c2
	ASCIZ "d" ; 76c6
	DB 03h, 02h, 0D0h, 07h ; 76c8
	ASCIZ "d" ; 76cc
	DB 01h, 02h, 0E8h, 03h ; 76ce
	ASCIZ "d" ; 76d2
	DB 01h, 02h, 0B0h, 04h ; 76d4
	ASCIZ "d" ; 76d8
	DB 01h, 02h, 0DCh, 05h ; 76da
	ASCIZ "d" ; 76de
	DB 01h, 02h, 0D0h, 07h ; 76e0
	ASCIZ "d" ; 76e4
	DB 0FFh, 03h, 01h, 0B0h, 1Dh, 0B8h, 0Bh, 03h ; 76e6
	DB 01h, 0E8h, 1Ch, 1Eh, 0Ch, 03h, 01h, 20h ; 76ee
	DB 1Ch, 1Eh, 0Ch, 03h, 01h ; 76f6
	ASCII "X" ; 76fb
	DB 1Bh, 1Eh, 0Ch, 03h, 01h, 90h, 1Ah, 1Eh ; 76fc
	DB 0Ch, 03h, 01h, 0C8h, 19h, 1Eh, 0Ch, 03h ; 7704
	DB 01h, 9Ch, 18h, 1Eh, 0Ch, 03h, 01h ; 770c
	ASCII "p" ; 7713
	DB 17h, 1Eh, 0Ch, 03h, 01h, 7Ch, 15h, 1Eh ; 7714
	DB 0Ch, 03h, 01h, 88h, 13h, 1Eh, 0Ch, 03h ; 771c
	DB 01h, 94h, 11h, 1Eh, 0Ch, 03h, 01h, 0A0h ; 7724
	DB 0Fh, 1Eh, 0Ch, 03h, 01h, 0B8h, 0Bh ; 772c
	ASCII "6" ; 7733
	DB 08h, 01h, 01h, 0B0h, 1Dh, 0B8h, 0Bh, 01h ; 7734
	DB 01h, 0E8h, 1Ch, 1Eh, 0Ch, 01h, 01h, 20h ; 773c
	DB 1Ch, 1Eh, 0Ch, 01h, 01h ; 7744
	ASCII "X" ; 7749
	DB 1Bh, 1Eh, 0Ch, 01h, 01h, 90h, 1Ah, 1Eh ; 774a
	DB 0Ch, 01h, 01h, 0C8h, 19h, 1Eh, 0Ch, 01h ; 7752
	DB 01h, 9Ch, 18h, 1Eh, 0Ch, 01h, 01h ; 775a
	ASCII "p" ; 7761
	DB 17h, 1Eh, 0Ch, 01h, 01h, 7Ch, 15h, 1Eh ; 7762
	DB 0Ch, 01h, 01h, 88h, 13h, 1Eh, 0Ch, 01h ; 776a
	DB 01h, 94h, 11h, 1Eh, 0Ch, 01h, 01h, 0A0h ; 7772
	DB 0Fh, 1Eh, 0Ch, 01h, 01h, 0B8h, 0Bh ; 777a
	ASCII "6" ; 7781
	DB 08h, 0FFh, 01h, 01h, 0C0h, 03h, 0E0h, 01h ; 7782
	DB 00h, 01h, 00h, 00h, 00h, 00h, 01h, 01h ; 778a
	DB 0C0h, 03h ; 7792
	ASCII "p" ; 7794
	DB 03h, 01h, 01h, 0ACh, 03h ; 7795
	ASCII "f" ; 779a
	DB 03h, 01h, 01h, 98h, 03h, 5Ch, 03h, 01h ; 779b
	DB 01h, 84h, 03h ; 77a3
	ASCII "R" ; 77a6
	DB 03h, 00h, 02h, 00h, 00h, 00h, 00h, 01h ; 77a7
	DB 01h, 0FAh, 02h ; 77af
	ASCII "E" ; 77b2
	DB 02h, 01h, 01h, 22h, 03h, 0F5h, 01h, 0FFh ; 77b3
	DB 00h, 01h, 00h, 00h, 00h, 00h, 0FFh, 03h ; 77bb
	DB 04h, 00h, 0Ah, 00h, 05h, 00h, 02h, 00h ; 77c3
	DB 00h, 00h, 00h, 03h, 04h, 80h, 07h, 0C0h ; 77cb
	DB 03h, 00h, 02h, 00h, 00h, 00h, 00h, 00h ; 77d3
	DB 04h, 00h, 00h, 00h, 00h, 00h, 02h, 00h ; 77db
	DB 00h, 00h, 00h, 03h, 04h, 0F4h, 05h, 0FCh ; 77e3
	DB 02h, 00h, 02h, 00h, 00h, 00h, 00h, 03h ; 77eb
	DB 04h, 0A0h, 05h, 0D0h, 02h, 00h, 02h, 00h ; 77f3
	DB 00h, 00h, 00h, 03h, 04h, 0F4h, 05h, 0FCh ; 77fb
	DB 02h, 00h, 02h, 00h, 00h, 00h, 00h, 03h ; 7803
	DB 04h, 00h, 05h, 80h, 02h, 0FFh, 03h, 02h ; 780b
	DB 0E8h, 0Bh, 0F4h, 05h, 00h, 04h, 00h, 00h ; 7813
	DB 00h, 00h, 03h, 02h, 0F4h, 05h, 0FAh, 02h ; 781b
	DB 00h, 04h, 00h, 00h, 00h, 00h, 03h, 02h ; 7823
	DB 0E8h, 0Bh, 0F4h, 05h, 00h, 04h, 00h, 00h ; 782b
	DB 00h, 00h, 03h, 02h, 40h, 0Bh, 0A0h, 05h ; 7833
	DB 00h, 04h, 00h, 00h, 00h, 00h, 03h, 02h ; 783b
	DB 0A0h, 05h, 0D0h, 02h, 00h, 04h, 00h, 00h ; 7843
	DB 00h, 00h, 03h, 02h, 40h, 0Bh, 0A0h, 05h ; 784b
	DB 00h, 04h, 00h, 00h, 00h, 00h, 03h, 02h ; 7853
	DB 00h, 0Ah, 00h, 05h, 00h, 04h, 00h, 00h ; 785b
	DB 00h, 00h, 03h, 02h, 00h, 05h, 80h, 02h ; 7863
	DB 00h, 04h, 00h, 00h, 00h, 00h, 03h, 02h ; 786b
	DB 00h, 0Ah, 00h, 05h, 00h, 04h, 00h, 00h ; 7873
	DB 00h, 00h, 03h, 04h, 0C0h, 03h, 0E0h, 01h ; 787b
	DB 0FFh, 03h, 02h, 00h, 0Fh, 80h, 07h, 0FFh ; 7883
	DB 03h, 02h, 2Ch, 0Eh, 16h, 07h, 0FFh, 03h ; 788b
	DB 02h, 5Ch, 0Dh, 0AEh, 06h, 0FFh, 03h, 02h ; 7893
	DB 0A0h, 0Ch ; 789b
	ASCII "P" ; 789d
	DB 06h, 0FFh, 03h, 02h, 0E8h, 0Bh, 0F4h, 05h ; 789e
	DB 0FFh, 03h, 02h, 40h, 0Bh, 0A0h, 05h, 0FFh ; 78a6
	DB 03h, 02h, 9Ch, 0Ah ; 78ae
	ASCII "N" ; 78b2
	DB 05h, 0FFh, 03h, 02h, 00h, 0Ah, 00h, 05h ; 78b3
	DB 0FFh, 03h, 02h ; 78bb
	ASCII "x" ; 78be
	DB 09h, 0BCh, 04h, 0FFh, 03h, 02h, 0ECh, 08h ; 78bf
	ASCII "v" ; 78c7
	DB 04h, 0FFh, 03h, 02h, 60h, 08h ; 78c8
	ASCII "0" ; 78ce
	DB 04h, 0FFh, 03h, 02h, 0D8h, 07h, 0ECh, 03h ; 78cf
	DB 0FFh, 03h, 02h, 80h, 07h, 0C0h, 03h, 0FFh ; 78d7
	DB 03h, 02h, 16h, 07h, 8Bh, 03h, 0FFh, 03h ; 78df
	DB 02h, 0AEh, 06h ; 78e7
	ASCII "W" ; 78ea
	DB 03h, 0FFh, 03h, 02h ; 78eb
	ASCII "P" ; 78ef
	DB 06h, 28h, 03h, 0FFh, 03h, 02h, 0F4h, 05h ; 78f0
	DB 0FAh, 02h, 0FFh, 03h, 02h, 0A0h, 05h, 0D0h ; 78f8
	DB 02h, 0FFh, 03h, 02h ; 7900
	ASCII "N" ; 7904
	DB 05h, 0A7h, 02h, 0FFh, 03h, 02h, 00h, 05h ; 7905
	DB 80h, 02h, 0FFh, 03h, 02h, 0BCh, 04h, 5Eh ; 790d
	DB 02h, 0FFh, 03h, 02h ; 7915
	ASCII "v" ; 7919
	DB 04h, 3Bh, 02h, 0FFh, 03h, 02h ; 791a
	ASCII "0" ; 7920
	DB 04h, 18h, 02h, 0FFh, 03h, 02h, 0ECh, 03h ; 7921
	DB 0F6h, 01h, 0FFh, 03h, 02h, 0C0h, 03h, 0E0h ; 7929
	DB 01h, 0FFh, 03h, 02h, 8Bh, 03h, 0C5h, 01h ; 7931
	DB 0FFh, 03h, 02h ; 7939
	ASCII "W" ; 793c
	DB 03h, 0ACh, 01h, 0FFh, 03h, 02h, 28h, 03h ; 793d
	DB 94h, 01h, 0FFh, 0CEh ; 7945
	ASCII "D" ; 7949
	DB 04h, 0CEh ; 794a
	ASCII "L" ; 794c
	DB 05h, 0F8h, 0CEh ; 794d
	ASCII "D" ; 7950
	DB 02h, 0CEh ; 7951
	ASCII "L" ; 7953
	DB 03h, 0B0h, 01h, 0CEh ; 7954
	ASCII "D" ; 7958
	DB 06h, 0F8h, 0CEh ; 7959
	ASCII "D" ; 795c
	DB 02h, 0CEh ; 795d
	ASCII "L" ; 795f
	DB 03h, 0B0h, 01h, 0CEh ; 7960
	ASCII "D" ; 7964
	DB 06h, 0C4h ; 7965
	ASCII "q" ; 7967
	DB 9Ah, 0CEh ; 7968
	ASCII "D" ; 796a
	DB 04h, 0CEh ; 796b
	ASCII "L" ; 796d
	DB 05h, 0F8h
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   handles cursor movement
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
	DB 0CEh ; 796e
	ASCII "T" ; 7971
	DB 04h, 0CEh, 5Ch, 05h, 0CEh ; 7972
	ASCII "D" ; 7977
	DB 02h, 0CEh ; 7978
	ASCII "L" ; 797a
	DB 03h, 0B0h, 01h, 0CEh ; 797b
	ASCII "D" ; 797f
	DB 06h, 0F8h, 0CEh ; 7980
	ASCII "D" ; 7983
	DB 0Ah, 0CEh ; 7984
	ASCII "L" ; 7986
	DB 0Eh ; 7987
	ASCII "8" ; 7988
	DB 0CEh ; 7989
	ASCII "D" ; 798a
	DB 09h, 0CEh ; 798b
	ASCII "D" ; 798d
	DB 0Bh, 0CEh ; 798e
	ASCII "D" ; 7990
	DB 0Dh, 0CEh ; 7991
	ASCII "D" ; 7993

	DB 0Fh, 0F8h, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7994
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 799c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79a4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79ac
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79b4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79bc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79c4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79cc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79d4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79dc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79e4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79ec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79f4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 79fc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a04
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a0c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a14
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a1c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a24
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a2c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a34
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a3c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a44
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a4c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a54
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a5c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a64
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a6c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a74
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a7c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a84
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a8c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a94
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7a9c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7aa4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7aac
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ab4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7abc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ac4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7acc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ad4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7adc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ae4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7aec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7af4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7afc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b04
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b0c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b14
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b1c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b24
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b2c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b34
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b3c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b44
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b4c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b54
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b5c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b64
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b6c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b74
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b7c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b84
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b8c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b94
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7b9c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ba4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bac
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bb4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bbc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bc4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bcc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bd4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bdc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7be4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bf4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7bfc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c04
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c0c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c14
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c1c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c24
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c2c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c34
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c3c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c44
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c4c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c54
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c5c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c64
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c6c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c74
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c7c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c84
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c8c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c94
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7c9c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ca4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cac
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cb4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cbc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cc4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ccc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cd4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cdc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ce4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cf4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7cfc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d04
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d0c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d14
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d1c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d24
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d2c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d34
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d3c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d44
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d4c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d54
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d5c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d64
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d6c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d74
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d7c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d84
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d8c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d94
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7d9c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7da4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7dac
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7db4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7dbc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7dc4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7dcc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7dd4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ddc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7de4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7dec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7df4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7dfc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e04
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e0c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e14
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e1c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e24
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e2c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e34
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e3c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e44
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e4c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e54
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e5c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e64
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e6c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e74
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e7c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e84
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e8c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e94
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7e9c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ea4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7eac
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7eb4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ebc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ec4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ecc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ed4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7edc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ee4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7eec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ef4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7efc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f04
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f0c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f14
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f1c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f24
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f2c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f34
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f3c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f44
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f4c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f54
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f5c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f64
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f6c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f74
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f7c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f84
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f8c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f94
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7f9c
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fa4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fac
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fb4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fbc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fc4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fcc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fd4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fdc
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fe4
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7fec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7ff4
	DB 0FFh, 0FFh, 0FFh, 0FFh ; 7ffc
DEFSECT ".rom1", CODE AT 008000H
SECT ".rom1"
; ---------------------- ; 7fff
	DB 0B9h, 0A9h ; 8000
	ASCII "f" ; 8002
	DB 82h, 1Eh, 80h, 1Eh, 80h, 0DDh, 81h, 84h ; 8003
	DB 82h, 0DAh, 0A9h, 0B9h, 0A9h ; 800b
	ASCII "b" ; 8010
	DB 82h, 1Ah, 80h, 1Ah, 80h, 0D9h, 81h, 80h ; 8011
	DB 82h, 9Dh, 99h, 0E3h, 0A7h, 0Ah, 00h, 0FCh ; 8019
	DB 0AFh, 0Ah, 00h, 00h, 0B0h, 0C1h, 99h, 1Eh ; 8021
	DB 80h, 9Dh, 99h, 0E3h, 0A7h ; 8029
	ASCII "O" ; 802e
	DB 9Ah, 0Dh, 7Bh, 0A7h ; 802f
	ASCII "9" ; 8033
	DB 80h ; 8034
	ASCII "P" ; 8035
	DB 80h ; 8036
	ASCII "g" ; 8037
	DB 80h, 08h, 00h, 24h, 0B0h, 08h, 00h, 28h ; 8038
	DB 0B0h ; 8040
	ASCII "O" ; 8041
	DB 9Ah, 0Dh, 08h, 00h, 2Ch, 0B0h, 08h, 00h ; 8042
	DB 28h, 0B0h, 0C1h, 99h, 2Eh, 80h, 08h, 00h ; 804a
	DB 8Ch, 0B2h, 08h, 00h, 90h, 0B2h ; 8052
	ASCII "O" ; 8058
	DB 9Ah, 0Dh, 08h, 00h, 94h, 0B2h, 08h, 00h ; 8059
	DB 90h, 0B2h, 0C1h, 99h, 2Eh, 80h, 08h, 00h ; 8061
	DB 0Ch, 0B5h, 08h, 00h, 10h, 0B5h ; 8069
	ASCII "O" ; 806f
	DB 9Ah, 0Dh, 08h, 00h, 14h, 0B5h, 08h, 00h ; 8070
	DB 10h, 0B5h, 0C1h, 99h, 2Eh, 80h, 9Dh, 99h ; 8078
	DB 0E3h, 0A7h ; 8080
	ASCII "O" ; 8082
	DB 9Ah, 0Dh, 7Bh, 0A7h, 8Dh, 80h, 0A4h, 80h ; 8083
	DB 0BBh, 80h, 08h, 00h ; 808b
	ASCII "8" ; 808f
	DB 0C1h, 08h, 00h, 3Ch, 0C1h ; 8090
	ASCII "O" ; 8095
	DB 9Ah, 0Dh, 08h, 00h, 40h, 0C1h, 08h, 00h ; 8096
	DB 3Ch, 0C1h, 0C1h, 99h, 82h, 80h, 08h, 00h ; 809e
	DB 5Ch, 0C1h, 08h, 00h, 60h, 0C1h ; 80a6
	ASCII "O" ; 80ac
	DB 9Ah, 0Dh, 08h, 00h ; 80ad
	ASCII "d" ; 80b1
	DB 0C1h, 08h, 00h, 60h, 0C1h, 0C1h, 99h, 82h ; 80b2
	DB 80h, 08h, 00h, 8Ch, 0C1h, 08h, 00h, 90h ; 80ba
	DB 0C1h ; 80c2
	ASCII "O" ; 80c3
	DB 9Ah, 0Dh, 08h, 00h, 94h, 0C1h, 08h, 00h ; 80c4
	DB 90h, 0C1h, 0C1h, 99h, 82h, 80h, 9Dh, 99h ; 80cc
	DB 0E3h, 0A7h ; 80d4
	ASCII "O" ; 80d6
	DB 9Ah, 0Dh, 7Bh, 0A7h, 0E1h, 80h, 0F8h, 80h ; 80d7
	DB 0Fh, 81h, 03h, 00h, 24h, 0B0h, 03h, 00h ; 80df
	DB 28h, 0B0h ; 80e7
	ASCII "O" ; 80e9
	DB 9Ah, 0Dh, 03h, 00h, 2Ch, 0B0h, 03h, 00h ; 80ea
	DB 28h, 0B0h, 0C1h, 99h, 0D6h, 80h, 03h, 00h ; 80f2
	DB 0B0h, 0B2h, 03h, 00h, 0B4h, 0B2h ; 80fa
	ASCII "O" ; 8100
	DB 9Ah, 0Dh, 03h, 00h, 0B8h, 0B2h, 03h, 00h ; 8101
	DB 0B4h, 0B2h, 0C1h, 99h, 0D6h, 80h, 03h, 00h ; 8109
	ASCII "0" ; 8111
	DB 0B5h, 03h, 00h ; 8112
	ASCII "4" ; 8115
	DB 0B5h ; 8116
	ASCII "O" ; 8117
	DB 9Ah, 0Dh, 03h, 00h ; 8118
	ASCII "8" ; 811c
	DB 0B5h, 03h, 00h, 3Ch, 0B5h, 0C1h, 99h, 0D6h ; 811d
	DB 80h, 9Dh, 99h, 0E3h, 0A7h ; 8125
	ASCII "O" ; 812a
	DB 9Ah, 0Dh, 7Bh, 0A7h ; 812b
	ASCII "5" ; 812f
	DB 81h ; 8130
	ASCII "L" ; 8131
	DB 81h ; 8132
	ASCII "c" ; 8133
	DB 81h, 03h, 00h ; 8134
	ASCII "8" ; 8137
	DB 0C1h, 03h, 00h, 3Ch, 0C1h ; 8138
	ASCII "O" ; 813d
	DB 9Ah, 0Dh, 03h, 00h, 40h, 0C1h, 03h, 00h ; 813e
	DB 3Ch, 0C1h, 0C1h, 99h, 2Ah, 81h, 03h, 00h ; 8146
	DB 80h, 0C1h, 03h, 00h, 84h, 0C1h ; 814e
	ASCII "O" ; 8154
	DB 9Ah, 0Dh, 03h, 00h, 88h, 0C1h, 03h, 00h ; 8155
	DB 84h, 0C1h, 0C1h, 99h, 2Ah, 81h, 03h, 00h ; 815d
	DB 98h, 0C1h, 03h, 00h, 9Ch, 0C1h ; 8165
	ASCII "O" ; 816b
	DB 9Ah, 0Dh, 03h, 00h, 0A0h, 0C1h, 03h, 00h ; 816c
	DB 0A4h, 0C1h, 0C1h, 99h, 2Ah, 81h ; 8174
	ASCII "O" ; 817a
	DB 9Ah, 0Bh, 7Bh, 0A7h, 85h, 81h, 0A1h, 81h ; 817b
	DB 0BDh, 81h, 07h, 00h, 0F0h, 0B0h, 06h, 00h ; 8183
	DB 0ECh, 0B0h, 06h, 00h, 0F0h, 0B0h, 06h, 00h ; 818b
	DB 0ECh, 0B0h, 07h, 00h, 0F0h, 0B0h, 04h, 00h ; 8193
	DB 0E8h, 0B0h, 0C1h, 99h, 0D9h, 81h, 07h, 00h ; 819b
	ASCII "t" ; 81a3
	DB 0B3h, 06h, 00h ; 81a4
	ASCII "p" ; 81a7
	DB 0B3h, 06h, 00h ; 81a8
	ASCII "t" ; 81ab
	DB 0B3h, 06h, 00h ; 81ac
	ASCII "p" ; 81af
	DB 0B3h, 07h, 00h ; 81b0
	ASCII "t" ; 81b3
	DB 0B3h, 04h, 00h ; 81b4
	ASCII "l" ; 81b7
	DB 0B3h, 0C1h, 99h, 0D9h, 81h, 07h, 00h, 0F4h ; 81b8
	DB 0B5h, 06h, 00h, 0F0h, 0B5h, 06h, 00h, 0F4h ; 81c0
	DB 0B5h, 06h, 00h, 0F0h, 0B5h, 07h, 00h, 0F4h ; 81c8
	DB 0B5h, 04h, 00h, 0ECh, 0B5h, 0C1h, 99h, 0D9h ; 81d0
	DB 81h, 9Dh, 99h, 0E3h, 0A7h ; 81d8
	ASCII "z" ; 81dd
	DB 0AEh, 7Bh, 0A7h, 0E7h, 81h, 0F7h, 81h, 07h ; 81de
	DB 82h, 5Eh, 0A9h, 0Ah, 00h, 94h, 0B0h, 1Ch ; 81e6
	DB 00h ; 81ee
	ASCII "H" ; 81ef
	DB 0B0h, 01h, 00h, 0E8h, 0B0h, 8Eh, 99h, 5Eh ; 81f0
	DB 0A9h, 0Ah, 00h, 18h, 0B3h, 1Ch, 00h, 0D4h ; 81f8
	DB 0B2h, 01h, 00h ; 8200
	ASCII "l" ; 8203
	DB 0B3h, 8Eh, 99h, 5Eh, 0A9h, 0Ah, 00h, 60h ; 8204
	DB 0B5h, 1Ch, 00h, 98h, 0B5h, 01h, 00h, 0ECh ; 820c
	DB 0B5h, 8Eh, 99h ; 8214
	ASCII "O" ; 8217
	DB 9Ah, 0Bh, 9Dh, 99h, 0DDh, 9Dh, 7Bh, 0A7h ; 8218
	DB 26h, 82h, 3Ah, 82h ; 8220
	ASCII "N" ; 8224
	DB 82h, 0Bh, 00h, 04h, 0B1h, 0Ah, 00h, 08h ; 8225
	DB 0B1h, 0Ah, 00h, 04h, 0B1h, 0Bh, 00h, 08h ; 822d
	DB 0B1h, 0C1h, 99h ; 8235
	ASCII "b" ; 8238
	DB 82h, 0Bh, 00h, 88h, 0B3h, 0Ah, 00h, 8Ch ; 8239
	DB 0B3h, 0Ah, 00h, 88h, 0B3h, 0Bh, 00h, 8Ch ; 8241
	DB 0B3h, 0C1h, 99h ; 8249
	ASCII "b" ; 824c
	DB 82h, 0Bh, 00h, 08h, 0B6h, 0Ah, 00h, 0Ch ; 824d
	DB 0B6h, 0Ah, 00h, 08h, 0B6h, 0Bh, 00h, 0Ch ; 8255
	DB 0B6h, 0C1h, 99h ; 825d
	ASCII "b" ; 8260
	DB 82h, 9Dh, 99h, 0E3h, 0A7h, 7Bh, 0A7h ; 8261
	ASCII "n" ; 8268
	DB 82h ; 8269
	ASCII "t" ; 826a
	DB 82h ; 826b
	ASCII "z" ; 826c
	DB 82h, 01h, 00h, 00h, 0B1h, 8Eh, 99h, 01h ; 826d
	DB 00h, 84h, 0B3h, 8Eh, 99h, 01h, 00h, 04h ; 8275
	DB 0B6h, 8Eh, 99h, 9Dh, 99h, 0E3h, 0A7h, 7Bh ; 827d
	DB 0A7h, 8Ch, 82h, 92h, 82h, 98h, 82h, 01h ; 8285
	DB 00h, 14h, 0B1h, 8Eh, 99h, 01h, 00h, 98h ; 828d
	DB 0B3h, 8Eh, 99h, 01h, 00h, 18h, 0B6h, 8Eh ; 8295
	DB 99h, 0AAh, 0A9h ; 829d
	ASCII "O" ; 82a0
	DB 9Ah, 10h, 0DAh, 0A9h, 9Dh, 99h ; 82a1
	ASCII "E" ; 82a7
	DB 0A0h, 7Bh, 0A7h, 0B1h, 82h, 0BFh, 82h, 0CDh ; 82a8
	DB 82h, 04h, 00h, 60h, 0B0h, 04h, 00h ; 82b0
	ASCII "d" ; 82b7
	DB 0B0h, 0AEh, 0A9h, 0C1h, 99h, 0A0h, 82h, 04h ; 82b8
	DB 00h, 0ECh, 0B2h, 04h, 00h, 0F0h, 0B2h, 0AEh ; 82c0
	DB 0A9h, 0C1h, 99h, 0A0h, 82h, 04h, 00h ; 82c8
	ASCII "x" ; 82cf
	DB 0B5h, 04h, 00h, 7Ch, 0B5h, 0AEh, 0A9h, 0C1h ; 82d0
	DB 99h, 0A0h, 82h, 9Dh, 99h, 0ECh, 9Fh, 7Bh ; 82d8
	DB 0A7h, 0E7h, 82h, 01h, 83h, 1Bh, 83h ; 82e0
	ASCII "t" ; 82e7
	DB 0AAh, 0EDh, 82h, 0F7h, 82h, 04h, 00h ; 82e8
	ASCII "h" ; 82ef
	DB 0B0h, 04h, 00h ; 82f0
	ASCII "l" ; 82f3
	DB 0B0h, 8Eh, 99h, 04h, 00h, 0Ch, 0B1h, 04h ; 82f4
	DB 00h, 10h, 0B1h, 8Eh, 99h ; 82fc
	ASCII "t" ; 8301
	DB 0AAh, 07h, 83h, 11h, 83h, 04h, 00h, 0F4h ; 8302
	DB 0B2h, 04h, 00h, 0F8h, 0B2h, 8Eh, 99h, 04h ; 830a
	DB 00h, 90h, 0B3h, 04h, 00h, 94h, 0B3h, 8Eh ; 8312
	DB 99h ; 831a
	ASCII "t" ; 831b
	DB 0AAh, 21h, 83h, 2Bh, 83h, 04h, 00h, 80h ; 831c
	DB 0B5h, 04h, 00h, 84h, 0B5h, 8Eh, 99h, 04h ; 8324
	DB 00h, 10h, 0B6h, 04h, 00h, 14h, 0B6h, 8Eh ; 832c
	DB 99h ; 8334
	ASCII "O" ; 8335
	DB 9Ah, 11h, 9Dh, 99h ; 8336
	ASCII "i" ; 833a
	DB 0A0h, 7Bh, 0A7h ; 833b
	ASCII "D" ; 833e
	DB 83h ; 833f
	ASCII "J" ; 8340
	DB 83h ; 8341
	ASCII "P" ; 8342
	DB 83h, 01h, 00h ; 8343
	ASCII "T" ; 8346
	DB 0B0h, 8Eh, 99h, 01h, 00h, 0E0h, 0B2h, 8Eh ; 8347
	DB 99h, 01h, 00h ; 834f
	ASCII "l" ; 8352
	DB 0B5h, 8Eh, 99h, 9Dh, 99h, 0DDh, 9Dh, 97h ; 8353
	DB 99h, 04h, 82h, 0A9h, 7Bh, 0A7h ; 835b
	ASCII "g" ; 8361
	DB 83h, 7Bh, 83h, 8Fh, 83h, 82h, 0AAh, 0A3h ; 8362
	DB 83h, 0ABh, 83h, 0B3h, 83h, 0BBh, 83h, 0C3h ; 836a
	DB 83h, 0CBh, 83h, 0D3h, 83h, 0DBh, 83h, 0E3h ; 8372
	DB 83h, 82h, 0AAh, 0EBh, 83h, 0F3h, 83h, 0FBh ; 837a
	DB 83h, 03h, 84h, 0Bh, 84h, 13h, 84h, 1Bh ; 8382
	DB 84h, 23h, 84h, 2Bh, 84h, 82h, 0AAh ; 838a
	ASCII "3" ; 8391
	DB 84h, 3Bh, 84h ; 8392
	ASCII "C" ; 8395
	DB 84h ; 8396
	ASCII "K" ; 8397
	DB 84h ; 8398
	ASCII "S" ; 8399
	DB 84h, 5Bh, 84h ; 839a
	ASCII "c" ; 839d
	DB 84h ; 839e
	ASCII "k" ; 839f
	DB 84h ; 83a0
	ASCII "s" ; 83a1
	DB 84h, 0Ah, 00h, 0FCh, 0AFh, 0C1h, 99h, 7Bh ; 83a2
	DB 84h, 0Ah, 00h, 04h, 0B0h, 0C1h, 99h, 7Bh ; 83aa
	DB 84h, 0Ah, 00h, 08h, 0B0h, 0C1h, 99h, 7Bh ; 83b2
	DB 84h, 0Ah, 00h, 0Ch, 0B0h, 0C1h, 99h, 7Bh ; 83ba
	DB 84h, 0Ah, 00h, 10h
loc_0x0083C6:
	DB 0B0h, 0C1h, 99h, 7Bh ; 83c2
	DB 84h, 0Ah, 00h, 14h, 0B0h, 0C1h, 99h, 7Bh ; 83ca
	DB 84h, 0Ah, 00h, 18h, 0B0h, 0C1h, 99h, 7Bh ; 83d2
	DB 84h, 0Ah, 00h, 1Ch, 0B0h, 0C1h, 99h, 7Bh ; 83da
	DB 84h, 0Ah, 00h, 20h, 0B0h, 0C1h, 99h, 7Bh ; 83e2
	DB 84h, 0Ah, 00h ; 83ea
	ASCII "d" ; 83ed
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h ; 83ee
	ASCII "l" ; 83f5
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h ; 83f6
	ASCII "p" ; 83fd
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h ; 83fe
	ASCII "t" ; 8405
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h ; 8406
	ASCII "x" ; 840d
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 7Ch ; 840e
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 80h ; 8416
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 84h ; 841e
	DB 0B2h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 88h ; 8426
	DB 0B2h
loc_0x00842F:
	DB 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 0E4h ; 842e
	DB 0B4h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 0ECh ; 8436
	DB 0B4h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 0F0h ; 843e
	DB 0B4h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 0F4h ; 8446
	DB 0B4h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 0F8h ; 844e
	DB 0B4h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 0FCh ; 8456
	DB 0B4h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 00h ; 845e
	DB 0B5h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 04h ; 8466
	DB 0B5h, 0C1h, 99h, 7Bh, 84h, 0Ah, 00h, 08h ; 846e
	DB 0B5h, 0C1h, 99h, 7Bh, 84h, 0E7h, 0AAh, 0F2h ; 8476
	DB 84h, 0Eh, 80h, 83h, 84h ; 847e
	ASCII "O" ; 8483
	DB 9Ah, 0Bh, 7Bh, 0A7h, 8Eh, 84h, 96h, 84h ; 8484
	DB 9Eh, 84h, 01h, 00h, 18h, 0B0h, 0C1h, 99h ; 848c
	DB 0A2h, 84h, 01h, 00h, 80h, 0B2h, 0C1h, 99h ; 8494
	DB 0A2h, 84h, 01h, 00h, 00h, 0B5h, 7Bh, 0A7h ; 849c
	DB 0AAh, 84h, 0C2h, 84h, 0DAh, 84h, 07h, 00h ; 84a4
	DB 0E0h, 0B0h, 06h, 00h, 0E4h, 0B0h, 06h, 00h ; 84ac
	DB 0E0h, 0B0h, 07h, 00h, 0E4h, 0B0h, 04h, 00h ; 84b4
	DB 18h, 0B0h, 0C1h, 99h, 0Eh, 80h, 07h, 00h ; 84bc
	ASCII "d" ; 84c4
	DB 0B3h, 06h, 00h ; 84c5
	ASCII "h" ; 84c8
	DB 0B3h, 06h, 00h ; 84c9
	ASCII "d" ; 84cc
	DB 0B3h, 07h, 00h ; 84cd
	ASCII "h" ; 84d0
	DB 0B3h, 04h, 00h, 80h, 0B2h, 0C1h, 99h, 0Eh ; 84d1
	DB 80h, 07h, 00h, 0E4h, 0B5h, 06h, 00h, 0E8h ; 84d9
	DB 0B5h, 06h, 00h, 0E4h, 0B5h, 07h, 00h, 0E8h ; 84e1
	DB 0B5h, 04h, 00h, 00h, 0B5h, 0C1h, 99h, 0Eh ; 84e9
	DB 80h ; 84f1
	ASCII "O" ; 84f2
	DB 9Ah, 0Ah, 0EBh, 0ACh, 0FBh, 84h ; 84f3
	ASCII "W" ; 84f9
	DB 85h, 7Bh, 0A7h, 25h, 85h, 25h, 85h, 03h ; 84fa
	DB 85h, 04h, 00h, 88h, 0B5h, 04h, 00h, 0D4h ; 8502
	DB 0B5h, 04h, 00h, 0D8h, 0B5h, 04h, 00h, 0DCh ; 850a
	DB 0B5h, 04h, 00h, 0E0h, 0B5h, 06h, 00h, 0D4h ; 8512
	DB 0B5h, 04h, 00h, 04h, 0B5h, 0F9h, 0ACh ; 851a
	ASCII "A" ; 8521
	DB 85h, 0BCh, 99h, 04h, 00h, 0D0h, 0B0h, 04h ; 8522
	DB 00h, 0D4h, 0B0h, 04h
loc_0x00852E:
	DB 00h, 0D8h, 0B0h, 04h ; 852a
	DB 00h, 0DCh, 0B0h, 04h, 00h, 0D0h, 0B0h, 04h ; 8532
	DB 00h, 1Ch, 0B0h, 0C1h, 99h ; 853a
	ASCII "A" ; 853f
	DB 85h, 1Ah, 0ADh ; 8540
	ASCII "G" ; 8543
	DB 85h ; 8544
	ASCII "O" ; 8545
	DB 85h, 9Dh, 99h ; 8546
	ASCII "b" ; 8549
	DB 9Eh, 0C1h, 99h, 0D6h, 80h, 9Dh, 99h, 95h ; 854a
	DB 9Eh, 0C1h, 99h, 2Ah, 81h, 06h, 00h, 1Ch ; 8552
	DB 0B0h, 07h, 00h, 20h, 0B0h, 04h, 00h, 18h ; 855a
	DB 0B0h, 7Bh, 0A7h ; 8562
	ASCII "q" ; 8565
	DB 85h ; 8566
	ASCII "q" ; 8567
	DB 85h ; 8568
	ASCII "k" ; 8569
	DB 85h, 0F9h, 0ACh ; 856a
	ASCII "q" ; 856d
	DB 85h, 0BCh, 99h, 1Ah, 0ADh ; 856e
	ASCII "w" ; 8573
	DB 85h, 7Fh, 85h, 9Dh, 99h, 0E7h, 9Eh, 0C1h ; 8574
	DB 99h, 2Eh, 80h, 9Dh, 99h, 12h, 9Fh, 0C1h ; 857c
	DB 99h, 82h, 80h, 82h, 0A9h, 9Dh, 99h, 0DDh ; 8584
	DB 9Dh, 2Bh, 0ADh, 0BDh, 85h, 0B5h, 85h, 95h ; 858c
	DB 85h, 7Bh, 0A7h, 9Dh, 85h, 0A5h, 85h, 0ADh ; 8594
	DB 85h, 0Ah, 00h, 0F0h, 0B0h, 0C1h, 99h, 0C1h ; 859c
	DB 85h, 0Ah, 00h ; 85a4
	ASCII "t" ; 85a7
	DB 0B3h, 0C1h, 99h, 0C1h, 85h, 0Ah, 00h, 0F4h ; 85a8
	DB 0B5h, 0C1h, 99h, 0C1h, 85h, 0Ah, 00h, 0ECh ; 85b0
	DB 0B0h, 0C1h, 99h, 0C1h, 85h, 0Ah, 00h, 0E8h ; 85b8
	DB 0B0h, 0E7h, 0AAh, 0C9h, 85h, 0Eh, 80h ; 85c0
	ASCII "z" ; 85c7
	DB 81h ; 85c8
	ASCII "O" ; 85c9
	DB 9Ah, 0Ah, 0F9h, 0ACh, 0D2h, 85h, 0BCh, 99h ; 85ca
	DB 1Ah, 0ADh, 0D8h, 85h, 18h, 86h, 9Dh, 99h ; 85d2
	ASCII "R" ; 85da
	DB 9Fh, 7Bh, 0A7h, 0E4h, 85h, 0E4h, 85h, 0FEh ; 85db
	DB 85h ; 85e3
	ASCII "O" ; 85e4
	DB 9Ah, 0Dh, 0Eh, 00h, 0F4h, 0B0h, 0Eh, 00h ; 85e5
	DB 0F8h, 0B0h ; 85ed
	ASCII "O" ; 85ef
	DB 9Ah, 0Dh, 0Eh, 00h, 0FCh, 0B0h, 0Eh, 00h ; 85f0
	DB 0F8h, 0B0h, 0C1h, 99h, 0DCh, 85h ; 85f8
	ASCII "O" ; 85fe
	DB 9Ah, 0Dh, 0Eh, 00h, 0F8h, 0B5h, 0Eh, 00h ; 85ff
	DB 0FCh, 0B5h ; 8607
	ASCII "O" ; 8609
	DB 9Ah, 0Dh, 0Eh, 00h, 00h, 0B6h, 0Eh, 00h ; 860a
	DB 0FCh, 0B5h, 0C1h, 99h, 0DCh, 85h, 9Dh, 99h ; 8612
	DB 85h, 9Fh, 7Bh, 0A7h, 24h, 86h, 24h, 86h ; 861a
	DB 3Eh, 86h ; 8622
	ASCII "O" ; 8624
	DB 9Ah, 0Dh, 0Eh, 00h ; 8625
	ASCII "P" ; 8629
	DB 0C1h, 0Eh, 00h ; 862a
	ASCII "T" ; 862d
	DB 0C1h ; 862e
	ASCII "O" ; 862f
	DB 9Ah, 0Dh, 0Eh, 00h ; 8630
	ASCII "X" ; 8634
	DB 0C1h, 0Eh, 00h ; 8635
	ASCII "T" ; 8638
	DB 0C1h, 0C1h, 99h, 1Ch, 86h ; 8639
	ASCII "O" ; 863e
	DB 9Ah, 0Dh, 0Eh, 00h, 0B4h, 0C1h, 0Eh, 00h ; 863f
	DB 0B8h, 0C1h ; 8647
	ASCII "O" ; 8649
	DB 9Ah, 0Dh, 0Eh, 00h, 0BCh, 0C1h, 0Eh, 00h ; 864a
	DB 0B8h, 0C1h, 0C1h, 99h, 1Ch, 86h, 9Dh, 99h ; 8652
	DB 0B2h, 0A1h, 0DAh, 0A9h, 96h, 0A9h, 7Bh, 0A7h ; 865a
	ASCII "h" ; 8662
	DB 86h ; 8663
	ASCII "t" ; 8664
	DB 86h, 80h, 86h, 14h, 00h, 0B8h, 0B0h, 14h ; 8665
	DB 00h, 0BCh, 0B0h, 0C1h, 99h ; 866d
	ASCII "X" ; 8672
	DB 86h, 14h, 00h, 3Ch, 0B3h, 14h, 00h, 40h ; 8673
	DB 0B3h, 0C1h, 99h ; 867b
	ASCII "X" ; 867e
	DB 86h, 14h, 00h, 0BCh, 0B5h, 14h, 00h, 0C0h ; 867f
	DB 0B5h, 0C1h, 99h ; 8687
	ASCII "X" ; 868a
	DB 86h, 7Bh, 0A7h, 94h, 86h, 0C4h, 86h, 0F4h ; 868b
	DB 86h, 1Eh, 00h, 0FCh, 0AFh, 0Fh, 00h, 18h ; 8693
	DB 0B1h, 03h, 00h, 1Ch, 0B1h, 03h, 00h, 20h ; 869b
	DB 0B1h, 02h, 00h, 1Ch, 0B1h, 02h, 00h, 20h ; 86a3
	DB 0B1h, 01h, 00h, 1Ch, 0B1h, 01h, 00h, 20h ; 86ab
	DB 0B1h, 01h, 00h, 1Ch, 0B1h, 08h, 00h, 20h ; 86b3
	DB 0B1h, 0Ah, 00h, 0FCh, 0AFh, 0C1h, 99h, 8Ch ; 86bb
	DB 86h, 1Eh, 00h ; 86c3
	ASCII "d" ; 86c6
	DB 0B2h, 0Fh, 00h, 9Ch, 0B3h, 03h, 00h, 0A0h ; 86c7
	DB 0B3h, 03h, 00h, 0A4h, 0B3h, 02h, 00h, 0A0h ; 86cf
	DB 0B3h, 02h, 00h, 0A4h, 0B3h, 01h, 00h, 0A0h ; 86d7
	DB 0B3h, 01h, 00h, 0A4h, 0B3h, 01h, 00h, 0A0h ; 86df
	DB 0B3h, 08h, 00h, 0A4h, 0B3h, 0Ah, 00h ; 86e7
	ASCII "d" ; 86ee
	DB 0B2h, 0C1h, 99h, 8Ch, 86h, 1Eh, 00h, 0E4h ; 86ef
	DB 0B4h, 0Fh, 00h, 1Ch, 0B6h, 03h, 00h, 20h ; 86f7
	DB 0B6h, 03h, 00h, 24h, 0B6h, 02h, 00h, 20h ; 86ff
	DB 0B6h, 02h, 00h, 24h, 0B6h, 01h, 00h, 20h ; 8707
	DB 0B6h, 01h, 00h, 24h, 0B6h, 01h, 00h, 20h ; 870f
	DB 0B6h, 08h, 00h, 24h, 0B6h, 0Ah, 00h, 0E4h ; 8717
	DB 0B4h, 0C1h, 99h, 8Ch, 86h, 7Bh, 0A7h, 2Ch ; 871f
	DB 87h ; 8727
	ASCII "b" ; 8728
	DB 87h, 98h, 87h, 1Eh, 00h, 0FCh, 0AFh, 05h ; 8729
	DB 00h, 24h, 0B1h, 14h, 00h, 0FCh, 0AFh, 14h ; 8731
	DB 00h, 24h, 0B1h, 19h, 00h, 0FCh, 0AFh, 05h ; 8739
	DB 00h, 28h, 0B1h, 19h, 00h, 24h, 0B1h, 14h ; 8741
	DB 00h, 28h, 0B1h, 1Ch, 00h, 24h, 0B1h, 05h ; 8749
	DB 00h, 28h, 0B1h ; 8751
	ASCII "j" ; 8754
	DB 0A9h, 14h, 00h, 2Ch, 0B1h, 0Ah, 00h, 0FCh ; 8755
	DB 0AFh, 0C1h, 99h, 24h, 87h, 1Eh, 00h ; 875d
	ASCII "d" ; 8764
	DB 0B2h, 05h, 00h, 0A8h, 0B3h, 14h, 00h ; 8765
	ASCII "d" ; 876c
	DB 0B2h, 14h, 00h, 0A8h, 0B3h, 19h, 00h ; 876d
	ASCII "d" ; 8774
	DB 0B2h, 05h, 00h, 0ACh, 0B3h, 19h, 00h, 0A8h ; 8775
	DB 0B3h, 14h, 00h, 0ACh, 0B3h, 1Ch, 00h, 0A8h ; 877d
	DB 0B3h, 05h, 00h, 0ACh, 0B3h ; 8785
	ASCII "j" ; 878a
	DB 0A9h, 14h, 00h, 0B0h, 0B3h, 0Ah, 00h ; 878b
	ASCII "d" ; 8792
	DB 0B2h, 0C1h, 99h, 24h, 87h, 1Eh, 00h, 0E4h ; 8793
	DB 0B4h, 05h, 00h, 28h, 0B6h, 14h, 00h, 0E4h ; 879b
	DB 0B4h, 14h, 00h, 28h, 0B6h, 19h, 00h, 0E4h ; 87a3
	DB 0B4h, 05h, 00h, 2Ch, 0B6h, 19h, 00h, 28h ; 87ab
	DB 0B6h, 14h, 00h, 2Ch, 0B6h, 1Ch, 00h, 28h ; 87b3
	DB 0B6h, 05h, 00h, 2Ch, 0B6h ; 87bb
	ASCII "j" ; 87c0
	DB 0A9h, 14h, 00h ; 87c1
	ASCII "0" ; 87c4
	DB 0B6h, 0Ah, 00h, 0E4h, 0B4h, 0C1h, 99h, 24h ; 87c5
	DB 87h, 7Bh, 0A7h, 0D6h, 87h, 0F0h, 87h, 0Ah ; 87cd
	DB 88h, 1Eh, 00h, 0FCh, 0AFh, 14h, 00h, 24h ; 87d5
	DB 0B1h ; 87dd
	ASCII "n" ; 87de
	DB 0A9h, 28h, 00h ; 87df
	ASCII "0" ; 87e2
	DB 0B1h, 0Ah, 00h, 24h, 0B1h, 0Ah, 00h, 0FCh ; 87e3
	DB 0AFh, 0C1h, 99h, 0CEh, 87h, 1Eh, 00h ; 87eb
	ASCII "d" ; 87f2
	DB 0B2h, 14h, 00h, 0A8h, 0B3h ; 87f3
	ASCII "n" ; 87f8
	DB 0A9h, 28h, 00h, 0B4h, 0B3h, 0Ah, 00h, 0A8h ; 87f9
	DB 0B3h, 0Ah, 00h ; 8801
	ASCII "d" ; 8804
	DB 0B2h, 0C1h, 99h, 0CEh, 87h, 1Eh, 00h, 0E4h ; 8805
	DB 0B4h, 14h, 00h, 28h, 0B6h ; 880d
	ASCII "n" ; 8812
	DB 0A9h, 28h, 00h ; 8813
	ASCII "4" ; 8816
	DB 0B6h, 0Ah, 00h, 28h, 0B6h, 0Ah, 00h, 0E4h ; 8817
	DB 0B4h, 0C1h, 99h, 0CEh, 87h, 7Bh, 0A7h, 2Ch ; 881f
	DB 88h ; 8827
	ASCII "d" ; 8828
	DB 88h, 9Ch, 88h, 1Eh, 00h, 18h, 0B0h, 08h ; 8829
	DB 00h ; 8831
	ASCII "4" ; 8832
	DB 0B1h, 1Eh, 00h ; 8833
	ASCII "8" ; 8836
	DB 0B1h, 14h, 00h, 3Ch, 0B1h, 04h, 00h ; 8837
	ASCII "8" ; 883e
	DB 0B1h, 14h, 00h, 40h, 0B1h, 04h, 00h ; 883f
	ASCII "8" ; 8846
	DB 0B1h, 14h, 00h, 3Ch, 0B1h, 04h, 00h ; 8847
	ASCII "8" ; 884e
	DB 0B1h, 14h, 00h, 40h, 0B1h, 14h, 00h ; 884f
	ASCII "8" ; 8856
	DB 0B1h, 08h, 00h ; 8857
	ASCII "4" ; 885a
	DB 0B1h, 0Ah, 00h, 18h, 0B0h, 0C1h, 99h, 24h ; 885b
	DB 88h, 1Eh, 00h, 80h, 0B2h, 08h, 00h, 0B8h ; 8863
	DB 0B3h, 1Eh, 00h, 0BCh, 0B3h, 14h, 00h, 0C0h ; 886b
	DB 0B3h, 04h, 00h, 0BCh, 0B3h, 14h, 00h, 0C4h ; 8873
	DB 0B3h, 04h, 00h, 0BCh, 0B3h, 14h, 00h, 0C0h ; 887b
	DB 0B3h, 04h, 00h, 0BCh, 0B3h, 14h, 00h, 0C4h ; 8883
	DB 0B3h, 14h, 00h, 0BCh, 0B3h, 08h, 00h, 0B8h ; 888b
	DB 0B3h, 0Ah, 00h, 80h, 0B2h, 0C1h, 99h, 24h ; 8893
	DB 88h, 1Eh, 00h, 00h, 0B5h, 08h, 00h ; 889b
	ASCII "8" ; 88a2
	DB 0B6h, 1Eh, 00h, 3Ch, 0B6h, 14h, 00h, 40h ; 88a3
	DB 0B6h, 04h, 00h, 3Ch, 0B6h, 14h, 00h ; 88ab
	ASCII "D" ; 88b2
	DB 0B6h, 04h, 00h, 3Ch, 0B6h, 14h, 00h, 40h ; 88b3
	DB 0B6h, 04h, 00h, 3Ch, 0B6h, 14h, 00h ; 88bb
	ASCII "D" ; 88c2
	DB 0B6h, 14h, 00h, 3Ch, 0B6h, 08h, 00h ; 88c3
	ASCII "8" ; 88ca
	DB 0B6h, 0Ah, 00h, 00h, 0B5h, 0C1h, 99h, 24h ; 88cb
	DB 88h, 7Bh, 0A7h, 0DCh, 88h, 2Ch, 89h, 7Ch ; 88d3
	DB 89h, 1Eh, 00h, 18h, 0B0h, 06h, 00h, 28h ; 88db
	DB 0B0h, 0Ah, 00h ; 88e3
	ASCII "D" ; 88e6
	DB 0B1h, 08h, 00h ; 88e7
	ASCII "H" ; 88ea
	DB 0B1h, 08h, 00h ; 88eb
	ASCII "L" ; 88ee
	DB 0B1h, 14h, 00h ; 88ef
	ASCII "P" ; 88f2
	DB 0B1h, 06h, 00h ; 88f3
	ASCII "T" ; 88f6
	DB 0B1h, 14h, 00h ; 88f7
	ASCII "P" ; 88fa
	DB 0B1h, 06h, 00h ; 88fb
	ASCII "T" ; 88fe
	DB 0B1h, 04h, 00h ; 88ff
	ASCII "P" ; 8902
	DB 0B1h, 04h, 00h ; 8903
	ASCII "T" ; 8906
	DB 0B1h, 04h, 00h ; 8907
	ASCII "P" ; 890a
	DB 0B1h, 04h, 00h ; 890b
	ASCII "T" ; 890e
	DB 0B1h, 0Fh, 00h ; 890f
	ASCII "P" ; 8912
	DB 0B1h, 23h, 00h ; 8913
	ASCII "T" ; 8916
	DB 0B1h, 08h, 00h ; 8917
	ASCII "P" ; 891a
	DB 0B1h, 08h, 00h ; 891b
	ASCII "H" ; 891e
	DB 0B1h, 0Ah, 00h ; 891f
	ASCII "D" ; 8922
	DB 0B1h, 0Ah, 00h, 18h, 0B0h, 0C1h, 99h, 0D4h ; 8923
	DB 88h, 1Eh, 00h, 80h, 0B2h, 06h, 00h, 90h ; 892b
	DB 0B2h, 0Ah, 00h, 0C8h, 0B3h, 08h, 00h, 0CCh ; 8933
	DB 0B3h, 08h, 00h, 0D0h, 0B3h, 14h, 00h, 0D4h ; 893b
	DB 0B3h, 06h, 00h, 0D8h, 0B3h, 14h, 00h, 0D4h ; 8943
	DB 0B3h, 06h, 00h, 0D8h, 0B3h, 04h, 00h, 0D4h ; 894b
	DB 0B3h, 04h, 00h, 0D8h, 0B3h, 04h, 00h, 0D4h ; 8953
	DB 0B3h, 04h, 00h, 0D8h, 0B3h, 0Fh, 00h, 0D4h ; 895b
	DB 0B3h, 0Ah, 00h, 0D8h, 0B3h, 1Ch, 00h, 0D4h ; 8963
	DB 0B3h, 08h, 00h, 0CCh, 0B3h, 0Ah, 00h, 0C8h ; 896b
	DB 0B3h, 0Fh, 00h, 80h, 0B2h, 0C1h, 99h, 0D4h ; 8973
	DB 88h, 1Eh, 00h, 00h, 0B5h, 06h, 00h, 10h ; 897b
	DB 0B5h, 0Ah, 00h ; 8983
	ASCII "H" ; 8986
	DB 0B6h, 08h, 00h ; 8987
	ASCII "L" ; 898a
	DB 0B6h, 08h, 00h ; 898b
	ASCII "P" ; 898e
	DB 0B6h, 14h, 00h ; 898f
	ASCII "T" ; 8992
	DB 0B6h, 06h, 00h ; 8993
	ASCII "X" ; 8996
	DB 0B6h, 14h, 00h ; 8997
	ASCII "T" ; 899a
	DB 0B6h, 06h, 00h ; 899b
	ASCII "X" ; 899e
	DB 0B6h, 04h, 00h ; 899f
	ASCII "T" ; 89a2
	DB 0B6h, 04h, 00h ; 89a3
	ASCII "X" ; 89a6
	DB 0B6h, 04h, 00h ; 89a7
	ASCII "T" ; 89aa
	DB 0B6h, 04h, 00h ; 89ab
	ASCII "X" ; 89ae
	DB 0B6h, 0Fh, 00h ; 89af
	ASCII "T" ; 89b2
	DB 0B6h, 23h, 00h ; 89b3
	ASCII "X" ; 89b6
	DB 0B6h, 08h, 00h ; 89b7
	ASCII "T" ; 89ba
	DB 0B6h, 08h, 00h ; 89bb
	ASCII "L" ; 89be
	DB 0B6h, 0Ah, 00h ; 89bf
	ASCII "H" ; 89c2
	DB 0B6h, 0Ah, 00h, 00h, 0B5h, 0C1h, 99h, 0D4h ; 89c3
	DB 88h, 7Bh, 0A7h, 0D4h, 89h, 14h, 8Ah ; 89cb
	ASCII "d" ; 89d2
	DB 8Ah, 0Ah, 00h, 0FCh, 0AFh, 0Ah, 00h ; 89d3
	ASCII "H" ; 89da
	DB 0B0h, 02h, 00h ; 89db
	ASCII "p" ; 89de
	DB 0B0h, 04h, 00h ; 89df
	ASCII "t" ; 89e2
	DB 0B0h, 0Ah, 00h ; 89e3
	ASCII "x" ; 89e6
	DB 0B0h, 02h, 00h, 7Ch, 0B0h, 04h, 00h ; 89e7
	ASCII "X" ; 89ee
	DB 0B0h, 0Ah, 00h, 80h, 0B0h, 02h, 00h, 84h ; 89ef
	DB 0B0h, 04h, 00h, 88h, 0B0h, 0Ah, 00h, 8Ch ; 89f7
	DB 0B0h, 02h, 00h, 90h, 0B0h, 04h, 00h, 0FCh ; 89ff
	DB 0AFh, 0Ah, 00h ; 8a07
	ASCII "H" ; 8a0a
	DB 0B0h, 0Ah, 00h, 0FCh, 0AFh, 0C1h, 99h, 0CCh ; 8a0b
	DB 89h, 0Ah, 00h ; 8a13
	ASCII "d" ; 8a16
	DB 0B2h, 06h, 00h, 0D4h, 0B2h, 02h, 00h, 0FCh ; 8a17
	DB 0B2h, 02h, 00h, 00h, 0B3h, 06h, 00h, 04h ; 8a1f
	DB 0B3h, 04h, 00h, 08h, 0B3h, 04h, 00h, 0Ch ; 8a27
	DB 0B3h, 04h, 00h, 10h, 0B3h, 04h, 00h, 14h ; 8a2f
	DB 0B3h, 06h, 00h, 0D4h, 0B2h, 02h, 00h, 0FCh ; 8a37
	DB 0B2h, 02h, 00h, 00h, 0B3h, 06h, 00h, 04h ; 8a3f
	DB 0B3h, 04h, 00h, 08h, 0B3h, 04h, 00h, 0Ch ; 8a47
	DB 0B3h, 04h, 00h, 10h, 0B3h, 04h, 00h, 14h ; 8a4f
	DB 0B3h, 0Ah, 00h, 0D4h, 0B2h, 0Ah, 00h ; 8a57
	ASCII "d" ; 8a5e
	DB 0B2h, 0C1h, 99h, 0CCh, 89h, 0Ah, 00h, 0E4h ; 8a5f
	DB 0B4h, 0Ah, 00h, 00h, 0B5h, 04h, 00h, 88h ; 8a67
	DB 0B5h, 02h, 00h, 8Ch, 0B5h, 04h, 00h, 90h ; 8a6f
	DB 0B5h, 06h, 00h, 94h, 0B5h, 06h, 00h, 08h ; 8a77
	DB 0B5h, 0Ah, 00h, 00h, 0B5h, 04h, 00h, 88h ; 8a7f
	DB 0B5h, 02h, 00h, 8Ch, 0B5h, 04h, 00h, 90h ; 8a87
	DB 0B5h, 06h, 00h, 94h, 0B5h, 06h, 00h, 08h ; 8a8f
	DB 0B5h, 0Ah, 00h, 00h, 0B5h, 0Ah, 00h, 0E4h ; 8a97
	DB 0B4h, 0C1h, 99h, 0CCh, 89h, 7Bh, 0A7h, 0ACh ; 8a9f
	DB 8Ah, 0E4h, 8Ah, 1Ch, 8Bh, 08h, 00h ; 8aa7
	ASCII "H" ; 8aae
	DB 0B0h, 9Dh, 99h ; 8aaf
	ASCII "x" ; 8ab2
	DB 0A1h ; 8ab3
	ASCII "O" ; 8ab4
	DB 9Ah, 11h, 0BBh, 99h, 08h, 0F4h, 99h, 00h ; 8ab5
	DB 0FFh, 01h, 00h ; 8abd
	ASCII "L" ; 8ac0
	DB 0B0h, 0C4h, 99h, 0BAh, 8Ah, 04h, 00h ; 8ac1
	ASCII "P" ; 8ac8
	DB 0B0h, 0BBh, 99h, 08h, 0F4h, 99h, 00h, 01h ; 8ac9
	DB 01h, 00h ; 8ad1
	ASCII "T" ; 8ad3
	DB 0B0h, 0C4h, 99h, 0CDh, 8Ah ; 8ad4
	ASCII "O" ; 8ad9
	DB 9Ah, 12h, 08h, 00h ; 8ada
	ASCII "H" ; 8ade
	DB 0B0h, 0C1h, 99h, 0Ch, 80h, 08h, 00h, 0D4h ; 8adf
	DB 0B2h, 9Dh, 99h ; 8ae7
	ASCII "x" ; 8aea
	DB 0A1h ; 8aeb
	ASCII "O" ; 8aec
	DB 9Ah, 11h, 0BBh, 99h, 08h, 0F4h, 99h, 00h ; 8aed
	DB 0FFh, 01h, 00h, 0D8h, 0B2h, 0C4h, 99h, 0F2h ; 8af5
	DB 8Ah, 04h, 00h, 0DCh, 0B2h, 0BBh, 99h, 08h ; 8afd
	DB 0F4h, 99h, 00h, 01h, 01h, 00h, 0E0h, 0B2h ; 8b05
	DB 0C4h, 99h, 05h, 8Bh ; 8b0d
	ASCII "O" ; 8b11
	DB 9Ah, 12h, 08h, 00h, 0D4h, 0B2h, 0C1h, 99h ; 8b12
	DB 0Ch, 80h, 08h, 00h, 60h, 0B5h, 9Dh, 99h ; 8b1a
	ASCII "x" ; 8b22
	DB 0A1h ; 8b23
	ASCII "O" ; 8b24
	DB 9Ah, 11h, 0BBh, 99h, 08h, 0F4h, 99h, 00h ; 8b25
	DB 0FFh, 01h, 00h ; 8b2d
	ASCII "d" ; 8b30
	DB 0B5h, 0C4h, 99h, 2Ah, 8Bh, 04h, 00h ; 8b31
	ASCII "h" ; 8b38
	DB 0B5h, 0BBh, 99h, 08h, 0F4h, 99h, 00h, 01h ; 8b39
	DB 01h, 00h ; 8b41
	ASCII "l" ; 8b43
	DB 0B5h, 0C4h, 99h, 3Dh, 8Bh ; 8b44
	ASCII "O" ; 8b49
	DB 9Ah, 12h, 08h, 00h, 60h, 0B5h, 0C1h, 99h ; 8b4a
	DB 0Ch, 80h, 7Bh, 0A7h, 5Ch, 8Bh, 88h, 8Bh ; 8b52
	DB 0B4h, 8Bh, 0Ah, 00h, 0C8h, 0B0h, 06h, 00h ; 8b5a
	DB 0CCh, 0B0h, 06h, 00h, 0C8h, 0B0h, 06h, 00h ; 8b62
	DB 0CCh, 0B0h, 06h, 00h, 0C8h, 0B0h, 06h, 00h ; 8b6a
	DB 0CCh, 0B0h, 14h, 00h, 0C8h, 0B0h, 06h, 00h ; 8b72
	DB 0CCh, 0B0h, 06h, 00h, 0C8h, 0B0h, 06h, 00h ; 8b7a
	DB 0CCh, 0B0h, 0C1h, 99h ; 8b82
	ASCII "T" ; 8b86
	DB 8Bh, 0Ah, 00h ; 8b87
	ASCII "L" ; 8b8a
	DB 0B3h, 06h, 00h ; 8b8b
	ASCII "P" ; 8b8e
	DB 0B3h, 06h, 00h ; 8b8f
	ASCII "L" ; 8b92
	DB 0B3h, 06h, 00h ; 8b93
	ASCII "P" ; 8b96
	DB 0B3h, 06h, 00h ; 8b97
	ASCII "L" ; 8b9a
	DB 0B3h, 06h, 00h ; 8b9b
	ASCII "P" ; 8b9e
	DB 0B3h, 14h, 00h ; 8b9f
	ASCII "L" ; 8ba2
	DB 0B3h, 06h, 00h ; 8ba3
	ASCII "P" ; 8ba6
	DB 0B3h, 06h, 00h ; 8ba7
	ASCII "L" ; 8baa
	DB 0B3h, 06h, 00h ; 8bab
	ASCII "P" ; 8bae
	DB 0B3h, 0C1h, 99h ; 8baf
	ASCII "T" ; 8bb2
	DB 8Bh, 0Ah, 00h, 0CCh, 0B5h, 06h, 00h, 0D0h ; 8bb3
	DB 0B5h, 06h, 00h, 0CCh, 0B5h, 06h, 00h, 0D0h ; 8bbb
	DB 0B5h, 06h, 00h, 0CCh, 0B5h, 06h, 00h, 0D0h ; 8bc3
	DB 0B5h, 14h, 00h, 0CCh, 0B5h, 06h, 00h, 0D0h ; 8bcb
	DB 0B5h, 06h, 00h, 0CCh, 0B5h, 06h, 00h, 0D0h ; 8bd3
	DB 0B5h, 0C1h, 99h ; 8bdb
	ASCII "T" ; 8bde
	DB 8Bh, 9Dh, 99h ; 8bdf
	ASCII "x" ; 8be2
	DB 0A1h, 7Bh, 0A7h, 0ECh, 8Bh, 2Ch, 8Ch ; 8be3
	ASCII "l" ; 8bea
	DB 8Ch, 28h, 00h, 0B4h, 0B0h, 28h, 00h, 0B8h ; 8beb
	DB 0B0h, 18h, 00h, 0BCh, 0B0h, 28h, 00h, 0B8h ; 8bf3
	DB 0B0h, 18h, 00h, 0BCh, 0B0h, 28h, 00h, 0B8h ; 8bfb
	DB 0B0h, 18h, 00h, 0BCh, 0B0h, 28h, 00h, 0B8h ; 8c03
	DB 0B0h, 18h, 00h, 0BCh, 0B0h, 28h, 00h, 0B8h ; 8c0b
	DB 0B0h, 04h, 00h, 0BCh, 0B0h, 08h, 00h, 0C0h ; 8c13
	DB 0B0h, 02h, 00h, 0BCh, 0B0h, 14h, 00h, 0C4h ; 8c1b
	DB 0B0h, 2Eh, 00h, 0FCh, 0AFh, 0C1h, 99h, 0Ch ; 8c23
	DB 80h, 28h, 00h ; 8c2b
	ASCII "8" ; 8c2e
	DB 0B3h, 28h, 00h, 3Ch, 0B3h, 18h, 00h, 40h ; 8c2f
	DB 0B3h, 28h, 00h, 3Ch, 0B3h, 18h, 00h, 40h ; 8c37
	DB 0B3h, 28h, 00h, 3Ch, 0B3h, 18h, 00h, 40h ; 8c3f
	DB 0B3h, 28h, 00h, 3Ch, 0B3h, 18h, 00h, 40h ; 8c47
	DB 0B3h, 28h, 00h, 3Ch, 0B3h, 04h, 00h, 40h ; 8c4f
	DB 0B3h, 08h, 00h ; 8c57
	ASCII "D" ; 8c5a
	DB 0B3h, 02h, 00h, 40h, 0B3h, 14h, 00h ; 8c5b
	ASCII "H" ; 8c62
	DB 0B3h, 2Eh, 00h ; 8c63
	ASCII "d" ; 8c66
	DB 0B2h, 0C1h, 99h, 0Ch, 80h, 28h, 00h, 0B8h ; 8c67
	DB 0B5h, 28h, 00h, 0BCh, 0B5h, 18h, 00h, 0C0h ; 8c6f
	DB 0B5h, 28h, 00h, 0BCh, 0B5h, 18h, 00h, 0C0h ; 8c77
	DB 0B5h, 28h, 00h, 0BCh, 0B5h, 18h, 00h, 0C0h ; 8c7f
	DB 0B5h, 28h, 00h, 0BCh, 0B5h, 18h, 00h, 0C0h ; 8c87
	DB 0B5h, 28h, 00h, 0BCh, 0B5h, 04h, 00h, 0C0h ; 8c8f
	DB 0B5h, 08h, 00h, 0C4h, 0B5h, 02h, 00h, 0C0h ; 8c97
	DB 0B5h, 14h, 00h, 0C8h, 0B5h, 06h, 00h, 0B8h ; 8c9f
	DB 0B5h, 28h, 00h, 0E4h, 0B4h, 0C1h, 99h, 0Ch ; 8ca7
	DB 80h, 9Dh, 99h, 0E5h, 0A1h, 82h, 0A9h, 7Bh ; 8caf
	DB 0A7h, 0BEh, 8Ch, 0DAh, 8Ch, 0F6h, 8Ch, 28h ; 8cb7
	DB 00h, 0C4h, 0B0h, 0Ah, 00h ; 8cbf
	ASCII "X" ; 8cc4
	DB 0B1h, 0Ah, 00h, 0C4h, 0B0h, 0Ah, 00h ; 8cc5
	ASCII "X" ; 8ccc
	DB 0B1h, 28h, 00h, 0C4h, 0B0h, 05h, 00h, 0B8h ; 8ccd
	DB 0B0h, 0C1h, 99h ; 8cd5
	ASCII "X" ; 8cd8
	DB 86h, 28h, 00h ; 8cd9
	ASCII "H" ; 8cdc
	DB 0B3h, 0Ah, 00h, 0DCh, 0B3h, 0Ah, 00h ; 8cdd
	ASCII "H" ; 8ce4
	DB 0B3h, 0Ah, 00h, 0DCh, 0B3h, 28h, 00h ; 8ce5
	ASCII "H" ; 8cec
	DB 0B3h, 05h, 00h, 3Ch, 0B3h, 0C1h, 99h ; 8ced
	ASCII "X" ; 8cf4
	DB 86h, 28h, 00h, 0C8h, 0B5h, 0Ah, 00h, 5Ch ; 8cf5
	DB 0B6h, 0Ah, 00h, 0C8h, 0B5h, 0Ah, 00h, 5Ch ; 8cfd
	DB 0B6h, 28h, 00h, 0C8h, 0B5h, 05h, 00h, 0BCh ; 8d05
	DB 0B5h, 0C1h, 99h ; 8d0d
	ASCII "X" ; 8d10
	DB 86h, 9Dh, 99h, 87h, 0A9h, 7Bh, 0A7h, 1Eh ; 8d11
	DB 8Dh, 2Ah, 8Dh ; 8d19
	ASCII "6" ; 8d1c
	DB 8Dh, 08h, 00h, 90h, 0C8h, 08h, 00h, 98h ; 8d1d
	DB 0C8h, 0C1h, 99h, 1Eh, 8Dh, 08h, 00h, 0A0h ; 8d25
	DB 0C8h, 08h, 00h, 0A8h, 0C8h, 0C1h, 99h, 2Ah ; 8d2d
	DB 8Dh, 08h, 00h, 0B0h, 0C8h, 08h, 00h, 0B8h ; 8d35
	DB 0C8h, 0C1h, 99h ; 8d3d
	ASCII "6" ; 8d40
	DB 8Dh, 86h, 0A9h, 9Dh, 99h, 0FDh, 0A1h, 7Bh ; 8d41
	DB 0A7h ; 8d49
	ASCII "P" ; 8d4a
	DB 8Dh ; 8d4b
	ASCII "X" ; 8d4c
	DB 8Dh, 60h, 8Dh, 0Fh, 00h, 18h, 0B0h, 0C1h ; 8d4d
	DB 99h ; 8d55
	ASCII "d" ; 8d56
	DB 8Dh, 0Fh, 00h, 80h, 0B2h, 0C1h, 99h ; 8d57
	ASCII "d" ; 8d5e
	DB 8Dh, 0Fh, 00h, 00h, 0B5h ; 8d5f
	ASCII "A" ; 8d64
	DB 0ADh ; 8d65
	ASCII "j" ; 8d66
	DB 8Dh, 0Eh, 80h, 9Dh, 99h, 19h, 9Bh, 7Bh ; 8d67
	DB 0A7h ; 8d6f
	ASCII "v" ; 8d70
	DB 8Dh, 7Eh, 8Dh, 86h, 8Dh, 04h, 00h, 0D0h ; 8d71
	DB 0B0h, 0C1h, 99h, 8Ah, 8Dh, 04h, 00h ; 8d79
	ASCII "T" ; 8d80
	DB 0B3h, 0C1h, 99h, 8Ah, 8Dh, 04h, 00h, 0D4h ; 8d81
	DB 0B5h, 9Dh, 99h, 87h, 0B7h, 97h, 99h, 01h ; 8d89
	DB 0C1h, 99h ; 8d91
	ASCII "y" ; 8d93
	DB 0ACh, 9Dh, 99h, 19h, 9Bh ; 8d94
	ASCII "T" ; 8d99
	DB 0ADh, 7Bh, 0A7h, 0A3h, 8Dh, 0ABh, 8Dh, 0A3h ; 8d9a
	DB 8Dh, 05h, 00h ; 8da2
	ASCII "X" ; 8da5
	DB 0B0h, 0C1h, 99h, 0Eh, 80h, 05h, 00h, 0E4h ; 8da6
	DB 0B2h, 0C1h, 99h, 0Eh, 80h, 0DAh, 0A9h ; 8dae
	ASCII "O" ; 8db5
	DB 9Ah, 12h, 9Dh, 99h, 0C6h, 9Fh, 09h, 0B6h ; 8db6
	DB 9Ah, 0ADh, 0D9h, 8Dh, 0C4h, 8Dh ; 8dbe
	ASCII "b" ; 8dc4
	DB 0A9h, 04h, 00h ; 8dc5
	ASCII "D" ; 8dc8
	DB 0C1h, 02h, 00h ; 8dc9
	ASCII "H" ; 8dcc
	DB 0C1h, 0Eh, 00h ; 8dcd
	ASCII "L" ; 8dd0
	DB 0C1h, 97h, 99h, 0Dh, 0C1h, 99h, 0EAh, 8Dh ; 8dd1
	ASCII "f" ; 8dd9
	DB 0A9h, 04h, 00h, 0A8h, 0B0h, 02h, 00h, 0ACh ; 8dda
	DB 0B0h, 0Eh, 00h, 0B0h, 0B0h, 97h, 99h, 0Dh ; 8de2
	ASCII "Z" ; 8dea
	DB 0A9h, 0Ah, 00h, 98h, 0B0h, 18h, 00h, 9Ch ; 8deb
	DB 0B0h, 0C1h, 99h, 0Eh, 80h, 01h, 00h ; 8df3
	ASCII "L" ; 8dfa
	DB 0B0h, 8Eh, 99h, 7Ch, 0AFh, 7Ch, 0AFh, 9Dh ; 8dfb
	DB 99h ; 8e03
	ASCII "x" ; 8e04
	DB 0A1h, 7Bh, 0A7h, 0Eh, 8Eh, 0D9h, 90h, 5Bh ; 8e05
	DB 8Fh, 0D6h, 99h, 3Eh, 00h, 2Ch, 00h, 0Ch ; 8e0d
	DB 00h ; 8e15
	ASCII "X" ; 8e16
	DB 0B0h, 0Ch, 00h, 80h, 0B0h, 06h, 00h, 0B8h ; 8e17
	DB 0B1h, 04h, 00h, 0BCh, 0B1h ; 8e1f
	ASCII "O" ; 8e24
	DB 9Ah, 12h, 04h, 00h, 0C0h, 0B1h, 0EDh, 0A9h ; 8e25
	ASCII "1" ; 8e2d
	DB 8Eh, 9Ah, 8Eh, 7Ch, 0AFh, 7Ch, 0AFh, 7Ch ; 8e2e
	DB 0AFh, 0D6h, 99h, 3Fh, 00h, 24h, 00h, 08h ; 8e36
	DB 00h, 80h, 0B0h, 06h, 00h, 0C4h, 0B1h, 04h ; 8e3e
	DB 00h, 0C8h, 0B1h ; 8e46
	ASCII "O" ; 8e49
	DB 9Ah, 12h, 04h, 00h, 0CCh, 0B1h, 0FBh, 0A9h ; 8e4a
	ASCII "V" ; 8e52
	DB 8Eh, 0BFh, 8Eh ; 8e53
	ASCII "O" ; 8e56
	DB 9Ah, 12h, 7Ch, 0AFh, 7Ch, 0AFh, 7Ch, 0AFh ; 8e57
	DB 7Ch, 0AFh, 0D6h, 99h, 40h, 00h, 1Eh, 00h ; 8e5f
	DB 08h, 00h, 80h, 0B0h, 06h, 00h, 0C4h, 0B1h ; 8e67
	DB 04h, 00h, 0C8h, 0B1h ; 8e6f
	ASCII "O" ; 8e73
	DB 9Ah, 12h, 04h, 00h, 0CCh, 0B1h, 0Fh, 0AAh ; 8e74
	DB 0Ch, 80h, 80h, 8Eh, 0D6h, 99h ; 8e7c
	ASCIZ "A" ; 8e82
	DB 18h, 00h, 0Ch, 00h, 80h, 0B0h, 04h, 00h ; 8e84
	DB 0D0h, 0B1h, 04h, 00h, 0D4h, 0B1h, 04h, 00h ; 8e8c
	DB 0D8h, 0B1h, 04h, 00h, 0DCh, 0B1h, 0D6h, 99h ; 8e94
	DB 3Eh, 00h, 24h, 00h, 04h, 00h, 0D0h, 0B1h ; 8e9c
	DB 04h, 00h, 0D4h, 0B1h, 04h, 00h, 0D8h, 0B1h ; 8ea4
	DB 04h, 00h, 0DCh, 0B1h ; 8eac
	ASCII "O" ; 8eb0
	DB 9Ah, 12h, 09h, 0B6h, 9Ah, 0A9h, 24h, 00h ; 8eb1
	DB 0E8h, 0B1h, 0C1h, 99h, 0Ch, 80h, 0D6h, 99h ; 8eb9
	ASCIZ "A" ; 8ec1
	DB 1Eh, 00h, 04h, 00h, 0D0h, 0B1h, 04h, 00h ; 8ec3
	DB 0D4h, 0B1h, 04h, 00h, 0E0h, 0B1h, 04h, 00h ; 8ecb
	DB 0E4h, 0B1h ; 8ed3
	ASCII "O" ; 8ed5
	DB 9Ah, 12h, 09h, 0B6h, 9Ah, 0A9h, 24h, 00h ; 8ed6
	DB 0ECh
loc_0x008EDF:
	DB 0B1h, 0C1h, 99h, 0Ch, 80h, 7Ch, 0AFh ; 8ede
	DB 9Dh, 99h ; 8ee6
	ASCII "x" ; 8ee8
	DB 0A1h, 7Bh, 0A7h, 0F2h, 8Eh ; 8ee9
	ASCII "s" ; 8eee
	DB 91h ; 8eef
	ASCII "f" ; 8ef0
	DB 90h, 0D6h, 99h ; 8ef1
	ASCIZ "A" ; 8ef4
	DB 18h, 00h, 06h, 00h, 80h, 0B0h, 0Ah, 00h ; 8ef6
	DB 0F0h, 0B1h, 06h, 00h, 0F4h, 0B1h ; 8efe
	ASCII "O" ; 8f04
	DB 9Ah, 12h, 1Eh, 00h, 0F8h, 0B1h ; 8f05
	ASCII "5" ; 8f0b
	DB 0AAh, 11h, 8Fh, 0BFh, 8Eh, 7Ch, 0AFh, 7Ch ; 8f0c
	DB 0AFh, 0D6h, 99h, 40h, 00h, 1Eh, 00h, 06h ; 8f14
	DB 00h, 80h, 0B0h, 0Ah, 00h, 0F0h, 0B1h, 06h ; 8f1c
	DB 00h, 0F4h, 0B1h ; 8f24
	ASCII "O" ; 8f27
	DB 9Ah, 12h, 1Eh, 00h, 0F8h, 0B1h ; 8f28
	ASCII "C" ; 8f2e
	DB 0AAh ; 8f2f
	ASCII "4" ; 8f30
	DB 8Fh, 9Ah, 8Eh, 7Ch, 0AFh, 7Ch, 0AFh, 7Ch ; 8f31
	DB 0AFh, 0D6h, 99h, 3Fh, 00h, 24h, 00h, 06h ; 8f39
	DB 00h, 80h, 0B0h, 0Ah, 00h, 0F0h, 0B1h, 06h ; 8f41
	DB 00h, 0FCh, 0B1h ; 8f49
	ASCII "O" ; 8f4c
	DB 9Ah, 12h, 1Eh, 00h, 00h, 0B2h, 0DAh, 0A9h ; 8f4d
	ASCII "T" ; 8f55
	DB 0AAh, 0Eh, 80h, 0B5h, 8Dh, 0D6h, 99h, 2Eh ; 8f56
	DB 00h ; 8f5e
	ASCIZ "0" ; 8f5f
	DB 0Ah, 00h ; 8f61
	ASCII "t" ; 8f63
	DB 0B5h, 04h, 00h, 0D8h, 0B6h, 04h, 00h, 0DCh ; 8f64
	DB 0B6h, 04h, 00h, 0E0h, 0B6h, 06h, 00h, 0E4h ; 8f6c
	DB 0B6h ; 8f74
	ASCII "O" ; 8f75
	DB 9Ah, 12h, 06h, 00h, 0E8h, 0B6h, 0EDh, 0A9h ; 8f76
	DB 82h, 8Fh, 0FAh, 8Fh, 7Ch, 0AFh, 7Ch, 0AFh ; 8f7e
	DB 7Ch, 0AFh, 0D6h, 99h, 3Dh, 00h, 24h, 00h ; 8f86
	DB 04h, 00h, 0ECh, 0B6h, 04h, 00h, 0F0h, 0B6h ; 8f8e
	DB 04h, 00h, 0F4h, 0B6h, 06h, 00h, 0F8h, 0B6h ; 8f96
	ASCII "O" ; 8f9e
	DB 9Ah, 12h, 06h, 00h, 0FCh, 0B6h, 0FBh, 0A9h ; 8f9f
	DB 0ABh, 8Fh, 0E8h, 8Fh, 7Ch, 0AFh, 7Ch, 0AFh ; 8fa7
	DB 7Ch, 0AFh, 7Ch, 0AFh, 0D6h, 99h, 3Fh, 00h ; 8faf
	DB 1Eh, 00h, 04h, 00h, 0ECh, 0B6h, 04h, 00h ; 8fb7
	DB 0F0h, 0B6h, 04h, 00h, 0F4h, 0B6h, 06h, 00h ; 8fbf
	DB 0F8h, 0B6h ; 8fc7
	ASCII "O" ; 8fc9
	DB 9Ah, 12h, 06h, 00h, 0FCh, 0B6h, 0Fh, 0AAh ; 8fca
	DB 0Ch, 80h, 0D6h, 8Fh, 0D6h, 99h, 3Fh, 00h ; 8fd2
	DB 1Eh, 00h, 04h, 00h, 24h, 0B7h, 04h, 00h ; 8fda
	DB 28h, 0B7h, 04h, 00h, 2Ch, 0B7h, 0D6h, 99h ; 8fe2
	DB 3Dh, 00h, 24h, 00h, 04h, 00h, 24h, 0B7h ; 8fea
	DB 04h, 00h, 28h, 0B7h, 04h, 00h, 2Ch, 0B7h ; 8ff2
	DB 0D6h, 99h, 3Bh, 00h, 2Ah, 00h, 04h, 00h ; 8ffa
	DB 24h, 0B7h, 04h, 00h, 28h, 0B7h, 04h, 00h ; 9002
	DB 2Ch, 0B7h, 09h, 0B6h, 0C1h, 99h, 88h, 99h ; 900a
	DB 0D6h, 99h ; 9012
	ASCIZ "A" ; 9014
	DB 18h, 00h, 0Ah, 00h, 0F4h, 0B4h, 0D6h, 99h ; 9016
	ASCIZ "A" ; 901e
	DB 1Bh, 00h, 06h, 00h ; 9020
	ASCII "0" ; 9024
	DB 0B7h, 06h, 00h ; 9025
	ASCII "4" ; 9028
	DB 0B7h, 06h, 00h ; 9029
	ASCII "8" ; 902c
	DB 0B7h, 0D6h, 99h, 3Fh, 00h, 21h, 00h, 06h ; 902d
	DB 00h ; 9035
	ASCII "0" ; 9036
	DB 0B7h, 06h, 00h ; 9037
	ASCII "4" ; 903a
	DB 0B7h, 06h, 00h ; 903b
	ASCII "8" ; 903e
	DB 0B7h, 0D6h, 99h, 3Dh, 00h, 27h, 00h, 06h ; 903f
	DB 00h ; 9047
	ASCII "0" ; 9048
	DB 0B7h, 06h, 00h ; 9049
	ASCII "4" ; 904c
	DB 0B7h, 06h, 00h ; 904d
	ASCII "8" ; 9050
	DB 0B7h, 0D6h, 99h, 3Bh, 00h, 2Dh, 00h, 06h ; 9051
	DB 00h ; 9059
	ASCII "0" ; 905a
	DB 0B7h, 06h, 00h ; 905b
	ASCII "4" ; 905e
	DB 0B7h, 09h, 0B6h, 0C1h, 99h, 88h, 99h, 0D6h ; 905f
	DB 99h ; 9067
	ASCIZ "A" ; 9068
	DB 18h, 00h, 04h, 00h, 0F4h, 0B4h, 04h, 00h ; 906a
	DB 00h, 0B7h, 04h, 00h, 04h, 0B7h, 06h, 00h ; 9072
	DB 08h, 0B7h ; 907a
	ASCII "O" ; 907c
	DB 9Ah, 12h, 06h, 00h, 0Ch, 0B7h ; 907d
	ASCII "5" ; 9083
	DB 0AAh, 89h, 90h, 2Eh, 90h, 7Ch, 0AFh, 7Ch ; 9084
	DB 0AFh, 0D6h, 99h, 3Fh, 00h, 1Eh, 00h, 04h ; 908c
	DB 00h, 0F4h, 0B4h, 04h, 00h, 00h, 0B7h, 04h ; 9094
	DB 00h, 04h, 0B7h, 06h, 00h, 08h, 0B7h ; 909c
	ASCII "O" ; 90a3
	DB 9Ah, 12h, 06h, 00h, 0Ch, 0B7h ; 90a4
	ASCII "C" ; 90aa
	DB 0AAh, 0B0h, 90h, 40h, 90h, 7Ch, 0AFh, 7Ch ; 90ab
	DB 0AFh, 7Ch, 0AFh, 0D6h, 99h, 3Dh, 00h, 24h ; 90b3
	DB 00h, 04h, 00h, 0F4h, 0B4h, 04h, 00h, 10h ; 90bb
	DB 0B7h, 04h, 00h, 14h, 0B7h, 04h, 00h, 18h ; 90c3
	DB 0B7h ; 90cb
	ASCII "O" ; 90cc
	DB 9Ah, 12h, 06h, 00h, 1Ch, 0B7h ; 90cd
	ASCII "T" ; 90d3
	DB 0AAh, 88h, 99h, 0B3h, 8Dh, 04h, 00h ; 90d4
	ASCII "H" ; 90db
	DB 0B4h, 04h, 00h ; 90dc
	ASCII "L" ; 90df
	DB 0B4h, 04h, 00h ; 90e0
	ASCII "P" ; 90e3
	DB 0B4h, 0D6h, 99h, 40h, 00h, 23h, 00h, 04h ; 90e4
	DB 00h ; 90ec
	ASCII "H" ; 90ed
	DB 0B4h, 04h, 00h ; 90ee
	ASCII "L" ; 90f1
	DB 0B4h, 04h, 00h ; 90f2
	ASCII "P" ; 90f5
	DB 0B4h, 0EDh, 0A9h, 0FDh, 90h ; 90f6
	ASCII "R" ; 90fb
	DB 91h, 7Ch, 0AFh, 7Ch, 0AFh, 7Ch, 0AFh, 0D6h ; 90fc
	DB 99h, 40h, 00h, 1Eh, 00h, 04h, 00h ; 9104
	ASCII "T" ; 910b
	DB 0B4h, 04h, 00h ; 910c
	ASCII "L" ; 910f
	DB 0B4h, 0Ah, 00h ; 9110
	ASCII "X" ; 9113
	DB 0B4h, 0FBh, 0A9h, 1Bh, 91h ; 9114
	ASCII "R" ; 9119
	DB 91h, 7Ch, 0AFh, 7Ch, 0AFh, 7Ch, 0AFh, 7Ch ; 911a
	DB 0AFh, 0D6h, 99h, 40h, 00h, 1Ah, 00h, 14h ; 9122
	DB 00h, 5Ch, 0B4h, 0Fh, 0AAh ; 912a
	ASCII "3" ; 912f
	DB 91h ; 9130
	ASCII "R" ; 9131
	DB 91h, 0D6h, 99h, 40h, 00h, 16h, 00h, 04h ; 9132
	DB 00h, 14h, 0B4h, 04h, 00h, 18h, 0B4h, 0D6h ; 913a
	DB 99h, 40h, 00h, 10h, 00h ; 9142
	ASCII "O" ; 9147
	DB 9Ah, 12h, 06h, 00h, 0Ch, 0B4h, 0C1h, 99h ; 9148
	DB 0Ch, 80h ; 9150
	ASCII "O" ; 9152
	DB 9Ah, 11h, 9Dh, 99h, 02h, 0A1h, 01h, 00h ; 9153
	DB 88h, 0B4h, 8Eh, 99h, 9Dh, 99h, 0FDh, 0A1h ; 915b
	DB 04h, 00h, 8Ch, 0B4h, 09h, 0B6h, 9Ah, 0A9h ; 9163
	DB 24h, 00h, 90h, 0B4h, 0C1h, 99h, 0Ch, 80h ; 916b
	DB 0D6h, 99h, 40h, 00h, 10h, 00h, 06h, 00h ; 9173
	DB 24h, 0B4h, 04h, 00h, 60h, 0B4h, 04h, 00h ; 917b
	ASCII "d" ; 9183
	DB 0B4h, 04h, 00h ; 9184
	ASCII "h" ; 9187
	DB 0B4h, 0D6h, 99h, 40h, 00h, 1Bh, 00h, 04h ; 9188
	DB 00h ; 9190
	ASCII "l" ; 9191
	DB 0B4h, 04h, 00h ; 9192
	ASCII "p" ; 9195
	DB 0B4h, 04h, 00h ; 9196
	ASCII "t" ; 9199
	DB 0B4h ; 919a
	ASCII "5" ; 919b
	DB 0AAh, 0A1h, 91h, 0DBh, 91h, 7Ch, 0AFh, 7Ch ; 919c
	DB 0AFh, 0D6h, 99h, 40h, 00h, 20h, 00h, 04h ; 91a4
	DB 00h ; 91ac
	ASCII "x" ; 91ad
	DB 0B4h, 04h, 00h ; 91ae
	ASCII "p" ; 91b1
	DB 0B4h, 04h, 00h, 7Ch, 0B4h ; 91b2
	ASCII "C" ; 91b7
	DB 0AAh, 0BDh, 91h, 0DBh, 91h, 7Ch, 0AFh, 7Ch ; 91b8
	DB 0AFh, 7Ch, 0AFh, 0D6h, 99h, 40h, 00h, 25h ; 91c0
	DB 00h, 04h, 00h ; 91c8
	ASCII "l" ; 91cb
	DB 0B4h, 04h, 00h ; 91cc
	ASCII "p" ; 91cf
	DB 0B4h, 04h, 00h ; 91d0
	ASCII "t" ; 91d3
	DB 0B4h ; 91d4
	ASCII "T" ; 91d5
	DB 0AAh, 0FEh, 91h, 0DBh, 91h ; 91d6
	ASCII "O" ; 91db
	DB 9Ah, 11h, 0DAh, 0A9h, 9Dh, 99h, 02h, 0A1h ; 91dc
	DB 01h, 00h, 94h, 0B4h, 8Eh, 99h, 9Dh, 99h ; 91e4
	DB 0FDh, 0A1h, 04h, 00h, 98h, 0B4h, 09h, 0B6h ; 91ec
	DB 9Ah, 0A9h, 24h, 00h, 9Ch, 0B4h, 0C1h, 99h ; 91f4
	DB 0Ch, 80h, 0D6h, 99h, 40h, 00h, 2Ah, 00h ; 91fc
	DB 04h, 00h ; 9204
	ASCII "p" ; 9206
	DB 0B4h, 0D6h, 99h, 40h, 00h, 29h, 00h, 04h ; 9207
	DB 00h, 80h, 0B4h, 02h, 00h, 84h, 0B4h, 0D6h ; 920f
	DB 99h, 3Fh, 00h, 2Bh, 00h, 04h, 00h, 0Ch ; 9217
	DB 0B4h, 0D6h, 99h, 40h, 00h, 2Ch, 00h, 06h ; 921f
	DB 00h ; 9227
	ASCII "d" ; 9228
	DB 0B2h, 0C1h, 99h, 0Eh, 80h, 9Dh, 99h, 0FDh ; 9229
	DB 0A1h, 01h, 00h, 28h, 0B0h, 9Dh, 99h, 0FDh ; 9231
	DB 0A1h, 97h, 99h ; 9239
	ASCII "2" ; 923c
	DB 0B0h, 0ADh ; 923d
	ASCII "E" ; 923f
	DB 92h ; 9240
	ASCII "X" ; 9241
	DB 92h ; 9242
	ASCII "b" ; 9243
	DB 92h, 9Dh, 99h ; 9244
	ASCII "j" ; 9247
	DB 0A2h ; 9248
	ASCII "O" ; 9249
	DB 9Ah, 0Dh, 0Ch, 00h, 14h, 0B2h, 0Ch, 00h ; 924a
	DB 18h, 0B2h, 0C1h, 99h ; 9252
	ASCII "I" ; 9256
	DB 92h, 9Dh, 99h, 0B6h, 0A2h, 1Ah, 0ADh, 2Eh ; 9257
	DB 80h, 82h, 80h, 9Dh, 99h, 0FAh, 0A2h, 1Ah ; 925f
	DB 0ADh, 0D6h, 80h, 2Ah, 81h, 9Dh, 99h, 0FDh ; 9267
	DB 0A1h, 0BBh, 99h, 03h ; 926f
	ASCII "O" ; 9273
	DB 9Ah, 0Dh ; 9274
	ASCII "r" ; 9276
	DB 0A9h, 04h, 00h, 24h, 0B2h, 04h, 00h, 28h ; 9277
	DB 0B2h, 0C4h, 99h ; 927f
	ASCII "s" ; 9282
	DB 92h, 9Dh, 99h, 0FAh, 0A2h ; 9283
	ASCII "O" ; 9288
	DB 9Ah, 0Dh, 03h, 00h, 24h, 0B2h, 03h, 00h ; 9289
	DB 2Ch, 0B2h, 0C1h, 99h, 88h, 92h, 0B0h, 0ADh ; 9291
	DB 9Fh, 92h, 0C8h, 92h, 0F2h, 92h, 9Dh, 99h ; 9299
	DB 0FDh, 0A1h, 0Ah, 00h ; 92a1
	ASCII "H" ; 92a5
	DB 0B0h, 9Dh, 99h ; 92a6
	ASCII "M" ; 92a9
	DB 0A3h ; 92aa
	ASCII "O" ; 92ab
	DB 9Ah, 11h, 01h, 00h, 1Ch, 0B2h, 8Eh, 99h ; 92ac
	DB 8Eh, 0A9h, 9Dh, 99h ; 92b4
	ASCII "U" ; 92b8
	DB 0A2h, 0Ah, 00h ; 92b9
	ASCII "H" ; 92bc
	DB 0B0h, 92h, 0A9h, 9Dh, 99h, 2Fh, 0A4h, 0C1h ; 92bd
	DB 99h, 0ABh, 92h, 9Dh, 99h, 0FDh, 0A1h, 07h ; 92c5
	DB 00h ; 92cd
	ASCII "H" ; 92ce
	DB 0B0h, 9Dh, 99h, 94h, 0A3h ; 92cf
	ASCII "O" ; 92d4
	DB 9Ah, 11h, 0C1h, 99h, 0F8h, 8Dh, 8Eh, 0A9h ; 92d5
	DB 9Dh, 99h ; 92dd
	ASCII "U" ; 92df
	DB 0A2h, 07h, 00h ; 92e0
	ASCII "H" ; 92e3
	DB 0B0h, 92h, 0A9h, 9Dh, 99h, 60h, 0A4h ; 92e4
	ASCII "O" ; 92eb
	DB 9Ah, 11h, 0C1h, 99h, 0F8h, 8Dh, 9Dh, 99h ; 92ec
	DB 0FDh, 0A1h, 02h, 00h ; 92f4
	ASCII "0" ; 92f8
	DB 0B2h, 9Dh, 99h, 0E2h, 0A3h ; 92f9
	ASCII "O" ; 92fe
	DB 9Ah, 11h, 01h, 00h ; 92ff
	ASCII "4" ; 9303
	DB 0B2h, 8Eh, 99h, 8Eh, 0A9h, 9Dh, 99h ; 9304
	ASCII "U" ; 930b
	DB 0A2h, 05h, 00h ; 930c
	ASCII "0" ; 930f
	DB 0B2h, 92h, 0A9h, 9Dh, 99h, 8Eh, 0A4h, 0C1h ; 9310
	DB 99h, 0FEh, 92h, 01h, 00h ; 9318
	ASCII "8" ; 931d
	DB 0B2h, 8Eh, 99h, 01h, 00h, 3Ch, 0B2h, 8Eh ; 931e
	DB 99h, 01h, 00h ; 9326
	ASCII "0" ; 9329
	DB 0B2h, 8Eh, 99h, 01h, 00h, 20h, 0B2h, 8Eh ; 932a
	DB 99h, 01h, 00h ; 9332
	ASCII "P" ; 9335
	DB 0B0h, 8Eh, 99h, 0C5h, 0ADh, 9Dh, 99h, 1Bh ; 9336
	DB 0A7h, 01h, 00h ; 933e
	ASCII "R" ; 9341
	DB 1Bh, 8Eh, 99h, 9Dh, 99h, 19h, 9Bh ; 9342
	ASCII "N" ; 9349
	DB 0AEh, 0D6h, 99h, 00h, 00h, 27h, 00h, 04h ; 934a
	DB 00h, 40h, 0B2h, 04h, 00h ; 9352
	ASCII "H" ; 9357
	DB 0B2h, 04h, 00h, 40h, 0B2h, 04h, 00h ; 9358
	ASCII "H" ; 935f
	DB 0B2h, 0DAh, 0A9h ; 9360
	ASCII "v" ; 9363
	DB 0A9h, 0B9h, 0A9h, 0C9h, 85h ; 9364
	ASCII "A" ; 9369
	DB 85h ; 936a
	ASCII "q" ; 936b
	DB 85h, 0C9h, 85h, 0C9h, 85h, 0B0h, 0ADh ; 936c
	ASCII "y" ; 9373
	DB 93h, 8Fh, 93h, 0A5h, 93h, 1Ah, 0ADh, 7Fh ; 9374
	DB 93h, 87h, 93h, 9Dh, 99h ; 937c
	ASCII "K" ; 9381
	DB 9Fh, 0C1h, 99h, 0DCh, 85h, 9Dh, 99h, 7Eh ; 9382
	DB 9Fh, 0C1h, 99h, 1Ch, 86h, 1Ah, 0ADh, 95h ; 938a
	DB 93h, 9Dh, 93h, 9Dh, 99h, 0E0h, 9Eh, 0C1h ; 9392
	DB 99h, 2Eh, 80h, 9Dh, 99h, 0Bh, 9Fh, 0C1h ; 939a
	DB 99h, 82h, 80h, 1Ah, 0ADh, 0ABh, 93h, 0B3h ; 93a2
	DB 93h, 9Dh, 99h, 5Bh, 9Eh, 0C1h, 99h, 0D6h ; 93aa
	DB 80h, 9Dh, 99h, 8Eh, 9Eh, 0C1h, 99h, 2Ah ; 93b2
	DB 81h, 0B0h, 0ADh ; 93ba
	ASCII "U" ; 93bd
	DB 94h, 0C3h, 93h, 0F9h, 93h, 9Dh, 99h, 0FDh ; 93be
	DB 0A1h, 0Ah, 00h, 00h, 0B5h, 0Ah, 00h, 08h ; 93c6
	DB 0B5h ; 93ce
	ASCII "O" ; 93cf
	DB 9Ah, 11h, 9Dh, 99h ; 93d0
	ASCII "x" ; 93d4
	DB 0A1h, 01h, 00h ; 93d5
	ASCII "P" ; 93d8
	DB 0B7h, 0BBh, 99h, 04h, 0F4h, 99h, 00h, 0FEh ; 93d9
	DB 97h, 99h, 01h, 0C4h, 99h, 0DDh, 93h, 01h ; 93e1
	DB 00h ; 93e9
	ASCII "T" ; 93ea
	DB 0B7h, 97h, 99h, 02h, 01h, 00h ; 93eb
	ASCII "X" ; 93f1
	DB 0B7h, 9Dh, 99h, 0D1h, 0A0h, 8Eh, 99h, 9Dh ; 93f2
	DB 99h, 0FDh, 0A1h, 0Ah, 00h, 00h, 0B5h, 0Ah ; 93fa
	DB 00h, 08h, 0B5h ; 9402
	ASCII "O" ; 9405
	DB 9Ah, 11h, 9Dh, 99h ; 9406
	ASCII "x" ; 940a
	DB 0A1h, 01h, 00h ; 940b
	ASCII "P" ; 940e
	DB 0B7h, 0BBh, 99h, 08h, 0F4h, 99h, 00h, 0FFh ; 940f
	DB 97h, 99h, 01h, 0C4h, 99h, 13h, 94h, 01h ; 9417
	DB 00h ; 941f
	ASCII "T" ; 9420
	DB 0B7h, 97h, 99h, 02h, 01h, 00h ; 9421
	ASCII "X" ; 9427
	DB 0B7h, 0BBh, 99h, 10h, 0F4h, 99h, 00h, 01h ; 9428
	DB 97h, 99h, 01h, 0C4h, 99h, 2Ch, 94h, 9Dh ; 9430
	DB 99h, 0D1h, 0A0h, 02h, 00h, 5Ch, 0B7h, 03h ; 9438
	DB 00h, 60h, 0B7h, 04h, 00h ; 9440
	ASCII "X" ; 9445
	DB 0B7h, 02h, 00h, 5Ch, 0B7h, 03h, 00h, 60h ; 9446
	DB 0B7h, 04h, 00h ; 944e
	ASCII "X" ; 9451
	DB 0B7h, 8Eh, 99h, 9Dh, 99h ; 9452
	ASCII "x" ; 9457
	DB 0A1h, 0D6h, 99h, 04h, 00h, 10h, 00h, 0Ah ; 9458
	DB 00h, 08h, 0B5h, 10h, 00h, 3Ch, 0B7h, 06h ; 9460
	DB 00h, 40h, 0B7h, 24h, 00h ; 9468
	ASCII "D" ; 946d
	DB 0B7h, 04h, 00h ; 946e
	ASCII "H" ; 9471
	DB 0B7h, 04h, 00h ; 9472
	ASCII "D" ; 9475
	DB 0B7h, 04h, 00h ; 9476
	ASCII "H" ; 9479
	DB 0B7h, 04h, 00h ; 947a
	ASCII "D" ; 947d
	DB 0B7h, 04h, 00h ; 947e
	ASCII "H" ; 9481
	DB 0B7h, 04h, 00h ; 9482
	ASCII "D" ; 9485
	DB 0B7h, 04h, 00h ; 9486
	ASCII "H" ; 9489
	DB 0B7h, 14h, 00h ; 948a
	ASCII "D" ; 948d
	DB 0B7h ; 948e
	ASCII "O" ; 948f
	DB 9Ah, 11h, 0DAh, 0A9h, 9Dh, 99h, 0D1h, 0A0h ; 9490
	DB 01h, 00h ; 9498
	ASCII "L" ; 949a
	DB 0B7h, 8Eh, 99h, 9Dh, 99h, 0FDh, 0A1h, 0B0h ; 949b
	DB 0ADh, 0AAh, 94h, 0E8h, 94h, 20h, 95h, 06h ; 94a3
	DB 00h, 0E4h, 0B2h, 28h, 00h, 0E8h, 0B2h ; 94ab
	ASCII "z" ; 94b2
	DB 0A9h, 3Eh, 00h, 0A4h, 0B4h, 10h, 00h, 0E8h ; 94b3
	DB 0B2h, 14h, 00h, 0A0h, 0B4h, 9Dh, 99h, 3Eh ; 94bb
	DB 0A1h, 0F4h, 99h, 00h, 0FEh, 0Ah, 00h ; 94c3
	ASCII "H" ; 94ca
	DB 0B4h, 0F4h, 99h, 00h, 0FEh, 0Ah, 00h, 5Ch ; 94cb
	DB 0B4h, 0F4h, 99h, 00h, 0FEh, 0Ah, 00h ; 94d3
	ASCII "T" ; 94da
	DB 0B4h, 0F4h, 99h, 00h, 0FEh, 0Ah, 00h, 5Ch ; 94db
	DB 0B4h, 0C1h, 99h, 0C4h, 94h, 06h, 00h ; 94e3
	ASCII "d" ; 94ea
	DB 0B2h, 1Eh, 00h, 0A8h, 0B4h, 14h, 00h ; 94eb
	ASCII "d" ; 94f2
	DB 0B2h, 0Ah, 00h, 0A0h, 0B4h, 9Dh, 99h, 3Eh ; 94f3
	DB 0A1h, 0F4h, 99h, 00h, 0FFh, 05h, 00h ; 94fb
	ASCII "H" ; 9502
	DB 0B4h, 0F4h, 99h, 00h, 0FFh, 05h, 00h, 5Ch ; 9503
	DB 0B4h, 0F4h, 99h, 00h, 0FFh, 05h, 00h ; 950b
	ASCII "T" ; 9512
	DB 0B4h, 0F4h, 99h, 00h, 0FFh, 05h, 00h, 5Ch ; 9513
	DB 0B4h, 0C1h, 99h, 0FCh, 94h, 06h, 00h ; 951b
	ASCII "d" ; 9522
	DB 0B2h, 14h, 00h, 0ACh, 0B4h, 0Eh, 00h, 0B0h ; 9523
	DB 0B4h, 7Eh, 0A9h, 1Ah, 00h, 0B0h, 0B4h, 06h ; 952b
	DB 00h, 0A0h, 0B4h, 9Dh, 99h, 3Eh, 0A1h, 0F4h ; 9533
	DB 99h, 00h, 0FFh, 02h, 00h ; 953b
	ASCII "H" ; 9540
	DB 0B4h, 0F4h, 99h, 00h, 0FFh, 02h, 00h, 5Ch ; 9541
	DB 0B4h, 0F4h, 99h, 00h, 0FFh, 02h, 00h ; 9549
	ASCII "T" ; 9550
	DB 0B4h, 0F4h, 99h, 00h, 0FFh, 02h, 00h, 5Ch ; 9551
	DB 0B4h, 0C1h, 99h, 3Ah, 95h, 0B0h, 0ADh ; 9559
	ASCII "l" ; 9560
	DB 95h ; 9561
	ASCII "i" ; 9562
	DB 95h ; 9563
	ASCII "f" ; 9564
	DB 95h, 97h, 99h, 12h, 97h, 99h, 12h, 97h ; 9565
	DB 99h, 12h, 9Dh, 99h ; 956d
	ASCII "x" ; 9571
	DB 0A1h, 0D6h, 99h, 12h, 00h, 0Eh, 00h, 14h ; 9572
	DB 00h, 0B4h, 0B4h, 08h, 00h, 0B8h, 0B4h, 28h ; 957a
	DB 00h, 0BCh, 0B4h, 0Ah, 00h, 0C0h, 0B4h, 08h ; 9582
	DB 00h, 0C4h, 0B4h, 0Ah, 00h, 0C8h, 0B4h, 0BBh ; 958a
	DB 99h, 08h, 0F4h, 99h, 00h, 01h, 02h, 00h ; 9592
	DB 0C8h, 0B4h, 0C4h, 99h, 94h, 95h, 0BBh, 99h ; 959a
	DB 08h, 0F4h, 99h, 00h, 01h, 01h, 00h, 0C8h ; 95a2
	DB 0B4h, 0C4h, 99h, 0A3h, 95h, 0D6h, 99h, 12h ; 95aa
	DB 00h, 1Eh, 00h, 0Ah, 00h, 0CCh, 0B4h, 06h ; 95b2
	DB 00h, 0C8h, 0B4h, 0D6h, 99h, 12h, 00h, 21h ; 95ba
	DB 00h, 06h, 00h, 0C8h, 0B4h, 0D6h, 99h, 0Dh ; 95c2
	DB 00h, 23h, 00h, 0Ah, 00h, 0D0h, 0B4h, 0Ah ; 95ca
	DB 00h, 0D4h, 0B4h, 0D6h, 99h, 0Bh, 00h, 24h ; 95d2
	DB 00h, 0Ah, 00h, 0D0h, 0B4h, 0Ah, 00h, 0D4h ; 95da
	DB 0B4h, 0D6h, 99h, 09h, 00h, 25h, 00h, 0Ah ; 95e2
	DB 00h, 0D0h, 0B4h, 0Ah, 00h, 0D4h, 0B4h, 0D6h ; 95ea
	DB 99h, 06h, 00h, 2Ch, 00h, 04h, 00h, 0D8h ; 95f2
	DB 0B2h, 0Ah, 00h, 0D4h, 0B2h, 06h, 00h ; 95fa
	ASCII "d" ; 9601
	DB 0B2h ; 9602
	ASCII "O" ; 9603
	DB 9Ah, 12h, 0C1h, 99h, 0Ch, 80h, 7Bh, 0A7h ; 9604
	DB 12h, 96h ; 960c
	ASCII "B" ; 960e
	DB 97h ; 960f
	ASCII "U" ; 9610
	DB 98h, 9Dh, 99h ; 9611
	ASCII "x" ; 9614
	DB 0A1h, 0D6h, 99h, 20h, 00h, 2Ch, 00h, 0Ah ; 9615
	DB 00h ; 961d
	ASCII "H" ; 961e
	DB 0B0h, 08h, 00h, 84h, 0B1h, 04h, 00h, 88h ; 961f
	DB 0B1h, 04h, 00h, 8Ch, 0B1h, 02h, 00h, 90h ; 9627
	DB 0B1h, 0C1h, 99h, 5Eh, 96h, 2Bh, 0ADh ; 962f
	ASCII "L" ; 9636
	DB 96h, 3Ch, 96h ; 9637
	ASCII "D" ; 963a
	DB 96h, 9Dh, 99h, 09h, 0A2h, 0C1h, 99h ; 963b
	ASCII "9" ; 9642
	DB 80h, 9Dh, 99h, 2Fh, 0A2h, 0C1h, 99h, 8Dh ; 9643
	DB 80h, 0D6h, 99h, 20h, 00h, 2Ch, 00h, 9Dh ; 964b
	DB 99h, 03h, 0A2h, 04h, 00h, 8Ch, 0B1h, 02h ; 9653
	DB 00h, 90h, 0B1h, 9Dh, 99h, 0Fh, 0ACh, 0D6h ; 965b
	DB 99h, 20h, 00h, 2Ch, 00h, 8Dh, 0AEh ; 9663
	ASCIZ "2" ; 966a
	DB 90h, 0B1h, 04h, 00h, 0B4h, 0B1h, 04h, 00h ; 966c
	DB 90h, 0B1h, 04h, 00h, 0B4h, 0B1h, 04h, 00h ; 9674
	DB 90h, 0B1h, 04h, 00h, 0B4h, 0B1h, 0C1h, 99h ; 967c
	ASCII "h" ; 9684
	DB 96h, 0D6h, 99h, 20h, 00h, 2Ch, 00h, 99h ; 9685
	DB 0AEh, 9Dh, 99h ; 968d
	ASCII "x" ; 9690
	DB 0A1h, 08h, 00h, 94h, 0B1h, 9Dh, 99h, 0E7h ; 9691
	DB 0ABh, 06h, 00h, 90h, 0B1h, 04h, 00h, 9Ch ; 9699
	DB 0B1h, 9Dh, 99h, 0F9h, 0ABh, 04h, 00h, 9Ch ; 96a1
	DB 0B1h, 06h, 00h, 90h, 0B1h, 0B8h, 0AEh, 8Eh ; 96a9
	DB 96h, 5Eh, 96h, 5Eh, 96h, 0B8h, 96h, 0E2h ; 96b1
	DB 0AEh, 0D6h, 99h, 20h, 00h, 2Ch, 00h, 0A5h ; 96b9
	DB 0AEh, 9Dh, 99h ; 96c1
	ASCII "x" ; 96c4
	DB 0A1h, 04h, 00h, 94h, 0B1h, 05h, 00h, 98h ; 96c5
	DB 0B1h, 04h, 00h, 94h, 0B1h, 9Dh, 99h, 0E7h ; 96cd
	DB 0ABh, 04h, 00h, 90h, 0B1h, 04h, 00h, 9Ch ; 96d5
	DB 0B1h, 02h, 00h, 0A0h, 0B1h, 9Dh, 99h, 0F9h ; 96dd
	DB 0ABh, 03h, 00h, 0A0h, 0B1h, 04h, 00h, 9Ch ; 96e5
	DB 0B1h, 04h, 00h, 90h, 0B1h, 0B8h, 0AEh, 0C2h ; 96ed
	DB 96h, 86h, 96h, 0FCh, 96h, 0B8h, 96h, 0D6h ; 96f5
	DB 99h, 20h, 00h, 2Ch, 00h, 9Dh, 99h ; 96fd
	ASCII "x" ; 9704
	DB 0A1h, 0B1h, 0AEh, 04h, 00h, 94h, 0B1h, 05h ; 9705
	DB 00h, 98h, 0B1h, 04h, 00h, 94h, 0B1h, 04h ; 970d
	DB 00h, 90h, 0B1h, 04h, 00h, 9Ch, 0B1h, 03h ; 9715
	DB 00h, 0A0h, 0B1h ; 971d
	ASCII "O" ; 9720
	DB 9Ah, 11h, 02h, 00h, 0A4h, 0B1h, 04h, 00h ; 9721
	DB 0A8h, 0B1h, 0Ah, 00h, 0ACh, 0B1h, 04h, 00h ; 9729
	DB 0B0h, 0B1h, 09h, 0B6h ; 9731
	ASCII "O" ; 9735
	DB 9Ah, 12h, 14h, 00h, 9Ch, 0B0h, 81h, 0AEh ; 9736
	DB 0C1h, 99h, 0Eh, 80h, 9Dh, 99h ; 973e
	ASCII "x" ; 9744
	DB 0A1h, 0D6h, 99h, 1Fh, 00h, 2Bh, 00h, 0Ah ; 9745
	DB 00h, 0Ch, 0B4h, 04h, 00h, 10h, 0B4h, 02h ; 974d
	DB 00h, 14h, 0B4h, 04h, 00h, 18h, 0B4h, 0D6h ; 9755
	DB 99h, 1Fh, 00h, 23h, 00h, 0F4h, 99h, 00h ; 975d
	DB 01h, 06h, 00h, 20h, 0B4h, 9Dh, 99h, 0BEh ; 9765
	DB 0A4h, 01h, 00h, 20h, 0B4h, 0F4h, 99h, 00h ; 976d
	DB 0FFh, 97h, 99h, 02h, 0F4h, 99h, 00h, 0FFh ; 9775
	DB 97h, 99h, 02h, 0F4h, 99h, 00h, 0FFh, 97h ; 977d
	DB 99h, 03h, 0F4h, 99h, 00h, 01h, 97h, 99h ; 9785
	DB 03h, 0F4h, 99h, 00h, 01h, 97h, 99h, 02h ; 978d
	DB 0F4h, 99h, 00h, 01h, 97h, 99h, 02h, 0F7h ; 9795
	DB 0AEh, 0D6h, 99h, 1Fh, 00h, 23h, 00h, 9Dh ; 979d
	DB 99h, 0FCh, 0A4h ; 97a5
	ASCIZ "2" ; 97a8
	DB 24h, 0B4h, 04h, 00h, 28h, 0B4h, 04h, 00h ; 97aa
	DB 24h, 0B4h, 04h, 00h, 28h, 0B4h, 04h, 00h ; 97b2
	DB 24h, 0B4h, 04h, 00h, 28h, 0B4h, 0C1h, 99h ; 97ba
	DB 0A8h, 97h, 04h, 00h, 2Ch, 0B4h, 01h, 00h ; 97c2
	ASCII "0" ; 97ca
	DB 0B4h, 8Eh, 99h, 01h, 00h ; 97cb
	ASCII "4" ; 97d0
	DB 0B4h, 8Eh, 99h, 0Ch, 00h ; 97d1
	ASCII "4" ; 97d6
	DB 0B4h, 01h, 00h ; 97d7
	ASCII "8" ; 97da
	DB 0B4h, 8Eh, 99h, 9Dh, 99h ; 97db
	ASCII "x" ; 97e0
	DB 0A1h, 0FEh, 0AEh, 02h, 00h ; 97e1
	ASCII "8" ; 97e6
	DB 0B4h, 9Dh, 99h, 9Dh, 0A6h, 8Eh, 99h, 9Dh ; 97e7
	DB 99h, 0D2h, 0A6h, 04h, 00h, 1Ch, 0B4h ; 97ef
	ASCII "O" ; 97f6
	DB 9Ah, 11h, 01h, 00h, 3Ch, 0B4h, 0BBh, 99h ; 97f7
	DB 04h, 0F4h, 99h, 0FFh, 0FFh, 97h, 99h, 01h ; 97ff
	DB 0C4h, 99h, 00h, 98h, 01h, 00h, 40h, 0B4h ; 9807
	DB 0BBh, 99h, 04h, 0F4h, 99h, 0FFh, 00h, 97h ; 980f
	DB 99h, 01h, 0C4h, 99h, 12h, 98h, 01h, 00h ; 9817
	ASCII "D" ; 981f
	DB 0B4h, 0BBh, 99h, 0Dh, 0F4h, 99h, 0FFh, 01h ; 9820
	DB 97h, 99h, 01h, 0C4h, 99h, 24h, 98h ; 9828
	ASCII "O" ; 982f
	DB 9Ah, 12h, 9Dh, 99h ; 9830
	ASCII "x" ; 9834
	DB 0A1h ; 9835
	ASCII "r" ; 9836
	DB 0A9h, 09h, 0B6h, 0BBh, 99h, 07h, 0F4h, 99h ; 9837
	DB 0FFh, 00h, 02h, 00h, 0D8h, 0B4h, 0C4h, 99h ; 983f
	DB 3Dh, 98h, 14h, 00h, 0DCh, 0B4h, 14h, 00h ; 9847
	DB 0E0h, 0B4h, 0C1h, 99h, 0Ch, 80h, 9Dh, 99h ; 984f
	ASCII "x" ; 9857
	DB 0A1h, 0D6h, 99h, 1Ch, 00h, 29h, 00h, 0Eh ; 9858
	DB 00h ; 9860
	ASCII "m" ; 9861
	DB 1Ah, 04h, 00h, 80h, 0B6h, 04h, 00h, 84h ; 9862
	DB 0B6h, 04h, 00h, 88h, 0B6h, 0Ah, 00h, 8Ch ; 986a
	DB 0B6h, 06h, 00h, 90h, 0B6h, 14h, 00h, 94h ; 9872
	DB 0B6h, 08h, 00h, 98h, 0B6h, 02h, 00h, 9Ch ; 987a
	DB 0B6h, 2Fh, 0AFh, 9Dh, 99h, 2Dh, 0ACh ; 9882
	ASCIZ "2" ; 9889
	DB 9Ch, 0B6h, 04h, 00h, 0A0h, 0B6h, 04h, 00h ; 988b
	DB 9Ch, 0B6h, 04h, 00h, 0A0h, 0B6h, 04h, 00h ; 9893
	DB 9Ch, 0B6h, 04h, 00h, 0A0h, 0B6h, 0C1h, 99h ; 989b
	DB 8Dh, 98h, 13h, 0AFh, 9Dh, 99h ; 98a3
	ASCII "D" ; 98a9
	DB 0ACh, 04h, 00h, 9Ch, 0B6h, 04h, 00h, 0BCh ; 98aa
	DB 0B6h, 04h, 00h, 0B8h, 0B6h, 04h, 00h, 0B4h ; 98b2
	DB 0B6h, 04h, 00h, 0B0h, 0B6h, 04h, 00h, 0ACh ; 98ba
	DB 0B6h, 04h, 00h, 0A8h, 0B6h, 04h, 00h, 0A4h ; 98c2
	DB 0B6h, 3Dh, 0AFh, 0D5h, 98h, 0A5h, 98h, 83h ; 98ca
	DB 98h ; 98d2
	ASCII "g" ; 98d3
	DB 99h, 1Ah, 0AFh, 9Dh, 99h ; 98d4
	ASCII "D" ; 98d9
	DB 0ACh, 03h, 00h, 9Ch, 0B6h, 03h, 00h, 0BCh ; 98da
	DB 0B6h, 03h, 00h, 0B8h, 0B6h, 03h, 00h, 0B4h ; 98e2
	DB 0B6h, 03h, 00h, 0B0h, 0B6h, 03h, 00h, 0ACh ; 98ea
	DB 0B6h, 03h, 00h, 0A8h, 0B6h, 03h, 00h, 0A4h ; 98f2
	DB 0B6h, 3Dh, 0AFh, 05h, 99h, 0D5h, 98h, 0A5h ; 98fa
	DB 98h ; 9902
	ASCII "g" ; 9903
	DB 99h, 21h, 0AFh, 9Dh, 99h ; 9904
	ASCII "D" ; 9909
	DB 0ACh, 02h, 00h, 9Ch, 0B6h, 02h, 00h, 0BCh ; 990a
	DB 0B6h, 02h, 00h, 0B8h, 0B6h, 02h, 00h, 0B4h ; 9912
	DB 0B6h, 02h, 00h, 0B0h, 0B6h, 02h, 00h, 0ACh ; 991a
	DB 0B6h, 02h, 00h, 0A8h, 0B6h, 02h, 00h, 0A4h ; 9922
	DB 0B6h, 3Dh, 0AFh ; 992a
	ASCII "5" ; 992d
	DB 99h, 05h, 99h, 0D5h, 98h ; 992e
	ASCII "g" ; 9933
	DB 99h, 0E2h, 0AEh, 28h, 0AFh, 9Dh, 99h ; 9934
	ASCII "D" ; 993b
	DB 0ACh, 01h, 00h, 9Ch, 0B6h, 01h, 00h, 0BCh ; 993c
	DB 0B6h, 01h, 00h, 0B8h, 0B6h, 01h, 00h, 0B4h ; 9944
	DB 0B6h, 01h, 00h, 0B0h, 0B6h, 01h, 00h, 0ACh ; 994c
	DB 0B6h, 01h, 00h, 0A8h, 0B6h, 01h, 00h, 0A4h ; 9954
	DB 0B6h, 3Dh, 0AFh ; 995c
	ASCII "g" ; 995f
	DB 99h ; 9960
	ASCII "7" ; 9961
	DB 99h, 05h, 99h ; 9962
	ASCII "g" ; 9965
	DB 99h ; 9966
	ASCII "6" ; 9967
	DB 0AFh, 09h, 0B6h, 9Dh, 99h, 0FDh, 0A1h ; 9968
	ASCII "O" ; 996f
	DB 9Ah, 11h, 04h, 00h, 0C0h, 0B6h, 04h, 00h ; 9970
	DB 0C8h, 0B6h, 04h, 00h, 0D0h, 0B6h, 0Eh, 00h ; 9978
	ASCII "m" ; 9980
	DB 1Ah, 0E1h, 0A9h, 0C1h, 99h, 0F8h, 99h, 9Dh ; 9981
	DB 99h, 0FDh, 0A1h, 97h, 99h, 02h, 0C1h, 99h ; 9989
	DB 9Eh, 99h, 9Dh, 99h, 0FDh, 0A1h, 97h, 99h ; 9991
	DB 02h, 0C1h, 99h, 0A8h, 99h, 0DAh, 0A9h, 16h ; 9999
	DB 00h ; 99a1
	ASCII "d" ; 99a2
	DB 0B7h, 0C1h, 99h, 0F8h, 99h, 0DAh, 0A9h, 04h ; 99a3
	DB 00h ; 99ab
	ASCII "d" ; 99ac
	DB 0B7h ; 99ad
	ASCII "i" ; 99ae
	DB 0AFh, 0C5h, 0ADh, 9Dh, 99h, 1Bh, 0A7h, 01h ; 99af
	DB 00h ; 99b7
	ASCII "R" ; 99b8
	DB 1Bh, 8Eh, 99h, 1Ah, 0ADh, 0C2h, 99h, 0CCh ; 99b9
	DB 99h, 9Dh, 99h, 5Bh, 9Eh, 01h, 00h ; 99c1
	ASCII "d" ; 99c8
	DB 0B7h, 8Eh, 99h, 9Dh, 99h, 8Eh, 9Eh, 01h ; 99c9
	DB 00h ; 99d1
	ASCII "d" ; 99d2
	DB 0B7h, 8Eh, 99h ; 99d3
	ASCII "p" ; 99d6
	DB 0AFh, 0B0h, 0ADh, 0E0h, 99h, 0E8h, 99h, 0F0h ; 99d7
	DB 99h, 09h, 00h ; 99df
	ASCII "d" ; 99e2
	DB 0B7h, 0C1h, 99h, 0F8h, 99h, 12h, 00h ; 99e3
	ASCII "d" ; 99ea
	DB 0B7h, 0C1h, 99h, 0F8h, 99h, 24h, 00h ; 99eb
	ASCII "d" ; 99f2
	DB 0B7h, 0C1h, 99h, 0F8h, 99h, 02h, 00h, 8Ch ; 99f3
	DB 0B7h, 02h, 00h, 7Ch, 0B7h, 02h, 00h, 80h ; 99fb
	DB 0B7h, 02h, 00h, 84h, 0B7h, 02h, 00h, 88h ; 9a03
	DB 0B7h, 0C1h, 99h, 0Eh, 80h, 0A6h, 0A3h, 0CEh ; 9a0b
	DB 0D2h, 0DFh, 1Ah, 0C7h, 1Fh, 9Ah, 0CEh, 0C7h ; 9a13
	DB 00h, 0F3h, 0C2h, 00h ; 9a1b
	ASCII "F<2" ; 9a1f
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0E1h, 1Ah, 0C7h ; 9a22
	ASCII "1" ; 9a29
	DB 9Ah, 0CEh, 0C7h, 00h, 0F3h, 0B0h, 00h ; 9a2a
	ASCII "F<2" ; 9a31
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0DFh, 1Ah, 0C7h ; 9a34
	ASCII "C" ; 9a3b
	DB 9Ah, 0CEh, 0C7h, 00h, 0F3h, 9Eh, 00h, 3Ch ; 9a3c
	ASCII "2(" ; 9a44
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0DFh, 1Ah, 0C7h ; 9a46
	ASCII "U" ; 9a4d
	DB 9Ah, 0CEh, 0C7h, 00h, 0F3h, 8Ch, 00h ; 9a4e
	ASCII "2(" ; 9a55
	DB 1Eh, 0A6h, 0A3h, 0CEh, 0D2h, 0DFh, 1Ah, 0C7h ; 9a57
	ASCII "f" ; 9a5f
	DB 9Ah, 0CEh, 0C7h, 00h, 0F1h, 7Bh, 28h, 1Eh ; 9a60
	DB 14h, 0A6h, 0A3h, 0CEh, 0D2h, 0DFh, 1Ah, 0C7h ; 9a68
	ASCII "w" ; 9a70
	DB 9Ah, 0CEh, 0C7h, 00h, 0F1h ; 9a71
	ASCII "jF<2" ; 9a76
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0DFh, 1Ah, 0C7h, 88h ; 9a7a
	DB 9Ah, 0CEh, 0C7h, 00h, 0F1h ; 9a82
	ASCII "Y<2(" ; 9a87
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0DFh, 1Ah, 0C7h, 99h ; 9a8b
	DB 9Ah, 0CEh, 0C7h, 00h, 0F1h ; 9a93
	ASCII "H2(" ; 9a98
	DB 1Eh, 0A6h, 0A3h, 0CEh, 0D2h, 0E3h, 1Ah, 0C7h ; 9a9b
	DB 0AAh, 9Ah, 0CEh, 0C7h, 00h, 0F1h ; 9aa3
	ASCII "7F<2" ; 9aa9
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0DDh, 1Ah, 0C7h, 0BBh ; 9aad
	DB 9Ah, 0CEh, 0C7h, 00h, 0F1h, 26h ; 9ab5
	ASCII "F<2" ; 9abb
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0DDh, 1Ah, 0C7h, 0CCh ; 9abe
	DB 9Ah, 0CEh, 0C7h, 00h, 0F1h, 15h ; 9ac6
	ASCII "F<2" ; 9acc
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0DDh, 1Ah, 0C7h, 0DDh ; 9acf
	DB 9Ah, 0CEh, 0C7h, 00h, 0F1h, 04h ; 9ad7
	ASCII "F<2" ; 9add
	DB 0F2h ; 9ae0
	ASCII "d" ; 9ae1
	DB 0Fh, 0E6h, 26h, 0CEh, 0D0h, 0DCh, 1Ah, 0B1h ; 9ae2
	DB 00h, 0CFh ; 9aea
	ASCII "B" ; 9aec
	DB 0B0h ; 9aed
	ASCII "d" ; 9aee
	DB 17h, 0CEh, 0D8h, 0B0h, 40h, 0CEh, 0D9h ; 9aef
	ASCII "B" ; 9af6
	DB 07h, 0CFh, 0B0h, 0C4h ; 9af7
	ASCIZ "d" ; 9afb
	DB 0CEh, 0C4h, 03h, 0F2h, 0FCh, 0F4h, 0CFh, 0B5h ; 9afd
	ASCII "1" ; 9b05
	DB 0E6h, 07h, 0E4h, 05h, 9Ch, 0FEh, 0F1h, 03h ; 9b06
	DB 9Dh, 01h, 0ABh, 0AEh, 0F8h, 04h, 00h ; 9b0e
	ASCII "m" ; 9b15
	DB 1Ah, 8Eh, 99h, 0F8h, 0CEh, 0D0h, 12h, 1Bh ; 9b16
	DB 12h, 02h, 0E5h, 02h ; 9b1e
	ASCII "8" ; 9b22
	DB 0CEh, 0D1h, 10h, 1Bh ; 9b23
	ASCII "1" ; 9b27
	DB 0E6h, 0Ch, 0E5h, 28h, 0CEh, 0D0h, 12h, 1Bh ; 9b28
	DB 02h, 02h ; 9b30
	ASCII "1" ; 9b32
	DB 0E4h, 1Fh, 0CEh, 0D0h, 13h, 1Bh, 12h, 0Dh ; 9b33
	DB 0E5h, 02h ; 9b3b
	ASCII "8" ; 9b3d
	DB 0CEh, 0D1h, 11h, 1Bh ; 9b3e
	ASCII "1" ; 9b42
	DB 0E6h, 0Ch, 0E5h, 0Dh, 0CEh, 0D0h, 13h, 1Bh ; 9b43
	DB 02h, 10h ; 9b4b
	ASCII "1" ; 9b4d
	DB 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 9b4e
	DB 0CEh, 0D0h, 12h, 1Bh, 12h, 02h, 0E5h, 02h ; 9b56
	ASCII "8" ; 9b5e
	DB 0CEh, 0D1h, 10h, 1Bh ; 9b5f
	ASCII "1" ; 9b63
	DB 0E6h, 0Ch, 0E5h, 23h, 0CEh, 0D0h, 12h, 1Bh ; 9b64
	DB 02h, 05h ; 9b6c
	ASCII "1" ; 9b6e
	DB 0E4h, 1Ah, 0CEh, 0D1h, 13h, 1Bh, 0CEh, 0D0h ; 9b6f
	DB 11h, 1Bh, 02h, 10h ; 9b77
	ASCII "1" ; 9b7b
	DB 0E4h, 0Dh, 0CEh, 0D0h, 11h, 1Bh ; 9b7c
	ASCII "1" ; 9b82
	DB 0E6h, 03h, 0E5h, 04h, 9Ch, 0FEh, 0F8h, 9Dh ; 9b83
	DB 01h, 0F8h, 0CEh, 0D0h, 14h, 1Bh ; 9b8b
	ASCIZ "2" ; 9b91
	DB 0E7h, 0Fh, 0CEh, 0D0h, 0D7h, 1Ah ; 9b93
	ASCIZ "2" ; 9b99
	DB 0E6h ; 9b9b
	ASCII "Z2" ; 9b9c
	DB 01h, 0E6h, 06h, 0F1h, 24h, 9Dh, 01h, 0F8h ; 9b9e
	DB 0B9h ; 9ba6
	ASCII "7" ; 9ba7
	DB 1Bh, 0C1h, 18h, 00h, 0CFh, 0C0h, 0D4h ; 9ba8
	ASCII "j" ; 9baf
	DB 97h, 0E4h, 11h, 0D4h ; 9bb0
	ASCII "I" ; 9bb4
	DB 98h, 0E5h, 0Ch, 0CEh, 0D0h, 10h, 1Bh ; 9bb5
	ASCII "20" ; 9bbc
	DB 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 9bbe
	DB 0B9h ; 9bc6
	ASCII "7" ; 9bc7
	DB 1Bh, 0C1h, 18h, 00h, 0CFh, 0C0h, 0D4h, 83h ; 9bc8
	DB 98h, 0E4h, 21h, 0D4h ; 9bd0
	ASCII "g" ; 9bd4
	DB 99h, 0E5h, 1Ch, 0CEh, 0D0h, 10h, 1Bh ; 9bd5
	ASCII "2+" ; 9bdc
	DB 0E4h, 14h ; 9bde
	ASCII "22" ; 9be0
	DB 0E5h, 10h, 0CEh, 0D0h, 11h, 1Bh ; 9be2
	ASCII "2'" ; 9be8
	DB 0E4h, 08h ; 9bea
	ASCII "23" ; 9bec
	DB 0E5h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 9bee
	DB 0B9h ; 9bf6
	ASCII "7" ; 9bf7
	DB 1Bh, 0C1h, 18h, 00h, 0CFh, 0C0h, 0D4h, 5Eh ; 9bf8
	DB 96h, 0E4h, 21h, 0D4h, 0FDh, 96h, 0E5h, 1Ch ; 9c00
	DB 0CEh, 0D0h, 10h, 1Bh ; 9c08
	ASCII "2'" ; 9c0c
	DB 0E4h, 14h ; 9c0e
	ASCII "2." ; 9c10
	DB 0E5h, 10h, 0CEh, 0D0h, 11h, 1Bh ; 9c12
	ASCII "2 " ; 9c18
	DB 0E4h, 08h ; 9c1a
	ASCII "2," ; 9c1c
	DB 0E5h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 9c1e
	DB 0CEh, 0D0h, 15h, 1Bh ; 9c26
	ASCII "2" ; 9c2a
	DB 03h, 0E6h, 22h ; 9c2b
	ASCII "2" ; 9c2e
	DB 04h, 0E6h, 1Eh, 0CEh, 0D0h, 28h, 1Bh ; 9c2f
	ASCII "2" ; 9c36
	DB 03h, 0E6h, 02h, 0FAh, 0B0h, 00h, 0CEh, 0D4h ; 9c37
	DB 28h, 1Bh, 0CEh, 0C4h, 02h, 0F2h ; 9c3f
	ASCII "6" ; 9c45
	DB 13h, 0C4h ; 9c46
	ASCII "B" ; 9c48
	DB 8Dh, 0F2h ; 9c49
	ASCII "1" ; 9c4b
	DB 0Dh, 0F8h, 0F8h, 0C4h ; 9c4c
	ASCII "j" ; 9c50
	DB 8Dh, 0F2h, 29h, 0Dh, 0F8h, 0CEh, 0D0h, 17h ; 9c51
	DB 1Bh ; 9c59
	ASCII "2" ; 9c5a
	DB 02h, 0E6h, 02h, 0FAh, 0C4h, 9Eh, 82h, 0F2h ; 9c5b
	DB 19h, 0Dh, 0F8h, 0F2h, 0EEh, 0FEh, 0E7h, 02h ; 9c63
	DB 0FAh, 0C4h, 0DBh, 82h, 0F2h, 0Ch, 0Dh, 0F8h ; 9c6b
	DB 0F2h, 89h, 0Eh, 0E7h, 02h, 0FAh, 0C4h ; 9c73
	ASCII "5" ; 9c7a
loc_0x009C7B:
	DB 83h, 0F2h, 0FFh, 0Ch, 0F8h, 0F2h, 0C4h, 0Dh ; 9c7b
	DB 0E6h, 02h, 0FAh, 0C5h, 80h, 82h, 0CEh, 0D0h ; 9c83
	DB 0DBh, 1Ah, 28h, 0E6h, 04h, 0C5h ; 9c8b
	ASCII "b" ; 9c91
	DB 82h, 0CFh, 0E1h, 0F2h, 0E6h, 0Ch, 0F8h, 0CEh ; 9c92
	DB 0D0h, 15h, 1Bh ; 9c9a
	ASCII "2" ; 9c9d
	DB 02h, 0E6h, 02h, 0FAh, 0B8h, 10h, 1Bh, 0BCh ; 9c9e
	DB 1Eh, 1Bh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 9ca6
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 9cae
	DB 8Fh, 0Dh, 0E6h, 13h, 0CEh, 0D0h, 0DCh, 1Ah ; 9cb6
	ASCII "2" ; 9cbe
	DB 02h, 0E6h, 06h, 0C4h ; 9cbf
	ASCII "V" ; 9cc3
	DB 83h, 0F1h, 09h, 0C4h, 87h, 85h, 0F1h, 04h ; 9cc4
	DB 0C4h, 17h, 82h, 0F2h, 0ACh, 0Ch, 0F8h, 0CEh ; 9ccc
	DB 0D0h, 0D8h, 1Ah ; 9cd4
	ASCII "2" ; 9cd7
	DB 01h, 0E7h, 0Ch, 0C5h, 12h, 1Bh, 0CEh, 0C4h ; 9cd8
	DB 02h, 0F2h ; 9ce0
	ASCII "5" ; 9ce2
	DB 0Ah, 0E7h, 02h, 0FAh, 0CEh, 0D0h, 0D6h, 1Ah ; 9ce3
	DB 28h, 0E7h, 0Fh, 0CEh, 0D0h, 0DAh, 1Ah ; 9ceb
	ASCII "2" ; 9cf2
	DB 02h, 0E5h
loc_0x009CF5:
	DB 07h, 0B0h, 02h, 0CEh, 0D4h, 0DAh ; 9cf3
	DB 1Ah, 0B0h, 0FFh, 0CEh, 0D4h, 0E8h, 1Ah, 0C4h ; 9cfb
	ASCII "X" ; 9d03
	DB 86h
loc_0x009D05:
	DB 0F2h ; 9d04
	ASCII "v" ; 9d06
	DB 0Ch, 0F8h, 0F2h, 0C1h, 0Dh, 0E7h, 14h, 0B0h ; 9d07
	DB 1Ch, 0CEh, 0D4h, 1Eh, 1Bh, 0B0h, 05h, 0CEh ; 9d0f
	DB 0D4h, 20h, 1Bh, 0C4h, 0BCh, 99h, 0F2h, 5Eh ; 9d17
	DB 0Ch, 0F8h, 0FAh, 0F2h ; 9d1f
	ASCII "k" ; 9d23
	DB 0Dh, 0E7h, 29h, 0CEh, 0D0h, 0D7h, 1Ah ; 9d24
	ASCIZ "2" ; 9d2b
	DB 0E6h, 08h, 0C4h ; 9d2d
	ASCII "j" ; 9d30
	DB 97h, 0F2h ; 9d31
	ASCII "I" ; 9d33
	DB 0Ch, 0F8h, 0C4h ; 9d34
	ASCII "4" ; 9d37
	DB 96h, 0F2h ; 9d38
	ASCII "B" ; 9d3a
	DB 0Ch, 0B8h, 12h, 1Bh, 0F2h ; 9d3b
	ASCII "A" ; 9d40
	DB 0DCh, 0B0h, 20h, 0CEh, 0D4h, 1Eh, 1Bh, 0B0h ; 9d41
	DB 05h, 0CEh, 0D4h, 20h, 1Bh, 0F8h, 0FAh, 0CEh ; 9d49
	DB 0D0h, 0D8h, 1Ah ; 9d51
	ASCIZ "2" ; 9d54
	DB 0E7h ; 9d56
	ASCII "e" ; 9d57
	DB 0F2h, 0ECh, 0Ch, 0E6h, 60h, 0CEh, 0D0h, 0D7h ; 9d58
	DB 1Ah ; 9d60
	ASCIZ "2" ; 9d61
	DB 0E6h ; 9d63
	ASCII "C2" ; 9d64
	DB 01h, 0E6h, 1Ch, 0CEh, 0D0h, 13h, 1Bh ; 9d66
	ASCII "2" ; 9d6d
	DB 10h, 0E7h ; 9d6e
	ASCII "L" ; 9d70
	DB 0B0h, 04h, 0CEh, 0D4h, 1Eh, 1Bh, 0B0h, 07h ; 9d71
	DB 0CEh, 0D4h, 20h, 1Bh, 0C4h ; 9d79
	ASCII "q" ; 9d7e
	DB 93h, 0F2h, 0FBh, 0Bh, 0F8h, 0CEh, 0D0h, 13h ; 9d7f
	DB 1Bh ; 9d87
	ASCII "2" ; 9d88
	DB 10h, 0E7h ; 9d89
	ASCII "1" ; 9d8b
	DB 0CEh, 0D0h, 12h, 1Bh ; 9d8c
	ASCII "2" ; 9d90
	DB 15h, 0E5h, 29h, 0B0h, 04h, 0CEh, 0D4h, 1Eh ; 9d91
	DB 1Bh, 0B0h, 07h, 0CEh, 0D4h, 20h, 1Bh, 0C4h ; 9d99
	ASCII "q" ; 9da1
	DB 93h, 0F2h, 0D8h, 0Bh, 0F8h, 0CEh, 0D0h, 13h ; 9da2
	DB 1Bh ; 9daa
	ASCII "2" ; 9dab
	DB 10h, 0E7h, 0Eh, 0B0h, 25h, 0CEh, 0D4h, 1Eh ; 9dac
	DB 1Bh, 0C4h, 3Dh, 92h, 0F2h, 0C3h, 0Bh, 0F8h ; 9db4
	DB 0FAh, 0F2h ; 9dbc
	ASCII "c" ; 9dbe
	DB 0FFh, 0F1h, 1Bh, 0F2h ; 9dbf
	ASCII "b" ; 9dc3
	DB 0FEh, 0F1h, 16h, 0F2h, 0AAh, 0FEh, 0F1h, 11h ; 9dc4
	DB 0F2h, 88h, 0FEh, 0F1h, 0Ch, 0F2h, 93h, 0FEh ; 9dcc
	DB 0F1h, 07h, 0F2h ; 9dd4
	ASCII "x" ; 9dd7
	DB 0FFh, 0F1h, 02h, 0FAh, 0F8h, 0F2h, 0DEh, 0FFh ; 9dd8
	DB 0FFh, 0F8h, 0F8h, 0C5h, 20h, 1Bh ; 9de0
	ASCII "E" ; 9de6
	DB 0B5h, 00h ; 9de7
	ASCII "2" ; 9de9
	DB 07h, 0E6h, 23h ; 9dea
	ASCII "2" ; 9ded
	DB 06h, 0E6h, 2Fh ; 9dee
	ASCII "2" ; 9df1
	DB 05h, 0E6h, 2Fh ; 9df2
	ASCII "2" ; 9df5
	DB 02h, 0E6h ; 9df6
	ASCII "72" ; 9df8
	DB 04h, 0E6h ; 9dfa
	ASCII "K2" ; 9dfc
	DB 03h, 0E6h ; 9dfe
	ASCII "W2" ; 9e00
	DB 01h, 0E7h ; 9e02
	ASCII "M" ; 9e04
	DB 0CEh, 0C4h, 02h, 0F2h, 0F1h, 11h, 0C4h, 0FEh ; 9e05
	DB 8Dh, 0F8h, 0CEh, 0D0h, 0D7h, 1Ah ; 9e0d
	ASCII "2" ; 9e13
	DB 02h, 0E6h, 05h, 0C4h, 9Eh, 94h, 0F8h, 0C4h ; 9e14
	DB 0BBh, 93h, 0F8h, 0C4h, 0B5h, 8Dh, 0F8h, 0CEh ; 9e1c
	DB 0D0h, 0D7h, 1Ah ; 9e24
	ASCII "2" ; 9e27
	DB 02h, 0E6h, 13h, 0C4h, 5Eh, 96h, 0F8h, 0CEh ; 9e28
	DB 0C4h, 02h, 0F2h, 0C7h, 11h, 0CEh, 0D0h, 0D7h ; 9e30
	DB 1Ah ; 9e38
	ASCII "2" ; 9e39
	DB 02h, 0E7h, 07h, 0B0h, 29h, 0CEh, 0D4h, 13h ; 9e3a
	DB 1Bh, 0C4h, 0Ah, 96h, 0F8h, 0CEh, 0C4h, 02h ; 9e42
	DB 0F2h, 0AFh, 11h, 0C4h, 0E4h, 8Eh, 0F8h, 0CEh ; 9e4a
	DB 0C4h, 02h, 0F2h, 0A5h, 11h, 0C4h, 0Eh, 80h ; 9e52
	DB 0F8h, 0F2h, 0F9h, 0FDh, 0F8h, 0FFh, 0F1h, 06h ; 9e5a
	DB 0F2h ; 9e62
	ASCII "Y" ; 9e63
	DB 0FFh, 0FFh, 0F8h, 0F2h ; 9e64
	ASCII "q" ; 9e68
	DB 0Dh, 0C5h, 12h, 1Bh, 0CEh, 14h, 0E5h, 03h ; 9e69
	ASCII "8hE" ; 9e71
	DB 0CEh, 0D1h, 1Eh, 1Bh ; 9e74
	ASCII "1" ; 9e78
	DB 0E6h, 03h, 0E5h, 0Bh, 0CEh, 0D5h, 12h, 1Bh ; 9e79
	DB 0F2h, 60h, 0FFh, 0F2h, 0F7h, 0Ah, 0B8h, 12h ; 9e81
	DB 1Bh, 0F2h, 0F6h, 0DAh, 0F8h, 0F2h, 0C6h, 0FDh ; 9e89
	DB 0F8h, 0FFh, 0F1h, 06h, 0F2h, 26h, 0FFh, 0FFh ; 9e91
	DB 0F8h, 0F2h, 3Eh, 0Dh, 0C5h, 12h, 1Bh, 03h ; 9e99
	ASCII "2P" ; 9ea1
	DB 0E4h, 03h, 0B0h ; 9ea3
	ASCII "P" ; 9ea6
	DB 0CEh, 0D4h, 12h, 1Bh, 0F2h, 0B5h, 0Bh, 0E6h ; 9ea7
	DB 15h, 0CEh, 0D5h, 12h, 1Bh, 0CEh, 0D0h, 20h ; 9eaf
	DB 1Bh ; 9eb7
	ASCII "2" ; 9eb8
	DB 04h, 0E6h, 18h, 0B0h, 00h, 0CEh, 0D4h, 20h ; 9eb9
	DB 1Bh, 0F1h, 10h, 0CEh, 0D0h, 12h, 1Bh, 0CEh ; 9ec1
	DB 0D1h, 1Eh, 1Bh ; 9ec9
	ASCII "1" ; 9ecc
	DB 0E4h, 0Bh
loc_0x009ECF:
	DB 0CEh, 0D5h, 12h, 1Bh, 0F2h, 0Eh ; 9ecd
	DB 0FFh, 0F2h, 0A5h, 0Ah, 0B8h, 12h, 1Bh, 0F2h ; 9ed5
	DB 0A4h, 0DAh, 0F8h, 0F2h ; 9edd
	ASCII "t" ; 9ee1
	DB 0FDh, 0F8h, 0FFh, 0F1h, 06h, 0F2h, 0D4h, 0FEh ; 9ee2
	DB 0FFh, 0F8h, 0CEh, 0D0h, 1Eh, 1Bh, 0CEh, 0D1h ; 9eea
	DB 12h, 1Bh ; 9ef2
	ASCII "1" ; 9ef4
	DB 0E6h, 08h, 89h, 0CEh, 0D5h, 12h, 1Bh, 0F1h ; 9ef5
	DB 07h, 0F2h, 0E3h, 0FEh, 0F2h ; 9efd
	ASCII "z" ; 9f02
	DB 0Ah, 0B8h, 12h, 1Bh, 0F2h ; 9f03
	ASCII "y" ; 9f08
	DB 0DAh, 0F8h, 0F2h ; 9f09
	ASCII "I" ; 9f0c
	DB 0FDh, 0F8h, 0FFh, 0F1h, 06h, 0F2h, 0A9h, 0FEh ; 9f0d
	DB 0FFh, 0F8h, 0CEh, 0D0h, 1Eh, 1Bh, 0CEh, 0D1h ; 9f15
	DB 12h, 1Bh ; 9f1d
	ASCII "1" ; 9f1f
	DB 0E6h, 1Dh, 81h, 0CEh, 0D5h, 12h, 1Bh, 0F2h ; 9f20
	ASCII "9" ; 9f28
	DB 0Bh, 0E6h, 19h, 0CEh, 0D5h, 12h, 1Bh, 0CEh ; 9f29
	DB 0D0h, 20h, 1Bh ; 9f31
	ASCII "2" ; 9f34
	DB 04h, 0E6h, 07h, 0B0h, 00h, 0CEh, 0D4h, 20h ; 9f35
	DB 1Bh, 0F2h, 0A3h, 0FEh, 0F2h, 3Ah, 0Ah, 0B8h ; 9f3d
	DB 12h, 1Bh, 0F2h ; 9f45
	ASCII "9" ; 9f48
	DB 0DAh, 0F8h, 0F2h, 09h, 0FDh, 0F8h, 0FFh, 0F1h ; 9f49
	DB 06h, 0F2h ; 9f51
	ASCII "i" ; 9f53
	DB 0FEh, 0F8h, 0FFh, 0CEh, 0D0h, 1Eh, 1Bh, 0CEh ; 9f54
	DB 0D1h, 12h, 1Bh ; 9f5c
	ASCII "1" ; 9f5f
	DB 0E6h, 10h, 0CEh, 0D0h ; 9f60
	ASCII "q" ; 9f64
	DB 16h, 96h, 01h, 0E7h, 06h, 89h, 0CEh, 0D5h ; 9f65
	DB 12h, 1Bh, 0F1h, 07h, 0F2h ; 9f6d
	ASCII "p" ; 9f72
	DB 0FEh, 0F2h, 07h, 0Ah, 0B8h, 12h, 1Bh, 0F2h ; 9f73
	DB 06h, 0DAh, 0F8h, 0F2h, 0D6h, 0FCh, 0F8h, 0FFh ; 9f7b
	DB 0F1h, 06h, 0F2h ; 9f83
	ASCII "6" ; 9f86
	DB 0FEh, 0FFh, 0F8h, 0CEh, 0D0h, 1Eh, 1Bh, 0CEh ; 9f87
	DB 0D1h, 12h, 1Bh ; 9f8f
	ASCII "1" ; 9f92
	DB 0E6h, 25h, 0CEh, 0D0h ; 9f93
	ASCII "q" ; 9f97
	DB 16h, 96h, 01h, 0E7h, 06h, 81h, 0CEh, 0D5h ; 9f98
	DB 12h, 1Bh, 0F2h, 0BEh, 0Ah, 0E6h, 19h, 0CEh ; 9fa0
	DB 0D5h, 12h, 1Bh, 0CEh, 0D0h, 20h, 1Bh ; 9fa8
	ASCII "2" ; 9faf
	DB 04h, 0E6h, 07h, 0B0h, 00h, 0CEh, 0D4h, 20h ; 9fb0
	DB 1Bh, 0F2h, 28h, 0FEh, 0F2h, 0BFh, 09h, 0B8h ; 9fb8
	DB 12h, 1Bh, 0F2h, 0BEh, 0D9h, 0F8h, 0F2h, 0F5h ; 9fc0
	DB 0FDh, 0FFh, 0F8h, 0F8h, 0F2h, 88h, 0FCh, 0F8h ; 9fc8
	DB 0FFh, 0CEh, 0D0h, 13h, 1Bh ; 9fd0
	ASCII "2" ; 9fd5
	DB 18h, 0E7h, 08h, 0C4h, 0Eh, 80h, 0F2h, 9Fh ; 9fd6
	DB 09h, 0F8h, 88h, 0CEh, 0D4h, 13h, 1Bh, 0B8h ; 9fde
	DB 12h, 1Bh, 0F2h, 98h, 0D9h, 0F8h, 0F2h ; 9fe6
	ASCII "8" ; 9fed
	DB 0FCh, 0F1h, 1Fh, 0F2h ; 9fee
	ASCII "c" ; 9ff2
	DB 0FBh, 0E7h, 08h, 0C4h, 0Eh, 80h, 0F2h, 82h ; 9ff3
	DB 09h, 0F8h, 0CEh, 0D0h, 17h, 1Bh ; 9ffb
	ASCII "2" ; 0a001
	DB 02h, 0E7h, 08h, 0C4h, 9Eh, 82h, 0F2h ; 0a002
	ASCII "s" ; 0a009
	DB 09h, 0F8h, 0F2h, 02h, 00h, 0F8h, 0CEh, 0D0h ; 0a00a
	ASCII "B" ; 0a012
	DB 16h, 96h, 60h, 0E6h, 2Dh, 0C5h, 18h, 1Bh ; 0a013
	DB 86h ; 0a01b
	ASCII "E2" ; 0a01c
	DB 08h, 0E4h, 1Eh, 0B5h, 00h, 0CEh, 0C4h, 02h ; 0a01e
	DB 0F2h ; 0a026
	ASCII "T" ; 0a027
	DB 0Fh, 0CEh, 0D0h, 0D6h, 1Ah, 28h, 0E7h, 06h ; 0a028
	DB 0F2h, 8Ch, 0FAh, 0E7h, 0Ah, 0CEh, 0C4h, 02h ; 0a030
	DB 0F2h, 0BCh, 0Fh, 0F2h, 0ACh, 20h, 0C4h, 0DBh ; 0a038
	DB 82h, 0F2h, 3Ah, 09h, 0F8h, 0CEh, 0D0h, 17h ; 0a040
	DB 1Bh ; 0a048
	ASCII "2" ; 0a049
	DB 02h, 0E6h, 16h, 0F2h, 0D3h, 0FCh, 0F1h, 11h ; 0a04a
	DB 0F2h, 1Fh, 0FCh, 0F1h, 0Ch, 0F2h, 0F7h, 0FCh ; 0a052
	DB 0F1h, 07h, 0C4h, 0Eh, 80h, 0F2h, 1Ch, 09h ; 0a05a
	DB 0B8h, 12h, 1Bh, 0F2h, 1Bh, 0D9h, 0F8h ; 0a062
	ASCII "8" ; 0a069
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0F2h, 0B2h, 0FCh, 0F1h ; 0a06a
	DB 3Bh, 0F2h, 0E1h, 0FBh, 0F1h ; 0a072
	ASCII "C" ; 0a077
	DB 0F2h, 84h, 0Ah, 0E7h, 3Fh, 0F2h, 8Ah, 0FCh ; 0a078
	DB 0F1h, 2Ch, 0F2h, 0CCh, 0FCh, 0F1h, 27h, 0CEh ; 0a080
	DB 0D0h, 0D8h, 1Ah ; 0a088
	ASCII "2" ; 0a08b
	DB 01h, 0E6h, 19h, 0CEh, 0D0h, 0D7h, 1Ah ; 0a08c
	ASCII "2" ; 0a093
	DB 02h, 0E7h, 11h, 0CEh, 0D1h, 23h, 1Bh, 0CEh ; 0a094
	DB 0D0h, 13h, 1Bh ; 0a09c
	ASCII "1" ; 0a09f
	DB 0E4h, 06h, 0C4h, 88h, 99h, 0F1h, 04h, 0C4h ; 0a0a0
	DB 0Eh, 80h, 0F2h, 0D1h, 08h, 0CEh, 0D0h, 0B6h ; 0a0a8
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 12h, 0CEh, 0D4h ; 0a0b0
	DB 0FAh, 14h, 0F8h, 0F2h, 16h, 0FCh, 0F1h, 0EEh ; 0a0b8
	DB 0B0h, 01h, 0CEh, 0D4h, 0E8h, 1Ah, 0C5h, 13h ; 0a0c0
	DB 1Bh, 86h, 0B8h, 12h, 1Bh, 0F2h, 0B3h, 0D8h ; 0a0c8
	DB 0F8h, 0F2h, 83h, 0FBh, 0F1h, 21h, 0F2h, 26h ; 0a0d0
	DB 0Ah, 0E7h, 1Dh, 0CEh, 0D0h, 13h, 1Bh ; 0a0d8
	ASCII "2" ; 0a0df
	DB 10h, 0E6h, 15h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 0a0e0
	DB 0E6h, 07h, 0B0h, 12h, 0CEh, 0D4h, 0FAh, 14h ; 0a0e8
	DB 0C4h, 93h, 99h, 0F2h, 88h, 08h, 0F8h, 0C5h ; 0a0f0
	DB 13h, 1Bh, 86h, 0B8h, 12h, 1Bh, 0F2h, 82h ; 0a0f8
	DB 0D8h, 0F8h, 0F2h ; 0a100
	ASCII "R" ; 0a103
	DB 0FBh, 0F1h, 2Ch, 0F2h, 0F5h, 09h, 0E7h, 28h ; 0a104
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 0a10c
	DB 12h, 0CEh, 0D4h, 0FAh, 14h, 0C4h, 5Fh, 91h ; 0a114
	DB 0CEh ; 0a11c
	ASCII "P" ; 0a11d
	DB 02h, 0CEh ; 0a11e
	ASCII "X" ; 0a120
	DB 03h, 0D5h ; 0a121
	ASCII "s" ; 0a123
	DB 91h, 0E4h, 09h, 0D5h, 0EAh, 91h, 0E5h, 04h ; 0a124
	DB 0C4h, 0EAh, 91h, 0F2h ; 0a12c
	ASCII "L" ; 0a130
	DB 08h, 0F8h, 0C5h, 13h, 1Bh, 86h, 0B8h, 12h ; 0a131
	DB 1Bh, 0F2h ; 0a139
	ASCII "F" ; 0a13b
	DB 0D8h, 0F8h, 0F2h, 16h, 0FBh, 0F1h ; 0a13c
	ASCII "5" ; 0a142
	DB 0A6h, 0A3h, 0CEh, 40h, 14h, 0CEh ; 0a143
	ASCII "H" ; 0a149
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 0a14a
	ASCII "G" ; 0a152
	DB 0CEh, 00h, 0Ah, 0CEh, 0D4h, 12h, 1Bh, 93h ; 0a153
	ASCII "G" ; 0a15b
	DB 0CEh, 00h, 0Eh, 0CEh, 0D4h, 13h, 1Bh, 0ABh ; 0a15c
	DB 0AEh, 0CEh, 0D0h, 13h, 1Bh, 96h, 80h, 0E6h ; 0a164
	DB 0Bh ; 0a16c
	ASCII "2" ; 0a16d
	DB 0F0h, 0E5h, 07h, 0C4h ; 0a16e
	ASCII "9" ; 0a172
	DB 93h, 0F2h, 07h, 08h, 0F8h, 0F2h, 0DCh, 0FAh ; 0a173
	DB 0F1h, 04h, 0F0h, 09h, 0F8h, 0CEh, 0C4h, 02h ; 0a17b
	DB 0F2h, 21h, 08h, 0F8h, 0A6h, 0A3h, 0CEh, 40h ; 0a183
	DB 14h, 0CEh ; 0a18b
	ASCII "H" ; 0a18d
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 0a18e
	ASCII "G" ; 0a196
	DB 0CEh, 00h, 0Ah, 0CEh, 0D4h, 12h, 1Bh, 93h ; 0a197
	ASCII "G" ; 0a19f
	DB 0CEh, 00h, 0Eh, 0CEh, 0D1h, 23h, 1Bh ; 0a1a0
	ASCII "1" ; 0a1a7
	DB 0E4h, 02h ; 0a1a8
	ASCII "A" ; 0a1aa
	DB 0CEh, 0D4h, 13h, 1Bh, 0ABh, 0AEh, 0F8h, 0F2h ; 0a1ab
	DB 0A2h, 0FAh, 0F1h, 10h, 0CEh, 0D0h, 28h, 1Bh ; 0a1b3
	ASCII "2" ; 0a1bb
	DB 03h, 0E6h, 14h, 0B0h, 0FFh, 0CEh, 0D4h, 0E8h ; 0a1bc
	DB 1Ah, 0F8h ; 0a1c4
	ASCII "8" ; 0a1c6
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0CEh, 0C4h, 02h, 0F2h ; 0a1c7
	DB 0D6h, 07h, 0F8h, 0B0h, 00h, 0CEh, 0D4h, 28h ; 0a1cf
	DB 1Bh, 0C4h, 0B0h, 8Ch, 0F2h, 0A0h, 07h, 0CEh ; 0a1d7
	DB 0C4h, 02h, 0F2h, 0C3h, 07h, 0F8h, 0F2h ; 0a1df
	ASCII "o" ; 0a1e6
	DB 0FAh, 0F1h, 08h, 0B0h, 0FFh, 0CEh, 0D4h, 0E8h ; 0a1e7
	DB 1Ah, 0F8h ; 0a1ef
	ASCII "8" ; 0a1f1
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0CEh, 0C4h, 02h, 0F2h ; 0a1f2
	DB 0ABh, 07h, 0F8h, 0F2h ; 0a1fa
	ASCII "W" ; 0a1fe
	DB 0FAh, 0F1h, 01h, 0F8h, 0F2h ; 0a1ff
	ASCII "Q" ; 0a204
	DB 0FAh, 0F1h, 01h, 0F8h, 0F2h ; 0a205
	ASCII "K" ; 0a20a
	DB 0FAh, 0F1h, 21h, 0CEh, 0D0h, 1Eh, 1Bh, 0CEh ; 0a20b
	DB 0D1h, 12h, 1Bh ; 0a213
	ASCII "1" ; 0a216
	DB 0E6h, 08h, 89h, 0CEh, 0D5h, 12h, 1Bh, 0F1h ; 0a217
	DB 07h, 0C4h ; 0a21f
	ASCII "4" ; 0a221
	DB 96h, 0F2h ; 0a222
	ASCII "X" ; 0a224
	DB 07h, 0B8h, 12h, 1Bh, 89h, 89h, 0F2h ; 0a225
	ASCII "U" ; 0a22c
	DB 0D7h, 0F8h, 0F2h, 25h, 0FAh, 0F1h, 21h, 0CEh ; 0a22d
	DB 0D0h, 1Eh, 1Bh, 0CEh, 0D1h, 12h, 1Bh ; 0a235
	ASCII "1" ; 0a23c
	DB 0E6h, 08h, 81h, 0CEh, 0D5h, 12h, 1Bh, 0F1h ; 0a23d
	DB 07h, 0C4h ; 0a245
	ASCII "4" ; 0a247
	DB 96h, 0F2h ; 0a248
	ASCII "2" ; 0a24a
	DB 07h, 0B8h, 12h, 1Bh, 89h, 89h, 0F2h, 2Fh ; 0a24b
	DB 0D7h, 0F8h, 0F2h, 0FFh, 0F9h, 0F1h, 0Ah, 0C5h ; 0a253
	DB 13h, 1Bh ; 0a25b
	ASCII "E2" ; 0a25d
	DB 14h, 0E5h, 02h, 86h, 0B8h, 12h, 1Bh, 0F2h ; 0a25f
	DB 1Ah, 0D7h, 0F8h, 0F2h, 0EAh, 0F9h, 0F1h ; 0a267
	ASCII "A" ; 0a26e
	DB 0CEh, 0D0h ; 0a26f
	ASCII "q" ; 0a271
	DB 16h, 22h, 07h, 0E7h ; 0a272
	ASCII "9" ; 0a276
	DB 0CEh, 0D1h, 1Eh, 1Bh, 0CEh, 0BCh, 25h, 0E6h ; 0a277
	DB 16h, 0CEh, 0D0h, 12h, 1Bh ; 0a27f
	ASCII "1" ; 0a284
	DB 0E6h, 08h, 88h, 0CEh, 0D4h, 12h, 1Bh, 0F1h ; 0a285
	DB 22h, 0C4h, 97h, 92h, 0F2h, 0EAh, 06h, 0F8h ; 0a28d
	DB 0CEh, 0D0h, 12h, 1Bh ; 0a295
	ASCII "1" ; 0a299
	DB 0E5h, 08h, 80h, 0CEh, 0D4h, 12h, 1Bh, 0F1h ; 0a29a
	DB 0Dh, 0B0h, 14h, 0CEh, 0D4h, 1Eh, 1Bh, 0C4h ; 0a2a2
	ASCII "6" ; 0a2aa
	DB 92h, 0F2h, 0CFh, 06h, 0B8h, 12h, 1Bh, 0F2h ; 0a2ab
	DB 0CEh, 0D6h, 0F8h, 0F2h, 9Eh, 0F9h, 0F1h ; 0a2b3
	ASCII "9" ; 0a2ba
	DB 0CEh, 0D1h, 1Eh, 1Bh, 0CEh, 0BCh, 25h, 0E6h ; 0a2bb
	DB 16h, 0CEh, 0D0h, 12h, 1Bh ; 0a2c3
	ASCII "1" ; 0a2c8
	DB 0E6h, 08h, 88h, 0CEh, 0D4h, 12h, 1Bh, 0F1h ; 0a2c9
	DB 22h, 0C4h, 97h, 92h, 0F2h, 0A6h, 06h, 0F8h ; 0a2d1
	DB 0CEh, 0D0h, 12h, 1Bh ; 0a2d9
	ASCII "1" ; 0a2dd
	DB 0E5h, 08h, 80h, 0CEh, 0D4h, 12h, 1Bh, 0F1h ; 0a2de
	DB 0Dh, 0B0h, 14h, 0CEh, 0D4h, 1Eh, 1Bh, 0C4h ; 0a2e6
	DB 2Eh, 92h, 0F2h, 8Bh, 06h, 0B8h, 12h, 1Bh ; 0a2ee
	DB 0F2h, 8Ah, 0D6h, 0F8h, 0F2h ; 0a2f6
	ASCII "Z" ; 0a2fb
	DB 0F9h, 0F1h ; 0a2fc
	ASCII "H" ; 0a2fe
	DB 0C5h, 12h, 1Bh, 0CEh, 0D1h, 1Eh, 1Bh, 0CEh ; 0a2ff
	DB 0BCh, 25h, 0E6h, 1Ch ; 0a307
	ASCII "E1" ; 0a30b
	DB 0E6h, 11h, 0F2h, 0C9h, 08h, 0CEh, 14h ; 0a30d
	ASCII "E" ; 0a314
	DB 0CEh, 0D1h, 1Eh, 1Bh ; 0a315
	ASCII "1" ; 0a319
	DB 0E5h, 2Bh ; 0a31a
	ASCII "i" ; 0a31c
	DB 0F1h, 28h, 0C4h, 97h, 92h, 0F2h ; 0a31d
	ASCII "Y" ; 0a323
	DB 06h, 0F8h ; 0a324
	ASCII "E1" ; 0a326
	DB 0E5h, 11h, 0F2h, 0AEh, 08h, 0CEh, 04h ; 0a328
	ASCII "E" ; 0a32f
	DB 0CEh, 0D1h, 1Eh, 1Bh ; 0a330
	ASCII "1" ; 0a334
	DB 0E4h, 10h ; 0a335
	ASCII "i" ; 0a337
	DB 0F1h, 0Dh, 0B0h, 14h, 0CEh, 0D4h, 1Eh, 1Bh ; 0a338
	DB 0C4h ; 0a340
	ASCII "l" ; 0a341
	DB 92h, 0F2h ; 0a342
	ASCII "8" ; 0a344
	DB 06h, 0B8h, 12h, 1Bh, 0F2h ; 0a345
	ASCII "7" ; 0a34a
	DB 0D6h, 0F8h, 0F2h, 07h, 0F9h, 0F1h ; 0a34b
	ASCII "5" ; 0a351
	DB 0CEh, 0D0h, 12h, 1Bh, 88h, 0CEh, 0D4h, 12h ; 0a352
	DB 1Bh ; 0a35a
	ASCII "2" ; 0a35b
	DB 06h, 0E6h, 2Fh ; 0a35c
	ASCII "2" ; 0a35f
	DB 0Fh, 0E5h, 13h ; 0a360
	ASCII "2" ; 0a363
	DB 0Dh, 0E5h, 0Ah, 0CEh, 0D0h, 13h, 1Bh, 80h ; 0a364
	DB 0CEh, 0D4h, 13h, 1Bh, 0C4h, 2Dh, 93h, 0F1h ; 0a36c
	DB 0Fh, 0CEh, 0D0h, 13h, 1Bh, 88h, 0CEh, 0D4h ; 0a374
	DB 13h, 1Bh, 0C4h, 0ABh, 92h, 0F1h, 01h, 0F2h ; 0a37c
	DB 0F8h, 05h, 0B8h, 12h, 1Bh, 0F2h, 0F7h, 0D5h ; 0a384
	DB 0F8h, 0C4h, 0B4h, 92h, 0F2h, 0EBh, 05h, 0F8h ; 0a38c
	DB 0F2h, 0C0h, 0F8h, 0F1h, 3Ch, 0CEh, 0D0h, 12h ; 0a394
	DB 1Bh, 88h, 0CEh, 0D4h, 12h, 1Bh ; 0a39c
	ASCII "2" ; 0a3a2
	DB 06h, 0E6h ; 0a3a3
	ASCII "62" ; 0a3a5
	DB 0Fh, 0E5h, 19h ; 0a3a7
	ASCII "2" ; 0a3aa
	DB 0Dh, 0E5h, 10h, 0CEh, 0D0h, 13h, 1Bh, 80h ; 0a3ab
	DB 80h, 0CEh, 0D4h, 13h, 1Bh, 0C4h ; 0a3b3
	ASCII "D" ; 0a3b9
	DB 83h, 0F1h, 15h, 0C4h ; 0a3ba
	ASCII "3" ; 0a3be
	DB 93h, 0F1h, 10h, 0CEh, 0D0h, 13h, 1Bh, 88h ; 0a3bf
	DB 88h, 0CEh, 0D4h, 13h, 1Bh, 0C4h, 0F8h, 8Dh ; 0a3c7
	DB 0F1h, 01h, 0F2h, 0AAh, 05h, 0B8h, 12h, 1Bh ; 0a3cf
	DB 0F2h, 0A9h, 0D5h, 0F8h, 0C4h, 0DBh, 92h, 0F2h ; 0a3d7
	DB 9Dh, 05h, 0F8h, 0F2h ; 0a3df
	ASCII "r" ; 0a3e3
	DB 0F8h, 0F1h, 3Bh, 0CEh, 0D0h, 12h, 1Bh, 88h ; 0a3e4
	DB 88h, 0CEh, 0D4h, 12h, 1Bh ; 0a3ec
	ASCII "2" ; 0a3f1
	DB 06h, 0E6h ; 0a3f2
	ASCII "42" ; 0a3f4
	DB 0Fh, 0E5h, 18h ; 0a3f6
	ASCII "2" ; 0a3f9
	DB 0Dh, 0E5h, 0Fh, 0CEh, 0D0h, 13h, 1Bh, 80h ; 0a3fa
	DB 0CEh, 0D4h, 13h, 1Bh, 0C4h, 21h, 93h, 0F1h ; 0a402
	DB 14h, 0C4h, 1Bh, 93h, 0F1h, 0Fh, 0CEh, 0D0h ; 0a40a
	DB 13h, 1Bh, 88h, 0CEh, 0D4h, 13h, 1Bh, 0C4h ; 0a412
	DB 0FEh, 92h, 0F1h, 01h, 0F2h, 5Dh, 05h, 0B8h ; 0a41a
	DB 12h, 1Bh, 0F2h, 5Ch, 0D5h, 0F8h, 0C4h, 07h ; 0a422
	DB 93h, 0F2h ; 0a42a
	ASCII "P" ; 0a42c
	DB 05h, 0F8h, 0F2h, 25h, 0F8h, 0F1h, 26h, 0CEh ; 0a42d
	DB 0D0h, 12h, 1Bh, 88h, 0CEh, 0D4h, 12h, 1Bh ; 0a435
	ASCII "2" ; 0a43d
	DB 0F0h, 0E6h, 12h, 0C5h, 13h, 1Bh, 96h, 80h ; 0a43e
	DB 0E7h, 05h ; 0a446
	ASCII "2" ; 0a448
	DB 02h, 0E5h, 04h, 86h, 0F1h, 0Bh, 8Eh, 0F1h ; 0a449
	DB 08h, 0C4h ; 0a451
	ASCII "9" ; 0a453
	DB 93h, 0F2h, 26h, 05h, 0F8h, 0B8h, 12h, 1Bh ; 0a454
	DB 0F2h, 24h, 0D5h, 0F8h, 0F2h, 0F4h, 0F7h, 0F1h ; 0a45c
	DB 23h, 0CEh, 0D0h, 12h, 1Bh, 88h, 0CEh, 0D4h ; 0a464
	DB 12h, 1Bh ; 0a46c
	ASCII "2" ; 0a46e
	DB 0F0h, 0E6h, 0Fh, 0CEh, 0D0h ; 0a46f
	ASCII "q" ; 0a474
	DB 16h, 22h, 01h, 0E6h, 0Eh, 0C5h, 13h, 1Bh ; 0a475
	DB 8Eh, 0F1h, 08h, 0C4h ; 0a47d
	ASCII "9" ; 0a481
	DB 93h, 0F2h, 0F8h, 04h, 0F8h, 0B8h, 12h, 1Bh ; 0a482
	DB 0F2h, 0F6h, 0D4h, 0F8h, 0F2h, 0C6h, 0F7h, 0F1h ; 0a48a
	DB 24h, 0CEh, 0D0h, 12h, 1Bh, 88h, 88h, 0CEh ; 0a492
	DB 0D4h, 12h, 1Bh ; 0a49a
	ASCII "2" ; 0a49d
	DB 0F0h, 0E6h, 0Fh, 0CEh, 0D0h ; 0a49e
	ASCII "q" ; 0a4a3
	DB 16h, 22h, 01h, 0E7h, 0Eh, 0C5h, 13h, 1Bh ; 0a4a4
	DB 8Eh, 0F1h, 08h, 0C4h ; 0a4ac
	ASCII "9" ; 0a4b0
	DB 93h, 0F2h, 0C9h, 04h, 0F8h, 0B8h, 12h, 1Bh ; 0a4b1
	DB 0F2h, 0C7h, 0D4h, 0F8h, 0FFh, 0F2h, 96h, 0F7h ; 0a4b9
	DB 0F1h ; 0a4c1
	ASCII "9" ; 0a4c2
	DB 0F2h, 0C2h, 0FCh, 0CEh, 0D0h, 12h, 1Bh ; 0a4c3
	ASCII "2" ; 0a4ca
	DB 1Fh, 0E6h, 2Eh, 0E5h, 12h ; 0a4cb
	ASCII "H" ; 0a4d0
	DB 0B0h, 1Fh, 11h, 0CEh, 8Ch, 28h, 0E7h, 02h ; 0a4d1
	DB 80h, 01h, 0CEh, 0D4h, 12h, 1Bh, 0F1h, 15h ; 0a4d9
	DB 12h, 1Fh, 0CEh, 8Ch, 28h, 0E7h, 02h, 80h ; 0a4e1
	ASCII "H" ; 0a4e9
	DB 0CEh, 0D0h, 12h, 1Bh, 11h, 0CEh, 0D4h, 12h ; 0a4ea
	DB 1Bh, 0F1h, 01h, 0B8h, 12h, 1Bh, 0F2h, 88h ; 0a4f2
	DB 0D4h, 0F8h, 0F2h ; 0a4fa
	ASCII "X" ; 0a4fd
	DB 0F7h, 0F1h ; 0a4fe
	ASCII "8" ; 0a500
	DB 0F2h ; 0a501
	ASCII "C" ; 0a502
	DB 05h, 0E7h, 08h, 0C4h ; 0a503
	ASCII "5" ; 0a507
	DB 83h, 0F2h ; 0a508
	ASCII "r" ; 0a50a
	DB 04h, 0F8h, 0CEh, 0D0h, 15h, 1Bh ; 0a50b
	ASCII "2" ; 0a511
	DB 07h, 0E7h, 24h, 0B0h, 0Ah, 0CEh, 0D4h, 26h ; 0a512
	DB 1Bh, 0B0h, 06h, 0CEh, 0D4h, 24h, 1Bh ; 0a51a
	ASCII "8" ; 0a521
	DB 0CEh, 0D4h, 25h, 1Bh, 0B0h, 00h, 0CEh, 0D4h ; 0a522
	DB 27h, 1Bh, 0C4h, 0C4h, 97h, 0F2h ; 0a52a
	ASCII "L" ; 0a530
	DB 04h, 0C4h, 10h, 0A6h, 0F2h, 11h, 0D4h, 0F8h ; 0a531
	DB 0F2h, 1Bh, 0F7h, 0F1h ; 0a539
	ASCII "c" ; 0a53d
	DB 0F2h, 06h, 05h, 0E6h ; 0a53e
	ASCII "W" ; 0a542
	DB 0F2h, 90h, 01h, 0CEh, 40h, 14h, 0CEh ; 0a543
	ASCII "H" ; 0a54a
	DB 15h, 0D4h ; 0a54b
	ASCII "4" ; 0a54d
	DB 0B4h, 0E6h ; 0a54e
	ASCII "I" ; 0a550
	DB 0C5h, 26h, 1Bh, 8Eh, 0E7h ; 0a551
	ASCII "J" ; 0a556
	DB 0C5h, 27h, 1Bh ; 0a557
	ASCII "E(" ; 0a55a
	DB 0E6h, 25h, 8Eh, 0B0h, 06h, 0CEh, 0D4h, 26h ; 0a55c
	DB 1Bh, 0CEh, 0D4h, 24h, 1Bh ; 0a564
	ASCII "8" ; 0a569
	DB 0CEh, 0D4h, 25h, 1Bh, 0C4h, 0A1h, 0A5h, 0F2h ; 0a56a
	DB 0D5h, 0D3h, 0C5h, 13h, 1Bh, 0CEh, 05h, 01h ; 0a572
	DB 0B8h, 12h, 1Bh, 0F2h, 03h, 0D4h, 0F1h, 1Fh ; 0a57a
	DB 0B0h, 06h, 0CEh, 0D4h, 26h, 1Bh, 0CEh, 0D4h ; 0a582
	DB 24h, 1Bh ; 0a58a
	ASCII "8" ; 0a58c
	DB 0CEh, 0D4h, 25h, 1Bh, 0C4h, 10h, 0A6h, 0F2h ; 0a58d
	DB 0B2h, 0D3h, 0F1h, 08h, 0C4h, 0EEh, 97h, 0F2h ; 0a595
	DB 0DFh, 03h, 0F8h, 0F8h, 0F2h, 0B3h, 0F6h, 0F1h ; 0a59d
	ASCII "j" ; 0a5a5
	DB 0CEh, 0D0h, 27h, 1Bh ; 0a5a6
	ASCII "2" ; 0a5aa
	DB 02h, 0E6h, 3Bh, 0F2h, 25h, 01h, 0CEh, 40h ; 0a5ab
	DB 14h, 0CEh ; 0a5b3
	ASCII "H" ; 0a5b5
	DB 15h, 0D4h ; 0a5b6
	ASCII "4" ; 0a5b8
	DB 0B4h, 0E7h, 2Dh, 0B0h, 02h, 0CEh, 0D4h, 27h ; 0a5b9
	DB 1Bh, 0CEh, 0D0h, 24h, 1Bh, 0C5h, 26h, 1Bh ; 0a5c1
	DB 13h, 96h, 80h, 0E6h, 02h ; 0a5c9
	ASCIZ "8" ; 0a5ce
	DB 0CEh, 0D4h, 25h, 1Bh, 02h, 0Fh, 0CEh, 0D4h ; 0a5d0
	DB 26h, 1Bh, 0C4h ; 0a5d8
	ASCII "w" ; 0a5db
	DB 0A6h, 0F2h ; 0a5dc
	ASCII "i" ; 0a5de
	DB 0D3h, 0C4h, 0CEh, 97h, 0F2h, 98h, 03h, 0F1h ; 0a5df
	DB 28h, 0C5h, 26h, 1Bh, 8Eh, 0E7h, 22h, 0B0h ; 0a5e7
	DB 06h, 0CEh, 0D4h, 26h, 1Bh, 0CEh, 0D4h, 24h ; 0a5ef
	DB 1Bh ; 0a5f7
	ASCII "8" ; 0a5f8
	DB 0CEh, 0D4h, 25h, 1Bh, 0C4h, 10h, 0A6h, 0F2h ; 0a5f9
	ASCII "F" ; 0a601
	DB 0D3h, 0C5h, 13h, 1Bh, 0CEh, 15h, 01h, 0B8h ; 0a602
	DB 12h, 1Bh, 0F2h ; 0a60a
	ASCII "t" ; 0a60d
	DB 0D3h, 0F8h, 0F2h ; 0a60e
	ASCII "D" ; 0a611
	DB 0F6h, 0F1h ; 0a612
	ASCII "b" ; 0a614
	DB 0CEh, 0D0h, 27h, 1Bh ; 0a615
	ASCIZ "2" ; 0a619
	DB 0E7h, 2Dh, 0F2h, 0B6h, 00h, 0CEh, 40h, 14h ; 0a61b
	DB 0CEh ; 0a623
	ASCII "H" ; 0a624
	DB 15h, 0D4h ; 0a625
	ASCII "4" ; 0a627
	DB 0B4h, 0E7h, 1Fh, 0B0h, 01h, 0CEh, 0D4h, 27h ; 0a628
	DB 1Bh, 0CEh, 0D0h, 24h, 1Bh, 0C5h, 26h, 1Bh ; 0a630
	DB 13h, 0E5h, 02h ; 0a638
	ASCIZ "8" ; 0a63b
	DB 0CEh, 0D4h, 25h, 1Bh, 0C4h, 0CEh, 97h, 0F2h ; 0a63d
	ASCII "7" ; 0a645
	DB 03h, 0F1h, 0Eh, 0C5h, 26h, 1Bh, 8Eh, 0E7h ; 0a646
	DB 28h, 0CEh, 0D0h, 27h, 1Bh, 28h, 0E6h, 1Bh ; 0a64e
	DB 0CEh, 0D0h, 25h, 1Bh, 02h, 00h ; 0a656
	ASCII "2" ; 0a65c
	DB 08h, 0E5h, 05h, 0B0h, 08h, 0F1h, 01h, 0CEh ; 0a65d
	DB 0D4h, 26h, 1Bh, 0C4h ; 0a665
	ASCII "w" ; 0a669
	DB 0A6h, 0F2h, 0DBh, 0D2h, 0F1h, 07h, 0C4h ; 0a66a
	ASCII "j" ; 0a671
	DB 97h, 0F2h, 08h, 03h, 0F8h, 0F2h, 0DDh, 0F5h ; 0a672
	DB 0F1h, 1Ah, 0F2h ; 0a67a
	ASCIZ "W" ; 0a67d
	DB 0C5h, 26h, 1Bh, 8Eh, 0E6h, 12h, 0CEh, 0D0h ; 0a67f
	ASCII "q" ; 0a687
	DB 16h, 22h, 01h, 0C5h, 13h, 1Bh, 8Eh, 0B8h ; 0a688
	DB 12h, 1Bh, 0F2h, 0EEh, 0D2h, 0F8h, 0C4h, 0DEh ; 0a690
	DB 97h, 0F2h, 0E2h, 02h, 0F8h, 0F2h, 0B7h, 0F5h ; 0a698
	DB 0F1h ; 0a6a0
	ASCII "0" ; 0a6a1
	DB 0F2h ; 0a6a2
	ASCIZ "1" ; 0a6a3
	DB 0C5h, 13h, 1Bh ; 0a6a5
	ASCII "E2#" ; 0a6a8
	DB 0E6h, 0Fh, 0CEh, 0D0h ; 0a6ab
	ASCII "q" ; 0a6af
	DB 16h, 22h, 01h, 86h, 0B8h, 12h, 1Bh, 0F2h ; 0a6b0
	DB 0C9h, 0D2h, 0F8h, 0B1h, 04h, 0CEh, 0D0h, 27h ; 0a6b8
	DB 1Bh ; 0a6c0
	ASCII "2" ; 0a6c1
	DB 02h, 0E7h, 03h, 0B1h, 02h, 0CEh, 0D5h, 26h ; 0a6c2
	DB 1Bh, 0C4h ; 0a6ca
	ASCII "9" ; 0a6cc
	DB 0A5h, 0F2h ; 0a6cd
	ASCII "x" ; 0a6cf
	DB 0D2h, 0F8h, 0F3h, 0A4h, 0FAh, 0CEh, 0D0h ; 0a6d0
	ASCII "B" ; 0a6d7
	DB 16h, 96h, 01h, 0E7h, 22h, 0CEh, 40h, 14h ; 0a6d8
	DB 0CEh ; 0a6e0
	ASCII "H" ; 0a6e1
	DB 15h, 0D4h, 2Ch, 0B4h, 0E6h, 06h, 0D4h ; 0a6e2
	ASCII "0" ; 0a6e9
	DB 0B4h, 0E7h, 2Eh, 0C4h, 0D4h, 97h, 0F2h, 8Bh ; 0a6ea
	DB 02h, 0C4h ; 0a6f2
	ASCII "4" ; 0a6f4
	DB 0B4h, 0CEh ; 0a6f5
	ASCII "D" ; 0a6f7
	DB 14h, 0CEh ; 0a6f8
	ASCII "L" ; 0a6fa
	DB 15h, 0F1h, 1Dh, 0CEh, 40h, 14h, 0CEh ; 0a6fb
	ASCII "H" ; 0a702
	DB 15h, 0D4h ; 0a703
	ASCII "4" ; 0a705
	DB 0B4h, 0E6h, 12h, 0CEh, 40h, 18h, 0CEh ; 0a706
	ASCII "H" ; 0a70d
	DB 19h, 0D4h, 0C4h, 97h, 0E6h, 07h, 0C4h, 0C4h ; 0a70e
	DB 97h, 0F2h ; 0a716
	ASCII "d" ; 0a718
	DB 02h, 0F8h, 0CEh, 0D0h ; 0a719
	ASCII "f" ; 0a71d
	DB 1Bh, 28h, 0E7h, 14h, 0C5h ; 0a71e
	ASCII "g" ; 0a723
	DB 1Bh, 86h ; 0a724
	ASCII "E2d" ; 0a726
	DB 0E4h, 29h, 0B5h, 00h, 0B0h, 01h, 0CEh, 0D4h ; 0a729
	ASCII "f" ; 0a731
	DB 1Bh, 0F1h, 1Fh, 0C5h ; 0a732
	ASCII "g" ; 0a736
	DB 1Bh, 0CEh, 0D0h ; 0a737
	ASCII "h" ; 0a73a
	DB 1Bh ; 0a73b
	ASCII "3" ; 0a73c
	DB 0E6h, 04h, 86h, 0F1h, 12h, 0CEh, 0D0h ; 0a73d
	ASCII "f" ; 0a744
	DB 1Bh, 0CEh, 0D1h ; 0a745
	ASCII "i" ; 0a748
	DB 1Bh ; 0a749
	ASCII "1" ; 0a74a
	DB 0E6h, 26h, 0C5h ; 0a74b
	ASCII "f" ; 0a74e
	DB 1Bh, 86h, 0F1h, 01h, 0CEh, 0D0h ; 0a74f
	ASCII "g" ; 0a755
	DB 1Bh, 0F2h, 1Ch, 7Eh, 02h, 40h, 0CEh, 0D4h ; 0a756
	ASCII "d" ; 0a75e
	DB 1Bh ; 0a75f
	ASCII "A" ; 0a760
	DB 02h, 40h, 0CEh, 0D4h, 60h, 1Bh, 0CEh, 0D0h ; 0a761
	ASCII "f" ; 0a769
	DB 1Bh, 02h, 40h, 0CEh, 0D4h, 5Ch, 1Bh, 0F8h ; 0a76a
	DB 0F2h, 0E2h, 04h, 0E7h, 19h, 0CEh, 0D0h ; 0a772
	ASCII "i" ; 0a779
	DB 1Bh ; 0a77a
	ASCII "2" ; 0a77b
	DB 09h, 0E7h, 11h, 0C5h, 0BAh, 96h, 0B1h, 03h ; 0a77c
	DB 0A3h, 0F2h, 08h, 7Bh, 0ABh, 0B4h, 20h, 0D8h ; 0a784
	DB 26h, 0BFh, 0F8h, 0CEh, 0D0h ; 0a78c
	ASCII "C" ; 0a791
	DB 16h, 96h, 01h, 0E6h, 0BDh, 0CEh, 0D0h, 0B6h ; 0a792
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h ; 0a79a
	DB 0FAh, 14h, 0F2h, 0B0h, 04h, 0E7h, 2Bh, 0CEh ; 0a7a2
	DB 0D0h, 0D7h, 1Ah ; 0a7aa
	ASCIZ "2" ; 0a7ad
	DB 0E6h, 0Ah ; 0a7af
	ASCII "2" ; 0a7b1
	DB 01h, 0E6h, 0Bh, 0C5h, 0D6h, 99h, 0F1h, 09h ; 0a7b2
	DB 0C5h ; 0a7ba
	ASCII "E" ; 0a7bb
	DB 93h, 0F1h, 04h, 0C5h, 5Eh, 95h, 0CFh, 0E1h ; 0a7bc
	DB 0F2h, 0B7h, 01h, 0B0h, 01h, 0CEh ; 0a7c4
	ASCII "D" ; 0a7ca
	DB 16h, 0B8h, 12h, 1Bh, 0F2h, 0B1h, 0D1h, 0F8h ; 0a7cb
	DB 0C5h, 0BAh, 96h, 0B1h, 03h, 0A3h, 0F2h, 0B4h ; 0a7d3
	ASCII "z" ; 0a7db
	DB 0ABh, 0B4h, 20h, 0D8h, 26h, 0BFh, 0F8h, 0B0h ; 0a7dc
	DB 00h, 0CEh, 0D4h, 20h, 1Bh, 0F2h, 0D2h, 0F5h ; 0a7e4
	DB 0F1h, 0Dh, 0F2h, 0A9h, 0F4h, 0F1h, 08h, 0F2h ; 0a7ec
	DB 8Bh, 0F4h, 0F1h, 03h, 0F1h, 0Ah, 0B0h, 24h ; 0a7f4
	DB 0CEh, 0D4h, 1Bh, 1Bh, 0F3h, 0EFh, 00h, 0C5h ; 0a7fc
	DB 1Bh, 1Bh ; 0a804
	ASCII "E(" ; 0a806
	DB 0E6h, 05h, 8Eh, 0EFh, 8Dh, 00h, 0CEh, 0D0h ; 0a808
	DB 0DCh, 1Ah ; 0a810
	ASCII "2" ; 0a812
	DB 02h, 0E6h ; 0a813
	ASCII "1" ; 0a815
	DB 0A6h, 0A2h, 0C6h, 0AAh, 15h, 0CEh, 0C6h, 00h ; 0a816
	DB 0F2h, 0E6h, 9Eh, 0CEh, 0D0h, 0ADh, 15h, 0AAh ; 0a81e
	DB 0AEh ; 0a826
	ASCII "2" ; 0a827
	DB 06h, 0E4h, 05h ; 0a828
	ASCII "2" ; 0a82b
	DB 12h, 0E4h, 18h, 0C4h, 0Ah, 00h, 0CEh, 0C4h ; 0a82c
	DB 03h, 0F2h, 0C7h, 0E7h, 28h, 0E7h, 0Ch, 0B0h ; 0a834
	DB 24h, 0CEh, 0D4h, 1Bh, 1Bh, 0C4h, 0E0h, 8Bh ; 0a83c
	DB 0F1h ; 0a844
	ASCII "R" ; 0a845
	DB 0CEh, 0D0h, 0DCh, 1Ah ; 0a846
	ASCIZ "2" ; 0a84a
	DB 0E7h, 13h, 0C4h, 0Ah, 00h, 0CEh, 0C4h, 03h ; 0a84c
	DB 0F2h, 0A8h, 0E7h, 28h, 0E7h, 07h, 0CEh, 0C4h ; 0a854
	DB 02h, 0F2h, 3Fh, 01h, 0A6h, 0A3h, 0C7h, 0F8h ; 0a85c
	DB 0A8h, 0CEh, 0C7h, 00h, 0CEh, 0D0h, 0DCh, 1Ah ; 0a864
	DB 00h, 0B1h, 00h, 0CFh ; 0a86c
	ASCII "B" ; 0a870
	DB 0CFh, 0DBh, 0C4h, 0Ah, 00h, 0CEh, 0C4h, 03h ; 0a871
	DB 0F2h, 83h, 0E7h ; 0a879
	ASCIZ "H" ; 0a87c
	DB 01h, 0B1h, 00h, 0CFh ; 0a87e
	ASCII "BG" ; 0a882
	DB 93h, 0CEh, 0D4h, 1Bh, 1Bh, 0CFh, 0D8h, 0ABh ; 0a884
	DB 0AEh, 0CEh ; 0a88c
	ASCII "P" ; 0a88e
	DB 18h, 0CEh ; 0a88f
	ASCII "X" ; 0a891
	DB 19h, 0CFh ; 0a892
	ASCII "8" ; 0a894
	DB 0E6h, 04h, 0F2h, 0E4h, 00h, 0CEh ; 0a895
	ASCII "P" ; 0a89b
	DB 18h, 0CEh ; 0a89c
	ASCII "X" ; 0a89e
	DB 19h, 0D5h, 0D2h, 80h, 0E6h, 3Fh, 0D5h, 26h ; 0a89f
	DB 81h, 0E6h, 20h, 0D5h, 2Ah, 80h, 0E6h, 11h ; 0a8a7
	DB 0D5h, 7Eh, 80h, 0E7h, 3Eh, 0C5h, 12h, 1Bh ; 0a8af
	ASCII "E2P" ; 0a8b7
	DB 0E5h ; 0a8ba
	ASCII "6" ; 0a8bb
	DB 86h, 0F1h, 1Ah, 0C5h, 12h, 1Bh ; 0a8bc
	ASCII "E(" ; 0a8c2
	DB 0E6h, 2Ch, 8Eh, 0F1h, 29h, 0C5h, 12h, 1Bh ; 0a8c4
	DB 0F2h, 0Ch, 03h, 0CEh, 04h ; 0a8cc
	ASCII "E2P" ; 0a8d1
	DB 0E4h, 03h, 0B5h ; 0a8d4
	ASCII "P" ; 0a8d7
	DB 0F2h, 88h, 01h, 0E6h, 15h, 0CEh, 0D5h, 12h ; 0a8d8
	DB 1Bh, 0F1h, 0Fh, 0C5h, 12h, 1Bh, 0F2h, 0F2h ; 0a8e0
	DB 02h, 0CEh, 14h, 0E5h, 05h, 0B5h, 00h, 0F1h ; 0a8e8
	DB 01h, 0B8h, 12h, 1Bh, 0F2h, 8Ch, 0D0h, 0F8h ; 0a8f0
	DB 0FEh, 0A8h, 25h, 0A9h ; 0a8f8
	ASCII "L" ; 0a8fc
	DB 0A9h, 0Ah, 1Ah, 80h, 05h, 0D2h, 80h, 05h ; 0a8fd
	DB 26h, 81h ; 0a905
	ASCII "L" ; 0a907
	DB 8Ch, 86h, 0D5h, 24h, 87h ; 0a908
	ASCII "n" ; 0a90d
	DB 0CEh, 87h, 0C6h, 24h, 88h, 0D8h, 0D4h, 88h ; 0a90e
	DB 24h, 0A4h, 8Ah, 5Eh, 0CCh, 89h ; 0a916
	ASCII "NT" ; 0a91c
	DB 8Bh, 05h, 0D2h, 80h, 05h, 26h, 81h, 0Ah ; 0a91e
	DB 1Ah, 80h, 0Ah, 2Ah, 80h, 0Ah, 7Eh, 80h ; 0a926
	ASCII "L" ; 0a92e
	DB 8Ch, 86h, 0D5h, 24h, 87h ; 0a92f
	ASCII "n" ; 0a934
	DB 0CEh, 87h, 0Ah, 2Ah, 80h, 0Ah, 7Eh, 80h ; 0a935
	DB 24h, 0A4h, 8Ah, 0Ah, 1Ah, 80h ; 0a93d
	ASCII "NT" ; 0a943
	DB 8Bh, 0Ah, 2Ah, 80h, 0Ah, 7Eh, 80h, 0Ah ; 0a945
	DB 0D9h, 81h, 0Ah, 0D9h, 81h, 0Ah, 0D9h, 81h ; 0a94d
	DB 0Ah, 0D9h, 81h, 0Ah, 0D9h, 81h, 0Ah, 0D9h ; 0a955
	DB 81h, 0Ah, 0D9h, 81h, 0Ah, 0D9h, 81h, 0Ah ; 0a95d
	DB 0D9h, 81h, 0Ah, 0D9h, 81h, 0Ah, 0D9h, 81h ; 0a965
	DB 0Ah, 0D9h, 81h, 0Ah, 0D9h, 81h, 0CEh ; 0a96d
	ASCII "D" ; 0a974
	DB 1Ah, 0CEh ; 0a975
	ASCII "L" ; 0a977
	DB 1Bh, 0F2h, 0D4h, 0CFh, 0F8h, 0CEh ; 0a978
	ASCII "D" ; 0a97e
	DB 18h, 0CEh ; 0a97f
	ASCII "L" ; 0a981
	DB 19h, 0F2h, 0CAh, 0CFh, 0F8h, 0CEh, 0D0h ; 0a982
	ASCII "C" ; 0a989
	DB 16h, 96h, 02h, 0E6h, 07h, 0C4h, 0Eh, 80h ; 0a98a
	DB 0F2h, 0E9h, 0FFh, 0F8h, 0BEh ; 0a992
	ASCII "7" ; 0a997
	DB 1Bh, 0CEh, 0D0h, 12h, 1Bh ; 0a998
	ASCII "2P" ; 0a99d
	DB 0E4h, 0Dh, 0B1h ; 0a99f
	ASCII "P2" ; 0a9a2
	DB 80h, 0E4h, 03h, 0B1h, 00h, 0CEh, 0D5h, 12h ; 0a9a4
	DB 1Bh, 0CEh, 0D0h, 13h, 1Bh ; 0a9ac
	ASCII "20" ; 0a9b1
	DB 0E4h, 0Dh, 0B1h ; 0a9b3
	ASCII "02" ; 0a9b6
	DB 80h, 0E4h, 03h, 0B1h, 00h, 0CEh, 0D5h, 13h ; 0a9b8
	DB 1Bh, 0C4h, 0Eh, 80h, 0F2h, 0B7h, 0FFh, 0CEh ; 0a9c0
	DB 0D0h, 2Ah, 1Bh, 28h, 0E6h, 08h, 0C4h, 12h ; 0a9c8
	DB 8Dh, 0F2h, 0AAh, 0FFh, 0F8h, 0CEh, 0D0h, 2Bh ; 0a9d0
	DB 1Bh, 28h, 0E7h, 2Ch, 0CEh, 0D0h, 14h, 1Bh ; 0a9d8
	DB 28h, 0E6h, 08h, 0C4h, 0Fh, 0ADh, 0F2h, 8Bh ; 0a9e0
	DB 0FFh, 0F8h, 0CEh, 0D0h ; 0a9e8
	ASCII "i" ; 0a9ec
	DB 1Bh ; 0a9ed
	ASCII "2" ; 0a9ee
	DB 0FFh, 0E6h, 23h, 0CEh, 0D0h, 0E8h, 1Ah ; 0a9ef
	ASCII "2" ; 0a9f6
	DB 0FFh, 0E7h, 0Dh, 0C4h ; 0a9f7
	ASCII "L%" ; 0a9fb
	DB 0BCh, 12h, 1Bh, 0C4h ; 0a9fd
	ASCII "X" ; 0aa01
	DB 86h, 0F2h ; 0aa02
	ASCII "x" ; 0aa04
	DB 0FFh, 0F8h, 0B0h, 01h, 0CEh, 0D4h, 14h, 1Bh ; 0aa05
	DB 0C4h, 0F7h, 0B6h, 0F2h ; 0aa0d
	ASCII "a" ; 0aa11
	DB 0FFh, 0F8h ; 0aa12
	ASCII "8" ; 0aa14
	DB 0CEh, 0D4h ; 0aa15
	ASCII "i" ; 0aa17
	DB 1Bh, 0C5h ; 0aa18
	ASCII "E" ; 0aa1a
	DB 93h, 0CEh, 0D0h, 0D7h, 1Ah ; 0aa1b
	ASCIZ "2" ; 0aa20
	DB 0E6h, 0Bh, 0C5h, 5Eh, 95h ; 0aa22
	ASCII "2" ; 0aa27
	DB 01h, 0E6h, 04h, 0C5h, 0D6h, 99h, 0CFh, 0E1h ; 0aa28
	DB 0F2h ; 0aa30
	ASCII "A" ; 0aa31
	DB 0FFh, 0F8h, 96h, 0A9h, 01h, 19h, 9Bh, 01h ; 0aa32
	DB 17h, 9Bh, 00h ; 0aa3a
	ASCII "q" ; 0aa3d
	DB 9Ah, 02h, 19h, 9Bh, 01h, 00h, 80h, 00h
; ---------------------- ; 0aa3e
loc_0x00AA46:
	LD A,[1ADBh] ; 0aa46
	OR A,A ; 0aa4a
	JRS Z,loc_0x00AA54 ; 0aa4b
	LD A,[1ADAh] ; 0aa4d
	OR A,A ; 0aa51
	JRS Z,loc_0x00AA54 ; 0aa52
loc_0x00AA54:
	RET
; ---------------------- ; 0aa54
loc_0x00AA55:
	CARL loc_0x00AA46 ; 0aa55
	JRS Z,loc_0x00AA5F ; 0aa58
	LD A,[1ADCh] ; 0aa5a
	RET
; ---------------------- ; 0aa5e
loc_0x00AA5F:
	LD A,#03h ; 0aa5f
	RET
; ---------------------- ; 0aa61
	DB 0B1h, 18h, 0B2h ; 0aa62
	ASCII "C" ; 0aa65
	DB 0CEh, 0D0h, 0D7h, 1Ah ; 0aa66
	ASCIZ "2" ; 0aa6a
	DB 0E6h, 0Dh, 0B1h, 10h, 0B2h, 40h ; 0aa6c
	ASCII "2" ; 0aa72
	DB 01h, 0E6h, 05h, 0B1h, 18h, 0B2h ; 0aa73
	ASCII "B" ; 0aa79
	DB 0CEh, 0D0h, 13h, 1Bh ; 0aa7a
	ASCII "1" ; 0aa7e
	DB 0E7h, 0Ch ; 0aa7f
	ASCII "J" ; 0aa81
	DB 0CEh, 0D0h, 12h, 1Bh ; 0aa82
	ASCII "1" ; 0aa86
	DB 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 0aa87
	DB 0CEh, 0D0h, 0D8h, 1Ah ; 0aa8f
	ASCIZ "2" ; 0aa93
	DB 0E7h ; 0aa95
	ASCII "3" ; 0aa96
	DB 0F2h, 0ADh, 0FFh, 0E6h, 2Eh, 0CEh, 0D0h, 0D7h ; 0aa97
	DB 1Ah ; 0aa9f
	ASCIZ "2" ; 0aaa0
	DB 0E6h, 0Fh ; 0aaa2
	ASCII "2" ; 0aaa4
	DB 01h, 0E7h, 22h, 0CEh, 0D0h, 13h, 1Bh ; 0aaa5
	ASCII "2#" ; 0aaac
	DB 0E7h, 1Ah, 0E6h, 09h, 0CEh, 0D0h, 13h, 1Bh ; 0aaae
	ASCII "2%" ; 0aab6
	DB 0E7h, 10h, 0CEh, 0D0h, 12h, 1Bh ; 0aab8
	ASCII "2" ; 0aabe
	DB 18h, 0E4h, 08h ; 0aabf
	ASCII "2." ; 0aac2
	DB 0E5h, 04h, 9Dh, 01h, 0F8h, 9Ch, 0FEh, 0F8h ; 0aac4
	DB 0CEh, 0D0h, 0D8h, 1Ah ; 0aacc
	ASCIZ "2" ; 0aad0
	DB 0E7h, 28h, 0F2h ; 0aad2
	ASCII "p" ; 0aad5
	DB 0FFh, 0E6h, 23h, 0CEh, 0D0h, 0D7h, 1Ah ; 0aad6
	ASCII "2" ; 0aadd
	DB 02h, 0E7h, 1Bh, 0CEh, 0D0h, 13h, 1Bh, 0CEh ; 0aade
	DB 0D1h, 23h, 1Bh ; 0aae6
	ASCII "1" ; 0aae9
	DB 0E7h, 10h, 0CEh, 0D0h, 12h, 1Bh ; 0aaea
	ASCII "2" ; 0aaf0
	DB 07h, 0E4h, 08h ; 0aaf1
	ASCII "2+" ; 0aaf4
	DB 0E5h, 04h, 9Dh, 01h, 0F8h, 9Ch, 0FEh, 0F8h ; 0aaf6
	DB 0F2h, 8Fh, 0FFh, 0E7h, 02h, 0F8h, 0CEh, 0D0h ; 0aafe
	DB 13h, 1Bh, 0CEh, 0D1h, 23h, 1Bh ; 0ab06
	ASCII "1" ; 0ab0c
	DB 0E7h, 04h, 9Dh, 01h, 0F8h, 0CEh, 0D0h, 0D8h ; 0ab0d
	DB 1Ah ; 0ab15
	ASCIZ "2" ; 0ab16
	DB 0E6h, 05h, 0F2h, 0A8h, 00h, 0F8h, 0CEh, 0D0h ; 0ab18
	DB 13h, 1Bh ; 0ab20
	ASCII "2" ; 0ab22
	DB 03h, 0E5h, 0Bh, 0CEh, 0D0h, 12h, 1Bh ; 0ab23
	ASCII "2<" ; 0ab2a
	DB 0E4h, 1Bh, 0F1h, 1Ch, 0CEh, 0D0h, 0D7h, 1Ah ; 0ab2c
	ASCIZ "2" ; 0ab34
	DB 0E6h, 09h ; 0ab36
	ASCII "2" ; 0ab38
	DB 01h, 0E6h, 09h, 0F2h, 5Eh, 00h, 0F8h, 0F2h ; 0ab39
	DB 0Ch, 00h, 0F8h, 0F2h ; 0ab41
	ASCIZ "4" ; 0ab45
	DB 0F8h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h, 0CEh ; 0ab47
	DB 0D0h, 13h, 1Bh ; 0ab4f
	ASCII "2" ; 0ab52
	DB 10h, 0E6h, 13h ; 0ab53
	ASCII "2" ; 0ab56
	DB 18h, 0E7h, 1Bh, 0CEh, 0D0h, 12h, 1Bh ; 0ab57
	ASCII "2&" ; 0ab5e
	DB 0E4h, 13h ; 0ab60
	ASCII "2D" ; 0ab62
	DB 0E4h, 12h, 0F1h, 0Dh, 0CEh, 0D0h, 12h, 1Bh ; 0ab64
	ASCII "2" ; 0ab6c
	DB 08h, 0E4h, 05h ; 0ab6d
	ASCII "20" ; 0ab70
	DB 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 0ab72
	DB 0CEh, 0D0h, 13h, 1Bh ; 0ab7a
	ASCII "2" ; 0ab7e
	DB 10h, 0E7h, 15h, 0CEh, 0D0h, 12h, 1Bh ; 0ab7f
	ASCII "2" ; 0ab86
	DB 15h, 0E4h, 10h, 0CEh, 0D0h, 12h, 1Bh ; 0ab87
	ASCII "2(" ; 0ab8e
	DB 0E4h, 05h ; 0ab90
	ASCII "2A" ; 0ab92
	DB 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 0ab94
	DB 0CEh, 0D0h, 13h, 1Bh ; 0ab9c
	ASCII "2" ; 0aba0
	DB 10h, 0E6h, 13h ; 0aba1
	ASCII "2" ; 0aba4
	DB 18h, 0E7h, 17h, 0CEh, 0D0h, 12h, 1Bh ; 0aba5
	ASCII "2 " ; 0abac
	DB 0E4h, 0Fh ; 0abae
	ASCII "2C" ; 0abb0
	DB 0E4h, 0Eh, 0F1h, 09h, 0CEh, 0D0h, 12h, 1Bh ; 0abb2
	ASCII "2" ; 0abba
	DB 15h, 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h ; 0abbb
	DB 0F8h, 0CEh, 0D0h, 13h, 1Bh ; 0abc3
	ASCII "2" ; 0abc8
	DB 18h, 0E7h, 09h, 0CEh, 0D0h, 12h, 1Bh ; 0abc9
	ASCII "2" ; 0abd0
	DB 18h, 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h ; 0abd1
	DB 0F8h, 0B1h, 02h, 0CEh, 0D0h ; 0abd9
	ASCII "q" ; 0abde
	DB 16h, 22h, 03h, 0E6h, 02h, 89h ; 0abdf
	ASCII "A" ; 0abe5
	DB 0F8h, 0CEh, 0D0h, 15h, 1Bh ; 0abe6
	ASCII "2" ; 0abeb
	DB 07h, 0E7h, 07h, 0B0h, 0FFh, 0CEh, 0D4h, 21h ; 0abec
	DB 1Bh, 0F2h, 81h, 0F5h, 0F8h, 0C5h, 21h, 1Bh ; 0abf4
	ASCII "E2" ; 0abfc
	DB 0FEh, 0E5h, 0Bh, 0CEh, 0D0h, 15h, 1Bh ; 0abfe
	ASCII "2" ; 0ac05
	DB 07h, 0E7h, 03h, 0B5h, 0FEh, 0F2h ; 0ac06
	ASCII "k" ; 0ac0c
	DB 0F5h, 0F8h, 0F2h ; 0ac0d
	ASCII "5" ; 0ac10
	DB 0FEh, 0E6h, 13h, 0CEh, 0D0h, 15h, 1Bh ; 0ac11
	ASCII "2" ; 0ac18
	DB 07h, 0E7h, 07h, 0C4h, 86h, 96h, 0F2h, 5Ch ; 0ac19
	DB 0FDh, 0F2h ; 0ac21
	ASCII "T" ; 0ac23
	DB 0F5h, 0F8h, 0C4h ; 0ac24
	ASCII "5" ; 0ac27
	DB 83h, 0F2h ; 0ac28
	ASCII "R" ; 0ac2a
	DB 0FDh, 0F8h, 0CEh, 0D0h, 15h, 1Bh ; 0ac2b
	ASCII "2" ; 0ac31
	DB 07h, 0E7h, 0Ch ; 0ac32
	ASCII "8" ; 0ac35
	DB 0CEh, 0D4h, 21h, 1Bh, 0C4h, 0A5h, 98h, 0F2h ; 0ac36
	DB 3Eh, 0FDh, 0F2h ; 0ac3e
	ASCII "6" ; 0ac41
	DB 0F5h, 0F8h, 0CEh, 0D0h, 15h, 1Bh ; 0ac42
	ASCII "2" ; 0ac48
	DB 07h, 0E7h, 07h, 0B0h, 0FFh, 0CEh, 0D4h, 21h ; 0ac49
	DB 1Bh, 0F2h, 24h, 0F5h, 0F8h, 0A6h, 0A3h, 0CEh ; 0ac51
	DB 0D0h ; 0ac59
	ASCII "i" ; 0ac5a
	DB 1Bh, 88h, 0B1h, 00h, 0C7h ; 0ac5b
	ASCII "p" ; 0ac60
	DB 0ACh, 0CEh, 0C7h, 00h, 0CFh ; 0ac61
	ASCII "B" ; 0ac66
	DB 0CEh, 0D0h, 0EAh, 1Ah, 27h, 3Fh, 0ABh, 0AEh ; 0ac67
	DB 0F8h, 01h, 03h, 07h, 0Fh, 1Fh, 3Fh, 7Fh ; 0ac6f
	DB 0FFh, 0FFh ; 0ac77
	ASCII "m" ; 0ac79
	DB 0ADh, 7Bh, 0A7h, 83h, 0ACh, 8Fh, 0ACh, 83h ; 0ac7a
	DB 0ACh, 04h, 00h ; 0ac82
	ASCII "X" ; 0ac85
	DB 0B9h, 04h, 00h, 60h, 0B9h, 0C1h, 99h, 9Bh ; 0ac86
	DB 0ACh, 04h, 00h, 0CCh, 0BCh, 04h, 00h, 0DCh ; 0ac8e
	DB 0BCh, 0C1h, 99h, 9Bh, 0ACh, 9Dh, 99h, 19h ; 0ac96
	DB 9Bh, 90h, 0ADh, 7Bh, 0A7h, 0EDh, 0ACh, 0CBh ; 0ac9e
	DB 0ACh, 0A9h, 0ACh, 0D6h, 99h, 1Fh, 00h, 10h ; 0aca6
	DB 00h, 02h, 00h ; 0acae
	ASCII "p" ; 0acb1
	DB 0BEh, 02h, 00h, 7Ch, 0BEh, 03h, 00h, 94h ; 0acb2
	DB 0BEh, 03h, 00h, 40h, 0BEh, 03h, 00h, 28h ; 0acba
	DB 0BEh, 03h, 00h, 40h, 0BEh, 0C1h, 99h, 0Fh ; 0acc2
	DB 0ADh, 0D6h, 99h, 1Bh, 00h, 10h, 00h, 02h ; 0acca
	DB 00h, 0E4h, 0BAh, 02h, 00h, 0F0h, 0BAh, 03h ; 0acd2
	DB 00h, 0Ch, 0BBh, 03h, 00h, 0ACh, 0BAh, 03h ; 0acda
	DB 00h, 90h, 0BAh, 03h, 00h, 0ACh, 0BAh, 0C1h ; 0ace2
	DB 99h, 0Fh, 0ADh, 0D6h, 99h, 21h, 00h, 10h ; 0acea
	DB 00h, 02h, 00h, 0D8h, 0B7h, 02h, 00h, 0E4h ; 0acf2
	DB 0B7h, 03h, 00h, 0FCh, 0B7h, 03h, 00h, 0A8h ; 0acfa
	DB 0B7h, 03h, 00h, 90h, 0B7h, 03h, 00h, 0A8h ; 0ad02
	DB 0B7h, 0C1h, 99h, 0Fh, 0ADh, 9Dh, 99h, 0A2h ; 0ad0a
	DB 0B0h ; 0ad12
	ASCII "P" ; 0ad13
	DB 0A9h, 7Bh, 0A7h ; 0ad14
	ASCII "A" ; 0ad17
	DB 0ADh, 2Fh, 0ADh, 1Dh, 0ADh, 0D6h, 99h, 1Fh ; 0ad18
	DB 00h, 10h, 00h, 0Ah, 00h, 28h, 0BEh, 0Ah ; 0ad20
	DB 00h, 40h, 0BEh, 0C1h, 99h, 23h, 0ADh, 0D6h ; 0ad28
	DB 99h, 1Bh, 00h, 10h, 00h, 0Ah, 00h, 90h ; 0ad30
	DB 0BAh, 0Ah, 00h, 0ACh, 0BAh, 0C1h, 99h ; 0ad38
	ASCII "5" ; 0ad3f
	DB 0ADh, 0D6h, 99h, 21h, 00h, 10h, 00h, 0Ah ; 0ad40
	DB 00h, 90h, 0B7h, 0Ah, 00h, 0A8h, 0B7h, 0C1h ; 0ad48
	DB 99h ; 0ad50
	ASCII "G" ; 0ad51
	DB 0ADh, 7Bh, 0A7h, 0C8h, 0ADh ; 0ad52
	ASCII "F" ; 0ad57
	DB 0AEh, 0C4h, 0AEh, 7Bh, 0A7h, 0AAh, 0ADh, 28h ; 0ad58
	DB 0AEh, 0A6h, 0AEh, 7Bh, 0A7h, 0CEh, 0ADh ; 0ad60
	ASCII "L" ; 0ad67
	DB 0AEh, 0CAh, 0AEh, 7Bh, 0A7h, 0B0h, 0ADh, 2Eh ; 0ad68
	DB 0AEh, 0ACh, 0AEh, 9Dh, 99h, 19h, 9Bh, 97h ; 0ad70
	DB 99h, 01h, 40h, 0A9h, 7Bh, 0A7h, 0D4h, 0ADh ; 0ad78
	ASCII "R" ; 0ad80
	DB 0AEh, 0D0h, 0AEh, 7Bh, 0A7h, 0B6h, 0ADh ; 0ad81
	ASCII "4" ; 0ad88
	DB 0AEh, 0B2h, 0AEh, 7Bh, 0A7h, 0BCh, 0ADh, 3Ah ; 0ad89
	DB 0AEh, 0B8h, 0AEh, 7Bh, 0A7h, 0A4h, 0ADh, 22h ; 0ad91
	DB 0AEh, 0A0h, 0AEh, 7Bh, 0A7h, 0C2h, 0ADh, 40h ; 0ad99
	DB 0AEh, 0BEh, 0AEh, 01h, 00h, 14h, 0B8h, 8Eh ; 0ada1
	DB 99h, 01h, 00h, 2Ch, 0B8h, 8Eh, 99h, 01h ; 0ada9
	DB 00h ; 0adb1
	ASCII "D" ; 0adb2
	DB 0B8h, 8Eh, 99h, 01h, 00h, 5Ch, 0B8h, 8Eh ; 0adb3
	DB 99h, 01h, 00h ; 0adbb
	ASCII "t" ; 0adbe
	DB 0B8h, 8Eh, 99h, 01h, 00h, 88h, 0B8h, 8Eh ; 0adbf
	DB 99h, 01h, 00h, 9Ch, 0B8h, 8Eh, 99h, 01h ; 0adc7
	DB 00h, 0B4h, 0B8h, 8Eh, 99h, 08h, 00h, 0CCh ; 0adcf
	DB 0B8h, 08h, 00h, 90h, 0B7h, 08h, 00h, 0CCh ; 0add7
	DB 0B8h, 08h, 00h, 90h, 0B7h, 08h, 00h, 0CCh ; 0addf
	DB 0B8h, 08h, 00h, 90h, 0B7h, 08h, 00h, 0E4h ; 0ade7
	DB 0B8h, 08h, 00h, 90h, 0B7h, 08h, 00h, 0E4h ; 0adef
	DB 0B8h, 08h, 00h, 90h, 0B7h, 08h, 00h, 0E4h ; 0adf7
	DB 0B8h, 08h, 00h, 90h, 0B7h, 08h, 00h, 0E4h ; 0adff
	DB 0B8h, 08h, 00h, 90h, 0B7h, 04h, 00h, 14h ; 0ae07
	DB 0B8h, 0Ch, 00h, 0FCh, 0B8h, 06h, 00h, 14h ; 0ae0f
	DB 0B8h, 9Eh, 0A9h, 14h, 00h ; 0ae17
	ASCII "x" ; 0ae1c
	DB 0BAh, 0C1h, 99h, 0Fh, 0ADh, 01h, 00h, 2Ch ; 0ae1d
	DB 0BBh, 8Eh, 99h, 01h, 00h ; 0ae25
	ASCII "H" ; 0ae2a
	DB 0BBh, 8Eh, 99h, 01h, 00h ; 0ae2b
	ASCII "d" ; 0ae30
	DB 0BBh, 8Eh, 99h, 01h, 00h, 80h, 0BBh, 8Eh ; 0ae31
	DB 99h, 01h, 00h, 9Ch, 0BBh, 8Eh, 99h, 01h ; 0ae39
	DB 00h, 0B8h, 0BBh, 8Eh, 99h, 01h, 00h, 0D4h ; 0ae41
	DB 0BBh, 8Eh, 99h, 01h, 00h, 0F0h, 0BBh, 8Eh ; 0ae49
	DB 99h, 08h, 00h, 0Ch, 0BCh, 08h, 00h, 90h ; 0ae51
	DB 0BAh, 08h, 00h, 0Ch, 0BCh, 08h, 00h, 90h ; 0ae59
	DB 0BAh, 08h, 00h, 0Ch, 0BCh, 08h, 00h, 90h ; 0ae61
	DB 0BAh, 08h, 00h, 28h, 0BCh, 08h, 00h, 90h ; 0ae69
	DB 0BAh, 08h, 00h, 28h, 0BCh, 08h, 00h, 90h ; 0ae71
	DB 0BAh, 08h, 00h, 28h, 0BCh, 08h, 00h, 90h ; 0ae79
	DB 0BAh, 08h, 00h, 28h, 0BCh, 08h, 00h, 90h ; 0ae81
	DB 0BAh, 04h, 00h, 2Ch, 0BBh, 0Ch, 00h ; 0ae89
	ASCII "D" ; 0ae90
	DB 0BCh, 06h, 00h, 2Ch, 0BBh, 9Eh, 0A9h, 14h ; 0ae91
	DB 00h, 0Ch, 0BEh, 0C1h, 99h, 0Fh, 0ADh, 01h ; 0ae99
	DB 00h, 0ACh, 0BEh, 8Eh, 99h, 01h, 00h, 0C4h ; 0aea1
	DB 0BEh, 8Eh, 99h, 01h, 00h, 0DCh, 0BEh, 8Eh ; 0aea9
	DB 99h, 01h, 00h, 0F4h, 0BEh, 8Eh, 99h, 01h ; 0aeb1
	DB 00h, 0Ch, 0BFh, 8Eh, 99h, 01h, 00h, 24h ; 0aeb9
	DB 0BFh, 8Eh, 99h, 01h, 00h, 3Ch, 0BFh, 8Eh ; 0aec1
	DB 99h, 01h, 00h ; 0aec9
	ASCII "T" ; 0aecc
	DB 0BFh, 8Eh, 99h, 08h, 00h ; 0aecd
	ASCII "l" ; 0aed2
	DB 0BFh, 08h, 00h, 28h, 0BEh, 08h, 00h ; 0aed3
	ASCII "l" ; 0aeda
	DB 0BFh, 08h, 00h, 28h, 0BEh, 08h, 00h ; 0aedb
	ASCII "l" ; 0aee2
	DB 0BFh, 08h, 00h, 28h, 0BEh, 08h, 00h, 84h ; 0aee3
	DB 0BFh, 08h, 00h, 28h, 0BEh, 08h, 00h, 84h ; 0aeeb
	DB 0BFh, 08h, 00h, 28h, 0BEh, 08h, 00h, 84h ; 0aef3
	DB 0BFh, 08h, 00h, 28h, 0BEh, 08h, 00h, 84h ; 0aefb
	DB 0BFh, 08h, 00h, 28h, 0BEh, 04h, 00h, 0ACh ; 0af03
	DB 0BEh, 0Ch, 00h, 9Ch, 0BFh, 06h, 00h, 0ACh ; 0af0b
	DB 0BEh, 9Eh, 0A9h, 14h, 00h, 1Ch, 0C1h, 0C1h ; 0af13
	DB 99h, 0Fh, 0ADh, 7Bh, 0A7h, 2Eh, 0AFh ; 0af1b
	ASCII "J" ; 0af22
	DB 0AFh ; 0af23
	ASCII "f" ; 0af24
	DB 0AFh, 7Bh, 0A7h, 3Ch, 0AFh ; 0af25
	ASCII "X" ; 0af2a
	DB 0AFh ; 0af2b
	ASCII "t" ; 0af2c
	DB 0AFh, 0D6h, 99h, 21h, 00h, 10h, 00h, 06h ; 0af2d
	DB 00h, 0C0h, 0B7h, 0C1h, 99h, 13h, 0ADh, 0D6h ; 0af35
	DB 99h, 21h, 00h, 10h, 00h, 06h, 00h, 0FCh ; 0af3d
	DB 0B8h, 0C1h, 99h, 13h, 0ADh, 0D6h, 99h, 1Bh ; 0af45
	DB 00h, 10h, 00h, 06h, 00h, 0C8h, 0BAh, 0C1h ; 0af4d
	DB 99h, 13h, 0ADh, 0D6h, 99h, 1Bh, 00h, 10h ; 0af55
	DB 00h, 06h, 00h ; 0af5d
	ASCII "D" ; 0af60
	DB 0BCh, 0C1h, 99h, 13h, 0ADh, 0D6h, 99h, 1Fh ; 0af61
	DB 00h, 10h, 00h, 06h, 00h ; 0af69
	ASCII "X" ; 0af6e
	DB 0BEh, 0C1h, 99h, 13h, 0ADh, 0D6h, 99h, 1Fh ; 0af6f
	DB 00h, 10h, 00h, 06h, 00h, 9Ch, 0BFh, 0C1h ; 0af77
	DB 99h, 13h, 0ADh, 9Dh, 99h, 19h, 9Bh, 7Bh ; 0af7f
	DB 0A7h, 8Eh, 0AFh, 0BEh, 0AFh, 0EEh, 0AFh, 03h ; 0af87
	DB 00h, 0A8h, 0B7h, 03h, 00h, 90h, 0B7h, 03h ; 0af8f
	DB 00h, 0A8h, 0B7h, 03h, 00h, 0FCh, 0B7h, 02h ; 0af97
	DB 00h, 0E4h, 0B7h, 02h, 00h, 0D8h, 0B7h, 0D6h ; 0af9f
	DB 99h, 28h, 00h, 40h, 00h, 9Dh, 99h, 0B1h ; 0afa7
	DB 0B7h, 83h, 0ADh, 04h, 00h ; 0afaf
	ASCII "p" ; 0afb4
	DB 0B9h, 04h, 00h, 80h, 0B9h, 0C1h, 99h, 95h ; 0afb5
	DB 8Dh, 03h, 00h, 0ACh, 0BAh, 03h, 00h, 90h ; 0afbd
	DB 0BAh, 03h, 00h, 0ACh, 0BAh, 03h, 00h, 0Ch ; 0afc5
	DB 0BBh, 02h, 00h, 0F0h, 0BAh, 02h, 00h, 0E4h ; 0afcd
	DB 0BAh, 0D6h, 99h, 28h, 00h, 40h, 00h, 9Dh ; 0afd5
	DB 99h, 0B1h, 0B7h, 83h, 0ADh, 04h, 00h, 0ECh ; 0afdd
	DB 0BCh, 04h, 00h, 0FCh, 0BCh, 0C1h, 99h, 95h ; 0afe5
	DB 8Dh, 03h, 00h, 40h, 0BEh, 03h, 00h, 28h ; 0afed
	DB 0BEh, 03h, 00h, 40h, 0BEh, 03h, 00h, 94h ; 0aff5
	DB 0BEh, 02h, 00h, 7Ch, 0BEh, 02h, 00h ; 0affd
	ASCII "p" ; 0b004
	DB 0BEh, 0D6h, 99h, 28h, 00h, 40h, 00h, 9Dh ; 0b005
	DB 99h, 0B1h, 0B7h, 83h, 0ADh, 04h, 00h, 14h ; 0b00d
	DB 0C0h, 04h, 00h, 24h, 0C0h, 0C1h, 99h, 95h ; 0b015
	DB 8Dh, 9Dh, 99h, 19h, 9Bh, 7Bh, 0A7h, 2Ah ; 0b01d
	DB 0B0h ; 0b025
	ASCII "R" ; 0b026
	DB 0B0h ; 0b027
	ASCII "z" ; 0b028
	DB 0B0h, 04h, 00h, 88h, 0B9h, 04h, 00h, 90h ; 0b029
	DB 0B7h, 04h, 00h, 0A0h, 0B9h, 04h, 00h, 90h ; 0b031
	DB 0B7h, 04h, 00h, 88h, 0B9h, 04h, 00h, 90h ; 0b039
	DB 0B7h, 04h, 00h, 0A0h, 0B9h, 04h, 00h, 90h ; 0b041
	DB 0B7h, 9Dh, 99h, 0A2h, 0B0h, 0C1h, 99h, 15h ; 0b049
	DB 0ADh, 04h, 00h, 0Ch, 0BDh, 04h, 00h, 90h ; 0b051
	DB 0BAh, 04h, 00h, 28h, 0BDh, 04h, 00h, 90h ; 0b059
	DB 0BAh, 04h, 00h, 0Ch, 0BDh, 04h, 00h, 90h ; 0b061
	DB 0BAh, 04h, 00h, 28h, 0BDh, 04h, 00h, 90h ; 0b069
	DB 0BAh, 9Dh, 99h, 0A2h, 0B0h, 0C1h, 99h, 15h ; 0b071
	DB 0ADh, 04h, 00h, 2Ch, 0C0h, 04h, 00h, 28h ; 0b079
	DB 0BEh, 04h, 00h ; 0b081
	ASCII "D" ; 0b084
	DB 0C0h, 04h, 00h, 28h, 0BEh, 04h, 00h, 2Ch ; 0b085
	DB 0C0h, 04h, 00h, 28h, 0BEh, 04h, 00h ; 0b08d
	ASCII "D" ; 0b094
	DB 0C0h, 04h, 00h, 28h, 0BEh, 9Dh, 99h, 0A2h ; 0b095
	DB 0B0h, 0C1h, 99h, 15h, 0ADh, 0B9h, 3Bh, 1Bh ; 0b09d
	DB 0C1h, 02h, 00h, 0CFh, 0C0h, 0D4h, 03h, 0B9h ; 0b0a5
	DB 0E7h, 0Fh, 0B0h, 28h, 0CEh, 0D1h, 23h, 1Bh ; 0b0ad
	DB 0BCh, 12h, 1Bh, 0C4h, 82h, 0AFh, 0F1h, 5Eh ; 0b0b5
	DB 0CEh, 0D0h, 15h, 1Bh ; 0b0bd
	ASCII "2" ; 0b0c1
	DB 04h, 0E6h, 05h ; 0b0c2
	ASCII "2" ; 0b0c5
	DB 05h, 0E7h, 05h, 0F2h, 0Ah, 01h, 0F8h, 0CEh ; 0b0c6
	DB 0D0h ; 0b0ce
	ASCII "B" ; 0b0cf
	DB 16h, 96h, 01h, 0E6h ; 0b0d0
	ASCII "D" ; 0b0d4
	DB 0F2h, 94h, 00h, 0E6h, 3Fh, 0CEh, 0D0h ; 0b0d5
	ASCII "C" ; 0b0dc
	DB 16h, 96h, 01h, 0EBh, 3Ch, 00h, 0CEh, 0D0h ; 0b0dd
	DB 15h, 1Bh ; 0b0e5
	ASCII "2" ; 0b0e7
	DB 03h, 0EAh ; 0b0e8
	ASCIZ "U" ; 0b0ea
	DB 0CEh, 0D0h ; 0b0ec
	ASCII "C" ; 0b0ee
	DB 16h, 96h, 01h, 0E6h, 0Dh, 0F2h, 0D1h, 06h ; 0b0ef
	DB 28h, 0E7h, 07h, 0CEh, 0C4h, 02h, 0F2h ; 0b0f7
	ASCII "A" ; 0b0fe
	DB 0F8h, 0C5h, 1Eh, 0AFh, 0A6h, 0A3h, 0F2h, 87h ; 0b0ff
	DB 02h, 0ABh, 0AEh, 0CEh, 0D0h, 11h, 1Bh ; 0b107
	ASCII "1" ; 0b10e
	DB 0E4h, 04h, 0C5h, 26h, 0AFh, 0CFh, 0E1h, 0F1h ; 0b10f
	DB 03h, 0F1h, 04h, 0F2h ; 0b117
	ASCII "W" ; 0b11b
	DB 0F8h, 0F8h, 0CEh, 0D0h, 15h, 1Bh ; 0b11c
	ASCII "2" ; 0b122
	DB 03h, 0E7h, 02h, 0F8h, 0F2h, 84h, 0E9h, 0E7h ; 0b123
	DB 14h, 0F2h, 0BBh, 0Fh, 0CEh, 0D0h, 0DCh, 1Ah ; 0b12b
	ASCIZ "2" ; 0b133
	DB 0E6h, 09h, 0CEh, 0C4h, 02h, 0F2h ; 0b135
	ASCII "N" ; 0b13b
	DB 0FEh, 0F1h, 01h, 0F8h, 0CEh, 0D0h ; 0b13c
	ASCII "B" ; 0b142
	DB 16h, 22h ; 0b143
	ASCII "x" ; 0b145
	DB 0E6h, 23h, 0C5h, 19h, 1Bh, 86h ; 0b146
	ASCII "E2$" ; 0b14c
	DB 0E4h, 1Ah, 0B5h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 0b14f
	DB 24h, 0FEh, 0F2h ; 0b157
	ASCII "A" ; 0b15a
	DB 0E9h, 0E7h, 0Dh, 0CEh, 0C4h, 02h, 0F2h, 27h ; 0b15b
	DB 0F8h, 0CEh, 0C4h, 02h, 0F2h, 9Ch, 0FEh, 0F8h ; 0b163
	DB 0CEh, 0D0h, 0D7h, 1Ah, 28h, 0E6h ; 0b16b
	ASCII "J" ; 0b171
	DB 88h, 0E6h, 2Dh, 0CEh, 0D0h, 11h, 1Bh ; 0b172
	ASCII "2" ; 0b179
	DB 08h, 0E4h, 22h ; 0b17a
	ASCII "2 " ; 0b17d
	DB 0E4h, 0Fh, 0CEh, 0D0h, 10h, 1Bh ; 0b17f
	ASCII "2#" ; 0b185
	DB 0E4h, 16h ; 0b187
	ASCII "2<" ; 0b189
	DB 0E5h, 12h, 0F1h, 0Dh, 0CEh, 0D0h, 10h, 1Bh ; 0b18b
	ASCII "2," ; 0b193
	DB 0E4h, 08h ; 0b195
	ASCII "20" ; 0b197
	DB 0E5h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 0b199
	DB 0CEh, 0D0h, 10h, 1Bh ; 0b1a1
	ASCII "2%" ; 0b1a5
	DB 0E4h, 10h ; 0b1a7
	ASCII "27" ; 0b1a9
	DB 0E5h, 0Ch, 0CEh, 0D0h, 11h, 1Bh ; 0b1ab
	ASCII "2" ; 0b1b1
	DB 0Ch, 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h ; 0b1b2
	DB 0F8h, 0CEh, 0D0h, 10h, 1Bh ; 0b1ba
	ASCII "2" ; 0b1bf
	DB 1Eh, 0E4h, 10h ; 0b1c0
	ASCII "2?" ; 0b1c3
	DB 0E5h, 0Ch, 0CEh, 0D0h, 11h, 1Bh ; 0b1c5
	ASCII "2" ; 0b1cb
	DB 0Dh, 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h ; 0b1cc
	DB 0F8h, 0A6h, 0A3h, 0F2h ; 0b1d4
	ASCII "u" ; 0b1d8
	DB 01h, 0CEh, 0D0h, 11h, 1Bh ; 0b1d9
	ASCII "1" ; 0b1de
	DB 0E4h ; 0b1df
	ASCII "I" ; 0b1e0
	DB 0F2h ; 0b1e1
	ASCII "s" ; 0b1e2
	DB 01h, 0CEh, 0D0h, 11h, 1Bh ; 0b1e3
	ASCII "1" ; 0b1e8
	DB 0E4h, 20h, 0F2h ; 0b1e9
	ASCII "q" ; 0b1ec
	DB 01h, 0C5h ; 0b1ed
	ASCII "S" ; 0b1ef
	DB 0ADh, 0CEh, 0D0h, 10h, 1Bh ; 0b1f0
	ASCII "1" ; 0b1f5
	DB 0E4h, 5Bh, 0F2h ; 0b1f6
	ASCII "l" ; 0b1f9
	DB 01h, 0C5h, 5Bh, 0ADh, 0CEh, 0D0h, 10h, 1Bh ; 0b1fa
	ASCII "1" ; 0b202
	DB 0E4h ; 0b203
	ASCII "N" ; 0b204
	DB 0C5h ; 0b205
	ASCII "c" ; 0b206
	DB 0ADh, 0F1h ; 0b207
	ASCII "I" ; 0b209
	DB 0F2h ; 0b20a
	ASCII "R" ; 0b20b
	DB 01h, 0C5h ; 0b20c
	ASCII "k" ; 0b20e
	DB 0ADh, 0CEh, 0D0h, 10h, 1Bh ; 0b20f
	ASCII "1" ; 0b214
	DB 0E4h, 3Ch, 0F2h ; 0b215
	ASCII "M" ; 0b218
	DB 01h, 0C5h, 15h, 0ADh, 0CEh, 0D0h, 10h, 1Bh ; 0b219
	ASCII "1" ; 0b221
	DB 0E4h, 25h, 0C5h, 84h, 0ADh, 0F1h, 2Ah, 0F2h ; 0b222
	ASCII "3" ; 0b22a
	DB 01h, 0C5h, 8Ch, 0ADh, 0CEh, 0D0h, 10h, 1Bh ; 0b22b
	ASCII "1" ; 0b233
	DB 0E4h, 1Dh, 0F2h, 2Eh, 01h, 0C5h, 94h, 0ADh ; 0b234
	DB 0CEh, 0D0h, 10h, 1Bh ; 0b23c
	ASCII "1" ; 0b240
	DB 0E4h, 10h, 0C5h, 9Ch, 0ADh, 0F1h, 0Bh, 0CEh ; 0b241
	DB 0D0h ; 0b249
	ASCII "B" ; 0b24a
	DB 16h, 96h, 01h, 0E6h, 03h, 0F0h, 09h, 0CFh ; 0b24b
	DB 0E1h, 0F2h, 1Dh, 0F7h, 0ABh, 0AEh, 0F8h, 0F2h ; 0b253
	DB 12h, 01h, 0CEh, 0D0h, 10h, 1Bh, 02h, 06h ; 0b25b
	ASCII "1" ; 0b263
	DB 0E4h, 3Fh, 0F2h, 0Eh, 01h, 0CEh, 0D0h, 10h ; 0b264
	DB 1Bh, 12h, 02h ; 0b26c
	ASCII "1" ; 0b26f
	DB 0E5h ; 0b270
	ASCII "3" ; 0b271
	DB 0F2h, 0Ah, 01h, 0CEh, 0D0h, 11h, 1Bh, 02h ; 0b272
	DB 0Ah ; 0b27a
	ASCII "1" ; 0b27b
	DB 0E4h, 27h, 0F2h, 06h, 01h, 0CEh, 0D0h, 11h ; 0b27c
	DB 1Bh, 02h, 04h ; 0b284
	ASCII "1" ; 0b287
	DB 0E5h, 1Bh, 0CEh, 0D0h, 80h, 1Bh, 28h, 0E6h ; 0b288
	DB 0Bh, 0F2h, 12h, 00h, 0E7h, 06h, 0C5h, 1Eh ; 0b290
	DB 0B0h, 0F1h, 0Ah, 0B0h, 06h, 0CEh, 0D4h, 15h ; 0b298
	DB 1Bh, 0C5h ; 0b2a0
	ASCII "s" ; 0b2a2
	DB 0ADh, 0F8h, 0A6h, 0A2h, 0A3h, 0C6h, 0ECh, 1Ah ; 0b2a3
	DB 0CEh, 0C6h, 00h, 0C5h, 8Ah, 1Bh, 0B1h, 07h ; 0b2ab
	ASCII "n" ; 0b2b3
	DB 92h, 91h, 0F5h, 0FCh, 0C6h, 0AAh, 15h, 0CEh ; 0b2b4
	DB 0C6h, 00h, 0F2h ; 0b2bc
	ASCII "F" ; 0b2bf
	DB 94h, 0C6h, 0AFh, 15h, 0CEh, 0C6h, 00h, 0F2h ; 0b2c0
	DB 27h, 00h, 0C6h, 83h, 1Bh, 0CEh, 40h, 00h ; 0b2c8
	DB 28h, 0E7h, 14h, 0CEh, 40h, 01h, 28h, 0E7h ; 0b2d0
	DB 0Eh, 0CEh, 40h, 02h, 28h, 0E7h, 08h, 0CEh ; 0b2d8
	DB 40h, 03h ; 0b2e0
	ASCII "2" ; 0b2e2
	DB 03h, 0E4h, 05h, 9Ch, 0FEh, 0F1h, 03h, 9Dh ; 0b2e3
	DB 01h, 0ABh, 0AAh, 0AEh, 0F8h, 0C5h, 8Fh, 1Bh ; 0b2eb
	DB 0C7h, 88h, 1Bh, 0CEh, 0C7h, 00h ; 0b2f3
	ASCII "F" ; 0b2f9
	DB 13h, 99h, 0E5h, 04h, 86h, 02h, 3Ch ; 0b2fa
	ASCII "p" ; 0b301
	DB 9Ah, 9Bh ; 0b302
	ASCII "F" ; 0b304
	DB 13h, 99h, 0E5h, 04h, 86h, 02h, 3Ch ; 0b305
	ASCII "p" ; 0b30c
	DB 9Ah, 9Bh ; 0b30d
	ASCII "F" ; 0b30f
	DB 13h, 99h, 0E5h, 04h, 86h, 02h, 18h ; 0b310
	ASCII "p" ; 0b317
	DB 9Ah, 9Bh ; 0b318
	ASCII "F" ; 0b31a
	DB 13h, 99h, 0E5h, 1Ah, 0A6h, 0A3h, 0CFh, 0B0h ; 0b31b
	DB 0CEh, 0D0h, 8Ah, 1Bh, 0CEh, 0D1h, 8Bh, 1Bh ; 0b323
	DB 0CEh, 0C4h, 07h, 0F2h, 0B2h, 0D4h ; 0b32b
	ASCII "H" ; 0b331
	DB 0CFh, 0B4h, 0ABh, 0AEh, 86h, 01h ; 0b332
	ASCII "p" ; 0b338
	DB 9Ah, 9Bh ; 0b339
	ASCII "F" ; 0b33b
	DB 13h, 99h, 0E5h, 04h, 86h, 02h, 0Ch ; 0b33c
	ASCII "p" ; 0b343
	DB 9Ah, 9Bh ; 0b344
	ASCII "F" ; 0b346
	DB 13h, 0E5h, 03h, 0B0h, 0FFh ; 0b347
	ASCII "p" ; 0b34c
	DB 0F8h, 0C7h ; 0b34d
	ASCII "S" ; 0b34f
	DB 0B3h, 0F1h ; 0b350
	ASCII "D!" ; 0b352
	DB 15h, 1Ah, 0C7h, 5Bh, 0B3h, 0F1h, 3Ch ; 0b354
	ASCII "3(1" ; 0b35b
	DB 0C7h ; 0b35e
	ASCII "c" ; 0b35f
	DB 0B3h, 0F1h ; 0b360
	ASCII "4" ; 0b362
	DB 1Dh, 20h, 23h, 0C7h ; 0b363
	ASCII "k" ; 0b367
	DB 0B3h, 0F1h, 2Ch, 3Eh ; 0b368
	ASCII "98" ; 0b36c
	DB 0C7h ; 0b36e
	ASCII "s" ; 0b36f
	DB 0B3h, 0F1h, 24h, 2Dh, 29h, 2Bh, 0C7h, 7Bh ; 0b370
	DB 0B3h, 0F1h, 1Ch ; 0b378
	ASCII "578" ; 0b37b
	DB 0C7h, 83h, 0B3h, 0F1h, 14h, 2Fh, 25h ; 0b37e
	ASCII "1" ; 0b385
	DB 0C7h, 8Bh, 0B3h, 0F1h, 0Ch ; 0b386
	ASCII "3*8" ; 0b38b
	DB 0C7h, 93h, 0B3h, 0F1h, 04h, 2Ah, 22h, 2Ah ; 0b38e
	DB 0CEh, 0D0h, 0D7h, 1Ah, 0B1h, 00h, 0CEh, 0C7h ; 0b396
	DB 00h, 0CFh ; 0b39e
	ASCII "BO" ; 0b3a0
	DB 0F8h, 7Bh, 0A7h, 0ABh, 0B3h, 0BDh, 0B3h, 0CFh ; 0b3a2
	DB 0B3h, 0D6h, 99h, 21h, 00h, 10h, 00h, 0Ah ; 0b3aa
	DB 00h, 28h, 0B9h, 0Ah, 00h ; 0b3b2
	ASCII "0" ; 0b3b7
	DB 0B9h, 0C1h, 99h, 0B1h, 0B3h, 0D6h, 99h, 1Bh ; 0b3b8
	DB 00h, 10h, 00h, 0Ah, 00h, 9Ch, 0BCh, 0Ah ; 0b3c0
	DB 00h, 0A4h, 0BCh, 0C1h, 99h, 0C3h, 0B3h, 0D6h ; 0b3c8
	DB 99h, 1Fh, 00h, 10h, 00h, 0Ah, 00h, 0E4h ; 0b3d0
	DB 0BFh, 0Ah, 00h, 0ECh, 0BFh, 0C1h, 99h, 0D5h ; 0b3d8
	DB 0B3h, 7Bh, 0A7h, 0E9h, 0B3h ; 0b3e0
	ASCII "C" ; 0b3e5
	DB 0B4h, 9Dh, 0B4h, 0D6h, 99h, 21h, 00h, 10h ; 0b3e6
	DB 00h, 01h, 00h ; 0b3ee
	ASCII "8" ; 0b3f1
	DB 0B9h, 01h, 00h, 40h, 0B9h, 01h, 00h ; 0b3f2
	ASCII "8" ; 0b3f9
	DB 0B9h, 01h, 00h, 40h, 0B9h, 01h, 00h ; 0b3fa
	ASCII "8" ; 0b401
	DB 0B9h, 01h, 00h, 40h, 0B9h, 01h, 00h ; 0b402
	ASCII "8" ; 0b409
	DB 0B9h, 01h, 00h, 40h, 0B9h, 01h, 00h ; 0b40a
	ASCII "8" ; 0b411
	DB 0B9h, 01h, 00h, 40h, 0B9h, 01h, 00h ; 0b412
	ASCII "P" ; 0b419
	DB 0B9h, 01h, 00h ; 0b41a
	ASCII "H" ; 0b41d
	DB 0B9h, 01h, 00h ; 0b41e
	ASCII "P" ; 0b421
	DB 0B9h, 01h, 00h ; 0b422
	ASCII "H" ; 0b425
	DB 0B9h, 01h, 00h ; 0b426
	ASCII "P" ; 0b429
	DB 0B9h, 01h, 00h ; 0b42a
	ASCII "H" ; 0b42d
	DB 0B9h, 01h, 00h ; 0b42e
	ASCII "P" ; 0b431
	DB 0B9h, 01h, 00h ; 0b432
	ASCII "H" ; 0b435
	DB 0B9h, 01h, 00h ; 0b436
	ASCII "P" ; 0b439
	DB 0B9h, 01h, 00h ; 0b43a
	ASCII "H" ; 0b43d
	DB 0B9h, 0C1h, 99h, 0EFh, 0B3h, 0D6h, 99h, 1Bh ; 0b43e
	DB 00h, 10h, 00h, 01h, 00h, 0ACh, 0BCh, 01h ; 0b446
	DB 00h, 0B4h, 0BCh, 01h, 00h, 0ACh, 0BCh, 01h ; 0b44e
	DB 00h, 0B4h, 0BCh, 01h, 00h, 0ACh, 0BCh, 01h ; 0b456
	DB 00h, 0B4h, 0BCh, 01h, 00h, 0ACh, 0BCh, 01h ; 0b45e
	DB 00h, 0B4h, 0BCh, 01h, 00h, 0ACh, 0BCh, 01h ; 0b466
	DB 00h, 0B4h, 0BCh, 01h, 00h, 0C4h, 0BCh, 01h ; 0b46e
	DB 00h, 0BCh, 0BCh, 01h, 00h, 0C4h, 0BCh, 01h ; 0b476
	DB 00h, 0BCh, 0BCh, 01h, 00h, 0C4h, 0BCh, 01h ; 0b47e
	DB 00h, 0BCh, 0BCh, 01h, 00h, 0C4h, 0BCh, 01h ; 0b486
	DB 00h, 0BCh, 0BCh, 01h, 00h, 0C4h, 0BCh, 01h ; 0b48e
	DB 00h, 0BCh, 0BCh, 0C1h, 99h ; 0b496
	ASCII "I" ; 0b49b
	DB 0B4h, 0D6h, 99h, 1Fh, 00h, 10h, 00h, 01h ; 0b49c
	DB 00h, 0F4h, 0BFh, 01h, 00h, 0FCh, 0BFh, 01h ; 0b4a4
	DB 00h, 0F4h, 0BFh, 01h, 00h, 0FCh, 0BFh, 01h ; 0b4ac
	DB 00h, 0F4h, 0BFh, 01h, 00h, 0FCh, 0BFh, 01h ; 0b4b4
	DB 00h, 0F4h, 0BFh, 01h, 00h, 0FCh, 0BFh, 01h ; 0b4bc
	DB 00h, 0F4h, 0BFh, 01h, 00h, 0FCh, 0BFh, 01h ; 0b4c4
	DB 00h, 0Ch, 0C0h, 01h, 00h, 04h, 0C0h, 01h ; 0b4cc
	DB 00h, 0Ch, 0C0h, 01h, 00h, 04h, 0C0h, 01h ; 0b4d4
	DB 00h, 0Ch, 0C0h, 01h, 00h, 04h, 0C0h, 01h ; 0b4dc
	DB 00h, 0Ch, 0C0h, 01h, 00h, 04h, 0C0h, 01h ; 0b4e4
	DB 00h, 0Ch, 0C0h, 01h, 00h, 04h, 0C0h, 0C1h ; 0b4ec
	DB 99h, 0A3h, 0B4h, 7Bh, 0A7h, 0FFh, 0B4h, 11h ; 0b4f4
	DB 0B5h, 23h, 0B5h, 0D6h, 99h, 21h, 00h, 10h ; 0b4fc
	DB 00h, 0Ah, 00h, 10h, 0BAh, 0Ah, 00h, 18h ; 0b504
	DB 0BAh, 0C1h, 99h, 05h, 0B5h, 0D6h, 99h, 1Bh ; 0b50c
	DB 00h, 10h, 00h, 0Ah, 00h, 0A4h, 0BDh, 0Ah ; 0b514
	DB 00h, 0ACh, 0BDh, 0C1h, 99h, 17h, 0B5h, 0D6h ; 0b51c
	DB 99h, 1Fh, 00h, 10h, 00h, 0Ah, 00h, 0B4h ; 0b524
	DB 0C0h, 0Ah, 00h, 0BCh, 0C0h, 0C1h, 99h, 29h ; 0b52c
	DB 0B5h, 0D6h, 99h, 21h, 00h, 10h, 00h, 0Ah ; 0b534
	DB 00h, 28h, 0BAh, 0Ah, 00h ; 0b53c
	ASCII "0" ; 0b541
	DB 0BAh, 0C1h, 99h, 3Bh, 0B5h, 0D6h, 99h, 21h ; 0b542
	DB 00h, 10h, 00h, 01h, 00h ; 0b54a
	ASCII "8" ; 0b54f
	DB 0BAh, 01h, 00h ; 0b550
	ASCII "H" ; 0b553
	DB 0BAh, 01h, 00h ; 0b554
	ASCII "8" ; 0b557
	DB 0BAh, 01h, 00h ; 0b558
	ASCII "H" ; 0b55b
	DB 0BAh, 01h, 00h ; 0b55c
	ASCII "8" ; 0b55f
	DB 0BAh, 01h, 00h ; 0b560
	ASCII "H" ; 0b563
	DB 0BAh, 01h, 00h ; 0b564
	ASCII "8" ; 0b567
	DB 0BAh, 01h, 00h ; 0b568
	ASCII "H" ; 0b56b
	DB 0BAh, 01h, 00h ; 0b56c
	ASCII "8" ; 0b56f
	DB 0BAh, 01h, 00h ; 0b570
	ASCII "H" ; 0b573
	DB 0BAh, 01h, 00h ; 0b574
	ASCII "h" ; 0b577
	DB 0BAh, 01h, 00h ; 0b578
	ASCII "X" ; 0b57b
	DB 0BAh, 01h, 00h ; 0b57c
	ASCII "h" ; 0b57f
	DB 0BAh, 01h, 00h ; 0b580
	ASCII "X" ; 0b583
	DB 0BAh, 01h, 00h ; 0b584
	ASCII "h" ; 0b587
	DB 0BAh, 01h, 00h ; 0b588
	ASCII "X" ; 0b58b
	DB 0BAh, 01h, 00h ; 0b58c
	ASCII "h" ; 0b58f
	DB 0BAh, 01h, 00h ; 0b590
	ASCII "X" ; 0b593
	DB 0BAh, 01h, 00h ; 0b594
	ASCII "h" ; 0b597
	DB 0BAh, 01h, 00h ; 0b598
	ASCII "X" ; 0b59b
	DB 0BAh, 0C1h, 99h ; 0b59c
	ASCII "M" ; 0b59f
	DB 0B5h, 0D6h, 99h, 1Bh, 00h, 10h, 00h, 0Ah ; 0b5a0
	DB 00h, 0BCh, 0BDh, 0Ah, 00h, 0C4h, 0BDh, 0C1h ; 0b5a8
	DB 99h, 0A7h, 0B5h, 0D6h, 99h, 1Bh, 00h, 10h ; 0b5b0
	DB 00h, 01h, 00h, 0CCh, 0BDh, 01h, 00h, 0DCh ; 0b5b8
	DB 0BDh, 01h, 00h, 0CCh, 0BDh, 01h, 00h, 0DCh ; 0b5c0
	DB 0BDh, 01h, 00h, 0CCh, 0BDh, 01h, 00h, 0DCh ; 0b5c8
	DB 0BDh, 01h, 00h, 0CCh, 0BDh, 01h, 00h, 0DCh ; 0b5d0
	DB 0BDh, 01h, 00h, 0CCh, 0BDh, 01h, 00h, 0DCh ; 0b5d8
	DB 0BDh, 01h, 00h, 0FCh, 0BDh, 01h, 00h, 0ECh ; 0b5e0
	DB 0BDh, 01h, 00h, 0FCh, 0BDh, 01h, 00h, 0ECh ; 0b5e8
	DB 0BDh, 01h, 00h, 0FCh, 0BDh, 01h, 00h, 0ECh ; 0b5f0
	DB 0BDh, 01h, 00h, 0FCh, 0BDh, 01h, 00h, 0ECh ; 0b5f8
	DB 0BDh, 01h, 00h, 0FCh, 0BDh, 01h, 00h, 0ECh ; 0b600
	DB 0BDh, 0C1h, 99h, 0B9h, 0B5h, 0D6h, 99h, 1Fh ; 0b608
	DB 00h, 10h, 00h, 0Ah, 00h, 0CCh, 0C0h, 0Ah ; 0b610
	DB 00h, 0D4h, 0C0h, 0C1h, 99h, 13h, 0B6h, 0D6h ; 0b618
	DB 99h, 1Fh, 00h, 10h, 00h, 01h, 00h, 0DCh ; 0b620
	DB 0C0h, 01h, 00h, 0ECh, 0C0h, 01h, 00h, 0DCh ; 0b628
	DB 0C0h, 01h, 00h, 0ECh, 0C0h, 01h, 00h, 0DCh ; 0b630
	DB 0C0h, 01h, 00h, 0ECh, 0C0h, 01h, 00h, 0DCh ; 0b638
	DB 0C0h, 01h, 00h, 0ECh, 0C0h, 01h, 00h, 0DCh ; 0b640
	DB 0C0h, 01h, 00h, 0ECh, 0C0h, 01h, 00h, 0Ch ; 0b648
	DB 0C1h, 01h, 00h, 0FCh, 0C0h, 01h, 00h, 0Ch ; 0b650
	DB 0C1h, 01h, 00h, 0FCh, 0C0h, 01h, 00h, 0Ch ; 0b658
	DB 0C1h, 01h, 00h, 0FCh, 0C0h, 01h, 00h, 0Ch ; 0b660
	DB 0C1h, 01h, 00h, 0FCh, 0C0h, 01h, 00h, 0Ch ; 0b668
	DB 0C1h, 01h, 00h, 0FCh, 0C0h, 0C1h, 99h, 25h ; 0b670
	DB 0B6h, 7Bh, 0A7h ; 0b678
	ASCII "G" ; 0b67b
	DB 0B5h, 0B3h, 0B5h, 1Fh, 0B6h, 7Bh, 0A7h ; 0b67c
	ASCII "5" ; 0b683
	DB 0B5h, 0A1h, 0B5h, 0Dh, 0B6h, 0CEh, 0D0h, 14h ; 0b684
	DB 1Bh, 28h, 0E6h, 0Eh, 0B9h ; 0b68c
	ASCII "7" ; 0b691
	DB 1Bh, 0C1h, 1Ah, 00h, 0CFh, 0C0h, 0D4h, 13h ; 0b692
	DB 0ADh, 0E6h, 06h, 0C4h, 13h, 9Bh, 0F1h ; 0b69a
	ASCII "9" ; 0b6a1
	DB 0F2h, 0A2h, 0F3h, 0E6h, 1Ah, 0CEh, 0D0h, 0DCh ; 0b6a2
	DB 1Ah ; 0b6aa
	ASCII "2" ; 0b6ab
	DB 02h, 0E6h, 29h ; 0b6ac
	ASCIZ "2" ; 0b6af
	DB 0E6h, 13h, 0CEh, 0D0h, 0DDh, 1Ah ; 0b6b1
	ASCII "2@" ; 0b6b7
	DB 0E4h, 0E3h, 0C4h, 0E1h, 0B3h, 0F1h, 1Bh, 0C4h ; 0b6b9
	DB 0F7h, 0B4h, 0F1h, 16h, 0CEh, 0D0h, 0DDh, 1Ah ; 0b6c1
	ASCII "2@" ; 0b6c9
	DB 0E4h, 06h, 0C4h ; 0b6cb
	ASCII "y" ; 0b6ce
	DB 0B6h, 0F1h, 09h, 0C4h, 81h, 0B6h, 0F1h, 04h ; 0b6cf
	DB 0C4h, 0A3h, 0B3h, 0CEh ; 0b6d7
	ASCII "P" ; 0b6db
	DB 18h, 0CEh ; 0b6dc
	ASCII "X" ; 0b6de
	DB 19h, 0CFh ; 0b6df
	ASCII "8" ; 0b6e1
	DB 0E6h, 0Ah, 0CEh ; 0b6e2
	ASCII "D" ; 0b6e5
	DB 18h, 0CEh ; 0b6e6
	ASCII "L" ; 0b6e8
	DB 19h, 0F2h ; 0b6e9
	ASCII "c" ; 0b6eb
	DB 0C2h, 0F8h ; 0b6ec
	ASCII "q" ; 0b6ee
	DB 9Ah, 02h, 89h, 0B6h, 01h, 17h, 9Bh, 00h ; 0b6ef
	DB 9Dh, 99h ; 0b6f7
	ASCII "s" ; 0b6f9
	DB 0B7h, 0A2h, 0A9h, 7Bh, 0A7h, 05h, 0B7h, 2Bh ; 0b6fa
	DB 0B7h ; 0b702
	ASCII "Q" ; 0b703
	DB 0B7h, 0D6h, 99h, 21h, 00h, 10h, 00h, 04h ; 0b704
	DB 00h, 90h, 0B7h, 04h, 00h, 10h, 0B9h, 04h ; 0b70c
	DB 00h, 90h, 0B7h, 04h, 00h, 10h, 0B9h, 04h ; 0b714
	DB 00h, 90h, 0B7h, 04h, 00h, 10h, 0B9h ; 0b71c
	ASCIZ "2" ; 0b723
	DB 90h, 0B7h, 0C1h, 99h, 0F7h, 0B6h, 0D6h, 99h ; 0b725
	DB 1Bh, 00h, 10h, 00h, 04h, 00h ; 0b72d
	ASCII "d" ; 0b733
	DB 0BCh, 04h, 00h, 80h, 0BCh, 04h, 00h ; 0b734
	ASCII "d" ; 0b73b
	DB 0BCh, 04h, 00h, 80h, 0BCh, 04h, 00h ; 0b73c
	ASCII "d" ; 0b743
	DB 0BCh, 04h, 00h, 80h, 0BCh ; 0b744
	ASCIZ "2" ; 0b749
	ASCII "d" ; 0b74b
	DB 0BCh, 0C1h, 99h, 0F7h, 0B6h, 0D6h, 99h, 1Fh ; 0b74c
	DB 00h, 10h, 00h, 04h, 00h, 0B4h, 0BFh, 04h ; 0b754
	DB 00h, 0CCh, 0BFh, 04h, 00h, 0B4h, 0BFh, 04h ; 0b75c
	DB 00h, 0CCh, 0BFh, 04h, 00h, 0B4h, 0BFh ; 0b764
	ASCIZ "6" ; 0b76b
	DB 0CCh, 0BFh, 0C1h, 99h, 0F7h, 0B6h, 0CEh, 0D0h ; 0b76d
	DB 2Bh, 1Bh, 28h, 0E7h, 0Dh, 0CEh, 0C4h, 02h ; 0b775
	DB 0F2h, 27h, 0F2h, 0C4h, 0Fh, 0ADh, 0F2h, 0EEh ; 0b77d
	DB 0F1h, 0F8h, 0CEh, 0D0h, 12h, 1Bh, 12h, 28h ; 0b785
	DB 0CEh, 88h, 0CEh, 88h, 0CEh, 88h ; 0b78d
	ASCII "H" ; 0b793
	DB 0CEh, 40h, 0Ah, 11h, 0CEh ; 0b794
	ASCII "D" ; 0b799
	DB 0Ah, 0CEh, 0D0h, 13h, 1Bh, 0B1h, 40h, 11h ; 0b79a
	DB 0CEh, 88h, 0CEh, 88h, 0CEh, 88h ; 0b7a2
	ASCII "H" ; 0b7a8
	DB 0CEh, 40h, 0Eh, 11h, 0CEh ; 0b7a9
	ASCII "D" ; 0b7ae
	DB 0Eh, 0F8h, 0CEh, 0D0h, 23h, 1Bh, 0B1h, 40h ; 0b7af
	DB 11h, 0CEh, 88h, 0CEh, 88h, 0CEh, 88h ; 0b7b7
	ASCII "H" ; 0b7be
	DB 0CEh, 40h, 0Eh, 01h, 0CEh ; 0b7bf
	ASCII "D" ; 0b7c4
	DB 0Eh, 0F8h, 0CFh, 0B9h, 0F2h ; 0b7c5
	ASCII "z" ; 0b7ca
	DB 8Ah, 0BCh ; 0b7cb
	ASCII "J" ; 0b7cd
	DB 16h, 0CFh, 0BDh, 0B8h ; 0b7ce
	ASCII "J" ; 0b7d2
	DB 16h, 0F8h, 7Bh, 0A7h, 0DDh, 0B7h, 0EFh, 0B7h ; 0b7d3
	DB 01h, 0B8h, 0D6h, 99h, 21h, 00h, 10h, 00h ; 0b7db
	DB 05h, 00h, 0B8h, 0B9h, 05h, 00h, 0D8h, 0B9h ; 0b7e3
	DB 0C1h, 99h, 0DDh, 0B7h, 0D6h, 99h, 1Bh, 00h ; 0b7eb
	DB 10h, 00h, 05h, 00h ; 0b7f3
	ASCII "D" ; 0b7f7
	DB 0BDh, 05h, 00h ; 0b7f8
	ASCII "h" ; 0b7fb
	DB 0BDh, 0C1h, 99h, 0EFh, 0B7h, 0D6h, 99h, 1Fh ; 0b7fc
	DB 00h, 10h, 00h, 05h, 00h, 5Ch, 0C0h, 05h ; 0b804
	DB 00h, 7Ch, 0C0h, 0C1h, 99h, 01h, 0B8h ; 0b80c
	ASCII "q" ; 0b813
	DB 9Ah, 02h, 19h, 9Bh, 01h, 0D5h, 0B7h, 00h ; 0b814
	DB 01h, 00h, 0A8h, 0ADh, 8Eh, 99h, 01h, 00h ; 0b81c
	DB 0ACh, 0ADh, 8Eh, 99h, 01h, 00h, 0B0h, 0ADh ; 0b824
	DB 8Eh, 99h, 9Dh, 99h, 19h, 9Bh, 02h, 00h ; 0b82c
	DB 0CCh, 0ADh, 06h, 00h, 0D0h, 0ADh, 02h, 00h ; 0b834
	DB 0CCh, 0ADh, 9Dh, 99h ; 0b83c
	ASCII "H" ; 0b840
	DB 0B8h, 04h, 00h ; 0b841
	ASCII "m" ; 0b844
	DB 1Ah, 8Eh, 99h, 0CEh, 0D0h, 15h, 1Bh ; 0b845
	ASCII "2" ; 0b84c
	DB 07h, 0E6h, 0Ch ; 0b84d
	ASCII "2" ; 0b850
	DB 01h, 0E6h, 23h, 0C4h, 13h, 9Bh, 0F2h, 0F6h ; 0b851
	DB 0C0h, 0F8h, 0CEh, 0D0h, 0D7h, 1Ah ; 0b859
	ASCII "2" ; 0b85f
	DB 01h, 0E6h ; 0b860
	ASCII "4" ; 0b862
	DB 0B0h, 00h, 0CEh, 0D4h, 15h, 1Bh, 0C4h, 2Eh ; 0b863
	DB 0B8h, 0F2h, 0E1h, 0C0h, 0B8h, 10h, 1Bh, 0F2h ; 0b86b
	DB 0Eh, 0C1h, 0F8h, 0CEh, 0D0h, 17h, 1Bh ; 0b873
	ASCIZ "H" ; 0b87a
	DB 01h, 0B1h, 00h, 0A6h, 0A3h, 0C7h, 98h, 0B8h ; 0b87c
	DB 0CFh ; 0b884
	ASCII "B" ; 0b885
	DB 0CEh, 0C7h, 00h, 0CFh, 0D8h, 0F2h, 0C2h, 0C0h ; 0b886
	DB 0ABh, 0AEh, 0B8h, 10h, 1Bh, 0F2h, 0EDh, 0C0h ; 0b88e
	DB 0F8h, 02h, 1Ch, 0B8h, 02h, 22h, 0B8h, 00h ; 0b896
	DB 28h, 0B8h, 0CEh, 0D0h, 17h, 1Bh ; 0b89e
	ASCIZ "H" ; 0b8a4
	DB 01h, 0B1h, 00h, 0A6h, 0A3h, 0C7h, 97h, 0B8h ; 0b8a6
	DB 0CFh ; 0b8ae
	ASCII "B" ; 0b8af
	DB 0CEh, 0C7h, 00h ; 0b8b0
	ASCII "G" ; 0b8b3
	DB 0CEh, 0D4h, 16h, 1Bh, 0ABh, 0AEh, 0F8h, 0CEh ; 0b8b4
	DB 0D0h, 2Ah, 1Bh, 28h, 0E7h, 07h, 0C4h ; 0b8bc
	ASCII "H" ; 0b8c3
	DB 0B8h, 0F2h, 81h, 0C0h, 0F8h, 0CEh, 0D0h, 2Ah ; 0b8c4
	DB 1Bh, 28h, 0E6h, 1Ch, 0C4h, 0BBh, 0B8h, 0F2h ; 0b8cc
	ASCII "s" ; 0b8d4
	DB 0C0h, 0CEh, 0D0h, 2Ch, 1Bh, 0CEh, 0D1h, 0D7h ; 0b8d5
	DB 1Ah, 0F2h, 0E8h, 13h, 0F2h ; 0b8dd
	ASCII "l" ; 0b8e2
	DB 0C0h, 0C4h, 28h, 18h, 0F2h, 99h, 0C0h, 0F8h ; 0b8e3
	DB 0C4h ; 0b8eb
	ASCII "H" ; 0b8ec
	DB 0B8h, 0F2h ; 0b8ed
	ASCII "X" ; 0b8ef
	DB 0C0h, 0F8h, 0C9h, 0B8h, 01h, 19h, 9Bh, 01h ; 0b8f0
	DB 17h, 9Bh, 00h, 9Dh, 99h, 15h, 0BBh, 01h ; 0b8f8
	DB 00h ; 0b900
	ASCII "m" ; 0b901
	DB 1Ah, 8Eh, 99h, 9Dh, 99h, 19h, 9Bh, 1Dh ; 0b902
	DB 00h ; 0b90a
	ASCII "m" ; 0b90b
	DB 1Ah, 9Dh, 99h ; 0b90c
	ASCII "m" ; 0b90f
	DB 0BBh, 0C1h, 99h ; 0b910
	ASCII "1" ; 0b913
	DB 0B9h, 9Dh, 99h ; 0b914
	ASCII "0" ; 0b917
	DB 0BEh, 0C1h, 99h ; 0b918
	ASCII "1" ; 0b91b
	DB 0B9h, 9Dh, 99h ; 0b91c
	ASCII "r" ; 0b91f
	DB 0BFh, 0C1h, 99h ; 0b920
	ASCII "1" ; 0b923
	DB 0B9h, 9Dh, 99h, 0A2h, 0BFh, 0C1h, 99h ; 0b924
	ASCII "1" ; 0b92b
	DB 0B9h, 9Dh, 99h, 0B7h, 0BBh, 87h, 0A7h, 3Fh ; 0b92c
	DB 0B9h ; 0b934
	ASCII "G" ; 0b935
	DB 0B9h ; 0b936
	ASCII "O" ; 0b937
	DB 0B9h ; 0b938
	ASCII "W" ; 0b939
	DB 0B9h ; 0b93a
	ASCII "m" ; 0b93b
	DB 0B9h, 83h, 0B9h, 01h, 00h, 0A4h, 0ADh, 0C1h ; 0b93c
	DB 99h ; 0b944
	ASCII "1" ; 0b945
	DB 0B9h, 01h, 00h, 0B8h, 0ADh, 0C1h, 99h ; 0b946
	ASCII "1" ; 0b94d
	DB 0B9h, 01h, 00h, 0C4h, 0C1h, 0C1h, 99h ; 0b94e
	ASCII "1" ; 0b955
	DB 0B9h, 0CEh, 0A7h, 5Dh, 0B9h ; 0b956
	ASCII "e" ; 0b95b
	DB 0B9h, 01h, 00h, 80h, 0AEh, 0C1h, 99h ; 0b95c
	ASCII "1" ; 0b963
	DB 0B9h, 01h, 00h, 90h, 0AFh, 0C1h, 99h ; 0b964
	ASCII "1" ; 0b96b
	DB 0B9h, 0CEh, 0A7h ; 0b96c
	ASCII "s" ; 0b96f
	DB 0B9h, 7Bh, 0B9h, 01h, 00h, 90h, 0AEh, 0C1h ; 0b970
	DB 99h ; 0b978
	ASCII "1" ; 0b979
	DB 0B9h, 01h, 00h, 0A0h, 0AFh, 0C1h, 99h ; 0b97a
	ASCII "1" ; 0b981
	DB 0B9h, 7Bh, 0A7h, 8Bh, 0B9h, 93h, 0B9h, 8Bh ; 0b982
	DB 0B9h, 01h, 00h, 0C8h, 0ADh, 0C1h, 99h ; 0b98a
	ASCII "1" ; 0b991
	DB 0B9h, 01h, 00h, 0D8h, 0ADh, 0C1h, 99h ; 0b992
	ASCII "1" ; 0b999
	DB 0B9h, 87h, 0A7h, 0A9h, 0B9h, 0B1h, 0B9h, 0B9h ; 0b99a
	DB 0B9h, 0C1h, 0B9h, 0D7h, 0B9h, 0EDh, 0B9h, 01h ; 0b9a2
	DB 00h, 0A0h, 0ADh, 0C1h, 99h, 9Bh, 0B9h, 01h ; 0b9aa
	DB 00h, 0BCh, 0ADh, 0C1h, 99h, 9Bh, 0B9h, 01h ; 0b9b2
	DB 00h, 0C0h, 0C1h, 0C1h, 99h, 9Bh, 0B9h, 0CEh ; 0b9ba
	DB 0A7h, 0C7h, 0B9h, 0CFh, 0B9h, 01h, 00h ; 0b9c2
	ASCII "x" ; 0b9c9
	DB 0AEh, 0C1h, 99h, 9Bh, 0B9h, 01h, 00h, 88h ; 0b9ca
	DB 0AFh, 0C1h, 99h, 9Bh, 0B9h, 0CEh, 0A7h, 0DDh ; 0b9d2
	DB 0B9h, 0E5h, 0B9h, 01h, 00h, 90h, 0AEh, 0C1h ; 0b9da
	DB 99h, 9Bh, 0B9h, 01h, 00h, 0A0h, 0AFh, 0C1h ; 0b9e2
	DB 99h, 9Bh, 0B9h, 7Bh, 0A7h, 0F5h, 0B9h, 0FDh ; 0b9ea
	DB 0B9h, 0F5h, 0B9h, 01h, 00h, 0C8h, 0ADh, 0C1h ; 0b9f2
	DB 99h, 9Bh, 0B9h, 01h, 00h, 0D8h, 0ADh, 0C1h ; 0b9fa
	DB 99h, 9Bh, 0B9h, 87h, 0A7h, 13h, 0BAh, 1Bh ; 0ba02
	DB 0BAh, 23h, 0BAh, 2Bh, 0BAh ; 0ba0a
	ASCII "A" ; 0ba0f
	DB 0BAh ; 0ba10
	ASCII "W" ; 0ba11
	DB 0BAh, 01h, 00h, 0A8h, 0ADh, 0C1h, 99h, 05h ; 0ba12
	DB 0BAh, 01h, 00h, 0C0h, 0ADh, 0C1h, 99h, 05h ; 0ba1a
	DB 0BAh, 01h, 00h, 0C8h, 0C1h, 0C1h, 99h, 05h ; 0ba22
	DB 0BAh, 0CEh, 0A7h ; 0ba2a
	ASCII "1" ; 0ba2d
	DB 0BAh ; 0ba2e
	ASCII "9" ; 0ba2f
	DB 0BAh, 01h, 00h, 88h, 0AEh, 0C1h, 99h, 05h ; 0ba30
	DB 0BAh, 01h, 00h, 98h, 0AFh, 0C1h, 99h, 05h ; 0ba38
	DB 0BAh, 0CEh, 0A7h ; 0ba40
	ASCII "G" ; 0ba43
	DB 0BAh ; 0ba44
	ASCII "O" ; 0ba45
	DB 0BAh, 01h, 00h, 90h, 0AEh, 0C1h, 99h, 05h ; 0ba46
	DB 0BAh, 01h, 00h, 0A0h, 0AFh, 0C1h, 99h, 05h ; 0ba4e
	DB 0BAh, 7Bh, 0A7h, 5Fh, 0BAh ; 0ba56
	ASCII "g" ; 0ba5b
	DB 0BAh, 5Fh, 0BAh, 01h, 00h, 0C8h, 0ADh, 0C1h ; 0ba5c
	DB 99h, 05h, 0BAh, 01h, 00h, 0D8h, 0ADh, 0C1h ; 0ba64
	DB 99h, 05h, 0BAh, 9Dh, 99h, 29h, 0BBh, 04h ; 0ba6c
	DB 00h ; 0ba74
	ASCII "m" ; 0ba75
	DB 1Ah, 8Eh, 99h, 9Dh, 99h, 19h, 9Bh, 0Ah ; 0ba76
	DB 00h ; 0ba7e
	ASCII "m" ; 0ba7f
	DB 1Ah, 0C1h, 99h, 2Dh, 0B9h, 9Dh, 99h, 19h ; 0ba80
	DB 9Bh, 04h, 00h, 0B4h, 0ADh, 0C1h, 99h, 2Dh ; 0ba88
	DB 0B9h, 01h, 00h, 0C4h, 0ADh, 8Eh, 99h, 9Dh ; 0ba90
	DB 99h, 19h, 9Bh, 0CEh, 0A7h, 0ADh, 0BAh, 0A1h ; 0ba98
	DB 0BAh, 10h, 00h, 0A8h, 0AFh, 10h, 00h, 0B0h ; 0baa0
	DB 0AFh, 0C1h, 99h, 0B5h, 0BAh, 10h, 00h, 98h ; 0baa8
	DB 0AEh, 10h, 00h, 0A0h, 0AEh ; 0bab0
	ASCIZ "z" ; 0bab5
	ASCII "m" ; 0bab7
	DB 1Ah, 0DBh, 0A7h, 0D1h, 0B5h, 0C1h, 99h, 0Dh ; 0bab8
	DB 0B9h, 0BEh, 3Bh, 1Bh, 0CEh, 0D0h, 2Bh, 1Bh ; 0bac0
	DB 28h, 0E6h, 0Ch, 0C4h, 0Ch, 0C0h, 0F2h ; 0bac8
	ASCII "x" ; 0bacf
	DB 0BEh, 0C4h, 17h, 9Bh, 0F1h, 16h, 0CEh, 0D0h ; 0bad0
	DB 2Ah, 1Bh, 28h, 0E6h, 0Ch, 0C4h, 0D9h, 0BFh ; 0bad8
	DB 0F2h ; 0bae0
	ASCII "f" ; 0bae1
	DB 0BEh, 0C4h, 17h, 9Bh, 0F1h, 04h, 0F2h, 05h ; 0bae2
	DB 00h, 0F2h ; 0baea
	ASCII "b" ; 0baec
	DB 0BEh, 0F8h, 0CEh, 0D0h, 15h, 1Bh ; 0baed
	ASCII "2" ; 0baf3
	DB 03h, 0E6h, 11h ; 0baf4
	ASCII "2" ; 0baf7
	DB 04h, 0E6h, 12h, 0CEh, 0D0h, 14h, 1Bh, 28h ; 0baf8
	DB 0E6h, 10h, 0C4h, 0Dh, 0B9h, 0F1h, 0Eh, 0C4h ; 0bb00
	DB 15h, 0B9h, 0F1h, 09h, 0C4h, 1Dh, 0B9h, 0F1h ; 0bb08
	DB 04h, 0C4h, 2Dh, 0B9h, 0F8h, 0B9h ; 0bb10
	ASCII "7" ; 0bb16
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0E3h ; 0bb17
	DB 0A7h, 0E7h, 07h, 0C4h, 2Dh, 0B9h, 0F2h, 28h ; 0bb1f
	DB 0BEh, 0F8h, 0C5h, 16h, 1Bh ; 0bb27
	ASCII "E(" ; 0bb2c
	DB 0E6h, 04h, 8Eh, 0E7h ; 0bb2e
	ASCII "1" ; 0bb32
	DB 0C5h, 17h, 1Bh, 0CEh, 0D0h ; 0bb33
	ASCII "B" ; 0bb38
	DB 16h, 22h, 01h, 0E6h, 0Fh, 0F2h, 16h, 0E0h ; 0bb39
	DB 0E6h, 0Ah ; 0bb41
	ASCII "E2" ; 0bb43
	DB 02h, 0E6h, 1Ch, 86h ; 0bb45
	ASCII "E" ; 0bb49
	DB 0F1h, 06h ; 0bb4a
	ASCII "E(" ; 0bb4c
	DB 0E6h, 07h, 8Eh, 0F2h ; 0bb4e
	ASCII "M" ; 0bb52
	DB 0FDh, 0F1h, 0Eh, 0B0h, 00h, 0CEh, 0D4h, 15h ; 0bb53
	DB 1Bh, 0C4h, 2Dh, 0B9h, 0F2h, 0EEh, 0BDh, 0F8h ; 0bb5b
	DB 0CEh, 0D0h, 17h, 1Bh ; 0bb63
	ASCII "2" ; 0bb67
	DB 02h, 0EAh ; 0bb68
	ASCII "q" ; 0bb6a
	DB 01h, 0F8h, 0CEh, 0D0h ; 0bb6b
	ASCII "B" ; 0bb6f
	DB 16h, 96h, 01h, 0E6h, 20h, 0CEh, 0D0h ; 0bb70
	ASCII "C" ; 0bb77
	DB 16h, 96h, 01h, 0E6h, 0Eh, 0CEh, 0D0h, 0B6h ; 0bb78
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 15h, 0CEh, 0D4h ; 0bb80
	DB 0FAh, 14h, 0C4h, 91h, 0BAh, 0F2h, 0C0h, 0BDh ; 0bb88
	DB 0F2h, 0A0h, 03h, 0F8h, 0CEh, 0D0h ; 0bb90
	ASCII "C" ; 0bb96
	DB 16h, 96h, 02h, 0E6h, 16h, 0B8h, 1Fh, 16h ; 0bb97
	DB 0D4h, 0DEh, 88h, 0E7h, 0Eh, 0B0h, 00h, 0CEh ; 0bb9f
	DB 0D4h, 15h, 1Bh, 0C4h, 0FBh, 0B8h, 0F2h, 0A0h ; 0bba7
	DB 0BDh, 0F8h, 0C5h ; 0bbaf
	ASCII "1" ; 0bbb2
	DB 0B9h, 0F3h, 9Dh, 00h, 0B0h, 00h, 0CEh, 0D4h ; 0bbb3
	DB 15h, 1Bh, 0CEh, 0D0h ; 0bbbb
	ASCII "C" ; 0bbbf
	DB 16h, 96h, 01h, 0E6h, 7Dh, 0F2h, 0C6h, 0DFh ; 0bbc0
	DB 0E7h, 3Fh, 0F2h, 8Ah, 0DFh, 0E6h, 16h, 0B0h ; 0bbc8
	DB 01h, 0CEh, 0D4h, 15h, 1Bh ; 0bbd0
	ASCII "8" ; 0bbd5
	DB 0CEh, 0D4h, 17h, 1Bh, 0F2h, 0C4h, 0FCh, 0C4h ; 0bbd6
	ASCII "o" ; 0bbde
	DB 0BAh, 0F2h ; 0bbdf
	ASCII "m" ; 0bbe1
	DB 0BDh, 0F8h, 0F2h ; 0bbe2
	ASCII "r" ; 0bbe5
	DB 01h, 0E7h, 19h, 0F2h, 0A9h, 01h, 0E7h ; 0bbe6
	ASCII "7" ; 0bbed
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 0bbee
	DB 09h, 0CEh, 0D4h, 0FAh, 14h, 0B0h, 02h, 0CEh ; 0bbf6
	DB 0D4h, 15h, 1Bh, 0C4h, 85h, 0BAh, 0F2h ; 0bbfe
	ASCII "I" ; 0bc05
	DB 0BDh, 0F8h, 0B0h, 07h, 0CEh, 0D4h, 15h, 1Bh ; 0bc06
	DB 0CEh, 0D0h, 0D7h, 1Ah ; 0bc0e
	ASCII "2" ; 0bc12
	DB 01h, 0E6h, 08h, 0C4h ; 0bc13
	ASCII "y" ; 0bc17
	DB 0BAh, 0F2h ; 0bc18
	ASCII "4" ; 0bc1a
	DB 0BDh, 0F8h, 0C4h, 98h, 0C0h, 0F2h, 2Dh, 0BDh ; 0bc1b
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 0bc23
	DB 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 01h ; 0bc2b
	DB 93h, 0B1h, 03h, 0A3h, 0F2h ; 0bc33
	ASCII "Vf" ; 0bc38
	DB 0ABh, 0B4h, 20h, 0D8h, 26h, 0BFh, 0F8h, 0CEh ; 0bc3a
	DB 0D0h, 14h, 1Bh ; 0bc42
	ASCII "2" ; 0bc45
	DB 01h, 0E7h, 08h, 0C4h, 05h, 0B9h, 0F2h, 01h ; 0bc46
	DB 0BDh, 0F8h, 0C5h, 2Dh, 0B9h, 0CEh, 0D0h ; 0bc4e
	ASCII "D" ; 0bc55
	DB 16h, 96h, 04h, 0E6h, 2Bh, 0B8h, 1Fh, 16h ; 0bc56
	DB 0D4h, 0DEh, 88h, 0E7h, 23h, 0CEh, 0D0h, 82h ; 0bc5e
	DB 1Bh, 28h, 0E7h, 1Ch, 0CEh, 0D0h, 0B6h, 1Ah ; 0bc66
	DB 20h, 0E6h, 07h, 0B0h, 05h, 0CEh, 0D4h, 0FAh ; 0bc6e
	DB 14h, 0F2h ; 0bc76
	ASCII "uf" ; 0bc78
	DB 0C5h ; 0bc7a
	ASCII "M" ; 0bc7b
	DB 91h, 0B1h, 03h, 0A3h, 0F2h, 0Dh ; 0bc7c
	ASCII "f" ; 0bc82
	DB 0ABh, 0F8h, 0CEh, 0D0h ; 0bc83
	ASCII "B" ; 0bc87
	DB 16h, 96h, 40h, 0E7h, 12h, 96h, 20h, 0E6h ; 0bc88
	DB 1Ah, 0C5h, 10h, 1Bh ; 0bc90
	ASCII "E(" ; 0bc94
	DB 0E6h, 02h, 8Eh, 0C5h, 05h, 0BAh, 0F1h, 0Dh ; 0bc96
	DB 0C5h, 10h, 1Bh ; 0bc9e
	ASCII "E2P" ; 0bca1
	DB 0E5h, 02h, 86h, 0C5h, 9Bh, 0B9h, 0CFh, 0E1h ; 0bca4
	DB 0F2h, 0A1h, 0BCh, 0C5h, 11h, 1Bh, 0CEh, 0D0h ; 0bcac
	ASCII "B" ; 0bcb4
	DB 16h, 96h, 08h, 0E7h, 0Dh, 96h, 10h, 0E6h ; 0bcb5
	DB 0Fh ; 0bcbd
	ASCII "E2:" ; 0bcbe
	DB 0E5h, 0Ah, 86h, 0F1h, 07h ; 0bcc1
	ASCII "E2" ; 0bcc6
	DB 01h, 0E4h, 02h, 8Eh, 0B8h, 10h, 1Bh, 0F2h ; 0bcc8
	DB 0B1h, 0BCh, 0F8h, 0C1h, 0BAh, 01h, 19h, 9Bh ; 0bcd0
	DB 01h, 17h, 9Bh, 00h, 0CEh, 0D0h ; 0bcd8
	ASCII "B" ; 0bcde
	DB 16h, 96h, 08h, 0E7h, 1Ah, 96h, 10h, 0E6h ; 0bcdf
	DB 2Eh, 0CEh, 0D0h, 13h, 1Bh, 0CEh, 0D1h, 23h ; 0bce7
	DB 1Bh ; 0bcef
	ASCII "1" ; 0bcf0
	DB 0E5h, 23h, 0C5h, 11h, 1Bh, 86h, 0C5h, 13h ; 0bcf1
	DB 1Bh, 86h, 0F1h, 19h, 0CEh, 0D0h, 13h, 1Bh ; 0bcf9
	ASCII "2" ; 0bd01
	DB 01h, 0E4h, 11h, 0CEh, 0D0h, 11h, 1Bh ; 0bd02
	ASCII "2" ; 0bd09
	DB 01h, 0E4h, 09h, 0C5h, 11h, 1Bh, 8Eh, 0C5h ; 0bd0a
	DB 13h, 1Bh, 8Eh, 0CEh, 0D0h ; 0bd12
	ASCII "B" ; 0bd17
	DB 16h, 96h, 20h, 0E7h, 1Fh, 96h, 40h, 0E6h ; 0bd18
	ASCII "1" ; 0bd20
	DB 0CEh, 0D0h, 10h, 1Bh ; 0bd21
	ASCII "2P" ; 0bd25
	DB 0E5h, 29h, 0CEh, 0D0h, 12h, 1Bh ; 0bd27
	ASCII "2P" ; 0bd2d
	DB 0E5h, 21h, 0C5h, 10h, 1Bh, 86h, 0C5h, 12h ; 0bd2f
	DB 1Bh, 86h, 0F1h, 17h, 0CEh, 0D0h, 10h, 1Bh ; 0bd37
	DB 28h, 0E6h, 10h, 0CEh, 0D0h, 12h, 1Bh, 28h ; 0bd3f
	DB 0E6h, 09h, 0C5h, 10h, 1Bh, 8Eh, 0C5h, 12h ; 0bd47
	DB 1Bh, 8Eh, 0B8h, 10h, 1Bh, 0F2h, 2Ch, 0BCh ; 0bd4f
	DB 0F8h, 0CEh, 0D0h, 0D8h, 1Ah ; 0bd57
	ASCII "2" ; 0bd5c
	DB 01h, 0E7h ; 0bd5d
	ASCII "2" ; 0bd5f
	DB 0CEh, 0D0h, 10h, 1Bh ; 0bd60
	ASCII "2" ; 0bd64
	DB 0Fh, 0E4h, 2Ah ; 0bd65
	ASCII "2" ; 0bd68
	DB 15h, 0E5h, 26h, 0CEh, 0D0h, 11h, 1Bh ; 0bd69
	ASCII "2" ; 0bd70
	DB 16h, 0E4h, 1Eh ; 0bd71
	ASCII "2" ; 0bd74
	DB 1Ch, 0E5h, 1Ah, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 0bd75
	DB 0E6h, 07h, 0B0h, 0Ch, 0CEh, 0D4h, 0FAh, 14h ; 0bd7d
	DB 0C5h, 0D9h, 1Ah ; 0bd85
	ASCII "E:" ; 0bd88
	DB 01h, 2Ah, 80h ; 0bd8a
	ASCII "h" ; 0bd8d
	DB 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h, 0CEh, 0D0h ; 0bd8e
	DB 0D6h, 1Ah, 28h, 0E7h, 06h, 0F2h, 0A9h, 0ECh ; 0bd96
	DB 0E6h, 24h, 0CEh, 0D0h, 0D8h, 1Ah ; 0bd9e
	ASCII "2" ; 0bda4
	DB 01h, 0E7h, 1Ch, 0CEh, 0D0h, 10h, 1Bh ; 0bda5
	ASCII "2" ; 0bdac
	DB 05h, 0E4h, 14h ; 0bdad
	ASCII "2" ; 0bdb0
	DB 16h, 0E5h, 10h, 0CEh, 0D0h, 11h, 1Bh ; 0bdb1
	ASCII "2&" ; 0bdb8
	DB 0E4h, 08h ; 0bdba
	ASCII "20" ; 0bdbc
	DB 0E5h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 0bdbe
	DB 9Dh, 99h, 5Fh, 0BEh, 01h, 00h, 0CCh, 0C1h ; 0bdc6
	DB 8Eh, 99h, 01h, 00h, 0DCh, 0C1h, 01h, 00h ; 0bdce
	DB 0D4h, 0C1h, 0C1h, 99h, 0C6h, 0BDh, 01h, 00h ; 0bdd6
	DB 0ECh, 0C1h, 01h, 00h, 0E4h, 0C1h, 0C1h, 99h ; 0bdde
	DB 0C6h, 0BDh, 01h, 00h, 0FCh, 0C1h, 01h, 00h ; 0bde6
	DB 0F4h, 0C1h, 0C1h, 99h, 0C6h, 0BDh, 01h, 00h ; 0bdee
	DB 0Ch, 0C2h, 01h, 00h, 04h, 0C2h, 0C1h, 99h ; 0bdf6
	DB 0C6h, 0BDh, 01h, 00h, 1Ch, 0C2h, 01h, 00h ; 0bdfe
	DB 14h, 0C2h, 0C1h, 99h, 0C6h, 0BDh, 01h, 00h ; 0be06
	DB 2Ch, 0C2h, 01h, 00h, 24h, 0C2h, 0C1h, 99h ; 0be0e
	DB 0C6h, 0BDh, 01h, 00h, 3Ch, 0C2h, 01h, 00h ; 0be16
	ASCII "4" ; 0be1e
	DB 0C2h, 0C1h, 99h, 0C6h, 0BDh, 01h, 00h ; 0be1f
	ASCII "L" ; 0be26
	DB 0C2h, 01h, 00h ; 0be27
	ASCII "D" ; 0be2a
	DB 0C2h, 0C1h, 99h, 0C6h, 0BDh ; 0be2b
	ASCII "8" ; 0be30
	DB 0CEh, 0D4h, 17h, 1Bh, 0CEh, 0D0h ; 0be31
	ASCII "B" ; 0be37
	DB 16h, 96h, 01h, 0E6h, 08h, 0C4h, 0C6h, 0BDh ; 0be38
	DB 0F2h, 0Dh, 0BBh, 0F8h, 0CEh, 0D0h ; 0be40
	ASCII "C" ; 0be46
	DB 16h, 96h, 02h, 0E6h, 0Eh, 0B0h, 00h, 0CEh ; 0be47
	DB 0D4h, 15h, 1Bh, 0C4h, 0FBh, 0B8h, 0F2h, 0F8h ; 0be4f
	DB 0BAh, 0F8h, 0C5h ; 0be57
	ASCII "1" ; 0be5a
	DB 0B9h, 0F3h, 0F5h, 0FDh, 0CEh, 0D0h ; 0be5b
	ASCII "B" ; 0be61
	DB 16h, 96h, 01h, 0E7h, 08h, 0C4h, 15h, 0B9h ; 0be62
	DB 0F2h, 0E3h, 0BAh, 0F8h, 0F2h, 0FBh, 0F2h, 0E6h ; 0be6a
	DB 09h, 0CEh, 0D0h ; 0be72
	ASCII "B" ; 0be75
	DB 16h, 22h ; 0be76
	ASCII "x" ; 0be78
	DB 0E7h, 0Fh, 0CEh, 0D0h, 17h, 1Bh, 28h, 0E6h ; 0be79
	ASCII "F" ; 0be81
	DB 88h, 0CEh, 0D4h, 17h, 1Bh, 0F1h, 3Fh, 0CEh ; 0be82
	DB 0D0h ; 0be8a
	ASCII "C" ; 0be8b
	DB 16h, 22h ; 0be8c
	ASCII "x" ; 0be8e
	DB 0E6h, 0Eh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 0be8f
	DB 07h, 0B0h, 13h, 0CEh, 0D4h, 0FAh, 14h, 0CEh ; 0be97
	DB 0D0h, 17h, 1Bh ; 0be9f
	ASCII "2" ; 0bea2
	DB 02h, 0E5h, 02h, 80h, 0CEh, 0D4h, 17h, 1Bh ; 0bea3
	DB 88h, 00h, 0B1h, 00h, 0A6h, 0A3h, 0C7h, 0CBh ; 0beab
	DB 0BEh, 0CFh ; 0beb3
	ASCII "B" ; 0beb5
	DB 0CEh, 0C7h, 00h, 0CFh, 0DBh, 0F2h ; 0beb6
	ASCIZ "6" ; 0bebc
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0F1h, 01h, 0F2h, 89h ; 0bebe
	DB 0BAh, 0F2h ; 0bec6
	ASCIZ "i" ; 0bec8
	DB 0F8h, 0CFh, 0BEh, 0E1h, 0BEh, 0D4h, 0BDh, 04h ; 0beca
	DB 0BEh, 1Ch, 0BEh, 0ECh, 0BDh, 28h, 0BEh, 0E0h ; 0bed2
	DB 0BDh, 0F8h, 0BDh, 10h, 0BEh, 0C6h, 0BDh, 0D0h ; 0beda
	DB 0BDh, 00h, 0BEh, 18h, 0BEh, 0E8h, 0BDh, 24h ; 0bee2
	DB 0BEh, 0DCh, 0BDh, 0Ch, 0BEh, 0F4h, 0BDh, 0C6h ; 0beea
	DB 0BDh, 0CEh, 0D0h ; 0bef2
	ASCII "B" ; 0bef5
	DB 16h, 22h ; 0bef6
	ASCII "x2" ; 0bef8
	DB 08h, 0E6h ; 0befa
	ASCII "52" ; 0befc
	DB 10h, 0E6h, 2Eh ; 0befe
	ASCII "2 " ; 0bf01
	DB 0E6h, 27h ; 0bf03
	ASCII "2@" ; 0bf05
	DB 0E6h, 20h ; 0bf07
	ASCII "2(" ; 0bf09
	DB 0E6h, 19h ; 0bf0b
	ASCII "2H" ; 0bf0d
	DB 0E6h, 12h ; 0bf0f
	ASCII "20" ; 0bf11
	DB 0E6h, 0Bh ; 0bf13
	ASCII "2P" ; 0bf15
	DB 0E6h, 04h, 0C3h, 02h, 00h, 0C3h, 02h, 00h ; 0bf17
	DB 0C3h, 02h, 00h, 0C3h, 02h, 00h, 0C3h, 02h ; 0bf1f
	DB 00h, 0C3h, 02h, 00h, 0C3h, 02h, 00h, 0C3h ; 0bf27
	DB 02h, 00h, 0F8h, 0C5h, 10h, 1Bh, 0CEh, 0D0h ; 0bf2f
	ASCII "B" ; 0bf37
	DB 16h, 96h, 40h, 0E7h, 0Ch, 96h, 20h, 0E6h ; 0bf38
	DB 0Eh ; 0bf40
	ASCII "E(" ; 0bf41
	DB 0E6h, 02h, 8Eh, 0F1h, 07h ; 0bf43
	ASCII "E2P" ; 0bf48
	DB 0E5h, 02h, 86h, 0C5h, 11h, 1Bh, 0CEh, 0D0h ; 0bf4b
	ASCII "B" ; 0bf53
	DB 16h, 96h, 08h, 0E7h, 0Dh, 96h, 10h, 0E6h ; 0bf54
	DB 0Fh ; 0bf5c
	ASCII "E2:" ; 0bf5d
	DB 0E5h, 0Ah, 86h, 0F1h, 07h ; 0bf60
	ASCII "E2" ; 0bf65
	DB 01h, 0E4h, 02h, 8Eh, 0B8h, 10h, 1Bh, 0F2h ; 0bf67
	DB 12h, 0BAh, 0F8h, 0CEh, 0D0h ; 0bf6f
	ASCII "B" ; 0bf74
	DB 16h, 96h, 01h, 0E6h, 0Eh, 0B0h, 05h, 0CEh ; 0bf75
	DB 0D4h, 15h, 1Bh, 0C4h, 25h, 0B9h, 0F2h, 0CAh ; 0bf7d
	DB 0B9h, 0F8h, 0CEh, 0D0h ; 0bf85
	ASCII "C" ; 0bf89
	DB 16h, 96h, 02h, 0E6h, 0Eh, 0B0h, 00h, 0CEh ; 0bf8a
	DB 0D4h, 15h, 1Bh, 0C4h, 0FBh, 0B8h, 0F2h, 0B5h ; 0bf92
	DB 0B9h, 0F8h, 0C5h ; 0bf9a
	ASCII "1" ; 0bf9d
	DB 0B9h, 0F3h, 0B2h, 0FCh, 0CEh, 0D0h, 15h, 1Bh ; 0bf9e
	ASCII "2" ; 0bfa6
	DB 06h, 0E7h, 15h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 0bfa7
	DB 0E6h, 07h, 0B0h, 14h, 0CEh, 0D4h, 0FAh, 14h ; 0bfaf
	DB 0C4h, 97h, 0BAh, 0F2h, 93h, 0B9h, 0F8h, 0CEh ; 0bfb7
	DB 0D0h ; 0bfbf
	ASCII "B" ; 0bfc0
	DB 16h, 96h, 01h, 0E7h, 0Eh, 0B0h, 04h, 0CEh ; 0bfc1
	DB 0D4h, 15h, 1Bh, 0C4h, 1Dh, 0B9h, 0F2h, 7Eh ; 0bfc9
	DB 0B9h, 0F8h, 0C5h ; 0bfd1
	ASCII "1" ; 0bfd4
	DB 0B9h, 0F3h, 7Bh, 0FCh, 0CEh, 0D0h ; 0bfd5
	ASCII "C" ; 0bfdb
	DB 16h, 96h, 02h, 0E6h, 2Bh, 0CEh, 0D0h, 0B6h ; 0bfdc
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h ; 0bfe4
	DB 0FAh, 14h ; 0bfec
	ASCII "8" ; 0bfee
	DB 0CEh, 0D4h, 2Ah, 1Bh, 0B0h, 00h, 0CEh, 0D4h ; 0bfef
	DB 14h, 1Bh, 0CEh, 0C4h, 03h, 0F2h, 8Eh, 0C9h ; 0bff7
	DB 0B0h, 00h, 0CEh, 0D4h, 15h, 1Bh, 0C4h, 2Dh ; 0bfff
	DB 0B9h, 0F2h ; 0c007
	ASCII "E" ; 0c009
	DB 0B9h, 0F8h, 0CEh, 0D0h ; 0c00a
	ASCII "B" ; 0c00e
	DB 16h, 28h, 0E6h, 1Dh, 0CEh, 0D0h, 0B6h, 1Ah ; 0c00f
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 0c017
	DB 14h ; 0c01f
	ASCII "8" ; 0c020
	DB 0CEh, 0D4h, 2Bh, 1Bh, 0CEh, 0D4h, 15h, 1Bh ; 0c021
	DB 0C4h, 0Dh, 0B9h, 0F2h, 21h, 0B9h, 0F8h, 01h ; 0c029
	DB 00h, 0A4h, 0ADh, 8Eh, 99h, 0CEh, 0D0h ; 0c031
	ASCII "E" ; 0c038
	DB 16h, 22h ; 0c039
	ASCII "x2" ; 0c03b
	DB 08h, 0E6h, 10h ; 0c03d
	ASCII "2" ; 0c040
	DB 10h, 0E7h, 25h, 0CEh, 0D0h, 2Dh, 1Bh ; 0c041
	ASCII "2" ; 0c048
	DB 06h, 0E5h, 1Dh, 80h, 0F1h, 09h, 0CEh, 0D0h ; 0c049
	DB 2Dh, 1Bh, 28h, 0E6h, 13h, 88h, 0CEh, 0D4h ; 0c051
	DB 2Dh, 1Bh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 0c059
	DB 07h, 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0CEh ; 0c061
	DB 0D0h, 2Dh, 1Bh, 00h, 0B1h, 00h, 0A6h, 0A3h ; 0c069
	DB 0C7h, 81h, 0C0h, 0CEh, 0C7h, 00h, 0CFh ; 0c071
	ASCII "B" ; 0c078
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0F2h, 03h, 0B9h, 0F8h ; 0c079
	DB 04h, 00h ; 0c081
	ASCIZ "4" ; 0c083
	DB 5Ch, 00h, 10h, 20h, 10h, 28h, 10h ; 0c085
	ASCII "0" ; 0c08c
	DB 10h ; 0c08d
	ASCII "8q" ; 0c08e
	DB 9Ah, 02h ; 0c090
	ASCII "6" ; 0c092
	DB 0C0h, 01h ; 0c093
	ASCII "0" ; 0c095
	DB 0C0h, 00h, 9Dh, 99h, 0ACh, 0C0h, 01h, 00h ; 0c096
	DB 0D4h, 0ADh, 8Eh, 99h, 9Dh, 99h, 0ACh, 0C0h ; 0c09e
	DB 01h, 00h, 0DCh, 0ADh, 8Eh, 99h, 0B0h, 00h ; 0c0a6
	DB 0CEh, 0D4h, 15h, 1Bh, 0F2h, 0F2h, 0DAh, 0E6h ; 0c0ae
	DB 20h, 0B9h ; 0c0b6
	ASCII "7" ; 0c0b8
	DB 1Bh, 0C1h, 14h, 00h, 0CFh, 0C0h, 0D4h ; 0c0b9
	ASCII "4" ; 0c0c0
	DB 0B4h, 0E6h, 1Ah, 0D4h, 2Ch, 0B4h, 0E6h, 06h ; 0c0c1
	DB 0D4h ; 0c0c9
	ASCII "0" ; 0c0ca
	DB 0B4h, 0E7h, 09h, 0C4h, 98h, 0C0h, 0F2h, 7Ch ; 0c0cb
	DB 0B8h, 0F1h, 0Eh, 0C4h, 2Dh, 0B9h, 0F2h ; 0c0d3
	ASCII "t" ; 0c0da
	DB 0B8h, 0F8h, 0C4h, 0A2h, 0C0h, 0F2h ; 0c0db
	ASCII "m" ; 0c0e1
	DB 0B8h, 0C5h ; 0c0e2
	ASCII "1" ; 0c0e4
	DB 0B9h, 0F3h ; 0c0e5
	ASCII "J" ; 0c0e7
	DB 0FEh, 0B0h, 02h, 0CEh, 0D4h, 1Dh, 1Bh, 0F8h ; 0c0e8
	DB 0B0h, 12h, 0CEh, 0D4h, 1Dh, 1Bh, 0F8h, 0B0h ; 0c0f0
	DB 13h, 0CEh, 0D4h, 1Dh, 1Bh, 0F8h, 0B0h, 00h ; 0c0f8
	DB 0CEh, 0D4h, 1Dh, 1Bh, 0F8h, 40h, 0A9h, 9Dh ; 0c100
	DB 99h, 0CBh, 0C3h, 04h, 00h, 0ECh, 0ADh, 04h ; 0c108
	DB 00h, 0F0h, 0ADh, 9Dh, 99h, 0C8h, 0C3h, 0C1h ; 0c110
	DB 99h, 13h, 9Bh ; 0c118
	ASCII "O" ; 0c11b
	DB 9Ah, 0Eh, 9Dh, 99h, 0CBh, 0C3h, 04h, 00h ; 0c11c
	ASCII "h" ; 0c124
	DB 0AEh, 04h, 00h ; 0c125
	ASCII "l" ; 0c128
	DB 0AEh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c129
	DB 9Bh ; 0c131
	ASCII "O" ; 0c132
	DB 9Ah, 0Eh, 9Dh, 99h, 0CBh, 0C3h, 02h, 00h ; 0c133
	DB 0F4h, 0ADh, 02h, 00h, 0F8h, 0ADh, 02h, 00h ; 0c13b
	DB 0FCh, 0ADh, 02h, 00h, 00h, 0AEh, 02h, 00h ; 0c143
	DB 0FCh, 0ADh, 05h, 00h, 00h, 0AEh, 9Dh, 99h ; 0c14b
	DB 0C8h, 0C3h, 0C1h, 99h, 13h, 9Bh ; 0c153
	ASCII "O" ; 0c159
	DB 9Ah, 0Fh, 9Dh, 99h, 0CBh, 0C3h, 04h, 00h ; 0c15a
	ASCII "p" ; 0c162
	DB 0AEh, 04h, 00h ; 0c163
	ASCII "t" ; 0c166
	DB 0AEh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c167
	DB 9Bh, 9Dh, 99h, 0C8h, 0C3h, 0Ah, 00h ; 0c16f
	ASCII "L" ; 0c176
	DB 0AEh, 0Ah, 00h ; 0c177
	ASCII "P" ; 0c17a
	DB 0AEh ; 0c17b
	ASCII "O" ; 0c17c
	DB 9Ah, 17h, 0Ah, 00h ; 0c17d
	ASCII "L" ; 0c181
	DB 0AEh, 0Ah, 00h ; 0c182
	ASCII "P" ; 0c185
	DB 0AEh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c186
	DB 9Bh, 9Dh, 99h, 0C8h, 0C3h, 05h, 00h, 04h ; 0c18e
	DB 0AEh, 01h, 00h, 08h, 0AEh, 02h, 00h, 0Ch ; 0c196
	DB 0AEh, 08h, 00h, 10h, 0AEh, 0C1h, 99h, 13h ; 0c19e
	DB 9Bh, 9Dh, 99h, 0ACh, 0C3h, 40h, 0A9h ; 0c1a6
	ASCII "O" ; 0c1ad
	DB 9Ah, 16h, 04h, 00h, 0E0h, 0ADh, 02h, 00h ; 0c1ae
	DB 0B8h, 0AEh, 02h, 00h, 0C4h, 0AEh, 04h, 00h ; 0c1b6
	DB 0E0h, 0ADh ; 0c1be
	ASCII "O" ; 0c1c0
	DB 9Ah, 16h, 02h, 00h, 0D0h, 0AEh, 02h, 00h ; 0c1c1
	DB 0DCh, 0AEh, 04h, 00h, 0E0h, 0ADh ; 0c1c9
	ASCII "O" ; 0c1cf
	DB 9Ah, 16h, 02h, 00h, 0E8h, 0AEh, 02h, 00h ; 0c1d0
	DB 0F4h, 0AEh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h ; 0c1d8
	DB 13h, 9Bh, 9Dh, 99h, 0C8h, 0C3h, 04h, 00h ; 0c1e0
	ASCII "d" ; 0c1e8
	DB 0AFh, 04h, 00h ; 0c1e9
	ASCII "h" ; 0c1ec
	DB 0AFh, 04h, 00h ; 0c1ed
	ASCII "l" ; 0c1f0
	DB 0AFh, 04h, 00h ; 0c1f1
	ASCII "d" ; 0c1f4
	DB 0AFh, 04h, 00h ; 0c1f5
	ASCII "h" ; 0c1f8
	DB 0AFh, 04h, 00h ; 0c1f9
	ASCII "l" ; 0c1fc
	DB 0AFh, 04h, 00h ; 0c1fd
	ASCII "d" ; 0c200
	DB 0AFh, 04h, 00h ; 0c201
	ASCII "h" ; 0c204
	DB 0AFh, 04h, 00h ; 0c205
	ASCII "l" ; 0c208
	DB 0AFh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c209
	DB 9Bh, 9Dh, 99h, 19h, 9Bh, 0D6h, 99h, 07h ; 0c211
	DB 00h, 2Fh, 00h, 04h, 00h ; 0c219
	ASCII "P" ; 0c21e
	DB 0B2h, 04h, 00h ; 0c21f
	ASCII "T" ; 0c222
	DB 0B2h, 03h, 00h, 5Ch, 0B2h, 9Dh, 99h, 0C8h ; 0c223
	DB 0C3h, 0C1h, 99h, 13h, 9Bh, 9Dh, 99h, 0CBh ; 0c22b
	DB 0C3h, 04h, 00h, 0E0h, 0ADh, 02h, 00h ; 0c233
	ASCII "4" ; 0c23a
	DB 0AEh, 02h, 00h, 3Ch, 0AEh, 02h, 00h ; 0c23b
	ASCII "D" ; 0c242
	DB 0AEh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c243
	DB 9Bh, 9Dh, 99h, 0CBh, 0C3h, 04h, 00h, 0E0h ; 0c24b
	DB 0ADh, 02h, 00h, 0E4h, 0AFh, 02h, 00h, 0ECh ; 0c253
	DB 0AFh, 02h, 00h, 0F4h, 0AFh, 9Dh, 99h, 0C8h ; 0c25b
	DB 0C3h, 0C1h, 99h, 13h, 9Bh, 9Dh, 99h, 0CBh ; 0c263
	DB 0C3h, 02h, 00h ; 0c26b
	ASCII "p" ; 0c26e
	DB 0AFh, 02h, 00h ; 0c26f
	ASCII "t" ; 0c272
	DB 0AFh, 02h, 00h ; 0c273
	ASCII "x" ; 0c276
	DB 0AFh, 9Dh, 99h, 0C8h, 0C3h, 02h, 00h, 0E0h ; 0c277
	DB 0ADh, 9Dh, 99h, 0CBh, 0C3h, 02h, 00h ; 0c27f
	ASCII "p" ; 0c286
	DB 0AFh, 02h, 00h ; 0c287
	ASCII "t" ; 0c28a
	DB 0AFh, 02h, 00h ; 0c28b
	ASCII "x" ; 0c28e
	DB 0AFh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c28f
	DB 9Bh, 9Dh, 99h, 0CBh, 0C3h, 04h, 00h, 5Ch ; 0c297
	DB 0AEh, 04h, 00h, 60h, 0AEh, 05h, 00h ; 0c29f
	ASCII "d" ; 0c2a6
	DB 0AEh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c2a7
	DB 9Bh, 9Dh, 99h, 0CBh, 0C3h, 04h, 00h, 7Ch ; 0c2af
	DB 0AFh, 04h, 00h, 80h, 0AFh, 04h, 00h, 84h ; 0c2b7
	DB 0AFh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c2bf
	DB 9Bh, 9Dh, 99h, 0CBh, 0C3h, 14h, 00h, 0D8h ; 0c2c7
	DB 0AFh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c2cf
	DB 9Bh, 9Dh, 99h, 0CBh, 0C3h, 0Ah, 00h, 0DCh ; 0c2d7
	DB 0AFh, 0Ah, 00h, 0E0h, 0AFh, 0Ah, 00h, 0DCh ; 0c2df
	DB 0AFh, 0Ah, 00h, 0E0h, 0AFh, 9Dh, 99h, 0C8h ; 0c2e7
	DB 0C3h, 0C1h, 99h, 13h, 9Bh, 9Dh, 99h, 0CBh ; 0c2ef
	DB 0C3h, 0Ah, 00h, 0E0h, 0ADh, 02h, 00h, 14h ; 0c2f7
	DB 0AEh, 04h, 00h, 18h, 0AEh, 02h, 00h, 1Ch ; 0c2ff
	DB 0AEh, 06h, 00h, 0E0h, 0ADh, 02h, 00h, 20h ; 0c307
	DB 0AEh, 04h, 00h, 24h, 0AEh, 02h, 00h, 28h ; 0c30f
	DB 0AEh, 06h, 00h, 0E0h, 0ADh, 9Dh, 99h, 0C8h ; 0c317
	DB 0C3h, 0C1h, 99h, 13h, 9Bh, 9Dh, 99h, 0CBh ; 0c31f
	DB 0C3h, 0Ah, 00h, 0E0h, 0ADh, 04h, 00h, 2Ch ; 0c327
	DB 0AEh, 04h, 00h ; 0c32f
	ASCII "0" ; 0c332
	DB 0AEh, 04h, 00h, 2Ch, 0AEh, 04h, 00h ; 0c333
	ASCII "0" ; 0c33a
	DB 0AEh, 04h, 00h, 2Ch, 0AEh, 04h, 00h ; 0c33b
	ASCII "0" ; 0c342
	DB 0AEh, 9Dh, 99h, 0C8h, 0C3h, 0C1h, 99h, 13h ; 0c343
	DB 9Bh, 0CEh, 0D0h, 1Ch, 1Bh ; 0c34b
	ASCII "2" ; 0c350
	DB 1Ah, 0E4h, 03h, 0B0h, 1Ah, 00h, 0B1h, 00h ; 0c351
	DB 0A6h, 0A3h, 0C7h ; 0c359
	ASCII "v" ; 0c35c
	DB 0C3h, 0CEh, 0C7h, 00h, 0CFh ; 0c35d
	ASCII "B" ; 0c362
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0D4h, 0FFh, 0FFh, 0E6h ; 0c363
	DB 04h, 0F2h, 0E1h, 0B5h, 0CEh, 0C4h, 02h, 0F2h ; 0c36b
	DB 3Eh, 0E6h, 0F8h, 0FFh, 0FFh, 05h, 0C1h, 0FFh ; 0c373
	DB 0FFh, 1Bh, 0C1h ; 0c37b
	ASCII "p" ; 0c37e
	DB 0C1h, 87h, 0C1h, 8Fh, 0C1h, 0A7h, 0C1h, 0E2h ; 0c37f
	DB 0C1h, 0FFh, 0FFh, 12h, 0C2h ; 0c387
	ASCII "0" ; 0c38c
	DB 0C2h ; 0c38d
	ASCII "h" ; 0c38e
	DB 0C2h, 0FFh, 0FFh ; 0c38f
	ASCII "Y" ; 0c392
	DB 0C1h ; 0c393
	ASCII "2" ; 0c394
	DB 0C1h, 98h, 0C2h, 0B0h, 0C2h, 0FFh, 0FFh, 0FFh ; 0c395
	DB 0FFh, 0C8h, 0C2h, 0D8h, 0C2h, 07h, 0C1h ; 0c39d
	ASCII "L" ; 0c3a4
	DB 0C2h, 0F4h, 0C2h, 24h, 0C3h, 0FFh, 0FFh, 0F2h ; 0c3a5
	DB 9Eh, 0FFh, 0C5h, 29h, 20h, 0CEh, 0D0h, 0D7h ; 0c3ad
	DB 1Ah, 28h, 0E6h, 0Ah, 0C5h, 1Ch, 1Dh, 88h ; 0c3b5
	DB 0E6h, 04h, 0C5h, 27h, 23h, 0CFh, 0E1h, 0F2h ; 0c3bd
	DB 0BCh, 0B5h, 0F8h, 0F2h, 82h, 0FFh, 0CEh, 0D0h ; 0c3c5
	DB 14h, 1Bh, 28h, 0E6h, 06h, 0C4h, 3Ah, 2Ah ; 0c3cd
	DB 0F1h, 04h, 0B8h, 12h, 1Bh, 0F2h, 0A6h, 0B5h ; 0c3d5
	DB 0F8h ; 0c3dd
	ASCII "q" ; 0c3de
	DB 9Ah, 02h, 0C8h, 0C3h, 01h, 17h, 9Bh, 00h ; 0c3df
	DB 0C1h, 99h, 0EEh, 0C3h ; 0c3e7
	ASCII "O" ; 0c3eb
	DB 9Ah, 0Fh, 9Dh, 99h, 26h, 0C4h, 04h, 00h ; 0c3ec
	DB 0E4h, 0ADh, 04h, 00h, 0E8h, 0ADh, 9Dh, 99h ; 0c3f4
	DB 02h, 0C4h, 0C1h, 99h, 13h, 9Bh, 0CEh, 0D0h ; 0c3fc
	DB 1Dh, 1Bh ; 0c404
	ASCII "2" ; 0c406
	DB 13h, 0E6h, 0Fh ; 0c407
	ASCII "2" ; 0c40a
	DB 12h, 0E6h, 10h ; 0c40b
	ASCII "2" ; 0c40e
	DB 02h, 0E6h, 02h, 0F8h, 0C4h, 0EBh, 0C3h, 0F1h ; 0c40f
	DB 09h, 0C4h, 0E7h, 0C3h, 0F1h, 04h, 0C4h, 0EBh ; 0c417
	DB 0C3h, 0F2h, 2Dh, 0B5h, 0F2h, 0D9h, 0FCh, 0CEh ; 0c41f
	DB 0D0h, 14h, 1Bh, 28h, 0E6h, 06h, 0C4h, 3Ah ; 0c427
	DB 2Ah, 0F1h, 10h, 0B8h, 12h, 1Bh, 0CEh, 0BCh ; 0c42f
	DB 10h, 0E4h, 06h, 0CEh, 0BCh ; 0c437
	ASCII "P" ; 0c43c
	DB 0E4h, 03h, 0B1h, 10h, 0F2h, 3Fh, 0B5h, 0F8h ; 0c43d
	ASCII "q" ; 0c445
	DB 9Ah, 02h, 02h, 0C4h, 01h, 17h, 9Bh, 00h ; 0c446
	DB 0A3h, 0A8h, 01h, 00h, 5Ch, 0B1h, 0C1h, 99h ; 0c44e
	ASCII "N" ; 0c456
	DB 0C4h, 08h, 00h ; 0c457
	ASCII "d" ; 0c45a
	DB 0B1h, 06h, 00h, 5Ch, 0B1h, 08h, 00h ; 0c45b
	ASCII "t" ; 0c462
	DB 0B1h, 06h, 00h, 5Ch, 0B1h, 0A3h, 0A8h, 0C1h ; 0c463
	DB 99h ; 0c46b
	ASCII "X" ; 0c46c
	DB 0C4h, 04h, 00h ; 0c46d
	ASCII "d" ; 0c470
	DB 0B1h, 05h, 00h ; 0c471
	ASCII "l" ; 0c474
	DB 0B1h, 04h, 00h ; 0c475
	ASCII "d" ; 0c478
	DB 0B1h, 04h, 00h, 5Ch, 0B1h, 04h, 00h ; 0c479
	ASCII "t" ; 0c480
	DB 0B1h, 05h, 00h, 7Ch, 0B1h, 04h, 00h ; 0c481
	ASCII "t" ; 0c488
	DB 0B1h, 04h, 00h, 5Ch, 0B1h, 0A3h, 0A8h, 0C1h ; 0c489
	DB 99h ; 0c491
	ASCII "n" ; 0c492
	DB 0C4h, 04h, 00h ; 0c493
	ASCII "d" ; 0c496
	DB 0B1h, 05h, 00h ; 0c497
	ASCII "l" ; 0c49a
	DB 0B1h, 04h, 00h ; 0c49b
	ASCII "d" ; 0c49e
	DB 0B1h, 04h, 00h, 5Ch, 0B1h, 04h, 00h ; 0c49f
	ASCII "t" ; 0c4a6
	DB 0B1h, 03h, 00h, 7Ch, 0B1h, 02h, 00h, 7Ch ; 0c4a7
	DB 0B1h, 04h, 00h ; 0c4af
	ASCII "t" ; 0c4b2
	DB 0B1h, 0Ah, 00h, 5Ch, 0B1h, 04h, 00h, 5Ch ; 0c4b3
	DB 0B1h, 14h, 00h, 5Ch, 0B1h, 0A3h, 0A8h, 0C1h ; 0c4bb
	DB 99h, 94h, 0C4h ; 0c4c3
	ASCII "q" ; 0c4c6
	DB 9Ah, 02h, 19h, 9Bh, 01h ; 0c4c7
	ASCII "N" ; 0c4cc
	DB 0C4h, 00h, 9Dh, 99h, 19h, 9Bh, 04h, 00h ; 0c4cd
	ASCII "h" ; 0c4d5
	DB 0B6h, 04h, 00h ; 0c4d6
	ASCII "h" ; 0c4d9
	DB 0B6h, 04h, 00h ; 0c4da
	ASCII "p" ; 0c4dd
	DB 0B6h, 04h, 00h ; 0c4de
	ASCII "p" ; 0c4e1
	DB 0B6h, 04h, 00h ; 0c4e2
	ASCII "h" ; 0c4e5
	DB 0B6h, 04h, 00h ; 0c4e6
	ASCII "h" ; 0c4e9
	DB 0B6h, 04h, 00h ; 0c4ea
	ASCII "p" ; 0c4ed
	DB 0B6h, 04h, 00h ; 0c4ee
	ASCII "p" ; 0c4f1
	DB 0B6h, 0EAh, 0A8h, 0C1h, 99h, 0CFh, 0C4h, 9Dh ; 0c4f2
	DB 99h, 19h, 9Bh, 03h, 00h ; 0c4fa
	ASCII "h" ; 0c4ff
	DB 0B6h, 03h, 00h ; 0c500
	ASCII "h" ; 0c503
	DB 0B6h, 03h, 00h ; 0c504
	ASCII "p" ; 0c507
	DB 0B6h, 03h, 00h ; 0c508
	ASCII "p" ; 0c50b
	DB 0B6h, 03h, 00h ; 0c50c
	ASCII "h" ; 0c50f
	DB 0B6h, 03h, 00h ; 0c510
	ASCII "h" ; 0c513
	DB 0B6h, 03h, 00h ; 0c514
	ASCII "p" ; 0c517
	DB 0B6h, 03h, 00h ; 0c518
	ASCII "p" ; 0c51b
	DB 0B6h, 0EAh, 0A8h, 0C1h, 99h, 0F9h, 0C4h, 9Dh ; 0c51c
	DB 99h, 19h, 9Bh, 02h, 00h ; 0c524
	ASCII "h" ; 0c529
	DB 0B6h, 02h, 00h ; 0c52a
	ASCII "h" ; 0c52d
	DB 0B6h, 02h, 00h ; 0c52e
	ASCII "p" ; 0c531
	DB 0B6h, 02h, 00h ; 0c532
	ASCII "p" ; 0c535
	DB 0B6h, 02h, 00h ; 0c536
	ASCII "h" ; 0c539
	DB 0B6h, 02h, 00h ; 0c53a
	ASCII "h" ; 0c53d
	DB 0B6h, 02h, 00h ; 0c53e
	ASCII "p" ; 0c541
	DB 0B6h, 02h, 00h ; 0c542
	ASCII "p" ; 0c545
	DB 0B6h, 0EAh, 0A8h, 0C1h, 99h, 23h, 0C5h, 9Dh ; 0c546
	DB 99h, 19h, 9Bh, 01h, 00h ; 0c54e
	ASCII "h" ; 0c553
	DB 0B6h, 01h, 00h ; 0c554
	ASCII "h" ; 0c557
	DB 0B6h, 01h, 00h ; 0c558
	ASCII "p" ; 0c55b
	DB 0B6h, 01h, 00h ; 0c55c
	ASCII "p" ; 0c55f
	DB 0B6h, 01h, 00h ; 0c560
	ASCII "h" ; 0c563
	DB 0B6h, 01h, 00h ; 0c564
	ASCII "h" ; 0c567
	DB 0B6h, 01h, 00h ; 0c568
	ASCII "p" ; 0c56b
	DB 0B6h, 01h, 00h ; 0c56c
	ASCII "p" ; 0c56f
	DB 0B6h, 0EAh, 0A8h, 0C1h, 99h ; 0c570
	ASCII "M" ; 0c575
	DB 0C5h, 9Dh, 99h, 9Bh, 0C5h, 01h, 00h, 60h ; 0c576
	DB 0B6h, 8Eh, 99h, 9Dh, 99h, 9Bh, 0C5h, 02h ; 0c57e
	DB 00h ; 0c586
	ASCII "x" ; 0c587
	DB 0B6h, 8Eh, 99h, 9Dh, 99h, 9Bh, 0C5h, 28h ; 0c588
	DB 00h, 60h, 0B6h, 28h, 00h ; 0c590
	ASCII "h" ; 0c595
	DB 0B6h, 0C1h, 99h, 8Fh, 0C5h, 0B9h ; 0c596
	ASCII "7" ; 0c59c
	DB 1Bh, 0C1h, 18h, 00h, 0CFh, 0C0h, 0D4h, 0A5h ; 0c59d
	DB 98h, 0E7h, 06h, 0C4h, 0CFh, 0C4h, 0F1h, 25h ; 0c5a5
	DB 0B9h ; 0c5ad
	ASCII "7" ; 0c5ae
	DB 1Bh, 0C1h, 14h, 00h, 0CFh, 0C0h, 0D4h, 98h ; 0c5af
	DB 0B6h, 0E4h, 0Bh, 0D4h, 9Ch, 0B6h, 0E4h, 0Bh ; 0c5b7
	DB 0D4h, 0BDh, 0B6h, 0E4h, 0Bh, 0C4h, 8Bh, 0C5h ; 0c5bf
	DB 0F1h, 09h, 0C4h, 81h, 0C5h, 0F1h, 04h, 0C4h ; 0c5c7
	ASCII "w" ; 0c5cf
	DB 0C5h, 0CEh ; 0c5d0
	ASCII "P" ; 0c5d2
	DB 18h, 0CEh ; 0c5d3
	ASCII "X" ; 0c5d5
	DB 19h, 0CFh ; 0c5d6
	ASCII "8" ; 0c5d8
	DB 0E6h, 0Ah, 0CEh ; 0c5d9
	ASCII "D" ; 0c5dc
	DB 18h, 0CEh ; 0c5dd
	ASCII "L" ; 0c5df
	DB 19h, 0F2h ; 0c5e0
	ASCII "l" ; 0c5e2
	DB 0B3h, 0F8h ; 0c5e3
	ASCII "q" ; 0c5e5
	DB 9Ah, 02h, 9Bh, 0C5h, 01h, 8Bh, 0C5h, 00h ; 0c5e6
	DB 0CEh, 0D0h, 1Ch, 1Bh ; 0c5ee
	ASCII "2" ; 0c5f2
	DB 0Dh, 0E6h, 10h ; 0c5f3
	ASCII "2" ; 0c5f6
	DB 09h, 0E6h, 07h ; 0c5f7
	ASCIZ "2" ; 0c5fa
	DB 0E6h, 14h, 0F1h, 06h, 0C4h ; 0c5fc
	ASCII "0" ; 0c601
	DB 0C6h, 0F1h, 04h, 0C4h ; 0c602
	ASCII "B" ; 0c606
	DB 0C6h, 0F2h ; 0c607
	ASCII "E" ; 0c609
	DB 0B3h, 0CEh, 0C4h, 02h, 0F2h, 0A2h, 0E3h, 0F8h ; 0c60a
	DB 0CEh, 0D0h, 1Ch, 1Bh ; 0c612
	ASCII "2" ; 0c616
	DB 0Dh, 0E6h, 0Ah ; 0c617
	ASCII "2" ; 0c61a
	DB 09h, 0E7h, 12h, 0C4h ; 0c61b
	ASCII "0" ; 0c61f
	DB 0C6h, 0F1h, 04h, 0C4h ; 0c620
	ASCII "B" ; 0c624
	DB 0C6h, 0F2h, 27h, 0B3h, 0CEh, 0C4h, 02h, 0F2h ; 0c625
	DB 84h, 0E3h, 0F8h, 9Dh, 99h, 19h, 9Bh, 02h ; 0c62d
	DB 00h, 0Ch, 0B2h, 9Dh, 99h, 0EEh, 0C5h, 01h ; 0c635
	DB 00h, 10h, 0B2h, 8Eh, 99h, 02h, 00h, 0Ch ; 0c63d
	DB 0B2h, 02h, 00h, 04h, 0B2h, 02h, 00h, 08h ; 0c645
	DB 0B2h, 9Dh, 99h, 12h, 0C6h, 01h, 00h, 04h ; 0c64d
	DB 0B2h, 8Eh, 99h ; 0c655
	ASCII "q" ; 0c658
	DB 9Ah, 02h, 12h, 0C6h, 01h ; 0c659
	ASCII "R" ; 0c65e
	DB 0C6h, 00h ; 0c65f
	ASCII "O" ; 0c661
	DB 9Ah, 12h, 9Dh, 99h, 19h, 9Bh, 02h, 00h ; 0c662
	ASCII "h" ; 0c66a
	DB 0B7h, 02h, 00h ; 0c66b
	ASCII "l" ; 0c66e
	DB 0B7h, 02h, 00h ; 0c66f
	ASCII "p" ; 0c672
	DB 0B7h, 9Dh, 99h, 0A8h, 0C6h, 8Eh, 99h ; 0c673
	ASCII "O" ; 0c67a
	DB 9Ah, 12h, 9Dh, 99h, 19h, 9Bh, 02h, 00h ; 0c67b
	ASCII "p" ; 0c683
	DB 0B7h, 02h, 00h ; 0c684
	ASCII "l" ; 0c687
	DB 0B7h, 02h, 00h ; 0c688
	ASCII "h" ; 0c68b
	DB 0B7h, 02h, 00h ; 0c68c
	ASCII "l" ; 0c68f
	DB 0B7h, 9Dh, 99h, 0A8h, 0C6h, 8Eh, 99h, 01h ; 0c690
	DB 00h ; 0c698
	ASCII "t" ; 0c699
	DB 0B7h, 8Eh, 99h, 01h, 00h ; 0c69a
	ASCII "x" ; 0c69f
	DB 0B7h, 8Eh, 99h ; 0c6a0
	ASCII "8" ; 0c6a3
	DB 0CEh ; 0c6a4
	ASCII "D" ; 0c6a5
	DB 1Ah, 0F8h, 0CEh, 0D0h, 14h, 1Bh ; 0c6a6
	ASCIZ "2" ; 0c6ac
	DB 0E6h, 08h, 0C4h, 13h, 9Bh, 0F2h, 9Ah, 0B2h ; 0c6ae
	DB 0F8h, 0CEh, 0D0h, 13h, 1Bh, 0CEh, 0D1h, 23h ; 0c6b6
	DB 1Bh ; 0c6be
	ASCII "1" ; 0c6bf
	DB 0E7h, 5Dh, 0A6h, 0A3h, 0A2h, 0BAh ; 0c6c0
	ASCII "7" ; 0c6c6
	DB 1Bh, 0CEh, 40h, 14h, 0CEh ; 0c6c7
	ASCII "H" ; 0c6cc
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 0c6cd
	DB 0CEh ; 0c6d5
	ASCII "A" ; 0c6d6
	DB 01h, 0CEh ; 0c6d7
	ASCII "P" ; 0c6d9
	DB 02h, 0CEh ; 0c6da
	ASCII "X" ; 0c6dc
	DB 03h, 0AAh, 0ABh, 0AEh, 96h, 80h, 0E7h, 3Ah ; 0c6dd
	DB 0D5h, 89h, 99h, 0E4h, 10h, 0D5h, 9Eh, 99h ; 0c6e5
	DB 0E4h, 26h, 0D5h, 0F8h, 99h, 0E4h, 2Bh, 0D5h ; 0c6ed
	DB 11h, 9Ah, 0E4h, 21h, 0C5h, 97h, 0C6h, 0CEh ; 0c6f5
	DB 40h, 1Ah, 3Ah, 01h, 0CEh ; 0c6fd
	ASCII "D" ; 0c702
	DB 1Ah, 0E6h, 04h, 0C5h, 9Dh, 0C6h, 0CEh, 40h ; 0c703
	DB 18h, 0CEh ; 0c70b
	ASCII "H" ; 0c70d
	DB 19h, 0D4h, 13h, 9Bh, 0E7h, 19h, 0C5h ; 0c70e
	ASCII "a" ; 0c715
	DB 0C6h, 0F1h, 14h, 0C5h ; 0c716
	ASCII "z" ; 0c71a
	DB 0C6h, 0F1h, 0Fh, 0CEh, 40h, 18h, 0CEh ; 0c71b
	ASCII "H" ; 0c722
	DB 19h, 0D4h, 97h, 0C6h, 0E5h, 0F1h, 0C5h, 13h ; 0c723
	DB 9Bh, 0CEh ; 0c72b
	ASCII "T" ; 0c72d
	DB 18h, 0CEh, 5Ch, 19h, 0CFh, 0E1h, 0F2h, 19h ; 0c72e
	DB 0B2h, 0A6h, 0A3h, 0A2h, 0BAh ; 0c736
	ASCII "7" ; 0c73b
	DB 1Bh, 0CEh, 40h, 14h, 0CEh ; 0c73c
	ASCII "H" ; 0c741
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 0c742
	DB 0CEh, 0D1h, 23h, 1Bh ; 0c74a
	ASCII "G" ; 0c74e
	DB 0CEh, 00h, 0Ah, 0AAh, 0ABh, 0AEh, 0F2h, 2Bh ; 0c74f
	DB 0B2h, 0F8h, 0A3h, 0C6h, 01h, 0A8h, 0C6h, 01h ; 0c757
	DB 97h, 0C6h, 00h, 9Dh, 99h ; 0c75f
	ASCII "F" ; 0c764
	DB 0C8h, 04h, 00h, 0F4h, 0B3h, 06h, 00h, 0F4h ; 0c765
	DB 0B3h, 04h, 00h, 0F4h, 0B3h, 9Dh, 99h ; 0c76d
	ASCII "Z" ; 0c774
	DB 0C8h, 01h, 00h, 0F4h, 0B3h, 8Eh, 99h, 9Dh ; 0c775
	DB 99h, 08h, 0C8h, 06h, 00h, 04h, 0B4h, 9Dh ; 0c77d
	DB 99h, 20h, 0C8h, 06h, 00h, 0FCh, 0B3h, 04h ; 0c785
	DB 00h, 0F4h, 0B3h, 04h, 00h, 0F4h, 0B3h, 06h ; 0c78d
	DB 00h, 0F4h, 0B3h, 06h, 00h, 0F4h, 0B3h, 04h ; 0c795
	DB 00h, 0F4h, 0B3h, 04h, 00h, 0FCh, 0B3h, 04h ; 0c79d
	DB 00h, 0F4h, 0B3h, 9Dh, 99h ; 0c7a5
	ASCII "Z" ; 0c7aa
	DB 0C8h, 8Eh, 99h, 9Dh, 99h ; 0c7ab
	ASCII "Z" ; 0c7b0
	DB 0C8h, 01h, 00h, 0FCh, 0B3h, 8Eh, 99h, 9Dh ; 0c7b1
	DB 99h ; 0c7b9
	ASCII "Z" ; 0c7ba
	DB 0C8h, 06h, 00h, 0FCh, 0B3h, 04h, 00h, 0F4h ; 0c7bb
	DB 0B3h, 06h, 00h, 0F4h, 0B3h, 04h, 00h, 0F4h ; 0c7c3
	DB 0B3h, 8Eh, 99h, 9Dh, 99h, 20h, 0C8h, 04h ; 0c7cb
	DB 00h, 0F4h, 0B3h, 06h, 00h, 0F4h, 0B3h, 04h ; 0c7d3
	DB 00h, 0F4h, 0B3h, 04h, 00h, 0FCh, 0B3h, 04h ; 0c7db
	DB 00h, 0F4h, 0B3h, 9Dh, 99h ; 0c7e3
	ASCII "Z" ; 0c7e8
	DB 0C8h, 8Eh, 99h, 9Dh, 99h, 19h, 9Bh, 06h ; 0c7e9
	DB 00h, 0FCh, 0B3h, 04h, 00h, 0F4h, 0B3h, 06h ; 0c7f1
	DB 00h, 0F4h, 0B3h, 04h, 00h, 0F4h, 0B3h, 9Dh ; 0c7f9
	DB 99h, 0BEh, 0C8h, 0C1h, 99h, 13h, 9Bh, 0B9h ; 0c801
	ASCII "7" ; 0c809
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h ; 0c80a
	ASCII "w" ; 0c811
	DB 0A6h, 0E7h, 08h, 0C4h, 84h, 0C7h, 0F2h ; 0c812
	ASCII "5" ; 0c819
	DB 0B1h, 0F8h, 0F2h, 02h, 00h, 0F8h, 0B9h ; 0c81a
	ASCII "7" ; 0c821
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0BEh ; 0c822
	DB 0A4h, 0E6h, 13h, 0D4h ; 0c82a
	ASCII "9" ; 0c82e
	DB 0A5h, 0E6h, 06h, 0D4h, 0FCh, 0A4h, 0E7h, 0Fh ; 0c82f
	DB 0C4h, 0AEh, 0C7h, 0F2h, 13h, 0B1h, 0F1h, 07h ; 0c837
	DB 0C4h ; 0c83f
	ASCII "b" ; 0c840
	DB 0C7h, 0F2h, 0Bh, 0B1h, 0F8h, 0B9h ; 0c841
	ASCII "7" ; 0c847
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0FCh ; 0c848
	DB 0A4h, 0E7h, 07h, 0C4h, 0AEh, 0C7h, 0F2h, 0F7h ; 0c850
	DB 0B0h, 0F8h, 0B9h ; 0c858
	ASCII "7" ; 0c85b
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0BDh ; 0c85c
	DB 0A4h, 0E4h, 2Eh, 0D4h, 0BEh, 0A4h, 0E6h ; 0c864
	ASCII "3" ; 0c86b
	DB 0D4h, 0FCh, 0A4h, 0E6h ; 0c86c
	ASCII "3" ; 0c870
	DB 0D4h ; 0c871
	ASCII "9" ; 0c872
	DB 0A5h, 0E6h, 2Eh, 0D4h, 0A1h, 0A5h, 0E6h ; 0c873
	ASCII "3" ; 0c87a
	DB 0D4h, 10h, 0A6h, 0E6h, 29h, 0D4h ; 0c87b
	ASCII "w" ; 0c881
	DB 0A6h, 0E6h ; 0c882
	ASCII "3" ; 0c884
	DB 0D4h, 0D2h, 0A6h, 0E6h, 29h, 0D4h, 1Bh, 0A7h ; 0c885
	DB 0E5h, 06h, 0C4h ; 0c88d
	ASCII "r" ; 0c890
	DB 0C7h, 0F1h, 27h, 0C5h, 0BEh, 0C8h, 0C4h, 13h ; 0c891
	DB 9Bh, 0F2h, 0D4h, 0B0h, 0F8h, 0C4h ; 0c899
	ASCII "b" ; 0c89f
	DB 0C7h, 0F1h, 18h, 0C4h, 0AEh, 0C7h, 0F1h, 13h ; 0c8a0
	DB 0C4h, 0B8h, 0C7h, 0F1h, 0Eh, 0C4h, 7Ch, 0C7h ; 0c8a8
	DB 0F1h, 09h, 0C4h, 0ECh, 0C7h, 0F1h, 04h, 0C4h ; 0c8b0
	DB 0CEh, 0C7h, 0F2h, 93h, 0B0h, 0F8h, 0B9h ; 0c8b8
	ASCII "7" ; 0c8bf
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0FCh ; 0c8c0
	DB 0A4h, 0E4h, 0Ch, 0D4h, 1Bh, 0A7h, 0E5h, 07h ; 0c8c8
	DB 0C4h ; 0c8d0
	ASCII "r" ; 0c8d1
	DB 0C7h, 0F2h ; 0c8d2
	ASCII "z" ; 0c8d4
	DB 0B0h, 0F8h, 0CEh, 0D0h, 0D8h, 1Ah ; 0c8d5
	ASCIZ "2" ; 0c8db
	DB 0E7h, 0Fh, 0CEh, 0D0h, 0D7h, 1Ah ; 0c8dd
	ASCII "2" ; 0c8e3
	DB 01h, 0E7h, 07h, 0C4h, 0BEh, 0C8h, 0F2h, 5Ch ; 0c8e4
	DB 0B0h, 0F8h, 0D7h, 0C8h, 01h, 19h, 9Bh, 01h ; 0c8ec
	DB 17h, 9Bh, 00h, 9Dh, 99h, 0D7h, 0C9h, 04h ; 0c8f4
	DB 00h, 0E0h, 0B3h, 06h, 00h, 0E4h, 0B3h, 04h ; 0c8fc
	DB 00h, 0E0h, 0B3h, 9Dh, 99h, 0EBh, 0C9h, 01h ; 0c904
	DB 00h, 0E0h, 0B3h, 8Eh, 99h, 9Dh, 99h, 99h ; 0c90c
	DB 0C9h, 06h, 00h, 0E8h, 0B3h, 9Dh, 99h, 0B1h ; 0c914
	DB 0C9h, 06h, 00h, 0E4h, 0B3h, 04h, 00h, 0E0h ; 0c91c
	DB 0B3h, 04h, 00h, 0ECh, 0B3h, 06h, 00h, 0F0h ; 0c924
	DB 0B3h, 06h, 00h, 0ECh, 0B3h, 04h, 00h, 0E0h ; 0c92c
	DB 0B3h, 04h, 00h, 0E4h, 0B3h, 04h, 00h, 0E0h ; 0c934
	DB 0B3h, 9Dh, 99h, 0EBh, 0C9h, 8Eh, 99h, 9Dh ; 0c93c
	DB 99h, 0EBh, 0C9h, 01h, 00h, 0E4h, 0B3h, 8Eh ; 0c944
	DB 99h, 9Dh, 99h, 0EBh, 0C9h, 06h, 00h, 0E4h ; 0c94c
	DB 0B3h, 04h, 00h, 0E0h, 0B3h, 06h, 00h, 0ECh ; 0c954
	DB 0B3h, 04h, 00h, 0E0h, 0B3h, 8Eh, 99h, 9Dh ; 0c95c
	DB 99h, 0B1h, 0C9h, 04h, 00h, 0E0h, 0B3h, 06h ; 0c964
	DB 00h, 0ECh, 0B3h, 04h, 00h, 0E0h, 0B3h, 04h ; 0c96c
	DB 00h, 0E4h, 0B3h, 04h, 00h, 0E0h, 0B3h, 9Dh ; 0c974
	DB 99h, 0EBh, 0C9h, 8Eh, 99h, 9Dh, 99h, 19h ; 0c97c
	DB 9Bh, 06h, 00h, 0E4h, 0B3h, 04h, 00h, 0E0h ; 0c984
	DB 0B3h, 06h, 00h, 0ECh, 0B3h, 04h, 00h, 0E0h ; 0c98c
	DB 0B3h, 0C1h, 99h, 07h, 0C9h, 0B9h ; 0c994
	ASCII "7" ; 0c99a
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h ; 0c99b
	ASCII "w" ; 0c9a2
	DB 0A6h, 0E7h, 08h, 0C4h, 19h, 0C9h, 0F2h, 0A4h ; 0c9a3
	DB 0AFh, 0F8h, 0F2h, 02h, 00h, 0F8h, 0B9h ; 0c9ab
	ASCII "7" ; 0c9b2
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0BEh ; 0c9b3
	DB 0A4h, 0E6h, 13h, 0D4h ; 0c9bb
	ASCII "9" ; 0c9bf
	DB 0A5h, 0E6h, 06h, 0D4h, 0FCh, 0A4h, 0E7h, 0Fh ; 0c9c0
	DB 0C4h ; 0c9c8
	ASCII "C" ; 0c9c9
	DB 0C9h, 0F2h, 82h, 0AFh, 0F1h, 07h, 0C4h, 0F7h ; 0c9ca
	DB 0C8h, 0F2h ; 0c9d2
	ASCII "z" ; 0c9d4
	DB 0AFh, 0F8h, 0B9h ; 0c9d5
	ASCII "7" ; 0c9d8
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0FCh ; 0c9d9
	DB 0A4h, 0E7h, 07h, 0C4h ; 0c9e1
	ASCII "C" ; 0c9e5
	DB 0C9h, 0F2h ; 0c9e6
	ASCII "f" ; 0c9e8
	DB 0AFh, 0F8h, 0B9h ; 0c9e9
	ASCII "7" ; 0c9ec
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0BDh ; 0c9ed
	DB 0A4h, 0E4h, 2Eh, 0D4h, 0BEh, 0A4h, 0E6h, 2Eh ; 0c9f5
	DB 0D4h, 0FCh, 0A4h, 0E6h, 2Eh, 0D4h ; 0c9fd
	ASCII "9" ; 0ca03
	DB 0A5h, 0E6h, 29h, 0D4h, 0A1h, 0A5h, 0E6h ; 0ca04
	ASCII "3" ; 0ca0b
	DB 0D4h, 10h, 0A6h, 0E6h, 24h, 0D4h ; 0ca0c
	ASCII "w" ; 0ca12
	DB 0A6h, 0E6h, 2Eh, 0D4h, 0D2h, 0A6h, 0E6h, 1Fh ; 0ca13
	DB 0D4h, 1Bh, 0A7h, 0E5h, 06h, 0C4h, 07h, 0C9h ; 0ca1b
	DB 0F1h, 22h, 0C4h, 07h, 0C9h, 0F1h, 1Dh, 0C4h ; 0ca23
	DB 0F7h, 0C8h, 0F1h, 18h, 0C4h ; 0ca2b
	ASCII "C" ; 0ca30
	DB 0C9h, 0F1h, 13h, 0C4h ; 0ca31
	ASCII "M" ; 0ca35
	DB 0C9h, 0F1h, 0Eh, 0C4h, 81h, 0C9h, 0F1h, 09h ; 0ca36
	DB 0C4h, 11h, 0C9h, 0F1h, 04h, 0C4h ; 0ca3e
	ASCII "c" ; 0ca44
	DB 0C9h, 0F2h, 07h, 0AFh, 0F8h, 0B9h ; 0ca45
	ASCII "7" ; 0ca4b
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C0h, 0D4h, 0D2h ; 0ca4c
	DB 0A6h, 0E6h, 11h, 0D4h, 0FCh, 0A4h, 0E4h, 0Ch ; 0ca54
	DB 0D4h, 1Bh, 0A7h, 0E5h, 07h, 0C4h, 07h, 0C9h ; 0ca5c
	DB 0F2h, 0E9h, 0AEh, 0F8h, 0CEh, 0D0h, 0D8h, 1Ah ; 0ca64
	ASCIZ "2" ; 0ca6c
	DB 0E7h, 0Fh, 0CEh, 0D0h, 0D7h, 1Ah ; 0ca6e
	ASCII "2" ; 0ca74
	DB 01h, 0E7h, 07h, 0C4h, 0EBh, 0C9h, 0F2h, 0CBh ; 0ca75
	DB 0AEh, 0F8h ; 0ca7d
	ASCII "h" ; 0ca7f
	DB 0CAh, 01h, 19h, 9Bh, 01h, 17h, 9Bh, 00h ; 0ca80
	DB 08h, 00h, 0D0h, 0C8h, 08h, 00h, 0D4h, 0C8h ; 0ca88
	DB 0C1h, 99h, 88h, 0CAh, 08h, 00h, 0D8h, 0C8h ; 0ca90
	DB 08h, 00h, 0DCh, 0C8h, 0C1h, 99h, 94h, 0CAh ; 0ca98
	DB 08h, 00h, 0E0h, 0C8h, 08h, 00h, 0E4h, 0C8h ; 0caa0
	DB 0C1h, 99h, 0A0h, 0CAh, 08h, 00h, 0E8h, 0C8h ; 0caa8
	DB 08h, 00h, 0ECh, 0C8h, 0C1h, 99h, 0ACh, 0CAh ; 0cab0
	DB 08h, 00h, 0F0h, 0C8h, 08h, 00h, 0F4h, 0C8h ; 0cab8
	DB 0C1h, 99h, 0B8h, 0CAh, 08h, 00h, 0F8h, 0C8h ; 0cac0
	DB 08h, 00h, 0FCh, 0C8h, 0C1h, 99h, 0C4h, 0CAh ; 0cac8
	DB 08h, 00h, 00h, 0C9h, 08h, 00h, 04h, 0C9h ; 0cad0
	DB 0C1h, 99h, 0D0h, 0CAh, 08h, 00h, 08h, 0C9h ; 0cad8
	DB 08h, 00h, 0Ch, 0C9h, 0C1h, 99h, 0DCh, 0CAh ; 0cae0
	DB 08h, 00h, 10h, 0C9h, 08h, 00h, 14h, 0C9h ; 0cae8
	DB 0C1h, 99h, 0E8h, 0CAh, 08h, 00h, 18h, 0C9h ; 0caf0
	DB 08h, 00h, 1Ch, 0C9h, 0C1h, 99h, 0F4h, 0CAh ; 0caf8
	DB 08h, 00h, 20h, 0C9h, 08h, 00h, 24h, 0C9h ; 0cb00
	DB 0C1h, 99h, 00h, 0CBh, 08h, 00h, 28h, 0C9h ; 0cb08
	DB 08h, 00h, 2Ch, 0C9h, 0C1h, 99h, 0Ch, 0CBh ; 0cb10
	DB 08h, 00h ; 0cb18
	ASCII "0" ; 0cb1a
	DB 0C9h, 08h, 00h ; 0cb1b
	ASCII "4" ; 0cb1e
	DB 0C9h, 0C1h, 99h, 18h, 0CBh, 08h, 00h ; 0cb1f
	ASCII "8" ; 0cb26
	DB 0C9h, 08h, 00h, 3Ch, 0C9h, 0C1h, 99h, 24h ; 0cb27
	DB 0CBh, 08h, 00h, 40h, 0C9h, 08h, 00h ; 0cb2f
	ASCII "D" ; 0cb36
	DB 0C9h, 0C1h, 99h ; 0cb37
	ASCII "0" ; 0cb3a
	DB 0CBh, 08h, 00h ; 0cb3b
	ASCII "H" ; 0cb3e
	DB 0C9h, 08h, 00h ; 0cb3f
	ASCII "L" ; 0cb42
	DB 0C9h, 0C1h, 99h, 3Ch, 0CBh, 08h, 00h ; 0cb43
	ASCII "P" ; 0cb4a
	DB 0C9h, 08h, 00h ; 0cb4b
	ASCII "T" ; 0cb4e
	DB 0C9h, 0C1h, 99h ; 0cb4f
	ASCII "H" ; 0cb52
	DB 0CBh, 08h, 00h ; 0cb53
	ASCII "X" ; 0cb56
	DB 0C9h, 08h, 00h, 5Ch, 0C9h, 0C1h, 99h ; 0cb57
	ASCII "T" ; 0cb5e
	DB 0CBh, 08h, 00h, 60h, 0C9h, 08h, 00h ; 0cb5f
	ASCII "d" ; 0cb66
	DB 0C9h, 0C1h, 99h, 60h, 0CBh, 08h, 00h ; 0cb67
	ASCII "h" ; 0cb6e
	DB 0C9h, 08h, 00h ; 0cb6f
	ASCII "l" ; 0cb72
	DB 0C9h, 0C1h, 99h ; 0cb73
	ASCII "l" ; 0cb76
	DB 0CBh, 08h, 00h ; 0cb77
	ASCII "p" ; 0cb7a
	DB 0C9h, 08h, 00h ; 0cb7b
	ASCII "t" ; 0cb7e
	DB 0C9h, 0C1h, 99h ; 0cb7f
	ASCII "x" ; 0cb82
	DB 0CBh, 08h, 00h ; 0cb83
	ASCII "x" ; 0cb86
	DB 0C9h, 08h, 00h, 7Ch, 0C9h, 0C1h, 99h, 84h ; 0cb87
	DB 0CBh, 08h, 00h, 80h, 0C9h, 08h, 00h, 84h ; 0cb8f
	DB 0C9h, 0C1h, 99h, 90h, 0CBh, 08h, 00h, 88h ; 0cb97
	DB 0C9h, 08h, 00h, 8Ch, 0C9h, 0C1h, 99h, 9Ch ; 0cb9f
	DB 0CBh, 08h, 00h, 90h, 0C9h, 08h, 00h, 94h ; 0cba7
	DB 0C9h, 0C1h, 99h, 0A8h, 0CBh, 08h, 00h, 98h ; 0cbaf
	DB 0C9h, 08h, 00h, 9Ch, 0C9h, 0C1h, 99h, 0B4h ; 0cbb7
	DB 0CBh, 08h, 00h, 0A0h, 0C9h, 08h, 00h, 0A4h ; 0cbbf
	DB 0C9h, 0C1h, 99h, 0C0h, 0CBh, 08h, 00h, 0A8h ; 0cbc7
	DB 0C9h, 08h, 00h, 0ACh, 0C9h, 0C1h, 99h, 0CCh ; 0cbcf
	DB 0CBh, 08h, 00h, 0B0h, 0C9h, 08h, 00h, 0B4h ; 0cbd7
	DB 0C9h, 0C1h, 99h, 0D8h, 0CBh, 08h, 00h, 0B8h ; 0cbdf
	DB 0C9h, 08h, 00h, 0BCh, 0C9h, 0C1h, 99h, 0E4h ; 0cbe7
	DB 0CBh, 08h, 00h, 0C0h, 0C9h, 08h, 00h, 0C4h ; 0cbef
	DB 0C9h, 0C1h, 99h, 0F0h, 0CBh, 08h, 00h, 0C8h ; 0cbf7
	DB 0C9h, 08h, 00h, 0CCh, 0C9h, 0C1h, 99h, 0FCh ; 0cbff
	DB 0CBh, 08h, 00h, 0D0h, 0C9h, 08h, 00h, 0D4h ; 0cc07
	DB 0C9h, 0C1h, 99h, 08h, 0CCh, 08h, 00h, 0D8h ; 0cc0f
	DB 0C9h, 08h, 00h, 0DCh, 0C9h, 0C1h, 99h, 14h ; 0cc17
	DB 0CCh, 08h, 00h, 0E0h, 0C9h, 08h, 00h, 0E4h ; 0cc1f
	DB 0C9h, 0C1h, 99h, 20h, 0CCh, 08h, 00h, 0E8h ; 0cc27
	DB 0C9h, 08h, 00h, 0ECh, 0C9h, 0C1h, 99h, 2Ch ; 0cc2f
	DB 0CCh, 08h, 00h, 0F0h, 0C9h, 08h, 00h, 0F4h ; 0cc37
	DB 0C9h, 0C1h, 99h ; 0cc3f
	ASCII "8" ; 0cc42
	DB 0CCh, 0CEh, 0D0h ; 0cc43
	ASCII "C" ; 0cc46
	DB 16h, 96h, 01h, 0E7h, 14h, 96h, 02h, 0E6h ; 0cc47
	DB 26h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 0cc4f
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 0Eh ; 0cc57
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 0cc5f
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 80h ; 0cc67
	ASCII "V" ; 0cc6e
	DB 0A3h, 0F2h, 1Dh ; 0cc6f
	ASCII "V" ; 0cc72
	DB 0ABh, 0F8h, 0CEh, 0D0h ; 0cc73
	ASCII "E" ; 0cc77
	DB 16h, 96h, 20h, 0E7h, 11h, 96h, 40h, 0E6h ; 0cc78
	DB 29h, 0CEh, 0D0h, 2Ch, 1Bh, 80h ; 0cc80
	ASCII "2" ; 0cc86
	DB 0Ch, 0E4h, 0Fh ; 0cc87
	ASCII "8" ; 0cc8a
	DB 0F1h, 0Ch, 0CEh, 0D0h, 2Ch, 1Bh, 88h ; 0cc8b
	ASCII "2" ; 0cc92
	DB 0FFh, 0E7h, 03h, 0B0h, 0Bh, 0CEh, 0D4h, 2Ch ; 0cc93
	DB 1Bh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 0cc9b
	DB 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0CEh, 0D0h ; 0cca3
	DB 2Ch, 1Bh, 0CEh, 0D1h, 97h, 1Bh, 0F2h, 15h ; 0ccab
	DB 00h, 0CEh ; 0ccb3
	ASCII "P" ; 0ccb5
	DB 18h, 0CEh ; 0ccb6
	ASCII "X" ; 0ccb8
	DB 19h, 0CFh, 19h, 0E6h, 0Ah, 0CEh ; 0ccb9
	ASCII "D" ; 0ccbf
	DB 18h, 0CEh ; 0ccc0
	ASCII "L" ; 0ccc2
	DB 19h, 0F2h, 89h, 0ACh, 0F8h ; 0ccc3
	ASCII "2" ; 0ccc8
	DB 0Bh, 0E4h, 03h, 0B0h, 0Bh, 0A0h, 0CEh, 0C4h ; 0ccc9
	DB 03h, 0F2h, 0DBh, 0C2h, 0A8h, 0E7h, 05h, 0C4h ; 0ccd1
	DB 88h, 0CAh, 0F8h, 0A6h, 0A3h, 0C7h, 0FAh, 0CCh ; 0ccd9
	DB 0CEh, 0C7h, 00h, 0CFh, 0B0h ; 0cce1
	ASCIZ "A" ; 0cce6
	DB 0B1h, 00h, 0CFh ; 0cce8
	ASCII "B" ; 0cceb
	DB 0CFh, 0DBh, 0CFh, 0B4h, 00h, 0B1h, 00h, 0CFh ; 0ccec
	ASCII "B" ; 0ccf4
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0F8h, 00h, 0CDh, 18h ; 0ccf5
	DB 0CDh ; 0ccfd
	ASCII "0" ; 0ccfe
	DB 0CDh, 94h, 0CAh, 0A0h, 0CAh, 0ACh, 0CAh, 0B8h ; 0ccff
	DB 0CAh, 0C4h, 0CAh, 0D0h, 0CAh, 0DCh, 0CAh, 0E8h ; 0cd07
	DB 0CAh, 0F4h, 0CAh, 00h, 0CBh, 0Ch, 0CBh, 18h ; 0cd0f
	DB 0CBh, 24h, 0CBh ; 0cd17
	ASCII "0" ; 0cd1a
	DB 0CBh, 3Ch, 0CBh ; 0cd1b
	ASCII "H" ; 0cd1e
	DB 0CBh ; 0cd1f
	ASCII "T" ; 0cd20
	DB 0CBh, 60h, 0CBh ; 0cd21
	ASCII "l" ; 0cd24
	DB 0CBh ; 0cd25
	ASCII "x" ; 0cd26
	DB 0CBh, 84h, 0CBh, 90h, 0CBh, 9Ch, 0CBh, 0A8h ; 0cd27
	DB 0CBh, 0B4h, 0CBh, 0C0h, 0CBh, 0CCh, 0CBh, 0D8h ; 0cd2f
	DB 0CBh, 0E4h, 0CBh, 0F0h, 0CBh, 0FCh, 0CBh, 08h ; 0cd37
	DB 0CCh, 14h, 0CCh, 20h, 0CCh, 2Ch, 0CCh ; 0cd3f
	ASCII "8" ; 0cd46
	DB 0CCh ; 0cd47
	ASCII "q" ; 0cd48
	DB 9Ah, 02h ; 0cd49
	ASCII "D" ; 0cd4b
	DB 0CCh, 01h, 17h, 9Bh, 00h, 0CEh, 0D0h, 2Ch ; 0cd4c
	DB 1Bh, 80h ; 0cd54
	ASCII "2" ; 0cd56
	DB 0Ch, 0E4h, 02h ; 0cd57
	ASCII "8" ; 0cd5a
	DB 0CEh, 0D1h, 97h, 1Bh, 0F2h ; 0cd5b
	ASCII "g" ; 0cd60
	DB 0FFh, 0F2h, 0EBh, 0ABh, 0F8h ; 0cd61
	ASCII "q" ; 0cd66
	DB 9Ah, 02h ; 0cd67
	ASCII "Q" ; 0cd69
	DB 0CDh, 01h, 17h, 9Bh, 00h, 0CEh, 0D0h, 2Ch ; 0cd6a
	DB 1Bh, 88h ; 0cd72
	ASCII "2" ; 0cd74
	DB 0FFh, 0E7h, 03h, 0B0h, 0Bh, 0CEh, 0D1h, 97h ; 0cd75
	DB 1Bh, 0F2h ; 0cd7d
	ASCII "H" ; 0cd7f
	DB 0FFh, 0F2h, 0CCh, 0ABh, 0F8h ; 0cd80
	ASCII "q" ; 0cd85
	DB 9Ah, 02h ; 0cd86
	ASCII "o" ; 0cd88
	DB 0CDh, 01h, 17h, 9Bh, 00h, 04h, 00h, 0D0h ; 0cd89
	DB 0AFh, 04h, 00h, 0D4h, 0AFh, 04h, 00h, 0D0h ; 0cd91
	DB 0AFh, 04h, 00h, 0D4h, 0AFh, 01h, 00h, 0D0h ; 0cd99
	DB 0AFh, 8Eh, 99h, 0CEh, 0D0h, 17h, 1Bh ; 0cda1
	ASCII "2" ; 0cda8
	DB 02h, 0E6h, 25h, 0F2h ; 0cda9
	ASCII "P" ; 0cdad
	DB 0DDh, 0E6h, 11h, 0F2h, 20h, 0CFh, 0F1h, 2Fh ; 0cdae
	DB 0C5h, 13h, 1Bh, 86h, 0B8h, 12h, 1Bh, 0F2h ; 0cdb6
	DB 0C3h, 0ABh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 0cdbe
	DB 0E6h, 07h, 0B0h, 12h, 0CEh, 0D4h, 0FAh, 14h ; 0cdc6
	DB 0F1h, 0Eh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 0cdce
	DB 07h, 0B0h, 21h, 0CEh, 0D4h, 0FAh, 14h, 0C4h ; 0cdd6
	DB 03h, 0CEh, 0F2h ; 0cdde
	ASCII "f" ; 0cde1
	DB 0ABh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 0cde2
	DB 07h, 0B0h, 12h, 0CEh, 0D4h, 0FAh, 14h, 0C5h ; 0cdea
	DB 19h, 9Bh, 0C4h, 9Eh, 0CDh, 0F2h ; 0cdf2
	ASCII "w" ; 0cdf8
	DB 0ABh, 0F2h, 0D8h ; 0cdf9
	ASCII "T" ; 0cdfc
	DB 0A3h, 0F2h, 8Fh ; 0cdfd
	ASCII "T" ; 0ce00
	DB 0ABh, 0F8h, 0CEh, 0D0h, 17h, 1Bh ; 0ce01
	ASCII "2" ; 0ce07
	DB 02h, 0E6h, 1Fh, 0F2h, 0F1h, 0DCh, 0E6h, 15h ; 0ce08
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 0ce10
	DB 11h, 0CEh, 0D4h, 0FAh, 14h, 0C4h, 0A4h, 0CDh ; 0ce18
	DB 0F2h, 26h, 0ABh, 0F8h, 0F2h ; 0ce20
	ASCII "0" ; 0ce25
	DB 0CDh, 0E7h, 06h, 0C4h, 9Eh, 0CDh, 0F1h, 06h ; 0ce26
	DB 0C4h, 8Eh, 0CDh, 0F1h, 01h, 0CEh ; 0ce2e
	ASCII "P" ; 0ce34
	DB 18h, 0CEh ; 0ce35
	ASCII "X" ; 0ce37
	DB 19h, 0CFh ; 0ce38
	ASCII "8" ; 0ce3a
	DB 0E6h, 0Ah, 0CEh ; 0ce3b
	ASCII "T" ; 0ce3e
	DB 18h, 0CEh, 5Ch, 19h, 0F2h ; 0ce3f
	ASCII "8" ; 0ce44
	DB 0DBh, 0B8h, 12h, 1Bh, 0F2h ; 0ce45
	ASCII "7" ; 0ce4a
	DB 0ABh, 0F8h ; 0ce4b
	ASCII "q" ; 0ce4d
	DB 9Ah, 02h, 03h, 0CEh, 01h, 9Eh, 0CDh, 00h ; 0ce4e
	DB 0CEh, 0D0h, 17h, 1Bh ; 0ce56
	ASCII "2" ; 0ce5a
	DB 02h, 0E6h, 25h, 0F2h, 9Eh, 0DCh, 0E6h, 11h ; 0ce5b
	DB 0F2h ; 0ce63
	ASCII "n" ; 0ce64
	DB 0CEh, 0F1h, 2Fh, 0C5h, 13h, 1Bh, 86h, 0B8h ; 0ce65
	DB 12h, 1Bh, 0F2h, 11h, 0ABh, 0F8h, 0CEh, 0D0h ; 0ce6d
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 12h, 0CEh ; 0ce75
	DB 0D4h, 0FAh, 14h, 0F1h, 0Eh, 0CEh, 0D0h, 0B6h ; 0ce7d
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 21h, 0CEh, 0D4h ; 0ce85
	DB 0FAh, 14h, 0C4h, 0ADh, 0CEh, 0F2h, 0B4h, 0AAh ; 0ce8d
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 0ce95
	DB 0B0h, 12h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 06h ; 0ce9d
	DB 0CFh, 0C4h, 9Eh, 0CDh, 0F2h, 0C5h, 0AAh, 0F8h ; 0cea5
	DB 0CEh, 0D0h, 17h, 1Bh ; 0cead
	ASCII "2" ; 0ceb1
	DB 02h, 0E6h, 24h, 0F2h ; 0ceb2
	ASCII "G" ; 0ceb6
	DB 0DCh, 0E6h, 1Ah, 0F2h, 17h, 0CEh, 0F1h, 3Eh ; 0ceb7
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 0cebf
	DB 11h, 0CEh, 0D4h, 0FAh, 14h, 0C4h ; 0cec7
	ASCII "V" ; 0cecd
	DB 0CEh, 0F2h ; 0cece
	ASCII "w" ; 0ced0
	DB 0AAh, 0F8h, 0F2h, 81h, 0CCh, 0E7h, 06h, 0C4h ; 0ced1
	DB 9Eh, 0CDh, 0F1h, 06h, 0C4h, 8Eh, 0CDh, 0F1h ; 0ced9
	DB 01h, 0CEh ; 0cee1
	ASCII "P" ; 0cee3
	DB 18h, 0CEh ; 0cee4
	ASCII "X" ; 0cee6
	DB 19h, 0CFh ; 0cee7
	ASCII "8" ; 0cee9
	DB 0E6h, 0Ah, 0CEh ; 0ceea
	ASCII "T" ; 0ceed
	DB 18h, 0CEh, 5Ch, 19h, 0F2h, 89h, 0DAh, 0B8h ; 0ceee
	DB 12h, 1Bh, 0F2h, 88h, 0AAh, 0F8h, 0C5h, 06h ; 0cef6
	DB 0CFh, 0C4h, 9Eh, 0CDh, 0F2h ; 0cefe
	ASCII "l" ; 0cf03
	DB 0AAh, 0F8h, 0CEh, 0D0h, 17h, 1Bh ; 0cf04
	ASCII "2" ; 0cf0a
	DB 02h, 0E6h, 2Bh, 0F2h ; 0cf0b
	ASCII "F" ; 0cf0f
	DB 0CCh, 0E6h ; 0cf10
	ASCII "1" ; 0cf12
	DB 0F2h, 0FBh, 0D0h, 0CEh, 0D0h, 0DAh, 1Ah, 28h ; 0cf13
	DB 0E7h, 14h, 0C5h, 19h, 9Bh, 0C4h, 9Eh, 0CDh ; 0cf1b
	DB 0F2h ; 0cf23
	ASCII "K" ; 0cf24
	DB 0AAh, 0F2h, 0ACh ; 0cf25
	ASCII "S" ; 0cf28
	DB 0A3h, 0F2h ; 0cf29
	ASCII "cS" ; 0cf2b
	DB 0ABh, 0F1h, 14h, 0C4h, 9Eh, 0CDh, 0F2h, 1Ah ; 0cf2d
	DB 0AAh, 0F1h, 0Ch ; 0cf35
	ASCII "8" ; 0cf38
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0C4h, 0ADh, 0CEh, 0F2h ; 0cf39
	DB 06h, 0AAh, 0F8h ; 0cf41
	ASCII "q" ; 0cf44
	DB 9Ah, 02h, 0ADh, 0CEh, 01h, 9Eh, 0CDh, 00h ; 0cf45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cf9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cfed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cff5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0cffd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d005
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d00d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d015
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d01d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d025
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d02d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d035
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d03d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d045
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d04d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d055
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d05d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d065
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d06d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d075
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d07d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d085
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d08d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d095
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d09d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d0fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d105
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d10d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d115
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d11d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d125
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d12d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d135
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d13d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d145
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d14d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d155
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d15d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d165
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d16d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d175
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d17d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d185
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d18d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d195
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d19d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d1fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d205
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d20d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d215
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d21d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d225
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d22d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d235
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d23d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d245
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d24d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d255
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d25d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d265
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d26d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d275
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d27d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d285
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d28d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d295
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d29d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d2fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d305
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d30d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d315
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d31d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d325
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d32d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d335
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d33d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d345
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d34d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d355
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d35d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d365
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d36d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d375
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d37d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d385
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d38d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d395
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d39d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d3fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d405
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d40d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d415
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d41d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d425
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d42d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d435
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d43d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d445
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d44d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d455
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d45d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d465
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d46d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d475
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d47d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d485
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d48d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d495
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d49d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d4fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d505
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d50d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d515
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d51d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d525
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d52d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d535
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d53d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d545
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d54d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d555
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d55d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d565
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d56d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d575
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d57d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d585
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d58d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d595
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d59d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d5fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d605
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d60d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d615
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d61d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d625
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d62d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d635
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d63d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d645
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d64d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d655
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d65d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d665
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d66d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d675
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d67d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d685
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d68d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d695
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d69d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d6fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d705
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d70d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d715
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d71d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d725
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d72d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d735
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d73d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d745
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d74d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d755
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d75d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d765
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d76d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d775
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d77d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d785
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d78d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d795
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d79d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d7fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d805
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d80d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d815
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d81d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d825
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d82d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d835
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d83d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d845
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d84d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d855
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d85d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d865
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d86d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d875
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d87d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d885
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d88d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d895
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d89d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d8fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d905
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d90d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d915
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d91d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d925
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d92d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d935
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d93d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d945
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d94d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d955
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d95d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d965
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d96d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d975
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d97d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d985
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d98d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d995
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d99d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0d9fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0da9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0daa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0daad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dab5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dabd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dac5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dacd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dad5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dadd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dae5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0daed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0daf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dafd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0db9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dba5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dbfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dc9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dca5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dccd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dce5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dced
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dcfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dd9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dda5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dddd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dde5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dded
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ddfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0de9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dea5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dead
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0deb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0debd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dec5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0decd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ded5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dedd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dee5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0deed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0def5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0defd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0df9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dfed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dff5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0dffd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e005
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e00d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e015
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e01d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e025
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e02d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e035
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e03d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e045
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e04d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e055
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e05d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e065
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e06d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e075
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e07d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e085
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e08d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e095
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e09d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e0fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e105
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e10d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e115
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e11d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e125
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e12d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e135
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e13d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e145
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e14d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e155
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e15d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e165
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e16d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e175
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e17d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e185
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e18d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e195
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e19d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e1fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e205
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e20d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e215
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e21d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e225
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e22d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e235
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e23d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e245
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e24d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e255
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e25d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e265
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e26d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e275
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e27d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e285
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e28d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e295
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e29d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e2fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e305
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e30d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e315
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e31d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e325
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e32d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e335
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e33d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e345
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e34d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e355
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e35d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e365
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e36d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e375
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e37d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e385
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e38d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e395
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e39d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e3fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e405
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e40d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e415
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e41d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e425
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e42d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e435
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e43d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e445
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e44d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e455
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e45d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e465
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e46d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e475
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e47d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e485
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e48d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e495
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e49d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e4fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e505
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e50d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e515
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e51d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e525
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e52d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e535
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e53d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e545
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e54d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e555
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e55d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e565
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e56d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e575
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e57d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e585
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e58d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e595
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e59d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e5fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e605
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e60d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e615
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e61d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e625
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e62d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e635
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e63d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e645
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e64d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e655
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e65d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e665
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e66d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e675
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e67d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e685
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e68d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e695
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e69d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e6fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e705
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e70d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e715
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e71d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e725
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e72d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e735
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e73d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e745
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e74d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e755
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e75d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e765
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e76d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e775
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e77d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e785
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e78d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e795
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e79d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e7fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e805
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e80d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e815
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e81d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e825
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e82d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e835
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e83d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e845
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e84d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e855
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e85d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e865
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e86d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e875
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e87d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e885
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e88d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e895
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e89d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e8fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e905
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e90d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e915
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e91d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e925
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e92d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e935
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e93d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e945
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e94d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e955
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e95d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e965
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e96d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e975
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e97d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e985
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e98d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e995
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e99d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0e9fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ea9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eaa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eaad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eab5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eabd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eac5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eacd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ead5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eadd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eae5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eaed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eaf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eafd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eb9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eba5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ebfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ec9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eca5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eccd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ece5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eced
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ecfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ed9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eda5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eddd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ede5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eded
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0edfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ee9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eea5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eead
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eeb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eebd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eec5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eecd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eed5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eedd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eee5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eeed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eef5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eefd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ef9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0efed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0eff5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0effd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f005
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f00d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f015
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f01d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f025
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f02d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f035
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f03d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f045
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f04d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f055
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f05d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f065
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f06d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f075
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f07d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f085
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f08d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f095
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f09d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f0fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f105
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f10d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f115
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f11d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f125
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f12d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f135
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f13d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f145
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f14d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f155
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f15d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f165
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f16d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f175
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f17d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f185
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f18d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f195
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f19d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f1fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f205
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f20d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f215
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f21d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f225
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f22d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f235
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f23d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f245
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f24d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f255
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f25d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f265
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f26d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f275
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f27d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f285
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f28d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f295
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f29d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f2fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f305
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f30d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f315
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f31d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f325
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f32d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f335
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f33d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f345
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f34d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f355
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f35d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f365
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f36d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f375
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f37d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f385
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f38d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f395
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f39d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f3fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f405
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f40d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f415
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f41d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f425
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f42d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f435
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f43d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f445
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f44d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f455
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f45d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f465
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f46d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f475
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f47d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f485
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f48d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f495
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f49d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f4fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f505
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f50d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f515
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f51d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f525
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f52d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f535
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f53d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f545
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f54d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f555
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f55d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f565
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f56d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f575
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f57d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f585
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f58d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f595
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f59d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f5fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f605
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f60d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f615
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f61d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f625
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f62d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f635
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f63d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f645
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f64d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f655
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f65d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f665
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f66d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f675
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f67d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f685
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f68d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f695
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f69d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f6fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f705
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f70d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f715
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f71d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f725
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f72d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f735
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f73d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f745
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f74d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f755
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f75d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f765
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f76d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f775
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f77d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f785
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f78d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f795
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f79d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f7fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f805
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f80d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f815
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f81d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f825
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f82d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f835
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f83d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f845
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f84d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f855
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f85d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f865
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f86d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f875
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f87d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f885
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f88d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f895
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f89d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f8fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f905
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f90d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f915
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f91d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f925
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f92d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f935
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f93d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f945
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f94d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f955
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f95d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f965
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f96d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f975
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f97d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f985
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f98d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f995
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f99d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0f9fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fa9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0faa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0faad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fab5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fabd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fac5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0facd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fad5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fadd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fae5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0faed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0faf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fafd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fb9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fba5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fbfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fc9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fca5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fccd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fce5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fced
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fcfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fd9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fda5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fddd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fde5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fded
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fdfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fe9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fea5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fead
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0feb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0febd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fec5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fecd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fed5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fedd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fee5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0feed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fef5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fefd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ff9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0ffed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 0fff5
	DB 0FFh, 0FFh, 0FFh ; 0fffd
DEFSECT ".rom2", CODE AT 010000H
SECT ".rom2"
; ---------------------- ; 0ffff
	DB 0D6h, 99h, 00h, 00h, 00h, 00h, 08h, 00h ; 10000
	DB 0E0h, 0ABh, 08h, 00h, 0F4h, 0ABh, 0C1h, 99h ; 10008
	DB 06h, 00h ; 10010
	ASCII "q" ; 10012
	DB 9Ah ; 10013
	ASCII "q" ; 10014
	DB 9Ah, 00h, 00h, 13h, 1Ah, 0FEh, 0FEh, 0FFh ; 10015
	DB 01h, 00h, 00h ; 1001d
	ASCII "4" ; 10020
	DB 1Ah, 0FEh, 0FEh, 00h, 0FFh, 00h, 00h, 06h ; 10021
	DB 00h, 0C8h, 0ABh, 06h, 00h, 0D0h, 0ABh, 0C1h ; 10029
	DB 99h, 28h, 00h, 0C7h, 18h, 00h, 0CEh, 0D0h ; 10031
	DB 8Eh, 16h, 0F2h, 0B1h, 15h, 0F8h, 0C7h, 18h ; 10039
	DB 00h, 0CEh, 0C7h, 01h, 0CEh, 0D0h, 8Eh, 16h ; 10041
	DB 0F2h, 0C5h, 15h, 0CEh, 0D4h, 8Eh, 16h, 0F8h ; 10049
	ASCII "4" ; 10051
	DB 80h, 3Fh, 80h, 28h, 00h, 0Ch, 1Ah, 0FEh ; 10052
	DB 0FEh, 05h, 01h, 00h, 00h, 16h, 1Ah, 0FEh ; 1005a
	DB 0FEh, 00h, 02h, 00h, 00h, 21h, 1Ah, 0FEh ; 10062
	DB 0FEh, 01h, 03h, 00h, 00h, 2Ch, 1Ah, 0FEh ; 1006a
	DB 0FEh, 02h, 04h, 00h, 00h ; 10072
	ASCII "7" ; 10077
	DB 1Ah, 0FEh, 0FEh, 03h, 05h, 00h, 00h ; 10078
	ASCII "B" ; 1007f
	DB 1Ah, 0FEh, 0FEh, 04h, 00h, 00h, 00h, 06h ; 10080
	DB 00h, 0D8h, 0ABh, 06h, 00h, 0DCh, 0ABh, 0C1h ; 10088
	DB 99h, 87h, 00h, 0C7h ; 10090
	ASCIZ "W" ; 10094
	DB 0CEh, 0D0h, 8Dh, 16h, 0F2h ; 10096
	ASCII "R" ; 1009b
	DB 15h, 0F8h, 0C7h ; 1009c
	ASCIZ "W" ; 1009f
	DB 0CEh, 0C7h, 01h, 0CEh, 0D0h, 8Dh, 16h, 0F2h ; 100a1
	ASCII "f" ; 100a9
	DB 15h, 0CEh, 0D4h, 8Dh, 16h, 0F8h, 93h, 80h ; 100aa
	DB 9Eh, 80h, 87h, 00h, 0CEh, 0D0h, 0B9h, 1Ah ; 100b2
	DB 0B1h, 00h, 0C7h, 0CCh, 00h, 0CEh, 0C7h, 01h ; 100ba
	DB 0CFh ; 100c2
	ASCII "B" ; 100c3
	DB 0CFh ; 100c4
	ASCII "B" ; 100c5
	DB 0CFh, 0D8h, 0F2h, 7Eh, 0F8h, 0F8h, 0E4h, 80h ; 100c6
	DB 0EDh, 80h ; 100ce
	ASCII "i" ; 100d0
	DB 81h, 0CEh, 0D0h, 0B9h, 1Ah, 80h ; 100d1
	ASCII "2" ; 100d7
	DB 03h, 0E7h, 02h ; 100d8
	ASCII "8" ; 100db
	DB 0CEh, 0D4h, 0B9h, 1Ah, 0F2h, 0D4h, 0FFh, 0F8h ; 100dc
	DB 0C5h ; 100e4
	ASCII "C" ; 100e5
	DB 16h, 95h, 04h, 0EBh, 0E7h, 0FFh, 0F8h, 0C5h ; 100e6
	ASCII "C" ; 100ee
	DB 16h, 95h, 04h, 0EBh, 0DEh, 0FFh, 0A6h, 0A2h ; 100ef
	DB 0C6h, 0AAh, 15h, 0CEh, 0C6h, 00h, 0F2h, 07h ; 100f7
	DB 0C6h, 0AAh, 0BBh, 0Fh, 19h, 0CEh, 0C7h, 00h ; 100ff
	DB 0CEh, 0D0h, 0ADh, 15h, 0F2h ; 10107
	ASCII "h" ; 1010c
	DB 0A4h, 0CFh, 0B1h, 02h, 10h, 0B1h, 08h, 0B2h ; 1010d
	DB 5Dh, 0B3h, 12h, 0F2h ; 10115
	ASCII "u" ; 10119
	DB 0A4h, 0CFh, 0B4h, 02h, 10h, 0B1h, 08h, 0B2h ; 1011a
	ASCII "X" ; 10122
	DB 0B3h, 12h, 0F2h ; 10123
	ASCII "h" ; 10126
	DB 0A4h, 0CEh, 40h, 18h, 80h ; 10127
	ASCII "2$" ; 1012c
	DB 0E7h, 02h ; 1012e
	ASCII "8" ; 10130
	DB 0CEh ; 10131
	ASCII "D" ; 10132
	DB 18h ; 10133
	ASCII "2" ; 10134
	DB 12h, 0E5h, 0Ch, 0B0h, 1Bh, 0B1h, 08h, 0B2h ; 10135
	ASCII "c" ; 1013d
	DB 0B3h, 12h, 0F2h ; 1013e
	ASCII "M" ; 10141
	DB 0A4h, 0CEh, 0D0h, 0AEh, 15h, 0F2h, 2Ch, 0A4h ; 10142
	DB 0CFh, 0B1h, 02h, 10h, 0B1h, 08h, 0B2h ; 1014a
	ASCII "j" ; 10151
	DB 0B3h, 12h, 0F2h ; 10152
	ASCII "9" ; 10155
	DB 0A4h, 0CFh, 0B4h, 02h, 10h, 0B1h, 08h, 0B2h ; 10156
	ASCII "e" ; 1015e
	DB 0B3h, 12h, 0F2h, 2Ch, 0A4h, 0BFh, 0Fh, 19h ; 1015f
	DB 0AEh, 0F8h, 0C5h ; 10167
	ASCII "C" ; 1016a
	DB 16h, 95h, 04h, 0EBh ; 1016b
	ASCII "b" ; 1016f
	DB 0FFh, 0A6h, 0A2h, 0C6h, 0AAh, 15h, 0CEh, 0C6h ; 10170
	DB 00h, 0F2h, 8Bh, 0C5h, 0AAh, 0BBh, 0Fh, 19h ; 10178
	DB 0CEh, 0C7h, 00h, 0CEh, 0D0h, 0AAh, 15h, 0F2h ; 10180
	DB 0ECh, 0A3h, 0CFh, 0B1h, 02h, 10h, 0B1h, 08h ; 10188
	DB 0B2h ; 10190
	ASCII "N" ; 10191
	DB 0B3h, 12h, 0F2h, 0F9h, 0A3h, 0CFh, 0B4h, 02h ; 10192
	DB 10h, 0B1h, 08h, 0B2h ; 1019a
	ASCII "I" ; 1019e
	DB 0B3h, 12h, 0F2h, 0ECh, 0A3h, 0B0h, 1Ah, 0B1h ; 1019f
	DB 08h, 0B2h ; 101a7
	ASCII "S" ; 101a9
	DB 0B3h, 12h, 0F2h, 0E1h, 0A3h, 0CEh, 0D0h, 0ABh ; 101aa
	DB 15h, 0F2h, 0C0h, 0A3h, 0CFh, 0B1h, 02h, 10h ; 101b2
	DB 0B1h, 08h, 0B2h, 5Ch, 0B3h, 12h, 0F2h, 0CDh ; 101ba
	DB 0A3h, 0CFh, 0B4h, 02h, 10h, 0B1h, 08h, 0B2h ; 101c2
	ASCII "W" ; 101ca
	DB 0B3h, 12h, 0F2h, 0C0h, 0A3h, 0B0h, 1Ah, 0B1h ; 101cb
	DB 08h, 0B2h ; 101d3
	ASCII "a" ; 101d5
	DB 0B3h, 12h, 0F2h, 0B5h, 0A3h, 0CEh, 0D0h, 0ACh ; 101d6
	DB 15h, 0F2h, 94h, 0A3h, 0CFh, 0B1h, 02h, 10h ; 101de
	DB 0B1h, 08h, 0B2h ; 101e6
	ASCII "j" ; 101e9
	DB 0B3h, 12h, 0F2h, 0A1h, 0A3h, 0CFh, 0B4h, 02h ; 101ea
	DB 10h, 0B1h, 08h, 0B2h ; 101f2
	ASCII "e" ; 101f6
	DB 0B3h, 12h, 0F2h, 94h, 0A3h, 0BFh, 0Fh, 19h ; 101f7
	DB 0AEh, 0F8h, 0B6h, 80h, 0E4h, 80h ; 101ff
	ASCII "v" ; 10205
	DB 1Ah, 0CEh, 0D0h, 0B6h, 1Ah, 0B1h, 00h, 0C7h ; 10206
	DB 1Dh, 02h, 0CEh, 0C7h, 01h, 0CFh ; 1020e
	ASCII "B" ; 10214
	DB 0CFh ; 10215
	ASCII "B" ; 10216
	DB 0CFh, 0D8h, 0F2h ; 10217
	ASCII "4" ; 1021a
	DB 0F7h, 0F8h ; 1021b
	ASCII "r" ; 1021d
	DB 1Ah, 23h, 02h, 2Ch, 02h, 3Dh, 9Ah, 01h ; 1021e
	DB 08h, 00h, 0B0h, 0ACh, 8Eh, 99h, 3Dh, 9Ah ; 10226
	DB 01h, 08h, 00h, 0B8h, 0ACh, 8Eh, 99h, 0CEh ; 1022e
	DB 0D0h, 0BBh, 1Ah ; 10236
	ASCIZ "2" ; 10239
	DB 0E7h, 13h, 0CEh, 0D0h ; 1023b
	ASCII "E" ; 1023f
	DB 16h, 96h, 20h, 0EBh, 0Bh, 00h, 0CEh, 0D0h ; 10240
	ASCII "E" ; 10248
	DB 16h, 96h, 40h, 0EBh, 18h, 00h, 0F8h, 0C5h ; 10249
	DB 0B6h, 1Ah, 0CEh ; 10251
	ASCIZ "5" ; 10254
	DB 0E6h, 0Eh, 8Eh ; 10256
	ASCII "E8" ; 10259
	DB 0CEh, 0D4h, 0B5h, 1Ah, 0F2h ; 1025b
	ASCII "e" ; 10260
	DB 0A4h, 0F2h, 0A3h, 0FFh, 0F8h, 0C5h, 0B6h, 1Ah ; 10261
	DB 0CEh ; 10269
	ASCII "5" ; 1026a
	DB 02h, 0E6h, 0Dh, 86h ; 1026b
	ASCII "8" ; 1026f
	DB 0CEh, 0D4h, 0B5h, 1Ah, 0F2h ; 10270
	ASCII "P" ; 10275
	DB 0A4h, 0F2h, 8Eh, 0FFh, 0F8h, 07h, 82h ; 10276
	ASCII "5" ; 1027d
	DB 82h, 23h, 02h, 0CEh, 0D0h, 0B7h, 1Ah, 0B1h ; 1027e
	DB 00h, 0C7h, 97h, 02h, 0CEh, 0C7h, 01h, 0CFh ; 10286
	ASCII "B" ; 1028e
	DB 0CFh ; 1028f
	ASCII "B" ; 10290
	DB 0CFh, 0D8h, 0F2h, 0BAh, 0F6h, 0F8h ; 10291
	ASCII "r" ; 10297
	DB 1Ah, 0A1h, 02h, 0AAh, 02h, 0B3h, 02h, 0BCh ; 10298
	DB 02h, 3Dh, 9Ah, 01h, 08h, 00h, 0C0h, 0ACh ; 102a0
	DB 8Eh, 99h, 3Dh, 9Ah, 01h, 08h, 00h, 0C8h ; 102a8
	DB 0ACh, 8Eh, 99h, 3Dh, 9Ah, 01h, 08h, 00h ; 102b0
	DB 0D0h, 0ACh, 8Eh, 99h, 3Dh, 9Ah, 01h, 08h ; 102b8
	DB 00h, 0D8h, 0ACh, 8Eh, 99h, 0CEh, 0D0h, 0BBh ; 102c0
	DB 1Ah ; 102c8
	ASCII "2" ; 102c9
	DB 01h, 0E7h, 13h, 0CEh, 0D0h ; 102ca
	ASCII "E" ; 102cf
	DB 16h, 96h, 20h, 0EBh, 0Bh, 00h, 0CEh, 0D0h ; 102d0
	ASCII "E" ; 102d8
	DB 16h, 96h, 40h, 0EBh, 17h, 00h, 0F8h, 0C5h ; 102d9
	DB 0B7h, 1Ah, 0CEh ; 102e1
	ASCIZ "5" ; 102e4
	DB 0E6h, 0Dh, 8Eh ; 102e6
	ASCII "8" ; 102e9
	DB 0CEh, 0D4h, 0B5h, 1Ah, 0F2h, 0D6h, 0A3h, 0F2h ; 102ea
	DB 8Eh, 0FFh, 0F8h, 0C5h, 0B7h, 1Ah, 0CEh ; 102f2
	ASCII "5" ; 102f9
	DB 04h, 0E6h, 0Dh, 86h ; 102fa
	ASCII "8" ; 102fe
	DB 0CEh, 0D4h, 0B5h, 1Ah, 0F2h, 0C1h, 0A3h, 0F2h ; 102ff
	ASCII "y" ; 10307
	DB 0FFh, 0F8h, 81h, 82h, 0C5h, 82h, 0A1h, 02h ; 10308
	DB 0CEh, 0D0h, 0B8h, 1Ah, 0B1h, 00h, 0C7h, 27h ; 10310
	DB 03h, 0CEh, 0C7h, 01h, 0CFh ; 10318
	ASCII "B" ; 1031d
	DB 0CFh ; 1031e
	ASCII "B" ; 1031f
	DB 0CFh, 0D8h, 0F2h, 2Bh, 0F6h, 0F8h, 0F8h, 2Bh ; 10320
	DB 03h, 3Ah, 03h, 3Dh, 9Ah, 01h, 08h, 00h ; 10328
	DB 0F8h, 0ACh, 08h, 00h, 04h, 0ADh, 0C1h, 99h ; 10330
	DB 2Eh, 03h, 3Dh, 9Ah, 01h, 08h, 00h, 0E0h ; 10338
	DB 0ACh, 08h, 00h, 0ECh, 0ACh, 0C1h, 99h, 3Dh ; 10340
	DB 03h, 0CEh, 0D0h, 0BBh, 1Ah ; 10348
	ASCII "2" ; 1034d
	DB 02h, 0E7h, 13h, 0CEh, 0D0h ; 1034e
	ASCII "C" ; 10353
	DB 16h, 96h, 20h, 0EBh, 0Bh, 00h, 0CEh, 0D0h ; 10354
	ASCII "C" ; 1035c
	DB 16h, 96h, 40h, 0EBh, 16h, 00h, 0F8h, 0C5h ; 1035d
	DB 0B8h, 1Ah, 95h, 01h, 0E7h, 0Dh, 0B5h, 01h ; 10365
	DB 0F2h, 0A1h, 0FFh, 0B0h, 08h, 0B1h, 08h, 0F2h ; 1036d
	ASCII "3" ; 10375
	DB 0A3h, 0F8h, 0C5h, 0B8h, 1Ah, 95h, 01h, 0E6h ; 10376
	DB 06h, 0B5h, 00h, 0F2h, 8Dh, 0FFh, 0F8h, 10h ; 1037e
	DB 83h ; 10386
	ASCII "I" ; 10387
	DB 83h, 3Ah, 03h, 0CEh, 0D0h, 0Fh, 1Bh, 02h ; 10388
	DB 28h, 0CEh ; 10390
	ASCII "D" ; 10392
	DB 0Ah, 0B0h ; 10393
	ASCII "1" ; 10395
	DB 0CEh ; 10396
	ASCII "D" ; 10397
	DB 0Eh, 0F8h, 3Dh, 9Ah, 01h, 08h, 00h, 10h ; 10398
	DB 0ADh, 08h, 00h, 14h, 0ADh, 0C1h, 99h, 9Dh ; 103a0
	DB 03h, 0CEh, 0D0h, 0BBh, 1Ah ; 103a8
	ASCII "2" ; 103ad
	DB 03h, 0E7h, 13h, 0CEh, 0D0h ; 103ae
	ASCII "E" ; 103b3
	DB 16h, 96h, 20h, 0EBh, 0Bh, 00h, 0CEh, 0D0h ; 103b4
	ASCII "E" ; 103bc
	DB 16h, 96h, 40h, 0EBh, 16h, 00h, 0F8h, 0C5h ; 103bd
	DB 0Fh, 1Bh, 0CEh ; 103c5
	ASCII "5" ; 103c8
	DB 12h, 0E6h, 0Ch, 8Eh, 0F2h, 0BCh, 0FFh, 0CEh ; 103c9
	DB 0D0h, 0Fh, 1Bh, 0F2h, 0F3h, 0D6h, 0F8h, 0C5h ; 103d1
	DB 0Fh, 1Bh, 0CEh ; 103d9
	ASCII "5-" ; 103dc
	DB 0E6h, 0Ch, 86h, 0F2h, 0A8h, 0FFh, 0CEh, 0D0h ; 103de
	DB 0Fh, 1Bh, 0F2h, 0DFh, 0D6h, 0F8h, 8Bh, 83h ; 103e6
	DB 0A9h, 83h, 9Ah, 03h, 3Dh, 9Ah, 01h, 08h ; 103ee
	DB 00h, 08h, 0ACh, 08h, 00h, 10h, 0ACh, 0C1h ; 103f6
	DB 99h, 0F5h, 03h, 3Dh, 9Ah, 01h, 08h, 00h ; 103fe
	DB 18h, 0ACh, 08h, 00h, 20h, 0ACh, 0C1h, 99h ; 10406
	DB 04h, 04h, 3Dh, 9Ah, 01h, 08h, 00h, 28h ; 1040e
	DB 0ACh, 08h, 00h ; 10416
	ASCII "4" ; 10419
	DB 0ACh, 0C1h, 99h, 13h, 04h, 3Dh, 9Ah, 01h ; 1041a
	DB 08h, 00h, 40h, 0ACh, 08h, 00h ; 10422
	ASCII "L" ; 10428
	DB 0ACh, 0C1h, 99h, 22h, 04h, 3Dh, 9Ah, 01h ; 10429
	DB 08h, 00h, 90h, 0ACh, 08h, 00h, 0A0h, 0ACh ; 10431
	DB 0C1h, 99h ; 10439
	ASCII "1" ; 1043b
	DB 04h, 3Dh, 9Ah, 01h, 08h, 00h ; 1043c
	ASCII "X" ; 10442
	DB 0ACh, 08h, 00h ; 10443
	ASCII "d" ; 10446
	DB 0ACh, 0C1h, 99h, 40h, 04h, 3Dh, 9Ah, 01h ; 10447
	DB 08h, 00h ; 1044f
	ASCII "p" ; 10451
	DB 0ACh, 08h, 00h, 80h, 0ACh, 0C1h, 99h ; 10452
	ASCII "O" ; 10459
	DB 04h, 3Dh, 9Ah, 01h, 08h, 00h ; 1045a
	ASCII "H" ; 10460
	DB 0ADh, 08h, 00h ; 10461
	ASCII "T" ; 10464
	DB 0ADh, 0C1h, 99h, 5Eh, 04h, 00h, 0Ch, 0FFh ; 10465
	DB 01h, 0FEh, 0FEh, 0F2h, 03h, 00h, 18h, 00h ; 1046d
	DB 02h, 0FEh, 0FEh, 01h, 04h, 00h, 24h, 01h ; 10475
	DB 03h, 0FEh, 0FEh, 10h, 04h, 00h ; 1047d
	ASCII "0" ; 10483
	DB 02h, 04h, 0FEh, 0FEh, 1Fh, 04h, 00h ; 10484
	ASCII "L" ; 1048b
	DB 03h, 05h, 0FEh, 0FEh, 2Eh, 04h, 00h ; 1048c
	ASCII "X" ; 10493
	DB 04h, 06h, 0FEh, 0FEh, 3Dh, 04h, 00h ; 10494
	ASCII "d" ; 1049b
	DB 05h, 07h, 0FEh, 0FEh ; 1049c
	ASCII "L" ; 104a0
	DB 04h, 00h ; 104a1
	ASCII "p" ; 104a3
	DB 06h, 0FFh, 0FEh, 0FEh, 5Bh, 04h, 0CEh, 40h ; 104a4
	DB 0Eh, 0CEh ; 104ac
	ASCII "H" ; 104ae
	DB 0Fh, 22h, 0C0h, 0BCh, 5Bh, 16h, 0CEh, 0D4h ; 104af
	ASCII "2" ; 104b7
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Fh, 16h, 0F8h ; 104b8
	DB 0C7h ; 104c0
	ASCII "j" ; 104c1
	DB 04h, 0CEh, 0D0h, 0BBh, 1Ah, 0F2h, 25h, 11h ; 104c2
	DB 0F2h, 0DEh, 0FFh, 0F8h, 0C7h ; 104ca
	ASCII "j" ; 104cf
	DB 04h, 0CEh, 0C7h, 01h, 0CEh, 0D0h, 0BBh, 1Ah ; 104d0
	DB 0F2h ; 104d8
	ASCII "6" ; 104d9
	DB 11h, 0CEh, 0D4h, 0BBh, 1Ah, 0F2h, 0C9h, 0FFh ; 104da
	DB 0F8h, 0C0h, 84h, 0CEh, 84h, 0F2h, 03h, 3Dh ; 104e2
	DB 9Ah, 01h, 0D6h, 99h, 00h, 00h ; 104ea
	ASCIZ "B" ; 104f0
	DB 06h, 00h, 18h, 0ADh, 06h, 00h ; 104f2
	ASCII "m" ; 104f8
	DB 1Ah, 0C1h, 99h, 0F2h, 04h, 3Dh, 9Ah, 01h ; 104f9
	DB 0D6h, 99h, 00h, 00h, 00h, 00h, 06h, 00h ; 10501
	DB 20h, 0ADh, 06h, 00h ; 10509
	ASCII "m" ; 1050d
	DB 1Ah, 0C1h, 99h, 07h, 05h, 0CEh, 0D0h, 0BBh ; 1050e
	DB 1Ah, 0CEh ; 10516
	ASCII "D" ; 10518
	DB 18h, 0B1h, 00h, 0CEh, 0C7h, 01h, 0C7h, 2Ch ; 10519
	DB 05h, 0CFh ; 10521
	ASCII "B" ; 10523
	DB 0CFh ; 10524
	ASCII "B" ; 10525
	DB 0CFh, 0D8h, 0F2h, 25h, 0F4h, 0F8h, 0FEh, 04h ; 10526
	DB 0FEh, 04h, 0FEh, 04h, 0FEh, 04h, 0E9h, 04h ; 1052e
	DB 0E9h, 04h, 0E9h, 04h, 0E9h, 04h, 0CEh, 0D0h ; 10536
	DB 0BBh, 1Ah, 0CEh ; 1053e
	ASCII "0" ; 10541
	DB 18h, 0EBh, 0CEh, 0FFh, 0F8h, 13h, 85h, 3Ch ; 10542
	DB 85h, 0E9h, 04h, 0B2h, 08h, 0CEh, 0D8h, 0CFh ; 1054a
	ASCII "C" ; 10552
	DB 0A3h, 0CEh, 0C7h, 01h, 0CFh, 0D8h, 0F2h, 27h ; 10553
	DB 0F4h, 0ABh, 0CEh, 0C7h, 01h, 0CEh ; 1055b
	ASCII "A" ; 10561
	DB 06h, 0CEh ; 10562
	ASCII "I" ; 10564
	DB 07h, 0D4h, 00h, 00h, 0E6h, 04h, 0F2h, 0E2h ; 10565
	DB 0F3h ; 1056d
	ASCII "8" ; 1056e
	DB 0CEh, 0D4h, 15h, 19h, 0F8h, 0CFh, 0B0h, 0C5h ; 1056f
	ASCII "E" ; 10577
	DB 16h, 95h, 03h, 0E6h ; 10578
	ASCII "T" ; 1057c
	DB 0A3h, 0B2h, 08h, 0CEh, 0D8h, 0CFh ; 1057d
	ASCII "C" ; 10583
	DB 0C5h ; 10584
	ASCII "C" ; 10585
	DB 16h, 95h, 02h, 0EBh ; 10586
	ASCIZ "X" ; 1058a
	DB 95h, 01h, 0EBh ; 1058c
	ASCIZ "W" ; 1058f
	DB 0ABh, 0CEh, 0D4h, 15h, 19h ; 10591
	ASCII "2" ; 10596
	DB 0FCh, 0E6h ; 10597
	ASCII "G2" ; 10599
	DB 0FDh, 0E6h ; 1059b
	ASCII "C2" ; 1059d
	DB 0FEh, 0E6h, 3Fh ; 1059f
	ASCII "2" ; 105a2
	DB 0FFh, 0E6h, 2Eh, 0B2h, 08h, 0CEh, 0D8h, 0CFh ; 105a3
	ASCII "C" ; 105ab
	DB 0CFh, 0B5h, 0CFh, 0B0h, 0CFh, 0D8h, 0F2h, 0CEh ; 105ac
	DB 0F3h, 0CEh ; 105b4
	ASCII "A" ; 105b6
	DB 06h, 0CEh ; 105b7
	ASCII "I" ; 105b9
	DB 07h, 0D4h, 00h, 00h, 0E6h, 04h, 0F2h, 8Dh ; 105ba
	DB 0F3h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 105c2
	DB 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0CFh, 0B4h ; 105ca
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 105d2
	DB 0B0h, 03h, 0CEh, 0D4h, 0FAh, 14h, 0CFh, 0B4h ; 105da
	DB 0F8h, 0CEh ; 105e2
	ASCII "A" ; 105e4
	DB 02h, 0F8h, 0CEh ; 105e5
	ASCII "A" ; 105e8
	DB 03h, 0F8h, 06h, 00h, 60h, 0ADh, 06h, 00h ; 105e9
	ASCII "h" ; 105f1
	DB 0ADh, 0C1h, 99h, 0EBh, 05h, 18h, 18h, 0FCh ; 105f2
	DB 01h, 0FEh, 0FEh, 00h, 00h ; 105fa
	ASCII "0" ; 105ff
	DB 18h, 00h, 02h, 0FEh, 0FEh, 00h, 00h ; 10600
	ASCII "H" ; 10607
	DB 18h, 01h, 03h, 0FEh, 0FEh, 00h, 00h, 18h ; 10608
	DB 28h, 02h, 04h, 0FEh, 0FEh, 00h, 00h ; 10610
	ASCII "0(" ; 10617
	DB 03h, 05h, 0FEh, 0FEh, 00h, 00h ; 10619
	ASCII "H(" ; 1061f
	DB 04h, 06h, 0FEh, 0FEh, 00h, 00h ; 10621
	ASCII "HH" ; 10627
	DB 0FEh, 0FEh, 0FEh, 0FEh, 00h, 00h, 0C7h, 0F7h ; 10629
	DB 05h, 0CEh, 0D0h, 0BAh, 1Ah, 0F2h, 15h, 0FFh ; 10631
	DB 0F8h, 0C7h, 0F7h, 05h, 0CEh, 0C7h, 01h, 0CEh ; 10639
	DB 0D0h, 0BAh, 1Ah, 0F2h, 2Eh, 0FFh, 0CEh, 0D4h ; 10641
	DB 0BAh, 1Ah, 0F8h, 2Fh, 86h, 3Ah, 86h, 0EBh ; 10649
	DB 05h, 00h, 00h, 0FEh, 0FEh, 0FFh, 01h ; 10651
	ASCII "b" ; 10658
	DB 06h, 00h, 00h, 0FEh, 0FEh, 00h, 0FFh ; 10659
	ASCII "n" ; 10660
	DB 06h, 06h, 00h, 28h, 0ADh, 06h, 00h ; 10661
	ASCII "0" ; 10668
	DB 0ADh, 0C1h, 99h ; 10669
	ASCII "b" ; 1066c
	DB 06h, 06h, 00h ; 1066d
	ASCII "8" ; 10670
	DB 0ADh, 06h, 00h, 40h, 0ADh, 0C1h, 99h ; 10671
	ASCII "n" ; 10678
	DB 06h, 0C7h ; 10679
	ASCII "R" ; 1067b
	DB 06h, 0CEh, 0D0h, 8Eh, 16h, 0F2h ; 1067c
	ASCII "k" ; 10682
	DB 0Fh, 0F8h, 0C7h ; 10683
	ASCII "R" ; 10686
	DB 06h, 0CEh, 0C7h, 01h, 0CEh, 0D0h, 8Eh, 16h ; 10687
	DB 0F2h, 7Fh, 0Fh, 0CEh, 0D4h, 8Eh, 16h, 0F8h ; 1068f
	ASCII "z" ; 10697
	DB 86h, 85h, 86h ; 10698
	ASCII "n" ; 1069b
	DB 06h, 00h, 00h, 04h, 08h, 10h, 00h, 05h ; 1069c
	DB 08h, 20h, 00h, 06h, 08h ; 106a4
	ASCIZ "0" ; 106a9
	DB 07h, 08h, 40h, 00h, 08h, 08h ; 106ab
	ASCIZ "P" ; 106b1
	DB 09h, 08h, 00h, 10h, 14h, 08h, 10h, 10h ; 106b3
	DB 15h, 08h, 20h, 10h, 16h, 08h ; 106bb
	ASCII "0" ; 106c1
	DB 10h, 17h, 08h, 40h, 10h, 18h, 08h ; 106c2
	ASCII "P" ; 106c9
	DB 10h, 19h, 88h, 00h, 00h, 0Ah, 08h, 10h ; 106ca
	DB 00h, 0Bh, 08h, 20h, 00h, 0Ch, 08h ; 106d2
	ASCIZ "0" ; 106d9
	DB 0Dh, 08h, 40h, 00h, 0Eh, 08h ; 106db
	ASCIZ "P" ; 106e1
	DB 0Fh, 08h, 00h, 10h, 1Ah, 08h, 10h, 10h ; 106e3
	DB 1Bh, 08h, 20h, 10h, 1Ch, 08h ; 106eb
	ASCII "0" ; 106f1
	DB 10h, 1Dh, 08h, 40h, 10h, 1Eh, 08h ; 106f2
	ASCII "P" ; 106f9
	DB 10h, 1Fh, 88h, 00h, 00h, 10h, 88h, 00h ; 106fa
	DB 00h, 11h, 88h, 10h, 00h, 04h, 08h, 20h ; 10702
	DB 00h, 05h, 08h ; 1070a
	ASCIZ "0" ; 1070d
	DB 06h, 08h, 40h, 00h, 07h, 08h, 10h, 10h ; 1070f
	DB 08h, 08h, 20h, 10h, 09h, 08h ; 10717
	ASCII "0" ; 1071d
	DB 10h, 0Ah, 08h, 40h, 10h, 0Bh, 88h, 10h ; 1071e
	DB 00h, 0Ch, 08h, 20h, 00h, 0Dh, 08h ; 10726
	ASCIZ "0" ; 1072d
	DB 0Eh, 08h, 40h, 00h, 0Fh, 08h, 10h, 10h ; 1072f
	DB 10h, 08h, 20h, 10h, 11h, 08h ; 10737
	ASCII "0" ; 1073d
	DB 10h, 12h, 08h, 40h, 10h, 13h, 88h, 28h ; 1073e
	DB 08h, 14h, 88h, 28h, 08h, 15h, 88h, 28h ; 10746
	DB 08h, 16h, 88h, 28h, 10h, 17h, 88h, 28h ; 1074e
	DB 10h, 18h, 88h, 00h, 00h, 00h, 88h, 00h ; 10756
	DB 00h, 01h, 88h, 00h, 00h, 02h, 88h, 00h ; 1075e
	DB 00h, 03h, 88h, 08h, 00h, 05h, 88h, 08h ; 10766
	DB 00h, 06h, 88h, 08h, 00h, 07h, 88h, 00h ; 1076e
	DB 00h, 04h, 08h, 10h, 00h, 04h, 89h, 0FFh ; 10776
	DB 00h, 04h, 08h, 11h, 00h, 04h, 89h, 08h ; 1077e
	DB 00h ; 10786
	ASCII "a" ; 10787
	DB 07h, 08h, 00h ; 10788
	ASCII "e" ; 1078b
	DB 07h, 0C1h, 99h, 85h, 07h, 0F8h, 0CEh, 0D0h ; 1078c
	DB 0B3h, 1Bh ; 10794
	ASCIZ "2" ; 10796
	DB 0E6h, 07h, 0B0h ; 10798
	ASCII "d" ; 1079b
	DB 0CEh ; 1079c
	ASCII "D" ; 1079d
	DB 0Ah, 0F8h, 0CEh, 0D0h, 0B5h, 1Bh, 0B1h, 00h ; 1079e
	DB 0C7h, 0B0h, 07h, 0CFh ; 107a6
	ASCII "BG" ; 107aa
	DB 0CEh ; 107ac
	ASCII "D" ; 107ad
	DB 0Ah, 0F8h, 18h, 20h, 28h ; 107ae
	ASCII "08d" ; 107b3
	DB 91h, 87h, 92h, 87h, 85h, 07h, 01h, 00h ; 107b6
	ASCII "Y" ; 107be
	DB 07h, 01h, 00h, 5Dh, 07h, 0C1h, 99h, 0BCh ; 107bf
	DB 07h, 08h, 10h, 19h, 05h, 22h, 01h, 00h ; 107c7
	DB 00h, 10h, 10h, 1Ah, 06h, 00h, 02h, 00h ; 107cf
	DB 00h, 18h, 10h, 1Bh, 07h, 01h, 03h, 00h ; 107d7
	DB 00h, 20h, 10h, 1Ch, 08h, 02h, 04h, 00h ; 107df
	DB 00h, 28h, 10h, 1Dh, 09h, 03h, 1Eh, 00h ; 107e7
	DB 00h, 08h, 18h, 00h, 0Ah, 27h, 06h, 00h ; 107ef
	DB 00h, 10h, 18h, 01h, 0Bh, 05h, 07h, 00h ; 107f7
	DB 00h, 18h, 18h, 02h, 0Ch, 06h, 08h, 00h ; 107ff
	DB 00h, 20h, 18h, 03h, 0Dh, 07h, 09h, 00h ; 10807
	DB 00h, 28h, 18h, 04h, 0Eh, 08h, 23h, 00h ; 1080f
	DB 00h, 08h, 20h, 05h, 0Fh, 2Ch, 0Bh, 00h ; 10817
	DB 00h, 10h, 20h, 06h, 10h, 0Ah, 0Ch, 00h ; 1081f
	DB 00h, 18h, 20h, 07h, 11h, 0Bh, 0Dh, 00h ; 10827
	DB 00h, 20h, 20h, 08h, 12h, 0Ch, 0Eh, 00h ; 1082f
	DB 00h, 28h, 20h, 09h, 13h, 0Dh, 28h, 00h ; 10837
	DB 00h, 08h, 28h, 0Ah, 14h ; 1083f
	ASCII "1" ; 10844
	DB 10h, 00h, 00h, 10h, 28h, 0Bh, 15h, 0Fh ; 10845
	DB 11h, 00h, 00h, 18h, 28h, 0Ch, 16h, 10h ; 1084d
	DB 12h, 00h, 00h, 20h, 28h, 0Dh, 17h, 11h ; 10855
	DB 13h, 00h, 00h, 28h, 28h, 0Eh, 18h, 12h ; 1085d
	DB 2Dh, 00h, 00h, 08h ; 10865
	ASCII "0" ; 10869
	DB 0Fh, 19h ; 1086a
	ASCII "6" ; 1086c
	DB 15h, 00h, 00h, 10h ; 1086d
	ASCII "0" ; 10871
	DB 10h, 1Ah, 14h, 16h, 00h, 00h, 18h ; 10872
	ASCII "0" ; 10879
	DB 11h, 1Bh, 15h, 17h, 00h, 00h, 20h ; 1087a
	ASCII "0" ; 10881
	DB 12h, 1Ch, 16h, 18h, 00h, 00h, 28h ; 10882
	ASCII "0" ; 10889
	DB 13h, 1Dh, 17h ; 1088a
	ASCIZ "2" ; 1088d
	DB 00h, 08h ; 1088f
	ASCII "8" ; 10891
	DB 14h, 00h, 3Bh, 1Ah, 00h, 00h, 10h ; 10892
	ASCII "8" ; 10899
	DB 15h, 01h, 19h, 1Bh, 00h, 00h, 18h ; 1089a
	ASCII "8" ; 108a1
	DB 16h, 02h, 1Ah, 1Ch, 00h, 00h, 20h ; 108a2
	ASCII "8" ; 108a9
	DB 17h, 03h, 1Bh, 1Dh, 00h, 00h, 28h ; 108aa
	ASCII "8" ; 108b1
	DB 18h, 04h, 1Ch ; 108b2
	ASCIZ "7" ; 108b5
	DB 00h ; 108b7
	ASCII "0" ; 108b8
	DB 10h ; 108b9
	ASCII "7#" ; 108ba
	DB 04h, 1Fh, 00h, 00h ; 108bc
	ASCII "8" ; 108c0
	DB 10h ; 108c1
	ASCII "8$" ; 108c2
	DB 1Eh, 20h, 00h, 00h, 40h, 10h ; 108c4
	ASCII "9%" ; 108ca
	DB 1Fh, 21h, 00h, 00h ; 108cc
	ASCII "H" ; 108d0
	DB 10h, 3Ah, 26h, 20h, 22h, 00h, 00h ; 108d1
	ASCII "P" ; 108d8
	DB 10h, 3Bh, 27h, 21h, 00h, 00h, 00h ; 108d9
	ASCII "0" ; 108e0
	DB 18h, 1Eh, 28h, 09h, 24h, 00h, 00h ; 108e1
	ASCII "8" ; 108e8
	DB 18h, 1Fh, 29h, 23h, 25h, 00h, 00h, 40h ; 108e9
	DB 18h, 20h, 2Ah, 24h, 26h, 00h, 00h ; 108f1
	ASCII "H" ; 108f8
	DB 18h, 21h, 2Bh, 25h, 27h, 00h, 00h ; 108f9
	ASCII "P" ; 10900
	DB 18h, 22h, 2Ch, 26h, 05h, 00h, 00h ; 10901
	ASCII "0 #-" ; 10908
	DB 0Eh, 29h, 00h, 00h ; 1090c
	ASCIZ "8 $.(*" ; 10910
	DB 00h, 40h, 20h, 25h, 2Fh, 29h, 2Bh, 00h ; 10917
	DB 00h ; 1091f
	ASCIZ "H &0*," ; 10920
	DB 00h ; 10927
	ASCII "P '1+" ; 10928
	DB 0Ah, 00h, 00h ; 1092d
	ASCII "0((2" ; 10930
	DB 13h, 2Eh, 00h, 00h ; 10934
	ASCIZ "8()3-/" ; 10938
	DB 00h, 40h, 28h, 2Ah ; 1093f
	ASCIZ "4.0" ; 10943
	DB 00h ; 10947
	ASCIZ "H(+5/1" ; 10948
	DB 00h ; 1094f
	ASCII "P(,60" ; 10950
	DB 0Fh, 00h, 00h ; 10955
	ASCII "00-7" ; 10958
	DB 18h ; 1095c
	ASCIZ "3" ; 1095d
	DB 00h ; 1095f
	ASCIZ "80.824" ; 10960
	DB 00h, 40h ; 10967
	ASCIZ "0/935" ; 10969
	DB 00h ; 1096f
	ASCIZ "H00:46" ; 10970
	DB 00h ; 10977
	ASCII "P01;5" ; 10978
	DB 14h, 00h, 00h ; 1097d
	ASCII "082" ; 10980
	DB 1Eh, 1Dh ; 10983
	ASCIZ "8" ; 10985
	DB 00h ; 10987
	ASCII "883" ; 10988
	DB 1Fh ; 1098b
	ASCIZ "79" ; 1098c
	DB 00h, 40h ; 1098f
	ASCIZ "84 8:" ; 10991
	DB 00h ; 10997
	ASCIZ "H85!9;" ; 10998
	DB 00h ; 1099f
	ASCII "P86", 22h, ":" ; 109a0
	DB 19h, 00h, 00h, 01h, 02h, 03h, 04h, 05h ; 109a5
	DB 06h, 07h, 08h, 09h, 0Ah, 0Bh, 0Ch, 0Dh ; 109ad
	DB 0Eh, 0Fh, 10h, 11h, 12h, 13h, 14h, 15h ; 109b5
	DB 16h, 17h, 18h, 19h, 1Ah, 1Bh, 1Ch, 1Dh ; 109bd
	DB 1Eh, 1Fh, 20h, 21h, 22h, 23h, 24h, 25h ; 109c5
	DB 26h, 0FFh, 0FFh, 27h, 28h, 29h, 2Ah, 2Bh ; 109cd
	DB 2Ch, 2Dh, 2Eh, 0E4h ; 109d5
	ASCII "PHIJKLMNO" ; 109d9
	DB 0FFh, 0FFh ; 109e2
	ASCII "QRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuv" ; 109e4
	DB 0FFh, 0FFh ; 10a0a
	ASCII "wxyz{|}~" ; 10a0c
	DB 0E4h, 0A0h, 98h, 99h, 9Ah, 9Bh, 9Ch, 9Dh ; 10a14
	DB 9Eh, 9Fh, 0FFh, 0FFh, 00h, 01h, 02h, 03h ; 10a1c
	DB 04h, 05h, 2Fh ; 10a24
	ASCII "0123456789:;<=" ; 10a27
	DB 15h, 16h, 17h, 18h, 19h, 3Eh, 3Fh, 40h ; 10a35
	ASCII "AB" ; 10a3d
	DB 1Fh, 20h, 21h, 22h, 23h, 24h, 25h, 26h ; 10a3f
	DB 27h, 28h, 29h, 2Ah, 2Bh, 2Ch, 2Dh, 2Eh ; 10a47
	DB 2Fh ; 10a4f
	ASCII "0123456789:;<=>?@AB>?@ABHIJKLMNOPQRSTU" ; 10a50
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 10a77
	DB 88h, 89h, 8Ah, 8Bh, 8Ch, 8Dh ; 10a7f
	ASCII "efghi" ; 10a85
	DB 8Eh, 8Fh, 90h, 91h, 92h ; 10a8a
	ASCII "opqrstuvwxyz{|}~" ; 10a8f
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 10aa0
	DB 88h, 89h, 8Ah, 8Bh, 8Ch, 8Dh, 8Eh, 8Fh ; 10aa8
	DB 90h, 91h, 92h, 8Eh, 8Fh, 90h, 91h, 92h ; 10ab0
	DB 98h, 99h, 9Ah, 9Bh, 9Ch, 9Dh, 9Eh, 9Fh ; 10ab8
	DB 0A0h, 0A1h, 0A2h, 0A3h, 0A4h, 0A5h, 0A6h, 0A7h ; 10ac0
	DB 0A8h, 0A9h, 0AAh, 0ABh, 0ACh, 0ADh, 0AEh, 0AFh ; 10ac8
	DB 0B0h, 0B1h, 0B2h, 0B3h, 0B4h, 0B5h, 0B6h, 0B7h ; 10ad0
	DB 0B8h, 0B9h, 0BAh, 0BBh, 0BCh, 0BDh, 0BEh, 0BFh ; 10ad8
	DB 0C0h, 0C1h, 0C2h, 0C3h, 0C4h, 0C5h, 0C6h, 0C7h ; 10ae0
	DB 0C8h, 0C9h, 0CAh, 0CBh, 0CCh, 0CDh, 0CEh, 0CFh ; 10ae8
	DB 0D0h, 0D1h, 0D2h, 0D3h, 0D4h, 0D5h, 0D6h, 0D7h ; 10af0
	DB 0D8h, 0D9h, 0DAh, 0DBh, 0DCh, 0DDh, 0DEh, 0DFh ; 10af8
	DB 0E0h, 0E1h, 0E2h, 0E3h, 0E4h, 0E5h, 0E6h, 0E7h ; 10b00
	DB 0E8h, 0E9h, 0EAh, 0EBh, 00h, 01h, 02h, 03h ; 10b08
	DB 04h, 05h, 06h, 07h, 08h, 09h, 0Ah, 0Bh ; 10b10
	DB 0Ch, 0Dh, 0Eh, 0Fh, 10h, 11h, 12h, 13h ; 10b18
	DB 14h, 15h, 16h, 17h, 18h, 19h ; 10b20
	ASCII "CDEFG" ; 10b26
	DB 1Fh, 20h, 21h, 22h, 23h, 24h, 25h, 26h ; 10b2b
	DB 27h, 28h, 29h, 2Ah, 2Bh, 2Ch, 2Dh, 2Eh ; 10b33
	DB 2Fh ; 10b3b
	ASCII "0123456789:;<=CDEFGCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghi" ; 10b3c
	DB 93h, 94h, 95h, 96h, 97h ; 10b76
	ASCII "opqrstuvwxyz{|}~" ; 10b7b
	DB 80h, 81h, 82h, 83h, 84h, 85h, 86h, 87h ; 10b8c
	DB 88h, 89h, 8Ah, 8Bh, 8Ch, 8Dh, 93h, 94h ; 10b94
	DB 95h, 96h, 97h, 93h, 94h, 95h, 96h, 97h ; 10b9c
	DB 98h, 99h, 9Ah, 9Bh, 9Ch, 9Dh, 9Eh, 9Fh ; 10ba4
	DB 0A0h, 0A1h, 0A2h, 0A3h, 0A4h, 0A5h, 0A6h, 0A7h ; 10bac
	DB 0A8h, 0A9h, 0AAh, 0ABh, 0ACh, 0ADh, 0AEh, 0AFh ; 10bb4
	DB 0B0h, 0B1h, 0B2h, 0B3h, 0B4h, 0B5h, 0B6h, 0B7h ; 10bbc
	DB 0B8h, 0B9h, 0BAh, 0BBh, 0BCh, 0BDh, 0BEh, 0BFh ; 10bc4
	DB 0C0h, 0C1h, 0C2h, 0C3h, 0C4h, 0C5h, 0C6h, 0C7h ; 10bcc
	DB 0C8h, 0C9h, 0CAh, 0CBh, 0CCh, 0CDh, 0CEh, 0CFh ; 10bd4
	DB 0D0h, 0D1h, 0D2h, 0D3h, 0D4h, 0D5h, 0D6h, 0D7h ; 10bdc
	DB 0D8h, 0D9h, 0DAh, 0DBh, 0DCh, 0DDh, 0DEh, 0DFh ; 10be4
	DB 0E0h, 0E1h, 0E2h, 0E3h, 0E4h, 0E5h, 0E6h, 0E7h ; 10bec
	DB 0E8h, 0E9h, 0EAh, 0EBh, 0C7h, 0C8h, 07h, 0CEh ; 10bf4
	DB 0C7h, 01h, 0CEh, 0D0h, 0B6h, 1Bh, 0F2h, 0EAh ; 10bfc
	DB 09h, 0F8h, 0CEh, 0D0h, 0B3h, 1Bh ; 10c04
	ASCIZ "2" ; 10c0a
	DB 0E6h, 07h, 0B0h ; 10c0c
	ASCII "d" ; 10c0f
	DB 0CEh ; 10c10
	ASCII "D" ; 10c11
	DB 0Ah, 0F8h, 0CEh, 0D0h, 0B6h, 1Bh, 0F2h ; 10c12
	ASCII "H" ; 10c19
	DB 01h, 0C7h, 0C8h, 07h, 0CEh, 0C7h, 01h, 0CEh ; 10c1a
	DB 0D0h, 0B6h, 1Bh, 0F2h, 0E9h, 09h, 0CEh, 0D4h ; 10c22
	DB 0B6h, 1Bh, 0C5h ; 10c2a
	ASCII "C" ; 10c2d
	DB 16h, 95h, 01h, 0EFh, 07h, 00h, 95h, 02h ; 10c2e
	DB 0EFh, 99h, 00h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah ; 10c36
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 10c3e
	DB 14h, 0CEh, 0D0h, 0B6h, 1Bh ; 10c46
	ASCII "2&" ; 10c4b
	DB 0EEh ; 10c4d
	ASCIZ "H" ; 10c4e
	ASCII "2'" ; 10c50
	DB 0EEh ; 10c52
	ASCIZ "M" ; 10c53
	ASCII "2:" ; 10c55
	DB 0EEh ; 10c57
	ASCIZ "R" ; 10c58
	ASCII "2;" ; 10c5a
	DB 0EEh ; 10c5c
	ASCIZ "T" ; 10c5d
	DB 0CEh, 0D0h, 0B5h, 1Bh, 0B1h, 00h, 0C5h, 0ACh ; 10c5f
	DB 1Bh, 0CFh, 20h, 0CEh, 0D0h, 0B6h, 1Bh, 0CEh ; 10c67
	DB 0D1h, 0B4h, 1Bh, 97h, 01h, 0E6h, 03h, 02h ; 10c6f
	DB 3Ch, 0B1h, 00h, 0C7h, 0A8h, 09h, 0CFh ; 10c77
	ASCII "B" ; 10c7e
	DB 0A6h, 0CEh, 0C7h, 01h ; 10c7f
	ASCII "Gh" ; 10c83
	DB 0AEh, 0CEh, 0D0h, 0B5h, 1Bh ; 10c85
	ASCII "2" ; 10c8a
	DB 04h, 0E6h, 06h, 80h, 0CEh, 0D4h, 0B5h, 1Bh ; 10c8b
	DB 0F2h, 0ABh, 00h, 0F8h, 0C7h, 20h, 0Ah, 0F2h ; 10c93
	DB 7Ch, 00h, 0F2h, 0A1h, 00h, 0F8h, 0C7h, 0Ch ; 10c9b
	DB 0Bh, 0F2h ; 10ca3
	ASCIZ "r" ; 10ca5
	DB 0F2h, 97h, 00h, 0F8h, 0C5h, 0B4h, 1Bh, 0CEh ; 10ca7
	DB 3Dh, 01h, 0F8h, 0CEh, 0C4h, 03h, 0F2h, 0A7h ; 10caf
	ASCIZ "Y2" ; 10cb7
	DB 0E6h, 08h, 0B0h, 01h, 0CEh, 0D4h, 0B3h, 1Bh ; 10cba
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 10cc2
	DB 0B0h, 03h, 0CEh, 0D4h, 0FAh, 14h, 0F8h, 0CEh ; 10cca
	DB 0D0h, 0B5h, 1Bh, 0B1h, 00h, 0C5h, 0ACh, 1Bh ; 10cd2
	DB 0CFh, 20h, 0CEh ; 10cda
	ASCII "5" ; 10cdd
	DB 0F4h, 0E7h, 0Eh, 0CEh, 0D0h, 0B5h, 1Bh ; 10cde
	ASCIZ "2" ; 10ce5
	DB 0E6h, 22h, 88h, 0CEh, 0D4h, 0B5h, 1Bh, 0CEh ; 10ce7
	DB 0D0h, 0B5h, 1Bh, 0B1h, 00h, 0C5h, 0ACh, 1Bh ; 10cef
	DB 0CFh, 20h, 0B0h, 0F4h ; 10cf7
	ASCII "h" ; 10cfb
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 10cfc
	DB 04h, 0CEh, 0D4h, 0FAh, 14h, 0F8h, 0CEh, 0D0h ; 10d04
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 03h, 0CEh ; 10d0c
	DB 0D4h, 0FAh, 14h, 0F8h, 0CEh, 0D0h, 0B5h, 1Bh ; 10d14
	DB 0B1h, 00h, 0C5h, 0ACh, 1Bh, 0CFh, 20h, 0CEh ; 10d1c
	ASCII "5" ; 10d24
	DB 0F4h, 0E7h, 0Ah, 0CEh, 0D0h, 0B5h, 1Bh ; 10d25
	ASCIZ "2" ; 10d2c
	DB 0E6h, 10h, 88h, 0B1h, 00h, 0C5h, 0ACh, 1Bh ; 10d2e
	DB 0CFh, 20h ; 10d36
	ASCII "E" ; 10d38
	DB 0B1h, 00h, 0CFh ; 10d39
	ASCII "BGh" ; 10d3c
	DB 0F8h, 0CEh, 0D0h, 0B5h, 1Bh ; 10d3f
	ASCII "2" ; 10d44
	DB 04h, 0E7h, 1Ah, 0CEh, 0D0h, 0B5h, 1Bh, 0B1h ; 10d45
	DB 00h, 0C5h, 0ACh, 1Bh, 0CFh, 20h, 0CEh ; 10d4d
	ASCII "5" ; 10d54
	DB 0F4h, 0E6h, 0Ah, 0B0h, 3Bh, 0CEh, 0D4h, 0B6h ; 10d55
	DB 1Bh, 0F2h, 02h, 00h, 0F8h, 0C7h, 0C8h, 07h ; 10d5d
	DB 0CEh, 0C7h, 01h, 0B2h, 08h, 0CEh, 0D8h, 0CFh ; 10d65
	ASCII "C" ; 10d6d
	DB 0CFh, 0D8h, 0F2h, 10h, 0ECh, 0F8h, 0F8h, 8Bh ; 10d6e
	DB 06h, 8Ch, 0BCh, 07h, 04h, 00h ; 10d76
	ASCII "i" ; 10d7c
	DB 07h, 8Eh, 99h, 04h, 00h ; 10d7d
	ASCII "m" ; 10d82
	DB 07h, 8Eh, 99h, 04h, 00h ; 10d83
	ASCII "q" ; 10d88
	DB 07h, 8Eh, 99h, 0CEh, 0D0h, 0B2h, 1Bh, 0CEh ; 10d89
	DB 80h, 0B1h, 00h, 0C7h, 9Fh, 0Dh, 0CFh ; 10d91
	ASCII "B" ; 10d98
	DB 0CFh, 0D8h, 0F2h, 0B2h, 0EBh, 0F8h ; 10d99
	ASCII "z" ; 10d9f
	DB 0Dh, 80h, 0Dh, 86h, 0Dh, 8Ch, 8Dh, 8Ch ; 10da0
	DB 8Dh ; 10da8
	ASCII "z" ; 10da9
	DB 0Dh, 0Ch, 00h ; 10daa
	ASCII "u" ; 10dad
	DB 07h, 0Ch, 00h, 7Dh, 07h, 0C1h, 99h, 0ABh ; 10dae
	DB 0Dh, 0F8h, 0CEh, 0D0h, 0B3h, 1Bh ; 10db6
	ASCII "2" ; 10dbc
	DB 01h, 0E6h, 07h, 0B0h ; 10dbd
	ASCII "d" ; 10dc1
	DB 0CEh ; 10dc2
	ASCII "D" ; 10dc3
	DB 0Ah, 0F8h, 0B0h, 40h, 0CEh ; 10dc4
	ASCII "D" ; 10dc9
	DB 0Ah, 0C4h, 0D2h, 8Dh, 0F2h ; 10dca
	ASCII "x" ; 10dcf
	DB 0EBh, 0F8h, 0C5h ; 10dd0
	ASCII "C" ; 10dd3
	DB 16h, 95h, 01h, 0EFh ; 10dd4
	ASCIZ "M" ; 10dd8
	DB 95h, 02h, 0EFh ; 10dda
	ASCIZ "x" ; 10ddd
	DB 95h, 20h, 0EFh, 07h, 00h, 95h, 40h, 0EFh ; 10ddf
	DB 21h, 00h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 10de7
	DB 0E6h, 07h, 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h ; 10def
	DB 0CEh, 0D0h, 0B2h, 1Bh, 88h, 0E6h, 05h ; 10df7
	ASCII "2" ; 10dfe
	DB 0FFh, 0E7h, 03h, 0B0h, 02h, 0CEh, 0D4h, 0B2h ; 10dff
	DB 1Bh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 10e07
	DB 07h, 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0CEh ; 10e0f
	DB 0D0h, 0B2h, 1Bh, 80h ; 10e17
	ASCII "2" ; 10e1b
	DB 03h, 0E7h, 03h, 0B0h, 01h, 0CEh, 0D4h, 0B2h ; 10e1c
	DB 1Bh, 0F8h, 0CEh, 0D0h, 0B2h, 1Bh ; 10e24
	ASCIZ "2" ; 10e2a
	DB 0E6h, 1Bh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 10e2c
	DB 07h, 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0B0h ; 10e34
	DB 02h, 0CEh, 0D4h, 0B3h, 1Bh, 0C4h, 0B8h, 8Dh ; 10e3c
	DB 0F2h, 02h, 0EBh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah ; 10e44
	DB 20h, 0E6h, 07h, 0B0h, 03h, 0CEh, 0D4h, 0FAh ; 10e4c
	DB 14h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 10e54
	DB 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C4h ; 10e5c
	DB 0B8h, 8Dh, 0F2h, 0E0h, 0EAh, 0CEh, 0C4h, 03h ; 10e64
	DB 0F2h, 0F0h ; 10e6c
	ASCII "W2" ; 10e6e
	DB 05h, 0E7h, 02h, 88h, 0CEh, 0D4h, 0B5h, 1Bh ; 10e70
	DB 0B0h, 00h, 0CEh, 0D4h, 0B3h, 1Bh, 0F8h, 0B7h ; 10e78
	DB 8Dh, 0B8h, 8Dh, 0ABh, 0Dh, 03h, 00h, 0Ch ; 10e80
	DB 0C8h, 03h, 00h, 10h, 0C8h, 05h, 00h, 14h ; 10e88
	DB 0C8h, 03h, 00h, 10h, 0C8h, 0C1h, 99h, 85h ; 10e90
	DB 0Eh, 00h, 00h, 0FEh, 0FEh, 0FEh, 0FEh, 00h ; 10e98
	DB 00h, 00h, 00h, 01h, 01h, 0FEh, 0FEh, 00h ; 10ea0
	DB 00h, 00h, 08h, 00h, 00h, 0FEh, 0FEh, 00h ; 10ea8
	DB 00h, 00h, 00h, 02h, 01h, 0FEh, 0FEh, 00h ; 10eb0
	DB 00h, 00h, 08h, 00h, 02h, 0FEh, 0FEh, 00h ; 10eb8
	DB 00h, 00h, 10h, 01h, 00h, 0FEh, 0FEh, 00h ; 10ec0
	DB 00h, 00h, 00h, 03h, 01h, 0FEh, 0FEh, 00h ; 10ec8
	DB 00h, 00h, 08h, 00h, 02h, 0FEh, 0FEh, 00h ; 10ed0
	DB 00h, 00h, 10h, 01h, 03h, 0FEh, 0FEh, 00h ; 10ed8
	DB 00h, 00h, 18h, 02h, 00h, 0FEh, 0FEh, 00h ; 10ee0
	DB 00h, 00h, 00h, 04h, 01h, 0FEh, 0FEh, 00h ; 10ee8
	DB 00h, 00h, 08h, 00h, 02h, 0FEh, 0FEh, 00h ; 10ef0
	DB 00h, 00h, 10h, 01h, 03h, 0FEh, 0FEh, 00h ; 10ef8
	DB 00h, 00h, 18h, 02h, 04h, 0FEh, 0FEh, 00h ; 10f00
	DB 00h, 00h, 20h, 03h, 00h, 0FEh, 0FEh, 00h ; 10f08
	DB 00h, 00h, 00h, 05h, 01h, 0FEh, 0FEh, 00h ; 10f10
	DB 00h, 00h, 08h, 00h, 02h, 0FEh, 0FEh, 00h ; 10f18
	DB 00h, 00h, 10h, 01h, 03h, 0FEh, 0FEh, 00h ; 10f20
	DB 00h, 00h, 18h, 02h, 04h, 0FEh, 0FEh, 00h ; 10f28
	DB 00h, 00h, 20h, 03h, 05h, 0FEh, 0FEh, 00h ; 10f30
	DB 00h, 00h, 28h, 04h, 00h, 0FEh, 0FEh, 00h ; 10f38
	DB 00h, 00h, 00h, 06h, 01h, 0FEh, 0FEh, 00h ; 10f40
	DB 00h, 00h, 08h, 00h, 02h, 0FEh, 0FEh, 00h ; 10f48
	DB 00h, 00h, 10h, 01h, 03h, 0FEh, 0FEh, 00h ; 10f50
	DB 00h, 00h, 18h, 02h, 04h, 0FEh, 0FEh, 00h ; 10f58
	DB 00h, 00h, 20h, 03h, 05h, 0FEh, 0FEh, 00h ; 10f60
	DB 00h, 00h, 28h, 04h, 06h, 0FEh, 0FEh, 00h ; 10f68
	DB 00h, 00h ; 10f70
	ASCII "0" ; 10f72
	DB 05h, 00h, 0FEh, 0FEh, 00h, 00h, 00h, 00h ; 10f73
	DB 07h, 01h, 0FEh, 0FEh, 00h, 00h, 00h, 08h ; 10f7b
	DB 00h, 02h, 0FEh, 0FEh, 00h, 00h, 00h, 10h ; 10f83
	DB 01h, 03h, 0FEh, 0FEh, 00h, 00h, 00h, 18h ; 10f8b
	DB 02h, 04h, 0FEh, 0FEh, 00h, 00h, 00h, 20h ; 10f93
	DB 03h, 05h, 0FEh, 0FEh, 00h, 00h, 00h, 28h ; 10f9b
	DB 04h, 06h, 0FEh, 0FEh, 00h, 00h, 00h ; 10fa3
	ASCII "0" ; 10faa
	DB 05h, 07h, 0FEh, 0FEh, 00h, 00h, 00h ; 10fab
	ASCII "8" ; 10fb2
	DB 06h, 00h, 0FEh, 0FEh, 00h, 00h, 0CEh, 0D0h ; 10fb3
	DB 0A9h, 1Bh, 88h, 0B1h, 00h, 0CEh, 80h, 0C7h ; 10fbb
	DB 0CDh, 0Fh, 0CFh ; 10fc3
	ASCII "B" ; 10fc6
	DB 0CFh, 0DBh, 0CEh, 0C7h, 01h, 0F8h, 99h, 0Eh ; 10fc7
	DB 0A1h, 0Eh, 0B1h, 0Eh, 0C9h, 0Eh, 0E9h, 0Eh ; 10fcf
	DB 11h, 0Fh ; 10fd7
	ASCII "A" ; 10fd9
	DB 0Fh ; 10fda
	ASCII "y" ; 10fdb
	DB 0Fh, 0F2h, 0DAh, 0FFh ; 10fdc
	ASCII "8" ; 10fe0
	DB 0CEh, 0D4h, 0AAh, 1Bh, 0F2h, 07h, 06h, 0B0h ; 10fe1
	DB 0FFh, 0CEh, 0D4h, 0A6h, 1Bh, 0F8h, 0F2h, 0C8h ; 10fe9
	DB 0FFh, 0CEh, 0D0h, 0AAh, 1Bh, 0F2h, 18h, 06h ; 10ff1
	DB 0CEh, 0D4h, 0AAh, 1Bh, 0C5h ; 10ff9
	ASCII "C" ; 10ffe
	DB 16h, 95h, 01h, 0EFh, 07h, 00h, 95h, 02h ; 10fff
	DB 0EFh, 1Eh, 00h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah ; 11007
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 1100f
	DB 14h, 0CEh, 0D0h, 0AAh, 1Bh, 0CEh, 0D4h, 0A6h ; 11017
	DB 1Bh, 0C4h ; 1101f
	ASCII "x" ; 11021
	DB 1Ah, 0F2h ; 11022
	ASCII "6" ; 11024
	DB 0E9h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 11025
	DB 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C4h ; 1102d
	ASCII "x" ; 11035
	DB 1Ah, 0F2h, 22h, 0E9h, 0F2h, 0B2h, 92h, 0F2h ; 11036
	ASCII "P" ; 1103e
	DB 92h, 0F8h, 0DDh, 8Fh, 0EFh, 8Fh, 85h, 0Eh ; 1103f
	DB 0CEh, 0D0h, 0A4h, 1Bh, 0B1h, 00h, 0CEh, 80h ; 11047
	DB 0CFh ; 1104f
	ASCII "B" ; 11050
	DB 0CFh, 0D8h, 0CEh ; 11051
	ASCII "D" ; 11054
	DB 02h, 0CEh ; 11055
	ASCII "L" ; 11057
	DB 03h, 0F8h, 01h, 00h, 28h, 0C8h, 01h, 00h ; 11058
	ASCII "H" ; 11060
	DB 0C8h, 0C1h, 99h ; 11061
	ASCII "Z" ; 11064
	DB 10h, 01h, 00h, 05h, 07h, 01h, 00h, 25h ; 11065
	DB 07h, 0C1h, 99h ; 1106d
	ASCII "f" ; 11070
	DB 10h, 01h, 00h, 9Dh, 06h, 01h, 00h, 0CDh ; 11071
	DB 06h, 0C1h, 99h ; 11079
	ASCII "r" ; 1107c
	DB 10h, 0C7h, 85h, 10h, 0F2h, 0C4h, 0FFh, 0F8h ; 1107d
	ASCII "Z" ; 11085
	DB 10h ; 11086
	ASCII "f" ; 11087
	DB 10h ; 11088
	ASCII "r" ; 11089
	DB 10h, 7Eh, 90h ; 1108a
	ASCII "q" ; 1108d
	DB 9Ah ; 1108e
	ASCII "v" ; 1108f
	DB 1Ah, 28h, 00h ; 11090
	ASCII "h" ; 11093
	DB 0C8h, 02h, 00h ; 11094
	ASCII "p" ; 11097
	DB 0C8h, 02h, 00h ; 11098
	ASCII "x" ; 1109b
	DB 0C8h, 02h, 00h ; 1109c
	ASCII "p" ; 1109f
	DB 0C8h ; 110a0
	ASCIZ "P" ; 110a1
	ASCII "h" ; 110a3
	DB 0C8h, 02h, 00h ; 110a4
	ASCII "p" ; 110a7
	DB 0C8h, 02h, 00h ; 110a8
	ASCII "x" ; 110ab
	DB 0C8h, 02h, 00h ; 110ac
	ASCII "p" ; 110af
	DB 0C8h, 03h, 00h ; 110b0
	ASCII "h" ; 110b3
	DB 0C8h, 02h, 00h ; 110b4
	ASCII "p" ; 110b7
	DB 0C8h, 02h, 00h ; 110b8
	ASCII "x" ; 110bb
	DB 0C8h, 02h, 00h ; 110bc
	ASCII "p" ; 110bf
	DB 0C8h, 0C1h, 99h, 91h, 10h, 28h, 00h ; 110c0
	ASCII "E" ; 110c7
	DB 07h, 02h, 00h ; 110c8
	ASCII "I" ; 110cb
	DB 07h, 02h, 00h ; 110cc
	ASCII "M" ; 110cf
	DB 07h, 02h, 00h ; 110d0
	ASCII "I" ; 110d3
	DB 07h ; 110d4
	ASCIZ "P" ; 110d5
	ASCII "E" ; 110d7
	DB 07h, 02h, 00h ; 110d8
	ASCII "I" ; 110db
	DB 07h, 02h, 00h ; 110dc
	ASCII "M" ; 110df
	DB 07h, 02h, 00h ; 110e0
	ASCII "I" ; 110e3
	DB 07h, 03h, 00h ; 110e4
	ASCII "E" ; 110e7
	DB 07h, 02h, 00h ; 110e8
	ASCII "I" ; 110eb
	DB 07h, 02h, 00h ; 110ec
	ASCII "M" ; 110ef
	DB 07h, 02h, 00h ; 110f0
	ASCII "I" ; 110f3
	DB 07h, 0C1h, 99h, 0C5h, 10h, 0C7h, 00h, 11h ; 110f4
	DB 0F2h ; 110fc
	ASCII "I" ; 110fd
	DB 0FFh, 0F8h, 91h, 10h, 0C5h, 10h ; 110fe
	ASCII "v" ; 11104
	DB 1Ah, 0F9h, 90h ; 11105
	ASCII "q" ; 11108
	DB 9Ah ; 11109
	ASCII "v" ; 1110a
	DB 1Ah, 0C5h, 0A5h, 1Bh, 95h, 01h, 0EFh, 0AEh ; 1110b
	DB 08h, 0C3h, 02h, 00h, 0F8h, 03h, 00h, 88h ; 11113
	DB 0C8h, 01h, 00h, 88h, 0C8h, 03h, 00h, 80h ; 1111b
	DB 0C8h, 02h, 00h, 80h, 0C8h, 0Ch, 91h, 18h ; 11123
	DB 11h, 9Dh, 99h ; 1112b
	ASCII "Y" ; 1112e
	DB 91h, 8Eh, 99h, 03h, 00h ; 1112f
	ASCII "U" ; 11134
	DB 07h, 01h, 00h ; 11135
	ASCII "U" ; 11138
	DB 07h, 03h, 00h ; 11139
	ASCII "Q" ; 1113c
	DB 07h, 02h, 00h ; 1113d
	ASCII "Q" ; 11140
	DB 07h, 0Ch, 91h ; 11141
	ASCII "2" ; 11144
	DB 11h, 9Dh, 99h ; 11145
	ASCII "Y" ; 11148
	DB 91h, 8Eh, 99h, 0C7h ; 11149
	ASCII "S" ; 1114d
	DB 11h, 0F2h, 0F6h, 0FEh, 0F8h, 18h, 11h ; 1114e
	ASCII "2" ; 11155
	DB 11h ; 11156
	ASCII "v" ; 11157
	DB 1Ah, 0C5h, 0A5h, 1Bh, 95h, 01h, 0EEh, 0Eh ; 11158
	DB 00h, 0B0h, 01h, 0CEh ; 11160
	ASCII "D" ; 11164
	DB 06h, 0C4h ; 11165
	ASCII "q" ; 11167
	DB 9Ah, 0F2h, 0DDh, 0E7h, 0F1h, 0DFh, 0F8h ; 11168
	ASCII "L" ; 1116f
	DB 91h ; 11170
	ASCII "q" ; 11171
	DB 9Ah ; 11172
	ASCII "v" ; 11173
	DB 1Ah, 0Ch, 00h, 24h, 0C8h, 0Ch, 00h, 08h ; 11174
	DB 0C8h, 0C1h, 99h ; 1117c
	ASCII "u" ; 1117f
	DB 11h, 0CEh, 0D0h, 98h, 1Bh, 88h, 05h, 9Ah ; 11180
	DB 1Bh, 0CEh, 80h, 0CEh, 80h, 0CEh, 80h, 0CEh ; 11188
	ASCII "D" ; 11190
	DB 0Ah, 0CEh, 0D0h, 99h, 1Bh, 88h, 05h, 9Bh ; 11191
	DB 1Bh, 0CEh, 80h, 0CEh, 80h, 0CEh, 80h, 0CEh ; 11199
	ASCII "D" ; 111a1
	DB 0Eh, 0C5h, 0A5h, 1Bh, 0CEh, 2Dh, 02h, 0B8h ; 111a2
	DB 1Fh, 16h, 0D4h, 1Ch, 0E9h, 0E7h, 11h, 0CEh ; 111aa
	DB 0D0h, 21h, 16h ; 111b2
	ASCII "2" ; 111b5
	DB 03h, 0E7h, 09h, 0CEh, 40h, 0Ah, 02h, 08h ; 111b6
	DB 0CEh ; 111be
	ASCII "D" ; 111bf
	DB 0Ah, 0F8h, 0C5h ; 111c0
	ASCII "C" ; 111c3
	DB 16h, 95h, 01h, 0E6h, 1Ah, 0CEh, 0D0h, 0B6h ; 111c4
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h ; 111cc
	DB 0FAh, 14h, 0C5h, 0A5h, 1Bh, 0CEh, 25h, 0FDh ; 111d4
	DB 0C4h ; 111dc
	ASCII "x" ; 111dd
	DB 1Ah, 0F2h ; 111de
	ASCII "z" ; 111e0
	DB 0E7h, 0F8h, 81h, 91h, 0C2h, 91h ; 111e1
	ASCII "u" ; 111e7
	DB 11h, 03h, 00h, 18h, 0C8h, 03h, 00h, 1Ch ; 111e8
	DB 0C8h, 05h, 00h, 20h, 0C8h, 03h, 00h, 1Ch ; 111f0
	DB 0C8h, 0C1h, 99h, 0E9h, 11h, 81h, 91h, 0C2h ; 111f8
	DB 91h, 0E9h, 11h, 00h ; 11200
	ASCII "0" ; 11204
	DB 0FEh, 0FEh, 0FEh, 01h, 00h, 00h, 20h ; 11205
	ASCII "0" ; 1120c
	DB 0FEh, 0FEh, 00h, 0FEh, 00h, 00h, 00h, 20h ; 1120d
	DB 0FEh, 0FEh, 0FEh, 01h, 00h, 00h, 20h, 20h ; 11215
	DB 0FEh, 0FEh, 00h, 0FEh, 00h, 00h, 03h, 00h ; 1121d
	DB 0Ch, 0C8h, 03h, 00h, 10h, 0C8h, 05h, 00h ; 11225
	DB 14h, 0C8h, 03h, 00h, 10h, 0C8h, 0C1h, 99h ; 1122d
	DB 23h, 12h, 0B0h, 0FFh, 0CEh, 0D4h, 0A6h, 1Bh ; 11235
	ASCII "8" ; 1123d
	DB 0CEh, 0D4h, 0A7h, 1Bh, 0C7h, 03h, 12h, 0CEh ; 1123e
	DB 0C7h, 01h, 0CEh, 0D0h, 0A7h, 1Bh, 0F2h, 0A0h ; 11246
	DB 03h, 0F8h, 0B0h, 0FFh, 0CEh, 0D4h, 0A6h, 1Bh ; 1124e
	ASCII "8" ; 11256
	DB 0CEh, 0D4h, 0A7h, 1Bh, 0C7h, 13h, 12h, 0CEh ; 11257
	DB 0C7h, 01h, 0CEh, 0D0h, 0A7h, 1Bh, 0F2h, 87h ; 1125f
	DB 03h, 0F8h, 0C7h, 03h, 12h, 0CEh, 0C7h, 01h ; 11267
	DB 0CEh, 0D0h, 0A7h, 1Bh, 0F2h, 9Bh, 03h, 0CEh ; 1126f
	DB 0D4h, 0A7h, 1Bh, 0F1h, 14h, 0C7h, 13h, 12h ; 11277
	DB 0CEh, 0C7h, 01h, 0CEh, 0D0h, 0A7h, 1Bh, 0F2h ; 1127f
	DB 88h, 03h, 0CEh, 0D4h, 0A7h, 1Bh, 0F1h, 01h ; 11287
	DB 0C5h ; 1128f
	ASCII "C" ; 11290
	DB 16h, 95h, 01h, 0EFh, 07h, 00h, 95h, 02h ; 11291
	DB 0EFh, 1Eh, 00h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah ; 11299
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 112a1
	DB 14h, 0CEh, 0D0h, 0A7h, 1Bh, 0CEh, 0D4h, 0A6h ; 112a9
	DB 1Bh, 0C4h ; 112b1
	ASCII "x" ; 112b3
	DB 1Ah, 0F2h, 0A4h, 0E6h, 0F8h, 0CEh, 0D0h, 0B6h ; 112b4
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h ; 112bc
	DB 0FAh, 14h, 0B0h, 01h, 0CEh, 0D4h, 0A6h, 1Bh ; 112c4
	DB 0C4h ; 112cc
	ASCII "x" ; 112cd
	DB 1Ah, 0F2h, 8Ah, 0E6h, 0F8h ; 112ce
	ASCII "7" ; 112d3
	DB 92h ; 112d4
	ASCII "i" ; 112d5
	DB 92h, 23h, 12h ; 112d6
	ASCII "P" ; 112d9
	DB 92h, 7Ch, 92h, 23h, 12h, 1Eh, 12h, 0FEh ; 112da
	DB 0FEh, 02h, 01h, 00h, 00h, 2Eh, 12h, 0FEh ; 112e2
	DB 0FEh, 00h, 02h, 00h, 00h, 3Eh, 12h, 0FEh ; 112ea
	DB 0FEh, 01h, 00h, 00h, 00h, 0Ch, 00h, 0FDh ; 112f2
	DB 06h, 0Ch, 00h, 01h, 07h, 0C1h, 99h, 0F7h ; 112fa
	DB 12h, 0B0h, 0FFh, 0CEh, 0D4h, 0A6h, 1Bh ; 11302
	ASCII "8" ; 11309
	DB 0CEh, 0D4h, 0A7h, 1Bh, 0C7h, 0DFh, 12h, 0CEh ; 1130a
	DB 0C7h, 01h, 0CEh, 0D0h, 0A7h, 1Bh, 0F2h, 0D4h ; 11312
	DB 02h, 0F8h, 0C7h, 0DFh, 12h, 0CEh, 0C7h, 01h ; 1131a
	DB 0CEh, 0D0h, 0A7h, 1Bh, 0F2h, 0E8h, 02h, 0CEh ; 11322
	DB 0D4h, 0A7h, 1Bh, 0C5h ; 1132a
	ASCII "C" ; 1132e
	DB 16h, 95h, 01h, 0EFh, 02h, 00h, 0F8h, 0CEh ; 1132f
	DB 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h ; 11337
	DB 0CEh, 0D4h, 0FAh, 14h, 0CEh, 0D0h, 0A7h, 1Bh ; 1133f
	DB 0CEh, 0D4h, 0A6h, 1Bh, 0C4h ; 11347
	ASCII "x" ; 1134c
	DB 1Ah, 0F2h, 0Bh, 0E6h, 0F8h, 03h, 93h, 1Ch ; 1134d
	DB 93h, 0F7h, 12h, 0C5h ; 11355
	ASCII "k" ; 11359
	DB 16h, 0CEh, 2Dh, 04h, 0CEh, 0D0h, 0Fh, 1Bh ; 1135a
	DB 0F2h ; 11362
	ASCII "7" ; 11363
	DB 93h, 0F8h, 0BBh, 99h, 07h, 8Bh, 93h, 97h ; 11364
	DB 99h, 01h, 0C4h, 99h ; 1136c
	ASCII "i" ; 11370
	DB 13h ; 11371
	ASCII "X" ; 11372
	DB 93h, 88h, 99h, 0C5h ; 11373
	ASCII "k" ; 11377
	DB 16h, 0CEh, 25h, 0FBh, 0CEh, 0D0h, 0Fh, 1Bh ; 11378
	DB 0CEh ; 11380
	ASCII "D" ; 11381
	DB 18h ; 11382
	ASCII "8" ; 11383
	DB 0CEh ; 11384
	ASCII "D" ; 11385
	DB 19h, 0F2h, 12h, 93h, 0F8h, 0CEh, 40h, 18h ; 11386
	DB 0CEh, 84h, 0CEh, 84h ; 1138e
	ASCII "P" ; 11392
	DB 0B3h, 00h, 0B0h, 08h, 0CEh, 0D9h, 0CEh, 40h ; 11393
	DB 19h, 0CEh, 0D8h ; 1139b
	ASCII "B" ; 1139e
	DB 0CEh, 8Ch, 0CEh, 8Ch, 0F2h, 0F6h, 92h, 0CEh ; 1139f
	DB 40h, 19h, 80h, 0CEh ; 113a7
	ASCII "D" ; 113ab
	DB 19h, 0F8h ; 113ac
	ASCII "v" ; 113ae
	DB 93h ; 113af
	ASCII "q" ; 113b0
	DB 9Ah ; 113b1
	ASCII "f" ; 113b2
	DB 13h ; 113b3
	ASCII "8" ; 113b4
	DB 0F2h, 0E4h, 92h, 0B8h, 22h, 16h, 0BCh, 1Fh ; 113b5
	DB 16h, 0CEh, 0D0h, 24h, 16h, 0CEh, 0D4h, 21h ; 113bd
	DB 16h, 0F8h, 0BBh, 99h, 07h, 0FAh, 93h, 97h ; 113c5
	DB 99h, 01h, 0C4h, 99h, 0CAh, 13h ; 113cd
	ASCII "O" ; 113d3
	DB 9Ah, 21h, 5Dh, 9Ah, 01h, 97h, 99h, 01h ; 113d4
	DB 0B4h, 93h ; 113dc
	ASCII "d" ; 113de
	DB 9Ah, 00h, 00h, 88h, 99h, 0C5h ; 113df
	ASCII "k" ; 113e5
	DB 16h, 0CEh, 25h, 0FBh, 0CEh, 0D0h, 0Fh, 1Bh ; 113e6
	DB 0CEh ; 113ee
	ASCII "D" ; 113ef
	DB 18h, 0F2h, 0A8h, 92h, 0B0h, 07h, 0CEh ; 113f0
	ASCII "D" ; 113f7
	DB 19h, 0F8h, 0CEh, 40h, 18h, 0CEh, 84h, 0CEh ; 113f8
	DB 84h ; 11400
	ASCII "P" ; 11401
	DB 0B3h, 00h, 0B0h, 08h, 0CEh, 0D9h, 0CEh, 40h ; 11402
	DB 19h, 0CEh, 0D8h ; 1140a
	ASCII "B" ; 1140d
	DB 0CEh, 8Ch, 0CEh, 8Ch, 0F2h, 87h, 92h, 0CEh ; 1140e
	DB 40h, 19h, 88h, 0CEh ; 11416
	ASCII "D" ; 1141a
	DB 19h, 0F8h, 0E4h, 93h ; 1141b
	ASCII "q" ; 1141f
	DB 9Ah, 0C7h, 13h, 0C5h ; 11420
	ASCII "k" ; 11424
	DB 16h, 0CEh, 2Dh, 04h, 0CEh, 0D0h, 0Fh, 1Bh ; 11425
	DB 0F2h ; 1142d
	ASCII "l" ; 1142e
	DB 92h, 0F8h, 0BBh, 99h, 01h, 8Bh, 93h, 97h ; 1142f
	DB 99h, 01h, 0C4h, 99h ; 11437
	ASCII "4" ; 1143b
	DB 14h, 23h, 94h, 88h, 99h, 0C5h ; 1143c
	ASCII "k" ; 11442
	DB 16h, 0CEh, 25h, 0FBh, 0CEh, 0D0h, 0Fh, 1Bh ; 11443
	DB 0CEh ; 1144b
	ASCII "D" ; 1144c
	DB 18h ; 1144d
	ASCII "8" ; 1144e
	DB 0CEh ; 1144f
	ASCII "D" ; 11450
	DB 19h, 0F2h ; 11451
	ASCII "G" ; 11453
	DB 92h, 0F8h, 0CEh, 40h, 18h, 0CEh, 84h, 0CEh ; 11454
	DB 84h ; 1145c
	ASCII "P" ; 1145d
	DB 0B3h, 00h, 0B0h, 02h, 0CEh, 0D9h, 0CEh, 40h ; 1145e
	DB 19h, 0CEh, 0D8h ; 11466
	ASCII "B" ; 11469
	DB 0CEh, 8Ch, 0CEh, 8Ch, 0F2h, 2Bh, 92h, 0CEh ; 1146a
	DB 40h, 19h, 80h, 0CEh ; 11472
	ASCII "D" ; 11476
	DB 19h, 0F8h ; 11477
	ASCII "A" ; 11479
	DB 94h ; 1147a
	ASCII "q" ; 1147b
	DB 9Ah ; 1147c
	ASCII "1" ; 1147d
	DB 14h ; 1147e
	ASCII "8" ; 1147f
	DB 0F2h, 19h, 92h, 0B8h, 22h, 16h, 0BCh, 1Fh ; 11480
	DB 16h, 0CEh, 0D0h, 24h, 16h, 0CEh, 0D4h, 21h ; 11488
	DB 16h, 0F8h, 0BBh, 99h, 01h, 0C5h, 94h, 97h ; 11490
	DB 99h, 01h, 0C4h, 99h, 95h, 14h ; 11498
	ASCII "O" ; 1149e
	DB 9Ah, 21h, 5Dh, 9Ah, 01h, 97h, 99h, 01h ; 1149f
	DB 7Fh, 94h ; 114a7
	ASCII "d" ; 114a9
	DB 9Ah, 00h, 00h, 88h, 99h, 0C5h ; 114aa
	ASCII "k" ; 114b0
	DB 16h, 0CEh, 25h, 0FBh, 0CEh, 0D0h, 0Fh, 1Bh ; 114b1
	DB 0CEh ; 114b9
	ASCII "D" ; 114ba
	DB 18h, 0F2h, 0DDh, 91h, 0B0h, 01h, 0CEh ; 114bb
	ASCII "D" ; 114c2
	DB 19h, 0F8h, 0CEh, 40h, 18h, 0CEh, 84h, 0CEh ; 114c3
	DB 84h ; 114cb
	ASCII "P" ; 114cc
	DB 0B3h, 00h, 0B0h, 02h, 0CEh, 0D9h, 0CEh, 40h ; 114cd
	DB 19h, 0CEh, 0D8h ; 114d5
	ASCII "B" ; 114d8
	DB 0CEh, 8Ch, 0CEh, 8Ch, 0F2h, 0BCh, 91h, 0CEh ; 114d9
	DB 40h, 19h, 88h, 0CEh ; 114e1
	ASCII "D" ; 114e5
	DB 19h, 0F8h, 0AFh, 94h ; 114e6
	ASCII "q" ; 114ea
	DB 9Ah, 92h, 14h, 0CEh, 40h, 0Ah, 0CEh ; 114eb
	ASCII "H" ; 114f2
	DB 0Bh, 0D0h ; 114f3
	ASCIZ "0" ; 114f5
	DB 0E5h, 04h, 0C4h, 00h, 00h, 0B9h ; 114f7
	ASCII "P" ; 114fd
	DB 16h, 0CFh, 19h, 0E4h, 03h, 0CFh, 0E1h, 0BCh ; 114fe
	ASCII "Y" ; 11506
	DB 16h, 0CEh, 0D4h ; 11507
	ASCII "3" ; 1150a
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Dh, 16h, 0CEh ; 1150b
	DB 40h, 0Eh, 0CEh ; 11513
	ASCII "H" ; 11516
	DB 0Fh, 0D0h ; 11517
	ASCIZ "0" ; 11519
	DB 0E5h, 04h, 0C4h, 00h, 00h, 0B9h ; 1151b
	ASCII "R" ; 11521
	DB 16h, 0CFh, 19h, 0E4h, 03h, 0CFh, 0E1h, 0BCh ; 11522
	DB 5Bh, 16h, 0CEh, 0D4h ; 1152a
	ASCII "2" ; 1152e
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Fh, 16h, 0F8h ; 1152f
	DB 0CEh, 40h, 0Ah, 0CEh ; 11537
	ASCII "H" ; 1153b
	DB 0Bh, 0D0h ; 1153c
	ASCIZ "0" ; 1153e
	DB 0E5h, 04h, 0C4h, 00h, 00h, 0B9h ; 11540
	ASCII "P" ; 11546
	DB 16h, 0CFh, 19h, 0E4h, 03h, 0CFh, 0E1h, 0BCh ; 11547
	ASCII "Y" ; 1154f
	DB 16h, 0CEh, 0D4h ; 11550
	ASCII "3" ; 11553
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Dh, 16h, 0CEh ; 11554
	DB 40h, 0Eh, 0CEh ; 1155c
	ASCII "H" ; 1155f
	DB 0Fh, 0D0h, 40h, 00h, 0E5h, 04h, 0C4h, 00h ; 11560
	DB 00h, 0B9h ; 11568
	ASCII "R" ; 1156a
	DB 16h, 0CFh, 19h, 0E4h, 03h, 0CFh, 0E1h, 0BCh ; 1156b
	DB 5Bh, 16h, 0CEh, 0D4h ; 11573
	ASCII "2" ; 11577
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Fh, 16h, 0F8h ; 11578
	DB 0CEh, 40h, 0Ah, 0CEh ; 11580
	ASCII "H" ; 11584
	DB 0Bh, 0D0h ; 11585
	ASCIZ "0" ; 11587
	DB 0E5h, 04h, 0C4h, 00h, 00h, 0B9h ; 11589
	ASCII "P" ; 1158f
	DB 16h, 0CFh, 19h, 0E4h, 03h, 0CFh, 0E1h, 0BCh ; 11590
	ASCII "Y" ; 11598
	DB 16h, 0CEh, 0D4h ; 11599
	ASCII "3" ; 1159c
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Dh, 16h, 0CEh ; 1159d
	DB 40h, 0Eh, 15h, 5Bh, 16h, 0E4h, 17h ; 115a5
	ASCIZ "2" ; 115ac
	DB 0E4h, 13h ; 115ae
	ASCII "20" ; 115b0
	DB 0E5h, 25h, 0B8h, 5Bh, 16h, 0CEh, 0D4h ; 115b2
	ASCII "2" ; 115b9
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Fh, 16h, 0F8h ; 115ba
	DB 0CEh, 40h, 0Eh, 0CEh, 0A8h, 0D0h, 00h, 00h ; 115c2
	DB 0BCh, 5Bh, 16h, 0CEh, 0D4h ; 115ca
	ASCII "2" ; 115cf
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Fh, 16h, 0F8h ; 115d0
	DB 0CEh, 40h, 0Eh, 0CEh, 0A8h, 0D0h ; 115d8
	ASCIZ "0" ; 115de
	DB 0BCh, 5Bh, 16h, 0CEh, 0D4h ; 115e0
	ASCII "2" ; 115e5
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Fh, 16h, 0F8h ; 115e6
	DB 0B2h, 08h, 0CEh, 0D8h, 0CFh ; 115ee
	ASCII "C" ; 115f3
	DB 0A3h, 0CEh, 0C7h, 01h, 0CFh, 0D8h, 0F2h, 86h ; 115f4
	DB 0E3h, 0ABh, 0CEh, 0C7h, 01h, 0CEh ; 115fc
	ASCII "A" ; 11602
	DB 06h, 0CEh ; 11603
	ASCII "I" ; 11605
	DB 07h, 0D4h, 00h, 00h, 0E6h, 04h, 0F2h ; 11606
	ASCII "A" ; 1160d
	DB 0E3h, 0F8h, 0CFh, 0B0h, 0C5h ; 1160e
	ASCII "E" ; 11613
	DB 16h, 95h ; 11614
	ASCII "x" ; 11616
	DB 0E6h ; 11617
	ASCII "R" ; 11618
	DB 0A3h, 0B2h, 08h, 0CEh, 0D8h, 0CFh ; 11619
	ASCII "C" ; 1161f
	DB 0C5h ; 11620
	ASCII "E" ; 11621
	DB 16h, 95h, 08h, 0EBh ; 11622
	ASCIZ "V" ; 11626
	DB 95h, 10h, 0EBh ; 11628
	ASCIZ "U" ; 1162b
	DB 95h, 20h, 0EBh ; 1162d
	ASCIZ "T" ; 11630
	DB 95h, 40h, 0EBh ; 11632
	ASCIZ "S" ; 11635
	DB 0ABh ; 11637
	ASCII "2" ; 11638
	DB 0FEh, 0E6h, 3Fh ; 11639
	ASCII "2" ; 1163c
	DB 0FFh, 0E6h, 2Eh, 0B2h, 08h, 0CEh, 0D8h, 0CFh ; 1163d
	ASCII "C" ; 11645
	DB 0CFh, 0B5h, 0CFh, 0B0h, 0CFh, 0D8h, 0F2h ; 11646
	ASCII "4" ; 1164d
	DB 0E3h, 0CEh ; 1164e
	ASCII "A" ; 11650
	DB 06h, 0CEh ; 11651
	ASCII "I" ; 11653
	DB 07h, 0D4h, 00h, 00h, 0E6h, 04h, 0F2h, 0F3h ; 11654
	DB 0E2h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1165c
	DB 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0CFh, 0B4h ; 11664
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1166c
	DB 0B0h, 03h, 0CEh, 0D4h, 0FAh, 14h, 0CFh, 0B4h ; 11674
	DB 0F8h, 0CEh ; 1167c
	ASCII "A" ; 1167e
	DB 02h, 0F8h, 0CEh ; 1167f
	ASCII "A" ; 11682
	DB 03h, 0F8h, 0CEh ; 11683
	ASCII "A" ; 11686
	DB 04h, 0F8h, 0CEh ; 11687
	ASCII "A" ; 1168a
	DB 05h, 0F8h, 0C6h, 8Fh, 16h, 0CEh, 0C6h, 00h ; 1168b
	DB 0B9h, 0Fh, 19h, 0CEh, 0C5h, 00h, 0B1h, 04h ; 11693
	DB 0CFh, 0B1h ; 1169b
	ASCII "F" ; 1169d
	DB 0CEh, 28h, 01h, 0E6h, 23h, 0CEh, 40h, 0Ah ; 1169e
	DB 02h, 10h, 0CEh, 0D4h, 13h, 19h, 0CEh, 40h ; 116a6
	DB 0Eh, 02h, 10h, 0CEh, 0D4h, 14h, 19h, 0CEh ; 116ae
	DB 40h, 14h, 0CEh ; 116b6
	ASCII "H" ; 116b9
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 116ba
	DB 0F2h ; 116c2
	ASCII "q" ; 116c3
	DB 05h, 0C2h, 20h, 00h, 0CFh, 0B5h, 0F5h, 0D0h ; 116c4
	DB 0BDh, 0Fh, 19h, 0F8h, 0C6h, 0Fh, 17h, 0CEh ; 116cc
	DB 0C6h, 00h, 0B9h, 0Fh, 19h, 0CEh, 0C5h, 00h ; 116d4
	DB 0B1h, 02h, 0CFh, 0B1h ; 116dc
	ASCII "F" ; 116e0
	DB 0CEh, 28h, 01h, 0E6h, 3Fh, 0BBh, 5Dh, 16h ; 116e1
	DB 0CEh, 40h, 0Ah, 0CEh ; 116e9
	ASCII "H" ; 116ed
	DB 0Bh, 0CFh, 0Bh, 0CEh, 0D4h, 13h, 19h, 0C0h ; 116ee
	DB 10h, 00h, 0D4h, 0A0h, 00h, 0E5h, 28h, 0BBh ; 116f6
	DB 5Fh, 16h, 0CEh, 40h, 0Eh, 0CEh ; 116fe
	ASCII "H" ; 11704
	DB 0Fh, 0CFh, 0Bh, 0CEh, 0D4h, 14h, 19h, 0C0h ; 11705
	DB 10h, 00h, 0D4h, 80h, 00h, 0E5h, 11h, 0CEh ; 1170d
	DB 40h, 14h, 0CEh ; 11715
	ASCII "H" ; 11718
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 11719
	DB 0F2h, 12h, 05h, 0C2h, 20h, 00h, 0CFh, 0B5h ; 11721
	DB 0F5h, 0B4h, 0BDh, 0Fh, 19h, 0F8h, 0C6h ; 11729
	ASCII "O" ; 11730
	DB 17h, 0CEh, 0C6h, 00h, 0B9h, 0Fh, 19h, 0CEh ; 11731
	DB 0C5h, 00h, 0B1h, 0Eh, 0CFh, 0B1h ; 11739
	ASCII "F" ; 1173f
	DB 0CEh, 28h, 01h, 0E6h, 3Fh, 0BBh, 5Dh, 16h ; 11740
	DB 0CEh, 40h, 0Ah, 0CEh ; 11748
	ASCII "H" ; 1174c
	DB 0Bh, 0CFh, 0Bh, 0CEh, 0D4h, 13h, 19h, 0C0h ; 1174d
	DB 10h, 00h, 0D4h, 0A0h, 00h, 0E5h, 28h, 0BBh ; 11755
	DB 5Fh, 16h, 0CEh, 40h, 0Eh, 0CEh ; 1175d
	ASCII "H" ; 11763
	DB 0Fh, 0CFh, 0Bh, 0CEh, 0D4h, 14h, 19h, 0C0h ; 11764
	DB 10h, 00h, 0D4h, 80h, 00h, 0E5h, 11h, 0CEh ; 1176c
	DB 40h, 14h, 0CEh ; 11774
	ASCII "H" ; 11777
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 11778
	DB 0F2h, 0B3h, 04h, 0C2h, 20h, 00h, 0CFh, 0B5h ; 11780
	DB 0F5h, 0B4h, 0BDh, 0Fh, 19h, 0F8h, 0A6h, 0A2h ; 11788
	DB 0A0h, 0CEh, 0C7h, 01h, 0C6h, 8Fh, 16h, 0CEh ; 11790
	DB 0C6h, 00h, 0CEh, 0C5h, 00h, 0B1h, 04h ; 11798
	ASCII "F" ; 1179f
	DB 0CEh, 28h, 01h, 0EEh, 5Eh, 03h, 0C2h, 20h ; 117a0
	DB 00h, 0F5h, 0F5h, 0A8h, 0AAh, 0AEh, 0F8h, 0A6h ; 117a8
	DB 0A2h, 0A0h, 0CEh, 0C7h, 01h, 0C6h, 0Fh, 17h ; 117b0
	DB 0CEh, 0C6h, 00h, 0CEh, 0C5h, 00h, 0B1h, 02h ; 117b8
	ASCII "F" ; 117c0
	DB 0CEh, 28h, 01h, 0EEh, 3Dh, 03h, 0C2h, 20h ; 117c1
	DB 00h, 0F5h, 0F5h, 0A8h, 0AAh, 0AEh, 0F8h, 0A6h ; 117c9
	DB 0A2h, 0A0h, 0CEh, 0C7h, 01h, 0C6h ; 117d1
	ASCII "O" ; 117d7
	DB 17h, 0CEh, 0C6h, 00h, 0CEh, 0C5h, 00h, 0B1h ; 117d8
	DB 0Eh ; 117e0
	ASCII "F" ; 117e1
	DB 0CEh, 28h, 01h, 0EEh, 1Ch, 03h, 0C2h, 20h ; 117e2
	DB 00h, 0F5h, 0F5h, 0A8h, 0AAh, 0AEh, 0F8h, 0A6h ; 117ea
	DB 0A2h, 0A0h, 0CEh, 0C7h, 01h, 0C6h, 0EFh, 18h ; 117f2
	DB 0CEh, 0C6h, 00h, 0CEh, 0C5h, 00h, 0B1h, 01h ; 117fa
	ASCII "F" ; 11802
	DB 0CEh, 28h, 01h, 0EEh, 0FBh, 02h, 0C2h, 20h ; 11803
	DB 00h, 0F5h, 0F5h, 0A8h, 0AAh, 0AEh, 0F8h, 0A6h ; 1180b
	DB 0A2h, 0C6h, 0Fh, 17h, 0CEh, 0C6h, 00h, 0CEh ; 11813
	DB 0C5h, 00h, 0B1h, 10h ; 1181b
	ASCII "F" ; 1181f
	DB 0CEh, 28h, 01h, 0EEh, 0Fh, 00h, 0CFh, 0B1h ; 11820
	DB 0CEh, 40h, 1Ah, 0CEh ; 11828
	ASCII "H" ; 1182c
	DB 1Bh, 0CFh, 19h, 0CFh, 0B5h, 0E6h, 09h, 0C2h ; 1182d
	DB 20h, 00h, 0F5h, 0E7h, 0AAh, 0AEh, 0F8h, 0B0h ; 11835
	DB 0FFh, 20h, 0AAh, 0AEh, 0F8h, 0CFh, 0D0h, 0D4h ; 1183d
	ASCII "4" ; 11845
	DB 0AAh, 0E6h, 29h, 0D4h ; 11846
	ASCII "L5" ; 1184a
	DB 0E6h, 24h, 0D4h, 14h, 3Bh, 0E6h, 1Fh, 0D4h ; 1184c
	DB 1Ch, 40h, 0E6h, 1Ah, 0D4h, 17h ; 11854
	ASCII "E" ; 1185a
	DB 0E6h, 15h, 0D4h, 12h ; 1185b
	ASCII "J" ; 1185f
	DB 0E6h, 10h, 0D4h, 0EEh, 0B6h, 0E6h, 0Bh, 0D4h ; 11860
	DB 0EEh, 0C8h, 0E7h, 09h, 0D2h, 0E0h, 00h, 0F1h ; 11868
	DB 04h, 0C2h, 20h, 00h, 0F8h, 0C6h, 8Fh, 16h ; 11870
	DB 0CEh, 0C6h, 00h, 0B9h, 0Fh, 19h, 0CEh, 0C5h ; 11878
	DB 00h, 0B1h, 14h, 0CFh, 0B1h ; 11880
	ASCII "F" ; 11885
	DB 0CEh, 28h, 01h, 0E6h, 5Fh, 0A2h, 0F2h, 0B4h ; 11886
	DB 0FFh, 0CEh, 40h, 17h, 96h, 01h, 0E6h ; 1188e
	ASCII "1" ; 11895
	DB 0BBh, 5Dh, 16h, 0CEh, 40h, 0Ah, 0CEh ; 11896
	ASCII "H" ; 1189d
	DB 0Bh, 0CFh, 0Bh, 0CEh, 0D4h, 13h, 19h, 0C0h ; 1189e
	DB 10h, 00h, 0D4h, 0A0h, 00h, 0E5h, 3Dh, 0BBh ; 118a6
	DB 5Fh, 16h, 0CEh, 40h, 0Eh, 0CEh ; 118ae
	ASCII "H" ; 118b4
	DB 0Fh, 0CFh, 0Bh, 0CEh, 0D4h, 14h, 19h, 0C0h ; 118b5
	DB 10h, 00h, 0D4h, 80h, 00h, 0E5h, 26h, 0F1h ; 118bd
	DB 13h, 0CEh, 40h, 0Ah, 02h, 10h, 0CEh, 0D4h ; 118c5
	DB 13h, 19h, 0CEh, 40h, 0Eh, 02h, 10h, 0CEh ; 118cd
	DB 0D4h, 14h, 19h, 0CEh, 40h, 14h, 0CEh ; 118d5
	ASCII "H" ; 118dc
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 118dd
	DB 0F2h ; 118e5
	ASCII "N" ; 118e6
	DB 03h, 0AAh, 0C2h, 20h, 00h, 0CFh, 0B5h, 0F5h ; 118e7
	DB 94h, 0BDh, 0Fh, 19h, 0F8h, 0CFh, 0D0h, 0D4h ; 118ef
	ASCII "u'" ; 118f7
	DB 0E6h, 0Eh, 0D4h ; 118f9
	ASCII "Oa" ; 118fc
	DB 0E7h, 06h, 0D2h, 60h, 00h, 0F1h, 04h, 0C2h ; 118fe
	DB 20h, 00h, 0F8h, 0C6h, 8Fh, 16h, 0CEh, 0C6h ; 11906
	DB 00h, 0B9h, 0Fh, 19h, 0CEh, 0C5h, 00h, 0B1h ; 1190e
	DB 14h, 0CFh, 0B1h ; 11916
	ASCII "F" ; 11919
	DB 0CEh, 28h, 01h, 0E6h, 5Fh, 0A2h, 0F2h, 0D2h ; 1191a
	DB 0FFh, 0CEh, 40h, 17h, 96h, 01h, 0E6h ; 11922
	ASCII "1" ; 11929
	DB 0BBh, 5Dh, 16h, 0CEh, 40h, 0Ah, 0CEh ; 1192a
	ASCII "H" ; 11931
	DB 0Bh, 0CFh, 0Bh, 0CEh, 0D4h, 13h, 19h, 0C0h ; 11932
	DB 10h, 00h, 0D4h, 0A0h, 00h, 0E5h, 3Dh, 0BBh ; 1193a
	DB 5Fh, 16h, 0CEh, 40h, 0Eh, 0CEh ; 11942
	ASCII "H" ; 11948
	DB 0Fh, 0CFh, 0Bh, 0CEh, 0D4h, 14h, 19h, 0C0h ; 11949
	DB 10h, 00h, 0D4h, 80h, 00h, 0E5h, 26h, 0F1h ; 11951
	DB 13h, 0CEh, 40h, 0Ah, 02h, 10h, 0CEh, 0D4h ; 11959
	DB 13h, 19h, 0CEh, 40h, 0Eh, 02h, 10h, 0CEh ; 11961
	DB 0D4h, 14h, 19h, 0CEh, 40h, 14h, 0CEh ; 11969
	ASCII "H" ; 11970
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 11971
	DB 0F2h, 0BAh, 02h, 0AAh, 0C2h, 20h, 00h, 0CFh ; 11979
	DB 0B5h, 0F5h, 94h, 0BDh, 0Fh, 19h, 0F8h ; 11981
	ASCII "8`" ; 11988
	DB 0CEh ; 1198a
	ASCII "D" ; 1198b
	DB 01h, 0FAh, 0C3h, 0FEh, 0FFh, 0B0h, 0FFh, 0CEh ; 1198c
	ASCII "D" ; 11994
	DB 06h, 0FAh ; 11995
	ASCII "G" ; 11997
	DB 0CEh ; 11998
	ASCII "D" ; 11999
	DB 06h, 93h, 0FAh, 0CFh, 0D8h, 0CEh ; 1199a
	ASCII "D" ; 119a0
	DB 04h, 0CEh ; 119a1
	ASCII "L" ; 119a3
	DB 05h, 0C3h, 02h, 00h, 0F8h, 0CFh, 0D8h, 0CEh ; 119a4
	ASCII "D" ; 119ac
	DB 04h, 0CEh ; 119ad
	ASCII "L" ; 119af
	DB 05h, 0CEh ; 119b0
	ASCII "A" ; 119b2
	DB 02h, 0CEh ; 119b3
	ASCII "D" ; 119b5
	DB 1Fh, 0C3h, 03h, 00h, 0F8h ; 119b6
	ASCII "G" ; 119bb
	DB 0CEh ; 119bc
	ASCII "D" ; 119bd
	DB 07h, 93h, 0F8h, 0CFh, 0DBh, 0F8h, 0CFh, 0E6h ; 119be
	DB 0C1h, 07h, 00h, 8Eh, 0E7h, 0F6h, 0C3h, 02h ; 119c6
	DB 00h, 0F8h ; 119ce
	ASCII "G" ; 119d0
	DB 0CEh ; 119d1
	ASCII "D" ; 119d2
	DB 16h, 93h, 0F8h ; 119d3
	ASCII "8" ; 119d6
	DB 0CEh ; 119d7
	ASCII "D" ; 119d8
	DB 09h, 0CEh ; 119d9
	ASCII "D" ; 119db
	DB 0Dh, 0CFh, 0D8h, 0CEh ; 119dc
	ASCII "D" ; 119e0
	DB 0Ah, 0CEh ; 119e1
	ASCII "L" ; 119e3
	DB 0Bh, 0C3h, 02h, 00h, 0CFh, 0D8h, 0CEh ; 119e4
	ASCII "D" ; 119eb
	DB 0Eh, 0CEh ; 119ec
	ASCII "L" ; 119ee
	DB 0Fh, 0C3h, 02h, 00h, 0F8h, 0CEh ; 119ef
	ASCII "P" ; 119f5
	DB 0Ah, 0CEh ; 119f6
	ASCII "X" ; 119f8
	DB 0Bh ; 119f9
	ASCII "G" ; 119fa
	DB 0CEh, 0A8h, 0CFh, 01h, 0CEh ; 119fb
	ASCII "D" ; 11a00
	DB 0Ah, 0CEh ; 11a01
	ASCII "L" ; 11a03
	DB 0Bh, 93h, 0CEh ; 11a04
	ASCII "P" ; 11a07
	DB 0Eh, 0CEh ; 11a08
	ASCII "X" ; 11a0a
	DB 0Fh ; 11a0b
	ASCII "G" ; 11a0c
	DB 0CEh, 0A8h, 0CFh, 01h, 0CEh ; 11a0d
	ASCII "D" ; 11a12
	DB 0Eh, 0CEh ; 11a13
	ASCII "L" ; 11a15
	DB 0Fh, 93h, 0F8h, 0CFh, 0D8h, 0CEh ; 11a16
	ASCII "D" ; 11a1c
	DB 08h, 0CEh ; 11a1d
	ASCII "L" ; 11a1f
	DB 0Ch, 0C3h, 02h, 00h, 0F8h, 0CFh, 0D8h, 0CEh ; 11a20
	ASCII "D" ; 11a28
	DB 10h, 0CEh ; 11a29
	ASCII "L" ; 11a2b
	DB 11h, 0C3h, 02h, 00h, 0F8h, 0CFh, 0D8h, 0CEh ; 11a2c
	ASCII "D" ; 11a34
	DB 12h, 0CEh ; 11a35
	ASCII "L" ; 11a37
	DB 13h, 0C3h, 02h, 00h, 0F8h, 0CEh, 40h, 17h ; 11a38
	DB 2Fh, 0CEh ; 11a40
	ASCII "D" ; 11a42
	DB 17h, 93h, 0F8h, 0CEh, 40h, 17h, 27h, 0CEh ; 11a43
	ASCII "D" ; 11a4b
	DB 17h, 93h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 11a4c
	DB 0E6h, 06h ; 11a54
	ASCII "G" ; 11a56
	DB 0CEh, 0D4h, 0FAh, 14h, 93h, 0F8h ; 11a57
	ASCII "G" ; 11a5d
	DB 0CEh, 0D4h, 0F4h, 14h, 93h, 0F8h, 0CFh, 0D8h ; 11a5e
	DB 0F2h ; 11a66
	ASCII "A" ; 11a67
	DB 8Ch, 0C3h, 02h, 00h, 0F8h, 00h, 00h, 00h ; 11a68
	DB 80h, 0F8h, 04h, 00h ; 11a70
	ASCII "m" ; 11a74
	DB 1Ah, 8Eh, 99h, 88h, 99h ; 11a75
	ASCII "8" ; 11a7a
	DB 0CEh, 0D4h, 0B4h, 15h, 0CEh, 0D4h, 0B8h, 15h ; 11a7b
	DB 0CEh, 0D4h, 0BCh, 15h, 0CEh, 0D4h, 0C0h, 15h ; 11a83
	DB 0CEh, 0D4h, 0C4h, 15h, 0CEh, 0D4h, 0C8h, 15h ; 11a8b
	DB 0CEh, 0D4h, 0CCh, 15h, 0CEh, 0D4h, 0D0h, 15h ; 11a93
	DB 0CEh, 0D4h, 0D4h, 15h, 0CEh, 0D4h, 0D8h, 15h ; 11a9b
	DB 0CEh, 0D4h, 0DCh, 15h, 0CEh, 0D4h, 0E0h, 15h ; 11aa3
	DB 0CEh, 0D4h, 0E4h, 15h, 0CEh, 0D4h, 0E8h, 15h ; 11aab
	DB 0CEh, 0D4h, 0ECh, 15h, 0CEh, 0D4h, 0F0h, 15h ; 11ab3
	DB 0CEh, 0D4h, 0F4h, 15h, 0CEh, 0D4h, 0F8h, 15h ; 11abb
	DB 0CEh, 0D4h, 0FCh, 15h, 0CEh, 0D4h, 00h, 16h ; 11ac3
	DB 0CEh, 0D4h, 04h, 16h, 0CEh, 0D4h, 08h, 16h ; 11acb
	DB 0CEh, 0D4h, 0Ch, 16h, 0CEh, 0D4h, 10h, 16h ; 11ad3
	DB 0F8h, 0C5h, 8Fh, 16h, 0CEh, 0C5h, 00h, 0C7h ; 11adb
	DB 00h, 00h, 0B1h, 14h, 0C6h, 20h, 00h, 0CFh ; 11ae3
	DB 0C7h, 0CFh, 22h, 0F5h, 0FBh, 0CEh, 0C4h, 02h ; 11aeb
	DB 0F2h, 85h, 0FFh, 0C4h, 0B1h, 15h, 0BCh ; 11af3
	ASCII "m" ; 11afa
	DB 16h, 0C5h, 0B1h, 15h, 0BDh, 0Fh, 19h, 0F8h
; ---------------------- ; 11afb
loc_0x011B03:

	LD [IX],IY ; 11b03
	LD [IX+0Ah],L ; 11b05
	LD [IX+0Eh],H ; 11b08

	LD A,[IY+02h] ; 11b0b
	LD B,[IY+03h] ; 11b0e
	LD [IX+04h],A ; 11b11
	LD [IX+05h],B ; 11b14

	LD A,[IY+04h] ; 11b17
	LD B,[IY+05h] ; 11b1a
	LD [IX+02h],A ; 11b1d
	LD [IX+03h],B ; 11b20

	XOR A,A ; 11b23

	LD [IX+07h],A ; 11b24
	LD [IX+08h],A ; 11b27
	LD [IX+0Ch],A ; 11b2a
	LD [IX+10h],A ; 11b2d
	LD [IX+11h],A ; 11b30
	LD [IX+12h],A ; 11b33
	LD [IX+13h],A ; 11b36
	LD [IX+09h],A ; 11b39
	LD [IX+0Bh],A ; 11b3c
	LD [IX+0Dh],A ; 11b3f
	LD [IX+0Fh],A ; 11b42
	LD [IX+17h],A ; 11b45

	POP BA ; 11b48

	LD [IX+18h],A ; 11b49
	LD [IX+19h],B ; 11b4c

	XOR A,A ; 11b4f

	LD [IX+1Ah],A ; 11b50
	LD [IX+1Bh],A ; 11b53
	LD [IX+1Ch],A ; 11b56
	LD [IX+1Dh],A ; 11b59

	LD A,#01h ; 11b5c
	LD [IX+1Eh],A ; 11b5e

	LD A,#02h ; 11b61
	LD [IX+1Fh],A ; 11b63

	LD A,#01h ; 11b66
	LD [IX+06h],A ; 11b68

	LD BA,#1A6Dh ; 11b6b
	LD [IX+14h],A ; 11b6e
	LD [IX+15h],B ; 11b71

	LD A,#01h ; 11b74
	LD [IX+16h],A ; 11b76

	LD HL,[IY] ; 11b79
	ADD IY,#0006h ; 11b7b
	CARS loc_0x011B83 ; 11b7e

	POP IX ; 11b80
	POP IP ; 11b81

	RET

; ---------------------- ; 11b82
loc_0x011B83:

	JP HL

; ---------------------- ; 11b83
loc_0x011B84:

	PUSH IP ; 11b84
	PUSH IX ; 11b85
	PUSH BA ; 11b86

	LD YP,#01h ; 11b87
	LD IX,#168Fh ; 11b8a
	LD XP,#00h ; 11b8d
	LD EP,#00h ; 11b90
	LD B,#14h ; 11b93

loc_0x011B95:

	LD A,[IX] ; 11b95
	OR A,[IX+01h] ; 11b96
	JRL Z,loc_0x011B03 ; 11b99

	ADD IX,#0020h ; 11b9c
	DJR NZ,loc_0x011B95 ; 11b9f

	POP BA ; 11ba1
	POP IX ; 11ba2
	POP IP ; 11ba3

	RET

; ---------------------- ; 11ba4
loc_0x011BA5:
	LD YP,#01h ; 11ba5
	LD IX,#168Fh ; 11ba8
	LD XP,#00h ; 11bab
	LD EP,#00h ; 11bae
	LD B,#14h ; 11bb1
loc_0x011BB3:
	PUSH B ; 11bb3
	LD A,[IX] ; 11bb5
	OR A,[IX+01h] ; 11bb6
	JRS Z,loc_0x011C05 ; 11bb9
	LD L,[IX+04h] ; 11bbb
	LD H,[IX+05h] ; 11bbe
	CARS loc_0x011C0D ; 11bc1
	LD HL,IX ; 11bc3
	ADD HL,#0006h ; 11bc5
	DEC [HL] ; 11bc8
	JRS NZ,loc_0x011C05 ; 11bc9
	LD L,[IX+02h] ; 11bcb
	LD H,[IX+03h] ; 11bce
	LD IY,HL ; 11bd1
loc_0x011BD3:
	LD YP,#01h ; 11bd3
	LD BA,[IY] ; 11bd6
	ADD IY,#0002h ; 11bd8
	BIT B,#80h ; 11bdb
	JRS Z,loc_0x011BEF ; 11bdd
	LD HL,BA ; 11bdf
	CARS loc_0x011C0D ; 11be1
	JRS loc_0x011BD3
; ---------------------- ; 11be3
	DB 0CFh, 0E3h, 0CEh ; 11be5
	ASCII "D" ; 11be8
	DB 02h, 0CEh ; 11be9
	ASCII "L" ; 11beb
	DB 03h, 0F1h, 17h
; ---------------------- ; 11bec
loc_0x011BEF:
	LD [IX+06h],A ; 11bef
	LD BA,[IY] ; 11bf2
	LD [IX+14h],A ; 11bf4
	LD [IX+15h],B ; 11bf7
	ADD IY,#0002h ; 11bfa
	LD BA,IY ; 11bfd
	LD [IX+02h],A ; 11bff
	LD [IX+03h],B ; 11c02
loc_0x011C05:
	ADD IX,#0020h ; 11c05
	POP B ; 11c08
	DJR NZ,loc_0x011BB3 ; 11c0a
	RET
; ---------------------- ; 11c0c
loc_0x011C0D:

	JP HL
; ---------------------- ; 11c0d
	DB 0CEh, 0C7h, 01h, 0C6h, 8Fh, 16h, 0CEh, 0C6h ; 11c0e
	DB 00h, 0CEh, 0C5h, 00h, 0B1h, 14h, 0CFh, 0B1h ; 11c16
	ASCII "F" ; 11c1e
	DB 0CEh, 28h, 01h, 0E6h, 09h, 0CEh ; 11c1f
	ASCII "P" ; 11c25
	DB 04h, 0CEh ; 11c26
	ASCII "X" ; 11c28
	DB 05h, 0F0h, 09h, 0C2h, 20h, 00h, 0CFh, 0B5h ; 11c29
	DB 0F5h, 0EAh, 0F8h

	JP HL
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   something to do with rendering sprites
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x011c35: ; 11c35

	CP HL, #1611h
	JRS NC, ret_011c35

	LD A, [IY]
	ADD A, [1913h]
	JRS Z, loc_0x011C64

	CP A, #70h
	JRS NC, loc_0x011C64

	LD [HL], A
	INC IY
	INC HL

	LD A, [IY]
	ADD A, [1914h]
	JRS Z, loc_0x011C6C

	CP A, #50h
	JRS NC, loc_0x011C6C

	LD [HL], A
	INC IY
	INC HL

	LD [HL], [IY]
	INC IY
	INC HL

	LD A, [IY]
	BIT A, #08h
	JRS Z, loc_0x011C75

	LD [HL], A
	INC IY
	INC HL 

loc_0x011C5F:

	BIT A, #80h
	JRS Z, loc_0x011c35

ret_011c35:

	RET

loc_0x011C64:

	LD A, [IY+03h]
	ADD IY, #04h
	JRS loc_0x011C5F

loc_0x011C6C:

	LD A, [IY+02h]
	ADD IY, #03h
	DEC HL
	JRS loc_0x011C5F

loc_0x011C75:

	INC IY
	SUB HL, #03h
	JRS loc_0x011C5F

	; load base address
loc_0x011C7B:

	LD IX, #168Fh
	LD XP, #00h
	LD HL, [190Fh]
	LD EP, #00h
	LD B, #14h

loc_0x011C89:

	PUSH B

	LD A, [IX]
	OR A, [IX+01h]
	JRS Z, loc_0x011CEA

	LD A, [IX+17h]
	BIT A, #01h
	JRS Z, loc_0x011CC8

	LD IY, [165Dh]
	LD A, [IX+0Ah]
	LD B, [IX+0Bh]
	SUB BA, IY
	LD [1913h], A

	ADD BA, #10h
	CP BA, #0A0h
	JRS NC, loc_0x011CEA

	LD IY, [165Fh]
	LD A, [IX+0Eh]
	LD B, [IX+0Fh]
	SUB BA, IY
	LD [1914h], A

	ADD BA, #10h
	CP BA, #80h
	JRS NC, loc_0x011CEA

	JRS loc_0x011CDA

loc_0x011CC8:

	LD A, [IX+0Ah]
	ADD A, #10h
	LD [1913h], A

	LD A, [IX+0Eh]
	ADD A, #10h
	LD [1914h], A

loc_0x011CDA:

	LD A, [IX+14h]
	LD B, [IX+15h]
	LD IY, BA
	LD A, [IX+16h]
	LD YP, A
	CARL loc_0x011c35

loc_0x011CEA:

	ADD IX, #20h
	POP B
	DJR NZ, loc_0x011C89

	LD [190Fh], HL

	RET
    
; ---------------------- ; 11cf4
loc_0x011CF5:
	LD HL,[190Fh] ; 11cf5
	XOR A,A ; 11cf8
	JRS loc_0x011CFF
; ---------------------- ; 11cf9
loc_0x011CFB:
	LD [HL],A ; 11cfb
	ADD HL,#0004h ; 11cfc
loc_0x011CFF:
	CP HL,#1611h ; 11cff
	JRS C,loc_0x011CFB ; 11d02
	RET
; ---------------------- ; 11d04
loc_0x011D05:
	
	LD EP, #00h

	LD BA, [15B1h]
	LD [1300h], BA

	LD BA, [15B3h]
	LD [1302h], BA

	LD BA, [15B5h]
	LD [1304h], BA

	LD BA, [15B7h]
	LD [1306h], BA

	LD BA, [15B9h]
	LD [1308h], BA

	LD BA, [15BBh]
	LD [130Ah], BA

	LD BA, [15BDh]
	LD [130Ch], BA

	LD BA, [15BFh]
	LD [130Eh], BA

	LD BA, [15C1h]
	LD [1310h], BA

	LD BA, [15C3h]
	LD [1312h], BA

	LD BA, [15C5h]
	LD [1314h], BA

	LD BA, [15C7h]
	LD [1316h], BA

	LD BA, [15C9h]
	LD [1318h], BA

	LD BA, [15CBh]
	LD [131Ah], BA

	LD BA, [15CDh]
	LD [131Ch], BA

	LD BA, [15CFh]
	LD [131Eh], BA

	DB 0B8h, 0D1h, 15h, 0BCh ; 11d64
	DB 20h, 13h, 0B8h, 0D3h, 15h, 0BCh, 22h, 13h ; 11d6c
	DB 0B8h, 0D5h, 15h, 0BCh, 24h, 13h, 0B8h, 0D7h ; 11d74
	DB 15h, 0BCh, 26h, 13h, 0B8h, 0D9h, 15h, 0BCh ; 11d7c
	DB 28h, 13h, 0B8h, 0DBh, 15h, 0BCh, 2Ah, 13h ; 11d84
	DB 0B8h, 0DDh, 15h, 0BCh, 2Ch, 13h, 0B8h, 0DFh ; 11d8c
	DB 15h, 0BCh, 2Eh, 13h, 0B8h, 0E1h, 15h, 0BCh ; 11d94
	ASCII "0" ; 11d9c
	DB 13h, 0B8h, 0E3h, 15h, 0BCh ; 11d9d
	ASCII "2" ; 11da2
	DB 13h, 0B8h, 0E5h, 15h, 0BCh ; 11da3
	ASCII "4" ; 11da8
	DB 13h, 0B8h, 0E7h, 15h, 0BCh ; 11da9
	ASCII "6" ; 11dae
	DB 13h, 0B8h, 0E9h, 15h, 0BCh ; 11daf
	ASCII "8" ; 11db4
	DB 13h, 0B8h, 0EBh, 15h, 0BCh, 3Ah, 13h, 0B8h ; 11db5
	DB 0EDh, 15h, 0BCh, 3Ch, 13h, 0B8h, 0EFh, 15h ; 11dbd
	DB 0BCh, 3Eh, 13h, 0B8h, 0F1h, 15h, 0BCh, 40h ; 11dc5
	DB 13h, 0B8h, 0F3h, 15h, 0BCh ; 11dcd
	ASCII "B" ; 11dd2
	DB 13h, 0B8h, 0F5h, 15h, 0BCh ; 11dd3
	ASCII "D" ; 11dd8
	DB 13h, 0B8h, 0F7h, 15h, 0BCh ; 11dd9
	ASCII "F" ; 11dde
	DB 13h, 0B8h, 0F9h, 15h, 0BCh ; 11ddf
	ASCII "H" ; 11de4
	DB 13h, 0B8h, 0FBh, 15h, 0BCh ; 11de5
	ASCII "J" ; 11dea
	DB 13h, 0B8h, 0FDh, 15h, 0BCh ; 11deb
	ASCII "L" ; 11df0
	DB 13h, 0B8h, 0FFh, 15h, 0BCh ; 11df1
	ASCII "N" ; 11df6
	DB 13h, 0B8h, 01h, 16h, 0BCh ; 11df7
	ASCII "P" ; 11dfc
	DB 13h, 0B8h, 03h, 16h, 0BCh ; 11dfd
	ASCII "R" ; 11e02
	DB 13h, 0B8h, 05h, 16h, 0BCh ; 11e03
	ASCII "T" ; 11e08
	DB 13h, 0B8h, 07h, 16h, 0BCh ; 11e09
	ASCII "V" ; 11e0e
	DB 13h, 0B8h, 09h, 16h, 0BCh ; 11e0f
	ASCII "X" ; 11e14
	DB 13h, 0B8h, 0Bh, 16h, 0BCh ; 11e15
	ASCII "Z" ; 11e1a
	DB 13h, 0B8h, 0Dh, 16h, 0BCh, 5Ch, 13h, 0B8h ; 11e1b
	DB 0Fh, 16h, 0BCh, 5Eh, 13h, 0F8h, 0CFh, 0D7h ; 11e23
	DB 0CEh ; 11e2b
	ASCII "T" ; 11e2c
	DB 0Ah, 0CEh, 5Ch, 0Eh, 0CEh ; 11e2d
	ASCII "A" ; 11e32
	DB 03h, 0CEh ; 11e33
	ASCII "I" ; 11e35
	DB 04h, 0CEh ; 11e36
	ASCII "D" ; 11e38
	DB 04h, 0CEh ; 11e39
	ASCII "L" ; 11e3b
	DB 05h, 0CEh ; 11e3c
	ASCII "A" ; 11e3e
	DB 05h, 0CEh ; 11e3f
	ASCII "D" ; 11e41
	DB 1Fh, 0CEh ; 11e42
	ASCII "A" ; 11e44
	DB 06h, 0CEh ; 11e45
	ASCII "I" ; 11e47
	DB 07h, 0CEh ; 11e48
	ASCII "D" ; 11e4a
	DB 02h, 0CEh ; 11e4b
	ASCII "L" ; 11e4d
	DB 03h, 0CEh ; 11e4e
	ASCII "A" ; 11e50
	DB 08h, 0CEh ; 11e51
	ASCII "D" ; 11e53
	DB 1Eh ; 11e54
	ASCII "8" ; 11e55
	DB 0CEh ; 11e56
	ASCII "D" ; 11e57
	DB 07h, 0CEh ; 11e58
	ASCII "D" ; 11e5a
	DB 08h, 0CEh ; 11e5b
	ASCII "D" ; 11e5d
	DB 0Ch, 0CEh ; 11e5e
	ASCII "D" ; 11e60
	DB 10h, 0CEh ; 11e61
	ASCII "D" ; 11e63
	DB 11h, 0CEh ; 11e64
	ASCII "D" ; 11e66
	DB 12h, 0CEh ; 11e67
	ASCII "D" ; 11e69
	DB 13h, 0CEh ; 11e6a
	ASCII "D" ; 11e6c
	DB 09h, 0CEh ; 11e6d
	ASCII "D" ; 11e6f
	DB 0Bh, 0CEh ; 11e70
	ASCII "D" ; 11e72
	DB 0Dh, 0CEh ; 11e73
	ASCII "D" ; 11e75
	DB 0Fh, 0CEh ; 11e76
	ASCII "D" ; 11e78
	DB 17h, 0A8h, 0CEh ; 11e79
	ASCII "D" ; 11e7c
	DB 18h, 0CEh ; 11e7d
	ASCII "L" ; 11e7f
	DB 19h ; 11e80
	ASCII "8" ; 11e81
	DB 0CEh ; 11e82
	ASCII "D" ; 11e83
	DB 1Ah, 0CEh ; 11e84
	ASCII "D" ; 11e86
	DB 1Bh, 0CEh ; 11e87
	ASCII "D" ; 11e89
	DB 1Ch, 0CEh ; 11e8a
	ASCII "D" ; 11e8c
	DB 1Dh, 0B0h, 01h, 0CEh ; 11e8d
	ASCII "D" ; 11e91
	DB 06h, 0C4h ; 11e92
	ASCII "m" ; 11e94
	DB 1Ah, 0CEh ; 11e95
	ASCII "D" ; 11e97
	DB 14h, 0CEh ; 11e98
	ASCII "L" ; 11e9a
	DB 15h, 0B0h, 01h, 0CEh ; 11e9b
	ASCII "D" ; 11e9f
	DB 16h, 0CFh, 0D9h, 0CEh ; 11ea0
	ASCII "A" ; 11ea4
	DB 02h, 0C3h, 06h, 00h, 0F0h, 04h, 0AAh, 0AEh ; 11ea5
	DB 0F8h, 0CEh, 0CCh, 0F4h, 0A6h, 0A2h, 0A0h, 0C6h ; 11ead
	DB 8Fh, 16h, 0CEh, 0C6h, 00h, 0CEh, 0C5h, 00h ; 11eb5
	DB 0B1h, 14h ; 11ebd
	ASCII "F" ; 11ebf
	DB 0CEh, 28h, 01h, 0EEh ; 11ec0
	ASCII "d" ; 11ec4
	DB 0FFh, 0C2h, 20h, 00h, 0F5h, 0F5h, 0A8h, 0AAh ; 11ec5
	DB 0AEh, 0F8h, 0C6h, 8Fh, 16h, 0CEh, 0C6h, 00h ; 11ecd
	DB 0CEh, 0C5h, 00h, 0B1h, 14h, 0CFh, 0B1h ; 11ed5
	ASCII "F" ; 11edc
	DB 0CEh, 28h, 01h, 0E6h ; 11edd
	ASCII "P" ; 11ee1
	DB 0CEh ; 11ee2
	ASCII "P" ; 11ee3
	DB 04h, 0CEh ; 11ee4
	ASCII "X" ; 11ee6
	DB 05h, 0CEh, 40h, 1Fh, 0F0h ; 11ee7
	ASCII "M" ; 11eec
	DB 0CFh, 0E6h, 0C1h, 06h, 00h, 8Eh, 0E7h, 3Dh ; 11eed
	DB 0CEh ; 11ef5
	ASCII "P" ; 11ef6
	DB 02h, 0CEh ; 11ef7
	ASCII "X" ; 11ef9
	DB 03h, 0CFh, 0EDh, 0CEh, 40h, 1Eh, 0CEh, 0CFh ; 11efa
	DB 0CFh, 0D8h, 0C3h, 02h, 00h, 97h, 80h, 0E6h ; 11f02
	DB 11h, 0CFh, 0E4h, 0F0h, 2Dh, 0F1h, 0EDh, 0CFh ; 11f0a
	DB 0E3h, 0CEh ; 11f12
	ASCII "D" ; 11f14
	DB 02h, 0CEh ; 11f15
	ASCII "L" ; 11f17
	DB 03h, 0F1h, 17h, 0CEh ; 11f18
	ASCII "D" ; 11f1c
	DB 06h, 0CFh, 0D8h, 0CEh ; 11f1d
	ASCII "D" ; 11f21
	DB 14h, 0CEh ; 11f22
	ASCII "L" ; 11f24
	DB 15h, 0C3h, 02h, 00h, 0CFh, 0E3h, 0CEh ; 11f25
	ASCII "D" ; 11f2c
	DB 02h, 0CEh ; 11f2d
	ASCII "L" ; 11f2f
	DB 03h, 0C2h, 20h, 00h, 0CFh, 0B5h, 0F5h, 0A3h ; 11f30
	DB 0F8h, 0CEh, 0CCh, 0F4h, 0D6h, 99h, 2Bh, 00h ; 11f38
	DB 11h, 00h, 08h, 00h ; 11f40
	ASCII "p" ; 11f44
	DB 0ADh, 0D6h, 99h, 2Bh, 00h, 10h, 00h, 08h ; 11f45
	DB 00h ; 11f4d
	ASCII "p" ; 11f4e
	DB 0ADh, 0C1h, 99h, 3Ch, 1Fh, 0D6h, 99h, 2Bh ; 11f4f
	DB 00h, 2Eh, 00h, 08h, 00h ; 11f57
	ASCII "t" ; 11f5c
	DB 0ADh, 0D6h, 99h, 2Bh, 00h, 2Fh, 00h, 08h ; 11f5d
	DB 00h ; 11f65
	ASCII "t" ; 11f66
	DB 0ADh, 0C1h, 99h ; 11f67
	ASCII "T" ; 11f6a
	DB 1Fh, 01h, 00h ; 11f6b
	ASCII "x" ; 11f6e
	DB 0ADh, 8Eh, 99h, 01h, 00h, 7Ch, 0ADh, 8Eh ; 11f6f
	DB 99h, 01h, 00h, 80h, 0ADh, 8Eh, 99h, 01h ; 11f77
	DB 00h, 84h, 0ADh, 8Eh, 99h, 01h, 00h, 88h ; 11f7f
	DB 0ADh, 8Eh, 99h, 01h, 00h, 8Ch, 0ADh, 8Eh ; 11f87
	DB 99h, 01h, 00h, 90h, 0ADh, 8Eh, 99h, 01h ; 11f8f
	DB 00h, 94h, 0ADh, 8Eh, 99h, 01h, 00h, 98h ; 11f97
	DB 0ADh, 8Eh, 99h, 01h, 00h, 9Ch, 0ADh, 8Eh ; 11f9f
	DB 99h ; 11fa7
	ASCII "q" ; 11fa8
	DB 9Ah ; 11fa9
	ASCII "q" ; 11faa
	DB 9Ah, 3Ch, 1Fh ; 11fab
	ASCII "q" ; 11fae
	DB 9Ah ; 11faf
	ASCII "q" ; 11fb0
	DB 9Ah ; 11fb1
	ASCII "T" ; 11fb2
	DB 1Fh, 0C5h, 0D7h, 1Ah, 0CEh, 0D0h ; 11fb3
	ASCII "E" ; 11fb9
	DB 16h, 96h, 10h, 0E7h, 0Fh, 96h, 08h, 0E6h ; 11fba
	DB 20h, 86h ; 11fc2
	ASCII "E2@" ; 11fc4
	DB 0E4h, 0Dh, 0B5h, 00h, 0F1h, 09h, 8Eh ; 11fc7
	ASCII "E2" ; 11fce
	DB 0FFh, 0E7h, 03h, 0B5h, 3Fh, 0CEh, 0D0h, 0B6h ; 11fd0
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 04h, 0CEh, 0D4h ; 11fd8
	DB 0FAh, 14h ; 11fe0
	ASCII "EP" ; 11fe2
	DB 0B3h, 00h, 0B0h, 0Ah, 0CEh, 0D9h ; 11fe4
	ASCII "C" ; 11fea
	DB 0A3h, 0A6h, 00h, 0B1h, 00h, 0C7h, 00h, 20h ; 11feb
	DB 0CEh, 0C7h, 01h, 0CFh ; 11ff3
	ASCII "B" ; 11ff7
	DB 0CFh, 0D8h, 0F2h ; 11ff8
	ASCII "S" ; 11ffb
	DB 0D9h, 0AEh, 0ABh, 0F8h ; 11ffc
	ASCII "l" ; 12000
	DB 1Fh ; 12001
	ASCII "r" ; 12002
	DB 1Fh ; 12003
	ASCII "x" ; 12004
	DB 1Fh, 7Eh, 1Fh, 84h, 1Fh, 8Ah, 1Fh, 90h ; 12005
	DB 1Fh, 96h, 1Fh, 9Ch, 1Fh, 0A2h, 1Fh ; 1200d
	ASCII "q" ; 12014
	DB 9Ah, 0B4h, 9Fh ; 12015
	ASCII "v" ; 12018
	DB 1Ah, 0CEh, 0D0h, 0D7h, 1Ah ; 12019
	ASCII "P" ; 1201e
	DB 0B3h, 00h, 0B0h, 0Ah, 0CEh, 0D9h ; 1201f
	ASCII "B" ; 12025
	DB 0F3h, 0C3h, 0FFh ; 12026
	ASCII "q" ; 12029
	DB 9Ah, 1Ah, 0A0h ; 1202a
	ASCII "v" ; 1202d
	DB 1Ah, 01h, 00h, 28h, 0C8h, 01h, 00h ; 1202e
	ASCII "H" ; 12035
	DB 0C8h, 0C1h, 99h, 2Fh, 20h ; 12036
	ASCII "q" ; 1203b
	DB 9Ah ; 1203c
	ASCII "q" ; 1203d
	DB 9Ah, 2Fh, 20h, 28h, 00h ; 1203e
	ASCII "h" ; 12043
	DB 0C8h, 02h, 00h ; 12044
	ASCII "p" ; 12047
	DB 0C8h, 02h, 00h ; 12048
	ASCII "x" ; 1204b
	DB 0C8h, 02h, 00h ; 1204c
	ASCII "p" ; 1204f
	DB 0C8h ; 12050
	ASCIZ "P" ; 12051
	ASCII "h" ; 12053
	DB 0C8h, 02h, 00h ; 12054
	ASCII "p" ; 12057
	DB 0C8h, 02h, 00h ; 12058
	ASCII "x" ; 1205b
	DB 0C8h, 02h, 00h ; 1205c
	ASCII "p" ; 1205f
	DB 0C8h, 03h, 00h ; 12060
	ASCII "h" ; 12063
	DB 0C8h, 02h, 00h ; 12064
	ASCII "p" ; 12067
	DB 0C8h, 02h, 00h ; 12068
	ASCII "x" ; 1206b
	DB 0C8h, 02h, 00h ; 1206c
	ASCII "p" ; 1206f
	DB 0C8h, 0C1h, 99h ; 12070
	ASCII "A q" ; 12073
	DB 9Ah ; 12076
	ASCII "q" ; 12077
	DB 9Ah ; 12078
	ASCII "A " ; 12079
	DB 9Dh, 99h ; 1207b
	ASCII "q" ; 1207d
	DB 9Ah, 03h, 00h, 80h, 0C8h, 03h, 00h, 88h ; 1207e
	DB 0C8h, 9Dh, 99h, 91h, 0A0h, 01h, 00h, 80h ; 12086
	DB 0C8h, 8Eh, 99h, 0CEh, 0D0h ; 1208e
	ASCII "x" ; 12093
	DB 1Bh, 28h, 0E6h, 0Ch ; 12094
	ASCII "8" ; 12098
	DB 0CEh, 0D4h ; 12099
	ASCII "x" ; 1209b
	DB 1Bh, 0C4h, 7Bh, 20h, 0F2h, 0ADh, 0D8h, 0F8h ; 1209c
	ASCII "q" ; 120a4
	DB 9Ah, 91h, 0A0h, 8Bh, 20h, 9Dh, 99h ; 120a5
	ASCII "D" ; 120ac
	DB 0A1h, 0Ch, 00h, 24h, 0C8h, 0Ch, 00h, 08h ; 120ad
	DB 0C8h, 0C1h, 99h, 0AEh, 20h, 9Dh, 99h ; 120b5
	ASCII "q" ; 120bc
	DB 9Ah, 01h, 00h, 24h, 0C8h, 8Eh, 99h, 9Dh ; 120bd
	DB 99h, 0FEh, 0A0h, 03h, 00h, 18h, 0C8h, 03h ; 120c5
	DB 00h, 1Ch, 0C8h, 05h, 00h, 20h, 0C8h, 03h ; 120cd
	DB 00h, 1Ch, 0C8h, 0C1h, 99h, 0C8h, 20h, 9Dh ; 120d5
	DB 99h, 20h, 0A1h, 03h, 00h, 0Ch, 0C8h, 03h ; 120dd
	DB 00h, 10h, 0C8h, 05h, 00h, 14h, 0C8h, 03h ; 120e5
	DB 00h, 10h, 0C8h, 0C1h, 99h, 0E0h, 20h, 9Dh ; 120ed
	DB 99h ; 120f5
	ASCII "h" ; 120f6
	DB 0A1h, 04h, 00h ; 120f7
	ASCII "m" ; 120fa
	DB 1Ah, 8Eh, 99h, 0CEh, 0D0h ; 120fb
	ASCII "C" ; 12100
	DB 16h, 96h, 07h, 0E6h, 1Ah, 0CEh, 0D0h, 0B6h ; 12101
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h ; 12109
	DB 0FAh, 14h, 0C4h, 0F4h, 20h, 0F2h ; 12111
	ASCII "7" ; 12117
	DB 0D8h, 0B0h, 82h, 0CEh, 0D4h ; 12118
	ASCII "w" ; 1211d
	DB 1Bh, 0F8h, 0B2h, 08h, 0CEh, 0D0h ; 1211e
	ASCII "z" ; 12124
	DB 1Bh ; 12125
	ASCII "2" ; 12126
	DB 02h, 0E6h, 14h ; 12127
	ASCIZ "2" ; 1212a
	DB 0E6h, 03h, 0B2h, 20h, 0CEh, 0D0h ; 1212c
	ASCII "t" ; 12132
	DB 1Bh, 00h, 00h, 00h ; 12133
	ASCII "HB" ; 12137
	DB 0F2h ; 12139
	ASCII "G" ; 1213a
	DB 0D8h, 0F8h, 0C4h, 0F4h, 20h, 0F2h, 0Dh, 0D8h ; 1213b
	DB 0F8h, 0CEh, 0D0h ; 12143
	ASCII "C" ; 12146
	DB 16h, 96h, 01h, 0E6h, 1Ch, 0C4h, 0BAh, 20h ; 12147
	DB 0F2h, 0FEh, 0D7h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 1214f
	DB 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h ; 12157
	DB 0F2h, 8Dh, 81h, 0A3h, 0F2h, 2Ah, 81h, 0ABh ; 1215f
	DB 0F8h, 0CEh, 0D0h ; 12167
	ASCII "w" ; 1216a
	DB 1Bh, 28h, 0E6h, 3Eh, 88h, 00h, 0B1h, 00h ; 1216b
	DB 0A6h, 0A3h, 0C7h, 0ADh, 21h, 0CFh ; 12173
	ASCII "B" ; 12179
	DB 0CEh, 0C7h, 01h, 0CFh, 0D8h, 0ABh, 0AEh, 0F2h ; 1217a
	DB 0CCh, 0D7h, 0CEh, 0D0h ; 12182
	ASCII "t" ; 12186
	DB 1Bh, 00h, 00h, 00h ; 12187
	ASCII "H" ; 1218b
	DB 0CEh, 0D0h ; 1218c
	ASCII "w" ; 1218e
	DB 1Bh ; 1218f
	ASCII "2" ; 12190
	DB 03h, 0E7h, 0Fh, 0B2h, 08h, 0CEh, 0D0h ; 12191
	ASCII "z" ; 12198
	DB 1Bh, 28h, 0E6h, 03h, 0B2h, 20h ; 12199
	ASCII "B" ; 1219f
	DB 0F1h, 08h, 0CEh, 0D0h ; 121a0
	ASCII "u" ; 121a4
	DB 1Bh, 00h, 00h, 00h, 0F2h, 0D7h, 0D7h, 0F8h ; 121a5
	DB 0AAh, 20h, 0C4h, 20h, 0DCh, 20h ; 121ad
	ASCII "q" ; 121b3
	DB 9Ah ; 121b4
	ASCII "h" ; 121b5
	DB 0A1h ; 121b6
	ASCII "v" ; 121b7
	DB 1Ah, 10h, 00h, 0A0h, 0ADh, 10h, 00h, 0A4h ; 121b8
	DB 0ADh, 0C1h, 99h, 0B9h, 21h, 0CEh, 0D0h ; 121c0
	ASCII "C" ; 121c7
	DB 16h, 96h, 01h, 0E7h, 1Dh, 96h, 02h, 0E6h ; 121c8
	ASCII "1" ; 121d0
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 121d1
	DB 02h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0B5h, 86h ; 121d9
	DB 0B1h, 03h, 0A3h, 0F2h, 0A9h, 80h, 0ABh, 0F8h ; 121e1
	DB 0A6h, 0A3h, 0CEh, 0C7h, 01h, 0C7h ; 121e9
	ASCII "a", 22h, "" ; 121ef
	DB 0CEh, 0D0h, 0Ah, 1Bh ; 121f1
	ASCII "2" ; 121f5
	DB 07h, 0E4h, 03h, 0B0h, 07h, 0F2h, 89h, 83h ; 121f6
	DB 0ABh, 0AEh, 0F8h, 0CEh, 0D0h, 0Ah, 1Bh, 0CEh ; 121fe
	DB 0D1h ; 12206
	ASCII "E" ; 12207
	DB 16h, 97h, 20h, 0E7h, 11h, 97h, 40h, 0E7h ; 12208
	DB 10h, 97h, 08h, 0E7h, 0Fh, 97h, 10h, 0E6h ; 12210
	DB 20h, 02h, 04h, 0F1h, 09h, 88h, 0F1h, 06h ; 12218
	DB 80h, 0F1h, 03h, 12h, 04h, 22h, 07h, 0CEh ; 12220
	DB 0D4h, 0Ah, 1Bh, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 12228
	DB 0E6h, 07h, 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h ; 12230
	DB 0CEh, 0D0h, 0Ah, 1Bh, 00h, 0B1h, 00h, 0A6h ; 12238
	DB 0A3h, 0C7h ; 12240
	ASCII "Q", 22h, "" ; 12242
	DB 0CEh, 0C7h, 01h, 0CFh ; 12244
	ASCII "B" ; 12248
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0F2h ; 12249
	ASCII "3" ; 1224e
	DB 0D7h, 0F8h, 0Ch, 0Ch, 24h, 0Ch, 3Ch, 0Ch ; 1224f
	ASCII "T" ; 12257
	DB 0Ch, 0Ch, 24h, 24h, 24h, 3Ch, 24h ; 12258
	ASCII "T$q" ; 1225f
	DB 0A2h, 0A0h, 0A2h, 0B4h, 0A2h, 28h, 0A3h, 0D4h ; 12262
	DB 0A2h, 00h, 0A3h, 14h, 0A3h, 0E8h, 0A2h, 0CEh ; 1226a
	DB 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 06h ; 12272
	DB 0CEh, 0D4h, 0FAh, 14h, 0B0h, 01h, 0CEh, 0D4h ; 1227a
	DB 22h, 1Bh, 0C5h, 0D8h, 1Ah, 0CEh, 3Dh, 01h ; 12282
	DB 0CEh, 0C4h, 03h, 0F2h, 07h, 0EAh, 0CEh, 0D1h ; 1228a
	DB 23h, 1Bh, 0B0h, 28h, 0BCh, 12h, 1Bh, 0C5h ; 12292
	DB 0B5h, 86h, 0B1h, 03h, 0F1h, 5Bh, 0CEh, 0D0h ; 1229a
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 122a2
	DB 0D4h, 0FAh, 14h, 0C5h, 9Fh, 95h, 0B1h, 03h ; 122aa
	DB 0F1h ; 122b2
	ASCII "G" ; 122b3
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 122b4
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0B0h, 03h, 0CEh ; 122bc
	DB 0D4h, 15h, 1Bh, 0CEh, 0C4h, 03h, 0F2h, 05h ; 122c4
	DB 0EBh, 0C5h, 0B8h, 86h, 0B1h, 03h, 0F1h, 27h ; 122cc
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 122d4
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0D7h, 91h ; 122dc
	DB 0B1h, 03h, 0F1h, 13h, 0CEh, 0D0h, 0B6h, 1Ah ; 122e4
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 122ec
	DB 14h, 0C5h, 0E8h, 0A2h, 0B1h, 03h, 0A3h, 0F2h ; 122f4
	DB 92h, 7Fh, 0ABh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah ; 122fc
	DB 20h, 0E6h, 07h, 0B0h, 08h, 0CEh, 0D4h, 0FAh ; 12304
	DB 14h, 0C5h, 28h, 0E8h, 0B1h, 03h, 0F1h, 0E7h ; 1230c
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 12314
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0D0h, 0A7h ; 1231c
	DB 0B1h, 03h, 0F1h, 0D3h, 0CEh, 0D0h, 0B6h, 1Ah ; 12324
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 1232c
	DB 14h, 0C5h, 0BCh, 97h, 0B1h, 03h, 0F1h, 0BFh ; 12334
	DB 0F8h ; 1233c
	ASCII "q" ; 1233d
	DB 9Ah, 0C5h, 0A1h, 0B9h, 21h, 0C5h, 0CBh, 1Ah ; 1233e

	ASCII "8" ; 12346
	DB 0CEh ; 12347
	ASCII "5" ; 12348
	DB 0FFh, 0E6h, 05h, 80h, 91h, 0F1h, 0F8h, 28h ; 12349
	DB 0E7h, 05h, 0B5h, 00h, 0F1h, 1Ch ; 12351
	ASCII "2" ; 12357
	DB 05h, 0E4h, 0Eh, 0C5h, 0CBh, 1Ah, 91h ; 12358
	ASCII "E" ; 1235f
	DB 99h ; 12360
	ASCII "h" ; 12361
	DB 91h ; 12362
	ASCII "2" ; 12363
	DB 0FFh, 0E7h, 0F8h, 99h, 99h ; 12364
	ASCII "E" ; 12369
	DB 91h, 80h ; 1236a
	ASCII "2P" ; 1236c
	DB 0E4h, 02h ; 1236e
	ASCII "8h" ; 12370
	DB 0F8h, 08h, 00h ; 12372
	ASCII "H" ; 12375
	DB 0CAh, 08h, 00h ; 12376
	ASCII "L" ; 12379
	DB 0CAh, 0C1h, 99h ; 1237a
	ASCII "s#" ; 1237d
	DB 08h, 00h ; 1237f
	ASCII "P" ; 12381
	DB 0CAh, 08h, 00h ; 12382
	ASCII "T" ; 12385
	DB 0CAh, 0C1h, 99h, 7Fh, 23h ; 12386
	ASCII "q" ; 1238b
	DB 9Ah ; 1238c
	ASCII "q" ; 1238d
	DB 9Ah, 7Fh, 23h ; 1238e
	ASCII "q" ; 12391
	DB 9Ah ; 12392
	ASCII "q" ; 12393
	DB 9Ah ; 12394
	ASCII "s#" ; 12395
	DB 08h, 00h, 0C8h, 0C8h, 08h, 00h, 0CCh, 0C8h ; 12397
	DB 0C1h, 99h, 97h, 23h ; 1239f
	ASCII "q" ; 123a3
	DB 9Ah ; 123a4
	ASCII "q" ; 123a5
	DB 9Ah, 97h, 23h, 08h, 00h, 0C0h, 0C8h, 08h ; 123a6
	DB 00h, 0C4h, 0C8h, 0C1h, 99h, 0A9h, 23h ; 123ae
	ASCII "q" ; 123b5
	DB 9Ah ; 123b6
	ASCII "q" ; 123b7
	DB 9Ah, 0A9h, 23h, 08h, 00h, 0F8h, 0C9h, 8Eh ; 123b8
	DB 99h, 08h, 00h, 0FCh, 0C9h, 8Eh, 99h, 08h ; 123c0
	DB 00h, 00h, 0CAh, 8Eh, 99h, 08h, 00h, 04h ; 123c8
	DB 0CAh, 8Eh, 99h, 08h, 00h, 08h, 0CAh, 8Eh ; 123d0
	DB 99h, 08h, 00h, 0Ch, 0CAh, 8Eh, 99h, 08h ; 123d8
	DB 00h, 10h, 0CAh, 8Eh, 99h, 08h, 00h, 14h ; 123e0
	DB 0CAh, 8Eh, 99h, 08h, 00h, 18h, 0CAh, 8Eh ; 123e8
	DB 99h, 08h, 00h, 1Ch, 0CAh, 8Eh, 99h, 08h ; 123f0
	DB 00h, 20h, 0CAh, 8Eh, 99h, 08h, 00h, 24h ; 123f8
	DB 0CAh, 8Eh, 99h, 08h, 00h, 0D0h, 0C8h, 8Eh ; 12400
	DB 99h, 0CEh, 0D0h, 0E9h, 1Ah, 88h ; 12408
	ASCII "2" ; 1240e
	DB 0FFh, 0E7h, 03h, 0B0h, 07h, 0F3h, 01h, 00h ; 1240f
	ASCII "2" ; 12417
	DB 08h, 0E4h, 03h, 0B0h, 07h, 0CFh, 0B0h, 0F2h ; 12418
	DB 0B7h, 7Fh, 0CEh, 0D1h, 0EAh, 1Ah, 21h, 0CFh ; 12420
	DB 0B4h, 0E7h, 06h, 0C4h, 03h, 24h, 0F1h, 15h ; 12428
	DB 0F2h ; 12430
	ASCIZ "D" ; 12431
	DB 00h, 0B1h, 00h, 0A6h, 0A3h, 0C7h ; 12433
	ASCII "X$" ; 12439
	DB 0CEh, 0C7h, 01h, 0CFh ; 1243b
	ASCII "B" ; 1243f
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0CEh ; 12440
	ASCII "P" ; 12445
	DB 18h, 0CEh ; 12446
	ASCII "X" ; 12448
	DB 19h, 0CFh, 19h, 0E6h, 0Ah, 0CEh ; 12449
	ASCII "D" ; 1244f
	DB 18h, 0CEh ; 12450
	ASCII "L" ; 12452
	DB 19h, 0F2h, 0F9h, 0D4h, 0F8h, 0BBh, 23h, 0C1h ; 12453
	DB 23h, 0C7h, 23h, 0CDh, 23h, 0D3h, 23h, 0D9h ; 1245b
	DB 23h, 0DFh, 23h, 0E5h, 23h, 0EBh, 23h, 0F1h ; 12463
	DB 23h, 0F7h, 23h, 0FDh, 23h ; 1246b
	ASCII "q" ; 12470
	DB 9Ah, 09h, 0A4h ; 12471
	ASCII "v" ; 12474
	DB 1Ah, 0A6h, 0A3h, 0CFh, 0B0h, 0CEh, 0D0h, 0D7h ; 12475
	DB 1Ah, 00h, 0B1h, 00h, 0C7h, 0BAh, 24h, 0CEh ; 1247d
	DB 0C7h, 01h, 0CFh ; 12485
	ASCII "B" ; 12488
	DB 0CFh, 0DBh, 0CFh, 0B4h, 0B1h, 00h, 0CFh ; 12489
	ASCII "BG" ; 12490
	DB 0ABh, 0AEh, 0F8h, 0A6h, 0A3h, 0CFh, 0B0h, 0CEh ; 12492
	DB 0D0h, 0D7h, 1Ah, 00h, 0B1h, 00h, 0C7h, 0BAh ; 1249a
	DB 24h, 0CEh, 0C7h, 01h, 0CFh ; 124a2
	ASCII "B" ; 124a7
	DB 0CFh, 0DBh, 0CFh, 0B4h, 0B1h, 08h ; 124a8
	ASCII "7" ; 124ae
	DB 0E6h, 04h, 93h, 0F5h, 0FBh, 0B0h, 08h, 11h ; 124af
	DB 0ABh, 0AEh, 0F8h, 0C0h, 24h, 0C8h, 24h, 0D0h ; 124b7
	DB 24h, 00h, 01h, 02h, 03h, 04h, 05h, 06h ; 124bf
	DB 07h, 00h, 04h, 03h, 05h, 02h, 01h, 06h ; 124c7
	DB 07h, 00h, 03h, 01h, 07h, 02h, 05h, 04h ; 124cf
	DB 06h, 0CEh, 0D0h, 0E9h, 1Ah, 80h ; 124d7
	ASCII "2" ; 124dd
	DB 08h, 0E4h, 02h ; 124de
	ASCII "8" ; 124e1
	DB 0F3h ; 124e2
	ASCII "3" ; 124e3
	DB 0FFh ; 124e4
	ASCII "q" ; 124e5
	DB 9Ah, 0D8h, 0A4h ; 124e6
	ASCII "v" ; 124e9
	DB 1Ah, 0CEh, 0D0h ; 124ea
	ASCII "E" ; 124ed
	DB 16h, 96h, 20h, 0E7h, 11h, 96h, 40h, 0E6h ; 124ee
	DB 29h, 0CEh, 0D0h, 0E9h, 1Ah, 80h ; 124f6
	ASCII "2" ; 124fc
	DB 08h, 0E4h, 0Fh ; 124fd
	ASCII "8" ; 12500
	DB 0F1h, 0Ch, 0CEh, 0D0h, 0E9h, 1Ah, 88h ; 12501
	ASCII "2" ; 12508
	DB 0FFh, 0E7h, 03h, 0B0h, 07h, 0CEh, 0D4h, 0E9h ; 12509
	DB 1Ah, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 12511
	DB 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0CEh, 0D0h ; 12519
	DB 0E9h, 1Ah, 0F3h, 0F2h, 0FEh ; 12521
	ASCII "q" ; 12526
	DB 9Ah, 0EBh, 0A4h ; 12527
	ASCII "v" ; 1252a
	DB 1Ah, 0CEh, 0D0h, 0E9h, 1Ah, 0F3h, 0E5h, 0FEh ; 1252b
	ASCII "q" ; 12533
	DB 9Ah, 2Ch, 0A5h ; 12534
	ASCII "v" ; 12537
	DB 1Ah, 08h, 00h, 0C8h, 0C8h, 08h, 00h, 0CCh ; 12538
	DB 0C8h, 0C1h, 99h ; 12540
	ASCII "9%" ; 12543
	DB 0CEh, 0D0h ; 12545
	ASCII "E" ; 12547
	DB 16h, 96h, 08h, 0E7h, 13h, 96h, 10h, 0E6h ; 12548
	DB 28h, 0CEh, 0D0h, 80h, 1Bh, 0CEh, 0D1h, 7Fh ; 12550
	DB 1Bh ; 12558
	ASCII "1" ; 12559
	DB 0E6h, 1Dh, 80h, 0F1h, 09h, 0CEh, 0D0h, 80h ; 1255a
	DB 1Bh, 28h, 0E6h, 13h, 88h, 0CEh, 0D4h, 80h ; 12562
	DB 1Bh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1256a
	DB 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0F3h, 82h ; 12572
	DB 00h ; 1257a
	ASCII "q" ; 1257b
	DB 9Ah ; 1257c
	ASCII "E" ; 1257d
	DB 0A5h ; 1257e
	ASCII "9%" ; 1257f
	DB 0CEh, 0D0h ; 12581
	ASCII "C" ; 12583
	DB 16h, 96h, 01h, 0E7h, 17h, 96h, 02h, 0E6h ; 12584
	DB 3Ch, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1258c
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 12594
	ASCII "R}" ; 1259b
	DB 0F1h, 11h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1259d
	DB 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 125a5
	DB 26h, 7Dh, 0A3h, 0F2h, 0DDh, 7Ch, 0ABh, 0CEh ; 125ad
	DB 0D0h, 80h, 1Bh, 28h, 0E6h, 02h, 88h, 0B1h ; 125b5
	DB 00h, 0C5h, 0CBh, 1Ah, 0CFh, 20h ; 125bd
	ASCII "E" ; 125c3
	DB 0CEh, 0D4h, 0C9h, 1Bh, 0CEh, 0D0h ; 125c4
	ASCII "E" ; 125ca
	DB 16h, 96h, 08h, 0E7h, 13h, 96h, 10h, 0E6h ; 125cb
	DB 29h, 0CEh, 0D0h, 80h, 1Bh, 0CEh, 0D1h, 7Fh ; 125d3
	DB 1Bh ; 125db
	ASCII "1" ; 125dc
	DB 0E6h, 1Eh, 80h, 0F1h, 0Ah, 0CEh, 0D0h, 80h ; 125dd
	DB 1Bh ; 125e5
	ASCII "2" ; 125e6
	DB 01h, 0E6h, 13h, 88h, 0CEh, 0D4h, 80h, 1Bh ; 125e7
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 125ef
	DB 04h, 0CEh, 0D4h, 0FAh, 14h, 0CEh, 0D0h, 80h ; 125f7
	DB 1Bh, 00h, 00h, 00h, 02h, 0FCh ; 125ff
	ASCII "H" ; 12605
	DB 0B0h, 02h, 0F2h ; 12606
	ASCII "x" ; 12609
	DB 0D3h, 0F8h, 0CEh, 0D0h, 80h, 1Bh, 28h, 0E6h ; 1260a
	DB 0Ch, 0C5h, 81h, 0A5h, 0C4h ; 12612
	ASCII "9%" ; 12617
	DB 0F2h ; 12619
	ASCII "U" ; 1261a
	DB 0D3h, 0F1h, 0DFh, 0F8h ; 1261b
	ASCII "q" ; 1261f
	DB 9Ah, 0Ch, 0A6h ; 12620
	ASCII "v" ; 12623
	DB 1Ah ; 12624
	ASCII "q" ; 12625
	DB 9Ah, 81h, 0A5h ; 12626
	ASCII "9%" ; 12629
	DB 08h, 08h, 02h, 01h, 0FEh, 0FEh, 00h, 00h ; 1262b
	DB 08h, 18h, 00h, 02h, 0FEh, 0FEh, 00h, 00h ; 12633
	DB 08h, 28h, 01h, 00h, 0FEh, 0FEh, 00h, 00h ; 1263b
	DB 0C7h, 2Bh, 26h, 0CEh, 0D0h ; 12643
	ASCII "n" ; 12648
	DB 1Bh, 0F2h, 0A2h, 0EFh, 0F8h, 0C7h, 2Bh, 26h ; 12649
	DB 0CEh, 0C7h, 01h, 0CEh, 0D0h ; 12651
	ASCII "n" ; 12656
	DB 1Bh, 0F2h, 0B6h, 0EFh, 0CEh, 0D4h ; 12657
	ASCII "n" ; 1265d
	DB 1Bh, 0F8h ; 1265e
	ASCII "C" ; 12660
	DB 0A6h ; 12661
	ASCII "N" ; 12662
	DB 0A6h ; 12663
	ASCIZ "9%" ; 12664
	ASCII "0" ; 12667
	DB 02h, 01h, 0FEh, 0FEh, 9Eh, 26h, 00h ; 12668
	ASCIZ "0" ; 1266f
	DB 02h, 0FEh, 0FEh, 0AAh, 26h, 00h ; 12671
	ASCII "0" ; 12677
	DB 01h, 00h, 0FEh, 0FEh, 0B6h, 26h, 00h ; 12678
	ASCII "0" ; 1267f
	DB 03h, 01h, 0FEh, 0FEh, 9Eh, 26h, 00h ; 12680
	ASCIZ "0" ; 12687
	DB 02h, 0FEh, 0FEh, 0AAh, 26h, 00h ; 12689
	ASCII "0" ; 1268f
	DB 01h, 03h, 0FEh, 0FEh, 0B6h, 26h, 00h ; 12690
	ASCII "0" ; 12697
	DB 02h, 00h, 0FEh, 0FEh, 0C2h, 26h, 06h, 00h ; 12698
	DB 8Ch, 0CAh, 06h, 00h, 94h, 0CAh, 0C1h, 99h ; 126a0
	DB 9Eh, 26h, 06h, 00h, 9Ch, 0CAh, 06h, 00h ; 126a8
	DB 0A4h, 0CAh, 0C1h, 99h, 0AAh, 26h, 06h, 00h ; 126b0
	DB 0ACh, 0CAh, 06h, 00h, 0B4h, 0CAh, 0C1h, 99h ; 126b8
	DB 0B6h, 26h, 06h, 00h, 0BCh, 0CAh, 06h, 00h ; 126c0
	DB 0C4h, 0CAh, 0C1h, 99h, 0C2h, 26h, 0F2h, 21h ; 126c8
	DB 00h, 0CEh, 0D0h, 0C9h, 1Ah, 0F2h, 17h, 0EFh ; 126d0
	DB 0F8h, 0F2h, 16h, 00h, 0CEh, 0C7h, 01h, 0CEh ; 126d8
	DB 0D0h, 0C9h, 1Ah, 0F2h, 2Bh, 0EFh, 0CEh, 0D4h ; 126e0
	DB 0C9h, 1Ah, 0F8h, 0CEh, 0A6h, 0D9h, 0A6h, 9Eh ; 126e8
	DB 26h, 0C7h ; 126f0
	ASCII "f&" ; 126f2
	DB 0CEh, 0D0h, 0D1h, 1Ah, 0C5h, 0D1h, 1Ah ; 126f4
	ASCII "E" ; 126fb
	DB 91h, 2Bh, 91h, 2Bh, 0E6h, 04h, 0C7h, 7Eh ; 126fc
	DB 26h, 0F8h, 9Dh, 99h ; 12704
	ASCII "q" ; 12708
	DB 9Ah, 08h, 00h, 0B0h, 0AEh, 9Dh, 99h, 29h ; 12709
	DB 0A7h, 01h, 00h, 0A8h, 0AEh, 8Eh, 99h ; 12711
	ASCII "E2G" ; 12718
	DB 0E4h, 0Ah, 91h ; 1271b
	ASCII "E2%" ; 1271e
	DB 0E7h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 12721
	DB 0CEh, 0D0h, 0E8h, 1Ah, 28h, 0E6h, 18h, 0C5h ; 12729
	DB 12h, 1Bh, 0F2h, 0E3h, 0FFh, 0E6h, 10h, 0CEh ; 12731
	ASCII "P" ; 12739
	DB 18h, 0CEh ; 1273a
	ASCII "X" ; 1273c
	DB 19h, 0C4h, 06h, 27h, 0CFh, 19h, 0E6h, 0Fh ; 1273d
	DB 0F1h, 04h, 0C4h ; 12745
	ASCII "r" ; 12748
	DB 1Ah, 0CEh ; 12749
	ASCII "D" ; 1274b
	DB 18h, 0CEh ; 1274c
	ASCII "L" ; 1274e
	DB 19h, 0F2h, 0FDh, 0D1h, 0F8h, 0CEh, 0D0h, 0E8h ; 1274f
	DB 1Ah, 28h, 0E6h, 09h, 0C5h, 12h, 1Bh, 0F2h ; 12757
	DB 0B8h, 0FFh, 0E7h, 06h, 0C4h, 12h, 27h, 0F1h ; 1275f
	DB 04h, 0C4h ; 12767
	ASCII "v" ; 12769
	DB 1Ah, 0F2h, 0E2h, 0D1h, 0F8h ; 1276a
	ASCII "q" ; 1276f
	DB 9Ah, 29h, 0A7h ; 12770
	ASCII "v" ; 12773
	DB 1Ah ; 12774
	ASCII "q" ; 12775
	DB 9Ah ; 12776
	ASCII "T" ; 12777
	DB 0A7h ; 12778
	ASCII "v" ; 12779
	DB 1Ah, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 0B1h, 00h ; 1277a
	DB 0CFh ; 12782
	ASCII "B" ; 12783
	DB 0CFh, 0DBh, 0F8h, 0CEh, 0D0h, 15h, 1Bh ; 12784
	ASCII "2" ; 1278b
	DB 04h, 0E6h ; 1278c
	ASCII "52" ; 1278e
	DB 03h, 0E6h, 27h, 0CEh, 0D0h, 14h, 1Bh, 28h ; 12790
	DB 0E7h, 16h, 0CEh, 0C4h, 01h, 0F2h, 0EEh, 0F3h ; 12798
	DB 0E7h, 1Dh, 0CEh, 0C4h, 01h, 0F2h, 0AFh, 0F3h ; 127a0
	DB 0E6h, 22h, 0C3h, 02h, 00h, 0F1h, 1Dh, 0CEh ; 127a8
	DB 0D0h, 15h, 1Bh ; 127b0
	ASCII "2" ; 127b3
	DB 05h, 0E6h, 12h, 0F1h, 13h, 0C3h, 04h, 00h ; 127b4
	DB 0F1h, 0Eh, 0C3h, 0Ah, 00h, 0F1h, 09h, 0C3h ; 127bc
	DB 06h, 00h, 0F1h, 04h, 0C3h, 08h, 00h, 0CFh ; 127c4
	DB 0DBh, 0F8h, 0CEh, 0D0h, 80h, 1Bh, 28h, 0E6h ; 127cc
	DB 04h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h, 0B0h ; 127d4
	DB 00h, 0CEh, 0D4h, 15h, 1Bh, 0A6h, 0A3h, 0CEh ; 127dc
	DB 0D0h, 80h, 1Bh, 28h, 0EEh, 94h, 00h, 88h ; 127e4
	DB 0B1h, 00h, 0C7h, 0CBh, 1Ah, 0CEh, 0C7h, 00h ; 127ec
	DB 0CFh ; 127f4
	ASCII "BG2" ; 127f5
	DB 1Eh, 0E4h, 05h, 12h, 1Eh, 0F1h, 0F9h ; 127f8
	ASCII "P" ; 127ff
	DB 0B3h, 00h, 0B0h, 06h, 0CEh, 0D9h ; 12800
	ASCII "KB(" ; 12806
	DB 0E6h, 1Ah, 88h, 0E6h, 28h, 88h, 0E6h ; 12809
	ASCII "6" ; 12810
	DB 88h, 0E6h ; 12811
	ASCII "C" ; 12813
	DB 81h, 0CEh, 81h, 0CEh, 81h, 0CFh, 0B1h, 0F2h ; 12814
	DB 0E3h, 07h, 0CFh, 0B5h, 0F5h, 0F8h, 0F1h ; 1281c
	ASCII "B" ; 12823
	DB 81h, 0CEh, 81h, 0CFh, 0B1h, 0F2h, 0DAh, 07h ; 12824
	DB 0F2h, 0CDh, 07h, 0CFh, 0B5h, 0F5h, 0F5h, 0F1h ; 1282c
	ASCII "1" ; 12834
	DB 81h, 0CEh, 81h, 0CFh, 0B1h, 0F2h, 0C9h, 07h ; 12835
	DB 0F2h, 0C1h, 07h, 0CFh, 0B5h, 0F5h, 0F5h, 0F1h ; 1283d
	DB 20h, 81h, 0CEh, 81h, 0CEh, 81h, 0CFh, 0B1h ; 12845
	DB 0F2h, 0ACh, 07h, 0CFh, 0B5h, 0F5h, 0F8h, 0F1h ; 1284d
	DB 10h, 81h, 0CEh, 81h, 0CFh, 0B1h, 0F2h, 0A8h ; 12855
	DB 07h, 0F2h, 96h, 07h, 0CFh, 0B5h, 0F5h, 0F5h ; 1285d
	DB 0CEh, 0D0h, 80h, 1Bh, 0B1h, 00h, 0C5h, 0CBh ; 12865
	DB 1Ah, 0CFh, 20h ; 1286d
	ASCII "E" ; 12870
	DB 99h ; 12871
	ASCII "h" ; 12872
	DB 91h, 91h ; 12873
	ASCII "2" ; 12875
	DB 0FFh, 0E7h, 0F8h, 0F2h, 0Ch, 00h, 0F1h, 07h ; 12876
	DB 0F2h ; 1287e
	ASCII "D" ; 1287f
	DB 07h, 0F2h ; 12880
	ASCII "A" ; 12882
	DB 07h, 0ABh, 0AEh, 0F8h, 0A2h, 0C6h, 0AAh, 15h ; 12883
	DB 0CEh, 0C6h, 00h, 0F2h ; 1288b
	ASCII "v" ; 1288f
	DB 9Eh, 0C6h, 0AAh, 15h, 0CEh, 0C6h, 00h, 0C5h ; 12890
	DB 0ECh, 1Ah, 0B1h, 07h ; 12898
	ASCII "n" ; 1289c
	DB 92h, 91h, 0F5h, 0FCh, 0AAh, 0F8h, 0B9h ; 1289d
	ASCII "7" ; 128a4
	DB 1Bh, 0C1h, 18h, 00h, 0CFh, 0C0h, 0D4h, 86h ; 128a5
	DB 96h, 0E6h, 1Bh, 0D4h, 0B8h, 96h, 0E6h, 1Bh ; 128ad
	DB 0D4h, 0FCh, 96h, 0E6h, 1Bh, 0CEh ; 128b5
	ASCII "P" ; 128bb
	DB 18h, 0CEh ; 128bc
	ASCII "X" ; 128be
	DB 19h, 0D5h ; 128bf
	ASCII "n" ; 128c1
	DB 0C4h, 0E6h, 06h, 0C4h ; 128c2
	ASCII "N" ; 128c6
	DB 0C4h, 0F1h, 0Eh, 0C4h ; 128c7
	ASCII "X" ; 128cb
	DB 0C4h, 0F1h, 09h, 0C4h ; 128cc
	ASCII "n" ; 128d0
	DB 0C4h, 0F1h, 04h, 0C4h, 94h, 0C4h, 0CEh ; 128d1
	ASCII "P" ; 128d8
	DB 18h, 0CEh ; 128d9
	ASCII "X" ; 128db
	DB 19h, 0CFh ; 128dc
	ASCII "8" ; 128de
	DB 0E6h, 09h, 0CEh ; 128df
	ASCII "D" ; 128e2
	DB 18h, 0CEh ; 128e3
	ASCII "L" ; 128e5
	DB 19h, 0CFh, 0ECh, 0F8h, 0B9h ; 128e6
	ASCII "7" ; 128eb
	DB 1Bh, 0C1h, 18h, 00h, 0CFh, 0C0h, 0D4h, 83h ; 128ec
	DB 98h, 0E6h, 2Ah, 0D4h, 0A5h, 98h, 0E6h, 2Ah ; 128f4
	DB 0D4h, 0D5h, 98h, 0E6h, 2Ah, 0D4h, 05h, 99h ; 128fc
	DB 0E6h, 2Ah, 0D4h ; 12904
	ASCII "5" ; 12907
	DB 99h, 0E6h, 2Ah, 0CEh, 40h, 18h, 0CEh ; 12908
	ASCII "H" ; 1290f
	DB 19h, 0D4h, 0F9h, 0C4h, 0E6h, 10h, 0D4h, 23h ; 12910
	DB 0C5h, 0E6h, 10h, 0D4h ; 12918
	ASCII "M" ; 1291c
	DB 0C5h, 0E6h, 10h, 0C4h ; 1291d
	ASCII "w" ; 12921
	DB 0C5h, 0F1h, 13h, 0C4h, 0CFh, 0C4h, 0F1h, 0Eh ; 12922
	DB 0C4h, 0F9h, 0C4h, 0F1h, 09h, 0C4h, 23h, 0C5h ; 1292a
	DB 0F1h, 04h, 0C4h ; 12932
	ASCII "M" ; 12935
	DB 0C5h, 0CEh ; 12936
	ASCII "D" ; 12938
	DB 18h, 0CEh ; 12939
	ASCII "L" ; 1293b
	DB 19h, 0CFh, 0ECh, 0F8h, 0B0h, 02h, 0B1h, 08h ; 1293c
	DB 0F2h ; 12944
	ASCII "c}" ; 12945
	DB 0F8h, 0B0h, 04h, 0B1h, 08h, 0F2h, 5Bh, 7Dh ; 12947
	DB 0F8h, 0C4h, 13h, 0ADh, 0CEh ; 1294f
	ASCII "D" ; 12954
	DB 1Ah, 0CEh ; 12955
	ASCII "L" ; 12957
	DB 1Bh, 0F8h, 0B0h, 19h, 0F1h ; 12958
	ASCII "W" ; 1295d
	DB 0B0h, 18h, 0F1h ; 1295e
	ASCII "S" ; 12961
	DB 0B0h, 17h, 0F1h ; 12962
	ASCII "O" ; 12965
	DB 0B0h, 0Bh, 0F1h ; 12966
	ASCII "K" ; 12969
	DB 0B0h, 14h, 0F1h ; 1296a
	ASCII "G" ; 1296d
	DB 0B0h, 15h, 0F1h ; 1296e
	ASCII "C" ; 12971
	DB 0B0h, 0Ch, 0F1h, 3Fh, 0B0h, 0Ah, 0F1h, 3Bh ; 12972
	DB 0B0h, 10h, 0F1h ; 1297a
	ASCII "7" ; 1297d
	DB 0B0h, 11h, 0F1h ; 1297e
	ASCII "3" ; 12981
	DB 0B0h, 03h, 0F1h, 2Fh, 0B0h, 0Fh, 0F1h, 2Bh ; 12982
	DB 0B0h, 0Eh, 0F1h, 27h, 0B0h, 09h, 0F1h, 23h ; 1298a
	DB 0B0h, 0Dh, 0F1h, 1Fh, 0B0h, 04h, 0F1h, 1Bh ; 12992
	DB 0B0h, 08h, 0F1h, 17h, 0B0h, 06h, 0F1h, 13h ; 1299a
	DB 0B0h, 07h, 0F1h, 0Fh, 0B0h, 05h, 0F1h, 0Bh ; 129a2
	DB 0B0h, 01h, 0F1h, 07h, 0B0h, 16h, 0F1h, 03h ; 129aa
	DB 0B0h, 00h, 0CEh, 0D4h, 1Ch, 1Bh, 0F8h, 0CEh ; 129b2
	DB 0D0h, 0DBh, 1Ah, 28h, 0E7h, 06h, 0C3h, 08h ; 129ba
	DB 00h, 0F1h, 13h, 0CEh, 0C4h, 01h, 0F2h, 7Ch ; 129c2
	DB 00h, 0E6h, 0Bh, 0CEh, 0D0h, 0DCh, 1Ah, 80h ; 129ca
	DB 00h, 0B1h, 00h, 0CFh ; 129d2
	ASCII "B" ; 129d6
	DB 0CFh, 0DBh, 0F8h, 0B8h, 12h, 1Bh, 0F2h, 0A3h ; 129d7
	DB 0CFh, 0F8h, 0CEh, 0D0h, 23h, 1Bh, 0CEh, 0D4h ; 129df
	DB 13h, 1Bh, 0F2h, 0EFh, 0FFh, 0F8h, 0CEh, 0C4h ; 129e7
	DB 01h, 0F2h ; 129ef
	ASCII "B" ; 129f1
	DB 0F0h, 0E6h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh ; 129f2
	DB 0F8h, 0F2h, 0FEh, 05h, 0F2h, 0FBh, 05h, 0CEh ; 129fa
	DB 0C4h, 01h, 0F2h, 40h, 0F0h, 0E6h, 04h, 0C3h ; 12a02
	DB 02h, 00h, 0CFh, 0DBh, 0F8h, 0F2h, 0EAh, 05h ; 12a0a
	DB 0F2h, 0E7h, 05h, 0F2h, 0E4h, 05h, 0CEh, 0C4h ; 12a12
	DB 01h, 0F2h, 3Bh, 0F0h, 0E6h, 07h, 0C3h, 02h ; 12a1a
	DB 00h, 0CFh, 0DBh, 0F8h, 0F2h, 0D3h, 05h, 0F2h ; 12a22
	DB 0D0h, 05h, 0F2h, 0CDh, 05h, 0F2h, 0CAh, 05h ; 12a2a
	DB 0CFh, 0DBh, 0F8h, 0CEh, 0C4h, 01h, 0F2h, 2Fh ; 12a32
	DB 0F0h, 0E6h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh ; 12a3a
	DB 0F8h, 0F2h, 0B6h, 05h, 0CEh, 0C4h, 01h, 0F2h ; 12a42
	DB 2Fh, 0F0h, 0E6h, 04h, 0C3h, 02h, 00h, 0CFh ; 12a4a
	DB 0DBh, 0F8h, 0F2h, 0A5h, 05h, 0F2h, 0A2h, 05h ; 12a52
	DB 0CEh, 0C4h, 01h, 0F2h, 2Ch, 0F0h, 0E6h, 07h ; 12a5a
	DB 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h, 0F2h, 91h ; 12a62
	DB 05h, 0F2h, 8Eh, 05h, 0F2h, 8Bh, 05h, 0CFh ; 12a6a
	DB 0DBh, 0F8h, 0CEh, 0D0h, 0DCh, 1Ah ; 12a72
	ASCII "2" ; 12a78
	DB 02h, 0E7h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh ; 12a79
	DB 0F8h, 0CEh, 0D0h, 13h, 1Bh, 0CEh, 0D1h, 1Fh ; 12a81
	DB 1Bh, 81h ; 12a89
	ASCII "1" ; 12a8b
	DB 0E5h, 19h, 02h, 10h ; 12a8c
	ASCII "1" ; 12a90
	DB 0E4h, 27h, 0CEh, 0D0h, 12h, 1Bh, 0CEh, 0D1h ; 12a91
	DB 1Eh, 1Bh, 81h ; 12a99
	ASCII "1" ; 12a9c
	DB 0E5h ; 12a9d
	ASCII "F" ; 12a9e
	DB 02h, 10h ; 12a9f
	ASCII "1" ; 12aa1
	DB 0E4h, 3Eh, 0F1h, 2Dh, 0CEh, 0D0h, 12h, 1Bh ; 12aa2
	DB 0CEh, 0D1h, 1Eh, 1Bh, 81h ; 12aaa
	ASCII "1" ; 12aaf
	DB 0E5h, 2Dh, 02h, 10h ; 12ab0
	ASCII "1" ; 12ab4
	DB 0E4h, 22h, 0F1h, 17h, 0CEh, 0D0h, 12h, 1Bh ; 12ab5
	DB 0CEh, 0D1h, 1Eh, 1Bh, 81h ; 12abd
	ASCII "1" ; 12ac2
	DB 0E5h, 17h, 02h, 10h ; 12ac3
	ASCII "1" ; 12ac7
	DB 0E4h, 0Ch, 0F1h, 01h, 0C3h, 02h, 00h, 0C3h ; 12ac8
	DB 02h, 00h, 0C3h, 02h, 00h, 0C3h, 02h, 00h ; 12ad0
	DB 0C3h, 02h, 00h, 0C3h, 02h, 00h, 0C3h, 02h ; 12ad8
	DB 00h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h, 0CEh ; 12ae0
	DB 0D0h, 0D8h, 1Ah ; 12ae8
	ASCIZ "2" ; 12aeb
	DB 0E7h, 17h, 0CEh, 0D0h, 20h, 1Bh ; 12aed
	ASCII "2" ; 12af3
	DB 03h, 0E6h, 0Fh ; 12af4
	ASCII "2" ; 12af7
	DB 02h, 0E6h, 0Bh, 0F2h, 0Ch, 01h, 0E7h, 1Ah ; 12af8
	DB 0F2h ; 12b00
	ASCIZ "e" ; 12b01
	DB 0E7h, 15h, 0CEh, 0D0h, 13h, 1Bh, 0CEh, 0D1h ; 12b03
	DB 1Fh, 1Bh ; 12b0b
	ASCII "1" ; 12b0d
	DB 0E5h, 06h, 02h, 10h ; 12b0e
	ASCII "1" ; 12b12
	DB 0E5h, 05h, 0B0h, 02h, 0F1h ; 12b13
	ASCII "G" ; 12b18
	DB 0CEh, 0C4h, 01h, 0F2h, 28h, 0FFh, 0E7h, 0Eh ; 12b19
	DB 0B0h, 00h, 0CEh, 0D4h, 20h, 1Bh, 0F2h ; 12b21
	ASCII "S" ; 12b28
	DB 04h, 0B0h, 01h, 0F1h ; 12b29
	ASCII "2" ; 12b2d
	DB 0CEh, 0C4h, 01h, 0F2h, 0EFh, 0EEh, 0E7h, 0F2h ; 12b2e
	DB 0F2h, 0C8h, 04h, 0F2h ; 12b36
	ASCII "A" ; 12b3a
	DB 04h, 0CEh, 0C4h, 01h, 0F2h, 0CFh, 0EEh, 0E6h ; 12b3b
	DB 17h, 0CEh, 0D0h, 12h, 1Bh, 0CEh, 0D1h, 1Eh ; 12b43
	DB 1Bh, 11h, 0CEh, 88h, 01h, 0CEh, 0D4h, 1Eh ; 12b4b
	DB 1Bh, 0B0h, 06h, 0CEh, 0D4h, 20h, 1Bh, 0F2h ; 12b53
	DB 20h, 04h, 0B0h, 00h, 00h, 0B1h, 00h, 0CFh ; 12b5b
	ASCII "B" ; 12b63
	DB 0CFh, 0DBh, 0F8h, 0CEh, 0D0h, 0D7h, 1Ah ; 12b64
	ASCIZ "2" ; 12b6b
	DB 0E6h ; 12b6d
	ASCII "i2" ; 12b6e
	DB 01h, 0E6h ; 12b70
	ASCII "3" ; 12b72
	DB 0CEh, 0D0h, 1Fh, 1Bh ; 12b73
	ASCII "2+" ; 12b77
	DB 0E4h, 28h ; 12b79
	ASCII "27" ; 12b7b
	DB 0E5h, 24h, 0CEh, 0D0h, 1Eh, 1Bh ; 12b7d
	ASCII "2" ; 12b83
	DB 17h, 0E4h, 1Ch ; 12b84
	ASCII "2+" ; 12b87
	DB 0E5h, 18h, 0CEh, 0D0h, 23h, 1Bh, 0CEh, 0D4h ; 12b89
	DB 1Fh, 1Bh, 0B0h, 1Ch, 0CEh, 0D4h, 1Eh, 1Bh ; 12b91
	DB 0B0h, 02h, 0CEh, 0D4h, 20h, 1Bh, 9Ch, 0FEh ; 12b99
	DB 0F8h, 9Dh, 01h, 0F8h, 0CEh, 0D0h, 1Fh, 1Bh ; 12ba1
	ASCII "2%" ; 12ba9
	DB 0E4h, 28h ; 12bab
	ASCII "20" ; 12bad
	DB 0E5h, 24h, 0CEh, 0D0h, 1Eh, 1Bh ; 12baf
	ASCII "2" ; 12bb5
	DB 1Dh, 0E4h, 1Ch ; 12bb6
	ASCII "2-" ; 12bb9
	DB 0E5h, 18h, 0CEh, 0D0h, 23h, 1Bh, 0CEh, 0D4h ; 12bbb
	DB 1Fh, 1Bh, 0B0h, 1Fh, 0CEh, 0D4h, 1Eh, 1Bh ; 12bc3
	DB 0B0h, 02h, 0CEh, 0D4h, 20h, 1Bh, 9Ch, 0FEh ; 12bcb
	DB 0F8h, 9Dh, 01h, 0F8h, 0CEh, 0D0h, 1Fh, 1Bh ; 12bd3
	ASCII "2" ; 12bdb
	DB 1Eh, 0E4h, 28h ; 12bdc
	ASCII "2/" ; 12bdf
	DB 0E5h, 24h, 0CEh, 0D0h, 1Eh, 1Bh ; 12be1
	ASCII "2!" ; 12be7
	DB 0E4h, 1Ch ; 12be9
	ASCII "2," ; 12beb
	DB 0E5h, 18h, 0CEh, 0D0h, 23h, 1Bh, 0CEh, 0D4h ; 12bed
	DB 1Fh, 1Bh, 0B0h, 20h, 0CEh, 0D4h, 1Eh, 1Bh ; 12bf5
	DB 0B0h, 02h, 0CEh, 0D4h, 20h, 1Bh, 9Ch, 0FEh ; 12bfd
	DB 0F8h, 9Dh, 01h, 0F8h, 0CEh, 0D0h, 0D7h, 1Ah ; 12c05
	ASCII "2" ; 12c0d
	DB 01h, 0E6h ; 12c0e
	ASCII "M2" ; 12c10
	DB 02h, 0EEh, 8Fh, 00h, 0CEh, 0D0h, 1Fh, 1Bh ; 12c12
	ASCII "2" ; 12c1a
	DB 18h, 0E4h, 3Dh ; 12c1b
	ASCII "29" ; 12c1e
	DB 0E5h ; 12c20
	ASCII "9" ; 12c21
	DB 0CEh, 0D0h, 1Eh, 1Bh ; 12c22
	ASCII "28" ; 12c26
	DB 0E4h ; 12c28
	ASCII "12P" ; 12c29
	DB 0E5h, 2Dh, 0CEh, 0D0h, 13h, 1Bh, 0CEh, 0D1h ; 12c2c
	DB 23h, 1Bh ; 12c34
	ASCII "1" ; 12c36
	DB 0E6h, 13h ; 12c37
	ASCII "2" ; 12c39
	DB 18h, 0E7h, 1Eh, 0B0h, 3Fh, 0CEh, 0D4h, 1Eh ; 12c3a
	DB 1Bh, 0B0h, 04h, 0CEh, 0D4h, 20h, 1Bh, 0F1h ; 12c42
	DB 0Dh, 0B0h, 3Eh, 0CEh, 0D4h, 1Eh, 1Bh, 0B0h ; 12c4a
	DB 01h, 0CEh, 0D4h, 20h, 1Bh, 9Ch, 0FEh, 0F8h ; 12c52
	DB 9Dh, 01h, 0F8h, 0CEh, 0D0h, 1Fh, 1Bh ; 12c5a
	ASCII "2" ; 12c61
	DB 10h, 0E4h, 3Dh ; 12c62
	ASCII "29" ; 12c65
	DB 0E5h ; 12c67
	ASCII "9" ; 12c68
	DB 0CEh, 0D0h, 1Eh, 1Bh ; 12c69
	ASCII "20" ; 12c6d
	DB 0E4h ; 12c6f
	ASCII "12P" ; 12c70
	DB 0E5h, 2Dh, 0CEh, 0D0h, 13h, 1Bh, 0CEh, 0D1h ; 12c73
	DB 23h, 1Bh ; 12c7b
	ASCII "1" ; 12c7d
	DB 0E6h, 13h ; 12c7e
	ASCII "2" ; 12c80
	DB 10h, 0E7h, 1Eh, 0B0h, 40h, 0CEh, 0D4h, 1Eh ; 12c81
	DB 1Bh, 0B0h, 04h, 0CEh, 0D4h, 20h, 1Bh, 0F1h ; 12c89
	DB 0Dh, 0B0h, 40h, 0CEh, 0D4h, 1Eh, 1Bh, 0B0h ; 12c91
	DB 01h, 0CEh, 0D4h, 20h, 1Bh, 9Ch, 0FEh, 0F8h ; 12c99
	DB 9Dh, 01h, 0F8h, 0CEh, 0D0h, 1Fh, 1Bh ; 12ca1
	ASCII "2" ; 12ca8
	DB 18h, 0E4h, 3Dh ; 12ca9
	ASCII "29" ; 12cac
	DB 0E5h ; 12cae
	ASCII "9" ; 12caf
	DB 0CEh, 0D0h, 1Eh, 1Bh ; 12cb0
	ASCII "20" ; 12cb4
	DB 0E4h ; 12cb6
	ASCII "12P" ; 12cb7
	DB 0E5h, 2Dh, 0CEh, 0D0h, 13h, 1Bh, 0CEh, 0D1h ; 12cba
	DB 23h, 1Bh ; 12cc2
	ASCII "1" ; 12cc4
	DB 0E6h, 13h ; 12cc5
	ASCII "2" ; 12cc7
	DB 18h, 0E7h, 1Eh, 0B0h ; 12cc8
	ASCII "A" ; 12ccc
	DB 0CEh, 0D4h, 1Eh, 1Bh, 0B0h, 04h, 0CEh, 0D4h ; 12ccd
	DB 20h, 1Bh, 0F1h, 0Dh, 0B0h, 2Eh, 0CEh, 0D4h ; 12cd5
	DB 1Eh, 1Bh, 0B0h, 01h, 0CEh, 0D4h, 20h, 1Bh ; 12cdd
	DB 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h, 0CEh, 0D0h ; 12ce5
	DB 0DCh, 1Ah ; 12ced
	ASCIZ "2" ; 12cef
	DB 0E6h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h ; 12cf1
	DB 0CEh, 0D0h, 0D7h, 1Ah ; 12cf9
	ASCII "2" ; 12cfd
	DB 02h, 0E7h, 17h, 0CEh, 0D0h, 13h, 1Bh, 0CEh ; 12cfe
	DB 0D1h, 23h, 1Bh ; 12d06
	ASCII "1" ; 12d09
	DB 0E7h, 0Ch, 0CEh, 0D0h, 20h, 1Bh ; 12d0a
	ASCII "2" ; 12d10
	DB 02h, 0E7h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh ; 12d11
	DB 0F8h, 0CEh, 0D0h, 1Eh, 1Bh, 0CEh, 0D1h, 12h ; 12d19
	DB 1Bh, 11h, 0E4h, 04h, 0C3h, 02h, 00h, 0CFh ; 12d21
	DB 0DBh, 0F8h, 0CEh, 0D0h, 1Eh, 1Bh, 0CEh, 0D1h ; 12d29
	DB 12h, 1Bh, 11h, 0E6h, 09h, 0E4h, 04h, 0C3h ; 12d31
	DB 02h, 00h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h ; 12d39
	DB 0CEh, 0C4h, 01h, 0F2h, 89h, 0EDh, 0E7h, 06h ; 12d41
	DB 0F2h, 0ABh, 02h, 0F1h, 04h, 0C3h, 02h, 00h ; 12d49
	DB 0CFh, 0DBh, 0F8h, 0B0h, 00h, 0CEh, 0D4h, 14h ; 12d51
	DB 1Bh, 0CEh, 0C4h, 03h, 0F2h, 2Dh, 0DCh, 0B0h ; 12d59
	DB 28h, 0CEh, 0D1h, 23h, 1Bh, 0BCh, 12h, 1Bh ; 12d61
	DB 0F2h, 17h, 0CCh, 0F8h, 0B0h, 01h, 0CEh, 0D4h ; 12d69
	DB 14h, 1Bh, 0CEh, 0C4h, 03h, 0F2h, 14h, 0DCh ; 12d71
	DB 0C4h ; 12d79
	ASCII "y" ; 12d7a
	DB 0ACh, 0CEh, 0C4h, 02h, 0F2h, 0F2h, 00h, 0F8h ; 12d7b
	DB 0CEh, 40h, 02h, 0CEh ; 12d83
	ASCII "H" ; 12d87
	DB 03h, 0CEh, 0C4h, 02h, 0F2h, 0E5h, 00h, 0F8h ; 12d88
	DB 0C4h, 9Bh, 0ACh, 0CEh, 0C4h, 02h, 0F2h, 0DBh ; 12d90
	DB 00h, 0F8h, 0CEh, 40h, 14h, 0CEh ; 12d98
	ASCII "H" ; 12d9e
	DB 15h, 0D4h ; 12d9f
	ASCII "8" ; 12da1
	DB 0C1h, 0E4h, 09h, 0D4h, 0C0h, 0C1h, 0E5h, 04h ; 12da2
	DB 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h, 0CEh, 0D0h ; 12daa
	DB 0DFh, 1Ah ; 12db2
	ASCII "2" ; 12db4
	DB 19h, 0E4h, 0Bh, 0C3h, 02h, 00h ; 12db5
	ASCII "23" ; 12dbb
	DB 0E4h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h ; 12dbd
	DB 0A6h, 0A3h, 0CEh, 0C7h, 01h, 0C7h, 28h, 0AFh ; 12dc5
	DB 0CEh, 0D0h, 0D7h, 1Ah ; 12dcd
	ASCIZ "2" ; 12dd1
	DB 0E6h, 0Bh, 0C7h ; 12dd3
	ASCII "P" ; 12dd6
	DB 0AFh ; 12dd7
	ASCII "2" ; 12dd8
	DB 01h, 0E6h, 04h, 0C7h, 3Ch, 0AFh, 0C5h ; 12dd9
	ASCII "R" ; 12de0
	DB 1Bh, 0B1h, 14h ; 12de1
	ASCII "Gh" ; 12de4
	DB 93h, 91h, 0F5h, 0FBh ; 12de6
	ASCII "8" ; 12dea
	DB 0CEh, 0D4h ; 12deb
	ASCII "f" ; 12ded
	DB 1Bh, 0CEh, 0D4h ; 12dee
	ASCII "g" ; 12df1
	DB 1Bh, 0CEh, 0D0h, 0DFh, 1Ah, 0CEh, 0D1h, 0E1h ; 12df2
	DB 1Ah, 01h, 0B2h, 04h, 0CEh, 0D8h, 0CEh, 0D0h ; 12dfa
	DB 0E0h, 1Ah, 0CEh, 0D1h, 0E2h, 1Ah, 01h, 0B1h ; 12e02
	DB 00h, 0CFh, 20h, 0B0h, 40h, 0CEh, 0D9h, 82h ; 12e0a
	DB 0CEh, 0D6h ; 12e12
	ASCII "i" ; 12e14
	DB 1Bh ; 12e15
	ASCII "C" ; 12e16
	DB 0B2h, 19h, 0CEh, 0D8h, 0B0h, 10h, 0CEh, 0D9h ; 12e17
	DB 0CEh, 0D6h ; 12e1f
	ASCII "h" ; 12e21
	DB 1Bh ; 12e22
	ASCII "8" ; 12e23
	DB 0CEh ; 12e24
	ASCII "D" ; 12e25
	DB 16h, 0CEh, 0D0h, 0D7h, 1Ah ; 12e26
	ASCIZ "2" ; 12e2b
	DB 0E6h, 0Fh ; 12e2d
	ASCII "2" ; 12e2f
	DB 01h, 0E6h, 12h, 0CEh, 0D0h, 12h, 1Bh, 0CEh ; 12e30
	DB 0D1h, 23h, 1Bh, 0F1h, 0Ch, 0CEh, 0D1h, 13h ; 12e38
	DB 1Bh ; 12e40
	ASCII "8" ; 12e41
	DB 0F1h, 05h, 0B0h, 0FCh, 0B1h, 00h, 0F2h ; 12e42
	ASCII "8" ; 12e49
	DB 0CBh, 0ABh, 0AEh, 0F8h, 0CEh, 0D0h, 23h, 1Bh ; 12e4a
	DB 0CEh, 0D4h, 13h, 1Bh, 0CEh, 0D4h, 1Fh, 1Bh ; 12e52
	DB 0B0h, 28h, 0CEh, 0D4h, 1Eh, 1Bh ; 12e5a
	ASCII "8" ; 12e60
	DB 0CEh, 0D4h, 12h, 1Bh, 0B0h, 03h, 0CEh, 0D4h ; 12e61
	DB 20h, 1Bh, 0F8h, 0CEh ; 12e69
	ASCII "D" ; 12e6d
	DB 18h, 0CEh ; 12e6e
	ASCII "L" ; 12e70
	DB 19h, 0F8h, 0CEh ; 12e71
	ASCII "D" ; 12e74
	DB 1Ah, 0CEh ; 12e75
	ASCII "L" ; 12e77
	DB 1Bh, 0F8h, 0C4h, 0D9h, 81h, 0F2h, 0EDh, 0FFh ; 12e78
	DB 0F8h ; 12e80
	ASCII "8" ; 12e81
	DB 0CEh, 0D4h, 21h, 1Bh, 0C4h, 0Ch, 80h, 0F2h ; 12e82
	DB 0E1h, 0FFh, 0F8h ; 12e8a
	ASCII "8" ; 12e8d
	DB 0CEh, 0D4h, 21h, 1Bh, 0C4h, 5Eh, 96h, 0F2h ; 12e8e
	DB 0D5h, 0FFh, 0F8h ; 12e96
	ASCII "8" ; 12e99
	DB 0CEh, 0D4h, 21h, 1Bh, 0C4h, 86h, 96h, 0F2h ; 12e9a
	DB 0C9h, 0FFh, 0F8h ; 12ea2
	ASCII "8" ; 12ea5
	DB 0CEh, 0D4h, 21h, 1Bh, 0C4h, 0B8h, 96h, 0F2h ; 12ea6
	DB 0BDh, 0FFh, 0F8h, 0C4h, 0FCh, 96h, 0F2h, 0B6h ; 12eae
	DB 0FFh, 0F8h, 0CEh, 0C4h, 01h, 0F2h, 89h, 0FBh ; 12eb6
	DB 0E6h, 1Ah, 0CEh, 0D0h, 21h, 1Bh ; 12ebe
	ASCII "2" ; 12ec4
	DB 0FFh, 0E6h, 12h ; 12ec5
	ASCII "2" ; 12ec8
	DB 0FEh, 0E6h, 0Bh, 0C5h, 21h, 1Bh, 86h ; 12ec9
	ASCII "2" ; 12ed0
	DB 04h, 0E4h, 0Ch, 0F1h, 07h, 0C3h, 02h, 00h ; 12ed1
	DB 0C3h, 02h, 00h, 0C3h, 02h, 00h, 0CFh, 0DBh ; 12ed9
	DB 0F8h, 0CEh, 0C4h, 01h, 0F2h, 5Fh, 0FBh, 0E6h ; 12ee1
	DB 0Dh, 0CEh, 0C4h, 01h, 0F2h, 0FAh, 11h, 0F2h ; 12ee9
	DB 04h, 01h, 0F2h, 87h, 00h, 0F8h, 0C4h, 9Ch ; 12ef1
	DB 97h, 0F2h ; 12ef9
	ASCII "p" ; 12efb
	DB 0FFh, 0F8h, 0CEh, 0D0h, 13h, 1Bh ; 12efc
	ASCII "2" ; 12f02
	DB 17h, 0E5h, 0Dh, 0CEh, 0C4h, 01h, 0F2h, 0E5h ; 12f03
	DB 11h, 0F2h ; 12f0b
	ASCIZ "n" ; 12f0d
	DB 0F2h, 0E5h, 00h, 0F8h, 0C4h, 0A5h, 98h, 0F2h ; 12f0f
	ASCII "T" ; 12f17
	DB 0FFh, 0F8h, 0C4h, 0D5h, 98h, 0F2h ; 12f18
	ASCII "M" ; 12f1e
	DB 0FFh, 0F8h, 0C4h, 05h, 99h, 0F2h ; 12f1f
	ASCII "F" ; 12f25
	DB 0FFh, 0F8h, 0C4h ; 12f26
	ASCII "5" ; 12f29
	DB 99h, 0F2h, 3Fh, 0FFh, 0F8h, 0C4h, 83h, 98h ; 12f2a
	DB 0F2h ; 12f32
	ASCII "8" ; 12f33
	DB 0FFh, 0F8h, 0C4h ; 12f34
	ASCII "g" ; 12f37
	DB 99h, 0F2h ; 12f38
	ASCII "1" ; 12f3a
	DB 0FFh, 0F8h, 0CEh, 0C4h, 01h, 0F2h, 3Eh, 0EDh ; 12f3b
	DB 0E6h, 1Ah, 0CEh, 0D0h, 21h, 1Bh ; 12f43
	ASCII "2" ; 12f49
	DB 0FFh, 0E6h, 15h, 80h, 0CEh, 0D4h, 21h, 1Bh ; 12f4a
	DB 0C3h, 02h, 00h ; 12f52
	ASCII "2" ; 12f55
	DB 04h, 0E4h, 0Eh, 0C3h, 02h, 00h, 0F1h, 04h ; 12f56
	DB 0C3h, 06h, 00h ; 12f5e
	ASCII "8" ; 12f61
	DB 0CEh, 0D4h, 21h, 1Bh, 0CFh, 0DBh, 0F8h, 0B0h ; 12f62
	DB 7Fh, 0CEh, 0D4h, 13h, 1Bh, 0F8h, 0CEh, 0D0h ; 12f6a
	DB 23h, 1Bh, 0CEh, 0D4h, 13h, 1Bh, 0F2h, 60h ; 12f72
	DB 0FAh, 0F8h
; ---------------------- ; 12f7a
loc_0x012F7C:

	LD HL,#1ADAh ; 12f7c

	JRS loc_0x012F84

; ---------------------- ; 12f7f
loc_0x012F81:

	LD HL,#1ADBh ; 12f81

loc_0x012F84:

	LD A,[HL] ; 12f84
	OR A,A ; 12f85
	JRS Z,loc_0x012F89 ; 12f86

	DEC [HL] ; 12f88

loc_0x012F89:

	RET

; ---------------------- ; 12f89
	DB 0C5h, 0DCh, 1Ah, 0F1h, 0F6h, 0C5h, 0DDh, 1Ah ; 12f8a
	DB 0F1h, 10h, 0C5h, 0DFh, 1Ah, 0F1h, 0Bh, 0C5h ; 12f92
	DB 0E1h, 1Ah, 0F1h, 06h
; ---------------------- ; 12f9a
loc_0x012F9E:

	LD HL,#1AE3h ; 12f9e
	JRS loc_0x012FA3

; ---------------------- ; 12fa1
loc_0x012FA3:

	INC HL ; 12fa3
	LD A,[HL] ; 12fa4
	OR A,A ; 12fa5
	JRS NZ,loc_0x012FB4 ; 12fa6

	LD [HL],#03h ; 12fa8

	DEC HL ; 12faa

	LD A,[HL] ; 12fab
	OR A,A ; 12fac
	JRS NZ,loc_0x012FB4 ; 12fad

	INC HL ; 12faf
	LD [HL],#00h ; 12fb0

	JRS loc_0x012FB5

; ---------------------- ; 12fb2
loc_0x012FB4:

	DEC [HL] ; 12fb4

loc_0x012FB5:

	RET
; ---------------------- ; 12fb5
loc_0x012FB6:

	LD A,[1ADAh] ; 12fb6
	CP A,#28h ; 12fba
	JRS NC,loc_0x012FC3 ; 12fbc

	INC A ; 12fbe
	LD [1ADAh],A ; 12fbf

loc_0x012FC3:

	RET

; ---------------------- ; 12fc3
	DB 0C4h, 00h, 00h, 0BCh, 01h, 1Bh, 0CEh, 0D4h ; 12fc4
	DB 03h, 1Bh, 0CEh, 0D0h, 0DBh, 1Ah ; 12fcc
	ASCII "2" ; 12fd2
	DB 08h, 0E5h, 07h, 80h, 0CEh, 0D4h, 0DBh, 1Ah ; 12fd3
	DB 0F8h, 0B1h, 04h, 0CFh, 0B1h, 0F2h, 0BCh, 0FFh ; 12fdb
	DB 0CFh, 0B5h, 0F5h, 0F8h, 0F8h
; ---------------------- ; 12fe3
loc_0x012FE8:

	LD A,[1ADCh] ; 12fe8
	CP A,#02h ; 12fec
	JRS NC,loc_0x012FF5 ; 12fee

	INC A ; 12ff0
	LD [1ADCh],A ; 12ff1

loc_0x012FF5:

	RET

; ---------------------- ; 12ff5
	DB 0C5h, 0DDh, 1Ah, 0F1h, 0Eh, 0C5h, 0DFh, 1Ah ; 12ff6
	DB 0F1h, 09h, 0C5h, 0E1h, 1Ah, 0F1h, 04h, 0C5h ; 12ffe
	DB 0E3h, 1Ah ; 13006
	ASCII "E2@" ; 13008
	DB 0E5h, 10h, 91h ; 1300b
	ASCII "E2" ; 1300e
	DB 03h, 0E4h, 09h, 0B5h, 00h, 99h ; 13010
	ASCII "E2@" ; 13016
	DB 0E5h, 02h, 86h, 0F0h, 02h, 0F8h, 0B9h, 0E5h ; 13019
	DB 1Ah, 0D5h, 0FFh, 0FFh, 0E6h, 05h, 91h, 0BDh ; 13021
	DB 0E5h, 1Ah, 0F8h, 0C7h ; 13029
	ASCII "40" ; 1302d
	DB 0CEh, 0C7h, 01h, 0F1h, 25h, 0B6h, 0AFh, 0C4h ; 1302f
	DB 0AFh, 8Ah, 0AFh, 0F6h, 0AFh, 0FBh, 0AFh, 00h ; 13037
	DB 0B0h, 05h, 0B0h, 0C7h ; 1303f
	ASCII "J0" ; 13043
	DB 0CEh, 0C7h, 01h, 0F1h, 0Fh, 7Ch, 0AFh, 81h ; 13045
	DB 0AFh, 0E8h, 0AFh, 8Fh, 0AFh, 94h, 0AFh, 99h ; 1304d
	DB 0AFh, 9Eh, 0AFh, 0CEh, 0D0h, 2Dh, 1Bh, 00h ; 13055
	DB 0B1h, 00h, 0CFh ; 1305d
	ASCII "B" ; 13060
	DB 0CFh, 0D9h, 0CEh, 0D0h, 2Dh, 1Bh ; 13061
	ASCII "2" ; 13067
	DB 03h, 0E4h, 0Fh, 0B1h, 01h, 0CFh, 0B1h, 0A1h ; 13068
	DB 0F2h, 07h, 00h, 0A9h, 0CFh, 0B5h, 0F5h, 0F6h ; 13070
	DB 0F8h, 0F4h, 7Bh, 0A7h, 82h ; 13078
	ASCII "0" ; 1307d
	DB 8Eh ; 1307e
	ASCII "0" ; 1307f
	DB 9Ah ; 13080
	ASCII "0" ; 13081
	DB 0Ah, 00h ; 13082
	ASCII "T" ; 13084
	DB 0C2h, 0Ah, 00h ; 13085
	ASCII "X" ; 13088
	DB 0C2h, 0C1h, 99h, 82h ; 13089
	ASCII "0" ; 1308d
	DB 0Ah, 00h, 84h, 0C4h, 0Ah, 00h, 88h, 0C4h ; 1308e
	DB 0C1h, 99h, 8Eh ; 13096
	ASCII "0" ; 13099
	DB 0Ah, 00h, 14h, 0C6h, 0Ah, 00h, 18h, 0C6h ; 1309a
	DB 0C1h, 99h, 9Ah ; 130a2
	ASCII "0{" ; 130a5
	DB 0A7h, 0AEh ; 130a7
	ASCII "0" ; 130a9
	DB 0B4h ; 130aa
	ASCII "0" ; 130ab
	DB 0BAh ; 130ac
	ASCII "0" ; 130ad
	DB 01h, 00h ; 130ae
	ASCII "T" ; 130b0
	DB 0C2h, 8Eh, 99h, 01h, 00h, 84h, 0C4h, 8Eh ; 130b1
	DB 99h, 01h, 00h, 14h, 0C6h, 8Eh, 99h, 7Bh ; 130b9
	DB 0A7h, 0C8h ; 130c1
	ASCII "0" ; 130c3
	DB 0CEh ; 130c4
	ASCII "0" ; 130c5
	DB 0D4h ; 130c6
	ASCII "0" ; 130c7
	DB 06h, 00h, 5Ch, 0C2h, 8Eh, 99h, 06h, 00h ; 130c8
	DB 8Ch, 0C4h, 8Eh, 99h, 06h, 00h, 1Ch, 0C6h ; 130d0
	DB 8Eh, 99h, 7Bh, 0A7h, 0E2h ; 130d8
	ASCII "0" ; 130dd
	DB 0FCh ; 130de
	ASCII "0" ; 130df
	DB 16h ; 130e0
	ASCII "1" ; 130e1
	DB 02h, 00h ; 130e2
	ASCII "m" ; 130e4
	DB 1Ah, 02h, 00h ; 130e5
	ASCII "d" ; 130e8
	DB 0C2h, 03h, 00h ; 130e9
	ASCII "h" ; 130ec
	DB 0C2h, 03h, 00h ; 130ed
	ASCII "X" ; 130f0
	DB 0C2h, 03h, 00h ; 130f1
	ASCII "T" ; 130f4
	DB 0C2h, 03h, 00h ; 130f5
	ASCII "X" ; 130f8
	DB 0C2h, 8Eh, 99h, 02h, 00h ; 130f9
	ASCII "m" ; 130fe
	DB 1Ah, 02h, 00h, 94h, 0C4h, 03h, 00h, 98h ; 130ff
	DB 0C4h, 03h, 00h, 88h, 0C4h, 03h, 00h, 84h ; 13107
	DB 0C4h, 03h, 00h, 88h, 0C4h, 8Eh, 99h, 02h ; 1310f
	DB 00h ; 13117
	ASCII "m" ; 13118
	DB 1Ah, 02h, 00h, 24h, 0C6h, 03h, 00h, 28h ; 13119
	DB 0C6h, 03h, 00h, 18h, 0C6h, 03h, 00h, 14h ; 13121
	DB 0C6h, 03h, 00h, 18h, 0C6h, 8Eh, 99h, 7Bh ; 13129
	DB 0A7h ; 13131
	ASCII "81>1D1" ; 13132
	DB 01h, 00h ; 13138
	ASCII "l" ; 1313a
	DB 0C2h, 8Eh, 99h, 01h, 00h, 9Ch, 0C4h, 8Eh ; 1313b
	DB 99h, 01h, 00h, 2Ch, 0C6h, 8Eh, 99h, 7Bh ; 13143
	DB 0A7h ; 1314b
	ASCII "R1X1^1" ; 1314c
	DB 01h, 00h ; 13152
	ASCII "p" ; 13154
	DB 0C2h, 8Eh, 99h, 01h, 00h, 0A0h, 0C4h, 8Eh ; 13155
	DB 99h, 01h, 00h ; 1315d
	ASCII "0" ; 13160
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h ; 13161
	ASCII "l1r1x1" ; 13166
	DB 01h, 00h ; 1316c
	ASCII "t" ; 1316e
	DB 0C2h, 8Eh, 99h, 01h, 00h, 0A4h, 0C4h, 8Eh ; 1316f
	DB 99h, 01h, 00h ; 13177
	ASCII "4" ; 1317a
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h, 86h ; 1317b
	ASCII "1" ; 13181
	DB 8Ch ; 13182
	ASCII "1" ; 13183
	DB 92h ; 13184
	ASCII "1" ; 13185
	DB 01h, 00h ; 13186
	ASCII "x" ; 13188
	DB 0C2h, 8Eh, 99h, 01h, 00h, 0A8h, 0C4h, 8Eh ; 13189
	DB 99h, 01h, 00h ; 13191
	ASCII "8" ; 13194
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h, 0A0h ; 13195
	ASCII "1" ; 1319b
	DB 0A6h ; 1319c
	ASCII "1" ; 1319d
	DB 0ACh ; 1319e
	ASCII "1" ; 1319f
	DB 01h, 00h, 7Ch, 0C2h, 8Eh, 99h, 01h, 00h ; 131a0
	DB 0ACh, 0C4h, 8Eh, 99h, 01h, 00h, 3Ch, 0C6h ; 131a8
	DB 8Eh, 99h, 7Bh, 0A7h, 0BAh ; 131b0
	ASCII "1" ; 131b5
	DB 0C0h ; 131b6
	ASCII "1" ; 131b7
	DB 0C6h ; 131b8
	ASCII "1" ; 131b9
	DB 01h, 00h, 80h, 0C2h, 8Eh, 99h, 01h, 00h ; 131ba
	DB 0B0h, 0C4h, 8Eh, 99h, 01h, 00h, 40h, 0C6h ; 131c2
	DB 8Eh, 99h, 7Bh, 0A7h, 0D4h ; 131ca
	ASCII "1" ; 131cf
	DB 0DAh ; 131d0
	ASCII "1" ; 131d1
	DB 0E0h ; 131d2
	ASCII "1" ; 131d3
	DB 01h, 00h, 84h, 0C2h, 8Eh, 99h, 01h, 00h ; 131d4
	DB 0B4h, 0C4h, 8Eh, 99h, 01h, 00h ; 131dc
	ASCII "D" ; 131e2
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h, 0EEh ; 131e3
	ASCII "1" ; 131e9
	DB 0F4h ; 131ea
	ASCII "1" ; 131eb
	DB 0FAh ; 131ec
	ASCII "1" ; 131ed
	DB 01h, 00h, 88h, 0C2h, 8Eh, 99h, 01h, 00h ; 131ee
	DB 0B8h, 0C4h, 8Eh, 99h, 01h, 00h ; 131f6
	ASCII "H" ; 131fc
	DB 0C6h, 8Eh, 99h ; 131fd
	ASCII "q" ; 13200
	DB 9Ah, 7Bh, 0A7h, 0Ah ; 13201
	ASCII "2T2" ; 13205
	DB 9Eh ; 13208
	ASCII "2" ; 13209
	DB 08h, 00h, 8Ch, 0C2h, 08h, 00h ; 1320a
	ASCII "T" ; 13210
	DB 0C2h, 08h, 00h, 8Ch, 0C2h, 08h, 00h ; 13211
	ASCII "T" ; 13218
	DB 0C2h, 08h, 00h, 8Ch, 0C2h, 08h, 00h ; 13219
	ASCII "T" ; 13220
	DB 0C2h, 08h, 00h, 90h, 0C2h, 08h, 00h ; 13221
	ASCII "T" ; 13228
	DB 0C2h, 08h, 00h, 90h, 0C2h, 08h, 00h ; 13229
	ASCII "T" ; 13230
	DB 0C2h, 08h, 00h, 90h, 0C2h, 08h, 00h ; 13231
	ASCII "T" ; 13238
	DB 0C2h, 08h, 00h, 90h, 0C2h, 08h, 00h ; 13239
	ASCII "T" ; 13240
	DB 0C2h, 04h, 00h ; 13241
	ASCII "l" ; 13244
	DB 0C2h, 0Ch, 00h, 94h, 0C2h, 06h, 00h ; 13245
	ASCII "l" ; 1324c
	DB 0C2h, 14h, 00h, 0C0h, 0C2h, 8Eh, 99h, 08h ; 1324d
	DB 00h, 0BCh, 0C4h, 08h, 00h, 84h, 0C4h, 08h ; 13255
	DB 00h, 0BCh, 0C4h, 08h, 00h, 84h, 0C4h, 08h ; 1325d
	DB 00h, 0BCh, 0C4h, 08h, 00h, 84h, 0C4h, 08h ; 13265
	DB 00h, 0C0h, 0C4h, 08h, 00h, 84h, 0C4h, 08h ; 1326d
	DB 00h, 0C0h, 0C4h, 08h, 00h, 84h, 0C4h, 08h ; 13275
	DB 00h, 0C0h, 0C4h, 08h, 00h, 84h, 0C4h, 08h ; 1327d
	DB 00h, 0C0h, 0C4h, 08h, 00h, 84h, 0C4h, 04h ; 13285
	DB 00h, 9Ch, 0C4h, 0Ch, 00h, 0C4h, 0C4h, 06h ; 1328d
	DB 00h, 9Ch, 0C4h, 14h, 00h, 0F0h, 0C4h, 8Eh ; 13295
	DB 99h, 08h, 00h ; 1329d
	ASCII "L" ; 132a0
	DB 0C6h, 08h, 00h, 14h, 0C6h, 08h, 00h ; 132a1
	ASCII "L" ; 132a8
	DB 0C6h, 08h, 00h, 14h, 0C6h, 08h, 00h ; 132a9
	ASCII "L" ; 132b0
	DB 0C6h, 08h, 00h, 14h, 0C6h, 08h, 00h ; 132b1
	ASCII "P" ; 132b8
	DB 0C6h, 08h, 00h, 14h, 0C6h, 08h, 00h ; 132b9
	ASCII "P" ; 132c0
	DB 0C6h, 08h, 00h, 14h, 0C6h, 08h, 00h ; 132c1
	ASCII "P" ; 132c8
	DB 0C6h, 08h, 00h, 14h, 0C6h, 08h, 00h ; 132c9
	ASCII "P" ; 132d0
	DB 0C6h, 08h, 00h, 14h, 0C6h, 04h, 00h, 2Ch ; 132d1
	DB 0C6h, 0Ch, 00h ; 132d9
	ASCII "T" ; 132dc
	DB 0C6h, 06h, 00h, 2Ch, 0C6h, 14h, 00h, 84h ; 132dd
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h, 0F0h ; 132e5
	ASCII "2" ; 132eb
	DB 0F6h ; 132ec
	ASCII "2" ; 132ed
	DB 0FCh ; 132ee
	ASCII "2" ; 132ef
	DB 06h, 00h, 94h, 0C2h, 8Eh, 99h, 06h, 00h ; 132f0
	DB 0C4h, 0C4h, 8Eh, 99h, 06h, 00h ; 132f8
	ASCII "T" ; 132fe
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h, 0Ah ; 132ff
	ASCII "3*3J3" ; 13305
	DB 04h, 00h ; 1330a
	ASCII "T" ; 1330c
	DB 0C2h, 04h, 00h, 98h, 0C2h, 04h, 00h ; 1330d
	ASCII "T" ; 13314
	DB 0C2h, 04h, 00h, 98h, 0C2h, 04h, 00h ; 13315
	ASCII "T" ; 1331c
	DB 0C2h, 04h, 00h, 98h, 0C2h ; 1331d
	ASCIZ "2" ; 13322
	ASCII "T" ; 13324
	DB 0C2h, 0C1h, 99h, 0Ah ; 13325
	ASCII "3" ; 13329
	DB 04h, 00h, 0C8h, 0C4h, 04h, 00h, 0CCh, 0C4h ; 1332a
	DB 04h, 00h, 0C8h, 0C4h, 04h, 00h, 0CCh, 0C4h ; 13332
	DB 04h, 00h, 0C8h, 0C4h, 04h, 00h, 0CCh, 0C4h ; 1333a
	ASCIZ "2" ; 13342
	DB 0C8h, 0C4h, 0C1h, 99h, 2Ah ; 13344
	ASCII "3" ; 13349
	DB 04h, 00h ; 1334a
	ASCII "X" ; 1334c
	DB 0C6h, 04h, 00h, 5Ch, 0C6h, 04h, 00h ; 1334d
	ASCII "X" ; 13354
	DB 0C6h, 04h, 00h, 5Ch, 0C6h, 04h, 00h ; 13355
	ASCII "X" ; 1335c
	DB 0C6h ; 1335d
	ASCIZ "6" ; 1335e
	DB 5Ch, 0C6h, 0C1h, 99h ; 13360
	ASCII "J3{" ; 13364
	DB 0A7h ; 13367
	ASCII "n3" ; 13368
	DB 88h ; 1336a
	ASCII "3" ; 1336b
	DB 0A2h ; 1336c
	ASCII "3" ; 1336d
	DB 03h, 00h ; 1336e
	ASCII "X" ; 13370
	DB 0C2h, 03h, 00h ; 13371
	ASCII "T" ; 13374
	DB 0C2h, 03h, 00h ; 13375
	ASCII "X" ; 13378
	DB 0C2h, 03h, 00h ; 13379
	ASCII "h" ; 1337c
	DB 0C2h, 02h, 00h ; 1337d
	ASCII "d" ; 13380
	DB 0C2h, 02h, 00h, 60h, 0C2h, 8Eh, 99h, 03h ; 13381
	DB 00h, 88h, 0C4h, 03h, 00h, 84h, 0C4h, 03h ; 13389
	DB 00h, 88h, 0C4h, 03h, 00h, 98h, 0C4h, 02h ; 13391
	DB 00h, 94h, 0C4h, 02h, 00h, 90h, 0C4h, 8Eh ; 13399
	DB 99h, 03h, 00h, 18h, 0C6h, 03h, 00h, 14h ; 133a1
	DB 0C6h, 03h, 00h, 18h, 0C6h, 03h, 00h, 28h ; 133a9
	DB 0C6h, 02h, 00h, 24h, 0C6h, 02h, 00h, 20h ; 133b1
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h, 0C4h ; 133b9
	ASCII "3" ; 133bf
	DB 0E8h ; 133c0
	ASCII "3" ; 133c1
	DB 0Ch ; 133c2
	ASCII "4" ; 133c3
	DB 04h, 00h, 9Ch, 0C2h, 04h, 00h ; 133c4
	ASCII "T" ; 133ca
	DB 0C2h, 04h, 00h, 0A0h, 0C2h, 04h, 00h ; 133cb
	ASCII "T" ; 133d2
	DB 0C2h, 04h, 00h, 9Ch, 0C2h, 04h, 00h ; 133d3
	ASCII "T" ; 133da
	DB 0C2h, 04h, 00h, 0A0h, 0C2h, 05h, 00h ; 133db
	ASCII "T" ; 133e2
	DB 0C2h, 0C1h, 99h, 0BCh ; 133e3
	ASCII "3" ; 133e7
	DB 04h, 00h, 0D0h, 0C4h, 04h, 00h, 84h, 0C4h ; 133e8
	DB 04h, 00h, 0D4h, 0C4h, 04h, 00h, 84h, 0C4h ; 133f0
	DB 04h, 00h, 0D0h, 0C4h, 04h, 00h, 84h, 0C4h ; 133f8
	DB 04h, 00h, 0D4h, 0C4h, 05h, 00h, 84h, 0C4h ; 13400
	DB 0C1h, 99h, 0BCh ; 13408
	ASCII "3" ; 1340b
	DB 04h, 00h, 60h, 0C6h, 04h, 00h, 14h, 0C6h ; 1340c
	DB 04h, 00h ; 13414
	ASCII "d" ; 13416
	DB 0C6h, 04h, 00h, 14h, 0C6h, 04h, 00h, 60h ; 13417
	DB 0C6h, 04h, 00h, 14h, 0C6h, 04h, 00h ; 1341f
	ASCII "d" ; 13426
	DB 0C6h, 05h, 00h, 14h, 0C6h, 0C1h, 99h, 0BCh ; 13427
	ASCII "3{" ; 1342f
	DB 0A7h ; 13431
	ASCII "84D4P4" ; 13432
	DB 0Ah, 00h, 0B8h, 0C2h, 0Ah, 00h, 0BCh, 0C2h ; 13438
	DB 0C1h, 99h ; 13440
	ASCII "84" ; 13442
	DB 0Ah, 00h, 0E8h, 0C4h, 0Ah, 00h, 0ECh, 0C4h ; 13444
	DB 0C1h, 99h ; 1344c
	ASCII "D4" ; 1344e
	DB 0Ah, 00h, 7Ch, 0C6h, 0Ah, 00h, 80h, 0C6h ; 13450
	DB 0C1h, 99h ; 13458
	ASCII "P4" ; 1345a
	DB 0CEh, 0D0h ; 1345c
	ASCII "B" ; 1345e
	DB 16h, 96h, 01h, 0EBh, 0EEh, 00h, 0CEh, 0D0h ; 1345f
	DB 14h, 1Bh, 28h, 0E6h ; 13467
	ASCII "f" ; 1346b
	DB 0CEh, 0D0h, 0E7h, 1Ah, 96h, 01h, 0E6h, 5Eh ; 1346c
	DB 0B9h ; 13474
	ASCII "7" ; 13475
	DB 1Bh, 0C1h, 1Ah, 00h, 0CFh, 0C0h, 0D4h, 9Bh ; 13476
	DB 0ACh, 0E6h ; 1347e
	ASCII "V" ; 13480
	DB 0D4h, 13h, 0ADh, 0E6h ; 13481
	ASCII "V" ; 13485
	DB 0D4h, 15h, 0ADh, 0E6h ; 13486
	ASCII "c" ; 1348a
	DB 0D4h ; 1348b
	ASCII "S" ; 1348c
	DB 0ADh, 0E6h ; 1348d
	ASCII "c" ; 1348f
	DB 0D4h, 5Bh, 0ADh, 0E6h ; 13490
	ASCII "c" ; 13494
	DB 0D4h ; 13495
	ASCII "c" ; 13496
	DB 0ADh, 0E6h ; 13497
	ASCII "c" ; 13499
	DB 0D4h ; 1349a
	ASCII "k" ; 1349b
	DB 0ADh, 0E6h ; 1349c
	ASCII "c" ; 1349e
	DB 0D4h ; 1349f
	ASCII "s" ; 134a0
	DB 0ADh, 0E6h ; 134a1
	ASCII "c" ; 134a3
	DB 0D4h, 84h, 0ADh, 0E6h ; 134a4
	ASCII "c" ; 134a8
	DB 0D4h, 8Ch, 0ADh, 0E6h ; 134a9
	ASCII "c" ; 134ad
	DB 0D4h, 94h, 0ADh, 0E6h ; 134ae
	ASCII "c" ; 134b2
	DB 0D4h, 9Ch, 0ADh, 0E6h ; 134b3
	ASCII "c" ; 134b7
	DB 0D4h, 1Eh, 0AFh, 0E6h ; 134b8
	ASCII "c" ; 134bc
	DB 0D4h, 26h, 0AFh, 0E6h ; 134bd
	ASCII "c" ; 134c1
	DB 0D4h, 0F7h, 0B6h, 0E6h ; 134c2
	ASCII "c" ; 134c6
	DB 0D4h, 1Eh, 0B0h, 0E6h ; 134c7
	ASCII "c" ; 134cb
	DB 0D4h, 82h, 0AFh, 0E6h ; 134cc
	ASCII "c" ; 134d0
	DB 0C4h ; 134d1
	ASCII "r" ; 134d2
	DB 1Ah, 0F1h ; 134d3
	ASCII "c" ; 134d5
	DB 0C4h, 0DAh ; 134d6
	ASCII "0" ; 134d8
	DB 0F1h, 5Eh, 0CEh, 0D0h, 0DCh, 1Ah ; 134d9
	ASCIZ "2" ; 134df
	DB 0E7h, 06h, 0C4h ; 134e1
	ASCII "04" ; 134e4
	DB 0F1h ; 134e6
	ASCII "Q" ; 134e7
	DB 0C4h ; 134e8
	ASCII "z0" ; 134e9
	DB 0F1h ; 134eb
	ASCII "L" ; 134ec
	DB 0C4h, 0A6h ; 134ed
	ASCII "0" ; 134ef
	DB 0F1h ; 134f0
	ASCII "G" ; 134f1
	DB 0C4h, 0CCh ; 134f2
	ASCII "1" ; 134f4
	DB 0F1h ; 134f5
	ASCII "B" ; 134f6
	DB 0C4h ; 134f7
	ASCII "J1" ; 134f8
	DB 0F1h, 3Dh, 0C4h, 0E6h ; 134fa
	ASCII "1" ; 134fe
	DB 0F1h ; 134ff
	ASCII "8" ; 13500
	DB 0C4h ; 13501
	ASCII "d1" ; 13502
	DB 0F1h ; 13504
	ASCII "3" ; 13505
	DB 0C4h, 00h ; 13506
	ASCII "2" ; 13508
	DB 0F1h, 2Eh, 0C4h, 7Eh ; 13509
	ASCII "1" ; 1350d
	DB 0F1h, 29h, 0C4h, 98h ; 1350e
	ASCII "1" ; 13512
	DB 0F1h, 24h, 0C4h ; 13513
	ASCII "01" ; 13516
	DB 0F1h, 1Fh, 0C4h, 0B2h ; 13518
	ASCII "1" ; 1351c
	DB 0F1h, 1Ah, 0C4h, 0C0h ; 1351d
	ASCII "0" ; 13521
	DB 0F1h, 15h, 0C4h, 0E8h ; 13522
	ASCII "2" ; 13526
	DB 0F1h, 10h, 0C4h, 02h ; 13527
	ASCII "3" ; 1352b
	DB 0F1h, 0Bh, 0C4h, 0BCh ; 1352c
	ASCII "3" ; 13530
	DB 0F1h, 06h, 0C4h ; 13531
	ASCII "f3" ; 13534
	DB 0F1h, 01h, 0CEh ; 13536
	ASCII "P" ; 13539
	DB 18h, 0CEh ; 1353a
	ASCII "X" ; 1353c
	DB 19h, 0CFh ; 1353d
	ASCII "8" ; 1353f
	DB 0E6h, 0Ah, 0CEh ; 13540
	ASCII "D" ; 13543
	DB 18h, 0CEh ; 13544
	ASCII "L" ; 13546
	DB 19h, 0F2h, 05h, 0C4h, 0F8h, 0B5h, 0B5h, 5Ch ; 13547
	DB 0B4h ; 1354f
	ASCII "v" ; 13550
	DB 1Ah, 0CEh, 0D0h, 15h, 1Bh ; 13551
	ASCIZ "2" ; 13556
	DB 0E6h, 06h ; 13558
	ASCII "2" ; 1355a
	DB 03h, 0E6h, 02h, 0F8h, 0A6h, 0A3h, 0CEh, 40h ; 1355b
	DB 14h, 0CEh ; 13563
	ASCII "H" ; 13565
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 13566
	DB 0A2h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 0B1h ; 1356e
	DB 00h, 0C6h, 0A9h ; 13576
	ASCII "5" ; 13579
	DB 0CFh, 40h, 0CEh, 0C6h, 01h ; 1357a
	ASCII "G" ; 1357f
	DB 06h, 0CEh, 0D1h, 10h, 1Bh ; 13580
	ASCII "1" ; 13585
	DB 0E5h, 1Eh, 92h ; 13586
	ASCII "G" ; 13589
	DB 06h ; 1358a
	ASCII "1" ; 1358b
	DB 0E4h, 18h, 93h, 92h ; 1358c
	ASCII "G" ; 13590
	DB 06h, 0CEh, 0D1h, 11h, 1Bh ; 13591
	ASCII "1" ; 13596
	DB 0E5h, 0Dh, 92h ; 13597
	ASCII "G" ; 1359a
	DB 06h ; 1359b
	ASCII "1" ; 1359c
	DB 0E4h, 07h, 0C5h, 0E7h, 1Ah, 0CEh, 25h, 0FEh ; 1359d
	DB 0AAh, 0ABh, 0AEh, 0F8h, 28h, 2Dh, 0Dh, 14h ; 135a5
	DB 1Bh, 20h, 14h, 1Dh, 29h, 2Dh, 0Dh, 13h ; 135ad
	DB 0B2h, 21h, 0B3h, 10h, 0CEh, 0D0h, 0D7h, 1Ah ; 135b5
	DB 28h, 0E6h, 0Ch, 0B2h, 1Bh, 0B3h, 10h, 88h ; 135bd
	DB 0E6h, 05h, 0B2h, 1Fh, 0B3h, 10h, 0CFh, 0E1h ; 135c5
	DB 0F2h, 0B3h, 0C3h, 0F8h, 0CEh, 0D0h, 0D7h, 1Ah ; 135cd
	ASCII "2" ; 135d5
	DB 01h, 0E6h, 19h, 0CEh, 0D0h ; 135d6
	ASCII "q" ; 135db
	DB 16h, 96h, 01h, 0E6h, 11h, 0C5h, 0E7h, 1Ah ; 135dc
	DB 95h, 02h, 0E6h, 06h, 0CEh, 2Dh, 01h, 0F1h ; 135e4
	DB 04h, 0CEh, 2Dh, 02h, 0F8h, 0C5h, 0E7h, 1Ah ; 135ec
	DB 95h, 01h, 0E6h, 0Eh, 0CEh, 0D0h, 0D7h, 1Ah ; 135f4
	ASCII "2" ; 135fc
	DB 01h, 0E6h, 09h, 0CEh, 2Dh, 02h, 0F1h, 04h ; 135fd
	DB 0CEh, 2Dh, 01h, 0F8h, 0CEh, 0D0h, 0D8h, 1Ah ; 13605
	ASCIZ "2" ; 1360d
	DB 0E6h, 02h, 0F8h
; ---------------------- ; 1360f
loc_0x013612:

	LD HL,#1AE7h ; 13612
	AND [HL],#0DFh ; 13615

	LD A,[1671h] ; 13618
	BIT A,#01h ; 1361c
	JRS NZ,loc_0x013628 ; 1361e

loc_0x013620:

	BIT [HL],#04h ; 13620
	JRS NZ,loc_0x013628 ; 13622

	OR [HL],#04h ; 13624

	RET

; ---------------------- ; 13627
loc_0x013628:

	BIT [HL],#08h ; 13628
	JRS NZ,loc_0x013630 ; 1362a

	OR [HL],#08h ; 1362c

	RET

; ---------------------- ; 1362f
loc_0x013630:

	BIT [HL],#10h ; 13630
	JRS NZ,loc_0x013638 ; 13632

	OR [HL],#10h ; 13634

	RET

; ---------------------- ; 13637
loc_0x013638:

	BIT [HL],#20h ; 13638
	JRS NZ,loc_0x013641 ; 1363a

	OR [HL],#20h ; 1363c
	JRS loc_0x013620

; ---------------------- ; 1363f
loc_0x013641:

	RET

; ---------------------- ; 13641
	DB 7Bh, 0A7h ; 13642
	ASCII "J6V6b6" ; 13644
	DB 0Ah, 00h, 0C4h, 0C2h, 0Ah, 00h, 0C8h, 0C2h ; 1364a
	DB 0C1h, 99h ; 13652
	ASCII "J6" ; 13654
	DB 0Ah, 00h, 84h, 0C4h, 0Ah, 00h, 88h, 0C4h ; 13656
	DB 0C1h, 99h ; 1365e
	ASCII "V6" ; 13660
	DB 0Ah, 00h, 88h, 0C6h, 0Ah, 00h, 8Ch, 0C6h ; 13662
	DB 0C1h, 99h ; 1366a
	ASCII "b6{" ; 1366c
	DB 0A7h ; 1366f
	ASCII "v6|6" ; 13670
	DB 82h ; 13674
	ASCII "6" ; 13675
	DB 01h, 00h, 0C4h, 0C2h, 8Eh, 99h, 01h, 00h ; 13676
	DB 84h, 0C4h, 8Eh, 99h, 01h, 00h, 88h, 0C6h ; 1367e
	DB 8Eh, 99h, 7Bh, 0A7h, 90h ; 13686
	ASCII "6" ; 1368b
	DB 96h ; 1368c
	ASCII "6" ; 1368d
	DB 9Ch ; 1368e
	ASCII "6" ; 1368f
	DB 06h, 00h, 0CCh, 0C2h, 8Eh, 99h, 06h, 00h ; 13690
	DB 8Ch, 0C4h, 8Eh, 99h, 06h, 00h, 90h, 0C6h ; 13698
	DB 8Eh, 99h, 7Bh, 0A7h, 0AAh ; 136a0
	ASCII "6" ; 136a5
	DB 0C4h ; 136a6
	ASCII "6" ; 136a7
	DB 0DEh ; 136a8
	ASCII "6" ; 136a9
	DB 02h, 00h ; 136aa
	ASCII "m" ; 136ac
	DB 1Ah, 02h, 00h, 0D4h, 0C2h, 03h, 00h, 0D8h ; 136ad
	DB 0C2h, 03h, 00h, 0C8h, 0C2h, 03h, 00h, 0C4h ; 136b5
	DB 0C2h, 03h, 00h, 0C8h, 0C2h, 8Eh, 99h, 02h ; 136bd
	DB 00h ; 136c5
	ASCII "m" ; 136c6
	DB 1Ah, 02h, 00h, 94h, 0C4h, 03h, 00h, 98h ; 136c7
	DB 0C4h, 03h, 00h, 88h, 0C4h, 03h, 00h, 84h ; 136cf
	DB 0C4h, 03h, 00h, 88h, 0C4h, 8Eh, 99h, 02h ; 136d7
	DB 00h ; 136df
	ASCII "m" ; 136e0
	DB 1Ah, 02h, 00h, 98h, 0C6h, 03h, 00h, 9Ch ; 136e1
	DB 0C6h, 03h, 00h, 8Ch, 0C6h, 03h, 00h, 88h ; 136e9
	DB 0C6h, 03h, 00h, 8Ch, 0C6h, 8Eh, 99h, 7Bh ; 136f1
	DB 0A7h, 00h ; 136f9
	ASCII "7" ; 136fb
	DB 06h ; 136fc
	ASCII "7" ; 136fd
	DB 0Ch ; 136fe
	ASCII "7" ; 136ff
	DB 01h, 00h, 0DCh, 0C2h, 8Eh, 99h, 01h, 00h ; 13700
	DB 9Ch, 0C4h, 8Eh, 99h, 01h, 00h, 0A0h, 0C6h ; 13708
	DB 8Eh, 99h, 7Bh, 0A7h, 1Ah ; 13710
	ASCII "7 7&7" ; 13715
	DB 01h, 00h, 0E0h, 0C2h, 8Eh, 99h, 01h, 00h ; 1371a
	DB 0A0h, 0C4h, 8Eh, 99h, 01h, 00h, 0A4h, 0C6h ; 13722
	DB 8Eh, 99h, 7Bh, 0A7h ; 1372a
	ASCII "47:7@7" ; 1372e
	DB 01h, 00h, 0E4h, 0C2h, 8Eh, 99h, 01h, 00h ; 13734
	DB 0A4h, 0C4h, 8Eh, 99h, 01h, 00h, 0A8h, 0C6h ; 1373c
	DB 8Eh, 99h, 7Bh, 0A7h ; 13744
	ASCII "N7T7Z7" ; 13748
	DB 01h, 00h, 0E8h, 0C2h, 8Eh, 99h, 01h, 00h ; 1374e
	DB 0A8h, 0C4h, 8Eh, 99h, 01h, 00h, 0ACh, 0C6h ; 13756
	DB 8Eh, 99h, 7Bh, 0A7h ; 1375e
	ASCII "h7n7t7" ; 13762
	DB 01h, 00h, 0ECh, 0C2h, 8Eh, 99h, 01h, 00h ; 13768
	DB 0ACh, 0C4h, 8Eh, 99h, 01h, 00h, 0B0h, 0C6h ; 13770
	DB 8Eh, 99h, 7Bh, 0A7h, 82h ; 13778
	ASCII "7" ; 1377d
	DB 88h ; 1377e
	ASCII "7" ; 1377f
	DB 8Eh ; 13780
	ASCII "7" ; 13781
	DB 01h, 00h, 0F0h, 0C2h, 8Eh, 99h, 01h, 00h ; 13782
	DB 0B0h, 0C4h, 8Eh, 99h, 01h, 00h, 0B4h, 0C6h ; 1378a
	DB 8Eh, 99h, 7Bh, 0A7h, 9Ch ; 13792
	ASCII "7" ; 13797
	DB 0A2h ; 13798
	ASCII "7" ; 13799
	DB 0A8h ; 1379a
	ASCII "7" ; 1379b
	DB 01h, 00h, 0F4h, 0C2h, 8Eh, 99h, 01h, 00h ; 1379c
	DB 0B4h, 0C4h, 8Eh, 99h, 01h, 00h, 0B8h, 0C6h ; 137a4
	DB 8Eh, 99h, 7Bh, 0A7h, 0B6h ; 137ac
	ASCII "7" ; 137b1
	DB 0BCh ; 137b2
	ASCII "7" ; 137b3
	DB 0C2h ; 137b4
	ASCII "7" ; 137b5
	DB 01h, 00h, 0F8h, 0C2h, 8Eh, 99h, 01h, 00h ; 137b6
	DB 0B8h, 0C4h, 8Eh, 99h, 01h, 00h, 0BCh, 0C6h ; 137be
	DB 8Eh, 99h ; 137c6
	ASCII "q" ; 137c8
	DB 9Ah, 7Bh, 0A7h, 0D2h ; 137c9
	ASCII "7" ; 137cd
	DB 1Ch ; 137ce
	ASCII "8f8" ; 137cf
	DB 08h, 00h, 0FCh, 0C2h, 08h, 00h, 0C4h, 0C2h ; 137d2
	DB 08h, 00h, 0FCh, 0C2h, 08h, 00h, 0C4h, 0C2h ; 137da
	DB 08h, 00h, 0FCh, 0C2h, 08h, 00h, 0C4h, 0C2h ; 137e2
	DB 08h, 00h, 00h, 0C3h, 08h, 00h, 0C4h, 0C2h ; 137ea
	DB 08h, 00h, 00h, 0C3h, 08h, 00h, 0C4h, 0C2h ; 137f2
	DB 08h, 00h, 00h, 0C3h, 08h, 00h, 0C4h, 0C2h ; 137fa
	DB 08h, 00h, 00h, 0C3h, 08h, 00h, 0C4h, 0C2h ; 13802
	DB 04h, 00h, 0DCh, 0C2h, 0Ch, 00h, 04h, 0C3h ; 1380a
	DB 06h, 00h, 0DCh, 0C2h, 14h, 00h ; 13812
	ASCII "0" ; 13818
	DB 0C3h, 8Eh, 99h, 08h, 00h, 0BCh, 0C4h, 08h ; 13819
	DB 00h, 84h, 0C4h, 08h, 00h, 0BCh, 0C4h, 08h ; 13821
	DB 00h, 84h, 0C4h, 08h, 00h, 0BCh, 0C4h, 08h ; 13829
	DB 00h, 84h, 0C4h, 08h, 00h, 0C0h, 0C4h, 08h ; 13831
	DB 00h, 84h, 0C4h, 08h, 00h, 0C0h, 0C4h, 08h ; 13839
	DB 00h, 84h, 0C4h, 08h, 00h, 0C0h, 0C4h, 08h ; 13841
	DB 00h, 84h, 0C4h, 08h, 00h, 0C0h, 0C4h, 08h ; 13849
	DB 00h, 84h, 0C4h, 04h, 00h, 9Ch, 0C4h, 0Ch ; 13851
	DB 00h, 0C4h, 0C4h, 06h, 00h, 9Ch, 0C4h, 14h ; 13859
	DB 00h, 0F0h, 0C4h, 8Eh, 99h, 08h, 00h, 0C0h ; 13861
	DB 0C6h, 08h, 00h, 88h, 0C6h, 08h, 00h, 0C0h ; 13869
	DB 0C6h, 08h, 00h, 88h, 0C6h, 08h, 00h, 0C0h ; 13871
	DB 0C6h, 08h, 00h, 88h, 0C6h, 08h, 00h, 0C4h ; 13879
	DB 0C6h, 08h, 00h, 88h, 0C6h, 08h, 00h, 0C4h ; 13881
	DB 0C6h, 08h, 00h, 88h, 0C6h, 08h, 00h, 0C4h ; 13889
	DB 0C6h, 08h, 00h, 88h, 0C6h, 08h, 00h, 0C4h ; 13891
	DB 0C6h, 08h, 00h, 88h, 0C6h, 04h, 00h, 0A0h ; 13899
	DB 0C6h, 0Ch, 00h, 0C8h, 0C6h, 06h, 00h, 0A0h ; 138a1
	DB 0C6h, 14h, 00h, 0E4h, 0C6h, 8Eh, 99h, 7Bh ; 138a9
	DB 0A7h, 0B8h ; 138b1
	ASCII "8" ; 138b3
	DB 0BEh ; 138b4
	ASCII "8" ; 138b5
	DB 0C4h ; 138b6
	ASCII "8" ; 138b7
	DB 06h, 00h, 04h, 0C3h, 8Eh, 99h, 06h, 00h ; 138b8
	DB 0C4h, 0C4h, 8Eh, 99h, 06h, 00h, 0C8h, 0C6h ; 138c0
	DB 8Eh, 99h, 7Bh, 0A7h, 0D2h ; 138c8
	ASCII "8" ; 138cd
	DB 0F2h ; 138ce
	ASCII "8" ; 138cf
	DB 12h ; 138d0
	ASCII "9" ; 138d1
	DB 04h, 00h, 0C4h, 0C2h, 04h, 00h, 08h, 0C3h ; 138d2
	DB 04h, 00h, 0C4h, 0C2h, 04h, 00h, 08h, 0C3h ; 138da
	DB 04h, 00h, 0C4h, 0C2h, 04h, 00h, 08h, 0C3h ; 138e2
	ASCIZ "2" ; 138ea
	DB 0C4h, 0C2h, 0C1h, 99h, 0D2h ; 138ec
	ASCII "8" ; 138f1
	DB 04h, 00h, 0C8h, 0C4h, 04h, 00h, 0CCh, 0C4h ; 138f2
	DB 04h, 00h, 0C8h, 0C4h, 04h, 00h, 0CCh, 0C4h ; 138fa
	DB 04h, 00h, 0C8h, 0C4h, 04h, 00h, 0CCh, 0C4h ; 13902
	ASCIZ "2" ; 1390a
	DB 0C8h, 0C4h, 0C1h, 99h, 0F2h ; 1390c
	ASCII "8" ; 13911
	DB 04h, 00h, 0CCh, 0C6h, 04h, 00h, 0D0h, 0C6h ; 13912
	DB 04h, 00h, 0CCh, 0C6h, 04h, 00h, 0D0h, 0C6h ; 1391a
	DB 04h, 00h, 0CCh, 0C6h ; 13922
	ASCIZ "6" ; 13926
	DB 0D0h, 0C6h, 0C1h, 99h, 12h ; 13928
	ASCII "9{" ; 1392d
	DB 0A7h ; 1392f
	ASCII "69P9j9" ; 13930
	DB 03h, 00h, 0C8h, 0C2h, 03h, 00h, 0C4h, 0C2h ; 13936
	DB 03h, 00h, 0C8h, 0C2h, 03h, 00h, 0D8h, 0C2h ; 1393e
	DB 02h, 00h, 0D4h, 0C2h, 02h, 00h, 0D0h, 0C2h ; 13946
	DB 8Eh, 99h, 03h, 00h, 88h, 0C4h, 03h, 00h ; 1394e
	DB 84h, 0C4h, 03h, 00h, 88h, 0C4h, 03h, 00h ; 13956
	DB 98h, 0C4h, 02h, 00h, 94h, 0C4h, 02h, 00h ; 1395e
	DB 90h, 0C4h, 8Eh, 99h, 03h, 00h, 8Ch, 0C6h ; 13966
	DB 03h, 00h, 88h, 0C6h, 03h, 00h, 8Ch, 0C6h ; 1396e
	DB 03h, 00h, 9Ch, 0C6h, 02h, 00h, 98h, 0C6h ; 13976
	DB 02h, 00h, 94h, 0C6h, 8Eh, 99h, 7Bh, 0A7h ; 1397e
	DB 8Ch ; 13986
	ASCII "9" ; 13987
	DB 0B0h ; 13988
	ASCII "9" ; 13989
	DB 0D4h ; 1398a
	ASCII "9" ; 1398b
	DB 04h, 00h, 0Ch, 0C3h, 04h, 00h, 0C4h, 0C2h ; 1398c
	DB 04h, 00h, 10h, 0C3h, 04h, 00h, 0C4h, 0C2h ; 13994
	DB 04h, 00h, 0Ch, 0C3h, 04h, 00h, 0C4h, 0C2h ; 1399c
	DB 04h, 00h, 10h, 0C3h, 05h, 00h, 0C4h, 0C2h ; 139a4
	DB 0C1h, 99h, 84h ; 139ac
	ASCII "9" ; 139af
	DB 04h, 00h, 0D0h, 0C4h, 04h, 00h, 84h, 0C4h ; 139b0
	DB 04h, 00h, 0D4h, 0C4h, 04h, 00h, 84h, 0C4h ; 139b8
	DB 04h, 00h, 0D0h, 0C4h, 04h, 00h, 84h, 0C4h ; 139c0
	DB 04h, 00h, 0D4h, 0C4h, 05h, 00h, 84h, 0C4h ; 139c8
	DB 0C1h, 99h, 84h ; 139d0
	ASCII "9" ; 139d3
	DB 04h, 00h, 0D4h, 0C6h, 04h, 00h, 88h, 0C6h ; 139d4
	DB 04h, 00h, 0D8h, 0C6h, 04h, 00h, 88h, 0C6h ; 139dc
	DB 04h, 00h, 0D4h, 0C6h, 04h, 00h, 88h, 0C6h ; 139e4
	DB 04h, 00h, 0D8h, 0C6h, 05h, 00h, 88h, 0C6h ; 139ec
	DB 0C1h, 99h, 84h ; 139f4
	ASCII "9{" ; 139f7
	DB 0A7h, 00h, 3Ah, 0Ch, 3Ah, 18h, 3Ah, 0Ah ; 139f9
	DB 00h, 28h, 0C3h, 0Ah, 00h, 2Ch, 0C3h, 0C1h ; 13a01
	DB 99h, 00h, 3Ah, 0Ah, 00h ; 13a09
	ASCII "H" ; 13a0e
	DB 0C5h, 0Ah, 00h ; 13a0f
	ASCII "L" ; 13a12
	DB 0C5h, 0C1h, 99h, 0Ch, 3Ah, 0Ah, 00h, 0DCh ; 13a13
	DB 0C6h, 0Ah, 00h, 0E0h, 0C6h, 0C1h, 99h, 18h ; 13a1b
	DB 3Ah, 0CEh, 0D0h ; 13a23
	ASCII "B" ; 13a26
	DB 16h, 96h, 01h, 0EBh, 0EEh, 00h, 0CEh, 0D0h ; 13a27
	DB 14h, 1Bh, 28h, 0E6h ; 13a2f
	ASCII "f" ; 13a33
	DB 0CEh, 0D0h, 0E7h, 1Ah, 96h, 02h, 0E6h, 5Eh ; 13a34
	DB 0B9h ; 13a3c
	ASCII "7" ; 13a3d
	DB 1Bh, 0C1h, 1Ah, 00h, 0CFh, 0C0h, 0D4h, 9Bh ; 13a3e
	DB 0ACh, 0E6h ; 13a46
	ASCII "V" ; 13a48
	DB 0D4h, 13h, 0ADh, 0E6h ; 13a49
	ASCII "V" ; 13a4d
	DB 0D4h, 15h, 0ADh, 0E6h ; 13a4e
	ASCII "c" ; 13a52
	DB 0D4h ; 13a53
	ASCII "S" ; 13a54
	DB 0ADh, 0E6h ; 13a55
	ASCII "c" ; 13a57
	DB 0D4h, 5Bh, 0ADh, 0E6h ; 13a58
	ASCII "c" ; 13a5c
	DB 0D4h ; 13a5d
	ASCII "c" ; 13a5e
	DB 0ADh, 0E6h ; 13a5f
	ASCII "c" ; 13a61
	DB 0D4h ; 13a62
	ASCII "k" ; 13a63
	DB 0ADh, 0E6h ; 13a64
	ASCII "c" ; 13a66
	DB 0D4h ; 13a67
	ASCII "s" ; 13a68
	DB 0ADh, 0E6h ; 13a69
	ASCII "c" ; 13a6b
	DB 0D4h, 84h, 0ADh, 0E6h ; 13a6c
	ASCII "c" ; 13a70
	DB 0D4h, 8Ch, 0ADh, 0E6h ; 13a71
	ASCII "c" ; 13a75
	DB 0D4h, 94h, 0ADh, 0E6h ; 13a76
	ASCII "c" ; 13a7a
	DB 0D4h, 9Ch, 0ADh, 0E6h ; 13a7b
	ASCII "c" ; 13a7f
	DB 0D4h, 1Eh, 0AFh, 0E6h ; 13a80
	ASCII "c" ; 13a84
	DB 0D4h, 26h, 0AFh, 0E6h ; 13a85
	ASCII "c" ; 13a89
	DB 0D4h, 0F7h, 0B6h, 0E6h ; 13a8a
	ASCII "c" ; 13a8e
	DB 0D4h, 1Eh, 0B0h, 0E6h ; 13a8f
	ASCII "c" ; 13a93
	DB 0D4h, 82h, 0AFh, 0E6h ; 13a94
	ASCII "c" ; 13a98
	DB 0C4h ; 13a99
	ASCII "r" ; 13a9a
	DB 1Ah, 0F1h ; 13a9b
	ASCII "c" ; 13a9d
	DB 0C4h, 0A2h ; 13a9e
	ASCII "6" ; 13aa0
	DB 0F1h, 5Eh, 0CEh, 0D0h, 0DCh, 1Ah ; 13aa1
	ASCIZ "2" ; 13aa7
	DB 0E7h, 06h, 0C4h, 0F8h ; 13aa9
	ASCII "9" ; 13aad
	DB 0F1h ; 13aae
	ASCII "Q" ; 13aaf
	DB 0C4h ; 13ab0
	ASCII "B6" ; 13ab1
	DB 0F1h ; 13ab3
	ASCII "L" ; 13ab4
	DB 0C4h ; 13ab5
	ASCII "n6" ; 13ab6
	DB 0F1h ; 13ab8
	ASCII "G" ; 13ab9
	DB 0C4h, 94h ; 13aba
	ASCII "7" ; 13abc
	DB 0F1h ; 13abd
	ASCII "B" ; 13abe
	DB 0C4h, 12h ; 13abf
	ASCII "7" ; 13ac1
	DB 0F1h, 3Dh, 0C4h, 0AEh ; 13ac2
	ASCII "7" ; 13ac6
	DB 0F1h ; 13ac7
	ASCII "8" ; 13ac8
	DB 0C4h, 2Ch ; 13ac9
	ASCII "7" ; 13acb
	DB 0F1h ; 13acc
	ASCII "3" ; 13acd
	DB 0C4h, 0C8h ; 13ace
	ASCII "7" ; 13ad0
	DB 0F1h, 2Eh, 0C4h ; 13ad1
	ASCII "F7" ; 13ad4
	DB 0F1h, 29h, 0C4h, 60h ; 13ad6
	ASCII "7" ; 13ada
	DB 0F1h, 24h, 0C4h, 0F8h ; 13adb
	ASCII "6" ; 13adf
	DB 0F1h, 1Fh, 0C4h ; 13ae0
	ASCII "z7" ; 13ae3
	DB 0F1h, 1Ah, 0C4h, 88h ; 13ae5
	ASCII "6" ; 13ae9
	DB 0F1h, 15h, 0C4h, 0B0h ; 13aea
	ASCII "8" ; 13aee
	DB 0F1h, 10h, 0C4h, 0CAh ; 13aef
	ASCII "8" ; 13af3
	DB 0F1h, 0Bh, 0C4h, 84h ; 13af4
	ASCII "9" ; 13af8
	DB 0F1h, 06h, 0C4h, 2Eh ; 13af9
	ASCII "9" ; 13afd
	DB 0F1h, 01h, 0CEh ; 13afe
	ASCII "P" ; 13b01
	DB 18h, 0CEh ; 13b02
	ASCII "X" ; 13b04
	DB 19h, 0CFh ; 13b05
	ASCII "8" ; 13b07
	DB 0E6h, 0Ah, 0CEh ; 13b08
	ASCII "D" ; 13b0b
	DB 18h, 0CEh ; 13b0c
	ASCII "L" ; 13b0e
	DB 19h, 0F2h, 3Dh, 0BEh, 0F8h, 0B5h, 0B5h, 24h ; 13b0f
	DB 0BAh ; 13b17
	ASCII "v" ; 13b18
	DB 1Ah, 0CEh, 0D0h, 15h, 1Bh ; 13b19
	ASCIZ "2" ; 13b1e
	DB 0E6h, 06h ; 13b20
	ASCII "2" ; 13b22
	DB 03h, 0E6h, 02h, 0F8h, 0A6h, 0A3h, 0CEh, 40h ; 13b23
	DB 14h, 0CEh ; 13b2b
	ASCII "H" ; 13b2d
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 13b2e
	DB 0A2h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 0B1h ; 13b36
	DB 00h, 0C6h ; 13b3e
	ASCII "q;" ; 13b40
	DB 0CFh, 40h, 0CEh, 0C6h, 01h ; 13b42
	ASCII "G" ; 13b47
	DB 06h, 0CEh, 0D1h, 10h, 1Bh ; 13b48
	ASCII "1" ; 13b4d
	DB 0E5h, 1Eh, 92h ; 13b4e
	ASCII "G" ; 13b51
	DB 06h ; 13b52
	ASCII "1" ; 13b53
	DB 0E4h, 18h, 93h, 92h ; 13b54
	ASCII "G" ; 13b58
	DB 06h, 0CEh, 0D1h, 11h, 1Bh ; 13b59
	ASCII "1" ; 13b5e
	DB 0E5h, 0Dh, 92h ; 13b5f
	ASCII "G" ; 13b62
	DB 06h ; 13b63
	ASCII "1" ; 13b64
	DB 0E4h, 07h, 0C5h, 0E7h, 1Ah, 0CEh, 25h, 0FDh ; 13b65
	DB 0AAh, 0ABh, 0AEh, 0F8h, 1Fh, 23h, 0Dh, 14h ; 13b6d
	DB 1Bh, 20h, 14h, 1Dh, 1Fh, 23h, 0Fh, 16h ; 13b75
	DB 7Bh, 0A7h, 85h, 3Bh, 91h, 3Bh, 9Dh, 3Bh ; 13b7d
	DB 0Ah, 00h ; 13b85
	ASCII "4" ; 13b87
	DB 0C3h, 0Ah, 00h ; 13b88
	ASCII "8" ; 13b8b
	DB 0C3h, 0C1h, 99h, 85h, 3Bh, 0Ah, 00h, 0F4h ; 13b8c
	DB 0C4h, 0Ah, 00h, 0F8h, 0C4h, 0C1h, 99h, 91h ; 13b94
	DB 3Bh, 0Ah, 00h, 0E8h, 0C6h, 0Ah, 00h, 0ECh ; 13b9c
	DB 0C6h, 0C1h, 99h, 9Dh, 3Bh, 7Bh, 0A7h, 0B1h ; 13ba4
	DB 3Bh, 0B7h, 3Bh, 0BDh, 3Bh, 01h, 00h ; 13bac
	ASCII "4" ; 13bb3
	DB 0C3h, 8Eh, 99h, 01h, 00h, 0F4h, 0C4h, 8Eh ; 13bb4
	DB 99h, 01h, 00h, 0E8h, 0C6h, 8Eh, 99h, 7Bh ; 13bbc
	DB 0A7h, 0CBh, 3Bh, 0D1h, 3Bh, 0D7h, 3Bh, 06h ; 13bc4
	DB 00h, 3Ch, 0C3h, 8Eh, 99h, 06h, 00h, 0FCh ; 13bcc
	DB 0C4h, 8Eh, 99h, 06h, 00h, 0F0h, 0C6h, 8Eh ; 13bd4
	DB 99h, 7Bh, 0A7h, 0E5h, 3Bh, 0FFh, 3Bh, 19h ; 13bdc
	DB 3Ch, 02h, 00h ; 13be4
	ASCII "m" ; 13be7
	DB 1Ah, 02h, 00h ; 13be8
	ASCII "D" ; 13beb
	DB 0C3h, 03h, 00h ; 13bec
	ASCII "H" ; 13bef
	DB 0C3h, 03h, 00h ; 13bf0
	ASCII "8" ; 13bf3
	DB 0C3h, 03h, 00h ; 13bf4
	ASCII "4" ; 13bf7
	DB 0C3h, 03h, 00h ; 13bf8
	ASCII "8" ; 13bfb
	DB 0C3h, 8Eh, 99h, 02h, 00h ; 13bfc
	ASCII "m" ; 13c01
	DB 1Ah, 02h, 00h, 04h, 0C5h, 03h, 00h, 08h ; 13c02
	DB 0C5h, 03h, 00h, 0F8h, 0C4h, 03h, 00h, 0F4h ; 13c0a
	DB 0C4h, 03h, 00h, 0F8h, 0C4h, 8Eh, 99h, 02h ; 13c12
	DB 00h ; 13c1a
	ASCII "m" ; 13c1b
	DB 1Ah, 02h, 00h, 0F8h, 0C6h, 03h, 00h, 0FCh ; 13c1c
	DB 0C6h, 03h, 00h, 0ECh, 0C6h, 03h, 00h, 0E8h ; 13c24
	DB 0C6h, 03h, 00h, 0ECh, 0C6h, 8Eh, 99h, 7Bh ; 13c2c
	DB 0A7h, 3Bh, 3Ch ; 13c34
	ASCII "A<G<" ; 13c37
	DB 01h, 00h ; 13c3b
	ASCII "L" ; 13c3d
	DB 0C3h, 8Eh, 99h, 01h, 00h, 0Ch, 0C5h, 8Eh ; 13c3e
	DB 99h, 01h, 00h, 00h, 0C7h, 8Eh, 99h, 7Bh ; 13c46
	DB 0A7h ; 13c4e
	ASCII "U<[<a<" ; 13c4f
	DB 01h, 00h ; 13c55
	ASCII "P" ; 13c57
	DB 0C3h, 8Eh, 99h, 01h, 00h, 10h, 0C5h, 8Eh ; 13c58
	DB 99h, 01h, 00h, 04h, 0C7h, 8Eh, 99h, 7Bh ; 13c60
	DB 0A7h ; 13c68
	ASCII "o<u<{<" ; 13c69
	DB 01h, 00h ; 13c6f
	ASCII "T" ; 13c71
	DB 0C3h, 8Eh, 99h, 01h, 00h, 14h, 0C5h, 8Eh ; 13c72
	DB 99h, 01h, 00h, 08h, 0C7h, 8Eh, 99h, 7Bh ; 13c7a
	DB 0A7h, 89h, 3Ch, 8Fh, 3Ch, 95h, 3Ch, 01h ; 13c82
	DB 00h ; 13c8a
	ASCII "X" ; 13c8b
	DB 0C3h, 8Eh, 99h, 01h, 00h, 18h, 0C5h, 8Eh ; 13c8c
	DB 99h, 01h, 00h, 0Ch, 0C7h, 8Eh, 99h, 7Bh ; 13c94
	DB 0A7h, 0A3h, 3Ch, 0A9h, 3Ch, 0AFh, 3Ch, 01h ; 13c9c
	DB 00h, 5Ch, 0C3h, 8Eh, 99h, 01h, 00h, 1Ch ; 13ca4
	DB 0C5h, 8Eh, 99h, 01h, 00h, 10h, 0C7h, 8Eh ; 13cac
	DB 99h, 7Bh, 0A7h, 0BDh, 3Ch, 0C3h, 3Ch, 0C9h ; 13cb4
	DB 3Ch, 01h, 00h, 60h, 0C3h, 8Eh, 99h, 01h ; 13cbc
	DB 00h, 20h, 0C5h, 8Eh, 99h, 01h, 00h, 14h ; 13cc4
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0D7h, 3Ch, 0DDh ; 13ccc
	DB 3Ch, 0E3h, 3Ch, 01h, 00h ; 13cd4
	ASCII "d" ; 13cd9
	DB 0C3h, 8Eh, 99h, 01h, 00h, 24h, 0C5h, 8Eh ; 13cda
	DB 99h, 01h, 00h, 18h, 0C7h, 8Eh, 99h, 7Bh ; 13ce2
	DB 0A7h, 0F1h, 3Ch, 0F7h, 3Ch, 0FDh, 3Ch, 01h ; 13cea
	DB 00h ; 13cf2
	ASCII "h" ; 13cf3
	DB 0C3h, 8Eh, 99h, 01h, 00h, 28h, 0C5h, 8Eh ; 13cf4
	DB 99h, 01h, 00h, 1Ch, 0C7h, 8Eh, 99h, 7Bh ; 13cfc
	DB 0A7h, 0Bh, 3Dh ; 13d04
	ASCII "U=" ; 13d07
	DB 9Fh, 3Dh, 08h, 00h ; 13d09
	ASCII "l" ; 13d0d
	DB 0C3h, 08h, 00h ; 13d0e
	ASCII "4" ; 13d11
	DB 0C3h, 08h, 00h ; 13d12
	ASCII "l" ; 13d15
	DB 0C3h, 08h, 00h ; 13d16
	ASCII "4" ; 13d19
	DB 0C3h, 08h, 00h ; 13d1a
	ASCII "l" ; 13d1d
	DB 0C3h, 08h, 00h ; 13d1e
	ASCII "4" ; 13d21
	DB 0C3h, 08h, 00h ; 13d22
	ASCII "p" ; 13d25
	DB 0C3h, 08h, 00h ; 13d26
	ASCII "4" ; 13d29
	DB 0C3h, 08h, 00h ; 13d2a
	ASCII "p" ; 13d2d
	DB 0C3h, 08h, 00h ; 13d2e
	ASCII "4" ; 13d31
	DB 0C3h, 08h, 00h ; 13d32
	ASCII "p" ; 13d35
	DB 0C3h, 08h, 00h ; 13d36
	ASCII "4" ; 13d39
	DB 0C3h, 08h, 00h ; 13d3a
	ASCII "p" ; 13d3d
	DB 0C3h, 08h, 00h ; 13d3e
	ASCII "4" ; 13d41
	DB 0C3h, 04h, 00h ; 13d42
	ASCII "L" ; 13d45
	DB 0C3h, 0Ch, 00h ; 13d46
	ASCII "t" ; 13d49
	DB 0C3h, 06h, 00h ; 13d4a
	ASCII "L" ; 13d4d
	DB 0C3h, 14h, 00h, 0A0h, 0C3h, 8Eh, 99h, 08h ; 13d4e
	DB 00h, 2Ch, 0C5h, 08h, 00h, 0F4h, 0C4h, 08h ; 13d56
	DB 00h, 2Ch, 0C5h, 08h, 00h, 0F4h, 0C4h, 08h ; 13d5e
	DB 00h, 2Ch, 0C5h, 08h, 00h, 0F4h, 0C4h, 08h ; 13d66
	DB 00h ; 13d6e
	ASCII "0" ; 13d6f
	DB 0C5h, 08h, 00h, 0F4h, 0C4h, 08h, 00h ; 13d70
	ASCII "0" ; 13d77
	DB 0C5h, 08h, 00h, 0F4h, 0C4h, 08h, 00h ; 13d78
	ASCII "0" ; 13d7f
	DB 0C5h, 08h, 00h, 0F4h, 0C4h, 08h, 00h ; 13d80
	ASCII "0" ; 13d87
	DB 0C5h, 08h, 00h, 0F4h, 0C4h, 04h, 00h, 0Ch ; 13d88
	DB 0C5h, 0Ch, 00h ; 13d90
	ASCII "4" ; 13d93
	DB 0C5h, 06h, 00h, 0Ch, 0C5h, 14h, 00h ; 13d94
	ASCII "P" ; 13d9b
	DB 0C5h, 8Eh, 99h, 08h, 00h, 20h, 0C7h, 08h ; 13d9c
	DB 00h, 0E8h, 0C6h, 08h, 00h, 20h, 0C7h, 08h ; 13da4
	DB 00h, 0E8h, 0C6h, 08h, 00h, 20h, 0C7h, 08h ; 13dac
	DB 00h, 0E8h, 0C6h, 08h, 00h, 24h, 0C7h, 08h ; 13db4
	DB 00h, 0E8h, 0C6h, 08h, 00h, 24h, 0C7h, 08h ; 13dbc
	DB 00h, 0E8h, 0C6h, 08h, 00h, 24h, 0C7h, 08h ; 13dc4
	DB 00h, 0E8h, 0C6h, 08h, 00h, 24h, 0C7h, 08h ; 13dcc
	DB 00h, 0E8h, 0C6h, 04h, 00h, 00h, 0C7h, 0Ch ; 13dd4
	DB 00h, 28h, 0C7h, 06h, 00h, 00h, 0C7h, 14h ; 13ddc
	DB 00h ; 13de4
	ASCII "D" ; 13de5
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0F1h, 3Dh, 0F7h ; 13de6
	DB 3Dh, 0FDh, 3Dh, 06h, 00h ; 13dee
	ASCII "t" ; 13df3
	DB 0C3h, 8Eh, 99h, 06h, 00h ; 13df4
	ASCII "4" ; 13df9
	DB 0C5h, 8Eh, 99h, 06h, 00h, 28h, 0C7h, 8Eh ; 13dfa
	DB 99h, 7Bh, 0A7h, 0Bh, 3Eh, 2Bh, 3Eh ; 13e02
	ASCII "K>" ; 13e09
	DB 04h, 00h ; 13e0b
	ASCII "4" ; 13e0d
	DB 0C3h, 04h, 00h ; 13e0e
	ASCII "x" ; 13e11
	DB 0C3h, 04h, 00h ; 13e12
	ASCII "4" ; 13e15
	DB 0C3h, 04h, 00h ; 13e16
	ASCII "x" ; 13e19
	DB 0C3h, 04h, 00h ; 13e1a
	ASCII "4" ; 13e1d
	DB 0C3h, 04h, 00h ; 13e1e
	ASCII "x" ; 13e21
	DB 0C3h ; 13e22
	ASCIZ "2" ; 13e23
	ASCII "4" ; 13e25
	DB 0C3h, 0C1h, 99h, 0Bh, 3Eh, 04h, 00h ; 13e26
	ASCII "8" ; 13e2d
	DB 0C5h, 04h, 00h, 3Ch, 0C5h, 04h, 00h ; 13e2e
	ASCII "8" ; 13e35
	DB 0C5h, 04h, 00h, 3Ch, 0C5h, 04h, 00h ; 13e36
	ASCII "8" ; 13e3d
	DB 0C5h, 04h, 00h, 3Ch, 0C5h ; 13e3e
	ASCIZ "2" ; 13e43
	ASCII "8" ; 13e45
	DB 0C5h, 0C1h, 99h, 2Bh, 3Eh, 04h, 00h, 2Ch ; 13e46
	DB 0C7h, 04h, 00h ; 13e4e
	ASCII "0" ; 13e51
	DB 0C7h, 04h, 00h, 2Ch, 0C7h, 04h, 00h ; 13e52
	ASCII "0" ; 13e59
	DB 0C7h, 04h, 00h, 2Ch, 0C7h ; 13e5a
	ASCIZ "6" ; 13e5f
	ASCII "0" ; 13e61
	DB 0C7h, 0C1h, 99h ; 13e62
	ASCII "K>{" ; 13e65
	DB 0A7h ; 13e68
	ASCII "o>" ; 13e69
	DB 89h, 3Eh, 0A3h, 3Eh, 03h, 00h ; 13e6b
	ASCII "8" ; 13e71
	DB 0C3h, 03h, 00h ; 13e72
	ASCII "4" ; 13e75
	DB 0C3h, 03h, 00h ; 13e76
	ASCII "8" ; 13e79
	DB 0C3h, 03h, 00h ; 13e7a
	ASCII "H" ; 13e7d
	DB 0C3h, 02h, 00h ; 13e7e
	ASCII "D" ; 13e81
	DB 0C3h, 02h, 00h, 40h, 0C3h, 8Eh, 99h, 03h ; 13e82
	DB 00h, 0F8h, 0C4h, 03h, 00h, 0F4h, 0C4h, 03h ; 13e8a
	DB 00h, 0F8h, 0C4h, 03h, 00h, 08h, 0C5h, 02h ; 13e92
	DB 00h, 04h, 0C5h, 02h, 00h, 00h, 0C5h, 8Eh ; 13e9a
	DB 99h, 03h, 00h, 0ECh, 0C6h, 03h, 00h, 0E8h ; 13ea2
	DB 0C6h, 03h, 00h, 0ECh, 0C6h, 03h, 00h, 0FCh ; 13eaa
	DB 0C6h, 02h, 00h, 0F8h, 0C6h, 02h, 00h, 0F4h ; 13eb2
	DB 0C6h, 8Eh, 99h, 7Bh, 0A7h, 0C5h, 3Eh, 0E9h ; 13eba
	DB 3Eh, 0Dh, 3Fh, 04h, 00h, 7Ch, 0C3h, 04h ; 13ec2
	DB 00h ; 13eca
	ASCII "4" ; 13ecb
	DB 0C3h, 04h, 00h, 80h, 0C3h, 04h, 00h ; 13ecc
	ASCII "4" ; 13ed3
	DB 0C3h, 04h, 00h, 7Ch, 0C3h, 04h, 00h ; 13ed4
	ASCII "4" ; 13edb
	DB 0C3h, 04h, 00h, 80h, 0C3h, 05h, 00h ; 13edc
	ASCII "4" ; 13ee3
	DB 0C3h, 0C1h, 99h, 0BDh, 3Eh, 04h, 00h, 40h ; 13ee4
	DB 0C5h, 04h, 00h, 0F4h, 0C4h, 04h, 00h ; 13eec
	ASCII "D" ; 13ef3
	DB 0C5h, 04h, 00h, 0F4h, 0C4h, 04h, 00h, 40h ; 13ef4
	DB 0C5h, 04h, 00h, 0F4h, 0C4h, 04h, 00h ; 13efc
	ASCII "D" ; 13f03
	DB 0C5h, 05h, 00h, 0F4h, 0C4h, 0C1h, 99h, 0BDh ; 13f04
	DB 3Eh, 04h, 00h ; 13f0c
	ASCII "4" ; 13f0f
	DB 0C7h, 04h, 00h, 0E8h, 0C6h, 04h, 00h ; 13f10
	ASCII "8" ; 13f17
	DB 0C7h, 04h, 00h, 0E8h, 0C6h, 04h, 00h ; 13f18
	ASCII "4" ; 13f1f
	DB 0C7h, 04h, 00h, 0E8h, 0C6h, 04h, 00h ; 13f20
	ASCII "8" ; 13f27
	DB 0C7h, 05h, 00h, 0E8h, 0C6h, 0C1h, 99h, 0BDh ; 13f28
	DB 3Eh, 0CEh, 0D0h, 15h, 1Bh ; 13f30
	ASCII "2" ; 13f35
	DB 03h, 0E7h, 0Ah, 0CEh, 0D0h ; 13f36
	ASCII "B" ; 13f3b
	DB 16h, 96h, 01h, 0EBh, 0E1h, 00h, 0CEh, 0D0h ; 13f3c
	DB 14h, 1Bh, 28h, 0E6h ; 13f44
	ASCII "f" ; 13f48
	DB 0CEh, 0D0h, 0E7h, 1Ah, 96h, 04h, 0E6h, 5Eh ; 13f49
	DB 0B9h ; 13f51
	ASCII "7" ; 13f52
	DB 1Bh, 0C1h, 1Ah, 00h, 0CFh, 0C0h, 0D4h, 9Bh ; 13f53
	DB 0ACh, 0E6h ; 13f5b
	ASCII "V" ; 13f5d
	DB 0D4h, 13h, 0ADh, 0E6h ; 13f5e
	ASCII "V" ; 13f62
	DB 0D4h, 15h, 0ADh, 0E6h ; 13f63
	ASCII "V" ; 13f67
	DB 0D4h ; 13f68
	ASCII "S" ; 13f69
	DB 0ADh, 0E6h ; 13f6a
	ASCII "V" ; 13f6c
	DB 0D4h, 5Bh, 0ADh, 0E6h ; 13f6d
	ASCII "V" ; 13f71
	DB 0D4h ; 13f72
	ASCII "c" ; 13f73
	DB 0ADh, 0E6h ; 13f74
	ASCII "V" ; 13f76
	DB 0D4h ; 13f77
	ASCII "k" ; 13f78
	DB 0ADh, 0E6h ; 13f79
	ASCII "V" ; 13f7b
	DB 0D4h ; 13f7c
	ASCII "s" ; 13f7d
	DB 0ADh, 0E6h ; 13f7e
	ASCII "V" ; 13f80
	DB 0D4h, 84h, 0ADh, 0E6h ; 13f81
	ASCII "V" ; 13f85
	DB 0D4h, 8Ch, 0ADh, 0E6h ; 13f86
	ASCII "V" ; 13f8a
	DB 0D4h, 94h, 0ADh, 0E6h ; 13f8b
	ASCII "V" ; 13f8f
	DB 0D4h, 9Ch, 0ADh, 0E6h ; 13f90
	ASCII "V" ; 13f94
	DB 0D4h, 1Eh, 0AFh, 0E6h ; 13f95
	ASCII "V" ; 13f99
	DB 0D4h, 26h, 0AFh, 0E6h ; 13f9a
	ASCII "V" ; 13f9e
	DB 0D4h, 0F7h, 0B6h, 0E6h ; 13f9f
	ASCII "V" ; 13fa3
	DB 0D4h, 1Eh, 0B0h, 0E6h ; 13fa4
	ASCII "V" ; 13fa8
	DB 0D4h, 82h, 0AFh, 0E6h ; 13fa9
	ASCII "V" ; 13fad
	DB 0C4h ; 13fae
	ASCII "r" ; 13faf
	DB 1Ah, 0F1h ; 13fb0
	ASCII "V" ; 13fb2
	DB 0C4h, 0DDh, 3Bh, 0F1h ; 13fb3
	ASCII "Q" ; 13fb7
	DB 0C4h, 7Dh, 3Bh, 0F1h ; 13fb8
	ASCII "L" ; 13fbc
	DB 0C4h, 0A9h, 3Bh, 0F1h ; 13fbd
	ASCII "G" ; 13fc1
	DB 0C4h, 0CFh, 3Ch, 0F1h ; 13fc2
	ASCII "B" ; 13fc6
	DB 0C4h ; 13fc7
	ASCII "M<" ; 13fc8
	DB 0F1h, 3Dh, 0C4h, 0E9h, 3Ch, 0F1h ; 13fca
	ASCII "8" ; 13fd0
	DB 0C4h ; 13fd1
	ASCII "g<" ; 13fd2
	DB 0F1h ; 13fd4
	ASCII "3" ; 13fd5
	DB 0C4h, 03h, 3Dh, 0F1h, 2Eh, 0C4h, 81h, 3Ch ; 13fd6
	DB 0F1h, 29h, 0C4h, 9Bh, 3Ch, 0F1h, 24h, 0C4h ; 13fde
	ASCII "3<" ; 13fe6
	DB 0F1h, 1Fh, 0C4h, 0B5h, 3Ch, 0F1h, 1Ah, 0C4h ; 13fe8
	DB 0C3h, 3Bh, 0F1h, 15h, 0C4h, 0E9h, 3Dh, 0F1h ; 13ff0
	DB 10h, 0C4h, 03h, 3Eh, 0F1h, 0Bh, 0C4h, 0BDh ; 13ff8
	DB 3Eh, 0F1h, 06h, 0C4h ; 14000
	ASCII "g>" ; 14004
	DB 0F1h, 01h, 0CEh ; 14006
	ASCII "P" ; 14009
	DB 18h, 0CEh ; 1400a
	ASCII "X" ; 1400c
	DB 19h, 0CFh ; 1400d
	ASCII "8" ; 1400f
	DB 0E6h, 0Ah, 0CEh ; 14010
	ASCII "D" ; 14013
	DB 18h, 0CEh ; 14014
	ASCII "L" ; 14016
	DB 19h, 0F2h ; 14017
	ASCII "5" ; 14019
	DB 0B9h, 0F8h, 0B5h, 0B5h ; 1401a
	ASCII "1" ; 1401e
	DB 0BFh ; 1401f
	ASCII "v" ; 14020
	DB 1Ah, 0A6h, 0A3h, 0CEh, 40h, 14h, 0CEh ; 14021
	ASCII "H" ; 14028
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 14029
	DB 0A2h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 0B1h ; 14031
	DB 00h, 0C6h ; 14039
	ASCII "l@" ; 1403b
	DB 0CFh, 40h, 0CEh, 0C6h, 01h ; 1403d
	ASCII "G" ; 14042
	DB 06h, 0CEh, 0D1h, 10h, 1Bh ; 14043
	ASCII "1" ; 14048
	DB 0E5h, 1Eh, 92h ; 14049
	ASCII "G" ; 1404c
	DB 06h ; 1404d
	ASCII "1" ; 1404e
	DB 0E4h, 18h, 93h, 92h ; 1404f
	ASCII "G" ; 14053
	DB 06h, 0CEh, 0D1h, 11h, 1Bh ; 14054
	ASCII "1" ; 14059
	DB 0E5h, 0Dh, 92h ; 1405a
	ASCII "G" ; 1405d
	DB 06h ; 1405e
	ASCII "1" ; 1405f
	DB 0E4h, 07h, 0C5h, 0E7h, 1Ah, 0CEh, 25h, 0FBh ; 14060
	DB 0AAh, 0ABh, 0AEh, 0F8h, 27h, 2Ch, 11h, 17h ; 14068
	DB 1Eh, 23h, 10h, 17h, 25h, 2Ah, 13h, 19h ; 14070
	DB 7Bh, 0A7h, 80h, 40h, 8Ch, 40h, 98h, 40h ; 14078
	DB 0Ah, 00h, 0A4h, 0C3h, 0Ah, 00h, 0A8h, 0C3h ; 14080
	DB 0C1h, 99h, 80h, 40h, 0Ah, 00h ; 14088
	ASCII "T" ; 1408e
	DB 0C5h, 0Ah, 00h ; 1408f
	ASCII "X" ; 14092
	DB 0C5h, 0C1h, 99h, 8Ch, 40h, 0Ah, 00h ; 14093
	ASCII "H" ; 1409a
	DB 0C7h, 0Ah, 00h ; 1409b
	ASCII "L" ; 1409e
	DB 0C7h, 0C1h, 99h, 98h, 40h, 7Bh, 0A7h, 0ACh ; 1409f
	DB 40h, 0B2h, 40h, 0B8h, 40h, 01h, 00h, 0A4h ; 140a7
	DB 0C3h, 8Eh, 99h, 01h, 00h ; 140af
	ASCII "T" ; 140b4
	DB 0C5h, 8Eh, 99h, 01h, 00h ; 140b5
	ASCII "H" ; 140ba
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0C6h, 40h, 0CCh ; 140bb
	DB 40h, 0D2h, 40h, 06h, 00h, 0ACh, 0C3h, 8Eh ; 140c3
	DB 99h, 06h, 00h, 5Ch, 0C5h, 8Eh, 99h, 06h ; 140cb
	DB 00h ; 140d3
	ASCII "P" ; 140d4
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0E0h, 40h, 0FAh ; 140d5
	DB 40h, 14h ; 140dd
	ASCII "A" ; 140df
	DB 02h, 00h ; 140e0
	ASCII "m" ; 140e2
	DB 1Ah, 02h, 00h, 0B4h, 0C3h, 03h, 00h, 0B8h ; 140e3
	DB 0C3h, 03h, 00h, 0A8h, 0C3h, 03h, 00h, 0A4h ; 140eb
	DB 0C3h, 03h, 00h, 0A8h, 0C3h, 8Eh, 99h, 02h ; 140f3
	DB 00h ; 140fb
	ASCII "m" ; 140fc
	DB 1Ah, 02h, 00h ; 140fd
	ASCII "d" ; 14100
	DB 0C5h, 03h, 00h ; 14101
	ASCII "h" ; 14104
	DB 0C5h, 03h, 00h ; 14105
	ASCII "X" ; 14108
	DB 0C5h, 03h, 00h ; 14109
	ASCII "T" ; 1410c
	DB 0C5h, 03h, 00h ; 1410d
	ASCII "X" ; 14110
	DB 0C5h, 8Eh, 99h, 02h, 00h ; 14111
	ASCII "m" ; 14116
	DB 1Ah, 02h, 00h ; 14117
	ASCII "X" ; 1411a
	DB 0C7h, 03h, 00h, 5Ch, 0C7h, 03h, 00h ; 1411b
	ASCII "L" ; 14122
	DB 0C7h, 03h, 00h ; 14123
	ASCII "H" ; 14126
	DB 0C7h, 03h, 00h ; 14127
	ASCII "L" ; 1412a
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h ; 1412b
	ASCII "6A<ABA" ; 14130
	DB 01h, 00h, 0BCh, 0C3h, 8Eh, 99h, 01h, 00h ; 14136
	ASCII "l" ; 1413e
	DB 0C5h, 8Eh, 99h, 01h, 00h, 60h, 0C7h, 8Eh ; 1413f
	DB 99h, 7Bh, 0A7h ; 14147
	ASCII "PAVA\A" ; 1414a
	DB 01h, 00h, 0C0h, 0C3h, 8Eh, 99h, 01h, 00h ; 14150
	ASCII "p" ; 14158
	DB 0C5h, 8Eh, 99h, 01h, 00h ; 14159
	ASCII "d" ; 1415e
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h ; 1415f
	ASCII "jApAvA" ; 14164
	DB 01h, 00h, 0C4h, 0C3h, 8Eh, 99h, 01h, 00h ; 1416a
	ASCII "t" ; 14172
	DB 0C5h, 8Eh, 99h, 01h, 00h ; 14173
	ASCII "h" ; 14178
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 84h ; 14179
	ASCII "A" ; 1417f
	DB 8Ah ; 14180
	ASCII "A" ; 14181
	DB 90h ; 14182
	ASCII "A" ; 14183
	DB 01h, 00h, 0C8h, 0C3h, 8Eh, 99h, 01h, 00h ; 14184
	ASCII "x" ; 1418c
	DB 0C5h, 8Eh, 99h, 01h, 00h ; 1418d
	ASCII "l" ; 14192
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 9Eh ; 14193
	ASCII "A" ; 14199
	DB 0A4h ; 1419a
	ASCII "A" ; 1419b
	DB 0AAh ; 1419c
	ASCII "A" ; 1419d
	DB 01h, 00h, 0CCh, 0C3h, 8Eh, 99h, 01h, 00h ; 1419e
	DB 7Ch, 0C5h, 8Eh, 99h, 01h, 00h ; 141a6
	ASCII "p" ; 141ac
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0B8h ; 141ad
	ASCII "A" ; 141b3
	DB 0BEh ; 141b4
	ASCII "A" ; 141b5
	DB 0C4h ; 141b6
	ASCII "A" ; 141b7
	DB 01h, 00h, 0D0h, 0C3h, 8Eh, 99h, 01h, 00h ; 141b8
	DB 80h, 0C5h, 8Eh, 99h, 01h, 00h ; 141c0
	ASCII "t" ; 141c6
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0D2h ; 141c7
	ASCII "A" ; 141cd
	DB 0D8h ; 141ce
	ASCII "A" ; 141cf
	DB 0DEh ; 141d0
	ASCII "A" ; 141d1
	DB 01h, 00h, 0D4h, 0C3h, 8Eh, 99h, 01h, 00h ; 141d2
	DB 84h, 0C5h, 8Eh, 99h, 01h, 00h ; 141da
	ASCII "x" ; 141e0
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0ECh ; 141e1
	ASCII "A" ; 141e7
	DB 0F2h ; 141e8
	ASCII "A" ; 141e9
	DB 0F8h ; 141ea
	ASCII "A" ; 141eb
	DB 01h, 00h, 0D8h, 0C3h, 8Eh, 99h, 01h, 00h ; 141ec
	DB 88h, 0C5h, 8Eh, 99h, 01h, 00h, 7Ch, 0C7h ; 141f4
	DB 8Eh, 99h, 7Bh, 0A7h, 06h ; 141fc
	ASCII "BPB" ; 14201
	DB 9Ah ; 14204
	ASCII "B" ; 14205
	DB 08h, 00h, 0DCh, 0C3h, 08h, 00h, 0A4h, 0C3h ; 14206
	DB 08h, 00h, 0DCh, 0C3h, 08h, 00h, 0A4h, 0C3h ; 1420e
	DB 08h, 00h, 0DCh, 0C3h, 08h, 00h, 0A4h, 0C3h ; 14216
	DB 08h, 00h, 0E0h, 0C3h, 08h, 00h, 0A4h, 0C3h ; 1421e
	DB 08h, 00h, 0E0h, 0C3h, 08h, 00h, 0A4h, 0C3h ; 14226
	DB 08h, 00h, 0E0h, 0C3h, 08h, 00h, 0A4h, 0C3h ; 1422e
	DB 08h, 00h, 0E0h, 0C3h, 08h, 00h, 0A4h, 0C3h ; 14236
	DB 04h, 00h, 0BCh, 0C3h, 0Ch, 00h, 0E4h, 0C3h ; 1423e
	DB 06h, 00h, 0BCh, 0C3h, 14h, 00h, 10h, 0C4h ; 14246
	DB 8Eh, 99h, 08h, 00h, 8Ch, 0C5h, 08h, 00h ; 1424e
	ASCII "T" ; 14256
	DB 0C5h, 08h, 00h, 8Ch, 0C5h, 08h, 00h ; 14257
	ASCII "T" ; 1425e
	DB 0C5h, 08h, 00h, 8Ch, 0C5h, 08h, 00h ; 1425f
	ASCII "T" ; 14266
	DB 0C5h, 08h, 00h, 90h, 0C5h, 08h, 00h ; 14267
	ASCII "T" ; 1426e
	DB 0C5h, 08h, 00h, 90h, 0C5h, 08h, 00h ; 1426f
	ASCII "T" ; 14276
	DB 0C5h, 08h, 00h, 90h, 0C5h, 08h, 00h ; 14277
	ASCII "T" ; 1427e
	DB 0C5h, 08h, 00h, 90h, 0C5h, 08h, 00h ; 1427f
	ASCII "T" ; 14286
	DB 0C5h, 04h, 00h ; 14287
	ASCII "l" ; 1428a
	DB 0C5h, 0Ch, 00h, 94h, 0C5h, 06h, 00h ; 1428b
	ASCII "l" ; 14292
	DB 0C5h, 14h, 00h, 0B0h, 0C5h, 8Eh, 99h, 08h ; 14293
	DB 00h, 80h, 0C7h, 08h, 00h ; 1429b
	ASCII "H" ; 142a0
	DB 0C7h, 08h, 00h, 80h, 0C7h, 08h, 00h ; 142a1
	ASCII "H" ; 142a8
	DB 0C7h, 08h, 00h, 80h, 0C7h, 08h, 00h ; 142a9
	ASCII "H" ; 142b0
	DB 0C7h, 08h, 00h, 84h, 0C7h, 08h, 00h ; 142b1
	ASCII "H" ; 142b8
	DB 0C7h, 08h, 00h, 84h, 0C7h, 08h, 00h ; 142b9
	ASCII "H" ; 142c0
	DB 0C7h, 08h, 00h, 84h, 0C7h, 08h, 00h ; 142c1
	ASCII "H" ; 142c8
	DB 0C7h, 08h, 00h, 84h, 0C7h, 08h, 00h ; 142c9
	ASCII "H" ; 142d0
	DB 0C7h, 04h, 00h, 60h, 0C7h, 0Ch, 00h, 88h ; 142d1
	DB 0C7h, 06h, 00h, 60h, 0C7h, 14h, 00h, 0A4h ; 142d9
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0ECh ; 142e1
	ASCII "B" ; 142e7
	DB 0F2h ; 142e8
	ASCII "B" ; 142e9
	DB 0F8h ; 142ea
	ASCII "B" ; 142eb
	DB 06h, 00h, 0E4h, 0C3h, 8Eh, 99h, 06h, 00h ; 142ec
	DB 94h, 0C5h, 8Eh, 99h, 06h, 00h, 88h, 0C7h ; 142f4
	DB 8Eh, 99h, 7Bh, 0A7h, 06h ; 142fc
	ASCII "C&CFC" ; 14301
	DB 04h, 00h, 0A4h, 0C3h, 04h, 00h, 0E8h, 0C3h ; 14306
	DB 04h, 00h, 0A4h, 0C3h, 04h, 00h, 0E8h, 0C3h ; 1430e
	DB 04h, 00h, 0A4h, 0C3h, 04h, 00h, 0E8h, 0C3h ; 14316
	ASCIZ "2" ; 1431e
	DB 0A4h, 0C3h, 0C1h, 99h, 06h ; 14320
	ASCII "C" ; 14325
	DB 04h, 00h, 98h, 0C5h, 04h, 00h, 9Ch, 0C5h ; 14326
	DB 04h, 00h, 98h, 0C5h, 04h, 00h, 9Ch, 0C5h ; 1432e
	DB 04h, 00h, 98h, 0C5h, 04h, 00h, 9Ch, 0C5h ; 14336
	ASCIZ "2" ; 1433e
	DB 98h, 0C5h, 0C1h, 99h, 26h ; 14340
	ASCII "C" ; 14345
	DB 04h, 00h, 8Ch, 0C7h, 04h, 00h, 90h, 0C7h ; 14346
	DB 04h, 00h, 8Ch, 0C7h, 04h, 00h, 90h, 0C7h ; 1434e
	DB 04h, 00h, 8Ch, 0C7h ; 14356
	ASCIZ "6" ; 1435a
	DB 90h, 0C7h, 0C1h, 99h ; 1435c
	ASCII "FC{" ; 14360
	DB 0A7h ; 14363
	ASCII "jC" ; 14364
	DB 84h ; 14366
	ASCII "C" ; 14367
	DB 9Eh ; 14368
	ASCII "C" ; 14369
	DB 03h, 00h, 0A8h, 0C3h, 03h, 00h, 0A4h, 0C3h ; 1436a
	DB 03h, 00h, 0A8h, 0C3h, 03h, 00h, 0B8h, 0C3h ; 14372
	DB 02h, 00h, 0B4h, 0C3h, 02h, 00h, 0B0h, 0C3h ; 1437a
	DB 8Eh, 99h, 03h, 00h ; 14382
	ASCII "X" ; 14386
	DB 0C5h, 03h, 00h ; 14387
	ASCII "T" ; 1438a
	DB 0C5h, 03h, 00h ; 1438b
	ASCII "X" ; 1438e
	DB 0C5h, 03h, 00h ; 1438f
	ASCII "h" ; 14392
	DB 0C5h, 02h, 00h ; 14393
	ASCII "d" ; 14396
	DB 0C5h, 02h, 00h, 60h, 0C5h, 8Eh, 99h, 03h ; 14397
	DB 00h ; 1439f
	ASCII "L" ; 143a0
	DB 0C7h, 03h, 00h ; 143a1
	ASCII "H" ; 143a4
	DB 0C7h, 03h, 00h ; 143a5
	ASCII "L" ; 143a8
	DB 0C7h, 03h, 00h, 5Ch, 0C7h, 02h, 00h ; 143a9
	ASCII "X" ; 143b0
	DB 0C7h, 02h, 00h ; 143b1
	ASCII "T" ; 143b4
	DB 0C7h, 8Eh, 99h, 7Bh, 0A7h, 0C0h ; 143b5
	ASCII "C" ; 143bb
	DB 0E4h ; 143bc
	ASCII "C" ; 143bd
	DB 08h ; 143be
	ASCII "D" ; 143bf
	DB 04h, 00h, 0ECh, 0C3h, 04h, 00h, 0A4h, 0C3h ; 143c0
	DB 04h, 00h, 0F0h, 0C3h, 04h, 00h, 0A4h, 0C3h ; 143c8
	DB 04h, 00h, 0ECh, 0C3h, 04h, 00h, 0A4h, 0C3h ; 143d0
	DB 04h, 00h, 0F0h, 0C3h, 05h, 00h, 0A4h, 0C3h ; 143d8
	DB 0C1h, 99h, 0B8h ; 143e0
	ASCII "C" ; 143e3
	DB 04h, 00h, 0A0h, 0C5h, 04h, 00h ; 143e4
	ASCII "T" ; 143ea
	DB 0C5h, 04h, 00h, 0A4h, 0C5h, 04h, 00h ; 143eb
	ASCII "T" ; 143f2
	DB 0C5h, 04h, 00h, 0A0h, 0C5h, 04h, 00h ; 143f3
	ASCII "T" ; 143fa
	DB 0C5h, 04h, 00h, 0A4h, 0C5h, 05h, 00h ; 143fb
	ASCII "T" ; 14402
	DB 0C5h, 0C1h, 99h, 0B8h ; 14403
	ASCII "C" ; 14407
	DB 04h, 00h, 94h, 0C7h, 04h, 00h ; 14408
	ASCII "H" ; 1440e
	DB 0C7h, 04h, 00h, 98h, 0C7h, 04h, 00h ; 1440f
	ASCII "H" ; 14416
	DB 0C7h, 04h, 00h, 94h, 0C7h, 04h, 00h ; 14417
	ASCII "H" ; 1441e
	DB 0C7h, 04h, 00h, 98h, 0C7h, 05h, 00h ; 1441f
	ASCII "H" ; 14426
	DB 0C7h, 0C1h, 99h, 0B8h ; 14427
	ASCII "C" ; 1442b
	DB 0CEh, 0D0h, 15h, 1Bh ; 1442c
	ASCII "2" ; 14430
	DB 03h, 0E7h, 0Ah, 0CEh, 0D0h ; 14431
	ASCII "B" ; 14436
	DB 16h, 96h, 01h, 0EBh, 0E1h, 00h, 0CEh, 0D0h ; 14437
	DB 14h, 1Bh, 28h, 0E6h ; 1443f
	ASCII "f" ; 14443
	DB 0CEh, 0D0h, 0E7h, 1Ah, 96h, 08h, 0E6h, 5Eh ; 14444
	DB 0B9h ; 1444c
	ASCII "7" ; 1444d
	DB 1Bh, 0C1h, 1Ah, 00h, 0CFh, 0C0h, 0D4h, 9Bh ; 1444e
	DB 0ACh, 0E6h ; 14456
	ASCII "V" ; 14458
	DB 0D4h, 13h, 0ADh, 0E6h ; 14459
	ASCII "V" ; 1445d
	DB 0D4h, 15h, 0ADh, 0E6h ; 1445e
	ASCII "V" ; 14462
	DB 0D4h ; 14463
	ASCII "S" ; 14464
	DB 0ADh, 0E6h ; 14465
	ASCII "V" ; 14467
	DB 0D4h, 5Bh, 0ADh, 0E6h ; 14468
	ASCII "V" ; 1446c
	DB 0D4h ; 1446d
	ASCII "c" ; 1446e
	DB 0ADh, 0E6h ; 1446f
	ASCII "V" ; 14471
	DB 0D4h ; 14472
	ASCII "k" ; 14473
	DB 0ADh, 0E6h ; 14474
	ASCII "V" ; 14476
	DB 0D4h ; 14477
	ASCII "s" ; 14478
	DB 0ADh, 0E6h ; 14479
	ASCII "V" ; 1447b
	DB 0D4h, 84h, 0ADh, 0E6h ; 1447c
	ASCII "V" ; 14480
	DB 0D4h, 8Ch, 0ADh, 0E6h ; 14481
	ASCII "V" ; 14485
	DB 0D4h, 94h, 0ADh, 0E6h ; 14486
	ASCII "V" ; 1448a
	DB 0D4h, 9Ch, 0ADh, 0E6h ; 1448b
	ASCII "V" ; 1448f
	DB 0D4h, 1Eh, 0AFh, 0E6h ; 14490
	ASCII "V" ; 14494
	DB 0D4h, 26h, 0AFh, 0E6h ; 14495
	ASCII "V" ; 14499
	DB 0D4h, 0F7h, 0B6h, 0E6h ; 1449a
	ASCII "V" ; 1449e
	DB 0D4h, 1Eh, 0B0h, 0E6h ; 1449f
	ASCII "V" ; 144a3
	DB 0D4h, 82h, 0AFh, 0E6h ; 144a4
	ASCII "V" ; 144a8
	DB 0C4h ; 144a9
	ASCII "r" ; 144aa
	DB 1Ah, 0F1h ; 144ab
	ASCII "V" ; 144ad
	DB 0C4h, 0D8h, 40h, 0F1h ; 144ae
	ASCII "Q" ; 144b2
	DB 0C4h ; 144b3
	ASCII "x@" ; 144b4
	DB 0F1h ; 144b6
	ASCII "L" ; 144b7
	DB 0C4h, 0A4h, 40h, 0F1h ; 144b8
	ASCII "G" ; 144bc
	DB 0C4h, 0CAh ; 144bd
	ASCII "A" ; 144bf
	DB 0F1h ; 144c0
	ASCII "B" ; 144c1
	DB 0C4h ; 144c2
	ASCII "HA" ; 144c3
	DB 0F1h, 3Dh, 0C4h, 0E4h ; 144c5
	ASCII "A" ; 144c9
	DB 0F1h ; 144ca
	ASCII "8" ; 144cb
	DB 0C4h ; 144cc
	ASCII "bA" ; 144cd
	DB 0F1h ; 144cf
	ASCII "3" ; 144d0
	DB 0C4h, 0FEh ; 144d1
	ASCII "A" ; 144d3
	DB 0F1h, 2Eh, 0C4h, 7Ch ; 144d4
	ASCII "A" ; 144d8
	DB 0F1h, 29h, 0C4h, 96h ; 144d9
	ASCII "A" ; 144dd
	DB 0F1h, 24h, 0C4h, 2Eh ; 144de
	ASCII "A" ; 144e2
	DB 0F1h, 1Fh, 0C4h, 0B0h ; 144e3
	ASCII "A" ; 144e7
	DB 0F1h, 1Ah, 0C4h, 0BEh, 40h, 0F1h, 15h, 0C4h ; 144e8
	DB 0E4h ; 144f0
	ASCII "B" ; 144f1
	DB 0F1h, 10h, 0C4h, 0FEh ; 144f2
	ASCII "B" ; 144f6
	DB 0F1h, 0Bh, 0C4h, 0B8h ; 144f7
	ASCII "C" ; 144fb
	DB 0F1h, 06h, 0C4h ; 144fc
	ASCII "bC" ; 144ff
	DB 0F1h, 01h, 0CEh ; 14501
	ASCII "P" ; 14504
	DB 18h, 0CEh ; 14505
	ASCII "X" ; 14507
	DB 19h, 0CFh ; 14508
	ASCII "8" ; 1450a
	DB 0E6h, 0Ah, 0CEh ; 1450b
	ASCII "D" ; 1450e
	DB 18h, 0CEh ; 1450f
	ASCII "L" ; 14511
	DB 19h, 0F2h, 3Ah, 0B4h, 0F8h, 0B5h, 0B5h, 2Ch ; 14512
	DB 0C4h ; 1451a
	ASCII "v" ; 1451b
	DB 1Ah, 0A6h, 0A3h, 0CEh, 40h, 14h, 0CEh ; 1451c
	ASCII "H" ; 14523
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 14524
	DB 0A2h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 0B1h ; 1452c
	DB 00h, 0C6h ; 14534
	ASCII "gE" ; 14536
	DB 0CFh, 40h, 0CEh, 0C6h, 01h ; 14538
	ASCII "G" ; 1453d
	DB 06h, 0CEh, 0D1h, 10h, 1Bh ; 1453e
	ASCII "1" ; 14543
	DB 0E5h, 1Eh, 92h ; 14544
	ASCII "G" ; 14547
	DB 06h ; 14548
	ASCII "1" ; 14549
	DB 0E4h, 18h, 93h, 92h ; 1454a
	ASCII "G" ; 1454e
	DB 06h, 0CEh, 0D1h, 11h, 1Bh ; 1454f
	ASCII "1" ; 14554
	DB 0E5h, 0Dh, 92h ; 14555
	ASCII "G" ; 14558
	DB 06h ; 14559
	ASCII "1" ; 1455a
	DB 0E4h, 07h, 0C5h, 0E7h, 1Ah, 0CEh, 25h, 0F7h ; 1455b
	DB 0AAh, 0ABh, 0AEh, 0F8h, 1Dh, 24h, 12h, 19h ; 14563
	DB 23h, 28h, 0Ch, 14h, 20h, 26h, 12h, 19h ; 1456b
	DB 7Bh, 0A7h, 7Bh ; 14573
	ASCII "E" ; 14576
	DB 87h ; 14577
	ASCII "E" ; 14578
	DB 93h ; 14579
	ASCII "E" ; 1457a
	DB 0Ah, 00h, 14h, 0C4h, 0Ah, 00h, 18h, 0C4h ; 1457b
	DB 0C1h, 99h, 7Bh ; 14583
	ASCII "E" ; 14586
	DB 0Ah, 00h, 0B4h, 0C5h, 0Ah, 00h, 0B8h, 0C5h ; 14587
	DB 0C1h, 99h, 87h ; 1458f
	ASCII "E" ; 14592
	DB 0Ah, 00h, 0A8h, 0C7h, 0Ah, 00h, 0ACh, 0C7h ; 14593
	DB 0C1h, 99h, 93h ; 1459b
	ASCII "E{" ; 1459e
	DB 0A7h, 0A7h ; 145a0
	ASCII "E" ; 145a2
	DB 0ADh ; 145a3
	ASCII "E" ; 145a4
	DB 0B3h ; 145a5
	ASCII "E" ; 145a6
	DB 01h, 00h, 14h, 0C4h, 8Eh, 99h, 01h, 00h ; 145a7
	DB 0B4h, 0C5h, 8Eh, 99h, 01h, 00h, 0A8h, 0C7h ; 145af
	DB 8Eh, 99h, 7Bh, 0A7h, 0C1h ; 145b7
	ASCII "E" ; 145bc
	DB 0C7h ; 145bd
	ASCII "E" ; 145be
	DB 0CDh ; 145bf
	ASCII "E" ; 145c0
	DB 06h, 00h, 1Ch, 0C4h, 8Eh, 99h, 06h, 00h ; 145c1
	DB 0BCh, 0C5h, 8Eh, 99h, 06h, 00h, 0B0h, 0C7h ; 145c9
	DB 8Eh, 99h, 7Bh, 0A7h, 0DBh ; 145d1
	ASCII "E" ; 145d6
	DB 0F5h ; 145d7
	ASCII "E" ; 145d8
	DB 0Fh ; 145d9
	ASCII "F" ; 145da
	DB 02h, 00h ; 145db
	ASCII "m" ; 145dd
	DB 1Ah, 02h, 00h, 24h, 0C4h, 03h, 00h, 28h ; 145de
	DB 0C4h, 03h, 00h, 18h, 0C4h, 03h, 00h, 14h ; 145e6
	DB 0C4h, 03h, 00h, 18h, 0C4h, 8Eh, 99h, 02h ; 145ee
	DB 00h ; 145f6
	ASCII "m" ; 145f7
	DB 1Ah, 02h, 00h, 0C4h, 0C5h, 03h, 00h, 0C8h ; 145f8
	DB 0C5h, 03h, 00h, 0B8h, 0C5h, 03h, 00h, 0B4h ; 14600
	DB 0C5h, 03h, 00h, 0B8h, 0C5h, 8Eh, 99h, 02h ; 14608
	DB 00h ; 14610
	ASCII "m" ; 14611
	DB 1Ah, 02h, 00h, 0B8h, 0C7h, 03h, 00h, 0BCh ; 14612
	DB 0C7h, 03h, 00h, 0ACh, 0C7h, 03h, 00h, 0A8h ; 1461a
	DB 0C7h, 03h, 00h, 0ACh, 0C7h, 8Eh, 99h, 7Bh ; 14622
	DB 0A7h ; 1462a
	ASCII "1F7F=F" ; 1462b
	DB 01h, 00h, 2Ch, 0C4h, 8Eh, 99h, 01h, 00h ; 14631
	DB 0CCh, 0C5h, 8Eh, 99h, 01h, 00h, 0C0h, 0C7h ; 14639
	DB 8Eh, 99h, 7Bh, 0A7h ; 14641
	ASCII "KFQFWF" ; 14645
	DB 01h, 00h ; 1464b
	ASCII "0" ; 1464d
	DB 0C4h, 8Eh, 99h, 01h, 00h, 0D0h, 0C5h, 8Eh ; 1464e
	DB 99h, 01h, 00h, 0C4h, 0C7h, 8Eh, 99h, 7Bh ; 14656
	DB 0A7h ; 1465e
	ASCII "eFkFqF" ; 1465f
	DB 01h, 00h ; 14665
	ASCII "4" ; 14667
	DB 0C4h, 8Eh, 99h, 01h, 00h, 0D4h, 0C5h, 8Eh ; 14668
	DB 99h, 01h, 00h, 0C8h, 0C7h, 8Eh, 99h, 7Bh ; 14670
	DB 0A7h, 7Fh ; 14678
	ASCII "F" ; 1467a
	DB 85h ; 1467b
	ASCII "F" ; 1467c
	DB 8Bh ; 1467d
	ASCII "F" ; 1467e
	DB 01h, 00h ; 1467f
	ASCII "8" ; 14681
	DB 0C4h, 8Eh, 99h, 01h, 00h, 0D8h, 0C5h, 8Eh ; 14682
	DB 99h, 01h, 00h, 0CCh, 0C7h, 8Eh, 99h, 7Bh ; 1468a
	DB 0A7h, 99h ; 14692
	ASCII "F" ; 14694
	DB 9Fh ; 14695
	ASCII "F" ; 14696
	DB 0A5h ; 14697
	ASCII "F" ; 14698
	DB 01h, 00h, 3Ch, 0C4h, 8Eh, 99h, 01h, 00h ; 14699
	DB 0DCh, 0C5h, 8Eh, 99h, 01h, 00h, 0D0h, 0C7h ; 146a1
	DB 8Eh, 99h, 7Bh, 0A7h, 0B3h ; 146a9
	ASCII "F" ; 146ae
	DB 0B9h ; 146af
	ASCII "F" ; 146b0
	DB 0BFh ; 146b1
	ASCII "F" ; 146b2
	DB 01h, 00h, 40h, 0C4h, 8Eh, 99h, 01h, 00h ; 146b3
	DB 0E0h, 0C5h, 8Eh, 99h, 01h, 00h, 0D4h, 0C7h ; 146bb
	DB 8Eh, 99h, 7Bh, 0A7h, 0CDh ; 146c3
	ASCII "F" ; 146c8
	DB 0D3h ; 146c9
	ASCII "F" ; 146ca
	DB 0D9h ; 146cb
	ASCII "F" ; 146cc
	DB 01h, 00h ; 146cd
	ASCII "D" ; 146cf
	DB 0C4h, 8Eh, 99h, 01h, 00h, 0E4h, 0C5h, 8Eh ; 146d0
	DB 99h, 01h, 00h, 0D8h, 0C7h, 8Eh, 99h, 7Bh ; 146d8
	DB 0A7h, 0E7h ; 146e0
	ASCII "F" ; 146e2
	DB 0EDh ; 146e3
	ASCII "F" ; 146e4
	DB 0F3h ; 146e5
	ASCII "F" ; 146e6
	DB 01h, 00h ; 146e7
	ASCII "H" ; 146e9
	DB 0C4h, 8Eh, 99h, 01h, 00h, 0E8h, 0C5h, 8Eh ; 146ea
	DB 99h, 01h, 00h, 0DCh, 0C7h, 8Eh, 99h, 7Bh ; 146f2
	DB 0A7h, 01h ; 146fa
	ASCII "GKG" ; 146fc
	DB 95h ; 146ff
	ASCII "G" ; 14700
	DB 08h, 00h ; 14701
	ASCII "L" ; 14703
	DB 0C4h, 08h, 00h, 14h, 0C4h, 08h, 00h ; 14704
	ASCII "L" ; 1470b
	DB 0C4h, 08h, 00h, 14h, 0C4h, 08h, 00h ; 1470c
	ASCII "L" ; 14713
	DB 0C4h, 08h, 00h, 14h, 0C4h, 08h, 00h ; 14714
	ASCII "P" ; 1471b
	DB 0C4h, 08h, 00h, 14h, 0C4h, 08h, 00h ; 1471c
	ASCII "P" ; 14723
	DB 0C4h, 08h, 00h, 14h, 0C4h, 08h, 00h ; 14724
	ASCII "P" ; 1472b
	DB 0C4h, 08h, 00h, 14h, 0C4h, 08h, 00h ; 1472c
	ASCII "P" ; 14733
	DB 0C4h, 08h, 00h, 14h, 0C4h, 04h, 00h, 2Ch ; 14734
	DB 0C4h, 0Ch, 00h ; 1473c
	ASCII "T" ; 1473f
	DB 0C4h, 06h, 00h, 2Ch, 0C4h, 14h, 00h, 80h ; 14740
	DB 0C4h, 8Eh, 99h, 08h, 00h, 0ECh, 0C5h, 08h ; 14748
	DB 00h, 0B4h, 0C5h, 08h, 00h, 0ECh, 0C5h, 08h ; 14750
	DB 00h, 0B4h, 0C5h, 08h, 00h, 0ECh, 0C5h, 08h ; 14758
	DB 00h, 0B4h, 0C5h, 08h, 00h, 0F0h, 0C5h, 08h ; 14760
	DB 00h, 0B4h, 0C5h, 08h, 00h, 0F0h, 0C5h, 08h ; 14768
	DB 00h, 0B4h, 0C5h, 08h, 00h, 0F0h, 0C5h, 08h ; 14770
	DB 00h, 0B4h, 0C5h, 08h, 00h, 0F0h, 0C5h, 08h ; 14778
	DB 00h, 0B4h, 0C5h, 04h, 00h, 0CCh, 0C5h, 0Ch ; 14780
	DB 00h, 0F4h, 0C5h, 06h, 00h, 0CCh, 0C5h, 14h ; 14788
	DB 00h, 10h, 0C6h, 8Eh, 99h, 08h, 00h, 0E0h ; 14790
	DB 0C7h, 08h, 00h, 0A8h, 0C7h, 08h, 00h, 0E0h ; 14798
	DB 0C7h, 08h, 00h, 0A8h, 0C7h, 08h, 00h, 0E0h ; 147a0
	DB 0C7h, 08h, 00h, 0A8h, 0C7h, 08h, 00h, 0E4h ; 147a8
	DB 0C7h, 08h, 00h, 0A8h, 0C7h, 08h, 00h, 0E4h ; 147b0
	DB 0C7h, 08h, 00h, 0A8h, 0C7h, 08h, 00h, 0E4h ; 147b8
	DB 0C7h, 08h, 00h, 0A8h, 0C7h, 08h, 00h, 0E4h ; 147c0
	DB 0C7h, 08h, 00h, 0A8h, 0C7h, 04h, 00h, 0C0h ; 147c8
	DB 0C7h, 0Ch, 00h, 0E8h, 0C7h, 06h, 00h, 0C0h ; 147d0
	DB 0C7h, 14h, 00h, 04h, 0C8h, 8Eh, 99h, 7Bh ; 147d8
	DB 0A7h, 0E7h ; 147e0
	ASCII "G" ; 147e2
	DB 0EDh ; 147e3
	ASCII "G" ; 147e4
	DB 0F3h ; 147e5
	ASCII "G" ; 147e6
	DB 06h, 00h ; 147e7
	ASCII "T" ; 147e9
	DB 0C4h, 8Eh, 99h, 06h, 00h, 0F4h, 0C5h, 8Eh ; 147ea
	DB 99h, 06h, 00h, 0E8h, 0C7h, 8Eh, 99h, 7Bh ; 147f2
	DB 0A7h, 01h ; 147fa
	ASCII "H!HAH" ; 147fc
	DB 04h, 00h, 14h, 0C4h, 04h, 00h ; 14801
	ASCII "X" ; 14807
	DB 0C4h, 04h, 00h, 14h, 0C4h, 04h, 00h ; 14808
	ASCII "X" ; 1480f
	DB 0C4h, 04h, 00h, 14h, 0C4h, 04h, 00h ; 14810
	ASCII "X" ; 14817
	DB 0C4h ; 14818
	ASCIZ "2" ; 14819
	DB 14h, 0C4h, 0C1h, 99h, 01h ; 1481b
	ASCII "H" ; 14820
	DB 04h, 00h, 0F8h, 0C5h, 04h, 00h, 0FCh, 0C5h ; 14821
	DB 04h, 00h, 0F8h, 0C5h, 04h, 00h, 0FCh, 0C5h ; 14829
	DB 04h, 00h, 0F8h, 0C5h, 04h, 00h, 0FCh, 0C5h ; 14831
	ASCIZ "2" ; 14839
	DB 0F8h, 0C5h, 0C1h, 99h, 21h ; 1483b
	ASCII "H" ; 14840
	DB 04h, 00h, 0ECh, 0C7h, 04h, 00h, 0F0h, 0C7h ; 14841
	DB 04h, 00h, 0ECh, 0C7h, 04h, 00h, 0F0h, 0C7h ; 14849
	DB 04h, 00h, 0ECh, 0C7h ; 14851
	ASCIZ "6" ; 14855
	DB 0F0h, 0C7h, 0C1h, 99h ; 14857
	ASCII "AH{" ; 1485b
	DB 0A7h ; 1485e
	ASCII "eHH" ; 1485f
	DB 99h ; 14863
	ASCII "H" ; 14864
	DB 03h, 00h, 18h, 0C4h, 03h, 00h, 14h, 0C4h ; 14865
	DB 03h, 00h, 18h, 0C4h, 03h, 00h, 28h, 0C4h ; 1486d
	DB 02h, 00h, 24h, 0C4h, 02h, 00h, 20h, 0C4h ; 14875
	DB 8Eh, 99h, 03h, 00h, 0B8h, 0C5h, 03h, 00h ; 1487d
	DB 0B4h, 0C5h, 03h, 00h, 0B8h, 0C5h, 03h, 00h ; 14885
	DB 0C8h, 0C5h, 02h, 00h, 0C4h, 0C5h, 02h, 00h ; 1488d
	DB 0C0h, 0C5h, 8Eh, 99h, 03h, 00h, 0ACh, 0C7h ; 14895
	DB 03h, 00h, 0A8h, 0C7h, 03h, 00h, 0ACh, 0C7h ; 1489d
	DB 03h, 00h, 0BCh, 0C7h, 02h, 00h, 0B8h, 0C7h ; 148a5
	DB 02h, 00h, 0B4h, 0C7h, 8Eh, 99h, 7Bh, 0A7h ; 148ad
	DB 0BBh ; 148b5
	ASCII "H" ; 148b6
	DB 0DFh ; 148b7
	ASCII "H" ; 148b8
	DB 03h ; 148b9
	ASCII "I" ; 148ba
	DB 04h, 00h, 5Ch, 0C4h, 04h, 00h, 14h, 0C4h ; 148bb
	DB 04h, 00h, 60h, 0C4h, 04h, 00h, 14h, 0C4h ; 148c3
	DB 04h, 00h, 5Ch, 0C4h, 04h, 00h, 14h, 0C4h ; 148cb
	DB 04h, 00h, 60h, 0C4h, 05h, 00h, 14h, 0C4h ; 148d3
	DB 0C1h, 99h, 0B3h ; 148db
	ASCII "H" ; 148de
	DB 04h, 00h, 00h, 0C6h, 04h, 00h, 0B4h, 0C5h ; 148df
	DB 04h, 00h, 04h, 0C6h, 04h, 00h, 0B4h, 0C5h ; 148e7
	DB 04h, 00h, 00h, 0C6h, 04h, 00h, 0B4h, 0C5h ; 148ef
	DB 04h, 00h, 04h, 0C6h, 05h, 00h, 0B4h, 0C5h ; 148f7
	DB 0C1h, 99h, 0B3h ; 148ff
	ASCII "H" ; 14902
	DB 04h, 00h, 0F4h, 0C7h, 04h, 00h, 0A8h, 0C7h ; 14903
	DB 04h, 00h, 0F8h, 0C7h, 04h, 00h, 0A8h, 0C7h ; 1490b
	DB 04h, 00h, 0F4h, 0C7h, 04h, 00h, 0A8h, 0C7h ; 14913
	DB 04h, 00h, 0F8h, 0C7h, 05h, 00h, 0A8h, 0C7h ; 1491b
	DB 0C1h, 99h, 0B3h ; 14923
	ASCII "H" ; 14926
	DB 0CEh, 0D0h, 15h, 1Bh ; 14927
	ASCII "2" ; 1492b
	DB 03h, 0E7h, 0Ah, 0CEh, 0D0h ; 1492c
	ASCII "B" ; 14931
	DB 16h, 96h, 01h, 0EBh, 0E1h, 00h, 0CEh, 0D0h ; 14932
	DB 14h, 1Bh, 28h, 0E6h ; 1493a
	ASCII "f" ; 1493e
	DB 0CEh, 0D0h, 0E7h, 1Ah, 96h, 10h, 0E6h, 5Eh ; 1493f
	DB 0B9h ; 14947
	ASCII "7" ; 14948
	DB 1Bh, 0C1h, 1Ah, 00h, 0CFh, 0C0h, 0D4h, 9Bh ; 14949
	DB 0ACh, 0E6h ; 14951
	ASCII "V" ; 14953
	DB 0D4h, 13h, 0ADh, 0E6h ; 14954
	ASCII "V" ; 14958
	DB 0D4h, 15h, 0ADh, 0E6h ; 14959
	ASCII "V" ; 1495d
	DB 0D4h ; 1495e
	ASCII "S" ; 1495f
	DB 0ADh, 0E6h ; 14960
	ASCII "V" ; 14962
	DB 0D4h, 5Bh, 0ADh, 0E6h ; 14963
	ASCII "V" ; 14967
	DB 0D4h ; 14968
	ASCII "c" ; 14969
	DB 0ADh, 0E6h ; 1496a
	ASCII "V" ; 1496c
	DB 0D4h ; 1496d
	ASCII "k" ; 1496e
	DB 0ADh, 0E6h ; 1496f
	ASCII "V" ; 14971
	DB 0D4h ; 14972
	ASCII "s" ; 14973
	DB 0ADh, 0E6h ; 14974
	ASCII "V" ; 14976
	DB 0D4h, 84h, 0ADh, 0E6h ; 14977
	ASCII "V" ; 1497b
	DB 0D4h, 8Ch, 0ADh, 0E6h ; 1497c
	ASCII "V" ; 14980
	DB 0D4h, 94h, 0ADh, 0E6h ; 14981
	ASCII "V" ; 14985
	DB 0D4h, 9Ch, 0ADh, 0E6h ; 14986
	ASCII "V" ; 1498a
	DB 0D4h, 1Eh, 0AFh, 0E6h ; 1498b
	ASCII "V" ; 1498f
	DB 0D4h, 26h, 0AFh, 0E6h ; 14990
	ASCII "V" ; 14994
	DB 0D4h, 0F7h, 0B6h, 0E6h ; 14995
	ASCII "V" ; 14999
	DB 0D4h, 1Eh, 0B0h, 0E6h ; 1499a
	ASCII "V" ; 1499e
	DB 0D4h, 82h, 0AFh, 0E6h ; 1499f
	ASCII "V" ; 149a3
	DB 0C4h ; 149a4
	ASCII "r" ; 149a5
	DB 1Ah, 0F1h ; 149a6
	ASCII "V" ; 149a8
	DB 0C4h, 0D3h ; 149a9
	ASCII "E" ; 149ab
	DB 0F1h ; 149ac
	ASCII "Q" ; 149ad
	DB 0C4h ; 149ae
	ASCII "sE" ; 149af
	DB 0F1h ; 149b1
	ASCII "L" ; 149b2
	DB 0C4h, 9Fh ; 149b3
	ASCII "E" ; 149b5
	DB 0F1h ; 149b6
	ASCII "G" ; 149b7
	DB 0C4h, 0C5h ; 149b8
	ASCII "F" ; 149ba
	DB 0F1h ; 149bb
	ASCII "B" ; 149bc
	DB 0C4h ; 149bd
	ASCII "CF" ; 149be
	DB 0F1h, 3Dh, 0C4h, 0DFh ; 149c0
	ASCII "F" ; 149c4
	DB 0F1h ; 149c5
	ASCII "8" ; 149c6
	DB 0C4h, 5Dh ; 149c7
	ASCII "F" ; 149c9
	DB 0F1h ; 149ca
	ASCII "3" ; 149cb
	DB 0C4h, 0F9h ; 149cc
	ASCII "F" ; 149ce
	DB 0F1h, 2Eh, 0C4h ; 149cf
	ASCII "wF" ; 149d2
	DB 0F1h, 29h, 0C4h, 91h ; 149d4
	ASCII "F" ; 149d8
	DB 0F1h, 24h, 0C4h, 29h ; 149d9
	ASCII "F" ; 149dd
	DB 0F1h, 1Fh, 0C4h, 0ABh ; 149de
	ASCII "F" ; 149e2
	DB 0F1h, 1Ah, 0C4h, 0B9h ; 149e3
	ASCII "E" ; 149e7
	DB 0F1h, 15h, 0C4h, 0DFh ; 149e8
	ASCII "G" ; 149ec
	DB 0F1h, 10h, 0C4h, 0F9h ; 149ed
	ASCII "G" ; 149f1
	DB 0F1h, 0Bh, 0C4h, 0B3h ; 149f2
	ASCII "H" ; 149f6
	DB 0F1h, 06h, 0C4h, 5Dh ; 149f7
	ASCII "H" ; 149fb
	DB 0F1h, 01h, 0CEh ; 149fc
	ASCII "P" ; 149ff
	DB 18h, 0CEh ; 14a00
	ASCII "X" ; 14a02
	DB 19h, 0CFh ; 14a03
	ASCII "8" ; 14a05
	DB 0E6h, 0Ah, 0CEh ; 14a06
	ASCII "D" ; 14a09
	DB 18h, 0CEh ; 14a0a
	ASCII "L" ; 14a0c
	DB 19h, 0F2h, 3Fh, 0AFh, 0F8h, 0B5h, 0B5h, 27h ; 14a0d
	DB 0C9h ; 14a15
	ASCII "v" ; 14a16
	DB 1Ah, 0A6h, 0A3h, 0CEh, 40h, 14h, 0CEh ; 14a17
	ASCII "H" ; 14a1e
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 14a1f
	DB 0A2h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 0B1h ; 14a27
	DB 00h, 0C6h ; 14a2f
	ASCII "bJ" ; 14a31
	DB 0CFh, 40h, 0CEh, 0C6h, 01h ; 14a33
	ASCII "G" ; 14a38
	DB 06h, 0CEh, 0D1h, 10h, 1Bh ; 14a39
	ASCII "1" ; 14a3e
	DB 0E5h, 1Eh, 92h ; 14a3f
	ASCII "G" ; 14a42
	DB 06h ; 14a43
	ASCII "1" ; 14a44
	DB 0E4h, 18h, 93h, 92h ; 14a45
	ASCII "G" ; 14a49
	DB 06h, 0CEh, 0D1h, 11h, 1Bh ; 14a4a
	ASCII "1" ; 14a4f
	DB 0E5h, 0Dh, 92h ; 14a50
	ASCII "G" ; 14a53
	DB 06h ; 14a54
	ASCII "1" ; 14a55
	DB 0E4h, 07h, 0C5h, 0E7h, 1Ah, 0CEh, 25h, 0EFh ; 14a56
	DB 0AAh, 0ABh, 0AEh, 0F8h, 25h, 29h, 15h, 1Ch ; 14a5e
	DB 23h, 28h, 0Ch, 14h, 1Bh, 21h, 16h, 1Dh ; 14a66
	DB 01h, 00h, 3Ch, 0CBh, 8Eh, 99h, 01h, 00h ; 14a6e
	DB 40h, 0CBh, 8Eh, 99h, 0C5h ; 14a76
	ASCII "nJ" ; 14a7b
	DB 0CEh, 0D0h ; 14a7d
	ASCII "B" ; 14a7f
	DB 16h, 96h, 09h, 0E6h, 04h, 0C5h ; 14a80
	ASCII "tJ" ; 14a86
	DB 0CFh, 0E1h, 0F2h, 0C3h, 0AEh, 0F8h ; 14a88
	ASCII "q" ; 14a8e
	DB 9Ah ; 14a8f
	ASCII "q" ; 14a90
	DB 9Ah ; 14a91
	ASCII "nJ" ; 14a92
	DB 01h, 00h ; 14a94
	ASCII "D" ; 14a96
	DB 0CBh, 8Eh, 99h, 9Dh, 99h ; 14a97
	ASCII "q" ; 14a9c
	DB 9Ah, 02h, 00h ; 14a9d
	ASCII "D" ; 14aa0
	DB 0CBh, 9Dh, 99h, 0BEh, 0CAh, 01h, 00h ; 14aa1
	ASCII "H" ; 14aa8
	DB 0CBh, 8Eh, 99h, 9Dh, 99h ; 14aa9
	ASCII "q" ; 14aae
	DB 9Ah, 02h, 00h ; 14aaf
	ASCII "D" ; 14ab2
	DB 0CBh, 9Dh, 99h, 0BEh, 0CAh, 01h, 00h ; 14ab3
	ASCII "L" ; 14aba
	DB 0CBh, 8Eh, 99h, 0CEh, 0D0h ; 14abb
	ASCII "B" ; 14ac0
	DB 16h, 96h, 40h, 0E7h, 0Ah, 96h, 20h, 0E7h ; 14ac1
	DB 19h, 0C4h, 94h ; 14ac9
	ASCII "J" ; 14acc
	DB 0F1h, 25h, 0C4h, 0ACh ; 14acd
	ASCII "J" ; 14ad1
	DB 0CEh ; 14ad2
	ASCII "P" ; 14ad3
	DB 14h, 0CEh ; 14ad4
	ASCII "X" ; 14ad6
	DB 15h, 0D5h ; 14ad7
	ASCII "H" ; 14ad9
	DB 0CBh, 0E6h, 17h, 0C4h, 0B4h ; 14ada
	ASCII "J" ; 14adf
	DB 0F1h, 12h, 0C4h, 9Ah ; 14ae0
	ASCII "J" ; 14ae4
	DB 0CEh ; 14ae5
	ASCII "P" ; 14ae6
	DB 14h, 0CEh ; 14ae7
	ASCII "X" ; 14ae9
	DB 15h, 0D5h ; 14aea
	ASCII "L" ; 14aec
	DB 0CBh, 0E6h, 04h, 0C4h, 0A2h ; 14aed
	ASCII "J" ; 14af2
	DB 0F2h ; 14af3
	ASCII "Z" ; 14af4
	DB 0AEh, 0F8h ; 14af5
	ASCII "q" ; 14af7
	DB 9Ah, 0BEh, 0CAh, 94h ; 14af8
	ASCII "J" ; 14afc
	DB 9Dh, 99h, 0CAh, 0CCh, 04h, 00h ; 14afd
	ASCII "P" ; 14b03
	DB 0CBh, 04h, 00h, 0ECh, 0CCh, 0C1h, 99h, 01h ; 14b04
	ASCII "K" ; 14b0c
	DB 9Dh, 99h, 0CAh, 0CCh, 04h, 00h, 60h, 0CBh ; 14b0d
	DB 04h, 00h, 0F4h, 0CCh, 0C1h, 99h, 11h ; 14b15
	ASCIZ "K" ; 14b1c
	DB 9Dh, 99h, 0CAh, 0CCh, 04h, 00h ; 14b1e
	ASCII "P" ; 14b24
	DB 0CBh, 04h, 00h ; 14b25
	ASCII "X" ; 14b28
	DB 0CBh, 0C1h, 99h, 22h ; 14b29
	ASCII "K" ; 14b2d
	DB 9Dh, 99h, 0CAh, 0CCh, 04h, 00h, 60h, 0CBh ; 14b2e
	DB 04h, 00h ; 14b36
	ASCII "h" ; 14b38
	DB 0CBh, 0C1h, 99h ; 14b39
	ASCII "2K" ; 14b3c
	DB 9Dh, 99h ; 14b3e
	ASCII "q" ; 14b40
	DB 9Ah ; 14b41
	ASCII "O" ; 14b42
	DB 9Ah, 19h, 0Ch, 0CCh, 04h, 00h ; 14b43
	ASCII "p" ; 14b49
	DB 0CBh, 04h, 00h ; 14b4a
	ASCII "x" ; 14b4d
	DB 0CBh, 04h, 00h, 80h, 0CBh, 9Dh, 99h, 0BAh ; 14b4e
	DB 0CBh, 04h, 00h, 60h, 0CBh, 9Dh, 99h ; 14b56
	ASCII "q" ; 14b5d
	DB 9Ah ; 14b5e
	ASCII "O" ; 14b5f
	DB 9Ah, 19h, 0Ch, 0CCh, 04h, 00h, 88h, 0CBh ; 14b60
	DB 04h, 00h, 90h, 0CBh, 04h, 00h, 98h, 0CBh ; 14b68
	DB 9Dh, 99h, 0CEh, 0CBh, 04h, 00h ; 14b70
	ASCII "P" ; 14b76
	DB 0CBh, 0C1h, 99h, 3Eh ; 14b77
	ASCII "K" ; 14b7b
	DB 9Dh, 99h ; 14b7c
	ASCII "q" ; 14b7e
	DB 9Ah ; 14b7f
	ASCII "O" ; 14b80
	DB 9Ah, 19h, 08h, 0CCh, 04h, 00h, 0BCh, 0CBh ; 14b81
	DB 04h, 00h, 0C4h, 0CBh, 04h, 00h, 0CCh, 0CBh ; 14b89
	DB 9Dh, 99h, 0E1h, 0CBh, 04h, 00h, 60h, 0CBh ; 14b91
	DB 9Dh, 99h ; 14b99
	ASCII "q" ; 14b9b
	DB 9Ah ; 14b9c
	ASCII "O" ; 14b9d
	DB 9Ah, 19h, 08h, 0CCh, 04h, 00h, 0A4h, 0CBh ; 14b9e
	DB 04h, 00h, 0ACh, 0CBh, 04h, 00h, 0B4h, 0CBh ; 14ba6
	DB 9Dh, 99h, 0F5h, 0CBh, 04h, 00h ; 14bae
	ASCII "P" ; 14bb4
	DB 0CBh, 0C1h, 99h, 7Ch ; 14bb5
	ASCII "K" ; 14bb9
	DB 0CEh, 0D0h ; 14bba
	ASCII "B" ; 14bbc
	DB 16h, 96h, 40h, 0E7h, 0Ch, 0B0h, 01h, 0CEh ; 14bbd
	ASCII "D" ; 14bc5
	DB 1Ah, 0C4h, 0Dh ; 14bc6
	ASCII "K" ; 14bc9
	DB 0F2h, 83h, 0ADh, 0F8h, 0CEh, 0D0h ; 14bca
	ASCII "B" ; 14bd0
	DB 16h, 96h, 40h, 0E7h, 0Bh ; 14bd1
	ASCII "8" ; 14bd6
	DB 0CEh ; 14bd7
	ASCII "D" ; 14bd8
	DB 1Ah, 0C4h, 0FDh ; 14bd9
	ASCII "J" ; 14bdc
	DB 0F2h ; 14bdd
	ASCII "p" ; 14bde
	DB 0ADh, 0F8h, 0CEh, 0D0h ; 14bdf
	ASCII "B" ; 14be3
	DB 16h, 96h, 20h, 0E7h, 0Ch, 0B0h, 01h, 0CEh ; 14be4
	ASCII "D" ; 14bec
	DB 1Ah, 0C4h, 0Dh ; 14bed
	ASCII "K" ; 14bf0
	DB 0F2h, 5Ch, 0ADh, 0F8h, 0CEh, 0D0h ; 14bf1
	ASCII "B" ; 14bf7
	DB 16h, 96h, 20h, 0E7h, 0Bh ; 14bf8
	ASCII "8" ; 14bfd
	DB 0CEh ; 14bfe
	ASCII "D" ; 14bff
	DB 1Ah, 0C4h, 0FDh ; 14c00
	ASCII "J" ; 14c03
	DB 0F2h ; 14c04
	ASCII "I" ; 14c05
	DB 0ADh, 0F8h, 0B0h, 01h, 0F1h, 07h, 0B0h, 02h ; 14c06
	DB 0F1h, 03h, 0B0h, 03h, 0CEh ; 14c0e
	ASCII "H" ; 14c13
	DB 1Bh ; 14c14
	ASCII "1" ; 14c15
	DB 0E6h, 2Eh, 0CEh ; 14c16
	ASCII "D" ; 14c19
	DB 1Bh, 0CEh, 0D0h, 3Fh, 1Bh, 28h, 0E7h, 24h ; 14c1a
	DB 0C5h, 40h, 1Bh ; 14c22
	ASCII "E(" ; 14c25
	DB 0E6h, 04h, 8Eh, 0F1h, 1Ah, 0B5h, 03h, 0F2h ; 14c27
	DB 0Dh, 01h, 0F2h ; 14c2f
	ASCII "I" ; 14c32
	DB 0E3h, 0CEh, 0C4h, 01h, 0F2h, 85h, 0CEh, 0E7h ; 14c33
	DB 0Ah, 0F2h, 0B8h, 0E3h, 0CEh, 0C4h, 01h, 0F2h ; 14c3b
	DB 0A5h, 0F4h, 0F8h, 0CEh, 40h, 19h, 28h, 0E7h ; 14c43
	DB 1Ah, 0CEh ; 14c4b
	ASCII "P" ; 14c4d
	DB 02h, 0CEh ; 14c4e
	ASCII "X" ; 14c50
	DB 03h, 0D5h, 1Dh ; 14c51
	ASCII "K" ; 14c54
	DB 0E4h, 2Bh, 0C5h, 0FDh ; 14c55
	ASCII "J" ; 14c59
	DB 0CEh, 40h, 1Ah, 28h, 0E6h, 1Dh, 0C5h, 0Dh ; 14c5a
	ASCII "K" ; 14c62
	DB 0F1h, 18h, 0CEh ; 14c63
	ASCII "P" ; 14c66
	DB 02h, 0CEh ; 14c67
	ASCII "X" ; 14c69
	DB 03h, 0D5h, 1Dh ; 14c6a
	ASCII "K" ; 14c6d
	DB 0E5h, 12h, 0C5h, 1Eh ; 14c6e
	ASCII "K" ; 14c72
	DB 0CEh, 40h, 1Ah, 28h, 0E6h, 04h, 0C5h, 2Eh ; 14c73
	ASCII "K" ; 14c7b
	DB 0CFh, 0E1h, 0F2h, 0CFh, 0ACh, 0F8h, 0CEh, 0D0h ; 14c7c
	ASCII "q" ; 14c84
	DB 16h, 22h, 0Fh, 0E7h, 0Ch, 0CEh, 0D0h ; 14c85
	ASCII "B" ; 14c8c
	DB 16h, 22h, 09h, 0E6h, 04h, 0F2h, 7Ch, 0FFh ; 14c8d
	DB 0CEh, 0D0h ; 14c95
	ASCII "B" ; 14c97
	DB 16h, 96h, 09h, 0E6h, 16h, 0CEh, 0D0h, 0B6h ; 14c98
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 18h, 0CEh, 0D4h ; 14ca0
	DB 0FAh, 14h, 0CEh, 40h, 19h, 80h ; 14ca8
	ASCII "2" ; 14cae
	DB 04h, 0E4h, 15h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 14caf
	DB 0E6h, 07h, 0B0h, 00h, 0CEh, 0D4h, 0FAh, 14h ; 14cb7
	DB 0CEh, 40h, 19h, 28h, 0E6h, 02h, 88h, 0CEh ; 14cbf
	ASCII "D" ; 14cc7
	DB 19h, 0F8h, 0CEh, 0D0h ; 14cc8
	ASCII "B" ; 14ccc
	DB 16h, 96h, 20h, 0E7h, 13h, 96h, 40h, 0E6h ; 14ccd
	DB 21h, 0C5h, 3Eh ; 14cd5
	ASCII "K" ; 14cd8
	DB 0CEh, 40h, 1Ah, 28h, 0E6h, 12h, 0C5h, 5Bh ; 14cd9
	ASCII "K" ; 14ce1
	DB 0F1h, 0Dh, 0C5h, 7Ch ; 14ce2
	ASCII "K" ; 14ce6
	DB 0CEh, 40h, 1Ah, 28h, 0E6h, 04h, 0C5h, 99h ; 14ce7
	ASCII "K" ; 14cef
	DB 0CFh, 0E1h, 0F2h, 5Bh, 0ACh, 0F8h, 0F2h, 8Ah ; 14cf0
	DB 0FFh, 0F2h ; 14cf8
	ASCII "K" ; 14cfa
	DB 0FFh, 0CEh, 40h, 19h, 28h, 0E6h, 27h, 0CEh ; 14cfb
	DB 40h, 1Ah, 28h, 0E6h, 0Fh, 0CEh, 40h, 0Ah ; 14d03
	DB 0CEh, 00h, 19h ; 14d0b
	ASCII "2P" ; 14d0e
	DB 0E4h, 0Eh, 0B0h ; 14d10
	ASCII "P" ; 14d13
	DB 0F1h, 0Ah, 0CEh, 40h, 0Ah, 0CEh, 10h, 19h ; 14d14
	DB 0E5h, 02h ; 14d1c
	ASCII "8" ; 14d1e
	DB 0CEh ; 14d1f
	ASCII "H" ; 14d20
	DB 0Eh, 0BCh, 12h, 1Bh, 0F2h, 5Bh, 0ACh, 0F8h ; 14d21
	ASCII "8" ; 14d29
	DB 0CEh ; 14d2a
	ASCII "D" ; 14d2b
	DB 18h, 0CEh ; 14d2c
	ASCII "D" ; 14d2e
	DB 19h, 0CEh ; 14d2f
	ASCII "D" ; 14d31
	DB 1Ah, 0CEh ; 14d32
	ASCII "D" ; 14d34
	DB 1Bh, 0F8h, 29h, 0CDh ; 14d35
	ASCII "q" ; 14d39
	DB 9Ah, 0FDh ; 14d3a
	ASCII "J" ; 14d3c
	DB 0B0h, 09h, 0CEh, 0D4h, 3Fh, 1Bh, 0F8h, 9Dh ; 14d3d
	DB 99h, 26h, 0CEh, 01h, 00h, 0CCh, 0CAh, 8Eh ; 14d45
	DB 99h, 9Dh, 99h ; 14d4d
	ASCII "q" ; 14d50
	DB 9Ah, 01h, 00h, 0D4h, 0CAh, 0BBh, 99h, 04h ; 14d51
	DB 0F4h, 99h, 0FFh, 00h, 97h, 99h, 01h, 0C4h ; 14d59
	DB 99h ; 14d61
	ASCII "YM" ; 14d62
	DB 9Dh, 99h, 0F1h, 0CEh, 01h, 00h, 0CCh, 0CAh ; 14d64
	DB 0BBh, 99h, 04h, 0F4h, 99h, 01h, 00h, 97h ; 14d6c
	DB 99h, 01h, 0C4h, 99h ; 14d74
	ASCII "oM" ; 14d78
	DB 0C1h, 99h ; 14d7a
	ASCII "DM" ; 14d7c
	DB 9Dh, 99h ; 14d7e
	ASCII "q" ; 14d80
	DB 9Ah, 01h, 00h, 0D4h, 0CAh, 0BBh, 99h, 04h ; 14d81
	DB 0F4h, 99h, 01h, 00h, 97h, 99h, 01h, 0C4h ; 14d89
	DB 99h, 89h ; 14d91
	ASCII "M" ; 14d93
	DB 9Dh, 99h, 0F5h, 0CEh, 01h, 00h, 0CCh, 0CAh ; 14d94
	DB 0BBh, 99h, 04h, 0F4h, 99h, 0FFh, 00h, 97h ; 14d9c
	DB 99h, 01h, 0C4h, 99h, 9Fh ; 14da4
	ASCII "M" ; 14da9
	DB 0C1h, 99h ; 14daa
	ASCII "DM" ; 14dac
	DB 9Dh, 99h ; 14dae
	ASCII "q" ; 14db0
	DB 9Ah, 01h, 00h, 0D4h, 0CAh, 0BBh, 99h, 04h ; 14db1
	DB 0F4h, 99h, 00h, 0FFh, 97h, 99h, 01h, 0C4h ; 14db9
	DB 99h, 0B9h ; 14dc1
	ASCII "M" ; 14dc3
	DB 9Dh, 99h, 0E9h, 0CEh, 01h, 00h, 0CCh, 0CAh ; 14dc4
	DB 0BBh, 99h, 04h, 0F4h, 99h, 00h, 01h, 97h ; 14dcc
	DB 99h, 01h, 0C4h, 99h, 0CFh ; 14dd4
	ASCII "M" ; 14dd9
	DB 0C1h, 99h ; 14dda
	ASCII "DM" ; 14ddc
	DB 9Dh, 99h ; 14dde
	ASCII "q" ; 14de0
	DB 9Ah, 01h, 00h, 0D4h, 0CAh, 0BBh, 99h, 04h ; 14de1
	DB 0F4h, 99h, 00h, 01h, 97h, 99h, 01h, 0C4h ; 14de9
	DB 99h, 0E9h ; 14df1
	ASCII "M" ; 14df3
	DB 9Dh, 99h, 0EDh, 0CEh, 01h, 00h, 0CCh, 0CAh ; 14df4
	DB 0BBh, 99h, 04h, 0F4h, 99h, 00h, 0FFh, 97h ; 14dfc
	DB 99h, 01h, 0C4h, 99h, 0FFh ; 14e04
	ASCII "M" ; 14e09
	DB 0C1h, 99h ; 14e0a
	ASCII "DM" ; 14e0c
	DB 9Dh, 99h ; 14e0e
	ASCII "q" ; 14e10
	DB 9Ah, 04h, 00h, 0D4h, 0CAh, 04h, 00h, 0CCh ; 14e11
	DB 0CAh, 04h, 00h, 0D4h, 0CAh, 04h, 00h, 0CCh ; 14e19
	DB 0CAh, 0C1h, 99h ; 14e21
	ASCII "DM" ; 14e24
	DB 0CEh, 0D0h ; 14e26
	ASCII "B" ; 14e28
	DB 16h, 0C5h ; 14e29
	ASCII "NM" ; 14e2b
	DB 96h, 20h, 0E7h, 1Dh, 0C5h, 7Eh ; 14e2d
	ASCII "M" ; 14e33
	DB 96h, 40h, 0E7h, 16h, 0C5h, 0AEh ; 14e34
	ASCII "M" ; 14e3a
	DB 96h, 08h, 0E7h, 0Fh, 0C5h, 0DEh ; 14e3b
	ASCII "M" ; 14e41
	DB 96h, 10h, 0E7h, 08h, 0C5h, 0Eh ; 14e42
	ASCII "N" ; 14e48
	DB 96h, 01h, 0E6h, 06h, 0CFh, 0E1h, 0F2h, 0FEh ; 14e49
	DB 0AAh, 0F8h ; 14e51
	ASCII "q" ; 14e53
	DB 9Ah, 26h, 0CEh ; 14e54
	ASCII "DM" ; 14e57
	DB 9Dh, 99h ; 14e59
	ASCII "q" ; 14e5b
	DB 9Ah, 04h, 00h, 08h, 0CBh, 9Dh, 99h, 0F1h ; 14e5c
	DB 0CEh, 01h, 00h, 0Ch, 0CBh, 9Dh, 99h ; 14e64
	ASCII "q" ; 14e6b
	DB 9Ah, 04h, 00h, 08h, 0CBh, 0C1h, 99h, 08h ; 14e6c
	ASCII "O" ; 14e74
	DB 9Dh, 99h ; 14e75
	ASCII "q" ; 14e77
	DB 9Ah, 04h, 00h, 10h, 0CBh, 9Dh, 99h, 0F5h ; 14e78
	DB 0CEh, 01h, 00h, 14h, 0CBh, 9Dh, 99h ; 14e80
	ASCII "q" ; 14e87
	DB 9Ah, 04h, 00h, 10h, 0CBh, 0C1h, 99h, 08h ; 14e88
	ASCII "O" ; 14e90
	DB 9Dh, 99h ; 14e91
	ASCII "q" ; 14e93
	DB 9Ah, 04h, 00h, 18h, 0CBh, 9Dh, 99h, 0EDh ; 14e94
	DB 0CEh, 01h, 00h, 1Ch, 0CBh, 9Dh, 99h ; 14e9c
	ASCII "q" ; 14ea3
	DB 9Ah, 04h, 00h, 18h, 0CBh, 0C1h, 99h, 08h ; 14ea4
	ASCII "O" ; 14eac
	DB 9Dh, 99h ; 14ead
	ASCII "q" ; 14eaf
	DB 9Ah, 04h, 00h, 20h, 0CBh, 9Dh, 99h, 0E9h ; 14eb0
	DB 0CEh, 01h, 00h, 24h, 0CBh, 9Dh, 99h ; 14eb8
	ASCII "q" ; 14ebf
	DB 9Ah, 04h, 00h, 20h, 0CBh, 0C1h, 99h, 08h ; 14ec0
	ASCII "O" ; 14ec8
	DB 9Dh, 99h ; 14ec9
	ASCII "q" ; 14ecb
	DB 9Ah, 03h, 00h, 28h, 0CBh, 02h, 00h, 2Ch ; 14ecc
	DB 0CBh, 02h, 00h ; 14ed4
	ASCII "0" ; 14ed7
	DB 0CBh, 02h, 00h ; 14ed8
	ASCII "4" ; 14edb
	DB 0CBh, 03h, 00h ; 14edc
	ASCII "8" ; 14edf
	DB 0CBh, 04h, 00h, 28h, 0CBh, 0C1h, 99h, 08h ; 14ee0
	ASCII "O" ; 14ee8
	DB 0B1h, 08h, 0F1h, 0Dh, 0B1h, 10h, 0F1h, 09h ; 14ee9
	DB 0B1h, 20h, 0F1h, 05h, 0B1h, 40h, 0F1h, 01h ; 14ef1
	DB 0CEh, 0D0h ; 14ef9
	ASCII "B" ; 14efb
	DB 16h, 94h, 0E6h, 08h, 0CEh, 40h, 06h, 80h ; 14efc
	DB 0CEh ; 14f04
	ASCII "D" ; 14f05
	DB 06h, 0F8h, 9Dh, 99h, 18h, 0CFh, 04h, 00h ; 14f06
	DB 00h, 0CBh, 04h, 00h, 04h, 0CBh, 0C1h, 99h ; 14f0e
	DB 0Ch ; 14f16
	ASCII "O" ; 14f17
	DB 0CEh, 0D0h ; 14f18
	ASCII "B" ; 14f1a
	DB 16h, 0C5h ; 14f1b
	ASCII "YN" ; 14f1d
	DB 96h, 20h, 0E7h, 1Dh, 0C5h ; 14f1f
	ASCII "uN" ; 14f24
	DB 96h, 40h, 0E7h, 16h, 0C5h, 0ADh ; 14f26
	ASCII "N" ; 14f2c
	DB 96h, 08h, 0E7h, 0Fh, 0C5h, 91h ; 14f2d
	ASCII "N" ; 14f33
	DB 96h, 10h, 0E7h, 08h, 0C5h, 0C9h ; 14f34
	ASCII "N" ; 14f3a
	DB 96h, 01h, 0E6h ; 14f3b
	ASCII "0" ; 14f3e
	DB 0CFh, 0E1h, 0F2h, 0Ch, 0AAh, 0CEh, 0D0h, 3Fh ; 14f3f
	DB 1Bh, 28h, 0E7h, 24h, 0C5h, 40h, 1Bh ; 14f47
	ASCII "E(" ; 14f4e
	DB 0E6h, 04h, 8Eh, 0F1h, 1Ah, 0B5h, 03h, 0F2h ; 14f50
	DB 0E4h, 0FDh, 0F2h, 20h, 0E0h, 0CEh, 0C4h, 01h ; 14f58
	DB 0F2h, 5Ch, 0CBh, 0E7h, 0Ah, 0F2h, 99h, 0E0h ; 14f60
	DB 0CEh, 0C4h, 01h, 0F2h, 7Ch, 0F1h, 0F8h ; 14f68
	ASCII "q" ; 14f6f
	DB 9Ah, 18h, 0CFh, 08h ; 14f70
	ASCII "O" ; 14f74
	DB 04h, 00h, 0E0h, 0CAh, 04h, 00h, 0E8h, 0CAh ; 14f75
	DB 04h, 00h, 0E0h, 0CAh, 04h, 00h, 0F4h, 0CAh ; 14f7d
	DB 0C1h, 99h ; 14f85
	ASCII "uOq" ; 14f87
	DB 9Ah ; 14f8a
	ASCII "q" ; 14f8b
	DB 9Ah ; 14f8c
	ASCII "uO" ; 14f8d
	DB 01h, 00h, 0DCh, 0CAh, 8Eh, 99h ; 14f8f
	ASCII "q" ; 14f95
	DB 9Ah ; 14f96
	ASCII "q" ; 14f97
	DB 9Ah, 8Fh ; 14f98
	ASCII "O" ; 14f9a
	DB 0CEh, 40h, 18h, 28h, 0E6h, 04h, 0C7h, 0A5h ; 14f9b
	ASCII "O" ; 14fa3
	DB 0F8h, 9Dh, 99h, 0E1h, 0D6h, 0BBh, 99h, 03h ; 14fa4
	ASCII "O" ; 14fac
	DB 9Ah, 1Ah, 01h, 00h, 08h, 0CCh, 02h, 00h ; 14fad
	DB 14h, 0CCh, 03h, 00h, 20h, 0CCh, 01h, 00h ; 14fb5
	DB 0E4h, 0CBh, 02h, 00h, 0F0h, 0CBh, 03h, 00h ; 14fbd
	DB 0FCh, 0CBh, 9Bh, 0CFh, 0C4h, 99h, 0ACh ; 14fc5
	ASCII "O" ; 14fcc
	DB 9Dh, 99h, 0B0h, 0D6h, 03h, 00h, 0D8h, 0CBh ; 14fcd
	DB 03h, 00h, 0FCh, 0CBh, 11h, 00h, 0D8h, 0CBh ; 14fd5
	DB 97h, 99h, 01h, 01h, 00h, 0D8h, 0CBh, 8Eh ; 14fdd
	DB 99h, 0BEh ; 14fe5
	ASCII "9" ; 14fe7
	DB 1Bh, 0F8h, 0E6h, 0CFh, 0B0h, 0D6h, 0E0h ; 14fe8
	ASCII "OO" ; 14fef
	DB 97h, 80h, 0E6h, 0Ch, 0CEh, 40h, 0Ah, 01h ; 14ff1
	DB 96h, 80h, 0E4h, 0Eh ; 14ff9
	ASCII "8" ; 14ffd
	DB 0F1h, 0Bh, 0CEh, 40h, 0Ah, 01h ; 14ffe
	ASCII "2P" ; 15004
	DB 0E4h, 03h, 0B0h ; 15006
	ASCII "P" ; 15009
	DB 0CEh, 0D4h, 12h, 1Bh, 0CEh ; 1500a
	ASCII "D" ; 1500f
	DB 0Ah, 93h, 0F8h, 0CEh, 0D0h, 0E9h, 1Ah, 0CEh ; 15010
	DB 0C4h, 02h, 0F2h ; 15018
	ASCII "Z" ; 1501b
	DB 0D4h ; 1501c
	ASCII "2" ; 1501d
	DB 02h, 0EEh, 12h, 0Ah ; 1501e
	ASCII "2" ; 15022
	DB 07h, 0EEh ; 15023
	ASCII "H" ; 15025
	DB 13h, 0C4h, 03h, 00h, 0CEh, 0C4h, 03h, 0F2h ; 15026
	DB 0CFh, 0BFh, 00h, 0B1h, 00h, 0A6h, 0A2h, 0C6h ; 1502e
	ASCII "BP" ; 15036
	DB 0CEh, 0C6h, 01h, 0CFh, 40h, 0CFh, 0D3h, 0AAh ; 15038
	DB 0AEh, 0F8h ; 15040
	ASCII "zPzP" ; 15042
	DB 88h ; 15046
	ASCII "P" ; 15047
	DB 0B0h ; 15048
	ASCII "P" ; 15049
	DB 0CEh, 0D0h, 0E9h, 1Ah, 0CEh, 0C4h, 02h, 0F2h ; 1504a
	DB 23h, 0D4h ; 15052
	ASCII "2" ; 15054
	DB 02h, 0EEh, 0DBh, 09h, 0CEh, 0C4h, 02h, 0F2h ; 15055
	DB 0DDh, 07h, 0D5h, 00h, 00h, 0E6h, 04h, 0CFh ; 1505d
	DB 0EDh, 0F8h, 0CEh, 0D1h, 1Eh, 1Bh, 0CEh, 0D0h ; 15065
	DB 12h, 1Bh ; 1506d
	ASCII "1" ; 1506f
	DB 0E4h, 05h, 0C7h, 0D8h ; 15070
	ASCII "P" ; 15074
	DB 0F8h, 0C7h, 2Eh ; 15075
	ASCII "R" ; 15078
	DB 0F8h, 9Dh, 99h, 8Dh, 0D7h, 0Ah, 00h, 2Ch ; 15079
	DB 0CCh, 0Ah, 00h ; 15081
	ASCII "0" ; 15084
	DB 0CCh, 13h, 0D0h, 9Dh, 99h, 8Dh, 0D7h ; 15085
	ASCII "O" ; 1508c
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 04h, 00h, 0B0h ; 1508d
	DB 0CCh, 0F0h, 0CFh, 0FCh, 04h, 00h, 0B4h, 0CCh ; 15095
	DB 0F0h, 0CFh, 0FCh ; 1509d
	ASCII "O" ; 150a0
	DB 9Ah, 0Dh, 04h, 00h, 0B8h, 0CCh, 0F0h, 0CFh ; 150a1
	DB 0FCh, 04h, 00h, 0B4h, 0CCh, 13h, 0D0h, 9Dh ; 150a9
	DB 99h, 8Dh, 0D7h ; 150b1
	ASCII "O" ; 150b4
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 04h, 00h, 2Ch ; 150b5
	DB 0D3h, 0F0h, 0CFh, 04h, 04h, 00h ; 150bd
	ASCII "0" ; 150c3
	DB 0D3h ; 150c4
	ASCII "O" ; 150c5
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 04h, 00h ; 150c6
	ASCII "4" ; 150cd
	DB 0D3h, 0F0h, 0CFh, 04h, 04h, 00h ; 150ce
	ASCII "0" ; 150d4
	DB 0D3h, 13h, 0D0h, 9Dh, 99h, 15h, 0D7h ; 150d5
	ASCII "O" ; 150dc
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 7Bh, 0A7h, 0EAh ; 150dd
	ASCII "P" ; 150e5
	DB 0Ah ; 150e6
	ASCII "Q*Q" ; 150e7
	DB 03h, 00h, 0BCh, 0CCh, 0F0h, 0CFh, 0FBh, 03h ; 150ea
	DB 00h, 0C0h, 0CCh ; 150f2
	ASCII "O" ; 150f5
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h, 0C4h ; 150f6
	DB 0CCh, 0F0h, 0CFh, 0FBh, 03h, 00h, 0C8h, 0CCh ; 150fe
	DB 0C1h, 99h, 0DCh ; 15106
	ASCII "P" ; 15109
	DB 03h, 00h, 18h, 0D9h, 0F0h, 0CFh, 0FBh, 03h ; 1510a
	DB 00h, 1Ch, 0D9h ; 15112
	ASCII "O" ; 15115
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h, 20h ; 15116
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h, 1Ch, 0D9h ; 1511e
	DB 0C1h, 99h, 0DCh ; 15126
	ASCII "P" ; 15129
	DB 03h, 00h, 18h, 0D9h, 0F0h, 0CFh, 0FBh, 03h ; 1512a
	DB 00h, 1Ch, 0D9h ; 15132
	ASCII "O" ; 15135
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h, 20h ; 15136
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h, 24h, 0D9h ; 1513e
	DB 0C1h, 99h, 0DCh ; 15146
	ASCII "P" ; 15149
	DB 9Dh, 99h, 15h, 0D7h ; 1514a
	ASCII "O" ; 1514e
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 7Bh, 0A7h, 5Ch ; 1514f
	ASCII "Q|Q" ; 15157
	DB 9Ch ; 1515a
	ASCII "Q" ; 1515b
	DB 03h, 00h, 0CCh, 0CCh, 0F0h, 0CFh, 0FBh, 03h ; 1515c
	DB 00h, 0D0h, 0CCh ; 15164
	ASCII "O" ; 15167
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h, 0D4h ; 15168
	DB 0CCh, 0F0h, 0CFh, 0FBh, 03h, 00h, 0D8h, 0CCh ; 15170
	DB 0C1h, 99h ; 15178
	ASCII "NQ" ; 1517a
	DB 03h, 00h, 28h, 0D9h, 0F0h, 0CFh, 0FBh, 03h ; 1517c
	DB 00h, 2Ch, 0D9h ; 15184
	ASCII "O" ; 15187
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h ; 15188
	ASCII "0" ; 1518f
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h, 2Ch, 0D9h ; 15190
	DB 0C1h, 99h ; 15198
	ASCII "NQ" ; 1519a
	DB 03h, 00h, 28h, 0D9h, 0F0h, 0CFh, 0FBh, 03h ; 1519c
	DB 00h, 2Ch, 0D9h ; 151a4
	ASCII "O" ; 151a7
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h ; 151a8
	ASCII "0" ; 151af
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h ; 151b0
	ASCII "4" ; 151b6
	DB 0D9h, 0C1h, 99h ; 151b7
	ASCII "NQ" ; 151ba
	DB 9Dh, 99h, 15h, 0D7h ; 151bc
	ASCII "O" ; 151c0
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 7Bh, 0A7h, 0CEh ; 151c1
	ASCII "Q" ; 151c9
	DB 0EEh ; 151ca
	ASCII "Q" ; 151cb
	DB 0Eh ; 151cc
	ASCII "R" ; 151cd
	DB 03h, 00h, 0DCh, 0CCh, 0F0h, 0CFh, 0FBh, 03h ; 151ce
	DB 00h, 0E0h, 0CCh ; 151d6
	ASCII "O" ; 151d9
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h, 0E4h ; 151da
	DB 0CCh, 0F0h, 0CFh, 0FBh, 03h, 00h, 0E8h, 0CCh ; 151e2
	DB 0C1h, 99h, 0C0h ; 151ea
	ASCII "Q" ; 151ed
	DB 03h, 00h ; 151ee
	ASCII "8" ; 151f0
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h, 3Ch, 0D9h ; 151f1
	ASCII "O" ; 151f9
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h, 40h ; 151fa
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h, 3Ch, 0D9h ; 15202
	DB 0C1h, 99h, 0C0h ; 1520a
	ASCII "Q" ; 1520d
	DB 03h, 00h ; 1520e
	ASCII "8" ; 15210
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h, 3Ch, 0D9h ; 15211
	ASCII "O" ; 15219
	DB 9Ah, 0Dh, 0F0h, 0CFh, 0FCh, 03h, 00h, 40h ; 1521a
	DB 0D9h, 0F0h, 0CFh, 0FBh, 03h, 00h ; 15222
	ASCII "D" ; 15228
	DB 0D9h, 0C1h, 99h, 0C0h ; 15229
	ASCII "Q" ; 1522d
	DB 9Dh, 99h ; 1522e
	ASCII "Q" ; 15230
	DB 0D7h ; 15231
	ASCII "O" ; 15232
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 7Bh, 0A7h, 40h ; 15233
	ASCII "R`R" ; 1523b
	DB 80h ; 1523e
	ASCII "R" ; 1523f
	DB 03h, 00h ; 15240
	ASCII "8" ; 15242
	DB 0D3h, 0F0h, 0CFh, 05h, 03h, 00h, 3Ch, 0D3h ; 15243
	ASCII "O" ; 1524b
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h, 40h ; 1524c
	DB 0D3h, 0F0h, 0CFh, 05h, 03h, 00h ; 15254
	ASCII "D" ; 1525a
	DB 0D3h, 0C1h, 99h ; 1525b
	ASCII "2R" ; 1525e
	DB 03h, 00h, 2Ch, 0DBh, 0F0h, 0CFh, 05h, 03h ; 15260
	DB 00h ; 15268
	ASCII "0" ; 15269
	DB 0DBh ; 1526a
	ASCII "O" ; 1526b
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h ; 1526c
	ASCII "4" ; 15273
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h ; 15274
	ASCII "0" ; 1527a
	DB 0DBh, 0C1h, 99h ; 1527b
	ASCII "2R" ; 1527e
	DB 03h, 00h, 2Ch, 0DBh, 0F0h, 0CFh, 05h, 03h ; 15280
	DB 00h ; 15288
	ASCII "0" ; 15289
	DB 0DBh ; 1528a
	ASCII "O" ; 1528b
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h ; 1528c
	ASCII "4" ; 15293
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h ; 15294
	ASCII "8" ; 1529a
	DB 0DBh, 0C1h, 99h ; 1529b
	ASCII "2R" ; 1529e
	DB 9Dh, 99h ; 152a0
	ASCII "Q" ; 152a2
	DB 0D7h ; 152a3
	ASCII "O" ; 152a4
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 7Bh, 0A7h, 0B2h ; 152a5
	ASCII "R" ; 152ad
	DB 0D2h ; 152ae
	ASCII "R" ; 152af
	DB 0F2h ; 152b0
	ASCII "R" ; 152b1
	DB 03h, 00h ; 152b2
	ASCII "H" ; 152b4
	DB 0D3h, 0F0h, 0CFh, 05h, 03h, 00h ; 152b5
	ASCII "L" ; 152bb
	DB 0D3h ; 152bc
	ASCII "O" ; 152bd
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h ; 152be
	ASCII "P" ; 152c5
	DB 0D3h, 0F0h, 0CFh, 05h, 03h, 00h ; 152c6
	ASCII "T" ; 152cc
	DB 0D3h, 0C1h, 99h, 0A4h ; 152cd
	ASCII "R" ; 152d1
	DB 03h, 00h, 3Ch, 0DBh, 0F0h, 0CFh, 05h, 03h ; 152d2
	DB 00h, 40h, 0DBh ; 152da
	ASCII "O" ; 152dd
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h ; 152de
	ASCII "D" ; 152e5
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h, 40h, 0DBh ; 152e6
	DB 0C1h, 99h, 0A4h ; 152ee
	ASCII "R" ; 152f1
	DB 03h, 00h, 3Ch, 0DBh, 0F0h, 0CFh, 05h, 03h ; 152f2
	DB 00h, 40h, 0DBh ; 152fa
	ASCII "O" ; 152fd
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h ; 152fe
	ASCII "D" ; 15305
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h ; 15306
	ASCII "H" ; 1530c
	DB 0DBh, 0C1h, 99h, 0A4h ; 1530d
	ASCII "R" ; 15311
	DB 9Dh, 99h ; 15312
	ASCII "Q" ; 15314
	DB 0D7h ; 15315
	ASCII "O" ; 15316
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 7Bh, 0A7h, 24h ; 15317
	ASCII "SDSdS" ; 1531f
	DB 03h, 00h ; 15324
	ASCII "X" ; 15326
	DB 0D3h, 0F0h, 0CFh, 05h, 03h, 00h, 5Ch, 0D3h ; 15327
	ASCII "O" ; 1532f
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h, 60h ; 15330
	DB 0D3h, 0F0h, 0CFh, 05h, 03h, 00h ; 15338
	ASCII "d" ; 1533e
	DB 0D3h, 0C1h, 99h, 16h ; 1533f
	ASCII "S" ; 15343
	DB 03h, 00h ; 15344
	ASCII "L" ; 15346
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h ; 15347
	ASCII "P" ; 1534d
	DB 0DBh ; 1534e
	ASCII "O" ; 1534f
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h ; 15350
	ASCII "T" ; 15357
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h ; 15358
	ASCII "P" ; 1535e
	DB 0DBh, 0C1h, 99h, 16h ; 1535f
	ASCII "S" ; 15363
	DB 03h, 00h ; 15364
	ASCII "L" ; 15366
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h ; 15367
	ASCII "P" ; 1536d
	DB 0DBh ; 1536e
	ASCII "O" ; 1536f
	DB 9Ah, 0Dh, 0F0h, 0CFh, 04h, 03h, 00h ; 15370
	ASCII "T" ; 15377
	DB 0DBh, 0F0h, 0CFh, 05h, 03h, 00h ; 15378
	ASCII "X" ; 1537e
	DB 0DBh, 0C1h, 99h, 16h ; 1537f
	ASCII "S" ; 15383
	DB 9Dh, 99h ; 15384
	ASCII "q" ; 15386
	DB 9Ah, 7Bh, 0A7h, 90h ; 15387
	ASCII "S" ; 1538b
	DB 0ECh ; 1538c
	ASCII "SHT" ; 1538d
	DB 82h, 0AAh, 0A4h ; 15390
	ASCII "S" ; 15393
	DB 0ACh ; 15394
	ASCII "S" ; 15395
	DB 0B4h ; 15396
	ASCII "S" ; 15397
	DB 0BCh ; 15398
	ASCII "S" ; 15399
	DB 0C4h ; 1539a
	ASCII "S" ; 1539b
	DB 0CCh ; 1539c
	ASCII "S" ; 1539d
	DB 0D4h ; 1539e
	ASCII "S" ; 1539f
	DB 0DCh ; 153a0
	ASCII "S" ; 153a1
	DB 0E4h ; 153a2
	ASCII "S" ; 153a3
	DB 08h, 00h, 2Ch, 0CCh, 0C1h, 99h, 0A4h ; 153a4
	ASCII "T" ; 153ab
	DB 08h, 00h ; 153ac
	ASCII "4" ; 153ae
	DB 0CCh, 0C1h, 99h, 0A4h ; 153af
	ASCII "T" ; 153b3
	DB 08h, 00h ; 153b4
	ASCII "8" ; 153b6
	DB 0CCh, 0C1h, 99h, 0A4h ; 153b7
	ASCII "T" ; 153bb
	DB 08h, 00h, 3Ch, 0CCh, 0C1h, 99h, 0A4h ; 153bc
	ASCII "T" ; 153c3
	DB 08h, 00h, 40h, 0CCh, 0C1h, 99h, 0A4h ; 153c4
	ASCII "T" ; 153cb
	DB 08h, 00h ; 153cc
	ASCII "D" ; 153ce
	DB 0CCh, 0C1h, 99h, 0A4h ; 153cf
	ASCII "T" ; 153d3
	DB 08h, 00h ; 153d4
	ASCII "p" ; 153d6
	DB 0CCh, 0C1h, 99h, 0A4h ; 153d7
	ASCII "T" ; 153db
	DB 08h, 00h ; 153dc
	ASCII "H" ; 153de
	DB 0CCh, 0C1h, 99h, 0A4h ; 153df
	ASCII "T" ; 153e3
	DB 08h, 00h ; 153e4
	ASCII "L" ; 153e6
	DB 0CCh, 0C1h, 99h, 0A4h ; 153e7
	ASCII "T" ; 153eb
	DB 82h, 0AAh, 00h ; 153ec
	ASCII "T" ; 153ef
	DB 08h ; 153f0
	ASCII "T" ; 153f1
	DB 10h ; 153f2
	ASCII "T" ; 153f3
	DB 18h ; 153f4
	ASCII "T T(T0T8T@T" ; 153f5
	DB 08h, 00h, 88h, 0D8h, 0C1h, 99h, 0A4h ; 15400
	ASCII "T" ; 15407
	DB 08h, 00h, 90h, 0D8h, 0C1h, 99h, 0A4h ; 15408
	ASCII "T" ; 1540f
	DB 08h, 00h, 94h, 0D8h, 0C1h, 99h, 0A4h ; 15410
	ASCII "T" ; 15417
	DB 08h, 00h, 98h, 0D8h, 0C1h, 99h, 0A4h ; 15418
	ASCII "T" ; 1541f
	DB 08h, 00h, 9Ch, 0D8h, 0C1h, 99h, 0A4h ; 15420
	ASCII "T" ; 15427
	DB 08h, 00h, 0A0h, 0D8h, 0C1h, 99h, 0A4h ; 15428
	ASCII "T" ; 1542f
	DB 08h, 00h, 0CCh, 0D8h, 0C1h, 99h, 0A4h ; 15430
	ASCII "T" ; 15437
	DB 08h, 00h, 0A4h, 0D8h, 0C1h, 99h, 0A4h ; 15438
	ASCII "T" ; 1543f
	DB 08h, 00h, 0A8h, 0D8h, 0C1h, 99h, 0A4h ; 15440
	ASCII "T" ; 15447
	DB 82h, 0AAh, 5Ch ; 15448
	ASCII "TdTlTtT|T" ; 1544b
	DB 84h ; 15454
	ASCII "T" ; 15455
	DB 8Ch ; 15456
	ASCII "T" ; 15457
	DB 94h ; 15458
	ASCII "T" ; 15459
	DB 9Ch ; 1545a
	ASCII "T" ; 1545b
	DB 08h, 00h, 0B0h, 0DCh, 0C1h, 99h, 0A4h ; 1545c
	ASCII "T" ; 15463
	DB 08h, 00h, 0B8h, 0DCh, 0C1h, 99h, 0A4h ; 15464
	ASCII "T" ; 1546b
	DB 08h, 00h, 0BCh, 0DCh, 0C1h, 99h, 0A4h ; 1546c
	ASCII "T" ; 15473
	DB 08h, 00h, 0C0h, 0DCh, 0C1h, 99h, 0A4h ; 15474
	ASCII "T" ; 1547b
	DB 08h, 00h, 0C4h, 0DCh, 0C1h, 99h, 0A4h ; 1547c
	ASCII "T" ; 15483
	DB 08h, 00h, 0C8h, 0DCh, 0C1h, 99h, 0A4h ; 15484
	ASCII "T" ; 1548b
	DB 08h, 00h, 0F4h, 0DCh, 0C1h, 99h, 0A4h ; 1548c
	ASCII "T" ; 15493
	DB 08h, 00h, 0CCh, 0DCh, 0C1h, 99h, 0A4h ; 15494
	ASCII "T" ; 1549b
	DB 08h, 00h, 0D0h, 0DCh, 0C1h, 99h, 0A4h ; 1549c
	ASCII "TJ" ; 154a3
	DB 0D0h, 00h, 04h, 00h ; 154a5
	ASCII "P" ; 154a9
	DB 0CCh, 04h, 00h, 2Ch, 0CCh, 04h, 00h ; 154aa
	ASCII "P" ; 154b1
	DB 0CCh, 04h, 00h, 2Ch, 0CCh, 0C1h, 99h ; 154b2
	ASCII "zP{" ; 154b9
	DB 0A7h, 0C3h ; 154bc
	ASCII "T" ; 154be
	DB 0D7h ; 154bf
	ASCII "T" ; 154c0
	DB 0EBh ; 154c1
	ASCII "T" ; 154c2
	DB 04h, 00h ; 154c3
	ASCII "T" ; 154c5
	DB 0CCh, 04h, 00h ; 154c6
	ASCII "4" ; 154c9
	DB 0CCh, 04h, 00h ; 154ca
	ASCII "T" ; 154cd
	DB 0CCh, 04h, 00h ; 154ce
	ASCII "4" ; 154d1
	DB 0CCh, 0C1h, 99h ; 154d2
	ASCII "zP" ; 154d5
	DB 04h, 00h, 0B0h, 0D8h, 04h, 00h, 90h, 0D8h ; 154d7
	DB 04h, 00h, 0B0h, 0D8h, 04h, 00h, 90h, 0D8h ; 154df
	DB 0C1h, 99h ; 154e7
	ASCII "zP" ; 154e9
	DB 04h, 00h, 0D8h, 0DCh, 04h, 00h, 0B8h, 0DCh ; 154eb
	DB 04h, 00h, 0D8h, 0DCh, 04h, 00h, 0B8h, 0DCh ; 154f3
	DB 0C1h, 99h ; 154fb
	ASCII "zP" ; 154fd
	DB 04h, 00h ; 154ff
	ASCII "X" ; 15501
	DB 0CCh, 04h, 00h ; 15502
	ASCII "8" ; 15505
	DB 0CCh, 04h, 00h ; 15506
	ASCII "X" ; 15509
	DB 0CCh, 04h, 00h ; 1550a
	ASCII "8" ; 1550d
	DB 0CCh, 0C1h, 99h ; 1550e
	ASCII "zP" ; 15511
	DB 04h, 00h, 5Ch, 0CCh, 04h, 00h, 3Ch, 0CCh ; 15513
	DB 04h, 00h, 5Ch, 0CCh, 04h, 00h, 3Ch, 0CCh ; 1551b
	DB 0C1h, 99h ; 15523
	ASCII "zP{" ; 15525
	DB 0A7h, 2Fh ; 15528
	ASCII "UCUWU" ; 1552a
	DB 04h, 00h, 60h, 0CCh, 04h, 00h, 40h, 0CCh ; 1552f
	DB 04h, 00h, 60h, 0CCh, 04h, 00h, 40h, 0CCh ; 15537
	DB 0C1h, 99h ; 1553f
	ASCII "zP" ; 15541
	DB 04h, 00h, 0BCh, 0D8h, 04h, 00h, 9Ch, 0D8h ; 15543
	DB 04h, 00h, 0BCh, 0D8h, 04h, 00h, 9Ch, 0D8h ; 1554b
	DB 0C1h, 99h ; 15553
	ASCII "zP" ; 15555
	DB 04h, 00h, 0E4h, 0DCh, 04h, 00h, 0C4h, 0DCh ; 15557
	DB 04h, 00h, 0E4h, 0DCh, 04h, 00h, 0C4h, 0DCh ; 1555f
	DB 0C1h, 99h ; 15567
	ASCII "zP{" ; 15569
	DB 0A7h ; 1556c
	ASCII "sU" ; 1556d
	DB 87h ; 1556f
	ASCII "U" ; 15570
	DB 9Bh ; 15571
	ASCII "U" ; 15572
	DB 04h, 00h ; 15573
	ASCII "d" ; 15575
	DB 0CCh, 04h, 00h ; 15576
	ASCII "D" ; 15579
	DB 0CCh, 04h, 00h ; 1557a
	ASCII "d" ; 1557d
	DB 0CCh, 04h, 00h ; 1557e
	ASCII "D" ; 15581
	DB 0CCh, 0C1h, 99h ; 15582
	ASCII "zP" ; 15585
	DB 04h, 00h, 0C0h, 0D8h, 04h, 00h, 0A0h, 0D8h ; 15587
	DB 04h, 00h, 0C0h, 0D8h, 04h, 00h, 0A0h, 0D8h ; 1558f
	DB 0C1h, 99h ; 15597
	ASCII "zP" ; 15599
	DB 04h, 00h, 0E8h, 0DCh, 04h, 00h, 0C8h, 0DCh ; 1559b
	DB 04h, 00h, 0E8h, 0DCh, 04h, 00h, 0C8h, 0DCh ; 155a3
	DB 0C1h, 99h ; 155ab
	ASCII "zP{" ; 155ad
	DB 0A7h, 0B7h ; 155b0
	ASCII "U" ; 155b2
	DB 0CBh ; 155b3
	ASCII "U" ; 155b4
	DB 0DFh ; 155b5
	ASCII "U" ; 155b6
	DB 04h, 00h ; 155b7
	ASCII "h" ; 155b9
	DB 0CCh, 04h, 00h ; 155ba
	ASCII "p" ; 155bd
	DB 0CCh, 04h, 00h ; 155be
	ASCII "h" ; 155c1
	DB 0CCh, 04h, 00h ; 155c2
	ASCII "p" ; 155c5
	DB 0CCh, 0C1h, 99h ; 155c6
	ASCII "zP" ; 155c9
	DB 04h, 00h, 0C4h, 0D8h, 04h, 00h, 0CCh, 0D8h ; 155cb
	DB 04h, 00h, 0C4h, 0D8h, 04h, 00h, 0CCh, 0D8h ; 155d3
	DB 0C1h, 99h ; 155db
	ASCII "zP" ; 155dd
	DB 04h, 00h, 0ECh, 0DCh, 04h, 00h, 0F4h, 0DCh ; 155df
	DB 04h, 00h, 0ECh, 0DCh, 04h, 00h, 0F4h, 0DCh ; 155e7
	DB 0C1h, 99h ; 155ef
	ASCII "zP{" ; 155f1
	DB 0A7h, 0FBh ; 155f4
	ASCII "U" ; 155f6
	DB 0Fh ; 155f7
	ASCII "V#V" ; 155f8
	DB 04h, 00h ; 155fb
	ASCII "l" ; 155fd
	DB 0CCh, 04h, 00h ; 155fe
	ASCII "p" ; 15601
	DB 0CCh, 04h, 00h ; 15602
	ASCII "l" ; 15605
	DB 0CCh, 04h, 00h ; 15606
	ASCII "p" ; 15609
	DB 0CCh, 0C1h, 99h ; 1560a
	ASCII "zP" ; 1560d
	DB 04h, 00h, 0C8h, 0D8h, 04h, 00h, 0CCh, 0D8h ; 1560f
	DB 04h, 00h, 0C8h, 0D8h, 04h, 00h, 0CCh, 0D8h ; 15617
	DB 0C1h, 99h ; 1561f
	ASCII "zP" ; 15621
	DB 04h, 00h, 0F0h, 0DCh, 04h, 00h, 0F4h, 0DCh ; 15623
	DB 04h, 00h, 0F0h, 0DCh, 04h, 00h, 0F4h, 0DCh ; 1562b
	DB 0C1h, 99h ; 15633
	ASCIZ "zP" ; 15635
	DB 9Dh, 99h ; 15638
	ASCII "q" ; 1563a
	DB 9Ah, 05h, 00h ; 1563b
	ASCII "t" ; 1563e
	DB 0CCh, 9Dh, 99h, 9Ch, 0D7h ; 1563f
	ASCII "O" ; 15644
	DB 9Ah, 11h, 0BBh, 99h, 08h, 0F4h, 99h, 00h ; 15645
	DB 0FFh, 01h, 00h ; 1564d
	ASCII "x" ; 15650
	DB 0CCh, 0C4h, 99h ; 15651
	ASCII "JV" ; 15654
	DB 9Dh, 99h ; 15656
	ASCII "q" ; 15658
	DB 9Ah, 02h, 00h, 7Ch, 0CCh, 9Dh, 99h, 0AEh ; 15659
	DB 0D7h, 0BBh, 99h, 08h, 0F4h, 99h, 00h, 01h ; 15661
	DB 01h, 00h, 80h, 0CCh, 0C4h, 99h ; 15669
	ASCII "eV" ; 1566f
	DB 9Dh, 99h ; 15671
	ASCII "q" ; 15673
	DB 9Ah ; 15674
	ASCII "O" ; 15675
	DB 9Ah, 12h, 06h, 00h, 84h, 0CCh, 03h, 00h ; 15676
	DB 88h, 0CCh, 03h, 00h, 94h, 0CCh, 03h, 00h ; 1567e
	DB 0A0h, 0CCh, 12h, 00h, 0ACh, 0CCh, 13h, 0D0h ; 15686
	DB 0BEh ; 1568e
	ASCII "7" ; 1568f
	DB 1Bh, 0F8h, 8Eh, 0D6h, 8Dh, 0D7h ; 15690
	ASCII "zP" ; 15696
	DB 0B9h ; 15698
	ASCII "7" ; 15699
	DB 1Bh, 0C1h, 02h, 00h, 0CFh, 0C1h, 0D5h, 0A6h ; 1569a
	ASCII "T" ; 156a2
	DB 0E4h, 06h, 0D5h ; 156a3
	ASCII "7V" ; 156a6
	DB 0E4h, 04h, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h ; 156a8
	DB 0CEh, 0D0h ; 156b0
	ASCII "C" ; 156b2
	DB 16h, 96h, 01h, 0E6h, 1Eh, 0F2h, 02h, 01h ; 156b3
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 156bb
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0B8h, 10h, 1Bh ; 156c3
	DB 0BCh, 1Eh, 1Bh, 0C4h, 0A5h ; 156cb
	ASCII "O" ; 156d0
	DB 0F2h, 7Ch, 0A2h, 0F8h, 0F2h, 0C1h, 0FFh, 0E6h ; 156d1
	DB 07h, 0CEh, 0C4h, 01h, 0F2h ; 156d9
	ASCII "S" ; 156de
	DB 0E8h, 0F8h, 0CEh, 0D0h ; 156df
	ASCII "C" ; 156e3
	DB 16h, 96h, 01h, 0E6h, 1Dh, 0F2h, 0D1h, 00h ; 156e4
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 156ec
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0B8h, 10h, 1Bh ; 156f4
	DB 0BCh, 1Eh, 1Bh, 0B0h, 01h, 0CEh ; 156fc
	ASCII "D" ; 15702
	DB 18h, 0F8h ; 15703
	ASCII "8" ; 15705
	DB 0CEh ; 15706
	ASCII "D" ; 15707
	DB 18h, 0F2h, 8Dh, 0FFh, 0E6h, 07h, 0CEh, 0C4h ; 15708
	DB 01h, 0F2h, 1Fh, 0E8h, 0F8h, 0F2h, 0DBh, 01h ; 15710
	DB 0F1h, 22h, 0B9h ; 15718
	ASCII "9" ; 1571b
	DB 1Bh, 0C1h, 02h, 00h, 0CFh, 0C0h, 0D4h, 0DDh ; 1571c
	ASCII "O" ; 15724
	DB 0E4h, 15h, 0D4h, 0E0h ; 15725
	ASCII "O" ; 15729
	DB 0E4h, 25h, 0A3h, 0CEh, 0C4h, 02h, 0F2h, 0E1h ; 1572a
	DB 0F8h, 0CFh, 0E3h, 0ABh, 0F2h, 17h, 0A2h, 0F1h ; 15732
	DB 16h, 0F2h, 0FEh, 00h, 0D5h, 00h, 00h, 0E7h ; 1573a
	DB 09h, 0F2h, 0B9h, 00h, 0D5h, 00h, 00h, 0E6h ; 15742
	DB 06h, 0CFh, 0E1h, 0F2h, 00h, 0A2h, 0F8h, 0F2h ; 1574a
	DB 9Fh, 01h, 0F1h, 22h, 0B9h ; 15752
	ASCII "9" ; 15757
	DB 1Bh, 0C1h, 02h, 00h, 0CFh, 0C0h, 0D4h, 0DDh ; 15758
	ASCII "O" ; 15760
	DB 0E4h, 15h, 0D4h, 0E0h ; 15761
	ASCII "O" ; 15765
	DB 0E4h, 25h, 0A3h, 0CEh, 0C4h, 02h, 0F2h, 0A5h ; 15766
	DB 0F8h, 0CFh, 0E3h, 0ABh, 0F2h, 0DBh, 0A1h, 0F1h ; 1576e
	DB 16h, 0F2h, 0C2h, 00h, 0D5h, 00h, 00h, 0E7h ; 15776
	DB 09h, 0F2h, 9Dh, 00h, 0D5h, 00h, 00h, 0E6h ; 1577e
	DB 06h, 0CFh, 0E1h, 0F2h, 0C4h, 0A1h, 0F8h, 0CEh ; 15786
	DB 0D0h ; 1578e
	ASCII "C" ; 1578f
	DB 16h, 96h, 01h, 0E6h, 07h, 0C4h, 84h ; 15790
	ASCII "S" ; 15797
	DB 0F2h, 0B5h, 0A1h, 0F8h, 0CEh, 0D0h, 11h, 1Bh ; 15798
	DB 02h, 04h, 0CEh ; 157a0
	ASCII "0" ; 157a3
	DB 0Eh, 0E4h, 07h, 0C4h ; 157a4
	ASCII "VV" ; 157a8
	DB 0F2h, 0A3h, 0A1h, 0F8h, 0CEh, 40h, 0Eh ; 157aa
	ASCII "2," ; 157b1
	DB 0E4h, 07h, 0C4h ; 157b3
	ASCII "qV" ; 157b6
	DB 0F2h, 95h, 0A1h, 0F8h, 0CEh, 0D0h, 3Fh, 1Bh ; 157b8
	DB 28h, 0E7h, 24h, 0C5h, 40h, 1Bh ; 157c0
	ASCII "E(" ; 157c6
	DB 0E6h, 04h, 8Eh, 0F1h, 1Ah, 0B5h, 03h, 0F2h ; 157c8
	ASCII "l" ; 157d0
	DB 0F5h, 0F2h, 0A8h, 0D7h, 0CEh, 0C4h, 01h, 0F2h ; 157d1
	DB 0E4h, 0C2h, 0E7h, 0Ah, 0F2h, 1Ch, 0D8h, 0CEh ; 157d9
	DB 0C4h, 01h, 0F2h, 04h, 0E9h, 0F8h, 0CEh, 0D0h ; 157e1
	DB 0D7h, 1Ah, 0B1h, 00h, 0A6h, 0A3h, 0C7h, 0FBh ; 157e9
	ASCII "W" ; 157f1
	DB 0CEh, 0C7h, 01h, 0CFh ; 157f2
	ASCII "BG" ; 157f6
	DB 0ABh, 0AEh, 0F8h, 0Ch, 0Fh, 0Dh, 0CEh, 0D0h ; 157f8
	DB 11h, 1Bh ; 15800
	ASCII "2$" ; 15802
	DB 0E4h, 15h, 0F2h, 0DFh, 0FFh, 0CEh, 0D1h, 12h ; 15804
	DB 1Bh, 01h ; 1580c
	ASCII "H" ; 1580e
	DB 0CEh, 0D0h, 10h, 1Bh ; 1580f
	ASCII "1" ; 15813
	DB 0E4h, 05h, 0F2h, 0C4h, 00h, 0F8h, 0C5h, 00h ; 15814
	DB 00h, 0F8h, 0CEh, 0D0h, 11h, 1Bh ; 1581c
	ASCII "2$" ; 15822
	DB 0E4h, 12h, 0CEh, 0D0h, 10h, 1Bh, 02h, 09h ; 15824
	DB 0CEh, 0D1h, 12h, 1Bh ; 1582c
	ASCII "1" ; 15830
	DB 0E5h, 05h, 0F2h, 91h, 00h, 0F8h, 0C5h, 00h ; 15831
	DB 00h, 0F8h, 0CEh, 0D0h, 10h, 1Bh, 02h, 09h ; 15839
	ASCII "H" ; 15841
	DB 0CEh, 0D0h, 12h, 1Bh ; 15842
	ASCII "1" ; 15846
	DB 0E4h, 26h, 12h, 02h, 0E5h, 02h ; 15847
	ASCII "81" ; 1584d
	DB 0E5h ; 1584f
	ASCII "r" ; 15850
	DB 0CEh, 0D0h, 11h, 1Bh, 02h, 04h ; 15851
	ASCII "2$" ; 15857
	DB 0E4h ; 15859
	ASCII "h" ; 1585a
	DB 0C5h, 0FFh ; 1585b
	ASCII "T2," ; 1585d
	DB 0E4h ; 15860
	ASCII "U" ; 15861
	DB 0C5h, 0A7h ; 15862
	ASCII "T24" ; 15864
	DB 0E4h ; 15867
	ASCII "N" ; 15868
	DB 0C5h, 13h ; 15869
	ASCII "U" ; 1586b
	DB 0F1h ; 1586c
	ASCII "I" ; 1586d
	DB 0F2h ; 1586e
	ASCII "w" ; 1586f
	DB 0FFh, 0CEh, 0D1h, 12h, 1Bh, 01h, 0CEh, 0D1h ; 15870
	DB 10h, 1Bh ; 15878
	ASCII "1" ; 1587a
	DB 0E5h, 23h, 02h, 03h ; 1587b
	ASCII "1" ; 1587f
	DB 0E4h ; 15880
	ASCII "A" ; 15881
	DB 0CEh, 0D0h, 11h, 1Bh, 02h, 04h ; 15882
	ASCII "2$" ; 15888
	DB 0E4h ; 1588a
	ASCII "7" ; 1588b
	DB 0C5h, 27h ; 1588c
	ASCII "U2," ; 1588e
	DB 0E4h, 24h, 0C5h, 0BBh ; 15891
	ASCII "T24" ; 15895
	DB 0E4h, 1Dh, 0C5h ; 15898
	ASCII "kU" ; 1589b
	DB 0F1h, 18h, 0CEh, 0D0h, 11h, 1Bh, 02h, 04h ; 1589d
	DB 0C5h ; 158a5
	ASCII "8V2$" ; 158a6
	DB 0E4h, 0Bh, 0C5h, 0AFh ; 158aa
	ASCII "U24" ; 158ae
	DB 0E4h, 04h, 0C5h, 0F3h ; 158b1
	ASCII "U" ; 158b5
	DB 0C4h ; 158b6
	ASCII "q" ; 158b7
	DB 9Ah, 0F2h, 8Dh, 0A0h, 0B0h, 02h, 0CEh ; 158b8
	ASCII "D" ; 158bf
	DB 1Fh, 0F8h, 0C5h, 00h, 00h, 0F8h, 0C5h ; 158c0
	ASCII "JQ" ; 158c7
	DB 0CEh, 0D0h, 1Fh, 1Bh ; 158c9
	ASCII "2," ; 158cd
	DB 0E4h, 0Bh, 0C5h, 0D8h ; 158cf
	ASCII "P24" ; 158d3
	DB 0E4h, 04h, 0C5h, 0BCh ; 158d6
	ASCII "Q" ; 158da
	DB 0F8h, 0C5h, 0A0h ; 158db
	ASCII "R" ; 158de
	DB 0CEh, 0D0h, 1Fh, 1Bh ; 158df
	ASCII "2," ; 158e3
	DB 0E4h, 0Bh, 0C5h, 2Eh ; 158e5
	ASCII "R24" ; 158e9
	DB 0E4h, 04h, 0C5h, 12h ; 158ec
	ASCII "S" ; 158f0
	DB 0F8h, 0CEh, 0D0h ; 158f1
	ASCII "C" ; 158f4
	DB 16h, 96h, 01h, 0E7h, 02h, 0FAh, 0CEh, 0D1h ; 158f5
	DB 1Eh, 1Bh, 0CEh, 0D0h, 12h, 1Bh ; 158fd
	ASCII "1" ; 15903
	DB 0E4h, 06h, 0F2h, 0BEh, 0FFh, 0F1h, 04h, 0F2h ; 15904
	DB 0CFh, 0FFh, 0CFh, 0E1h, 0F2h, 3Dh, 0A0h, 0F8h ; 1590c
	DB 9Dh, 99h ; 15914
	ASCII "q" ; 15916
	DB 9Ah, 01h, 00h, 0F8h, 0CDh, 01h, 00h, 08h ; 15917
	DB 0CEh, 01h, 00h, 28h, 0CEh, 01h, 00h ; 1591f
	ASCII "H" ; 15926
	DB 0CEh, 04h, 00h ; 15927
	ASCII "h" ; 1592a
	DB 0CEh, 01h, 00h ; 1592b
	ASCII "H" ; 1592e
	DB 0CEh, 01h, 00h, 28h, 0CEh, 01h, 00h, 08h ; 1592f
	DB 0CEh ; 15937
	ASCII "v" ; 15938
	DB 0D9h, 14h, 00h, 0F8h, 0CDh, 0C1h, 99h ; 15939
	ASCII "BY" ; 15940
	DB 9Dh, 99h, 0D8h, 0D9h, 03h, 00h ; 15942
	ASCII "X" ; 15948
	DB 0CDh, 03h, 00h ; 15949
	ASCII "l" ; 1594c
	DB 0CDh, 03h, 00h, 80h, 0CDh, 03h, 00h, 94h ; 1594d
	DB 0CDh, 03h, 00h, 0A8h, 0CDh, 03h, 00h, 0BCh ; 15955
	DB 0CDh, 03h, 00h, 0D0h, 0CDh, 03h, 00h, 0E4h ; 1595d
	DB 0CDh, 9Dh, 99h, 0B6h, 0D9h, 01h, 00h ; 15965
	ASCII "0" ; 1596c
	DB 0CDh, 01h, 00h ; 1596d
	ASCII "D" ; 15970
	DB 0CDh, 0C1h, 99h ; 15971
	ASCII "jY" ; 15974
	DB 0CEh, 0D0h, 3Fh, 1Bh, 28h, 0E7h, 11h, 0F2h ; 15976
	DB 0BEh, 0F3h, 0F0h, 0Dh, 0E7h, 0Ah, 0F2h, 7Fh ; 1597e
	DB 0D6h, 0CEh, 0C4h, 01h, 0F2h, 5Dh, 0E7h, 0F8h ; 15986
	DB 0CEh, 40h, 0Eh, 02h, 02h, 0CEh, 0D1h, 13h ; 1598e
	DB 1Bh ; 15996
	ASCII "1" ; 15997
	DB 0E5h, 1Ah, 02h, 05h ; 15998
	ASCII "1" ; 1599c
	DB 0E4h, 15h, 0CEh, 40h, 0Ah, 02h, 02h, 0CEh ; 1599d
	DB 0D1h, 12h, 1Bh ; 159a5
	ASCII "1" ; 159a8
	DB 0E5h, 09h, 02h, 0Bh ; 159a9
	ASCII "1" ; 159ad
	DB 0E4h, 04h, 9Dh, 01h, 0F8h, 9Ch, 0FEh, 0F8h ; 159ae
	DB 0CEh, 0D0h ; 159b6
	ASCII "C" ; 159b8
	DB 16h, 96h, 01h, 0E6h, 1Bh, 0CEh, 0D0h, 0B6h ; 159b9
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 1Bh, 0CEh, 0D4h ; 159c1
	DB 0FAh, 14h, 0F2h, 0AFh, 0D5h, 0F2h ; 159c9
	ASCII "p" ; 159cf
	DB 0CFh, 0C4h, 14h ; 159d0
	ASCII "Y" ; 159d3
	DB 0F2h ; 159d4
	ASCII "y" ; 159d5
	DB 9Fh, 0F8h, 0CEh, 0D0h ; 159d6
	ASCII "B" ; 159da
	DB 16h, 96h, 10h, 0E7h, 0Eh, 96h, 08h, 0E6h ; 159db
	DB 15h, 0CEh, 40h, 0Eh, 28h, 0E6h, 0Fh, 88h ; 159e3
	DB 0F1h, 09h, 0CEh, 40h, 0Eh ; 159eb
	ASCII "2)" ; 159f0
	DB 0E5h, 05h, 80h, 0CEh ; 159f2
	ASCII "D" ; 159f6
	DB 0Eh, 0CEh, 0D0h ; 159f7
	ASCII "B" ; 159fa
	DB 16h, 96h, 40h, 0E7h, 0Eh, 96h, 20h, 0E6h ; 159fb
	DB 15h, 0CEh, 40h, 0Ah, 28h, 0E6h, 0Fh, 88h ; 15a03
	DB 0F1h, 09h, 0CEh, 40h, 0Ah ; 15a0b
	ASCII "2A" ; 15a10
	DB 0E5h, 05h, 80h, 0CEh ; 15a12
	ASCII "D" ; 15a16
	DB 0Ah, 0F8h, 0BEh ; 15a17
	ASCII "9" ; 15a1a
	DB 1Bh, 0F8h, 19h, 0DAh, 0B6h, 0D9h ; 15a1b
	ASCII "fY" ; 15a21
	DB 9Dh, 99h ; 15a23
	ASCII "c" ; 15a25
	DB 0DAh, 0C1h, 99h, 0DCh ; 15a26
	ASCII "P" ; 15a2a
	DB 9Dh, 99h ; 15a2b
	ASCII "c" ; 15a2d
	DB 0DAh, 0C1h, 99h ; 15a2e
	ASCII "2R" ; 15a31
	DB 0B0h, 0Ch, 0CEh ; 15a33
	ASCII "D" ; 15a36
	DB 18h, 0C4h, 07h, 00h, 0CEh, 0C4h, 03h, 0F2h ; 15a37
	DB 0BEh, 0B5h, 00h, 0B1h, 00h, 0A6h, 0A2h, 0C6h ; 15a3f
	ASCII "SZ" ; 15a47
	DB 0CEh, 0C6h, 01h, 0CFh, 40h, 0CFh, 0D3h, 0AAh ; 15a49
	DB 0AEh, 0F8h, 7Eh ; 15a51
	ASCII "P~P" ; 15a54
	DB 88h ; 15a57
	ASCII "S" ; 15a58
	DB 88h ; 15a59
	ASCII "S" ; 15a5a
	DB 8Ch ; 15a5b
	ASCII "P" ; 15a5c
	DB 0B4h ; 15a5d
	ASCII "P#Z+Z" ; 15a5e
	DB 0CEh, 40h, 06h, 0CFh, 0B0h, 0F2h, 23h, 00h ; 15a63
	DB 0CEh, 40h, 06h, 0CFh, 0B5h ; 15a6b
	ASCII "1" ; 15a70
	DB 0E7h, 1Ah, 0CEh, 40h, 18h, 28h, 0E6h, 07h ; 15a71
	DB 88h, 0CEh ; 15a79
	ASCII "D" ; 15a7b
	DB 18h, 0F1h, 0Eh, 0A3h, 0F2h, 0B1h, 0FFh, 0CFh ; 15a7c
	DB 0E3h, 0ABh, 0C5h, 8Dh, 0DAh, 0F2h, 0E5h, 9Eh ; 15a84
	DB 0F8h, 0B9h ; 15a8c
	ASCII "9" ; 15a8e
	DB 1Bh, 0C1h, 02h, 00h, 0CFh, 0C0h, 0D4h, 14h ; 15a8f
	ASCII "Y" ; 15a97
	DB 0E4h, 0Dh, 0D4h ; 15a98
	ASCII "BY" ; 15a9b
	DB 0E5h, 08h, 0CEh, 40h, 06h, 80h, 0CEh ; 15a9d
	ASCII "D" ; 15aa4
	DB 06h, 0F8h ; 15aa5
	ASCII "q" ; 15aa7
	DB 9Ah, 8Dh, 0DAh, 7Eh ; 15aa8
	ASCII "P" ; 15aac
	DB 01h, 00h, 14h, 0CDh, 8Eh, 99h ; 15aad
	ASCII "q" ; 15ab3
	DB 9Ah ; 15ab4
	ASCII "q" ; 15ab5
	DB 9Ah, 0ADh ; 15ab6
	ASCII "Z" ; 15ab8
	DB 9Dh, 99h ; 15ab9
	ASCII "q" ; 15abb
	DB 9Ah, 02h, 00h, 04h, 0CDh, 02h, 00h, 0Ch ; 15abc
	DB 0CDh, 02h, 00h, 04h, 0CDh, 02h, 00h, 0FCh ; 15ac4
	DB 0CCh, 9Dh, 99h, 0D7h, 0DAh, 01h, 00h, 0FCh ; 15acc
	DB 0CCh, 8Eh, 99h, 0CEh, 0D0h ; 15ad4
	ASCII "C" ; 15ad9
	DB 16h, 96h, 01h, 0E6h, 07h, 0C4h, 0B9h ; 15ada
	ASCII "Z" ; 15ae1
	DB 0F2h ; 15ae2
	ASCII "k" ; 15ae3
	DB 9Eh, 0F8h ; 15ae4
	ASCII "q" ; 15ae6
	DB 9Ah, 0D7h, 0DAh, 0CDh ; 15ae7
	ASCII "Z" ; 15aeb
	DB 0A6h, 0A3h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 0B1h ; 15aec
	DB 00h, 0C7h, 83h, 5Bh, 0CEh, 0C7h, 01h, 0CFh ; 15af4
	ASCII "B" ; 15afc
	DB 0CFh, 0DBh, 0CEh, 0D0h, 3Eh, 1Bh, 0B1h, 00h ; 15afd
	DB 0CFh ; 15b05
	ASCII "BG2" ; 15b06
	DB 0FFh, 0E7h, 08h ; 15b09
	ASCII "8" ; 15b0c
	DB 0CEh, 0D4h, 3Eh, 1Bh, 0F1h, 0DCh, 0CFh, 0B0h ; 15b0d
	DB 0CEh, 0D0h, 3Fh, 1Bh, 28h, 0CFh, 0B4h, 0E7h ; 15b15
	ASCII "Z" ; 15b1d
	DB 0CFh, 0B0h, 0C5h, 40h, 1Bh ; 15b1e
	ASCII "E(" ; 15b23
	DB 0CFh, 0B4h, 0E6h, 10h, 8Eh, 0CFh, 0B0h, 0B0h ; 15b25
	DB 01h, 0CEh, 0D4h, 3Dh, 1Bh, 0CFh, 0B4h, 02h ; 15b2d
	DB 24h, 0F1h ; 15b35
	ASCII "4" ; 15b37
	DB 0B5h, 03h, 0CFh, 0B0h, 0F2h, 0FFh, 0F1h, 0F2h ; 15b38
	DB 3Bh, 0D4h, 0CEh, 0C4h, 01h, 0F2h ; 15b40
	ASCII "w" ; 15b46
	DB 0BFh, 0CFh, 0B4h, 0E7h, 18h, 0CFh, 0B0h, 0F2h ; 15b47
	DB 0B0h, 0D4h, 0CEh, 0C4h, 01h, 0F2h, 0A1h, 0E5h ; 15b4f
	DB 0B0h, 01h, 0CEh, 0D4h, 3Dh, 1Bh, 0CFh, 0B4h ; 15b57
	DB 02h, 24h, 0F1h, 09h, 0B0h, 02h, 0CEh, 0D4h ; 15b5f
	DB 3Dh, 1Bh, 0B0h, 3Fh ; 15b67
	ASCII "H" ; 15b6b
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 05h, 0CEh ; 15b6c
	DB 0D5h, 0FAh, 14h, 0CEh, 0D0h, 3Eh, 1Bh, 80h ; 15b74
	DB 0CEh, 0D4h, 3Eh, 1Bh, 0ABh, 0AEh, 0F8h, 89h ; 15b7c
	DB 5Bh, 89h, 5Bh, 89h, 5Bh, 00h, 02h, 04h ; 15b84
	DB 05h, 07h, 09h, 0Bh, 0Ch, 0FFh, 9Dh, 99h ; 15b8c
	ASCII "q" ; 15b94
	DB 9Ah, 0ECh, 0DAh, 7Bh, 0A7h, 0A0h, 5Bh, 0A8h ; 15b95
	DB 5Bh, 0B0h, 5Bh, 02h, 00h, 2Ch, 0CDh, 0C1h ; 15b9d
	DB 99h, 0B8h, 5Bh, 02h, 00h, 5Ch, 0D9h, 0C1h ; 15ba5
	DB 99h, 0B8h, 5Bh, 02h, 00h, 84h, 0DDh, 0C1h ; 15bad
	DB 99h, 0B8h, 5Bh, 9Dh, 99h, 0D6h, 0DBh, 7Bh ; 15bb5
	DB 0A7h, 0C4h, 5Bh, 0CAh, 5Bh, 0D0h, 5Bh, 01h ; 15bbd
	DB 00h, 28h, 0CDh, 8Eh, 99h, 01h, 00h ; 15bc5
	ASCII "X" ; 15bcc
	DB 0D9h, 8Eh, 99h, 01h, 00h, 80h, 0DDh, 8Eh ; 15bcd
	DB 99h, 0CEh, 0D0h ; 15bd5
	ASCII "C" ; 15bd8
	DB 16h, 96h, 01h, 0E6h, 07h, 0C4h, 92h, 5Bh ; 15bd9
	DB 0F2h ; 15be1
	ASCII "l" ; 15be2
	DB 9Dh, 0F8h ; 15be3
	ASCII "q" ; 15be5
	DB 9Ah, 0D6h, 0DBh, 0B8h, 5Bh, 9Dh, 99h ; 15be6
	ASCII "q" ; 15bed
	DB 9Ah, 04h, 00h, 18h, 0CDh, 04h, 00h, 1Ch ; 15bee
	DB 0CDh, 9Dh, 99h, 13h, 0DCh, 0C1h, 99h ; 15bf6
	ASCII "r" ; 15bfd
	DB 1Ah, 9Dh, 99h ; 15bfe
	ASCII "q" ; 15c01
	DB 9Ah, 04h, 00h, 20h, 0CDh, 04h, 00h, 24h ; 15c02
	DB 0CDh, 9Dh, 99h, 13h, 0DCh, 0C1h, 99h ; 15c0a
	ASCII "r" ; 15c11
	DB 1Ah, 0CEh, 0D0h, 3Dh, 1Bh, 28h, 0E6h, 15h ; 15c12
	DB 0C5h, 0EBh, 5Bh ; 15c1a
	ASCII "2" ; 15c1d
	DB 01h, 0E6h, 04h, 0C5h, 0FFh, 5Bh, 0CFh, 0E1h ; 15c1e
	DB 0F2h, 27h, 9Dh ; 15c26
	ASCII "8" ; 15c29
	DB 0CEh, 0D4h, 3Dh, 1Bh, 0F8h ; 15c2a
	ASCII "q" ; 15c2f
	DB 9Ah, 13h, 0DCh ; 15c30
	ASCII "v" ; 15c33
	DB 1Ah, 0CEh, 0D0h ; 15c34
	ASCII "A" ; 15c37
	DB 1Bh, 28h, 0E6h, 04h, 0D3h, 0Ah, 00h, 0F8h ; 15c38
	DB 9Dh, 99h, 0E2h, 0DCh, 04h, 00h ; 15c40
	ASCII "P" ; 15c46
	DB 0CFh, 0C1h, 99h ; 15c47
	ASCII "m\" ; 15c4a
	DB 9Dh, 99h ; 15c4c
	ASCII "q" ; 15c4e
	DB 9Ah, 0BBh, 99h, 03h, 02h, 00h, 0C4h, 0CEh ; 15c4f
	DB 02h, 00h, 0D8h, 0CEh, 0C4h, 99h ; 15c57
	ASCII "S\" ; 15c5d
	DB 02h, 00h, 0C4h, 0CEh, 02h, 00h, 0D8h, 0CEh ; 15c5f
	ASCII "5" ; 15c67
	DB 0DCh, 02h, 00h, 0C4h, 0CEh, 9Dh, 99h, 0E2h ; 15c68
	DB 0DCh, 0Ah, 00h, 88h, 0CEh, 0Ah, 00h, 9Ch ; 15c70
	DB 0CEh, 0C1h, 99h ; 15c78
	ASCII "m\" ; 15c7b
	DB 04h, 00h, 88h, 0CEh, 04h, 00h, 9Ch, 0CEh ; 15c7d
	DB 08h, 00h, 0B0h, 0CEh, 04h, 00h, 9Ch, 0CEh ; 15c85
	DB 0C1h, 99h, 7Dh, 5Ch, 9Dh, 99h ; 15c8d
	ASCII "8" ; 15c93
	DB 0DDh, 04h, 00h ; 15c94
	ASCII "P" ; 15c97
	DB 0CFh, 0C1h, 99h, 0BEh, 5Ch, 9Dh, 99h ; 15c98
	ASCII "q" ; 15c9f
	DB 9Ah, 0BBh, 99h, 03h, 02h, 00h, 28h, 0CFh ; 15ca0
	DB 02h, 00h, 3Ch, 0CFh, 0C4h, 99h, 0A4h, 5Ch ; 15ca8
	DB 02h, 00h, 28h, 0CFh, 02h, 00h, 3Ch, 0CFh ; 15cb0
	ASCII "5" ; 15cb8
	DB 0DCh, 02h, 00h, 28h, 0CFh, 9Dh, 99h ; 15cb9
	ASCII "8" ; 15cc0
	DB 0DDh, 0Ah, 00h, 0ECh, 0CEh, 0Ah, 00h, 00h ; 15cc1
	DB 0CFh, 0C1h, 99h, 0BEh, 5Ch, 04h, 00h, 0ECh ; 15cc9
	DB 0CEh, 04h, 00h, 00h, 0CFh, 08h, 00h, 14h ; 15cd1
	DB 0CFh, 04h, 00h, 00h, 0CFh, 0C1h, 99h, 0CEh ; 15cd9
	DB 5Ch, 0F2h, 0A5h, 00h, 0CEh, 0D0h ; 15ce1
	ASCII "C" ; 15ce7
	DB 16h, 96h, 01h, 0E6h, 09h, 0F2h, 0F1h, 00h ; 15ce8
	DB 0C4h ; 15cf0
	ASCII "L\" ; 15cf1
	DB 0F1h, 3Fh, 0CEh, 0D0h ; 15cf3
	ASCII "B" ; 15cf7
	DB 16h, 96h ; 15cf8
	ASCII "8" ; 15cfa
	DB 0E7h, 0Ah, 96h, 40h, 0E6h, 20h, 0C4h, 91h ; 15cfb
	DB 5Ch, 0F1h, 2Eh, 0CEh, 40h, 02h, 0CEh ; 15d03
	ASCII "H" ; 15d0a
	DB 03h, 0D4h ; 15d0b
	ASCII "m\" ; 15d0d
	DB 0E4h, 27h, 0D4h, 7Dh, 5Ch, 0E5h, 22h, 0C4h ; 15d0f
	DB 7Dh, 5Ch, 0F1h, 19h, 0C4h, 81h, 5Ch, 0F1h ; 15d17
	DB 14h, 0CEh, 40h, 02h, 0CEh ; 15d1f
	ASCII "H" ; 15d24
	DB 03h, 0D4h ; 15d25
	ASCII "m\" ; 15d27
	DB 0E4h, 06h, 0D4h, 7Dh, 5Ch, 0E4h, 08h, 0C4h ; 15d29
	ASCII "m\" ; 15d31
	DB 0F2h, 1Ah, 9Ch, 0F8h, 0F8h, 0F2h ; 15d33
	ASCIZ "O" ; 15d39
	DB 0CEh, 0D0h ; 15d3b
	ASCII "C" ; 15d3d
	DB 16h, 96h, 01h, 0E6h, 09h, 0F2h, 0D9h, 00h ; 15d3e
	DB 0C4h, 9Dh, 5Ch, 0F1h, 3Ah, 0CEh, 0D0h ; 15d46
	ASCII "B" ; 15d4d
	DB 16h, 96h ; 15d4e
	ASCII "X" ; 15d50
	DB 0E7h, 0Ah, 96h, 20h, 0E6h, 1Bh, 0C4h, 40h ; 15d51
	DB 5Ch, 0F1h, 29h, 0CEh, 40h, 02h, 0CEh ; 15d59
	ASCII "H" ; 15d60
	DB 03h, 0D4h, 0BEh, 5Ch, 0E4h, 22h, 0D4h, 0CEh ; 15d61
	DB 5Ch, 0E5h, 1Dh, 0C4h, 0CEh, 5Ch, 0F1h, 14h ; 15d69
	DB 0CEh, 40h, 02h, 0CEh ; 15d71
	ASCII "H" ; 15d75
	DB 03h, 0D4h, 0BEh, 5Ch, 0E4h, 06h, 0D4h, 0CEh ; 15d76
	DB 5Ch, 0E4h, 08h, 0C4h, 0BEh, 5Ch, 0F2h, 0C9h ; 15d7e
	DB 9Bh, 0F8h, 0F8h, 0CEh, 0D0h ; 15d86
	ASCII "B" ; 15d8b
	DB 16h, 96h, 10h, 0E7h, 0Fh, 96h, 08h, 0E6h ; 15d8c
	DB 18h, 0CEh, 0D0h, 11h, 1Bh, 28h, 0E6h, 11h ; 15d94
	DB 88h, 0F1h, 0Ah, 0CEh, 0D0h, 11h, 1Bh ; 15d9c
	ASCII "2-" ; 15da3
	DB 0E6h, 06h, 80h, 0CEh, 0D4h, 11h, 1Bh, 0CEh ; 15da5
	DB 0D0h ; 15dad
	ASCII "B" ; 15dae
	DB 16h, 96h, 40h, 0E7h, 0Fh, 96h, 20h, 0E6h ; 15daf
	DB 18h, 0CEh, 0D0h, 10h, 1Bh, 28h, 0E6h, 11h ; 15db7
	DB 88h, 0F1h, 0Ah, 0CEh, 0D0h, 10h, 1Bh ; 15dbf
	ASCII "2O" ; 15dc6
	DB 0E6h, 06h, 80h, 0CEh, 0D4h, 10h, 1Bh, 0B8h ; 15dc8
	DB 10h, 1Bh, 0F2h, 0AEh, 9Bh, 0F8h, 0BEh ; 15dd0
	ASCII "9" ; 15dd7
	DB 1Bh, 0F8h, 0D6h, 0DDh, 89h, 0DDh ; 15dd8
	ASCII "m\" ; 15dde
	DB 0CEh, 0D0h, 3Fh, 1Bh, 28h, 0E7h ; 15de0
	ASCII "7" ; 15de6
	DB 0F2h ; 15de7
	ASCII "T" ; 15de8
	DB 0EFh, 0F2h, 90h, 0D1h, 0B0h, 01h, 0CEh, 0D4h ; 15de9
	ASCII "A" ; 15df1
	DB 1Bh, 0CEh, 0D0h, 10h, 1Bh, 12h, 27h, 0E5h ; 15df2
	DB 02h ; 15dfa
	ASCII "8" ; 15dfb
	DB 0CEh, 0D1h, 12h, 1Bh ; 15dfc
	ASCII "1" ; 15e00
	DB 0E6h, 0Ch, 0E5h, 19h, 0CEh, 0D0h, 10h, 1Bh ; 15e01
	DB 02h, 08h ; 15e09
	ASCII "1" ; 15e0b
	DB 0E4h, 10h, 0B0h, 02h, 0CEh, 0D4h ; 15e0c
	ASCII "A" ; 15e12
	DB 1Bh, 0F2h, 0E5h, 0D1h, 0CEh, 0C4h, 01h, 0F2h ; 15e13
	DB 0CDh, 0E2h, 0F8h, 0CEh, 0D0h, 3Fh, 1Bh, 28h ; 15e1b
	DB 0E7h ; 15e23
	ASCII "7" ; 15e24
	DB 0F2h, 16h, 0EFh, 0F2h ; 15e25
	ASCII "R" ; 15e29
	DB 0D1h, 0B0h, 01h, 0CEh, 0D4h ; 15e2a
	ASCII "A" ; 15e2f
	DB 1Bh, 0CEh, 0D0h, 10h, 1Bh, 12h, 08h, 0E5h ; 15e30
	DB 02h ; 15e38
	ASCII "8" ; 15e39
	DB 0CEh, 0D1h, 12h, 1Bh ; 15e3a
	ASCII "1" ; 15e3e
	DB 0E6h, 0Ch, 0E5h, 19h, 0CEh, 0D0h, 10h, 1Bh ; 15e3f
	DB 02h, 27h ; 15e47
	ASCII "1" ; 15e49
	DB 0E4h, 10h, 0B0h, 02h, 0CEh, 0D4h ; 15e4a
	ASCII "A" ; 15e50
	DB 1Bh, 0F2h, 0A7h, 0D1h, 0CEh, 0C4h, 01h, 0F2h ; 15e51
	DB 8Fh, 0E2h, 0F8h ; 15e59
	ASCII "8" ; 15e5c
	DB 0CEh, 0D4h ; 15e5d
	ASCII "A" ; 15e5f
	DB 1Bh, 0F8h, 9Dh, 99h ; 15e60
	ASCII "q" ; 15e64
	DB 9Ah, 02h, 00h ; 15e65
	ASCII "d" ; 15e68
	DB 0CFh, 01h, 00h ; 15e69
	ASCII "l" ; 15e6c
	DB 0CFh, 5Ch, 0DEh, 9Dh, 99h, 0B5h, 0E0h, 01h ; 15e6d
	DB 00h ; 15e75
	ASCII "8" ; 15e76
	DB 0CCh, 8Eh, 99h, 9Dh, 99h ; 15e77
	ASCII "q" ; 15e7c
	DB 9Ah, 7Bh, 0A7h, 86h, 5Eh, 92h, 5Eh, 9Eh ; 15e7d
	DB 5Eh, 02h, 00h ; 15e85
	ASCII "t" ; 15e88
	DB 0CFh, 01h, 00h, 7Ch, 0CFh, 0C1h, 99h, 0A6h ; 15e89
	DB 5Eh, 02h, 00h ; 15e91
	ASCII "p" ; 15e94
	DB 0D9h, 01h, 00h ; 15e95
	ASCII "x" ; 15e98
	DB 0D9h, 0C1h, 99h, 0A6h, 5Eh, 02h, 00h, 98h ; 15e99
	DB 0DDh, 01h, 00h, 0A0h, 0DDh, 5Ch, 0DEh, 9Dh ; 15ea1
	DB 99h, 0E0h, 0E0h, 7Bh, 0A7h, 0B4h, 5Eh, 0BAh ; 15ea9
	DB 5Eh, 0C0h, 5Eh, 01h, 00h, 40h, 0CCh, 8Eh ; 15eb1
	DB 99h, 01h, 00h, 9Ch, 0D8h, 8Eh, 99h, 01h ; 15eb9
	DB 00h, 0C4h, 0DCh, 8Eh, 99h, 0B0h, 01h, 0CEh ; 15ec1
	ASCII "D" ; 15ec9
	DB 18h, 0F8h, 9Dh, 99h ; 15eca
	ASCII "q" ; 15ece
	DB 9Ah, 03h, 00h, 00h, 0D6h ; 15ecf
	ASCII "O" ; 15ed4
	DB 9Ah, 11h, 0C6h, 0DEh, 0BBh, 99h, 06h, 0F4h ; 15ed5
	DB 99h, 00h, 0FFh, 01h, 00h, 04h, 0D6h, 0C4h ; 15edd
	DB 99h, 0DCh, 5Eh, 02h, 00h, 08h, 0D6h, 0BBh ; 15ee5
	DB 99h, 06h, 0F4h, 99h, 00h, 01h, 01h, 00h ; 15eed
	DB 0Ch, 0D6h, 0C4h, 99h, 0EFh, 5Eh ; 15ef5
	ASCII "O" ; 15efb
	DB 9Ah, 12h, 02h, 00h, 10h, 0D6h, 03h, 00h ; 15efc
	DB 14h, 0D6h, 0C1h, 99h ; 15f04
	ASCII "D_" ; 15f08
	DB 9Dh, 99h ; 15f0a
	ASCII "q" ; 15f0c
	DB 9Ah, 03h, 00h, 84h, 0CFh ; 15f0d
	ASCII "O" ; 15f12
	DB 9Ah, 11h, 0C6h, 0DEh, 0BBh, 99h, 06h, 0F4h ; 15f13
	DB 99h, 00h, 0FFh, 01h, 00h, 88h, 0CFh, 0C4h ; 15f1b
	DB 99h, 1Ah, 5Fh, 02h, 00h, 8Ch, 0CFh, 0BBh ; 15f23
	DB 99h, 06h, 0F4h, 99h, 00h, 01h, 01h, 00h ; 15f2b
	DB 90h, 0CFh, 0C4h, 99h, 2Dh, 5Fh ; 15f33
	ASCII "O" ; 15f39
	DB 9Ah, 12h, 02h, 00h, 94h, 0CFh, 03h, 00h ; 15f3a
	DB 98h, 0CFh, 00h, 0E0h, 0A5h, 5Fh ; 15f42
	ASCII "J_" ; 15f48
	DB 9Dh, 99h, 11h, 0E0h, 97h, 99h, 01h, 9Dh ; 15f4a
	DB 99h, 11h, 0E0h ; 15f52
	ASCII "O" ; 15f55
	DB 9Ah, 0Dh, 7Bh, 0A7h, 60h, 5Fh ; 15f56
	ASCII "w_" ; 15f5c
	DB 8Eh, 5Fh, 03h, 00h, 9Ch, 0CFh, 03h, 00h ; 15f5e
	DB 0A4h, 0CFh ; 15f66
	ASCII "O" ; 15f68
	DB 9Ah, 0Dh, 03h, 00h, 0ACh, 0CFh, 03h, 00h ; 15f69
	DB 0B4h, 0CFh, 0C1h, 99h ; 15f71
	ASCII "Q_" ; 15f75
	DB 03h, 00h, 98h, 0D9h, 03h, 00h, 0A0h, 0D9h ; 15f77
	ASCII "O" ; 15f7f
	DB 9Ah, 0Dh, 03h, 00h, 0A8h, 0D9h, 03h, 00h ; 15f80
	DB 0A0h, 0D9h, 0C1h, 99h ; 15f88
	ASCII "Q_" ; 15f8c
	DB 03h, 00h, 0C0h, 0DDh, 03h, 00h, 0C8h, 0DDh ; 15f8e
	ASCII "O" ; 15f96
	DB 9Ah, 0Dh, 03h, 00h, 0D0h, 0DDh, 03h, 00h ; 15f97
	DB 0D8h, 0DDh, 0C1h, 99h ; 15f9f
	ASCII "Q_" ; 15fa3
	DB 9Dh, 99h ; 15fa5
	ASCII "d" ; 15fa7
	DB 0E0h, 97h, 99h, 01h, 9Dh, 99h ; 15fa8
	ASCII "d" ; 15fae
	DB 0E0h ; 15faf
	ASCII "O" ; 15fb0
	DB 9Ah, 0Dh, 7Bh, 0A7h, 0BBh, 5Fh, 0D2h, 5Fh ; 15fb1
	DB 0E9h, 5Fh, 03h, 00h, 18h, 0D6h, 03h, 00h ; 15fb9
	DB 20h, 0D6h ; 15fc1
	ASCII "O" ; 15fc3
	DB 9Ah, 0Dh, 03h, 00h, 28h, 0D6h, 03h, 00h ; 15fc4
	ASCII "0" ; 15fcc
	DB 0D6h, 0C1h, 99h, 0ACh, 5Fh, 03h, 00h, 0ACh ; 15fcd
	DB 0DBh, 03h, 00h, 0B4h, 0DBh ; 15fd5
	ASCII "O" ; 15fda
	DB 9Ah, 0Dh, 03h, 00h, 0BCh, 0DBh, 03h, 00h ; 15fdb
	DB 0B4h, 0DBh, 0C1h, 99h, 0ACh, 5Fh, 03h, 00h ; 15fe3
	DB 00h, 0E0h, 03h, 00h, 08h, 0E0h ; 15feb
	ASCII "O" ; 15ff1
	DB 9Ah, 0Dh, 03h, 00h, 10h, 0E0h, 03h, 00h ; 15ff2
	DB 18h, 0E0h, 0C1h, 99h, 0ACh, 5Fh, 0CEh, 0D0h ; 15ffa
	DB 10h, 1Bh, 0CEh, 0D1h, 12h, 1Bh ; 16002
	ASCII "1" ; 16008
	DB 0E4h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h ; 16009
	DB 0B1h, 1Fh, 0CEh, 0D0h ; 16011
	ASCII "A" ; 16015
	DB 1Bh ; 16016
	ASCII "2" ; 16017
	DB 02h, 0E7h, 03h, 0B1h, 27h, 0CEh, 0D0h, 10h ; 16018
	DB 1Bh, 11h, 0E5h, 02h ; 16020
	ASCII "8" ; 16024
	DB 0CEh, 0D1h, 12h, 1Bh ; 16025
	ASCII "1" ; 16029
	DB 0E6h, 08h, 0E4h, 06h, 0C4h, 0A6h, 5Eh, 0F1h ; 1602a
	DB 2Eh, 0CEh, 0BCh, 00h, 0E6h, 26h, 0CEh, 0C4h ; 16032
	DB 01h, 0F2h, 9Dh, 0CBh ; 1603a
	ASCII "H" ; 1603e
	DB 0CEh, 0D0h ; 1603f
	ASCII "A" ; 16041
	DB 1Bh ; 16042
	ASCII "2" ; 16043
	DB 02h, 0E7h, 03h, 0B1h, 02h, 0CEh, 0D0h, 12h ; 16044
	DB 1Bh, 11h, 0E5h, 02h ; 1604c
	ASCII "8" ; 16050
	DB 0CEh, 0D4h, 12h, 1Bh, 0CEh, 0D1h, 13h, 1Bh ; 16051
	DB 0F2h, 27h, 99h, 0F8h, 0C4h, 0ACh, 5Fh, 0F2h ; 16059
	DB 0EDh, 98h, 0F8h, 0B1h, 1Fh, 0CEh, 0D0h ; 16061
	ASCII "A" ; 16068
	DB 1Bh ; 16069
	ASCII "2" ; 1606a
	DB 02h, 0E7h, 03h, 0B1h, 27h, 0CEh, 0D0h, 10h ; 1606b
	DB 1Bh, 01h, 0CEh, 0D1h, 12h, 1Bh ; 16073
	ASCII "1" ; 16079
	DB 0E5h, 06h, 0C4h ; 1607a
	ASCII "n^" ; 1607d
	DB 0F1h ; 1607f
	ASCII "1" ; 16080
	DB 0CEh, 0BCh ; 16081
	ASCII "O" ; 16083
	DB 0E5h, 29h, 0CEh, 0C4h, 01h, 0F2h ; 16084
	ASCII "O" ; 1608a
	DB 0CBh ; 1608b
	ASCII "H" ; 1608c
	DB 0CEh, 0D0h ; 1608d
	ASCII "A" ; 1608f
	DB 1Bh ; 16090
	ASCII "2" ; 16091
	DB 02h, 0E7h, 03h, 0B1h, 02h, 0CEh, 0D0h, 12h ; 16092
	DB 1Bh, 01h ; 1609a
	ASCII "2O" ; 1609c
	DB 0E4h, 03h, 0B0h ; 1609e
	ASCII "O" ; 160a1
	DB 0CEh, 0D4h, 12h, 1Bh, 0CEh, 0D1h, 13h, 1Bh ; 160a2
	DB 0F2h, 0D6h, 98h, 0F8h, 0C4h ; 160aa
	ASCII "Q_" ; 160af
	DB 0F2h, 9Ch, 98h, 0F8h, 0CEh, 0D0h ; 160b1
	ASCII "A" ; 160b7
	DB 1Bh, 28h, 0E6h, 11h ; 160b8
	ASCII "2" ; 160bc
	DB 02h, 0E6h, 06h, 0C4h ; 160bd
	ASCII "b^" ; 160c1
	DB 0F1h, 04h, 0C4h, 0Ah, 5Fh, 0F2h, 85h, 98h ; 160c3
	DB 0F8h, 0CEh, 0D0h, 10h, 1Bh, 02h, 1Fh, 0CEh ; 160cb
	DB 0D1h, 12h, 1Bh ; 160d3
	ASCII "1" ; 160d6
	DB 0E4h, 07h, 0C4h ; 160d7
	ASCII "D_" ; 160da
	DB 0F2h ; 160dc
	ASCII "q" ; 160dd
	DB 98h, 0F8h, 0CEh, 0D0h ; 160de
	ASCII "A" ; 160e2
	DB 1Bh, 28h, 0E6h, 11h ; 160e3
	ASCII "2" ; 160e7
	DB 02h, 0E6h, 06h, 0C4h ; 160e8
	ASCII "z^" ; 160ec
	DB 0F1h, 04h, 0C4h, 0CCh, 5Eh, 0F2h ; 160ee
	ASCII "Z" ; 160f4
	DB 98h, 0F8h, 0CEh, 0D0h, 10h, 1Bh, 12h, 1Fh ; 160f5
	DB 0E5h, 02h ; 160fd
	ASCII "8" ; 160ff
	DB 0CEh, 0D1h, 12h, 1Bh ; 16100
	ASCII "1" ; 16104
	DB 0E6h, 03h, 0E5h, 07h, 0C4h ; 16105
	ASCII "D_" ; 1610a
	DB 0F2h ; 1610c
	ASCII "A" ; 1610d
	DB 98h, 0F8h ; 1610e
	ASCII "8" ; 16110
	DB 0CEh ; 16111
	ASCII "D" ; 16112
	DB 18h, 0BEh ; 16113
	ASCII "7" ; 16115
	DB 1Bh, 0F8h, 10h, 0E1h, 0E0h, 0E0h, 0A6h, 5Eh ; 16116
	DB 9Dh, 99h ; 1611e
	ASCII "q" ; 16120
	DB 9Ah, 02h, 00h, 0BCh, 0CFh, 02h, 00h, 0C0h ; 16121
	DB 0CFh, 02h, 00h, 0C4h, 0CFh, 9Dh, 99h ; 16129
	ASCII "6" ; 16130
	DB 0E1h, 0C1h, 99h ; 16131
	ASCII "r" ; 16134
	DB 1Ah, 0B9h ; 16135
	ASCII "7" ; 16137
	DB 1Bh, 0C1h, 18h, 00h ; 16138
	ASCII "E(" ; 1613c
	DB 0E6h, 0Fh ; 1613e
	ASCII "8h" ; 16140
	DB 0C4h, 1Eh ; 16142
	ASCII "a" ; 16144
	DB 0F2h, 08h, 98h, 0B8h, 12h, 1Bh, 0F2h ; 16145
	ASCII "5" ; 1614c
	DB 98h, 0F8h ; 1614d
	ASCII "q" ; 1614f
	DB 9Ah ; 16150
	ASCII "6" ; 16151
	DB 0E1h ; 16152
	ASCII "v" ; 16153
	DB 1Ah ; 16154
	ASCII "O" ; 16155
	DB 9Ah, 0Eh, 9Dh, 99h, 81h, 0E1h, 04h, 00h ; 16156
	DB 40h, 0D1h, 04h, 00h ; 1615e
	ASCII "D" ; 16162
	DB 0D1h, 9Dh, 99h ; 16163
	ASCII "l" ; 16166
	DB 0E1h, 0C1h, 99h ; 16167
	ASCII "r" ; 1616a
	DB 1Ah, 0CEh, 0D0h, 1Dh, 1Bh ; 1616b
	ASCII "2" ; 16170
	DB 02h, 0E6h, 02h, 0F8h, 0C4h ; 16171
	ASCII "Ua" ; 16176
	DB 0F2h, 0D5h, 97h, 0CEh, 0C4h, 01h, 0F2h, 7Eh ; 16178
	DB 0DFh, 0CEh, 0D0h, 14h, 1Bh, 28h, 0E6h, 06h ; 16180
	DB 0C4h, 3Ah, 2Ah, 0F1h, 10h, 0B8h, 12h, 1Bh ; 16188
	DB 0CEh, 0BCh, 10h, 0E4h, 06h, 0CEh, 0BCh ; 16190
	ASCII "P" ; 16197
	DB 0E4h, 03h, 0B1h, 10h, 0F2h, 0E4h, 97h, 0F8h ; 16198
	ASCII "q" ; 161a0
	DB 9Ah ; 161a1
	ASCII "l" ; 161a2
	DB 0E1h ; 161a3
	ASCII "v" ; 161a4
	DB 1Ah, 0CEh, 0D0h, 12h, 1Bh ; 161a5
	ASCII "2(" ; 161aa
	DB 0E4h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h ; 161ac
	DB 0CEh, 0D0h, 3Fh, 1Bh, 28h, 0E7h, 18h, 0F2h ; 161b4
	DB 80h, 0EBh, 0F2h, 0BCh, 0CDh, 0CEh, 0C4h, 01h ; 161bc
	DB 0F2h, 0F8h, 0B8h, 0E7h, 0Ah, 0F2h ; 161c4
	ASCII "0" ; 161ca
	DB 0CEh, 0CEh, 0C4h, 01h, 0F2h, 18h, 0DFh, 0F8h ; 161cb
	DB 9Dh, 99h, 0EDh, 0E3h, 01h, 00h, 84h, 0CFh ; 161d3
	DB 8Eh, 99h, 9Dh, 99h ; 161db
	ASCII "q" ; 161df
	DB 9Ah ; 161e0
	ASCII "O" ; 161e1
	DB 9Ah, 20h, 0B4h, 0E1h, 0A6h, 0E1h, 0B0h ; 161e2
	ASCII "b" ; 161e9
	DB 0ECh ; 161ea
	ASCII "a" ; 161eb
	DB 9Dh, 99h ; 161ec
	ASCII "q" ; 161ee
	DB 9Ah, 02h, 00h, 14h, 0D0h, 0Fh, 00h, 1Ch ; 161ef
	DB 0D0h, 0Fh, 00h, 24h, 0D0h, 03h, 00h, 2Ch ; 161f7
	DB 0D0h, 03h, 00h ; 161ff
	ASCII "8" ; 16202
	DB 0D0h, 03h, 00h, 2Ch, 0D0h, 03h, 00h ; 16203
	ASCII "8" ; 1620a
	DB 0D0h, 9Dh, 99h, 0B6h, 0E3h ; 1620b
	ASCII "O" ; 16210
	DB 9Ah, 0Dh, 7Bh, 0A7h, 1Bh ; 16211
	ASCII "b2bIb" ; 16216
	DB 03h, 00h ; 1621b
	ASCII "D" ; 1621d
	DB 0D0h, 03h, 00h ; 1621e
	ASCII "P" ; 16221
	DB 0D0h ; 16222
	ASCII "O" ; 16223
	DB 9Ah, 0Dh, 03h, 00h, 5Ch, 0D0h, 03h, 00h ; 16224
	ASCII "h" ; 1622c
	DB 0D0h, 0C1h, 99h, 0Ch ; 1622d
	ASCII "b" ; 16231
	DB 03h, 00h, 0B4h, 0D9h, 03h, 00h, 0C0h, 0D9h ; 16232
	ASCII "O" ; 1623a
	DB 9Ah, 0Dh, 03h, 00h, 0CCh, 0D9h, 03h, 00h ; 1623b
	DB 0C0h, 0D9h, 0C1h, 99h, 0Ch ; 16243
	ASCII "b" ; 16248
	DB 03h, 00h, 0E0h, 0DDh, 03h, 00h, 0ECh, 0DDh ; 16249
	ASCII "O" ; 16251
	DB 9Ah, 0Dh, 03h, 00h, 0F8h, 0DDh, 03h, 00h ; 16252
	DB 04h, 0DEh, 0C1h, 99h, 0Ch ; 1625a
	ASCII "b" ; 1625f
	DB 9Dh, 99h ; 16260
	ASCII "q" ; 16262
	DB 9Ah ; 16263
	ASCII "O" ; 16264
	DB 9Ah, 1Fh, 7Bh, 0A7h ; 16265
	ASCII "obob{b" ; 16269
	DB 02h, 00h ; 1626f
	ASCII "t" ; 16271
	DB 0D0h, 01h, 00h, 80h, 0D0h, 0C1h, 99h, 83h ; 16272
	ASCII "b" ; 1627a
	DB 02h, 00h, 10h, 0DEh, 01h, 00h, 1Ch, 0DEh ; 1627b
	DB 97h, 99h, 01h, 02h, 00h, 90h, 0D0h, 02h ; 16283
	DB 00h, 94h, 0D0h, 02h, 00h, 98h, 0D0h, 04h ; 1628b
	DB 00h, 9Ch, 0D0h, 04h, 00h, 0A4h, 0D0h, 04h ; 16293
	DB 00h, 0ACh, 0D0h, 04h, 00h, 9Ch, 0D0h, 04h ; 1629b
	DB 00h, 0A4h, 0D0h, 04h, 00h, 0ACh, 0D0h, 9Dh ; 162a3
	DB 99h, 0FCh, 0E3h ; 162ab
	ASCII "n" ; 162ae
	DB 0E3h, 02h, 00h, 90h, 0D6h, 0Fh, 00h, 98h ; 162af
	DB 0D6h, 0Fh, 00h, 0A0h, 0D6h, 03h, 00h, 0A8h ; 162b7
	DB 0D6h, 03h, 00h, 0B4h, 0D6h, 03h, 00h, 0A8h ; 162bf
	DB 0D6h, 03h, 00h, 0B4h, 0D6h, 9Dh, 99h, 0D1h ; 162c7
	DB 0E3h ; 162cf
	ASCII "O" ; 162d0
	DB 9Ah, 0Dh, 7Bh, 0A7h, 0DBh ; 162d1
	ASCII "b" ; 162d6
	DB 0F2h ; 162d7
	ASCII "b" ; 162d8
	DB 09h ; 162d9
	ASCII "c" ; 162da
	DB 03h, 00h, 0C0h, 0D6h, 03h, 00h, 0CCh, 0D6h ; 162db
	ASCII "O" ; 162e3
	DB 9Ah, 0Dh, 03h, 00h, 0D8h, 0D6h, 03h, 00h ; 162e4
	DB 0E4h, 0D6h, 0C1h, 99h, 0CCh ; 162ec
	ASCII "b" ; 162f1
	DB 03h, 00h, 0C8h, 0DBh, 03h, 00h, 0D4h, 0DBh ; 162f2
	ASCII "O" ; 162fa
	DB 9Ah, 0Dh, 03h, 00h, 0E0h, 0DBh, 03h, 00h ; 162fb
	DB 0D4h, 0DBh, 0C1h, 99h, 0CCh ; 16303
	ASCII "b" ; 16308
	DB 03h, 00h, 20h, 0E0h, 03h, 00h, 2Ch, 0E0h ; 16309
	ASCII "O" ; 16311
	DB 9Ah, 0Dh, 03h, 00h ; 16312
	ASCII "8" ; 16316
	DB 0E0h, 03h, 00h ; 16317
	ASCII "D" ; 1631a
	DB 0E0h, 0C1h, 99h, 0CCh ; 1631b
	ASCII "b" ; 1631f
	DB 9Dh, 99h ; 16320
	ASCII "q" ; 16322
	DB 9Ah ; 16323
	ASCII "O" ; 16324
	DB 9Ah, 1Fh, 7Bh, 0A7h, 2Fh ; 16325
	ASCII "c/c;c" ; 1632a
	DB 02h, 00h, 0F0h, 0D6h, 01h, 00h, 0FCh, 0D6h ; 1632f
	DB 0C1h, 99h ; 16337
	ASCII "Cc" ; 16339
	DB 02h, 00h ; 1633b
	ASCII "P" ; 1633d
	DB 0E0h, 01h, 00h, 5Ch, 0E0h, 97h, 99h, 01h ; 1633e
	DB 02h, 00h, 0Ch, 0D7h, 02h, 00h, 10h, 0D7h ; 16346
	DB 02h, 00h, 14h, 0D7h, 04h, 00h, 18h, 0D7h ; 1634e
	DB 04h, 00h, 20h, 0D7h, 04h, 00h, 28h, 0D7h ; 16356
	DB 04h, 00h, 18h, 0D7h, 04h, 00h, 20h, 0D7h ; 1635e
	DB 04h, 00h, 28h, 0D7h, 0C1h, 99h, 0AAh ; 16366
	ASCII "b" ; 1636d
	DB 0C4h, 04h, 00h, 0CEh, 0C4h, 03h, 0F2h, 88h ; 1636e
	DB 0ACh, 28h, 0E6h, 1Fh ; 16376
	ASCII "2" ; 1637a
	DB 01h, 0E6h, 11h ; 1637b
	ASCII "2" ; 1637e
	DB 03h, 0E6h, 0Dh, 0CEh, 0D1h, 12h, 1Bh, 0CEh ; 1637f
	DB 0BCh ; 16387
	ASCII "P" ; 16388
	DB 0E7h, 0Eh, 80h, 0F1h, 0Bh, 0CEh, 0D1h, 12h ; 16389
	DB 1Bh, 0CEh, 0BCh, 00h, 0E7h, 02h, 88h, 00h ; 16391
	DB 0B1h, 00h, 0A6h, 0A2h, 0C6h, 0AAh ; 16399
	ASCII "c" ; 1639f
	DB 0CEh, 0C6h, 01h, 0CFh, 40h, 0CFh, 0D3h, 0AAh ; 163a0
	DB 0AEh, 0F8h, 7Eh ; 163a8
	ASCII "P" ; 163ab
	DB 8Ch ; 163ac
	ASCII "P" ; 163ad
	DB 0B4h ; 163ae
	ASCII "P" ; 163af
	DB 8Ch ; 163b0
	ASCII "P" ; 163b1
	DB 0B4h ; 163b2
	ASCII "P~P" ; 163b3
	DB 0CEh, 0D0h, 12h, 1Bh, 28h, 0E7h, 08h, 0C4h ; 163b6
	DB 60h ; 163be
	ASCII "b" ; 163bf
	DB 0F2h, 8Dh, 95h, 0F8h, 88h, 0CEh, 0D4h, 12h ; 163c0
	DB 1Bh, 0CEh, 0D1h, 13h, 1Bh, 0F2h, 0B3h, 95h ; 163c8
	DB 0F8h, 0CEh, 0D0h, 12h, 1Bh ; 163d0
	ASCII "2P" ; 163d5
	DB 0E4h, 08h, 0C4h, 20h ; 163d7
	ASCII "c" ; 163db
	DB 0F2h ; 163dc
	ASCII "q" ; 163dd
	DB 95h, 0F8h, 80h, 0CEh, 0D4h, 12h, 1Bh, 0CEh ; 163de
	DB 0D1h, 13h, 1Bh, 0F2h, 97h, 95h, 0F8h, 0CEh ; 163e6
	DB 0D0h, 11h, 1Bh ; 163ee
	ASCII "2*" ; 163f1
	DB 0E4h, 07h, 0C4h, 0DDh ; 163f3
	ASCII "a" ; 163f7
	DB 0F2h ; 163f8
	ASCII "U" ; 163f9
	DB 95h, 0F8h, 0B9h ; 163fa
	ASCII "9" ; 163fd
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C1h, 0D5h, 90h ; 163fe
	DB 0E5h, 0E7h, 14h, 0CEh, 0D0h, 11h, 1Bh ; 16406
	ASCII "2" ; 1640d
	DB 1Ch, 0E7h, 0Ch, 0F2h, 0A4h, 00h, 0E7h, 07h ; 1640e
	DB 0C4h, 0D3h ; 16416
	ASCII "a" ; 16418
	DB 0F2h ; 16419
	ASCII "4" ; 1641a
	DB 95h, 0F8h, 0BEh ; 1641b
	ASCII "7" ; 1641e
	DB 1Bh, 0F8h, 1Dh, 0E4h, 0FCh, 0E3h, 7Eh ; 1641f
	ASCII "P" ; 16426
	DB 9Dh, 99h ; 16427
	ASCII "q" ; 16429
	DB 9Ah ; 1642a
	ASCII "O" ; 1642b
	DB 9Ah, 1Fh, 03h, 00h, 0D4h, 0CFh, 03h, 00h ; 1642c
	DB 04h, 0D0h, 03h, 00h, 0D4h, 0CFh, 03h, 00h ; 16434
	DB 08h, 0D0h, 0C1h, 99h, 0ADh ; 1643c
	ASCII "d" ; 16441
	DB 9Dh, 99h, 0DCh, 0E4h, 01h, 00h, 0E4h, 0CFh ; 16442
	DB 01h, 00h, 0DCh, 0CFh, 01h, 00h, 0ECh, 0CFh ; 1644a
	DB 01h, 00h, 0D8h, 0CFh, 01h, 00h, 0FCh, 0CFh ; 16452
	DB 01h, 00h, 0E0h, 0CFh, 01h, 00h, 0F4h, 0CFh ; 1645a
	DB 01h, 00h, 0D4h, 0CFh, 0C1h, 99h ; 16462
	ASCII "Fd" ; 16468
	DB 9Dh, 99h, 22h, 0E5h, 01h, 00h, 0F4h, 0CFh ; 1646a
	DB 01h, 00h, 0E0h, 0CFh, 01h, 00h, 0FCh, 0CFh ; 16472
	DB 01h, 00h, 0D8h, 0CFh, 01h, 00h, 0ECh, 0CFh ; 1647a
	DB 01h, 00h, 0DCh, 0CFh, 01h, 00h, 0E4h, 0CFh ; 16482
	DB 01h, 00h, 0D4h, 0CFh, 0C1h, 99h ; 1648a
	ASCII "nd" ; 16490
	DB 9Dh, 99h ; 16492
	ASCII "q" ; 16494
	DB 9Ah ; 16495
	ASCII "O" ; 16496
	DB 9Ah, 1Fh, 05h, 00h, 0Ch, 0D0h, 05h, 00h ; 16497
	DB 0D4h, 0CFh, 03h, 00h, 08h, 0D0h, 03h, 00h ; 1649f
	DB 0D4h, 0CFh, 03h, 00h, 04h, 0D0h, 9Dh, 99h ; 164a7
	DB 0DBh, 0E5h, 01h, 00h, 0D4h, 0CFh, 8Eh, 99h ; 164af
	DB 0CEh, 0D0h, 10h, 1Bh, 12h, 04h, 0E5h, 02h ; 164b7
	ASCII "8H" ; 164bf
	DB 0CEh, 0D0h, 12h, 1Bh ; 164c1
	ASCII "1" ; 164c5
	DB 0E4h, 12h, 0CEh, 0D0h, 10h, 1Bh, 02h, 05h ; 164c6
	ASCII "H" ; 164ce
	DB 0CEh, 0D0h, 12h, 1Bh ; 164cf
	ASCII "1" ; 164d3
	DB 0E5h, 04h, 9Dh, 01h, 0F8h, 9Ch, 0FEh, 0F8h ; 164d4
	DB 0CEh, 0D0h, 10h, 1Bh, 28h, 0E6h, 10h, 0CEh ; 164dc
	DB 0D0h, 11h, 1Bh ; 164e4
	ASCII "2," ; 164e7
	DB 0E7h, 08h, 0C4h, 92h ; 164e9
	ASCII "d" ; 164ed
	DB 0F2h, 5Fh, 94h, 0F8h, 0CEh, 0D0h, 10h, 1Bh ; 164ee
	DB 80h, 80h, 0CEh, 0D4h, 10h, 1Bh ; 164f6
	ASCII "2(" ; 164fc
	DB 0E4h, 13h, 0CEh, 0D0h, 11h, 1Bh, 80h, 80h ; 164fe
	ASCII "2," ; 16506
	DB 0E4h, 03h, 0B0h, 2Ch, 0CEh, 0D4h, 11h, 1Bh ; 16508
	DB 0F1h, 0Ah, 0CEh, 0D0h, 11h, 1Bh, 88h, 0CEh ; 16510
	DB 0D4h, 11h, 1Bh, 0B8h, 10h, 1Bh, 0F2h ; 16518
	ASCII "b" ; 1651f
	DB 94h, 0F8h, 0CEh, 0D0h, 10h, 1Bh ; 16520
	ASCII "2P" ; 16526
	DB 0E6h, 10h, 0CEh, 0D0h, 11h, 1Bh ; 16528
	ASCII "2," ; 1652e
	DB 0E7h, 08h, 0C4h, 92h ; 16530
	ASCII "d" ; 16534
	DB 0F2h, 18h, 94h, 0F8h, 0CEh, 0D0h, 10h, 1Bh ; 16535
	DB 88h, 88h, 0CEh, 0D4h, 10h, 1Bh ; 1653d
	ASCII "2(" ; 16543
	DB 0E5h, 13h, 0CEh, 0D0h, 11h, 1Bh, 80h, 80h ; 16545
	ASCII "2," ; 1654d
	DB 0E4h, 03h, 0B0h, 2Ch, 0CEh, 0D4h, 11h, 1Bh ; 1654f
	DB 0F1h, 0Ah, 0CEh, 0D0h, 11h, 1Bh, 88h, 0CEh ; 16557
	DB 0D4h, 11h, 1Bh, 0B8h, 10h, 1Bh, 0F2h, 1Bh ; 1655f
	DB 94h, 0F8h, 0B9h ; 16567
	ASCII "7" ; 1656a
	DB 1Bh, 0C1h, 02h, 00h, 0CFh, 0C1h, 0D5h ; 1656b
	ASCII "Fc" ; 16572
	DB 0E6h, 0Bh, 0D5h, 86h ; 16574
	ASCII "b" ; 16578
	DB 0E7h, 15h, 0C4h ; 16579
	ASCII "Bd" ; 1657c
	DB 0F1h, 04h, 0C4h ; 1657e
	ASCII "jd" ; 16581
	DB 0F2h, 0CAh, 93h, 0B8h, 12h, 1Bh, 0BCh, 10h ; 16583
	DB 1Bh, 0F2h, 0F4h, 93h, 0F8h, 0CEh, 0D0h ; 1658b
	ASCII "B" ; 16592
	DB 1Bh, 28h, 0E6h, 07h, 0C4h, 0E9h, 0E5h, 0F2h ; 16593
	DB 0ACh, 93h, 0CEh, 0D0h, 11h, 1Bh ; 1659b
	ASCII "2," ; 165a1
	DB 0E4h, 08h, 0C4h, 27h ; 165a3
	ASCII "d" ; 165a7
	DB 0F2h, 0A5h, 93h, 0F8h, 80h, 0CEh, 0D4h, 11h ; 165a8
	DB 1Bh, 0B8h, 10h, 1Bh, 0F2h, 0CCh, 93h, 0CEh ; 165b0
	DB 0D0h, 11h, 1Bh ; 165b8
	ASCII "2*" ; 165bb
	DB 0E7h, 1Ch, 0B9h ; 165bd
	ASCII "7" ; 165c0
	DB 1Bh, 0C1h, 02h, 00h, 0CFh, 0C1h, 0D5h, 0D3h ; 165c1
	ASCII "a" ; 165c9
	DB 0E4h, 0Fh, 0D5h, 0DDh ; 165ca
	ASCII "a" ; 165ce
	DB 0E5h, 0Ah, 0C5h ; 165cf
	ASCII "i" ; 165d2
	DB 0E5h, 0C4h ; 165d3
	ASCII "r" ; 165d5
	DB 1Ah, 0F2h, 97h, 93h, 0F8h, 0CEh, 0D0h ; 165d6
	ASCII "B" ; 165dd
	DB 1Bh, 28h, 0E6h, 07h, 0C4h, 0E9h, 0E5h, 0F2h ; 165de
	ASCII "a" ; 165e6
	DB 93h, 0F8h, 0CEh, 0D0h ; 165e7
	ASCII "B" ; 165eb
	DB 1Bh, 28h, 0E7h, 2Bh, 0CEh, 0D0h, 11h, 1Bh ; 165ec
	ASCII "2," ; 165f4
	DB 0E5h, 1Ch, 0CEh, 0D0h, 11h, 1Bh, 0CEh ; 165f6
	ASCII "D" ; 165fd
	DB 18h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 165fe
	DB 0B0h, 11h, 0CEh, 0D4h, 0FAh, 14h, 0C4h, 90h ; 16606
	DB 0E5h, 0F2h ; 1660e
	ASCII "7" ; 16610
	DB 93h, 0F8h, 0C4h, 0DBh, 0E5h, 0F2h ; 16611
	ASCII "0" ; 16617
	DB 93h, 0F8h, 0B8h, 10h, 1Bh, 0F2h ; 16618
	ASCII "c" ; 1661e
	DB 93h, 0F8h, 0BEh ; 1661f
	ASCII "9" ; 16622
	DB 1Bh, 0F8h, 21h, 0E6h ; 16623
	ASCII "q" ; 16627
	DB 9Ah, 0ADh ; 16628
	ASCII "d" ; 1662a
	DB 9Dh, 99h, 0A2h, 0E6h, 02h, 00h, 0CCh, 0CFh ; 1662b
	DB 9Dh, 99h, 7Fh, 0E6h, 01h, 00h, 0D0h, 0CFh ; 16633
	DB 8Eh, 99h, 9Dh, 99h, 0B5h, 0E6h, 02h, 00h ; 1663b
	DB 0CCh, 0CFh, 01h, 00h, 0C8h, 0CFh, 8Eh, 99h ; 16643
	DB 0CEh, 0D0h, 10h, 1Bh, 12h, 02h, 0E5h, 02h ; 1664b
	ASCII "8" ; 16653
	DB 0CEh ; 16654
	ASCII "H" ; 16655
	DB 0Ah ; 16656
	ASCII "1" ; 16657
	DB 0E6h, 0Ch, 0E5h, 21h, 0CEh, 0D0h, 10h, 1Bh ; 16658
	DB 02h, 02h ; 16660
	ASCII "1" ; 16662
	DB 0E4h, 18h, 0CEh, 0D1h, 11h, 1Bh, 0CEh, 40h ; 16663
	DB 0Eh, 02h, 0Ah ; 1666b
	ASCII "1" ; 1666e
	DB 0E4h, 0Ch, 0CEh, 40h, 0Eh ; 1666f
	ASCII "1" ; 16674
	DB 0E6h, 03h, 0E5h, 04h, 9Ch, 0FEh, 0F8h, 9Dh ; 16675
	DB 01h, 0F8h ; 1667d
	ASCII "8" ; 1667f
	DB 0CEh, 0D4h ; 16680
	ASCII "B" ; 16682
	DB 1Bh, 0F2h, 0C5h, 0FFh, 0E6h, 09h, 0CEh, 0D0h ; 16683
	ASCII "B" ; 1668b
	DB 16h, 96h, 01h, 0E7h, 08h, 0C4h, 3Dh ; 1668c
	ASCII "f" ; 16693
	DB 0F2h, 0B9h, 92h, 0F8h, 0B0h, 01h, 0CEh, 0D4h ; 16694
	ASCII "B" ; 1669c
	DB 1Bh, 0F2h ; 1669d
	ASCIZ "6" ; 1669f
	DB 0F8h, 0CEh, 0D0h ; 166a1
	ASCII "B" ; 166a4
	DB 16h, 96h, 01h, 0E7h, 08h, 0C4h, 3Dh ; 166a5
	ASCII "f" ; 166ac
	DB 0F2h, 0A0h, 92h, 0F8h, 0F2h, 96h, 00h, 0F8h ; 166ad
	DB 0B9h ; 166b5
	ASCII "9" ; 166b6
	DB 1Bh, 0C1h, 04h, 00h, 0CFh, 0C1h, 0D5h, 0DBh ; 166b7
	DB 0E5h, 0E6h, 02h, 0F8h, 0CEh, 0D0h ; 166bf
	ASCII "C" ; 166c5
	DB 16h, 96h, 01h, 0E6h, 08h, 0C4h, 2Bh ; 166c6
	ASCII "f" ; 166cd
	DB 0F2h, 7Fh, 92h, 0F8h, 0F2h ; 166ce
	ASCIZ "u" ; 166d3
	DB 0F8h, 0CFh, 0E6h, 0C1h, 0Ah, 00h, 0F2h, 0Ah ; 166d5
	DB 00h, 0CFh, 0E6h, 0C1h, 0Eh, 00h, 0F2h ; 166dd
	ASCIZ "3" ; 166e4
	DB 0F8h, 0CEh, 0D0h ; 166e6
	ASCII "B" ; 166e9
	DB 16h, 96h, 20h, 0E7h, 19h, 96h, 40h, 0E6h ; 166ea
	DB 25h ; 166f2
	ASCII "E2P" ; 166f3
	DB 0E5h, 20h, 0CEh, 0D0h, 10h, 1Bh ; 166f6
	ASCII "2P" ; 166fc
	DB 0E5h, 18h, 86h, 0C5h, 10h, 1Bh, 86h, 0F1h ; 166fe
	DB 11h ; 16706
	ASCII "E(" ; 16707
	DB 0E6h, 0Dh, 0CEh, 0D0h, 10h, 1Bh, 28h, 0E6h ; 16709
	DB 06h, 8Eh, 0C5h, 10h, 1Bh, 8Eh, 0F8h, 0CEh ; 16711
	DB 0D0h ; 16719
	ASCII "B" ; 1671a
	DB 16h, 96h, 08h, 0E7h, 19h, 96h, 10h, 0E6h ; 1671b
	DB 25h ; 16723
	ASCII "E2," ; 16724
	DB 0E5h, 20h, 0CEh, 0D0h, 11h, 1Bh ; 16727
	ASCII "2," ; 1672d
	DB 0E5h, 18h, 86h, 0C5h, 11h, 1Bh, 86h, 0F1h ; 1672f
	DB 11h ; 16737
	ASCII "E(" ; 16738
	DB 0E6h, 0Dh, 0CEh, 0D0h, 11h, 1Bh, 28h, 0E6h ; 1673a
	DB 06h, 8Eh, 0C5h, 11h, 1Bh, 8Eh, 0F8h, 0CEh ; 16742
	DB 0D0h ; 1674a
	ASCII "B" ; 1674b
	DB 16h, 96h, 20h, 0E7h, 12h, 96h, 40h, 0E6h ; 1674c
	DB 18h, 0CEh, 40h, 0Ah ; 16754
	ASCII "2P" ; 16758
	DB 0E5h, 11h, 80h, 0CEh ; 1675a
	ASCII "D" ; 1675e
	DB 0Ah, 0F1h, 0Bh, 0CEh, 40h, 0Ah, 28h, 0E6h ; 1675f
	DB 05h, 88h, 0CEh ; 16767
	ASCII "D" ; 1676a
	DB 0Ah, 0CEh, 0D0h ; 1676b
	ASCII "B" ; 1676e
	DB 16h, 96h, 08h, 0E7h, 12h, 96h, 10h, 0E6h ; 1676f
	DB 18h, 0CEh, 40h, 0Eh ; 16777
	ASCII "2," ; 1677b
	DB 0E5h, 11h, 80h, 0CEh ; 1677d
	ASCII "D" ; 16781
	DB 0Eh, 0F1h, 0Bh, 0CEh, 40h, 0Eh, 28h, 0E6h ; 16782
	DB 05h, 88h, 0CEh ; 1678a
	ASCII "D" ; 1678d
	DB 0Eh, 0F8h ; 1678e
	ASCII "q" ; 16790
	DB 9Ah, 0B5h, 0E6h ; 16791
	ASCII "Ef" ; 16794
	DB 01h, 00h, 0B4h, 0D0h, 8Eh, 99h, 0CEh, 0D0h ; 16796
	ASCII "B" ; 1679e
	DB 16h, 96h, 01h, 0E7h, 08h, 0C4h, 0AEh, 0E7h ; 1679f
	DB 0F2h, 9Fh, 91h, 0F8h, 0F3h, 2Ch, 00h, 0CEh ; 167a7
	DB 0D0h ; 167af
	ASCII "C" ; 167b0
	DB 16h, 96h, 01h, 0E6h, 24h, 0CEh, 0D0h, 3Fh ; 167b1
	DB 1Bh, 28h, 0E7h, 1Dh, 0CEh, 0D0h ; 167b9
	ASCII "C" ; 167bf
	DB 1Bh ; 167c0
	ASCII "2" ; 167c1
	DB 0Fh, 0E5h, 15h, 0A3h, 0CEh ; 167c2
	ASCII "P" ; 167c7
	DB 0Ah, 0CEh ; 167c8
	ASCII "X" ; 167ca
	DB 0Eh, 0C7h, 01h ; 167cb
	ASCII "l" ; 167ce
	DB 0F2h, 0B3h, 0B3h, 0ABh, 0C4h, 9Ch, 0E7h, 0F2h ; 167cf
	ASCII "p" ; 167d7
	DB 91h, 0CEh, 0D0h ; 167d8
	ASCII "B" ; 167db
	DB 16h, 96h, 08h, 0E7h, 0Fh, 96h, 10h, 0E6h ; 167dc
	DB 15h, 0CEh, 40h, 0Eh ; 167e4
	ASCII "2" ; 167e8
	DB 1Ah, 0E5h, 0Eh, 80h, 0F1h, 08h, 0CEh, 40h ; 167e9
	DB 0Eh, 28h, 0E6h, 05h, 88h, 0CEh ; 167f1
	ASCII "D" ; 167f7
	DB 0Eh, 0F8h ; 167f8
	ASCII "8" ; 167fa
	DB 0CEh, 0D4h ; 167fb
	ASCII "C" ; 167fd
	DB 1Bh, 0F8h, 0FAh, 0E7h, 0AEh, 0E7h, 96h ; 167fe
	ASCII "g" ; 16805
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0F8h, 0D0h ; 16806
	DB 0Ah, 00h, 0Ch, 0D1h, 0F4h, 99h, 00h, 01h ; 1680e
	DB 0Ah, 00h, 0F8h, 0D0h, 0Ah, 00h, 0Ch, 0D1h ; 16816
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 0F8h, 0D0h ; 1681e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 0Ch, 0D1h ; 16826
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0F8h, 0D0h ; 1682e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 0Ch, 0D1h ; 16836
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0F8h, 0D0h ; 1683e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 0Ch, 0D1h ; 16846
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0F8h, 0D0h ; 1684e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 0Ch, 0D1h ; 16856
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0F8h, 0D0h ; 1685e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0Ch, 0D1h ; 16866
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 0F8h, 0D0h ; 1686e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0Ch, 0D1h ; 16876
	DB 0C1h, 99h, 06h ; 1687e
	ASCII "h" ; 16881
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0FCh, 0D0h ; 16882
	DB 0Ah, 00h, 10h, 0D1h, 0F4h, 99h, 00h, 01h ; 1688a
	DB 0Ah, 00h, 0FCh, 0D0h, 0Ah, 00h, 10h, 0D1h ; 16892
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 0FCh, 0D0h ; 1689a
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 10h, 0D1h ; 168a2
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0FCh, 0D0h ; 168aa
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 10h, 0D1h ; 168b2
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0FCh, 0D0h ; 168ba
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 10h, 0D1h ; 168c2
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0FCh, 0D0h ; 168ca
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 10h, 0D1h ; 168d2
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 0FCh, 0D0h ; 168da
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 10h, 0D1h ; 168e2
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 0FCh, 0D0h ; 168ea
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 10h, 0D1h ; 168f2
	DB 0C1h, 99h, 82h ; 168fa
	ASCII "h" ; 168fd
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 00h, 0D1h ; 168fe
	DB 0Ah, 00h, 14h, 0D1h, 0F4h, 99h, 00h, 01h ; 16906
	DB 0Ah, 00h, 00h, 0D1h, 0Ah, 00h, 14h, 0D1h ; 1690e
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 00h, 0D1h ; 16916
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 14h, 0D1h ; 1691e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 00h, 0D1h ; 16926
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 14h, 0D1h ; 1692e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 00h, 0D1h ; 16936
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 14h, 0D1h ; 1693e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 00h, 0D1h ; 16946
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 14h, 0D1h ; 1694e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 00h, 0D1h ; 16956
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 14h, 0D1h ; 1695e
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 00h, 0D1h ; 16966
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 14h, 0D1h ; 1696e
	DB 0C1h, 99h, 0FEh ; 16976
	ASCII "h" ; 16979
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 04h, 0D1h ; 1697a
	DB 0Ah, 00h, 18h, 0D1h, 0F4h, 99h, 00h, 01h ; 16982
	DB 0Ah, 00h, 04h, 0D1h, 0Ah, 00h, 18h, 0D1h ; 1698a
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 04h, 0D1h ; 16992
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 18h, 0D1h ; 1699a
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 04h, 0D1h ; 169a2
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 18h, 0D1h ; 169aa
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 04h, 0D1h ; 169b2
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 18h, 0D1h ; 169ba
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 04h, 0D1h ; 169c2
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 18h, 0D1h ; 169ca
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 04h, 0D1h ; 169d2
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 18h, 0D1h ; 169da
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 04h, 0D1h ; 169e2
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 18h, 0D1h ; 169ea
	DB 0C1h, 99h ; 169f2
	ASCII "zi" ; 169f4
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 08h, 0D1h ; 169f6
	DB 0Ah, 00h, 1Ch, 0D1h, 0F4h, 99h, 00h, 01h ; 169fe
	DB 0Ah, 00h, 08h, 0D1h, 0Ah, 00h, 1Ch, 0D1h ; 16a06
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 08h, 0D1h ; 16a0e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 1Ch, 0D1h ; 16a16
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 08h, 0D1h ; 16a1e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 1Ch, 0D1h ; 16a26
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 08h, 0D1h ; 16a2e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 1Ch, 0D1h ; 16a36
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 08h, 0D1h ; 16a3e
	DB 0F4h, 99h, 00h, 0FFh, 0Ah, 00h, 1Ch, 0D1h ; 16a46
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 08h, 0D1h ; 16a4e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 1Ch, 0D1h ; 16a56
	DB 0F4h, 99h, 00h, 01h, 0Ah, 00h, 08h, 0D1h ; 16a5e
	DB 0F4h, 99h, 00h, 00h, 0Ah, 00h, 1Ch, 0D1h ; 16a66
	DB 0C1h, 99h, 0F6h ; 16a6e
	ASCII "iO" ; 16a71
	DB 9Ah, 1Eh, 04h, 00h, 20h, 0D1h, 0C1h, 99h ; 16a73
	DB 0A5h ; 16a7b
	ASCII "jO" ; 16a7c
	DB 9Ah, 1Eh, 04h, 00h, 24h, 0D1h, 0C1h, 99h ; 16a7e
	DB 0A5h ; 16a86
	ASCII "jO" ; 16a87
	DB 9Ah, 1Eh, 04h, 00h, 28h, 0D1h, 0C1h, 99h ; 16a89
	DB 0A5h ; 16a91
	ASCII "jO" ; 16a92
	DB 9Ah, 1Eh, 04h, 00h, 2Ch, 0D1h, 0C1h, 99h ; 16a94
	DB 0A5h ; 16a9c
	ASCII "jO" ; 16a9d
	DB 9Ah, 1Eh, 04h, 00h ; 16a9f
	ASCII "0" ; 16aa3
	DB 0D1h, 0EBh, 0EAh, 0C1h, 99h, 0DEh ; 16aa4
	ASCII "j" ; 16aaa
	DB 08h, 00h ; 16aab
	ASCII "m" ; 16aad
	DB 1Ah, 04h, 00h, 0B8h, 0D0h, 08h, 00h, 0C0h ; 16aae
	DB 0D0h, 0FDh, 0EAh, 0Ch, 00h, 0C8h, 0D0h, 0FDh ; 16ab6
	DB 0EAh, 10h, 00h, 0D0h, 0D0h, 0FDh, 0EAh, 14h ; 16abe
	DB 00h, 0D8h, 0D0h, 0FDh, 0EAh, 18h, 00h, 0E0h ; 16ac6
	DB 0D0h, 0FDh, 0EAh, 1Ch, 00h, 0E8h, 0D0h, 7Ch ; 16ace
	DB 0AFh ; 16ad6
	ASCII "O" ; 16ad7
	DB 9Ah, 1Eh, 04h, 00h, 0F0h, 0D0h, 9Dh, 99h ; 16ad8
	ASCII "q" ; 16ae0
	DB 9Ah ; 16ae1
	ASCII "O" ; 16ae2
	DB 9Ah, 21h, 04h, 00h ; 16ae3
	ASCII "m" ; 16ae7
	DB 1Ah, 88h, 99h, 0C5h ; 16ae8
	ASCII "C" ; 16aec
	DB 1Bh, 8Eh, 0B8h ; 16aed
	ASCII "9" ; 16af0
	DB 1Bh, 0CFh, 1Ah, 0E7h, 07h, 0C5h, 00h, 00h ; 16af1
	DB 0BDh ; 16af9
	ASCII "9" ; 16afa
	DB 1Bh, 0F8h, 0CEh, 40h, 18h, 80h, 0CEh ; 16afb
	ASCII "D" ; 16b02
	DB 18h, 0F8h, 0CEh, 40h, 19h, 28h, 0E6h, 06h ; 16b03
	DB 88h, 0CEh ; 16b0b
	ASCII "D" ; 16b0d
	DB 19h, 0F8h, 0CEh, 40h, 18h, 0F2h, 0BBh, 00h ; 16b0e
	DB 0CEh ; 16b16
	ASCII "D" ; 16b17
	DB 19h, 0CEh, 40h, 0Ah, 88h, 0CEh ; 16b18
	ASCII "D" ; 16b1e
	DB 0Ah, 28h, 0E7h, 18h, 0A6h, 0A3h, 0CEh, 40h ; 16b1f
	DB 18h, 00h, 0B1h, 00h, 0C7h, 3Bh ; 16b27
	ASCII "k" ; 16b2d
	DB 0CEh, 0C7h, 01h, 0CFh ; 16b2e
	ASCII "B" ; 16b32
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0F2h, 16h, 8Eh, 0F8h ; 16b33
	DB 0DEh ; 16b3b
	ASCII "jrj}j" ; 16b3c
	DB 88h ; 16b41
	ASCII "j" ; 16b42
	DB 93h ; 16b43
	ASCII "j" ; 16b44
	DB 9Eh ; 16b45
	ASCII "j" ; 16b46
	DB 0CEh, 0D0h ; 16b47
	ASCII "B" ; 16b49
	DB 16h, 96h, 01h, 0E7h ; 16b4a
	ASCII "e" ; 16b4e
	DB 0F2h, 0ECh, 0E1h, 0F2h, 28h, 0C4h, 0CEh, 40h ; 16b4f
	DB 18h, 28h, 0E6h, 26h, 0CEh, 0D0h, 0B6h, 1Ah ; 16b57
	DB 20h, 0E6h, 07h, 0B0h, 1Dh, 0CEh, 0D4h, 0FAh ; 16b5f
	DB 14h, 0BEh ; 16b67
	ASCII "9" ; 16b69
	DB 1Bh, 0C5h ; 16b6a
	ASCII "C" ; 16b6c
	DB 1Bh, 86h, 0CEh, 0C4h, 01h, 0F2h ; 16b6d
	ASCII "J" ; 16b73
	DB 0AFh, 0E7h, 0Ah, 0F2h, 7Dh, 0C4h, 0CEh, 0C4h ; 16b74
	DB 01h, 0F2h ; 16b7c
	ASCII "j" ; 16b7e
	DB 0D5h, 0A6h, 0A3h, 0CEh, 40h, 18h, 00h, 0B1h ; 16b7f
	DB 00h, 0C7h, 0C4h ; 16b87
	ASCII "k" ; 16b8a
	DB 0CEh, 0C7h, 01h, 0CFh ; 16b8b
	ASCII "B" ; 16b8f
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0C5h, 05h, 0EBh, 0F2h ; 16b90
	DB 0D7h, 8Dh, 0CEh, 40h, 18h, 0F2h ; 16b98
	ASCIZ "1" ; 16b9e
	DB 0CEh ; 16ba0
	ASCII "D" ; 16ba1
	DB 19h ; 16ba2
	ASCII "H" ; 16ba3
	DB 0CEh, 40h, 18h, 0F2h, 3Dh, 00h ; 16ba4
	ASCII "H" ; 16baa
	DB 0CEh, 40h, 0Ah, 11h, 0CEh ; 16bab
	ASCII "D" ; 16bb0
	DB 0Ah, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 16bb1
	DB 07h, 0B0h, 1Ch, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 16bb9
	DB 17h, 0FCh, 0F8h, 0DEh ; 16bc1
	ASCII "j" ; 16bc5
	DB 06h ; 16bc6
	ASCII "h" ; 16bc7
	DB 82h ; 16bc8
	ASCII "h" ; 16bc9
	DB 0FEh ; 16bca
	ASCII "hzi" ; 16bcb
	DB 0F6h ; 16bce
	ASCII "i" ; 16bcf
	DB 0A6h, 0A3h, 0B1h, 00h, 0C7h, 0E0h ; 16bd0
	ASCII "k" ; 16bd6
	DB 0CEh, 0C7h, 01h, 0CFh ; 16bd7
	ASCII "BG" ; 16bdb
	DB 0ABh, 0AEh, 0F8h, 00h, 05h, 07h, 09h, 0Bh ; 16bdd
	DB 0Dh, 0A6h, 0A3h, 0B1h, 00h, 0C7h, 0F6h ; 16be5
	ASCII "k" ; 16bec
	DB 0CEh, 0C7h, 01h, 0CFh ; 16bed
	ASCII "BG" ; 16bf1
	DB 0ABh, 0AEh, 0F8h, 00h, 07h, 09h, 0Bh, 0Dh ; 16bf3
	DB 0Fh ; 16bfb
	ASCII "8" ; 16bfc
	DB 0CEh ; 16bfd
	ASCII "D" ; 16bfe
	DB 18h, 0F8h, 0FCh, 0EBh ; 16bff
	ASCII "G" ; 16c03
	DB 0EBh, 0ABh ; 16c04
	ASCII "j" ; 16c06
	DB 9Dh, 99h, 81h, 0EDh, 7Bh, 0A7h, 13h ; 16c07
	ASCII "l'l;l" ; 16c0e
	DB 1Eh, 00h ; 16c13
	ASCII "H" ; 16c15
	DB 0CCh, 04h, 00h ; 16c16
	ASCII "p" ; 16c19
	DB 0CCh, 04h, 00h ; 16c1a
	ASCII "H" ; 16c1d
	DB 0CCh, 04h, 00h ; 16c1e
	ASCII "p" ; 16c21
	DB 0CCh, 0C1h, 99h, 0Bh ; 16c22
	ASCII "l" ; 16c26
	DB 1Eh, 00h, 0A4h, 0D8h, 04h, 00h, 0CCh, 0D8h ; 16c27
	DB 04h, 00h, 0A4h, 0D8h, 04h, 00h, 0CCh, 0D8h ; 16c2f
	DB 0C1h, 99h, 0Bh ; 16c37
	ASCII "l" ; 16c3a
	DB 1Eh, 00h, 0CCh, 0DCh, 04h, 00h, 0F4h, 0DCh ; 16c3b
	DB 04h, 00h, 0CCh, 0DCh, 04h, 00h, 0F4h, 0DCh ; 16c43
	DB 0C1h, 99h, 0Bh ; 16c4b
	ASCII "l" ; 16c4e
	DB 9Dh, 99h, 01h, 0EDh, 7Bh, 0A7h, 5Bh ; 16c4f
	ASCII "lalgl" ; 16c56
	DB 01h, 00h ; 16c5b
	ASCII "H" ; 16c5d
	DB 0CCh, 8Eh, 99h, 01h, 00h, 0A4h, 0D8h, 8Eh ; 16c5e
	DB 99h, 01h, 00h, 0CCh, 0DCh, 8Eh, 99h, 9Dh ; 16c66
	DB 99h, 0E5h, 0ECh, 7Bh, 0A7h ; 16c6e
	ASCII "yll" ; 16c73
	DB 85h ; 16c77
	ASCII "l" ; 16c78
	DB 01h, 00h ; 16c79
	ASCII "8" ; 16c7b
	DB 0CCh, 8Eh, 99h, 01h, 00h, 94h, 0D8h, 8Eh ; 16c7c
	DB 99h, 01h, 00h, 0BCh, 0DCh, 8Eh, 99h, 9Dh ; 16c84
	DB 99h, 0B9h, 0ECh ; 16c8c
	ASCII "O" ; 16c8f
	DB 9Ah, 0Dh, 08h, 00h ; 16c90
	ASCII "4" ; 16c94
	DB 0D1h, 08h, 00h ; 16c95
	ASCII "8" ; 16c98
	DB 0D1h ; 16c99
	ASCII "O" ; 16c9a
	DB 9Ah, 0Dh, 08h, 00h, 3Ch, 0D1h, 08h, 00h ; 16c9b
	ASCII "8" ; 16ca3
	DB 0D1h, 0C1h, 99h, 8Fh ; 16ca4
	ASCII "l" ; 16ca8
	DB 9Dh, 99h ; 16ca9
	ASCII "q" ; 16cab
	DB 9Ah, 14h, 00h ; 16cac
	ASCII "8" ; 16caf
	DB 0D1h, 9Dh, 99h ; 16cb0
	ASCII "e" ; 16cb3
	DB 0EDh, 0C1h, 99h, 0A4h ; 16cb4
	ASCII "R" ; 16cb8
	DB 0A6h, 0A3h, 0F2h ; 16cb9
	ASCIZ "e" ; 16cbc
	DB 0F1h, 23h, 0BBh ; 16cbe
	ASCII "9" ; 16cc1
	DB 1Bh, 0CEh, 0C7h, 00h, 0CEh ; 16cc2
	ASCII "A" ; 16cc7
	DB 18h, 0F2h, 05h, 0FFh, 0CEh ; 16cc8
	ASCII "I" ; 16ccd
	DB 19h ; 16cce
	ASCII "1" ; 16ccf
	DB 0E7h, 11h, 0CEh, 0D0h, 12h, 1Bh, 88h, 0CEh ; 16cd0
	DB 0D4h, 12h, 1Bh, 0CEh, 0D1h, 13h, 1Bh, 0F2h ; 16cd8
	DB 0A1h, 8Ch, 0ABh, 0AEh, 0F8h, 0F2h, 3Bh, 00h ; 16ce0
	DB 0F1h, 17h, 0B9h ; 16ce8
	ASCII "9" ; 16ceb
	DB 1Bh, 0C1h, 0Ah, 00h ; 16cec
	ASCII "E" ; 16cf0
	DB 02h, 18h, 0CEh, 0D1h, 12h, 1Bh ; 16cf1
	ASCII "1" ; 16cf7
	DB 0E5h, 07h, 0C4h, 8Bh ; 16cf8
	ASCII "l" ; 16cfc
	DB 0F2h ; 16cfd
	ASCII "P" ; 16cfe
	DB 8Ch, 0F8h, 0B9h ; 16cff
	ASCII "9" ; 16d02
	DB 1Bh, 0D5h, 00h, 00h, 0E6h, 13h, 0C1h, 0Ah ; 16d03
	DB 00h ; 16d0b
	ASCII "E" ; 16d0c
	DB 02h, 08h, 0CEh, 0D1h, 12h, 1Bh ; 16d0d
	ASCII "1" ; 16d13
	DB 0E5h, 0Ch, 0C4h ; 16d14
	ASCII "ml" ; 16d17
	DB 0F1h, 04h, 0C4h ; 16d19
	ASCII "Ol" ; 16d1c
	DB 0F2h, 2Fh, 8Ch, 0F8h, 0B9h ; 16d1e
	ASCII "9" ; 16d23
	DB 1Bh, 0D5h, 00h, 00h, 0E6h, 2Ah, 0C1h, 02h ; 16d24
	DB 00h, 0CFh, 0C1h, 0D5h ; 16d2c
	ASCII "rj" ; 16d30
	DB 0E4h, 06h, 0D5h, 0ABh ; 16d32
	ASCII "j" ; 16d36
	DB 0E4h, 25h, 0B9h ; 16d37
	ASCII "9" ; 16d3a
	DB 1Bh, 0C1h, 0Ah, 00h ; 16d3b
	ASCII "E" ; 16d3f
	DB 0CEh, 0D1h, 12h, 1Bh ; 16d40
	ASCII "1" ; 16d44
	DB 0E4h, 1Eh, 0CEh, 0BCh, 40h, 0E4h, 08h, 0C4h ; 16d45
	ASCII "Ol" ; 16d4d
	DB 0F2h, 0FEh, 8Bh, 0F8h, 0C5h ; 16d4f
	ASCII "e" ; 16d54
	DB 0EDh, 0C4h, 0A4h ; 16d55
	ASCII "R" ; 16d58
	DB 0F2h, 15h, 8Ch, 0F8h, 0C4h, 0A9h ; 16d59
	ASCII "l" ; 16d5f
	DB 0F2h, 0EDh, 8Bh, 0F8h, 0FAh, 0CEh, 0D0h, 12h ; 16d60
	DB 1Bh ; 16d68
	ASCII "2@" ; 16d69
	DB 0E4h, 14h, 0B0h, 40h, 0CEh, 0D4h, 12h, 1Bh ; 16d6b
	DB 0CEh, 0D1h, 13h, 1Bh, 0F2h, 09h, 8Ch, 0C4h ; 16d73
	DB 07h ; 16d7b
	ASCII "l" ; 16d7c
	DB 0F2h, 0D0h, 8Bh, 0F8h, 0B9h ; 16d7d
	ASCII "9" ; 16d82
	DB 1Bh, 0D5h, 00h, 00h, 0E6h, 07h, 0C4h ; 16d83
	ASCII "Ol" ; 16d8a
	DB 0F2h, 0C1h, 8Bh, 0F8h ; 16d8c
	ASCII "q" ; 16d90
	DB 9Ah, 81h, 0EDh, 07h ; 16d91
	ASCII "l" ; 16d95
	DB 0D6h, 99h, 28h, 00h, 18h, 00h, 06h, 00h ; 16d96
	ASCII "l" ; 16d9e
	DB 0E0h, 01h, 00h ; 16d9f
	ASCII "t" ; 16da2
	DB 0E0h, 06h, 00h ; 16da3
	ASCII "l" ; 16da6
	DB 0E0h, 01h, 00h ; 16da7
	ASCII "t" ; 16daa
	DB 0E0h, 05h, 00h ; 16dab
	ASCII "l" ; 16dae
	DB 0E0h, 01h, 00h ; 16daf
	ASCII "t" ; 16db2
	DB 0E0h, 05h, 00h ; 16db3
	ASCII "l" ; 16db6
	DB 0E0h, 01h, 00h ; 16db7
	ASCII "t" ; 16dba
	DB 0E0h, 04h, 00h ; 16dbb
	ASCII "l" ; 16dbe
	DB 0E0h, 01h, 00h ; 16dbf
	ASCII "t" ; 16dc2
	DB 0E0h, 02h, 00h ; 16dc3
	ASCII "l" ; 16dc6
	DB 0E0h, 01h, 00h ; 16dc7
	ASCII "t" ; 16dca
	DB 0E0h, 02h, 00h ; 16dcb
	ASCII "l" ; 16dce
	DB 0E0h, 01h, 00h ; 16dcf
	ASCII "t" ; 16dd2
	DB 0E0h, 02h, 00h ; 16dd3
	ASCII "l" ; 16dd6
	DB 0E0h, 01h, 00h ; 16dd7
	ASCII "t" ; 16dda
	DB 0E0h, 02h, 00h ; 16ddb
	ASCII "l" ; 16dde
	DB 0E0h, 01h, 00h ; 16ddf
	ASCII "t" ; 16de2
	DB 0E0h, 01h, 00h ; 16de3
	ASCII "l" ; 16de6
	DB 0E0h, 01h, 00h ; 16de7
	ASCII "t" ; 16dea
	DB 0E0h, 01h, 00h ; 16deb
	ASCII "l" ; 16dee
	DB 0E0h, 01h, 00h ; 16def
	ASCII "t" ; 16df2
	DB 0E0h, 01h, 00h ; 16df3
	ASCII "l" ; 16df6
	DB 0E0h, 01h, 00h ; 16df7
	ASCII "t" ; 16dfa
	DB 0E0h, 01h, 00h ; 16dfb
	ASCII "l" ; 16dfe
	DB 0E0h, 01h, 00h ; 16dff
	ASCII "t" ; 16e02
	DB 0E0h, 01h, 00h ; 16e03
	ASCII "l" ; 16e06
	DB 0E0h, 01h, 00h ; 16e07
	ASCII "t" ; 16e0a
	DB 0E0h, 01h, 00h ; 16e0b
	ASCII "l" ; 16e0e
	DB 0E0h, 01h, 00h ; 16e0f
	ASCII "t" ; 16e12
	DB 0E0h, 01h, 00h ; 16e13
	ASCII "l" ; 16e16
	DB 0E0h, 01h, 00h ; 16e17
	ASCII "t" ; 16e1a
	DB 0E0h, 01h, 00h ; 16e1b
	ASCII "l" ; 16e1e
	DB 0E0h, 01h, 00h ; 16e1f
	ASCII "t" ; 16e22
	DB 0E0h, 01h, 00h ; 16e23
	ASCII "l" ; 16e26
	DB 0E0h, 01h, 00h ; 16e27
	ASCII "t" ; 16e2a
	DB 0E0h, 01h, 00h ; 16e2b
	ASCII "l" ; 16e2e
	DB 0E0h, 01h, 00h ; 16e2f
	ASCII "t" ; 16e32
	DB 0E0h, 01h, 00h ; 16e33
	ASCII "l" ; 16e36
	DB 0E0h, 01h, 00h ; 16e37
	ASCII "t" ; 16e3a
	DB 0E0h, 01h, 00h ; 16e3b
	ASCII "l" ; 16e3e
	DB 0E0h, 01h, 00h ; 16e3f
	ASCII "t" ; 16e42
	DB 0E0h, 01h, 00h ; 16e43
	ASCII "l" ; 16e46
	DB 0E0h, 01h, 00h ; 16e47
	ASCII "t" ; 16e4a
	DB 0E0h, 01h, 00h ; 16e4b
	ASCII "l" ; 16e4e
	DB 0E0h, 01h, 00h ; 16e4f
	ASCII "t" ; 16e52
	DB 0E0h, 01h, 00h ; 16e53
	ASCII "l" ; 16e56
	DB 0E0h, 01h, 00h ; 16e57
	ASCII "t" ; 16e5a
	DB 0E0h, 01h, 00h ; 16e5b
	ASCII "l" ; 16e5e
	DB 0E0h, 01h, 00h ; 16e5f
	ASCII "t" ; 16e62
	DB 0E0h, 01h, 00h ; 16e63
	ASCII "l" ; 16e66
	DB 0E0h, 01h, 00h ; 16e67
	ASCII "t" ; 16e6a
	DB 0E0h, 01h, 00h ; 16e6b
	ASCII "l" ; 16e6e
	DB 0E0h ; 16e6f
	ASCII "O" ; 16e70
	DB 9Ah, 05h, 14h, 00h ; 16e71
	ASCII "t" ; 16e75
	DB 0E0h, 0Ah, 00h ; 16e76
	ASCII "x" ; 16e79
	DB 0E0h, 04h, 00h, 7Ch, 0E0h, 04h, 00h ; 16e7a
	ASCII "x" ; 16e81
	DB 0E0h, 04h, 00h, 7Ch, 0E0h, 0Ah, 00h ; 16e82
	ASCII "x" ; 16e89
	DB 0E0h, 0C1h, 99h, 81h ; 16e8a
	ASCII "p" ; 16e8e
	DB 0D6h, 99h, 28h, 00h, 18h, 00h, 06h, 00h ; 16e8f
	ASCII "l" ; 16e97
	DB 0E0h, 01h, 00h, 80h, 0E0h, 06h, 00h ; 16e98
	ASCII "l" ; 16e9f
	DB 0E0h, 01h, 00h, 80h, 0E0h, 05h, 00h ; 16ea0
	ASCII "l" ; 16ea7
	DB 0E0h, 01h, 00h, 80h, 0E0h, 05h, 00h ; 16ea8
	ASCII "l" ; 16eaf
	DB 0E0h, 01h, 00h, 80h, 0E0h, 04h, 00h ; 16eb0
	ASCII "l" ; 16eb7
	DB 0E0h, 01h, 00h, 80h, 0E0h, 02h, 00h ; 16eb8
	ASCII "l" ; 16ebf
	DB 0E0h, 01h, 00h, 80h, 0E0h, 02h, 00h ; 16ec0
	ASCII "l" ; 16ec7
	DB 0E0h, 01h, 00h, 80h, 0E0h, 02h, 00h ; 16ec8
	ASCII "l" ; 16ecf
	DB 0E0h, 01h, 00h, 80h, 0E0h, 02h, 00h ; 16ed0
	ASCII "l" ; 16ed7
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16ed8
	ASCII "l" ; 16edf
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16ee0
	ASCII "l" ; 16ee7
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16ee8
	ASCII "l" ; 16eef
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16ef0
	ASCII "l" ; 16ef7
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16ef8
	ASCII "l" ; 16eff
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f00
	ASCII "l" ; 16f07
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f08
	ASCII "l" ; 16f0f
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f10
	ASCII "l" ; 16f17
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f18
	ASCII "l" ; 16f1f
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f20
	ASCII "l" ; 16f27
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f28
	ASCII "l" ; 16f2f
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f30
	ASCII "l" ; 16f37
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f38
	ASCII "l" ; 16f3f
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f40
	ASCII "l" ; 16f47
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f48
	ASCII "l" ; 16f4f
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f50
	ASCII "l" ; 16f57
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f58
	ASCII "l" ; 16f5f
	DB 0E0h, 01h, 00h, 80h, 0E0h, 01h, 00h ; 16f60
	ASCII "l" ; 16f67
	DB 0E0h ; 16f68
	ASCII "O" ; 16f69
	DB 9Ah, 05h, 14h, 00h, 80h, 0E0h, 0Ah, 00h ; 16f6a
	DB 84h, 0E0h, 04h, 00h, 88h, 0E0h, 04h, 00h ; 16f72
	DB 84h, 0E0h, 04h, 00h, 88h, 0E0h, 0Ah, 00h ; 16f7a
	DB 84h, 0E0h, 0C1h, 99h, 81h ; 16f82
	ASCII "p" ; 16f87
	DB 0D6h, 99h, 28h, 00h, 18h, 00h, 06h, 00h ; 16f88
	ASCII "l" ; 16f90
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 06h, 00h ; 16f91
	ASCII "l" ; 16f98
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 05h, 00h ; 16f99
	ASCII "l" ; 16fa0
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 05h, 00h ; 16fa1
	ASCII "l" ; 16fa8
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 04h, 00h ; 16fa9
	ASCII "l" ; 16fb0
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 02h, 00h ; 16fb1
	ASCII "l" ; 16fb8
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 02h, 00h ; 16fb9
	ASCII "l" ; 16fc0
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 02h, 00h ; 16fc1
	ASCII "l" ; 16fc8
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 02h, 00h ; 16fc9
	ASCII "l" ; 16fd0
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 16fd1
	ASCII "l" ; 16fd8
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 16fd9
	ASCII "l" ; 16fe0
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 16fe1
	ASCII "l" ; 16fe8
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 16fe9
	ASCII "l" ; 16ff0
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 16ff1
	ASCII "l" ; 16ff8
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 16ff9
	ASCII "l" ; 17000
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17001
	ASCII "l" ; 17008
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17009
	ASCII "l" ; 17010
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17011
	ASCII "l" ; 17018
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17019
	ASCII "l" ; 17020
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17021
	ASCII "l" ; 17028
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17029
	ASCII "l" ; 17030
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17031
	ASCII "l" ; 17038
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17039
	ASCII "l" ; 17040
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17041
	ASCII "l" ; 17048
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17049
	ASCII "l" ; 17050
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17051
	ASCII "l" ; 17058
	DB 0E0h, 01h, 00h, 8Ch, 0E0h, 01h, 00h ; 17059
	ASCII "l" ; 17060
	DB 0E0h ; 17061
	ASCII "O" ; 17062
	DB 9Ah, 05h, 14h, 00h, 8Ch, 0E0h, 0Ah, 00h ; 17063
	DB 90h, 0E0h, 04h, 00h, 94h, 0E0h, 04h, 00h ; 1706b
	DB 90h, 0E0h, 04h, 00h, 94h, 0E0h, 0Ah, 00h ; 17073
	DB 90h, 0E0h, 0C1h, 99h, 81h ; 1707b
	ASCII "p" ; 17080
	DB 85h, 0F0h, 8Eh, 99h, 0A3h, 0C5h, 00h, 00h ; 17081
	DB 0C7h, 0B8h ; 17089
	ASCII "q" ; 1708b
	DB 0CEh, 0C4h, 02h, 0F2h, 0F3h, 0AAh, 0ABh, 0F8h ; 1708c
	DB 0A6h, 0A3h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 0B1h ; 17094
	DB 00h, 0C7h, 0ADh ; 1709c
	ASCII "p" ; 1709f
	DB 0CEh, 0C7h, 01h, 0CFh ; 170a0
	ASCII "B" ; 170a4
	DB 0CFh, 0D8h, 0F2h, 0A6h, 88h, 0ABh, 0AEh, 0F8h ; 170a5
	DB 96h ; 170ad
	ASCII "m" ; 170ae
	DB 8Fh ; 170af
	ASCII "n" ; 170b0
	DB 88h ; 170b1
	ASCII "o" ; 170b2
	DB 94h, 0F0h ; 170b3
	ASCII "q" ; 170b5
	DB 9Ah ; 170b6
	ASCII "v" ; 170b7
	DB 1Ah, 0D6h, 99h ; 170b8
	ASCIZ "d" ; 170bb
	DB 28h, 00h, 0BBh, 99h, 11h, 0F4h, 99h, 0FBh ; 170bd
	DB 00h, 01h, 00h, 98h, 0E0h, 0C4h, 99h, 0C2h ; 170c5
	ASCII "p" ; 170cd
	DB 0F4h, 99h, 02h, 00h, 02h, 00h, 98h, 0E0h ; 170ce
	DB 0F4h, 99h, 0FEh, 00h, 02h, 00h, 98h, 0E0h ; 170d6
	DB 0F4h, 99h, 01h, 00h, 02h, 00h, 98h, 0E0h ; 170de
	DB 0F4h, 99h, 0FFh, 00h, 02h, 00h, 98h, 0E0h ; 170e6
	DB 0C1h, 99h, 60h ; 170ee
	ASCII "q" ; 170f1
	DB 0D6h, 99h ; 170f2
	ASCIZ "d" ; 170f4
	DB 28h, 00h, 0BBh, 99h, 11h, 0F4h, 99h, 0FBh ; 170f6
	DB 00h, 01h, 00h, 0ACh, 0E0h, 0C4h, 99h, 0FBh ; 170fe
	ASCII "p" ; 17106
	DB 0F4h, 99h, 02h, 00h, 02h, 00h, 0ACh, 0E0h ; 17107
	DB 0F4h, 99h, 0FEh, 00h, 02h, 00h, 0ACh, 0E0h ; 1710f
	DB 0F4h, 99h, 01h, 00h, 02h, 00h, 0ACh, 0E0h ; 17117
	DB 0F4h, 99h, 0FFh, 00h, 02h, 00h, 0ACh, 0E0h ; 1711f
	DB 0C1h, 99h, 60h ; 17127
	ASCII "q" ; 1712a
	DB 0D6h, 99h ; 1712b
	ASCIZ "d" ; 1712d
	DB 28h, 00h, 0BBh, 99h, 11h, 0F4h, 99h, 0FBh ; 1712f
	DB 00h, 01h, 00h, 0C0h, 0E0h, 0C4h, 99h ; 17137
	ASCII "4q" ; 1713e
	DB 0F4h, 99h, 02h, 00h, 02h, 00h, 0C0h, 0E0h ; 17140
	DB 0F4h, 99h, 0FEh, 00h, 02h, 00h, 0C0h, 0E0h ; 17148
	DB 0F4h, 99h, 01h, 00h, 02h, 00h, 0C0h, 0E0h ; 17150
	DB 0F4h, 99h, 0FFh, 00h, 02h, 00h, 0C0h, 0E0h ; 17158
	ASCII "O" ; 17160
	DB 9Ah, 05h, 97h, 99h, 24h ; 17161
	ASCII "j" ; 17166
	DB 0F1h, 8Eh, 99h, 0A3h, 0F2h ; 17167
	ASCII "g1" ; 1716c
	DB 0F2h, 1Fh ; 1716e
	ASCII "1" ; 17170
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 17171
	DB 08h, 0CEh, 0D4h, 0FAh, 14h, 0ABh ; 17179
	ASCII "8" ; 1717f
	DB 0CEh, 0D4h, 0D6h, 1Ah, 0CEh, 0D4h, 0E8h, 1Ah ; 17180
	DB 0CEh, 0D4h, 0E9h, 1Ah, 0B0h, 28h, 0CEh, 0D4h ; 17188
	DB 0DAh, 1Ah, 0CEh, 0C4h, 03h, 0F2h, 0B7h, 9Dh ; 17190
	DB 0F8h, 0A6h, 0A3h, 0CEh, 0D0h, 0D7h, 1Ah, 00h ; 17198
	DB 0B1h, 00h, 0C7h, 0B2h ; 171a0
	ASCII "q" ; 171a4
	DB 0CEh, 0C7h, 01h, 0CFh ; 171a5
	ASCII "B" ; 171a9
	DB 0CFh, 0D8h, 0F2h, 0A1h, 87h, 0ABh, 0AEh, 0F8h ; 171aa
	DB 0B9h ; 171b2
	ASCII "p" ; 171b3
	DB 0F2h ; 171b4
	ASCII "p+q" ; 171b5
	DB 99h, 0F1h ; 171b8
	ASCII "q" ; 171ba
	DB 9Ah ; 171bb
	ASCII "v" ; 171bc
	DB 1Ah, 01h, 00h, 0DCh, 0E0h, 8Eh, 99h, 0CEh ; 171bd
	DB 0D0h ; 171c5
	ASCII "E" ; 171c6
	DB 16h, 96h, 20h, 0E7h, 14h, 96h, 40h, 0E7h ; 171c7
	DB 03h, 0F1h, 29h, 0CEh, 0D0h, 0D4h, 1Ah ; 171cf
	ASCII "2" ; 171d6
	DB 11h, 0E4h, 03h, 0B0h, 0FFh, 80h, 0F1h, 0Bh ; 171d7
	DB 0CEh, 0D0h, 0D4h, 1Ah, 28h, 0E7h, 03h, 0B0h ; 171df
	DB 12h, 88h, 0CEh, 0D4h, 0D4h, 1Ah, 0CEh, 0D0h ; 171e7
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 04h, 0CEh ; 171ef
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 0D4h, 1Ah ; 171f7
	ASCII "2" ; 171fe
	DB 10h, 0E4h, 0Bh, 12h, 10h, 0F2h, 0D2h ; 171ff
	ASCII "1" ; 17206
	DB 0C5h, 0D3h, 1Ah, 0F1h, 15h ; 17207
	ASCII "2" ; 1720c
	DB 08h, 0E4h, 0Bh, 12h, 08h, 0F2h, 0C4h ; 1720d
	ASCII "1" ; 17214
	DB 0C5h, 0D2h, 1Ah, 0F1h, 07h, 0F2h, 0BCh ; 17215
	ASCII "1" ; 1721c
	DB 0C5h, 0D1h, 1Ah, 23h, 0E7h, 20h, 0C4h ; 1721d
	ASCII "r" ; 17224
	DB 1Ah, 0F2h, 27h, 87h, 0C4h, 00h, 8Bh, 0BCh ; 17225
	DB 2Ch, 16h, 0B0h, 06h, 0CEh, 0D4h, 2Eh, 16h ; 1722d
	DB 0C4h, 00h, 8Dh, 0BCh, 2Fh, 16h, 0B0h, 06h ; 17235
	DB 0CEh, 0D4h ; 1723d
	ASCII "1" ; 1723f
	DB 16h, 0F8h, 0C4h, 0BEh ; 17240
	ASCII "q" ; 17244
	DB 0F2h, 08h, 87h, 0CEh, 0D0h, 0D4h, 1Ah ; 17245
	ASCII "P" ; 1724c
	DB 0B3h, 00h, 0B0h, 06h, 0CEh, 0D9h, 0A6h, 0A3h ; 1724d
	DB 0CFh, 0B3h ; 17255
	ASCIZ "BJ" ; 17257
	DB 01h, 00h, 0B1h, 00h, 0C7h, 0D6h ; 1725a
	ASCII "r" ; 17260
	DB 0CEh, 0C7h, 01h, 0CFh ; 17261
	ASCII "B" ; 17265
	DB 0CFh, 0D8h, 0BCh ; 17266
	ASCII "4" ; 17269
	DB 16h, 0CEh ; 1726a
	ASCII "A" ; 1726c
	DB 02h, 0CEh, 0D4h ; 1726d
	ASCII "6" ; 17270
	DB 16h, 0CEh ; 17271
	ASCII "A" ; 17273
	DB 03h, 0CEh ; 17274
	ASCII "I" ; 17276
	DB 04h, 0BCh ; 17277
	ASCII "7" ; 17279
	DB 16h, 0CEh ; 1727a
	ASCII "A" ; 1727c
	DB 05h, 0CEh, 0D4h ; 1727d
	ASCII "9" ; 17280
	DB 16h, 0CFh, 0B7h ; 17281
	ASCIZ "CK" ; 17284
	DB 01h, 00h, 0B1h, 00h, 0C7h, 0B2h ; 17287
	ASCII "r" ; 1728d
	DB 0CEh, 0C7h, 01h, 0CFh ; 1728e
	ASCII "B" ; 17292
	DB 0CFh, 0D8h, 0BCh, 2Ch, 16h, 0CEh ; 17293
	ASCII "A" ; 17299
	DB 02h, 0CEh, 0D4h, 2Eh, 16h, 0CEh ; 1729a
	ASCII "A" ; 172a0
	DB 03h, 0CEh ; 172a1
	ASCII "I" ; 172a3
	DB 04h, 0BCh, 2Fh, 16h, 0CEh ; 172a4
	ASCII "A" ; 172a9
	DB 05h, 0CEh, 0D4h ; 172aa
	ASCII "1" ; 172ad
	DB 16h, 0ABh, 0AEh, 0F8h, 00h ; 172ae
	ASCII "s" ; 172b3
	DB 06h, 00h ; 172b4
	ASCII "u" ; 172b6
	DB 06h, 00h ; 172b7
	ASCII "w" ; 172b9
	DB 06h, 00h ; 172ba
	ASCII "y" ; 172bc
	DB 06h, 00h, 7Bh, 06h, 00h, 7Dh, 06h, 00h ; 172bd
	DB 7Fh, 06h, 00h, 81h, 06h, 00h, 83h, 06h ; 172c5
	DB 00h, 85h, 06h, 00h, 87h, 06h, 00h, 89h ; 172cd
	DB 06h, 00h, 08h, 06h, 00h, 0Ch, 06h, 00h ; 172d5
	DB 10h, 06h, 00h, 14h, 06h, 00h, 18h, 06h ; 172dd
	DB 00h, 1Ch, 06h ; 172e5
	ASCII "q" ; 172e8
	DB 9Ah, 0C4h, 0F1h, 0BEh ; 172e9
	ASCII "qq" ; 172ed
	DB 9Ah ; 172ef
	ASCII "q" ; 172f0
	DB 9Ah, 0BEh ; 172f1
	ASCII "q" ; 172f3
	DB 0D6h, 99h, 00h, 00h, 00h, 00h, 01h, 00h ; 172f4
	DB 0F4h, 0E0h, 0C1h, 99h, 0FAh ; 172fc
	ASCII "rq" ; 17301
	DB 9Ah ; 17303
	ASCII "q" ; 17304
	DB 9Ah, 0F4h ; 17305
	ASCII "r" ; 17307
	DB 08h, 00h, 0D4h, 0E0h, 0F4h, 99h, 01h, 00h ; 17308
	DB 08h, 00h, 0D4h, 0E0h, 0F4h, 99h, 0FFh, 00h ; 17310
	DB 0C1h, 99h, 08h ; 17318
	ASCII "sq" ; 1731b
	DB 9Ah ; 1731d
	ASCII "q" ; 1731e
	DB 9Ah, 08h ; 1731f
	ASCII "s" ; 17321
	DB 08h, 00h, 0D8h, 0E0h, 0F4h, 99h, 0FFh, 00h ; 17322
	DB 08h, 00h, 0D8h, 0E0h, 0F4h, 99h, 01h, 00h ; 1732a
	DB 0C1h, 99h, 22h ; 17332
	ASCII "sq" ; 17335
	DB 9Ah ; 17337
	ASCII "q" ; 17338
	DB 9Ah, 22h ; 17339
	ASCII "s" ; 1733b
	DB 01h, 00h, 00h, 0E1h, 8Eh, 99h ; 1733c
	ASCII "q" ; 17342
	DB 9Ah ; 17343
	ASCII "q" ; 17344
	DB 9Ah, 3Ch ; 17345
	ASCII "s{" ; 17347
	DB 0A7h, 88h ; 17349
	ASCII "s" ; 1734b
	DB 04h ; 1734c
	ASCII "t" ; 1734d
	DB 80h ; 1734e
	ASCII "t" ; 1734f
	DB 1Eh, 00h ; 17350
	ASCII "m" ; 17352
	DB 1Ah, 7Bh, 0A7h, 0A6h ; 17353
	ASCII "s", 22h, "t" ; 17357
	DB 9Eh ; 1735a
	ASCII "t{" ; 1735b
	DB 0A7h, 0C4h ; 1735d
	ASCII "s@t" ; 1735f
	DB 0BCh ; 17362
	ASCII "t" ; 17363
	DB 1Eh, 00h ; 17364
	ASCII "m" ; 17366
	DB 1Ah, 7Bh, 0A7h, 0E2h ; 17367
	ASCII "s^t" ; 1736b
	DB 0DAh ; 1736e
	ASCII "t8" ; 1736f
	DB 0CEh, 0D4h ; 17371
	ASCII "q" ; 17373
	DB 16h, 0F8h, 0CEh, 0D0h ; 17374
	ASCII "q" ; 17378
	DB 16h ; 17379
	ASCII "2" ; 1737a
	DB 1Dh, 0E5h, 0Ah, 0B0h, 01h, 0CEh ; 1737b
	ASCII "D" ; 17381
	DB 06h, 0C3h, 0FEh, 0FFh, 0FAh, 0F8h, 9Dh, 99h ; 17382
	ASCII "q" ; 1738a
	DB 9Ah, 0D6h, 99h, 21h, 00h, 10h, 00h, 03h ; 1738b
	DB 00h, 0FCh, 0B9h, 04h, 00h, 00h, 0BAh, 04h ; 17393
	DB 00h, 20h, 0BAh, 01h, 00h ; 1739b
	ASCII "m" ; 173a0
	DB 1Ah ; 173a1
	ASCII "p" ; 173a2
	DB 0F3h ; 173a3
	ASCII "v" ; 173a4
	DB 0F3h, 9Dh, 99h ; 173a5
	ASCII "q" ; 173a8
	DB 9Ah, 0D6h, 99h, 21h, 00h, 10h, 00h, 14h ; 173a9
	DB 00h, 0F8h, 0B9h, 9Dh, 99h, 0FCh, 0F4h, 0D6h ; 173b1
	DB 99h, 21h, 00h, 10h, 00h, 01h, 00h, 0FCh ; 173b9
	DB 0B9h, 8Eh, 99h, 9Dh, 99h ; 173c1
	ASCII "q" ; 173c6
	DB 9Ah, 0D6h, 99h, 21h, 00h, 10h, 00h, 03h ; 173c7
	DB 00h, 08h, 0BAh, 04h, 00h, 0Ch, 0BAh, 04h ; 173cf
	DB 00h, 24h, 0BAh, 01h, 00h ; 173d7
	ASCII "m" ; 173dc
	DB 1Ah ; 173dd
	ASCII "p" ; 173de
	DB 0F3h ; 173df
	ASCII "v" ; 173e0
	DB 0F3h, 9Dh, 99h ; 173e1
	ASCII "q" ; 173e4
	DB 9Ah, 0D6h, 99h, 21h, 00h, 10h, 00h, 14h ; 173e5
	DB 00h, 04h, 0BAh, 14h, 00h, 08h, 0BAh, 9Dh ; 173ed
	DB 99h, 10h, 0F5h, 0D6h, 99h, 21h, 00h, 10h ; 173f5
	DB 00h, 01h, 00h, 08h, 0BAh, 8Eh, 99h, 9Dh ; 173fd
	DB 99h ; 17405
	ASCII "q" ; 17406
	DB 9Ah, 0D6h, 99h, 1Bh, 00h, 10h, 00h, 03h ; 17407
	DB 00h, 90h, 0BDh, 04h, 00h, 94h, 0BDh, 04h ; 1740f
	DB 00h, 0B4h, 0BDh, 01h, 00h ; 17417
	ASCII "m" ; 1741c
	DB 1Ah ; 1741d
	ASCII "p" ; 1741e
	DB 0F3h ; 1741f
	ASCII "v" ; 17420
	DB 0F3h, 9Dh, 99h ; 17421
	ASCII "q" ; 17424
	DB 9Ah, 0D6h, 99h, 1Bh, 00h, 10h, 00h, 14h ; 17425
	DB 00h, 8Ch, 0BDh, 9Dh, 99h, 0FCh, 0F4h, 0D6h ; 1742d
	DB 99h, 1Bh, 00h, 10h, 00h, 01h, 00h, 90h ; 17435
	DB 0BDh, 8Eh, 99h, 9Dh, 99h ; 1743d
	ASCII "q" ; 17442
	DB 9Ah, 0D6h, 99h, 1Bh, 00h, 10h, 00h, 03h ; 17443
	DB 00h, 9Ch, 0BDh, 04h, 00h, 0A0h, 0BDh, 04h ; 1744b
	DB 00h, 0B8h, 0BDh, 01h, 00h ; 17453
	ASCII "m" ; 17458
	DB 1Ah ; 17459
	ASCII "p" ; 1745a
	DB 0F3h ; 1745b
	ASCII "v" ; 1745c
	DB 0F3h, 9Dh, 99h ; 1745d
	ASCII "q" ; 17460
	DB 9Ah, 0D6h, 99h, 1Bh, 00h, 10h, 00h, 14h ; 17461
	DB 00h, 98h, 0BDh, 14h, 00h, 9Ch, 0BDh, 9Dh ; 17469
	DB 99h, 10h, 0F5h, 0D6h, 99h, 1Bh, 00h, 10h ; 17471
	DB 00h, 01h, 00h, 9Ch, 0BDh, 8Eh, 99h, 9Dh ; 17479
	DB 99h ; 17481
	ASCII "q" ; 17482
	DB 9Ah, 0D6h, 99h, 1Fh, 00h, 10h, 00h, 03h ; 17483
	DB 00h, 0A0h, 0C0h, 04h, 00h, 0A4h, 0C0h, 04h ; 1748b
	DB 00h, 0C4h, 0C0h, 01h, 00h ; 17493
	ASCII "m" ; 17498
	DB 1Ah ; 17499
	ASCII "p" ; 1749a
	DB 0F3h ; 1749b
	ASCII "v" ; 1749c
	DB 0F3h, 9Dh, 99h ; 1749d
	ASCII "q" ; 174a0
	DB 9Ah, 0D6h, 99h, 1Fh, 00h, 10h, 00h, 14h ; 174a1
	DB 00h, 9Ch, 0C0h, 9Dh, 99h, 0FCh, 0F4h, 0D6h ; 174a9
	DB 99h, 1Fh, 00h, 10h, 00h, 01h, 00h, 0A0h ; 174b1
	DB 0C0h, 8Eh, 99h, 9Dh, 99h ; 174b9
	ASCII "q" ; 174be
	DB 9Ah, 0D6h, 99h, 1Fh, 00h, 10h, 00h, 03h ; 174bf
	DB 00h, 0ACh, 0C0h, 04h, 00h, 0B0h, 0C0h, 04h ; 174c7
	DB 00h, 0C8h, 0C0h, 01h, 00h ; 174cf
	ASCII "m" ; 174d4
	DB 1Ah ; 174d5
	ASCII "p" ; 174d6
	DB 0F3h ; 174d7
	ASCII "v" ; 174d8
	DB 0F3h, 9Dh, 99h ; 174d9
	ASCII "q" ; 174dc
	DB 9Ah, 0D6h, 99h, 1Fh, 00h, 10h, 00h, 14h ; 174dd
	DB 00h, 0A8h, 0C0h, 14h, 00h, 0ACh, 0C0h, 9Dh ; 174e5
	DB 99h, 10h, 0F5h, 0D6h, 99h, 1Fh, 00h, 10h ; 174ed
	DB 00h, 01h, 00h, 0ACh, 0C0h, 8Eh, 99h, 0CEh ; 174f5
	DB 0D0h ; 174fd
	ASCII "B" ; 174fe
	DB 16h, 96h, 01h, 0E6h, 0Ch, 0F2h, 2Ah, 00h ; 174ff
	DB 0E6h, 07h, 0C4h ; 17507
	ASCII "Hs" ; 1750a
	DB 0F2h ; 1750c
	ASCII "A" ; 1750d
	DB 84h, 0F8h, 0CEh, 0D0h ; 1750e
	ASCII "B" ; 17512
	DB 16h, 96h, 01h, 0E6h, 0Ch, 0F2h ; 17513
	ASCIZ "l" ; 17519
	DB 0E6h, 07h, 0C4h, 5Ch ; 1751b
	ASCII "s" ; 1751f
	DB 0F2h, 2Dh, 84h, 0F8h ; 17520
	ASCII "q" ; 17524
	DB 9Ah ; 17525
	ASCII "q" ; 17526
	DB 9Ah ; 17527
	ASCII "Psq" ; 17528
	DB 9Ah ; 1752b
	ASCII "q" ; 1752c
	DB 9Ah ; 1752d
	ASCII "ds" ; 1752e
	DB 0A6h, 0A3h, 0CEh, 40h, 14h, 0CEh ; 17530
	ASCII "H" ; 17536
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 17537
	DB 0A2h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 0B1h ; 1753f
	DB 00h, 0C6h ; 17547
	ASCII "zu" ; 17549
	DB 0CFh, 40h, 0CEh, 0C6h, 01h ; 1754b
	ASCII "G" ; 17550
	DB 06h, 0CEh, 0D1h, 10h, 1Bh ; 17551
	ASCII "1" ; 17556
	DB 0E5h, 1Ch, 92h ; 17557
	ASCII "G" ; 1755a
	DB 06h ; 1755b
	ASCII "1" ; 1755c
	DB 0E4h, 16h, 93h, 92h ; 1755d
	ASCII "G" ; 17561
	DB 06h, 0CEh, 0D1h, 11h, 1Bh ; 17562
	ASCII "1" ; 17567
	DB 0E5h, 0Bh, 92h ; 17568
	ASCII "G" ; 1756b
	DB 06h ; 1756c
	ASCII "1" ; 1756d
	DB 0E4h, 05h, 9Ch, 0FEh, 0F1h, 03h, 9Dh, 01h ; 1756e
	DB 0AAh, 0ABh, 0AEh, 0F8h, 22h, 27h, 0Eh, 17h ; 17576
	DB 1Ah, 1Fh, 11h, 1Ah, 26h, 2Bh, 0Fh, 18h ; 1757e
	DB 0A6h, 0A3h, 0CEh, 40h, 14h, 0CEh ; 17586
	ASCII "H" ; 1758c
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh ; 1758d
	DB 0A2h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 0B1h ; 17595
	DB 00h, 0C6h, 0D0h ; 1759d
	ASCII "u" ; 175a0
	DB 0CFh, 40h, 0CEh, 0C6h, 01h ; 175a1
	ASCII "G" ; 175a6
	DB 06h, 0CEh, 0D1h, 10h, 1Bh ; 175a7
	ASCII "1" ; 175ac
	DB 0E5h, 1Ch, 92h ; 175ad
	ASCII "G" ; 175b0
	DB 06h ; 175b1
	ASCII "1" ; 175b2
	DB 0E4h, 16h, 93h, 92h ; 175b3
	ASCII "G" ; 175b7
	DB 06h, 0CEh, 0D1h, 11h, 1Bh ; 175b8
	ASCII "1" ; 175bd
	DB 0E5h, 0Bh, 92h ; 175be
	ASCII "G" ; 175c1
	DB 06h ; 175c2
	ASCII "1" ; 175c3
	DB 0E4h, 05h, 9Ch, 0FEh, 0F1h, 03h, 9Dh, 01h ; 175c4
	DB 0AAh, 0ABh, 0AEh, 0F8h, 25h, 2Ah, 0Eh, 17h ; 175cc
	DB 21h, 26h, 11h, 1Ah, 22h, 27h, 0Fh, 18h ; 175d4
	DB 08h, 00h, 28h, 0CAh, 8Eh, 99h, 08h, 00h ; 175dc
	DB 2Ch, 0CAh, 8Eh, 99h, 08h, 00h ; 175e4
	ASCII "0" ; 175ea
	DB 0CAh, 8Eh, 99h, 08h, 00h ; 175eb
	ASCII "4" ; 175f0
	DB 0CAh, 8Eh, 99h, 08h, 00h ; 175f1
	ASCII "8" ; 175f6
	DB 0CAh, 8Eh, 99h, 08h, 00h, 3Ch, 0CAh, 8Eh ; 175f7
	DB 99h, 08h, 00h, 40h, 0CAh, 8Eh, 99h, 08h ; 175ff
	DB 00h ; 17607
	ASCII "D" ; 17608
	DB 0CAh, 8Eh, 99h, 0CEh, 0D0h ; 17609
	ASCII "E" ; 1760e
	DB 16h, 96h, 20h, 0E7h, 11h, 96h, 40h, 0E6h ; 1760f
	DB 29h, 0CEh, 0D0h, 0D5h, 1Ah, 80h ; 17617
	ASCII "2" ; 1761d
	DB 08h, 0E4h, 0Fh ; 1761e
	ASCII "8" ; 17621
	DB 0F1h, 0Ch, 0CEh, 0D0h, 0D5h, 1Ah, 88h ; 17622
	ASCII "2" ; 17629
	DB 0FFh, 0E7h, 03h, 0B0h, 07h, 0CEh, 0D4h, 0D5h ; 1762a
	DB 1Ah, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 17632
	DB 0B0h, 04h, 0CEh, 0D4h, 0FAh, 14h, 0CEh, 0D0h ; 1763a
	DB 0D5h, 1Ah, 0F2h, 15h, 00h, 0CEh ; 17642
	ASCII "P" ; 17648
	DB 18h, 0CEh ; 17649
	ASCII "X" ; 1764b
	DB 19h, 0CFh, 19h, 0E6h, 0Ah, 0CEh ; 1764c
	ASCII "D" ; 17652
	DB 18h, 0CEh ; 17653
	ASCII "L" ; 17655
	DB 19h, 0F2h, 0F6h, 82h, 0F8h ; 17656
	ASCII "2" ; 1765b
	DB 07h, 0E4h, 03h, 0B0h, 07h, 0A6h, 0A3h, 0C7h ; 1765c
	ASCII "sv" ; 17664
	DB 0CEh, 0C7h, 01h, 00h, 0B1h, 00h, 0CFh ; 17666
	ASCII "B" ; 1766d
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0F8h, 0DCh ; 1766e
	ASCII "u" ; 17674
	DB 0E2h ; 17675
	ASCII "u" ; 17676
	DB 0E8h ; 17677
	ASCII "u" ; 17678
	DB 0EEh ; 17679
	ASCII "u" ; 1767a
	DB 0F4h ; 1767b
	ASCII "u" ; 1767c
	DB 0FAh ; 1767d
	ASCIZ "u" ; 1767e
	ASCII "v" ; 17680
	DB 06h ; 17681
	ASCII "vq" ; 17682
	DB 9Ah, 0Ch, 0F6h ; 17684
	ASCII "v" ; 17687
	DB 1Ah, 0CEh, 0D0h, 0D5h, 1Ah, 80h ; 17688
	ASCII "2" ; 1768e
	DB 08h, 0E4h, 02h ; 1768f
	ASCII "8" ; 17692
	DB 0F2h, 0C6h, 0FFh, 0F2h, 0B7h, 82h, 0F8h ; 17693
	ASCII "q" ; 1769a
	DB 9Ah, 89h, 0F6h ; 1769b
	ASCII "v" ; 1769e
	DB 1Ah, 0CEh, 0D0h, 0D5h, 1Ah, 88h ; 1769f
	ASCII "2" ; 176a5
	DB 0FFh, 0E7h, 03h, 0B0h, 07h, 0F2h, 0AEh, 0FFh ; 176a6
	DB 0F2h, 9Fh, 82h, 0F8h ; 176ae
	ASCII "q" ; 176b2
	DB 9Ah, 0A0h, 0F6h ; 176b3
	ASCII "v" ; 176b6
	DB 1Ah, 0C5h ; 176b7
	ASCII "C" ; 176b9
	DB 16h, 95h, 01h, 0EBh, 02h, 00h, 0F8h, 0C4h ; 176ba
	ASCII "v" ; 176c2
	DB 1Ah, 0F2h, 95h, 82h, 0F2h, 0Bh, 2Ch, 0F2h ; 176c3
	DB 0C3h, 2Bh, 0F8h, 97h, 99h, 24h, 9Dh, 99h ; 176cb
	DB 0B8h, 0F6h, 97h, 99h, 12h, 0DCh, 0F6h, 8Eh ; 176d3
	DB 99h, 0A6h, 0A3h, 0F2h, 0F4h, 2Bh, 0F2h, 0ACh ; 176db
	DB 2Bh, 0ABh, 0AEh, 0F8h ; 176e3
	ASCII "q" ; 176e7
	DB 9Ah ; 176e8
	ASCII "q" ; 176e9
	DB 9Ah, 0CEh ; 176ea
	ASCII "v" ; 176ec
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 176ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 176f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 176fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17705
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1770d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17715
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1771d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17725
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1772d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17735
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1773d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17745
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1774d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17755
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1775d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17765
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1776d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17775
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1777d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17785
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1778d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17795
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1779d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 177fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17805
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1780d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17815
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1781d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17825
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1782d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17835
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1783d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17845
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1784d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17855
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1785d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17865
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1786d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17875
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1787d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17885
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1788d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17895
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1789d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 178fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17905
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1790d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17915
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1791d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17925
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1792d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17935
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1793d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17945
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1794d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17955
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1795d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17965
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1796d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17975
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1797d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17985
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1798d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17995
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1799d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179a5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179ad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179b5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179bd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179c5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179cd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179d5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179dd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179e5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179ed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179f5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 179fd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17a9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17aa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17aad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ab5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17abd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ac5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17acd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ad5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17add
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ae5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17aed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17af5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17afd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17b9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ba5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17be5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17bfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17c9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ca5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ccd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ce5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ced
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cf5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17cfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17d9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17da5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17dad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17db5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17dbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17dc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17dcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17dd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ddd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17de5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ded
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17df5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17dfd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17e9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ea5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ead
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17eb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ebd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ec5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ecd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ed5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17edd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ee5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17eed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ef5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17efd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f05
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f0d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f15
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f1d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f25
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f2d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f35
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f3d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f45
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f4d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f55
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f5d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f65
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f6d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f75
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f7d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f85
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f8d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f95
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17f9d
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fa5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fad
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fb5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fbd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fc5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fcd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fd5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fdd
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fe5
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17fed
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 17ff5
	DB 0FFh, 0FFh, 0FFh
; ---------------------- ; 17ffd
DEFSECT ".rom3", CODE AT 018000H
SECT ".rom3"
; ---------------------- ; 17fff
loc_0x018000:

	LD EP, #00h

	LD A, #00h
	LD [1503h], A

	LD A,#00h
	LD [1504h], A

	LD A, #00h
	LD [1505h], A

	LD A, #00h
	LD [1506h], A

	RET

; ---------------------- ; 1801b
loc_0x01801C:
	LD A,#0FFh ; 1801c
	LD [168Ch],A ; 1801e
	LD A,#02h ; 18022
	LD [166Bh],A ; 18024
	LD A,#07h ; 18028
	LD [166Ch],A ; 1802a
	LD BA,#0000h ; 1802e
	LD [1AB1h],BA ; 18031
	RET
; ---------------------- ; 18034
loc_0x018035:

	XOR A,A ; 18035
	LD [1AB5h],A ; 18036

	LD A,#01h ; 1803a
	LD [1AB6h],A ; 1803c

	LD A,#02h ; 18040
	LD [1AB7h],A ; 18042

	LD A,#01h ; 18046
	LD [1AB8h],A ; 18048

	XOR A,A ; 1804c
	LD [1ABCh],A ; 1804d
	LD [1AC2h],A ; 18051

	LD A,#0F4h ; 18055
	LD [1ABDh],A ; 18057
	LD [1ABEh],A ; 1805b
	LD [1ABFh],A ; 1805f
	LD [1AC0h],A ; 18063
	LD [1AC1h],A ; 18067

	XOR A,A ; 1806b
	LD [1AB9h],A ; 1806c
	LD [1ABAh],A ; 18070
	LD [1ABBh],A ; 18074

	CARL loc_0x018CAF ; 18078
	CARL loc_0x0026B7 ; 1807b
	CARL loc_0x0026C6 ; 1807e

	RET

; ---------------------- ; 18081
	DB 0F8h, 07h, 04h, 0Eh, 00h ; 18082
	ASCII "A" ; 18087
	DB 02h, 00h ; 18088
	ASCII "A" ; 1808a
	DB 02h, 00h, 00h, 02h, 00h, 00h, 02h ; 1808b
	ASCIZ "m/" ; 18092
	DB 81h, 81h, 03h, 15h, 9Eh, 03h, 00h, 00h ; 18095
	DB 00h, 18h, 08h, 03h, 1Ah, 26h, 00h ; 1809d
	ASCII "CQ" ; 180a4
	DB 02h, 0Ch, 10h, 0Dh, 04h, 0Eh, 00h ; 180a6
	ASCII "A" ; 180ad
	DB 02h, 00h ; 180ae
	ASCII "A" ; 180b0
	DB 02h, 00h, 00h, 02h, 00h, 00h, 02h ; 180b1
	ASCIZ "m/" ; 180b8
	DB 7Eh, 81h, 03h ; 180bb
	ASCII "M" ; 180be
	DB 91h, 03h, 00h, 00h, 00h, 18h, 08h, 03h ; 180bf
	DB 1Ah, 26h, 00h ; 180c7
	ASCII "CQ" ; 180ca
	DB 02h, 0Ch, 10h, 0F2h, 23h, 0A1h, 0F2h ; 180cc
	ASCII "d" ; 180d3
	DB 0A2h, 0CEh, 0C4h, 02h, 0F2h, 02h, 1Ah, 0CEh ; 180d4
	DB 0C4h, 00h, 0F2h, 19h, 0ABh, 0CEh, 0C4h, 07h ; 180dc
	DB 0F2h, 0Eh, 02h, 0CEh, 0C4h, 00h, 0F2h, 91h ; 180e4
	DB 0A7h, 0F1h, 19h, 0F2h, 03h, 0A1h, 0F2h ; 180ec
	ASCII "D" ; 180f3
	DB 0A2h, 0CEh, 0C4h, 02h, 0F2h, 0E2h, 19h, 0CEh ; 180f4
	DB 0C4h, 00h, 0F2h, 0F9h, 0AAh, 0CEh, 0C4h, 07h ; 180fc
	DB 0F2h, 0EEh, 01h, 0C7h, 83h, 80h, 0CEh, 0C7h ; 18104
	DB 01h, 0CEh, 0D0h ; 1810c
	ASCII "6" ; 1810f
	DB 1Bh, 28h, 0E6h, 04h, 0C7h, 0A9h, 80h, 0F2h ; 18110
	ASCII "Y" ; 18118
	DB 0ACh, 0C5h, 00h, 00h, 0C7h, 0E3h, 04h, 0CEh ; 18119
	DB 0C4h, 02h, 0F2h, 5Fh, 1Ah, 0C5h, 00h, 00h ; 18121
	DB 0C7h ; 18129
	ASCII "G" ; 1812a
	DB 05h, 0CEh, 0C4h, 02h, 0F2h ; 1812b
	ASCII "S" ; 18130
	DB 1Ah, 0C5h, 00h, 00h, 0C7h, 7Bh, 02h, 0CEh ; 18131
	DB 0C4h, 02h, 0F2h ; 18139
	ASCII "G" ; 1813c
	DB 1Ah, 0C5h, 00h, 00h, 0C7h, 0Ah, 03h, 0CEh ; 1813d
	DB 0C4h, 02h, 0F2h, 3Bh, 1Ah, 0C5h, 00h, 00h ; 18145
	DB 0C7h, 85h, 03h, 0CEh, 0C4h, 02h, 0F2h, 2Fh ; 1814d
	DB 1Ah, 0C5h, 00h, 00h, 0C7h, 0ECh, 03h, 0CEh ; 18155
	DB 0C4h, 02h, 0F2h, 23h, 1Ah, 0C7h, 0AEh, 13h ; 1815d
	DB 0CEh, 0C4h, 02h, 0F2h, 1Ah, 1Ah, 0F2h, 0D2h ; 18165
	DB 0A1h, 0F2h, 8Bh, 0A0h, 0D9h, 24h, 20h, 0D9h ; 1816d
	DB 40h, 02h, 0B0h, 01h, 0CEh, 0D4h, 3Ah, 16h ; 18175
	DB 0F8h, 0F2h ; 1817d
	ASCII "q" ; 1817f
	DB 08h, 0F2h, 0C3h, 0A1h, 0C5h ; 18180
	ASCII "C" ; 18185
	DB 16h, 95h, 02h, 0E7h, 09h, 0C5h ; 18186
	ASCII "C" ; 1818c
	DB 16h, 95h, 01h, 0E7h, 26h, 0F8h, 0CEh, 0D0h ; 1818d
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh ; 18195
	DB 0D4h, 0FAh, 14h, 0C4h, 0D6h, 1Ah, 0D0h, 0B5h ; 1819d
	DB 1Ah, 0F2h, 17h, 0A7h, 0CEh, 0D0h, 0Fh, 1Bh ; 181a5
	DB 0F2h, 0DEh, 0A4h, 0F2h, 3Ch, 0A1h, 0F2h, 0DAh ; 181ad
	DB 0A0h, 0F8h, 0CEh, 0D0h, 0BBh, 1Ah ; 181b5
	ASCII "2" ; 181bb
	DB 04h, 0E6h, 0Eh ; 181bc
	ASCII "2" ; 181bf
	DB 05h, 0E6h ; 181c0
	ASCII "02" ; 181c2
	DB 06h, 0E6h ; 181c4
	ASCII "R2" ; 181c6
	DB 07h, 0E6h ; 181c8
	ASCII "t" ; 181ca
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 181cb
	DB 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C4h, 0D6h ; 181d3
	DB 1Ah, 0D0h, 0B5h, 1Ah, 0F2h, 0DEh, 0A6h, 0CEh ; 181db
	DB 0D0h, 0Fh, 1Bh, 0F2h, 0A5h, 0A4h, 0C5h, 0B1h ; 181e3
	DB 0E6h, 0B1h, 03h, 0F2h, 9Fh, 0A0h, 0F8h, 0CEh ; 181eb
	DB 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h ; 181f3
	DB 0CEh, 0D4h, 0FAh, 14h, 0C4h, 0D6h, 1Ah, 0D0h ; 181fb
	DB 0B5h, 1Ah, 0F2h, 0B8h, 0A6h, 0CEh, 0D0h, 0Fh ; 18203
	DB 1Bh, 0F2h, 7Fh, 0A4h, 0C5h, 8Ah, 82h, 0B1h ; 1820b
	DB 03h, 0F2h ; 18213
	ASCII "y" ; 18215
	DB 0A0h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 18216
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C4h ; 1821e
	DB 0D6h, 1Ah, 0D0h, 0B5h, 1Ah, 0F2h, 92h, 0A6h ; 18226
	DB 0CEh, 0D0h, 0Fh, 1Bh, 0F2h ; 1822e
	ASCII "Y" ; 18233
	DB 0A4h, 0C5h ; 18234
	ASCII "m" ; 18236
	DB 84h, 0B1h, 03h, 0F2h ; 18237
	ASCII "S" ; 1823b
	DB 0A0h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1823c
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C4h ; 18244
	DB 0D6h, 1Ah, 0D0h, 0B5h, 1Ah, 0F2h ; 1824c
	ASCII "l" ; 18252
	DB 0A6h, 0CEh, 0D0h, 0Fh, 1Bh, 0F2h ; 18253
	ASCII "3" ; 18259
	DB 0A4h, 0C5h ; 1825a
	ASCII "8" ; 1825c
	DB 0A2h, 0B1h, 03h, 0F2h, 2Dh, 0A0h, 0F8h, 06h ; 1825d
	DB 04h, 3Eh, 80h ; 18265
	ASCII "E" ; 18268
	DB 02h, 80h ; 18269
	ASCII "E" ; 1826b
	DB 02h, 00h, 10h, 02h, 00h, 10h, 02h ; 1826c
	ASCIZ "m/" ; 18273
	DB 0EEh, 82h, 03h, 0EFh, 80h, 03h, 0EFh, 80h ; 18276
	DB 03h, 18h, 04h, 03h, 0F8h, 25h, 00h, 00h ; 1827e
	DB 00h, 00h, 00h, 00h, 0F2h ; 18286
	ASCII "h" ; 1828b
	DB 9Fh, 0F2h, 0A9h, 0A0h, 0CEh, 0C4h, 02h, 0F2h ; 1828c
	ASCII "G" ; 18294
	DB 18h, 0CEh, 0C4h, 00h, 0F2h, 5Eh, 0A9h, 0CEh ; 18295
	DB 0C4h, 07h, 0F2h ; 1829d
	ASCIZ "S" ; 182a0
	DB 0C7h ; 182a2
	ASCII "d" ; 182a3
	DB 82h, 0CEh, 0C7h, 01h, 0F2h, 0C8h, 0AAh ; 182a4
	ASCII "8" ; 182ab
	DB 0CEh, 0D4h, 0BAh, 1Ah, 0A6h, 0A2h, 0C6h, 0AAh ; 182ac
	DB 15h, 0CEh, 0C6h, 00h, 0F2h ; 182b4
	ASCII "L" ; 182b9
	DB 0C4h, 0AAh, 0AEh, 0C7h ; 182ba
	ASCII "L" ; 182be
	DB 06h, 0CEh, 0C4h, 02h, 0F2h, 0BFh, 18h, 0C7h ; 182bf
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0B6h, 18h ; 182c7
	DB 0C5h, 03h, 03h, 0C7h, 7Eh, 89h, 0CEh, 0C4h ; 182cf
	DB 07h, 0F2h, 90h, 00h, 0C5h, 03h, 05h, 0C7h ; 182d7
	DB 12h, 89h, 0CEh, 0C4h, 07h, 0F2h, 84h, 00h ; 182df
	DB 0F2h ; 182e7
	ASCII "V" ; 182e8
	DB 0A0h, 0F2h, 0Fh, 9Fh, 0F8h, 0F2h ; 182e9
	ASCII "V" ; 182ef
	DB 0A0h, 0CEh, 0D0h, 0BAh, 1Ah ; 182f0
	ASCIZ "2" ; 182f5
	DB 0E7h, 08h, 0C5h ; 182f7
	ASCII "C" ; 182fa
	DB 16h, 95h, 02h, 0E7h, 11h, 0CEh, 0D0h, 0BAh ; 182fb
	DB 1Ah ; 18303
	ASCII "2" ; 18304
	DB 06h, 0E7h, 08h, 0C5h ; 18305
	ASCII "C" ; 18309
	DB 16h, 95h, 01h, 0E7h, 1Eh, 0F8h, 0CEh, 0D0h ; 1830a
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh ; 18312
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 15h, 19h ; 1831a
	ASCII "2" ; 18321
	DB 0FCh, 0E7h, 07h, 0F2h, 0C7h, 9Fh, 0F2h ; 18322
	ASCII "e" ; 18329
	DB 9Fh, 0F8h, 0C6h, 0AAh, 15h, 0CEh, 0C6h, 00h ; 1832a
	DB 0F2h, 20h, 0C7h, 0F2h, 9Dh, 9Fh, 0F2h ; 18332
	ASCII "U" ; 18339
	DB 9Fh, 0F8h, 06h, 04h, 3Eh, 80h ; 1833a
	ASCII "E" ; 18340
	DB 02h, 80h ; 18341
	ASCII "E" ; 18343
	DB 02h, 00h, 10h, 02h, 00h, 10h, 02h ; 18344
	ASCIZ "m/" ; 1834b
	DB 12h, 84h, 03h, 00h, 00h, 00h, 8Bh, 0E6h ; 1834e
	DB 03h, 18h, 04h, 03h, 0F8h, 25h, 00h, 00h ; 18356
	DB 00h, 00h, 00h, 00h, 0F2h, 0AFh, 0C7h, 0F3h ; 1835e
	DB 24h ; 18366
	ASCII "c" ; 18367
	DB 0F2h, 8Ah, 9Eh, 0F2h, 0CBh, 9Fh, 0CEh, 0C4h ; 18368
	DB 02h, 0F2h ; 18370
	ASCII "i" ; 18372
	DB 17h, 0CEh, 0C4h, 00h, 0F2h, 80h, 0A8h, 0CEh ; 18373
	DB 0C4h, 07h, 0F2h ; 1837b
	ASCII "u" ; 1837e
	DB 0FFh, 0CEh, 0C4h, 00h, 0F2h ; 1837f
	ASCII "A" ; 18384
	DB 0B2h, 0F1h, 19h, 0F2h ; 18385
	ASCII "j" ; 18389
	DB 9Eh, 0F2h, 0ABh, 9Fh, 0CEh, 0C4h, 02h, 0F2h ; 1838a
	ASCII "I" ; 18392
	DB 17h, 0CEh, 0C4h, 00h, 0F2h, 60h, 0A8h, 0CEh ; 18393
	DB 0C4h, 07h, 0F2h ; 1839b
	ASCII "U" ; 1839e
	DB 0FFh, 0F2h, 14h, 0C3h ; 1839f
	ASCIZ "2" ; 183a3
	DB 0EEh, 0BBh, 0FFh ; 183a5
	ASCII "2" ; 183a8
	DB 04h, 0E6h, 01h, 0C6h, 0AAh, 15h, 0CEh, 0C6h ; 183a9
	DB 00h, 0B0h, 02h, 0CEh ; 183b1
	ASCIZ "D" ; 183b5
	DB 0B0h, 0Ch, 0CEh ; 183b7
	ASCII "D" ; 183ba
	DB 01h, 0B0h, 01h, 0CEh ; 183bb
	ASCII "D" ; 183bf
	DB 02h, 0B0h, 00h, 0CEh ; 183c0
	ASCII "D" ; 183c4
	DB 03h, 0B0h, 00h, 0CEh ; 183c5
	ASCII "D" ; 183c9
	DB 04h, 0B0h, 00h, 0CEh ; 183ca
	ASCII "D" ; 183ce
	DB 05h, 0F2h, 82h, 0C6h, 0C7h, 3Ch, 83h, 0CEh ; 183cf
	DB 0C7h, 01h, 0F2h, 97h, 0A9h ; 183d7
	ASCII "8" ; 183dc
	DB 0CEh, 0D4h, 0BAh, 1Ah, 0C7h ; 183dd
	ASCII "L" ; 183e2
	DB 06h, 0CEh, 0C4h, 02h, 0F2h, 9Bh, 17h, 0C7h ; 183e3
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 92h, 17h ; 183eb
	DB 0C5h, 03h, 03h, 0C7h, 7Eh, 89h, 0CEh, 0C4h ; 183f3
	DB 07h, 0F2h ; 183fb
	ASCII "l" ; 183fd
	DB 0FFh, 0C5h, 03h, 05h, 0C7h, 12h, 89h, 0CEh ; 183fe
	DB 0C4h, 07h, 0F2h, 60h, 0FFh, 0F2h ; 18406
	ASCII "2" ; 1840c
	DB 9Fh, 0F2h, 0EBh, 9Dh, 0F8h, 0F2h ; 1840d
	ASCII "2" ; 18413
	DB 9Fh, 0CEh, 0D0h, 0BAh, 1Ah, 20h, 0E7h, 08h ; 18414
	DB 0C5h ; 1841c
	ASCII "C" ; 1841d
	DB 16h, 95h, 02h, 0E7h, 11h, 0CEh, 0D0h, 0BAh ; 1841e
	DB 1Ah ; 18426
	ASCII "2" ; 18427
	DB 06h, 0E7h, 08h, 0C5h ; 18428
	ASCII "C" ; 1842c
	DB 16h, 95h, 01h, 0E7h, 03h, 0F8h, 0F8h, 0C6h ; 1842d
	DB 0AAh, 15h, 0CEh, 0C6h, 00h, 0F2h, 18h, 0C6h ; 18435
	DB 0F2h, 0D4h, 0C6h, 0F2h, 92h, 9Eh, 0F2h ; 1843d
	ASCII "J" ; 18444
	DB 9Eh, 0F8h, 06h, 04h, 0Eh, 00h ; 18445
	ASCII "A" ; 1844b
	DB 02h, 00h ; 1844c
	ASCII "A" ; 1844e
	DB 02h, 00h, 00h, 02h, 00h, 00h, 02h ; 1844f
	ASCIZ "m/" ; 18456
	DB 0B0h, 84h, 03h, 0EFh, 80h, 03h ; 18459
	ASCII "n" ; 1845f
	DB 0E6h, 03h, 18h, 08h, 03h, 1Ah, 26h, 00h ; 18460
	DB 03h ; 18468
	ASCII "R" ; 18469
	DB 02h, 0Ch, 08h, 0F2h, 85h, 9Dh, 0F2h, 0C6h ; 1846a
	DB 9Eh, 0CEh, 0C4h, 02h, 0F2h ; 18472
	ASCII "d" ; 18477
	DB 16h, 0CEh, 0C4h, 00h, 0F2h, 7Bh, 0A7h, 0CEh ; 18478
	DB 0C4h, 07h, 0F2h ; 18480
	ASCII "p" ; 18483
	DB 0FEh, 0C7h ; 18484
	ASCII "G" ; 18486
	DB 84h, 0CEh, 0C7h, 01h, 0F2h, 0E5h, 0A8h, 0B0h ; 18487
	DB 01h, 0CEh, 0D4h, 8Eh, 16h, 0C5h, 00h, 00h ; 1848f
	DB 0C7h, 97h, 06h, 0CEh, 0C4h, 02h, 0F2h, 0E5h ; 18497
	DB 16h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1849f
	DB 0DCh, 16h, 0F2h, 94h, 9Eh, 0F2h ; 184a7
	ASCII "M" ; 184ad
	DB 9Dh, 0F8h, 0F2h, 94h, 9Eh, 0C5h ; 184ae
	ASCII "C" ; 184b4
	DB 16h, 95h, 01h, 0E7h, 09h, 0C5h ; 184b5
	ASCII "C" ; 184bb
	DB 16h, 95h, 02h, 0E7h, 23h, 0F8h, 0CEh, 0D0h ; 184bc
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 184c4
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 8Eh, 16h, 20h ; 184cc
	DB 0E7h, 1Bh, 0CEh, 0C4h, 03h, 0F2h ; 184d4
	ASCII "q" ; 184da
	DB 0FBh, 0F2h, 0F6h, 9Dh, 0F2h, 0AEh, 9Dh, 0F8h ; 184db
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 184e3
	DB 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 0FCh, 9Dh ; 184eb
	DB 0F2h, 9Ah, 9Dh, 0F8h, 07h, 04h, 1Eh, 00h ; 184f3
	ASCII "H" ; 184fb
	DB 03h, 00h ; 184fc
	ASCII "H" ; 184fe
	DB 03h, 00h, 00h, 03h, 00h, 00h, 03h ; 184ff
	ASCIZ "m/" ; 18506
	DB 84h, 85h, 03h, 15h, 9Eh, 03h ; 18509
	ASCII "9" ; 1850f
	DB 86h, 03h, 18h, 08h, 08h, 22h, 26h, 00h ; 18510
	DB 80h ; 18518
	ASCII "y" ; 18519
	DB 03h, 0Ch, 08h, 0B0h, 01h, 0CEh, 0D4h, 0D8h ; 1851a
	DB 1Ah, 0F2h, 0CFh, 9Ch, 0F2h, 10h, 9Eh, 0CEh ; 18522
	DB 0C4h, 02h, 0F2h, 0AEh, 15h, 0CEh, 0C4h, 00h ; 1852a
	DB 0F2h, 0C5h, 0A6h, 0CEh, 0C4h, 07h, 0F2h, 0BAh ; 18532
	DB 0FDh, 0C7h, 0F7h, 84h, 0CEh, 0C7h, 01h, 0F2h ; 1853a
	DB 2Fh, 0A8h, 0C5h, 00h, 00h, 0C7h, 0A8h, 1Fh ; 18542
	DB 0CEh, 0C4h, 02h, 0F2h ; 1854a
	ASCII "5" ; 1854e
	DB 16h, 0C5h, 00h, 00h, 0C7h, 0AEh, 1Fh, 0CEh ; 1854f
	DB 0C4h, 02h, 0F2h, 29h, 16h, 0C5h, 2Fh, 1Bh ; 18557
	DB 0C7h, 14h, 20h, 0CEh, 0C4h, 02h, 0F2h, 1Dh ; 1855f
	DB 16h, 0C5h, 2Bh, 1Bh, 0C7h, 29h, 20h, 0CEh ; 18567
	DB 0C4h, 02h, 0F2h, 11h, 16h, 0C7h, 0AEh, 13h ; 1856f
	DB 0CEh, 0C4h, 02h, 0F2h, 08h, 16h, 0F2h, 0C0h ; 18577
	DB 9Dh, 0F2h ; 1857f
	ASCII "y" ; 18581
	DB 9Ch, 0F8h, 0F2h, 0C0h, 9Dh, 0CEh, 0D0h ; 18582
	ASCII "C" ; 18589
	DB 16h, 96h, 04h, 0E7h ; 1858a
	ASCII "u" ; 1858e
	DB 96h, 02h, 0E7h ; 1858f
	ASCII "O" ; 18592
	DB 96h, 01h, 0E6h ; 18593
	ASCII "4" ; 18596
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 18597
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0F9h, 0A3h ; 1859f
	DB 0B1h, 03h, 0CEh, 0D0h ; 185a7
	ASCII "B" ; 185ab
	DB 16h, 96h, 60h, 0E6h, 09h ; 185ac
	ASCII "8" ; 185b1
	DB 0CEh, 0D4h, 0D6h, 1Ah, 0F2h, 1Ch, 9Dh, 0F2h ; 185b2
	DB 0D4h, 9Ch, 0CEh, 0D0h, 0D7h, 1Ah ; 185ba
	ASCII "2" ; 185c0
	DB 03h, 0E4h, 07h, 0B0h, 02h, 0CEh, 0D4h, 0D7h ; 185c1
	DB 1Ah, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 185c9
	DB 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C5h ; 185d1
	DB 0EFh, 80h, 0B1h, 03h, 0F2h, 0B0h, 9Ch, 0F8h ; 185d9
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 185e1
	DB 21h, 0CEh, 0D4h, 0FAh, 14h, 0F8h, 0CEh, 0D0h ; 185e9
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh ; 185f1
	DB 0D4h, 0FAh, 14h, 0F2h, 0F0h, 9Ch, 0F2h, 8Eh ; 185f9
	DB 9Ch, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 18601
	DB 09h, 0CEh, 0D0h, 0D7h, 1Ah, 0CEh, 0D4h, 0FAh ; 18609
	DB 14h, 0F8h, 0Dh, 04h, 3Eh, 00h ; 18611
	ASCII "P" ; 18617
	DB 03h, 00h ; 18618
	ASCII "W" ; 1861a
	DB 03h, 00h, 00h, 04h, 00h, 00h, 04h, 83h ; 1861b
	ASCIZ "0" ; 18623
	DB 0DEh, 88h, 03h, 1Dh, 85h, 03h, 00h, 00h ; 18625
	DB 00h, 18h, 08h, 01h ; 1862d
	ASCIZ "B&" ; 18631
	DB 0E0h ; 18634
	ASCII "y" ; 18635
	DB 03h, 0Ch, 08h, 0F2h, 0A8h, 07h, 0B9h, 0E5h ; 18636
	DB 1Ah, 0D5h, 80h, 04h, 0E4h, 0Ah, 0C5h ; 1863e
	ASCII "c" ; 18645
	DB 0E4h, 0B1h, 03h, 0F2h ; 18646
	ASCII "1" ; 1864a
	DB 9Ch, 0F8h, 0CEh, 0D0h, 0DBh, 1Ah, 0C5h, 0DAh ; 1864b
	DB 1Ah, 2Bh, 0E7h, 24h, 0CEh, 0C4h, 02h, 0F2h ; 18653
	ASCII "h)" ; 1865b
	DB 0B1h, 28h, 0CFh, 0B1h, 0CEh, 0C4h, 02h, 0F2h ; 1865d
	DB 29h, 29h, 0CFh, 0B5h, 0F5h, 0F5h, 0B0h, 02h ; 18665
	DB 0CEh, 0D4h, 0DCh, 1Ah, 0C5h, 0C2h, 0E5h, 0B1h ; 1866d
	DB 03h, 0F2h, 04h, 9Ch, 0F8h ; 18675
	ASCII "8" ; 1867a
	DB 0CEh, 0D4h, 22h, 1Bh, 0CEh, 0D4h ; 1867b
	ASCII "i" ; 18681
	DB 1Bh, 0C6h, 0AAh, 15h, 0CEh, 0C6h, 00h, 0F2h ; 18682
	DB 7Bh, 0C0h, 0CEh, 0D0h, 0ADh, 15h ; 1868a
	ASCII "2" ; 18690
	DB 07h, 0E4h, 05h ; 18691
	ASCII "2" ; 18694
	DB 15h, 0E4h, 1Bh, 0B0h, 01h, 0CEh, 0D4h, 14h ; 18695
	DB 1Bh, 0B0h, 00h, 0CEh, 0D4h, 15h, 1Bh, 0B0h ; 1869d
	DB 0FFh, 0CEh, 0D4h, 0E8h, 1Ah, 0B0h, 01h, 0CEh ; 186a5
	DB 0D4h, 0D8h, 1Ah, 0F1h, 04h, 0F2h, 0A8h, 08h ; 186ad
	DB 0F2h, 0DFh, 06h, 0CEh, 0D0h, 15h, 1Bh ; 186b5
	ASCII "2" ; 186bc
	DB 03h, 0E6h, 0Bh ; 186bd
	ASCII "2" ; 186c0
	DB 04h, 0E6h, 07h, 0B0h, 00h, 0CEh, 0D4h, 15h ; 186c1
	DB 1Bh ; 186c9
	ASCII "8" ; 186ca
	DB 0CEh, 0D4h, 17h, 1Bh, 0CEh, 0D4h, 29h, 1Bh ; 186cb
	DB 0CEh, 0D4h, 28h, 1Bh, 0CEh, 0D4h, 1Ch, 1Bh ; 186d3
	DB 0CEh, 0D4h, 1Dh, 1Bh, 0CEh, 0D4h, 20h, 1Bh ; 186db
	DB 0F2h, 0B1h, 05h, 0F2h, 0Ch, 9Bh, 0F2h ; 186e3
	ASCII "M" ; 186ea
	DB 9Ch, 0CEh, 0C4h, 02h, 0F2h, 0EBh, 13h, 0CEh ; 186eb
	DB 0C4h, 00h, 0F2h, 02h, 0A5h, 0CEh, 0C4h, 07h ; 186f3
	DB 0F2h, 0F7h, 0FBh, 0C7h, 13h, 86h, 0CEh, 0C7h ; 186fb
	DB 01h, 0F2h ; 18703
	ASCII "l" ; 18705
	DB 0A6h, 0F2h, 0FBh, 01h, 0C5h, 00h, 00h, 0C7h ; 18706
	ASCII "E" ; 1870e
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1870f
	DB 99h, 17h, 0C5h, 00h, 00h, 0C7h, 0DEh, 0C3h ; 18717
	DB 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h, 8Ah ; 1871f
	DB 17h, 0B9h, 10h, 1Bh, 0C7h, 0D3h, 0BCh, 0CEh ; 18727
	DB 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h, 7Bh, 17h ; 1872f
	DB 0CEh, 0D0h, 0D8h, 1Ah ; 18737
	ASCII "2" ; 1873b
	DB 01h, 0E7h, 0Fh, 0C5h ; 1873c
	ASCII "K-" ; 18740
	DB 0C7h ; 18742
	ASCII "o'" ; 18743
	DB 0CEh, 0C4h, 02h, 0F2h, 3Ah, 14h, 0F1h, 18h ; 18745
	DB 0CEh, 0D0h, 0D7h, 1Ah ; 1874d
	ASCII "2" ; 18751
	DB 02h, 0E7h, 10h, 0C5h, 00h, 00h, 0C7h ; 18752
	ASCII "Y" ; 18759
	DB 0C7h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1875a
	ASCII "N" ; 18762
	DB 17h, 0B9h, 12h, 1Bh, 0C7h ; 18763
	ASCII "4" ; 18768
	DB 0AAh, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 18769
	DB 3Fh, 17h, 0C5h, 00h, 00h, 0C7h ; 18771
	ASCII "L5" ; 18777
	DB 0CEh, 0C7h, 01h, 0CEh, 0C4h, 02h, 0F2h, 03h ; 18779
	DB 14h, 0C5h, 00h, 00h, 0C7h, 14h, 3Bh, 0CEh ; 18781
	DB 0C7h, 01h, 0CEh, 0C4h, 02h, 0F2h, 0F4h, 13h ; 18789
	DB 0C5h, 00h, 00h, 0C7h, 1Ch, 40h, 0CEh, 0C7h ; 18791
	DB 01h, 0CEh, 0C4h, 02h, 0F2h, 0E5h, 13h, 0C5h ; 18799
	DB 00h, 00h, 0C7h, 17h ; 187a1
	ASCII "E" ; 187a5
	DB 0CEh, 0C7h, 01h, 0CEh, 0C4h, 02h, 0F2h, 0D6h ; 187a6
	DB 13h, 0C5h, 00h, 00h, 0C7h, 12h ; 187ae
	ASCII "J" ; 187b4
	DB 0CEh, 0C7h, 01h, 0CEh, 0C4h, 02h, 0F2h, 0C7h ; 187b5
	DB 13h, 0C5h, 21h, 10h, 0C7h, 0EEh, 0B6h, 0CEh ; 187bd
	DB 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h, 0E5h, 16h ; 187c5
	DB 0C5h, 20h, 25h, 0C7h, 0EEh, 0C8h, 0CEh, 0C7h ; 187cd
	DB 00h, 0CEh, 0C4h, 02h, 0F2h, 0D6h, 16h, 0C5h ; 187d5
	DB 00h, 00h, 0C7h, 0F2h, 0B8h, 0CEh, 0C7h, 00h ; 187dd
	DB 0CEh, 0C4h, 02h, 0F2h, 0C7h, 16h, 0CEh, 0D0h ; 187e5
	DB 0D8h, 1Ah ; 187ed
	ASCII "2" ; 187ef
	DB 01h, 0E7h, 0Dh, 0C5h ; 187f0
	ASCII "K-" ; 187f4
	DB 0C7h ; 187f6
	ASCII "u'" ; 187f7
	DB 0CEh, 0C4h, 02h, 0F2h, 86h, 13h, 0C5h, 01h ; 187f9
	DB 00h, 0C7h, 92h, 8Dh, 0CEh, 0C4h, 07h, 0F2h ; 18801
	DB 60h, 0FBh, 0CEh, 0D0h, 0D8h, 1Ah ; 18809
	ASCII "2" ; 1880f
	DB 01h, 0E7h, 19h, 0C5h, 00h, 01h, 0C7h, 3Dh ; 18810
	DB 8Eh, 0CEh, 0C4h, 07h, 0F2h ; 18818
	ASCII "L" ; 1881d
	DB 0FBh, 0C5h, 05h, 03h, 0C7h, 0F4h, 8Dh, 0CEh ; 1881e
	DB 0C4h, 07h, 0F2h, 40h, 0FBh, 0CEh, 0D0h, 0D8h ; 18826
	DB 1Ah ; 1882e
	ASCIZ "2" ; 1882f
	DB 0E7h, 5Dh, 0C5h, 00h, 01h, 0C7h, 0D9h, 8Eh ; 18831
	DB 0CEh, 0C4h, 07h, 0F2h, 2Ch, 0FBh, 0CEh, 0D0h ; 18839
	DB 0D7h, 1Ah ; 18841
	ASCIZ "2" ; 18843
	DB 0E6h, 1Ah ; 18845
	ASCII "2" ; 18847
	DB 01h, 0E6h ; 18848
	ASCII "62" ; 1884a
	DB 02h, 0E7h ; 1884c
	ASCII "A" ; 1884e
	DB 0C5h, 1Ch, 29h, 0C7h, 0E5h, 0C5h, 0CEh, 0C7h ; 1884f
	DB 00h, 0CEh, 0C4h, 02h, 0F2h ; 18857
	ASCII "T" ; 1885c
	DB 16h, 0F1h ; 1885d
	ASCII "0" ; 1885f
	DB 0C5h, 20h, 2Ch, 0C7h, 0C6h, 0C4h, 0CEh, 0C7h ; 18860
	DB 00h, 0CEh, 0C4h, 02h, 0F2h ; 18868
	ASCII "C" ; 1886d
	DB 16h, 0C5h, 08h, 18h, 0C7h ; 1886e
	ASCII "X" ; 18873
	DB 0C6h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 18874
	ASCII "4" ; 1887c
	DB 16h, 0F1h, 10h, 0C5h, 20h, 25h, 0C7h, 7Fh ; 1887d
	DB 0CAh, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 18885
	DB 23h, 16h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h ; 1888d
	DB 0F2h, 0EDh, 12h, 0CEh, 0D0h, 14h, 1Bh, 0F2h ; 18895
	DB 0EEh, 00h, 0CEh, 0D0h, 2Ah, 1Bh, 28h, 0E6h ; 1889d
	DB 14h, 0C4h, 00h, 80h, 0BCh ; 188a5
	ASCII "4" ; 188aa
	DB 16h, 0BCh ; 188ab
	ASCII "7" ; 188ad
	DB 16h, 0B0h, 05h, 0CEh, 0D4h ; 188ae
	ASCII "6" ; 188b3
	DB 16h, 0CEh, 0D4h ; 188b4
	ASCII "9" ; 188b7
	DB 16h, 0B4h, 20h, 0D9h, 26h, 40h, 0F2h, 7Fh ; 188b8
	DB 9Ah, 0F2h ; 188c0
	ASCII "8" ; 188c2
	DB 99h, 0CEh, 0D0h, 22h, 1Bh, 28h, 0E6h, 13h ; 188c3
	ASCII "8" ; 188cb
	DB 0CEh, 0D4h, 22h, 1Bh, 0CEh, 0D0h, 0B6h, 1Ah ; 188cc
	DB 20h, 0E6h, 07h, 0B0h, 07h, 0CEh, 0D4h, 0FAh ; 188d4
	DB 14h, 0F8h, 0F2h, 11h, 01h, 0F2h ; 188dc
	ASCII "c" ; 188e2
	DB 9Ah, 0F2h ; 188e3
	ASCII "a" ; 188e5
	DB 03h, 0B9h, 0E5h, 1Ah, 0D5h, 80h, 04h, 0E4h ; 188e6
	DB 11h, 0C5h ; 188ee
	ASCII "c" ; 188f0
	DB 0E4h, 0B1h, 03h, 0F2h, 99h, 99h, 0C5h, 00h ; 188f1
	DB 89h, 0B1h, 03h, 0F2h, 7Eh, 99h, 0F8h, 0F2h ; 188f9
	ASCII "D" ; 18901
	DB 9Ah, 0F8h, 0CEh, 0D0h, 0D8h, 1Ah ; 18902
	ASCIZ "2" ; 18908
	DB 0E6h, 03h, 0F1h, 3Ah, 0CEh, 0D0h, 0D7h, 1Ah ; 1890a
	DB 0B2h, 0Bh, 0CEh, 0D8h, 0C7h ; 18912
	ASCII "k" ; 18917
	DB 89h, 0CEh, 0C7h, 01h, 0CFh ; 18918
	ASCII "C" ; 1891d
	DB 0CFh, 0D8h, 0BCh, 2Ch, 16h, 93h, 93h ; 1891e
	ASCII "G" ; 18925
	DB 0CEh, 0D4h, 2Eh, 16h, 93h, 0CFh, 0D8h, 0BCh ; 18926
	DB 2Fh, 16h, 93h, 93h ; 1892e
	ASCII "G" ; 18932
	DB 0CEh, 0D4h ; 18933
	ASCII "1" ; 18935
	DB 16h, 93h, 0CFh, 0DAh, 93h, 93h ; 18936
	ASCII "G" ; 1893c
	DB 0CEh, 0CEh, 93h ; 1893d
	ASCII "O" ; 18940
	DB 0CEh ; 18941
	ASCII "A" ; 18942
	DB 01h, 0F2h, 0DCh, 0A2h, 0C7h, 13h, 86h, 0CEh ; 18943
	DB 0C7h, 01h, 0CEh ; 1894b
	ASCII "Q" ; 1894e
	DB 1Eh, 0CEh ; 1894f
	ASCII "Y" ; 18951
	DB 1Fh, 0D5h, 00h, 00h, 0E6h, 10h, 0BAh ; 18952
	ASCII "T" ; 18959
	DB 16h, 0CEh, 0D0h ; 1895a
	ASCII "V" ; 1895d
	DB 16h, 0CEh, 0CEh, 0CEh ; 1895e
	ASCII "A " ; 18962
	DB 0F2h, 02h, 00h, 0F8h, 0CEh, 0CCh, 0F4h, 00h ; 18964
	DB 5Eh, 03h, 00h ; 1896c
	ASCII "e" ; 1896f
	DB 03h, 17h, 8Fh, 03h, 08h, 0Ch, 00h ; 18970
	ASCII "W" ; 18977
	DB 06h, 00h, 5Eh, 06h ; 18978
	ASCII "w" ; 1897c
	DB 8Fh, 03h, 08h, 0Ch, 00h ; 1897d
	ASCII "e" ; 18982
	DB 06h, 00h ; 18983
	ASCII "l" ; 18985
	DB 06h, 0D7h, 8Fh, 03h, 08h, 0Ch, 0A6h, 0A3h ; 18986
	DB 0C7h, 0BCh, 89h, 0CEh, 0C7h, 01h ; 1898e
	ASCIZ "2" ; 18994
	DB 0E6h, 04h, 0C7h, 0C5h, 89h, 0CEh, 0D0h, 0D7h ; 18996
	DB 1Ah ; 1899e
	ASCIZ "H" ; 1899f
	DB 01h, 0B1h, 00h, 0CFh ; 189a1
	ASCII "B" ; 189a5
	DB 0CFh, 0D8h, 0BCh ; 189a6
	ASCII "4" ; 189a9
	DB 16h, 0BCh ; 189aa
	ASCII "7" ; 189ac
	DB 16h, 0CEh ; 189ad
	ASCII "A" ; 189af
	DB 02h, 0CEh, 0D4h ; 189b0
	ASCII "6" ; 189b3
	DB 16h, 0CEh, 0D4h ; 189b4
	ASCII "9" ; 189b7
	DB 16h, 0ABh, 0AEh, 0F8h, 00h, 00h, 04h, 00h ; 189b8
	DB 40h, 04h, 00h, 80h, 04h, 00h, 0C0h, 04h ; 189c0
	DB 00h, 00h, 05h, 00h, 40h, 05h
; ---------------------- ; 189c8
loc_0x0189CE:

	LD A,[1ADBh] ; 189ce
	OR A,A ; 189d2
	JRS Z,loc_0x0189E7 ; 189d3

	LD A,[1AD7h] ; 189d5
	ADD A,A ; 189d9
	LD B,#00h ; 189da
	LD IY,#89EBh ; 189dc
	LD YP,#01h ; 189df
	ADD IY,BA ; 189e2
	LD BA,[IY] ; 189e4

	RET

; ---------------------- ; 189e6
loc_0x0189E7:

	LD BA,#0E10h ; 189e7

	RET

; ---------------------- ; 189ea
	DB 60h, 09h, 10h, 0Eh, 0B8h, 0Bh, 0C5h, 03h ; 189eb
	DB 1Bh, 86h ; 189f3
	ASCII "E2$" ; 189f5
	DB 0E4h, 19h, 0B5h, 00h, 0B9h, 01h, 1Bh, 91h ; 189f8
	DB 0BDh, 01h, 1Bh, 0F2h, 0C9h, 0FFh, 0CFh ; 18a00
	ASCII "8" ; 18a07
	DB 0E4h, 09h, 0CFh, 28h, 0BDh, 01h, 1Bh, 0F2h ; 18a08
	DB 11h, 02h, 0CEh, 0D0h, 0E7h, 1Ah, 22h, 1Ch ; 18a10
	DB 0E7h, 0Dh, 0C4h, 00h, 00h, 0CEh, 0D4h, 06h ; 18a18
	DB 1Bh, 0BCh, 04h, 1Bh, 0F1h, 21h, 0C5h, 06h ; 18a20
	DB 1Bh, 86h ; 18a28
	ASCII "E2$" ; 18a2a
	DB 0E4h, 18h, 0B5h, 00h, 0B9h, 04h, 1Bh, 91h ; 18a2d
	DB 0BDh, 04h, 1Bh, 0D5h, 10h, 0Eh, 0E4h, 0Ah ; 18a35
	DB 0D1h, 10h, 0Eh, 0BDh, 04h, 1Bh, 0F2h, 0F3h ; 18a3d
	DB 01h, 0CEh, 0D0h, 0E8h, 1Ah ; 18a45
	ASCII "2" ; 18a4a
	DB 0FFh, 0E7h ; 18a4b
	ASCII "5" ; 18a4d
	DB 0CEh, 0D0h, 0DBh, 1Ah, 28h, 0E6h, 2Eh, 0C5h ; 18a4e
	DB 09h, 1Bh, 86h ; 18a56
	ASCII "E2$" ; 18a59
	DB 0E4h, 0Ah, 0B5h, 00h, 0B9h, 07h, 1Bh, 91h ; 18a5c
	DB 0BDh, 07h, 1Bh, 0F2h, 0A1h, 01h, 0B9h, 07h ; 18a64
	DB 1Bh, 0B1h, 00h, 0CFh, 28h, 0E4h, 10h, 0BDh ; 18a6c
	DB 07h, 1Bh, 0A1h, 0A0h, 0CEh, 0C4h, 02h, 0F2h ; 18a74
	ASCII "9%" ; 18a7c
	DB 0A8h, 0A9h, 0F1h, 0EEh, 0F2h, 0CAh, 04h, 0F8h
; ---------------------- ; 18a7e
loc_0x018A86:

	LD B,#00h ; 18a86
	LD [1B6Ch],B ; 18a88

	LD A,[1ADBh] ; 18a8c
	OR A,A ; 18a90
	JRS Z,loc_0x018A96 ; 18a91

	OR B,#01h ; 18a93

loc_0x018A96:

	LD A,[1ADAh] ; 18a96
	CP A,#28h ; 18a9a
	JRS NC,loc_0x018AA1 ; 18a9c

	OR B,#02h ; 18a9e

loc_0x018AA1:

	PUSH B ; 18aa1

	LD IX,#15AAh ; 18aa3
	LD XP,#00h ; 18aa6
	CARL loc_0x004706 ; 18aa9

	LD HL,#0100h ; 18aac
	LD [1B95h],HL ; 18aaf

	LD IX,#15AAh ; 18ab2
	CARL loc_0x018B15 ; 18ab5

	LD A,[1ADAh] ; 18ab8
	CP A,#28h ; 18abc
	JRS NZ,loc_0x018AC8 ; 18abe

	LD HL,[1B6Ah] ; 18ac0
	CP HL,#0FFFFh ; 18ac3
	JRS NZ,loc_0x018ACD ; 18ac6

loc_0x018AC8:

	CARL loc_0x018BC5 ; 18ac8

	JRS loc_0x018AD1

; ---------------------- ; 18acb
loc_0x018ACD:

	DEC HL ; 18acd
	LD [1B6Ah],HL ; 18ace

loc_0x018AD1:

	CARL loc_0x018F4E ; 18ad1

	POP B ; 18ad4
	BIT B,#01h ; 18ad6
	JRS Z,loc_0x018AE3 ; 18ad8

	LD A,[1ADBh] ; 18ada
	OR A,A ; 18ade
	JRS Z,loc_0x018B09 ; 18adf

	JRS loc_0x018AF2

; ---------------------- ; 18ae1
loc_0x018AE3:

	LD A,[1B6Ch] ; 18ae3
	CP A,#01h ; 18ae7
	JRS NZ,loc_0x018AF2 ; 18ae9

	LD A,[1ADAh] ; 18aeb
	OR A,A ; 18aef
	JRS NZ,loc_0x018B12 ; 18af0

loc_0x018AF2:

	BIT B,#02h ; 18af2
	JRS Z,loc_0x018AFE ; 18af4

	LD A,[1ADAh] ; 18af6
	CP A,#28h ; 18afa
	JRS NC,loc_0x018B0C ; 18afc

loc_0x018AFE:

	LD HL,[1B6Ah] ; 18afe
	CP HL,#0000h ; 18b01
	JRS Z,loc_0x018B0F ; 18b04

	LD A,#00h ; 18b06

	RET

; ---------------------- ; 18b08
loc_0x018B09:

	LD A,#01h ; 18b09

	RET

; ---------------------- ; 18b0b
loc_0x018B0C:

	LD A,#02h ; 18b0c

	RET

; ---------------------- ; 18b0e
loc_0x018B0F:

	LD A,#03h ; 18b0f

	RET

; ---------------------- ; 18b11
loc_0x018B12:

	LD A,#04h ; 18b12

	RET

; ---------------------- ; 18b14
loc_0x018B15:

	LD A,[IX+04h] ; 18b15
	LD L,#3Ch ; 18b18
	MLT ; 18b1a
	LD A,[IX+05h] ; 18b1c
	LD B,#00h ; 18b1f
	ADD HL,BA ; 18b21
	LD A,[IX+03h] ; 18b23

	CP A,#06h ; 18b26
	JRS C,loc_0x018B6D ; 18b28

	JRS Z,loc_0x018B34 ; 18b2a

	CP A,#14h ; 18b2c
	JRS Z,loc_0x018B42 ; 18b2e

	JRS NC,loc_0x018B6D ; 18b30

	JRS C,loc_0x018B4E ; 18b32

loc_0x018B34:

	LD BA,#0E10h ; 18b34
	SUB BA,HL ; 18b37

	LD HL,[1B95h] ; 18b39
	SUB HL,BA ; 18b3c
	JRS C,loc_0x018B4E ; 18b3e

	JRS loc_0x018B51

; ---------------------- ; 18b40
loc_0x018B42:

	LD BA,#0E10h ; 18b42
	SUB BA,HL ; 18b45
	LD HL,[1B95h] ; 18b47
	CP BA,HL ; 18b4a
	JRS C,loc_0x018B51 ; 18b4c

loc_0x018B4E:

	LD BA,[1B95h] ; 18b4e

loc_0x018B51:

	LD HL,[1B01h] ; 18b51
	ADD HL,BA ; 18b54
	LD [1B01h],HL ; 18b56
	CARL loc_0x0189CE ; 18b59

	SUB HL,BA ; 18b5c
	JRS C,loc_0x018B6D ; 18b5e

	LD [1B01h],HL ; 18b60
	LD HL,#1B6Ch ; 18b63
	INC [HL] ; 18b66

	LD NB,#02h ; 18b67
	CARL loc_0x012F81 ; 18b6a

loc_0x018B6D:

	LD A,[1AE7h] ; 18b6d
	AND A,#1Ch ; 18b71
	JRS NZ,loc_0x018B81 ; 18b73

	LD BA,#0000h ; 18b75
	LD [1B06h],A ; 18b78
	LD [1B04h],BA ; 18b7c

	JRS loc_0x018B97

; ---------------------- ; 18b7f
loc_0x018B81:

	LD HL,[1B04h] ; 18b81
	LD BA,[1B95h] ; 18b84
	ADD HL,BA ; 18b87
	LD [1B04h],HL ; 18b89

	SUB HL,#0E10h ; 18b8c
	JRS C,loc_0x018B97 ; 18b8f

	LD [1B04h],HL ; 18b91
	CARL loc_0x018C38 ; 18b94

loc_0x018B97:

	LD A,[1ADBh] ; 18b97
	OR A,A ; 18b9b
	JRS Z,loc_0x018BC4 ; 18b9c

	LD HL,[1B07h] ; 18b9e
	LD BA,[1B95h] ; 18ba1
	ADD HL,BA ; 18ba4
	LD [1B07h],HL ; 18ba6

	CARL loc_0x018C0A ; 18ba9

	LD HL,[1B07h] ; 18bac
	LD B,#00h ; 18baf

loc_0x018BB1:

	SUB HL,BA ; 18bb1
	JRS C,loc_0x018BC4 ; 18bb3

	LD [1B07h],HL ; 18bb5

	PUSH HL ; 18bb8
	PUSH BA ; 18bb9

	LD NB,#02h ; 18bba
	CARL loc_0x012FB6 ; 18bbd

	POP BA ; 18bc0
	POP HL ; 18bc1

	JRS loc_0x018BB1

; ---------------------- ; 18bc2
loc_0x018BC4:

	RET

; ---------------------- ; 18bc4
loc_0x018BC5:

	LD A,[1ADAh] ; 18bc5
	CP A,#28h ; 18bc9
	JRS C,loc_0x018BF7 ; 18bcb

	LD NB,#01h ; 18bcd
	CARL loc_0x00AA55 ; 18bd0

	LD HL,#0000h ; 18bd3
	CP A,#00h ; 18bd6
	JRS Z,loc_0x018BE1 ; 18bd8

	LD HL,#0002h ; 18bda
	CP A,#01h ; 18bdd
	JRS NZ,loc_0x018BF7 ; 18bdf

loc_0x018BE1:

	LD A,[1AD7h] ; 18be1
	ADD A,A ; 18be5
	ADD A,A ; 18be6

	LD B,#00h ; 18be7
	LD IY,#8BFEh ; 18be9

	LD YP,#01h ; 18bec
	ADD IY,BA ; 18bef
	ADD IY,HL ; 18bf1
	LD HL,[IY] ; 18bf3
	JRS loc_0x018BFA

; ---------------------- ; 18bf5
loc_0x018BF7:

	LD HL,#0FFFFh ; 18bf7

loc_0x018BFA:

	LD [1B6Ah],HL ; 18bfa

	RET

; ---------------------- ; 18bfd
	DB 07h, 00h, 0Eh, 00h, 0Bh, 00h, 17h, 00h ; 18bfe
	DB 09h, 00h, 12h, 00h
; ---------------------- ; 18c06
loc_0x018C0A:
	LD B,#50h ; 18c0a
	LD A,[1AE8h] ; 18c0c
	CP A,#0FFh ; 18c10
	JRS NZ,loc_0x018C20 ; 18c12

	LD B,#3Ch ; 18c14
	LD A,[1AD9h] ; 18c16
	CP A,#00h ; 18c1a
	JRS Z,loc_0x018C20 ; 18c1c

	LD B,#28h ; 18c1e

loc_0x018C20:

	LD A,B ; 18c20

	RET

; ---------------------- ; 18c21
	DB 0CEh, 0D0h, 0DBh, 1Ah, 28h, 0E6h, 09h, 0CEh ; 18c22
	DB 0C4h, 02h, 0F2h ; 18c2a
	ASCII "S#" ; 18c2d
	DB 0F1h, 07h, 0CEh, 0C4h, 02h, 0F2h ; 18c2f
	ASCII "F#" ; 18c35
	DB 0F8h
; ---------------------- ; 18c37
loc_0x018C38:

	LD B,#04h ; 18c38

loc_0x018C3A:

	PUSH B ; 18c3a

	LD NB,#02h ; 18c3c
	CARL loc_0x012F9E ; 18c3f

	POP B ; 18c42

	DJR NZ,loc_0x018C3A ; 18c44

	RET

; ---------------------- ; 18c46
	DB 0C5h, 29h, 1Bh, 0CEh, 0D0h, 28h, 1Bh ; 18c47
	ASCII "2" ; 18c4e
	DB 03h, 0E4h, 09h, 0B0h, 00h, 0CEh, 0D4h, 28h ; 18c4f
	DB 1Bh ; 18c57
	ASCII "8hE(" ; 18c58
	DB 0E6h, 0Ah, 8Eh, 0E7h, 07h, 0B0h, 00h, 0CEh ; 18c5c
	DB 0D4h, 28h, 1Bh, 0CEh, 0D0h ; 18c64
	ASCII "w" ; 18c69
	DB 16h, 28h, 0E6h, 19h, 0CEh, 0D0h, 28h, 1Bh ; 18c6a
	ASCII "2" ; 18c72
	DB 02h, 0E6h, 0Ah, 0B5h, 24h, 0B0h, 01h, 0CEh ; 18c73
	DB 0D4h, 28h, 1Bh, 0F8h, 0B0h, 03h, 0CEh, 0D4h ; 18c7b
	DB 28h, 1Bh, 0F8h, 0CEh, 0D0h, 28h, 1Bh ; 18c83
	ASCII "2" ; 18c8a
	DB 01h, 0E6h, 02h, 0F8h, 0B0h, 02h, 0CEh, 0D4h ; 18c8b
	DB 28h, 1Bh, 0F8h, 0B1h, 2Ch, 0CEh, 0D0h, 0D8h ; 18c93
	DB 1Ah ; 18c9b
	ASCII "2" ; 18c9c
	DB 01h, 0E6h, 0Bh, 0CEh, 0D0h, 0D7h, 1Ah ; 18c9d
	ASCII "2" ; 18ca4
	DB 02h, 0E7h, 03h, 0B1h ; 18ca5
	ASCII "0" ; 18ca9
	DB 0CEh, 0D5h, 23h, 1Bh, 0F8h
; ---------------------- ; 18caa
loc_0x018CAF:

	XOR A,A ; 18caf

	LD [1AC3h],A ; 18cb0
	LD [1AC4h],A ; 18cb4
	LD [1AC5h],A ; 18cb8
	LD [1AC6h],A ; 18cbc
	LD [1AC7h],A ; 18cc0
	LD [1AC8h],A ; 18cc4
	LD [1AC9h],A ; 18cc8
	LD [1ACAh],A ; 18ccc
	LD [1AD1h],A ; 18cd0
	LD [1AD2h],A ; 18cd4
	LD [1AD3h],A ; 18cd8
	LD [1AD7h],A ; 18cdc
	LD [1AD5h],A ; 18ce0
	LD [1AD4h],A ; 18ce4

	LD A,#0FFh ; 18ce8

	LD [1ACBh],A ; 18cea
	LD [1ACCh],A ; 18cee
	LD [1ACDh],A ; 18cf2
	LD [1ACEh],A ; 18cf6
	LD [1ACFh],A ; 18cfa
	LD [1AD0h],A ; 18cfe
	LD [1AD6h],A ; 18d02

	RET

; ---------------------- ; 18d06
	DB 0C4h, 00h, 00h, 0CEh, 0D4h, 0D9h, 1Ah, 0CEh ; 18d07
	DB 0D4h, 0Ah, 1Bh, 0CEh, 0D4h, 0E7h, 1Ah, 0CEh ; 18d0f
	DB 0D4h, 0DDh, 1Ah, 0CEh, 0D4h, 0DFh, 1Ah, 0CEh ; 18d17
	DB 0D4h, 0E1h, 1Ah, 0CEh, 0D4h, 0E3h, 1Ah, 0CEh ; 18d1f
	DB 0D4h, 0DEh, 1Ah, 0CEh, 0D4h, 0E0h, 1Ah, 0CEh ; 18d27
	DB 0D4h, 0E2h, 1Ah, 0CEh, 0D4h, 0E4h, 1Ah, 0CEh ; 18d2f
	DB 0D4h, 0E8h, 1Ah, 0BCh, 01h, 1Bh, 0CEh, 0D4h ; 18d37
	DB 03h, 1Bh, 0BCh, 04h, 1Bh, 0CEh, 0D4h, 06h ; 18d3f
	DB 1Bh, 0BCh, 07h, 1Bh, 0CEh, 0D4h, 09h, 1Bh ; 18d47
	DB 0CEh, 0D4h, 0EAh, 1Ah, 0CEh, 0D4h, 0EBh, 1Ah ; 18d4f
	DB 0CEh, 0D4h, 0E9h, 1Ah, 0BCh, 0E5h, 1Ah, 0CEh ; 18d57
	DB 0D4h, 2Ah, 1Bh, 0B1h, 07h, 0C5h, 0ECh, 1Ah ; 18d5f
	ASCII "h" ; 18d67
	DB 91h, 0F5h, 0FDh, 0B0h, 28h, 0CEh, 0D4h, 0DAh ; 18d68
	DB 1Ah, 0B0h, 08h, 0CEh, 0D4h, 0DBh, 1Ah, 0B0h ; 18d70
	DB 00h, 0CEh, 0D4h, 0DCh, 1Ah, 0B0h, 00h, 0CEh ; 18d78
	DB 0D4h, 14h, 1Bh, 0B0h, 00h, 0CEh, 0D4h, 15h ; 18d80
	DB 1Bh, 0F2h, 2Bh, 0B9h, 0C6h, 0F3h, 1Ah, 0CEh ; 18d88
	DB 0C6h, 00h, 0F2h ; 18d90
	ASCII "r" ; 18d93
	DB 0B9h, 0F8h, 0B0h, 00h, 0CEh, 0D4h, 15h, 1Bh ; 18d94
	ASCII "8" ; 18d9c
	DB 0CEh, 0D4h, 14h, 1Bh, 0F2h, 0F3h, 0FEh, 0CEh ; 18d9d
	DB 0D1h, 23h, 1Bh, 0B0h, 28h, 0BCh, 12h, 1Bh ; 18da5
	DB 0CEh, 0D0h, 0D8h, 1Ah ; 18dad
	ASCIZ "2" ; 18db1
	DB 0E7h, 06h ; 18db3
	ASCII "8" ; 18db5
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0F8h
; ---------------------- ; 18db6
loc_0x018DBB:

	LD A,#01h ; 18dbb
	LD [1B14h],A ; 18dbd

	LD A,#00h ; 18dc1
	LD [1B15h],A ; 18dc3

	XOR A,A ; 18dc7

	LD [1AE8h],A ; 18dc8
	LD [1B2Ah],A ; 18dcc

	RET

; ---------------------- ; 18dd0
	DB 0F2h, 0C3h, 0FEh, 0CEh, 0D1h, 23h, 1Bh, 0B0h ; 18dd1
	DB 28h, 0BCh, 12h, 1Bh ; 18dd9
	ASCII "8" ; 18ddd
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0F8h, 0A6h, 0A2h, 0A3h ; 18dde
	DB 0F2h, 0D6h, 00h, 0EEh ; 18de6
	ASCIZ "v" ; 18dea
	DB 0CEh, 0D0h, 0DBh, 1Ah, 28h, 0E7h, 19h, 0CEh ; 18dec
	DB 0D0h, 0DAh, 1Ah, 28h, 0E7h, 12h, 0CEh, 0D0h ; 18df4
	DB 0E7h, 1Ah, 22h, 1Ch, 0EEh, 81h, 00h, 0CEh ; 18dfc
	DB 0D0h, 0E3h, 1Ah, 28h, 0EEh ; 18e04
	ASCIZ "y" ; 18e09
	DB 0B8h, 91h, 1Bh, 0D0h, 10h, 0Eh, 0BCh, 91h ; 18e0b
	DB 1Bh, 0E5h, 0Eh, 0B8h, 93h, 1Bh, 0D4h, 00h ; 18e13
	DB 00h, 0EEh, 29h, 00h, 98h, 0BCh, 93h, 1Bh ; 18e1b
	DB 0F2h ; 18e23
	ASCIZ "n" ; 18e24
	DB 0C5h, 10h, 0Eh, 0BDh, 95h, 1Bh, 0C6h, 0FAh ; 18e26
	DB 1Ah, 0CEh, 0C6h, 00h, 0F2h, 0E1h, 0FCh, 0F2h ; 18e2e
	ASCIZ "k" ; 18e36
	DB 0CEh, 0D0h, 0FDh, 1Ah, 80h ; 18e38
	ASCII "2" ; 18e3d
	DB 18h, 0E4h, 02h ; 18e3e
	ASCII "8" ; 18e41
	DB 0CEh ; 18e42
	ASCII "D" ; 18e43
	DB 03h, 0F1h, 0A6h, 0F2h ; 18e44
	ASCIZ "J" ; 18e48
	DB 0B8h, 91h, 1Bh, 0C0h, 10h, 0Eh, 0BCh, 95h ; 18e4a
	DB 1Bh, 0C6h, 0FAh, 1Ah, 0CEh, 0C6h, 00h, 0F2h ; 18e52
	DB 0BAh, 0FCh, 0F2h ; 18e5a
	ASCIZ "D" ; 18e5d
	DB 0F1h, 2Fh, 0CEh, 0D0h, 83h, 1Bh ; 18e5f
	ASCII "2" ; 18e65
	DB 0FFh, 0E6h, 27h ; 18e66
	ASCII "8" ; 18e69
	DB 0CEh, 0D4h, 0DAh, 1Ah, 0CEh, 0D4h, 0DBh, 1Ah ; 18e6a
	DB 0CEh, 0D0h, 0E7h, 1Ah, 22h, 1Ch, 0E6h, 0Ah ; 18e72
	ASCII "8" ; 18e7a
	DB 0CEh, 0D4h, 0E3h, 1Ah, 0CEh, 0D4h, 0E4h, 1Ah ; 18e7b
	DB 0C4h, 00h, 00h, 0BCh, 01h, 1Bh, 0BCh, 04h ; 18e83
	DB 1Bh, 0BCh, 07h, 1Bh, 0ABh, 0AAh, 0AEh, 0F8h ; 18e8b
	DB 0B1h, 00h, 0CEh, 0D0h, 0DBh, 1Ah, 28h, 0E7h ; 18e93
	DB 02h, 81h, 0CEh, 0D5h ; 18e9b
	ASCII "l" ; 18e9f
	DB 1Bh, 0F8h, 0CEh, 0D0h ; 18ea0
	ASCII "l" ; 18ea4
	DB 1Bh ; 18ea5
	ASCII "2" ; 18ea6
	DB 02h, 0E7h, 14h, 0CEh, 0D0h, 0DBh, 1Ah, 28h ; 18ea7
	DB 0E7h, 0Dh, 0CEh, 0D0h, 0DAh, 1Ah, 28h, 0E6h ; 18eaf
	DB 06h, 88h, 0CEh, 0D4h, 0DAh, 1Ah, 0F8h, 0C6h ; 18eb7
	DB 0FAh, 1Ah, 0CEh, 0C6h, 00h, 0C5h, 8Ah, 1Bh ; 18ebf
	DB 0B1h, 07h ; 18ec7
	ASCII "n" ; 18ec9
	DB 92h, 91h, 0F5h, 0FCh, 0C6h, 0AAh, 15h, 0CEh ; 18eca
	DB 0C6h, 00h, 0F2h ; 18ed2
	ASCII "0" ; 18ed5
	DB 0B8h, 0C6h, 0AFh, 15h, 0CEh, 0C6h, 00h, 0CEh ; 18ed6
	DB 0C4h, 01h, 0F2h, 0Eh, 24h, 0C6h, 83h, 1Bh ; 18ede
	DB 0CEh, 40h, 00h ; 18ee6
	ASCII "2" ; 18ee9
	DB 0FFh, 0E6h, 5Fh, 28h, 0E7h, 5Ch, 0CEh, 40h ; 18eea
	DB 01h, 28h, 0E7h ; 18ef2
	ASCII "V" ; 18ef5
	DB 0CEh, 40h, 02h ; 18ef6
	ASCII "2" ; 18ef9
	DB 05h, 0E5h ; 18efa
	ASCII "O" ; 18efc
	DB 0B2h, 18h, 0CEh, 0D8h, 0CEh, 40h, 03h, 0B1h ; 18efd
	DB 00h, 0CFh, 20h, 0C4h, 3Ch, 00h, 0F2h, 0FFh ; 18f05
	DB 00h, 0BDh, 93h, 1Bh, 0CEh ; 18f0d
	ASCII "P" ; 18f12
	DB 04h, 0B3h, 00h, 0CFh, 01h, 0E5h, 08h, 0B9h ; 18f13
	DB 93h, 1Bh, 91h, 0BDh, 93h, 1Bh, 0C5h, 3Ch ; 18f1b
	DB 00h, 0F2h, 0E6h, 00h, 0BCh, 91h, 1Bh, 0B8h ; 18f23
	DB 93h, 1Bh, 0CFh, 20h, 0BDh, 93h, 1Bh, 0B8h ; 18f2b
	DB 91h, 1Bh, 0CEh ; 18f33
	ASCII "P" ; 18f36
	DB 05h, 0B3h, 00h, 0CFh, 01h, 0BCh, 91h, 1Bh ; 18f37
	DB 0E5h, 08h, 0B9h, 93h, 1Bh, 91h, 0BDh, 93h ; 18f3f
	DB 1Bh, 9Ch, 0FEh, 0F8h, 9Dh, 01h, 0F8h
; ---------------------- ; 18f47
loc_0x018F4E:

	PUSH IP ; 18f4e
	PUSH IX ; 18f4f

	LD IX,#1AFAh ; 18f50
	LD XP,#00h ; 18f53
	CARL loc_0x004706 ; 18f56

	POP IX ; 18f59
	POP IP ; 18f5a

	RET

; ---------------------- ; 18f5b
	DB 0CEh, 0D0h, 2Bh, 1Bh, 28h, 0E7h ; 18f5c
	ASCII "G" ; 18f62
	DB 0CEh, 0D0h, 0E3h, 1Ah, 0B2h, 04h, 0CEh, 0D8h ; 18f63
	DB 0CEh, 0D0h, 0E4h, 1Ah, 0B1h, 00h, 0CFh, 20h ; 18f6b
	DB 0B0h, 15h, 0CEh, 0D9h ; 18f73
	ASCII "J81" ; 18f77
	DB 0E6h, 2Eh, 0A0h, 0CEh, 0D1h, 0D7h, 1Ah, 0F2h ; 18f7a
	DB 2Ch, 00h, 0A8h, 0E6h, 04h, 80h, 0F1h, 0F0h ; 18f82
	DB 0CEh, 0D4h, 2Ch, 1Bh, 0F2h, 3Ah, 00h, 0B0h ; 18f8a
	DB 01h, 0CEh, 0D4h, 2Ah, 1Bh, 0B0h, 01h, 0CEh ; 18f92
	DB 0D4h, 0D8h, 1Ah, 0B0h, 00h, 0CEh, 0D4h, 14h ; 18f9a
	DB 1Bh ; 18fa2
	ASCII "8" ; 18fa3
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0F8h ; 18fa4
	ASCII "8" ; 18fa9
	DB 0CEh, 0D4h, 2Ah, 1Bh, 0F8h, 0CFh, 0B0h ; 18faa
	ASCIZ "A" ; 18fb1
	DB 0B1h, 00h, 0C5h, 0C3h, 1Ah, 0CFh, 20h, 0CFh ; 18fb3
	DB 0B4h, 0A1h, 0F2h, 19h, 94h, 0A9h, 28h, 0E7h ; 18fbb
	DB 05h ; 18fc3
	ASCII "A" ; 18fc4
	DB 91h, 23h, 0F8h, 23h, 0F8h, 0F2h, 0Ch, 94h ; 18fc5
	DB 0A0h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 0B1h, 00h ; 18fcd
	DB 0C5h, 0C3h, 1Ah, 0CFh, 20h, 0A8h, 28h, 0E7h ; 18fd5
	DB 05h, 91h ; 18fdd
	ASCII "A" ; 18fdf
	DB 0F1h, 01h, 0CEh, 2Ch, 0F8h, 0F2h, 05h, 00h ; 18fe0
	DB 0BCh, 0Bh, 1Bh, 0F8h, 0B8h, 0Bh, 1Bh, 0C5h ; 18fe8
	DB 05h, 40h, 0F2h, 18h, 00h, 0C5h, 0E1h, 0AEh ; 18ff0
	DB 0CFh, 01h, 0BCh, 0Bh, 1Bh, 0F8h, 90h, 0E6h ; 18ff8
	DB 0ECh, 0A0h, 0F2h, 0E8h, 0FFh, 0A9h, 0F2h, 04h ; 19000
	DB 00h, 0CFh, 0E1h, 0F8h, 0A6h, 0A2h, 0CEh, 0C6h ; 19008
	DB 00h, 0CFh, 0FAh, 0A1h, 0CEh, 0D8h, 0A1h, 0CEh ; 19010
	ASCII "P" ; 19018
	DB 0FFh, 0CEh, 0D8h, 0A1h, 0CEh ; 19019
	ASCII "P" ; 1901e
	DB 0FEh ; 1901f
	ASCII "A" ; 19020
	DB 0CEh, 0D8h, 0A1h, 0CEh ; 19021
	ASCII "P" ; 19025
	DB 0FFh, 0CEh, 0D8h, 0A1h, 0CEh, 40h, 0FAh, 0CEh ; 19026
	DB 00h, 0FDh, 0CEh ; 1902e
	ASCII "D" ; 19031
	DB 0FAh, 0CEh, 40h, 0FBh, 0Ah, 00h, 0CEh ; 19032
	ASCII "D" ; 19039
	DB 0FBh, 0CFh ; 1903a
	ASCII "p" ; 1903c
	DB 04h, 0CFh ; 1903d
	ASCII "q" ; 1903f
	DB 02h, 0CFh, 20h, 0CFh ; 19040
	ASCII "u" ; 19044
	DB 02h, 0CEh, 40h, 0F7h, 0Ah, 00h, 0CEh ; 19045
	ASCII "D" ; 1904c
	DB 0F7h, 0CEh, 40h, 0F6h, 0CEh, 00h, 0F9h ; 1904d
	ASCII "P" ; 19054
	DB 0CEh, 40h, 0F7h, 0Ah, 00h ; 19055
	ASCII "X" ; 1905a
	DB 0CEh ; 1905b
	ASCII "H" ; 1905c
	DB 0F8h, 0CEh, 40h, 0FCh, 0CFh ; 1905d
	ASCII "h" ; 19062
	DB 0Ah, 00h, 0AAh, 0AEh, 0F8h, 0A5h, 0A1h, 0A0h ; 19063
	DB 0CEh, 80h, 0B1h, 00h, 0CFh ; 1906b
	ASCII "q" ; 19070
	DB 05h, 0CFh, 20h, 0CFh ; 19071
	ASCII "p" ; 19075
	DB 07h, 0CEh, 8Ch, 0CEh, 0CDh ; 19076
	ASCII "C" ; 1907b
	DB 0CEh, 90h, 0CEh, 9Ch ; 1907c
	ASCII "X" ; 19080
	DB 0CFh, 0C1h, 0CFh ; 19081
	ASCII "u" ; 19084
	DB 05h, 0A8h, 0A9h, 0ADh, 0F8h, 0Dh, 04h, 1Eh ; 19085
	DB 80h ; 1908d
	ASCII "q" ; 1908e
	DB 03h, 80h ; 1908f
	ASCII "q" ; 19091
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 19092
	ASCIZ "m/" ; 19099
	DB 20h, 91h, 03h ; 1909c
	ASCII "M" ; 1909f
	DB 91h, 03h ; 190a0
	ASCII "M" ; 190a2
	DB 91h, 03h, 18h, 08h, 02h, 22h, 26h, 00h ; 190a3
	DB 0A0h ; 190ab
	ASCII "z" ; 190ac
	DB 03h, 0Ch, 08h, 0F2h ; 190ad
	ASCII "B" ; 190b1
	DB 91h, 0F2h, 83h, 92h, 0CEh, 0C4h, 02h, 0F2h ; 190b2
	DB 21h, 0Ah, 0CEh, 0C4h, 00h, 0F2h ; 190ba
	ASCII "8" ; 190c0
	DB 9Bh, 0CEh, 0C4h, 07h, 0F2h, 2Dh, 0F2h, 0C7h ; 190c1
	DB 8Ah, 90h, 0CEh, 0C7h, 01h, 0F2h, 0A2h, 9Ch ; 190c9
	DB 0B0h, 01h, 0CEh, 0D4h ; 190d1
	ASCII "M" ; 190d5
	DB 16h, 0C5h, 40h, 00h, 0C7h ; 190d6
	ASCII "u " ; 190db
	DB 0CEh, 0C4h, 02h, 0F2h, 0A2h, 0Ah, 0C5h, 40h ; 190dd
	DB 00h, 0C7h, 0A4h, 20h, 0CEh, 0C4h, 02h, 0F2h ; 190e5
	DB 96h, 0Ah, 0C5h, 40h, 00h, 0C7h, 3Bh, 20h ; 190ed
	DB 0CEh, 0C4h, 02h, 0F2h, 8Ah, 0Ah, 0C5h, 00h ; 190f5
	DB 00h, 0C7h, 0B3h, 21h, 0CEh, 0C4h, 02h, 0F2h ; 190fd
	DB 7Eh, 0Ah, 0C7h, 5Fh, 8Ch, 0CEh, 0C4h, 07h ; 19105
	DB 0F2h, 5Bh, 0F2h, 0C7h, 0AEh, 13h, 0CEh, 0C4h ; 1910d
	DB 02h, 0F2h ; 19115
	ASCII "l" ; 19117
	DB 0Ah, 0F2h, 24h, 92h, 0F2h, 0DDh, 90h, 0F8h ; 19118
	DB 0F2h, 0CFh, 0F8h, 0F2h, 21h, 92h, 0F8h, 0Dh ; 19120
	DB 04h, 3Eh, 00h ; 19128
	ASCII "l" ; 1912b
	DB 03h, 00h ; 1912c
	ASCII "l" ; 1912e
	DB 03h, 00h, 00h, 04h, 00h, 00h, 04h ; 1912f
	ASCIZ "m/" ; 19136
	DB 0AAh, 91h, 03h ; 19139
	ASCII "M" ; 1913c
	DB 91h, 03h, 00h, 00h, 00h, 18h, 08h, 04h ; 1913d
	ASCIZ "B&" ; 19145
	DB 00h, 7Bh, 03h, 0Ch, 08h, 0CEh, 0D0h, 0D8h ; 19148
	DB 1Ah, 0CEh, 0D4h ; 19150
	ASCII "m" ; 19153
	DB 1Bh, 0F2h, 9Dh, 90h, 0F2h, 0DEh, 91h, 0CEh ; 19154
	DB 0C4h, 02h, 0F2h, 7Ch, 09h, 0CEh, 0C4h, 00h ; 1915c
	DB 0F2h, 93h, 9Ah, 0CEh, 0C4h, 07h, 0F2h, 88h ; 19164
	DB 0F1h, 0C7h, 27h, 91h, 0CEh, 0C7h, 01h, 0F2h ; 1916c
	DB 0FDh, 9Bh, 0C5h, 00h, 00h, 0C7h, 3Dh, 23h ; 19174
	DB 0CEh, 0C4h, 02h, 0F2h, 03h, 0Ah, 0C5h, 00h ; 1917c
	DB 03h, 0C7h ; 19184
	ASCII "W" ; 19186
	DB 92h, 0CEh, 0C4h, 07h, 0F2h, 0DDh, 0F1h, 0C5h ; 19187
	DB 00h, 06h, 0C7h, 0E0h, 92h, 0CEh, 0C4h, 07h ; 1918f
	DB 0F2h, 0D1h, 0F1h, 0C7h, 0AEh, 13h, 0CEh, 0C4h ; 19197
	DB 02h, 0F2h, 0E2h, 09h, 0F2h, 9Ah, 91h, 0F2h ; 1919f
	ASCII "S" ; 191a7
	DB 90h, 0F8h, 0F2h ; 191a8
	ASCII "E" ; 191ab
	DB 0F8h, 0F2h, 97h, 91h, 0F8h, 0Dh, 04h, 3Eh ; 191ac
	DB 00h ; 191b4
	ASCII "P" ; 191b5
	DB 03h, 00h ; 191b6
	ASCII "W" ; 191b8
	DB 03h, 00h, 00h, 04h, 00h, 00h, 04h, 0CAh ; 191b9
	DB 2Fh, 00h, 3Ch, 92h, 03h, 0D7h, 91h, 03h ; 191c1
	DB 00h, 00h, 00h, 0Ch, 01h, 04h ; 191c9
	ASCIZ "B&" ; 191cf
	ASCII "8|" ; 191d2
	DB 03h, 0Ch, 08h ; 191d4
	ASCII "8" ; 191d7
	DB 0CEh, 0D4h, 2Dh, 1Bh, 0F2h, 16h, 90h, 0F2h ; 191d8
	ASCII "W" ; 191e0
	DB 91h, 0CEh, 0C4h, 02h, 0F2h, 0F5h, 08h, 0CEh ; 191e1
	DB 0C4h, 00h, 0F2h, 0Ch, 9Ah, 0CEh, 0C4h, 07h ; 191e9
	DB 0F2h, 01h, 0F1h, 0C7h, 0B1h, 91h, 0CEh, 0C7h ; 191f1
	DB 01h, 0F2h ; 191f9
	ASCII "v" ; 191fb
	DB 9Bh, 0B0h, 00h, 0F2h, 8Bh, 0F7h, 0C5h ; 191fc
	ASCII "L" ; 19203
	DB 0Ch, 0C7h, 3Dh, 0AAh, 0CEh, 0C7h, 00h, 0CEh ; 19204
	DB 0C4h, 02h, 0F2h, 0A1h, 0Ch, 0F2h ; 1920c
	ASCIZ "M" ; 19212
	DB 0C5h, 01h, 00h, 0C7h, 92h, 8Dh, 0CEh, 0C4h ; 19214
	DB 07h, 0F2h ; 1921c
	ASCII "K" ; 1921e
	DB 0F1h, 0C5h, 05h, 02h, 0C7h, 0C8h, 95h, 0CEh ; 1921f
	DB 0C4h, 07h, 0F2h, 3Fh, 0F1h, 0C7h, 0AEh, 13h ; 19227
	DB 0CEh, 0C4h, 02h, 0F2h ; 1922f
	ASCII "P" ; 19233
	DB 09h, 0F2h, 08h, 91h, 0F2h, 0C1h, 8Fh, 0F8h ; 19234
	DB 0F2h, 08h, 91h, 0F2h, 06h, 0FAh, 0CEh, 0D0h ; 1923c
	ASCII "C" ; 19244
	DB 16h, 96h, 03h, 0E6h, 16h, 0CEh, 0D0h, 0B6h ; 19245
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h ; 1924d
	DB 0FAh, 14h, 0C5h ; 19255
	ASCII "M" ; 19258
	DB 91h, 0B1h, 03h, 0F2h ; 19259
	ASCII "1" ; 1925d
	DB 90h, 0F8h, 0CEh, 0D0h, 0D7h, 1Ah, 00h, 0B1h ; 1925e
	DB 00h, 0C7h, 0A1h, 92h, 0CEh, 0C7h, 01h, 0CFh ; 19266
	ASCII "B" ; 1926e
	DB 0CFh, 0DBh, 0C5h, 91h, 13h, 0B1h, 05h ; 1926f
	ASCII "Gh" ; 19276
	DB 93h, 91h, 0F5h, 0FBh, 0CEh, 0D1h, 0DDh, 1Ah ; 19278
	DB 0C5h, 0C4h, 13h, 0F0h ; 19280
	ASCII "2" ; 19284
	DB 0CEh, 0D1h, 0DFh, 1Ah, 0C5h, 0DCh, 13h, 0F0h ; 19285
	DB 29h, 0CEh, 0D1h, 0E1h, 1Ah, 0C5h, 0F4h, 13h ; 1928d
	DB 0F0h, 20h, 0CEh, 0D1h, 0E3h, 1Ah, 0C5h, 0Ch ; 19295
	DB 14h, 0F0h, 17h, 0F8h, 0A7h, 92h, 0ACh, 92h ; 1929d
	DB 0B1h, 92h, 0A2h, 0A3h, 0A4h, 00h, 00h, 0A5h ; 192a5
	DB 0A6h, 0A7h, 00h, 00h, 0A8h, 0A9h, 0AAh, 0ABh ; 192ad
	DB 0ACh, 0CEh, 0BCh, 40h, 0E4h, 03h, 0B1h, 40h ; 192b5
	DB 0CFh, 0B1h, 0CEh, 8Dh, 0CEh, 8Dh, 0CEh, 8Dh ; 192bd
	DB 0CEh, 0BCh, 00h, 0E6h, 06h, 0B5h, 0Ch, 91h ; 192c5
	DB 0F5h, 0FCh, 0CFh, 0B4h, 22h, 07h, 28h, 0E6h ; 192cd
	DB 05h, 02h, 04h ; 192d5
	ASCII "h" ; 192d8
	DB 91h, 0F8h, 0Dh, 04h, 3Eh, 00h, 9Ch, 05h ; 192d9
	DB 00h, 9Ch, 05h, 00h, 80h, 05h, 00h, 80h ; 192e1
	DB 05h ; 192e9
	ASCIZ "m/" ; 192ea
	DB 9Bh, 93h, 03h, 0B5h, 86h, 03h, 0EAh, 9Eh ; 192ed
	DB 03h, 18h, 08h, 05h ; 192f5
	ASCIZ "B&" ; 192f9
	DB 98h, 7Ch, 03h, 0Ch, 08h, 0CEh, 0D0h, 0E9h ; 192fc
	DB 1Ah ; 19304
	ASCII "2" ; 19305
	DB 07h, 0E4h, 07h, 0B0h, 07h, 0CEh, 0D4h, 0E9h ; 19306
	DB 1Ah, 0F2h, 0E3h, 8Eh, 0F2h, 24h, 90h, 0CEh ; 1930e
	DB 0C4h, 02h, 0F2h, 0C2h, 07h, 0CEh, 0C4h, 00h ; 19316
	DB 0F2h, 0D9h, 98h, 0CEh, 0C4h, 07h, 0F2h, 0CEh ; 1931e
	DB 0EFh, 0C7h, 0DBh, 92h, 0CEh, 0C7h, 01h, 0F2h ; 19326
	ASCII "C" ; 1932e
	DB 9Ah, 0F2h, 0DFh, 00h, 0CEh, 0D0h, 0D6h, 1Ah ; 1932f
	DB 28h, 0E6h, 0Ah, 0C5h ; 19337
	ASCII "k" ; 1933b
	DB 16h, 0CEh, 2Dh, 0F7h, 0CEh, 2Dh, 02h, 0C5h ; 1933c
	DB 00h, 18h, 0C7h, 0B5h, 23h, 0CEh, 0C4h, 02h ; 19344
	DB 0F2h ; 1934c
	ASCII "6" ; 1934d
	DB 08h, 0C5h ; 1934e
	ASCII "X" ; 19350
	DB 18h, 0C7h, 0A3h, 23h, 0CEh, 0C4h, 02h, 0F2h ; 19351
	DB 2Ah, 08h, 0C5h, 10h, 18h, 0C7h ; 19359
	ASCII "p$" ; 1935f
	DB 0CEh, 0C4h, 02h, 0F2h, 1Eh, 08h, 0C5h, 40h ; 19361
	DB 18h, 0C7h, 0E5h, 24h, 0CEh, 0C4h, 02h, 0F2h ; 19369
	DB 12h, 08h, 0C5h, 28h, 18h, 0C7h, 26h, 25h ; 19371
	DB 0CEh, 0C4h, 02h, 0F2h, 06h, 08h, 0C5h, 04h ; 19379
	DB 06h, 0C7h, 0F7h, 93h, 0CEh, 0C4h, 07h, 0F2h ; 19381
	DB 0E0h, 0EFh, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h ; 19389
	DB 0F2h, 0F1h, 07h, 0F2h, 0A9h, 8Fh, 0F2h ; 19391
	ASCII "b" ; 19398
	DB 8Eh, 0F8h, 0CEh, 0D0h, 0D6h, 1Ah, 28h, 0EAh ; 19399
	ASCII "O" ; 193a1
	DB 0F6h, 0F2h, 0A1h, 8Fh, 0CEh, 0D0h ; 193a2
	ASCII "C" ; 193a8
	DB 16h, 96h, 01h, 0E7h, 2Ch, 96h, 02h, 0E6h ; 193a9
	DB 5Fh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 193b1
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 2Dh ; 193b9
	DB 8Fh, 0CEh, 0D0h, 0D6h, 1Ah, 28h, 0E6h ; 193c1
	ASCII "E" ; 193c8
	DB 0C5h, 2Ch, 0A4h, 0B1h, 03h ; 193c9
	ASCII "2" ; 193ce
	DB 0FFh, 0E6h, 3Ch, 0C5h, 1Ch, 0A5h, 0B1h, 03h ; 193cf
	DB 0F1h ; 193d7
	ASCII "5" ; 193d8
	DB 0CEh, 0D0h, 0D6h, 1Ah, 28h, 0E7h, 0Fh, 0CEh ; 193d9
	DB 0D0h, 0E9h, 1Ah, 0F2h, 0F2h, 8Fh, 0CEh, 0D1h ; 193e1
	DB 0EAh, 1Ah, 21h, 0E7h, 10h, 0CEh, 0D0h, 0B6h ; 193e9
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 03h, 0CEh, 0D4h ; 193f1
	DB 0FAh, 14h, 0F1h, 14h, 0CEh, 0D0h, 0B6h, 1Ah ; 193f9
	DB 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh ; 19401
	DB 14h, 0F2h, 0C8h, 8Eh, 0F2h, 80h, 8Eh, 0F8h ; 19409
	DB 0CEh, 0D0h, 0D7h, 1Ah, 00h, 00h, 02h, 14h ; 19411
	DB 0C5h ; 19419
	ASCII "z" ; 1941a
	DB 13h, 0B1h, 04h ; 1941b
	ASCII "h" ; 1941e
	DB 91h, 80h, 0F5h, 0FCh, 0F8h, 0Dh, 04h, 3Eh ; 1941f
	DB 00h, 9Ch, 05h, 00h, 9Ch, 05h, 00h, 80h ; 19427
	DB 05h, 00h, 80h, 05h, 0CAh, 2Fh, 00h, 40h ; 1942f
	DB 95h, 03h ; 19437
	ASCII "M" ; 19439
	DB 91h, 03h, 00h, 00h, 00h, 18h, 08h, 06h ; 1943a
	ASCIZ "B&" ; 19442
	DB 0F8h, 7Ch, 03h, 0Ch, 08h, 0F2h, 0A8h, 8Dh ; 19445
	DB 0F2h, 0E9h, 8Eh, 0CEh, 0C4h, 02h, 0F2h, 87h ; 1944d
	DB 06h, 0CEh, 0C4h, 00h, 0F2h, 9Eh, 97h, 0CEh ; 19455
	DB 0C4h, 07h, 0F2h, 93h, 0EEh, 0C7h, 24h, 94h ; 1945d
	DB 0F1h ; 19465
	ASCII "B" ; 19466
	DB 07h, 04h, 3Eh, 00h, 9Ch, 05h, 00h, 9Ch ; 19467
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h, 0CAh ; 1946f
	DB 2Fh, 00h ; 19477
	ASCII "G" ; 19479
	DB 95h, 03h, 15h, 9Eh, 03h, 00h, 00h, 00h ; 1947a
	DB 18h, 08h, 06h ; 19482
	ASCIZ "B&" ; 19485
	DB 0F8h, 7Ch, 03h, 0Ch, 08h, 0F2h ; 19488
	ASCII "e" ; 1948e
	DB 8Dh, 0F2h, 0A6h, 8Eh, 0CEh, 0C4h, 02h, 0F2h ; 1948f
	ASCII "D" ; 19497
	DB 06h, 0CEh, 0C4h, 00h, 0F2h, 5Bh, 97h, 0CEh ; 19498
	DB 0C4h, 07h, 0F2h ; 194a0
	ASCII "P" ; 194a3
	DB 0EEh, 0C7h ; 194a4
	ASCII "g" ; 194a6
	DB 94h, 0CEh, 0C7h, 01h, 0F2h, 0C5h, 98h ; 194a7
	ASCII "8" ; 194ae
	DB 0CEh, 0D4h, 2Ch, 1Bh, 0CEh, 0D0h, 0D7h, 1Ah ; 194af
	DB 0CEh, 0D4h, 97h, 1Bh, 0C5h, 00h, 18h, 0C7h ; 194b7
	DB 0B5h, 23h, 0CEh, 0C4h, 02h, 0F2h, 0BEh, 06h ; 194bf
	DB 0C5h ; 194c7
	ASCII "X" ; 194c8
	DB 18h, 0C7h, 0A3h, 23h, 0CEh, 0C4h, 02h, 0F2h ; 194c9
	DB 0B2h, 06h, 0C5h, 10h, 18h, 0C7h, 85h, 0CDh ; 194d1
	DB 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h, 0D0h ; 194d9
	DB 09h, 0C5h, 40h, 18h, 0C7h ; 194e1
	ASCII "f" ; 194e6
	DB 0CDh, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 194e7
	DB 0C1h, 09h, 0C5h, 28h, 18h, 0C7h ; 194ef
	ASCII "H" ; 194f5
	DB 0CDh, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 194f6
	DB 0B2h, 09h, 0C5h, 00h, 00h, 0C7h, 91h, 23h ; 194fe
	DB 0CEh, 0C4h, 02h, 0F2h ; 19506
	ASCII "y" ; 1950a
	DB 06h, 0C5h, 00h, 00h, 0C7h, 8Bh, 23h, 0CEh ; 1950b
	DB 0C4h, 02h, 0F2h ; 19513
	ASCII "m" ; 19516
	DB 06h, 0C5h, 04h, 06h, 0C7h, 3Eh, 94h, 0CEh ; 19517
	DB 0C4h, 07h, 0F2h ; 1951f
	ASCII "G" ; 19522
	DB 0EEh, 0C5h, 02h, 01h, 0C7h, 89h, 94h, 0CEh ; 19523
	DB 0C4h, 07h, 0F2h, 3Bh, 0EEh, 0C7h, 0AEh, 13h ; 1952b
	DB 0CEh, 0C4h, 02h, 0F2h ; 19533
	ASCII "L" ; 19537
	DB 06h, 0F2h, 04h, 8Eh, 0F2h, 0BDh, 8Ch, 0F8h ; 19538
	DB 0F2h, 0AFh, 0F4h, 0F2h, 01h, 8Eh, 0F8h, 0F2h ; 19540
	DB 0FDh, 8Dh, 0C5h, 97h, 1Bh, 0CEh, 0D0h ; 19548
	ASCII "E" ; 1954f
	DB 16h, 96h, 08h, 0E7h, 0Fh, 96h, 10h, 0E6h ; 19550
	DB 20h, 8Eh ; 19558
	ASCII "E2" ; 1955a
	DB 0FFh, 0E7h, 0Dh, 0B5h, 02h, 0F1h, 09h, 86h ; 1955c
	ASCII "E2" ; 19564
	DB 03h, 0E4h, 03h, 0B5h, 00h, 0CEh, 0D0h, 0B6h ; 19566
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 04h, 0CEh, 0D4h ; 1956e
	DB 0FAh, 14h, 0F8h, 0Dh, 04h, 3Eh, 00h, 0A4h ; 19576
	DB 05h, 00h, 0A4h, 05h, 00h, 80h, 05h, 00h ; 1957e
	DB 80h, 05h ; 19586
	ASCIZ "m/" ; 19588
	DB 0F4h, 95h, 03h ; 1958b
	ASCII "M" ; 1958e
	DB 91h, 03h, 0B8h, 86h, 03h, 18h, 08h, 04h ; 1958f
	ASCIZ "B&" ; 19597
	ASCII "X}" ; 1959a
	DB 03h, 0Ch, 08h ; 1959c
	ASCII "8" ; 1959f
	DB 0CEh, 0D4h, 80h, 1Bh, 0C5h, 0CBh, 1Ah, 0CEh ; 195a0
	ASCII "5" ; 195a8
	DB 0FFh, 0E6h, 05h, 91h, 80h, 0F1h, 0F8h, 0CEh ; 195a9
	DB 0D4h, 7Fh, 1Bh, 0F2h, 3Eh, 8Ch, 0F2h, 7Fh ; 195b1
	DB 8Dh, 0CEh, 0C4h, 02h, 0F2h, 1Dh, 05h, 0CEh ; 195b9
	DB 0C4h, 00h, 0F2h ; 195c1
	ASCII "4" ; 195c4
	DB 96h, 0CEh, 0C4h, 07h, 0F2h, 29h, 0EDh, 0C7h ; 195c5
	ASCII "y" ; 195cd
	DB 95h, 0CEh, 0C7h, 01h, 0F2h, 9Eh, 97h, 0F2h ; 195ce
	DB 5Eh, 00h, 0C5h, 00h, 08h, 0C7h, 7Bh, 25h ; 195d6
	DB 0CEh, 0C4h, 02h, 0F2h, 0A1h, 05h, 0C7h, 0AEh ; 195de
	DB 13h, 0CEh, 0C4h, 02h, 0F2h, 98h, 05h, 0F2h ; 195e6
	ASCII "P" ; 195ee
	DB 8Dh, 0F2h, 09h, 8Ch, 0F8h, 0F2h, 0FBh, 0F3h ; 195ef
	DB 0F2h ; 195f7
	ASCII "M" ; 195f8
	DB 8Dh, 0CEh, 0D0h ; 195f9
	ASCII "C" ; 195fc
	DB 16h, 96h, 01h, 0E7h, 17h, 96h, 02h, 0E6h ; 195fd
	DB 2Fh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 19605
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 0D9h ; 1960d
	DB 8Ch, 0F1h, 1Ah, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 19615
	DB 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h ; 1961d
	DB 0B0h, 04h, 0CEh, 0D4h, 15h, 1Bh, 0F2h, 0A4h ; 19625
	DB 0F7h, 0F2h, 0A4h, 8Ch, 0F2h, 5Ch, 8Ch, 0F8h ; 1962d
	DB 0C7h, 0CBh, 1Ah, 0CEh, 0C7h, 00h, 0C5h ; 19635
	ASCII "y" ; 1963c
	DB 13h ; 1963d
	ASCII "G2" ; 1963e
	DB 0FFh, 0E6h, 0Ah, 0F2h, 08h, 00h, 93h, 0C1h ; 19640
	DB 0Fh, 00h, 0F1h, 0F3h, 0F8h, 0A1h ; 19648
	ASCII "2" ; 1964e
	DB 1Eh, 0E4h, 05h, 12h, 1Eh, 0F1h, 0F9h ; 1964f
	ASCII "P" ; 19656
	DB 0B3h, 00h, 0B0h, 06h, 0CEh, 0D9h, 0CEh, 0D6h ; 19657
	ASCII "r" ; 1965f
	DB 1Bh, 0CEh, 0D7h ; 19660
	ASCII "s" ; 19663
	DB 1Bh ; 19664
	ASCII "B" ; 19665
	DB 0A9h, 0B5h, 04h, 91h, 0CEh, 0D0h ; 19666
	ASCII "r" ; 1966c
	DB 1Bh ; 1966d
	ASCIZ "H" ; 1966e
	DB 01h, 02h, 10h, 0B1h, 03h ; 19670
	ASCII "h" ; 19675
	DB 91h, 80h, 0F5h, 0FCh, 0B5h, 06h, 91h, 0B0h ; 19676
	DB 0Dh, 0B1h, 02h ; 1967e
	ASCII "h" ; 19681
	DB 91h, 80h, 0F5h, 0FCh, 0B5h, 00h, 91h, 0B5h ; 19682
	DB 05h, 91h, 0CEh, 0D0h ; 1968a
	ASCII "s" ; 1968e
	DB 1Bh, 02h, 20h ; 1968f
	ASCII "h" ; 19692
	DB 0F8h, 0Dh, 04h, 3Eh, 00h, 9Ch, 05h, 00h ; 19693
	DB 9Ch, 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 1969b
	ASCIZ "m/" ; 196a3
	DB 3Fh, 97h, 03h, 0B8h, 86h, 03h, 0BAh, 96h ; 196a6
	DB 03h, 18h, 08h, 01h ; 196ae
	ASCIZ "B&" ; 196b2
	ASCII "x" ; 196b5
	DB 81h, 03h, 0Ch, 08h, 0CEh, 0C4h, 01h, 0F2h ; 196b6
	DB 97h, 15h, 0B1h, 08h, 96h, 01h, 0E7h, 05h ; 196be
	DB 0CEh, 8Ch, 0F5h, 0F9h, 0CEh, 0BCh, 00h, 0E6h ; 196c6
	DB 06h, 0B0h, 08h, 11h, 0F1h, 0Ah, 0C5h ; 196ce
	ASCII "C" ; 196d5
	DB 0AAh, 0B1h, 03h, 0F2h, 0A1h, 8Bh, 0F8h, 0CEh ; 196d6
	DB 0D4h, 0E9h, 1Ah, 0F2h, 0F5h, 8Ch, 0C5h, 0EAh ; 196de
	DB 1Ah, 0CEh, 2Ch, 0F2h, 09h, 8Bh, 0F2h ; 196e6
	ASCII "J" ; 196ed
	DB 8Ch, 0CEh, 0C4h, 02h, 0F2h, 0E8h, 03h, 0CEh ; 196ee
	DB 0C4h, 00h, 0F2h, 0FFh, 94h, 0CEh, 0C4h, 07h ; 196f6
	DB 0F2h, 0F4h, 0EBh, 0C7h, 94h, 96h, 0CEh, 0C7h ; 196fe
	DB 01h, 0F2h ; 19706
	ASCII "i" ; 19708
	DB 96h, 0C5h, 28h, 08h, 0C7h ; 19709
	ASCII "3%" ; 1970e
	DB 0CEh, 0C4h, 02h, 0F2h ; 19710
	ASCII "o" ; 19714
	DB 04h, 0C5h, 04h, 04h, 0C7h, 0F7h, 93h, 0CEh ; 19715
	DB 0C4h, 07h, 0F2h ; 1971d
	ASCII "I" ; 19720
	DB 0ECh, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 19721
	ASCII "Z" ; 19729
	DB 04h, 0F2h, 12h, 8Ch, 0F2h, 0CBh, 8Ah, 0CEh ; 1972a
	DB 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 22h ; 19732
	DB 0CEh, 0D4h, 0FAh, 14h, 0F8h, 0F2h, 0B0h, 0F2h ; 1973a
	DB 0F2h, 02h, 8Ch, 0CEh, 0D0h ; 19742
	ASCII "C" ; 19747
	DB 16h, 96h, 01h, 0E7h, 14h, 96h, 02h, 0E6h ; 19748
	ASCII "E" ; 19750
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 19751
	DB 02h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 0Eh, 0CEh ; 19759
	DB 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h ; 19761
	DB 0CEh, 0D4h, 0FAh, 14h, 0CEh, 0C4h, 01h, 0F2h ; 19769
	DB 0E4h, 14h, 0E7h, 1Bh, 0CEh, 0D0h ; 19771
	ASCII "i" ; 19777
	DB 1Bh ; 19778
	ASCII "2" ; 19779
	DB 09h, 0E7h, 08h, 0C5h ; 1977a
	ASCII "C" ; 1977e
	DB 0AAh, 0B1h, 03h, 0F1h, 0Fh, 0F2h ; 1977f
	ASCII "h" ; 19785
	DB 8Bh, 0B0h, 0FFh, 0CEh, 0D4h ; 19786
	ASCII "i" ; 1978b
	DB 1Bh, 0F1h, 04h, 0F2h ; 1978c
	ASCII "C" ; 19790
	DB 8Bh, 0F2h, 0FBh, 8Ah, 0F8h, 07h, 04h, 3Eh ; 19791
	DB 00h ; 19799
	ASCII "R" ; 1979a
	DB 06h, 00h ; 1979b
	ASCII "R" ; 1979d
	DB 06h, 00h, 80h, 05h, 00h, 80h, 05h ; 1979e
	ASCIZ "m/" ; 197a5
	DB 16h, 98h, 03h ; 197a8
	ASCII "M" ; 197ab
	DB 91h, 03h, 00h, 00h, 00h, 18h, 08h, 07h ; 197ac
	ASCIZ "B&" ; 197b4
	ASCII "x~" ; 197b7
	DB 03h, 0Ch, 08h ; 197b9
	ASCII "8" ; 197bc
	DB 0CEh, 0D4h ; 197bd
	ASCII "n" ; 197bf
	DB 1Bh, 0F2h, 0F3h, 0AEh ; 197c0
	ASCII "8" ; 197c4
	DB 0CEh, 0D4h, 80h, 1Bh, 0C5h, 0CBh, 1Ah, 0CEh ; 197c5
	ASCII "5" ; 197cd
	DB 0FFh, 0E6h, 05h, 91h, 80h, 0F1h, 0F8h, 0CEh ; 197ce
	DB 0D4h, 7Fh, 1Bh, 0F2h, 19h, 8Ah, 0F2h ; 197d6
	ASCII "Z" ; 197dd
	DB 8Bh, 0CEh, 0C4h, 02h, 0F2h, 0F8h, 02h, 0CEh ; 197de
	DB 0C4h, 00h, 0F2h, 0Fh, 94h, 0CEh, 0C4h, 07h ; 197e6
	DB 0F2h, 04h, 0EBh, 0C7h, 96h, 97h, 0CEh, 0C7h ; 197ee
	DB 01h, 0F2h ; 197f6
	ASCII "y" ; 197f8
	DB 95h, 0C5h, 00h, 00h, 0C7h, 60h, 26h, 0CEh ; 197f9
	DB 0C4h, 02h, 0F2h, 7Fh, 03h, 0C7h, 0AEh, 13h ; 19801
	DB 0CEh, 0C4h, 02h, 0F2h ; 19809
	ASCII "v" ; 1980d
	DB 03h, 0F2h, 2Eh, 8Bh, 0F2h, 0E7h, 89h, 0F8h ; 1980e
	DB 0F2h, 2Eh, 8Bh, 0CEh, 0D0h ; 19816
	ASCII "C" ; 1981b
	DB 16h, 96h, 02h, 0E7h, 5Dh, 96h, 01h, 0E6h ; 1981c
	ASCII "l" ; 19824
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 19825
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0CEh, 0D0h ; 1982d
	ASCII "n" ; 19834
	DB 1Bh, 28h, 0E6h, 2Fh, 88h, 0E6h, 17h, 0C5h ; 19835
	DB 89h, 0EBh, 0B1h, 03h, 0CEh, 0D0h, 7Fh, 1Bh ; 1983d
	ASCII "2" ; 19845
	DB 05h, 0E4h, 06h, 0C5h, 0DEh, 9Bh, 0B1h, 03h ; 19846
	DB 0F2h, 3Fh, 8Ah, 0F8h, 0C5h, 0A6h, 9Ch, 0B1h ; 1984e
	DB 03h, 0CEh, 0D0h, 7Fh, 1Bh, 28h, 0E7h, 06h ; 19856
	DB 0C5h ; 1985e
	ASCII "R" ; 1985f
	DB 9Dh, 0B1h, 03h, 0F2h, 2Ah, 8Ah, 0F8h, 0CEh ; 19860
	DB 0D0h, 7Fh, 1Bh ; 19868
	ASCII "2" ; 1986b
	DB 05h, 0E4h, 08h, 0C5h, 0EDh, 9Bh, 0B1h, 03h ; 1986c
	DB 0F1h, 18h, 0C5h, 0B7h, 98h, 0B1h, 03h, 0F1h ; 19874
	DB 11h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1987c
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 19884
	ASCII "b" ; 1988b
	DB 8Ah, 0F2h, 00h, 8Ah, 0F8h, 07h, 04h, 3Eh ; 1988c
	DB 00h ; 19894
	ASCII "R" ; 19895
	DB 06h, 00h ; 19896
	ASCII "R" ; 19898
	DB 06h, 00h, 80h, 05h, 00h, 80h, 05h ; 19899
	ASCIZ "m/" ; 198a0
	DB 19h, 99h, 03h ; 198a3
	ASCII "u" ; 198a6
	DB 9Ah, 03h, 00h, 00h, 00h, 18h, 08h, 01h ; 198a7
	ASCIZ "B&" ; 198af
	DB 98h, 7Fh, 03h, 0Ch, 08h, 0F2h, 3Bh, 89h ; 198b2
	DB 0F2h, 7Ch, 8Ah, 0CEh, 0C4h, 02h, 0F2h, 1Ah ; 198ba
	DB 02h, 0CEh, 0C4h, 00h, 0F2h ; 198c2
	ASCII "1" ; 198c7
	DB 93h, 0CEh, 0C4h, 07h, 0F2h, 26h, 0EAh, 0C7h ; 198c8
	DB 91h, 98h, 0CEh, 0C7h, 01h, 0F2h, 9Bh, 94h ; 198d0
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0A4h ; 198d8
	DB 02h, 0F2h, 5Ch, 8Ah, 0F2h, 15h, 89h, 0F8h ; 198e0
	DB 0F2h, 5Ch, 8Ah, 0F8h, 0F2h ; 198e8
	ASCII "X" ; 198ed
	DB 8Ah, 0C5h, 00h, 9Bh, 0B1h, 03h, 0CEh, 0D0h ; 198ee
	ASCII "q" ; 198f6
	DB 1Bh, 28h, 0E6h, 13h, 0C6h, 0B8h, 80h, 0CEh ; 198f7
	DB 0C6h, 03h, 0F2h, 3Fh, 8Dh, 0C5h, 0A6h, 9Ah ; 198ff
	DB 0B1h, 03h, 0F2h ; 19907
	ASCII "q" ; 1990a
	DB 89h, 0F8h, 0F2h, 80h, 89h, 0C5h, 0E8h, 98h ; 1990b
	DB 0B1h, 03h, 0F2h ; 19913
	ASCII "e" ; 19916
	DB 89h, 0F8h, 0F2h, 2Bh, 8Ah, 0C5h ; 19917
	ASCII "k" ; 1991d
	DB 16h, 95h, 04h, 0E6h, 0F7h, 0F2h, 0D1h, 0C0h ; 1991e
	DB 0C5h ; 19926
	ASCII "H" ; 19927
	DB 9Ah, 0B1h, 03h, 0CEh, 0C4h, 00h, 0F2h ; 19928
	ASCII "9" ; 1992f
	DB 89h, 0B4h, 20h, 0DDh ; 19930
	ASCII "0" ; 19934
	DB 80h, 0C4h, 0FFh, 0FFh, 0BCh ; 19935
	ASCII "2 " ; 1993a
	DB 0DDh, 18h, 0Fh, 0D9h, 19h, 11h, 0D9h ; 1993c
	ASCII "0" ; 19943
	DB 02h, 0D8h, 23h, 00h, 0D8h, 24h, 03h, 0D8h ; 19944
	DB 25h, 00h, 0D8h, 26h, 0BFh, 0D8h, 80h, 0F1h ; 1994c
	DB 0D9h, 29h, 82h, 0D9h, 25h, 82h, 0D9h, 21h ; 19954
	DB 04h, 0DDh, 27h, 08h, 0D9h, 20h, 08h, 0D9h ; 1995c
	DB 23h, 08h, 0D9h ; 19964
	ASCII "0" ; 19967
	DB 04h, 0CFh, 0B9h, 0F2h, 3Ah ; 19968
	ASCII "U" ; 1996d
	DB 0F2h ; 1996e
	ASCII "dU" ; 1996f
	DB 0CEh, 0C5h, 00h, 0BDh ; 19971
	ASCII "o" ; 19975
	DB 1Bh, 0CEh, 0D4h ; 19976
	ASCII "q" ; 19979
	DB 1Bh, 0CFh, 0BDh, 0D8h, 25h, 7Dh, 0D8h, 21h ; 1997a
	DB 0F3h, 0F2h ; 19982
	ASCII "v" ; 19984
	DB 88h, 0CEh, 0D0h ; 19985
	ASCII "q" ; 19988
	DB 1Bh, 0F2h, 7Ch, 00h, 0CEh, 0D0h ; 19989
	ASCII "q" ; 1998f
	DB 1Bh ; 19990
	ASCIZ "2" ; 19991
	DB 0E6h ; 19993
	ASCII "82" ; 19994
	DB 0FFh, 0E6h ; 19996
	ASCII "L8" ; 19998
	DB 0CEh, 0D4h ; 1999a
	ASCII "q" ; 1999c
	DB 16h, 0F2h, 0A6h, 89h, 0CEh, 0D0h ; 1999d
	ASCII "B" ; 199a3
	DB 16h, 96h, 02h, 0E7h ; 199a4
	ASCII "3" ; 199a8
	DB 0CEh, 0D0h ; 199a9
	ASCII "q" ; 199ab
	DB 16h ; 199ac
	ASCII "2" ; 199ad
	DB 0Bh, 0E4h, 0EEh, 0C5h, 0FBh, 13h, 0B1h, 07h ; 199ae
	ASCII "8h" ; 199b6
	DB 99h, 0F5h, 0FDh, 0CEh, 0D0h, 0CAh, 1Bh ; 199b8
	ASCII "2" ; 199bf
	DB 0FFh, 0E6h, 19h, 0F2h, 81h, 89h, 0F2h, 2Ch ; 199c0
	DB 88h, 0F3h ; 199c8
	ASCII "z" ; 199ca
	DB 0FFh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 199cb
	DB 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 1Fh ; 199d3
	DB 0B0h, 0FEh, 0CEh, 0D4h ; 199db
	ASCII "q" ; 199df
	DB 1Bh, 0F2h, 25h, 00h, 0DCh ; 199e0
	ASCII "R" ; 199e5
	DB 80h, 0EAh, 9Eh, 8Fh, 0F1h, 0E1h, 0CEh, 0D0h ; 199e6
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh ; 199ee
	DB 0D4h, 0FAh, 14h, 0D8h, 23h, 0FBh, 0D8h, 20h ; 199f6
	DB 0F3h, 0C5h, 0ECh, 98h, 0B1h, 03h, 0F2h ; 199fe
	ASCII "v" ; 19a05
	DB 88h, 0F8h, 0F8h, 0CFh, 0B0h, 0C5h, 0FBh, 13h ; 19a06
	DB 22h, 0Fh, 02h, 90h ; 19a0e
	ASCII "h" ; 19a12
	DB 0CFh, 0B4h, 99h, 0F6h, 22h, 0Fh, 02h, 90h ; 19a13
	ASCII "h" ; 19a1b
	DB 99h, 99h, 0CEh, 0D0h ; 19a1c
	ASCII "o" ; 19a20
	DB 1Bh, 22h, 0Fh, 02h, 90h ; 19a21
	ASCII "h" ; 19a26
	DB 99h, 0CEh, 0D0h ; 19a27
	ASCII "o" ; 19a2a
	DB 1Bh, 0F6h, 22h, 0Fh, 02h, 90h ; 19a2b
	ASCII "h" ; 19a31
	DB 99h, 0CEh, 0D0h ; 19a32
	ASCII "p" ; 19a35
	DB 1Bh, 22h, 0Fh, 02h, 90h ; 19a36
	ASCII "h" ; 19a3b
	DB 99h, 0CEh, 0D0h ; 19a3c
	ASCII "p" ; 19a3f
	DB 1Bh, 0F6h, 22h, 0Fh, 02h, 90h ; 19a40
	ASCII "h" ; 19a46
	DB 0F8h, 0B0h, 0FFh, 0CEh, 0D4h, 0CAh, 1Bh, 0F8h ; 19a47
	DB 07h, 04h, 3Eh, 00h ; 19a4f
	ASCII "R" ; 19a53
	DB 06h, 00h ; 19a54
	ASCII "R" ; 19a56
	DB 06h, 00h, 80h, 05h, 00h, 80h, 05h ; 19a57
	ASCIZ "m/" ; 19a5e
	DB 0A6h, 9Ah, 03h, 0C1h, 97h, 03h, 00h, 00h ; 19a61
	DB 00h, 18h, 08h, 07h ; 19a69
	ASCIZ "B&" ; 19a6d
	DB 0B8h, 80h, 03h, 0Ch, 08h, 0F2h, 7Dh, 87h ; 19a70
	DB 0F2h, 0BEh, 88h, 0CEh, 0C4h, 02h, 0F2h, 5Ch ; 19a78
	DB 00h, 0CEh, 0C4h, 00h, 0F2h ; 19a80
	ASCII "s" ; 19a85
	DB 91h, 0CEh, 0C4h, 07h, 0F2h ; 19a86
	ASCII "h" ; 19a8b
	DB 0E8h, 0C7h ; 19a8c
	ASCII "O" ; 19a8e
	DB 9Ah, 0CEh, 0C7h, 01h, 0F2h, 0DDh, 92h, 0C7h ; 19a8f
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0E6h, 00h ; 19a97
	DB 0F2h, 9Eh, 88h, 0F2h ; 19a9f
	ASCII "W" ; 19aa3
	DB 87h, 0F8h, 0F2h, 9Eh, 88h, 0CEh, 0D0h ; 19aa4
	ASCII "C" ; 19aab
	DB 16h, 96h, 01h, 0E7h, 14h, 96h, 02h, 0E6h ; 19aac
	DB 25h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 19ab4
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 0Eh ; 19abc
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 19ac4
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0C1h, 97h ; 19acc
	DB 0B1h, 03h, 0F2h, 0B7h, 87h, 0F8h, 07h, 04h ; 19ad4
	DB 3Eh, 00h, 0A4h, 05h, 00h, 0A4h, 05h, 00h ; 19adc
	DB 80h, 05h, 00h, 80h, 05h ; 19ae4
	ASCIZ "m/" ; 19ae9
	ASCII "L" ; 19aec
	DB 9Bh, 03h, 00h, 00h, 00h, 0C1h, 97h, 03h ; 19aed
	DB 18h, 08h, 07h ; 19af5
	ASCIZ "B&" ; 19af8
	DB 18h, 81h, 03h, 0Ch, 08h, 0CEh, 0D0h ; 19afb
	ASCII "o" ; 19b02
	DB 1Bh, 0CEh, 0D1h ; 19b03
	ASCII "p" ; 19b06
	DB 1Bh, 01h ; 19b07
	ASCII "2" ; 19b09
	DB 1Eh, 0E4h, 05h, 12h, 1Eh, 0F1h, 0F9h, 0CEh ; 19b0a
	DB 0D4h, 0C9h, 1Bh, 0F2h, 89h, 00h, 0F2h, 0DAh ; 19b12
	DB 86h, 0F2h, 1Bh, 88h, 0CEh, 0C4h, 02h, 0F2h ; 19b1a
	DB 0B9h, 0FFh, 0CEh, 0C4h, 00h, 0F2h, 0D0h, 90h ; 19b22
	DB 0CEh, 0C4h, 07h, 0F2h, 0C5h, 0E7h, 0C7h, 0DAh ; 19b2a
	DB 9Ah, 0CEh, 0C7h, 01h, 0F2h, 3Ah, 92h, 0F2h ; 19b32
	ASCIZ "C" ; 19b3a
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 40h ; 19b3c
	DB 00h, 0F2h, 0F8h, 87h, 0F2h, 0B1h, 86h, 0F8h ; 19b44
	DB 0F2h, 0F8h, 87h, 0CEh, 0D0h ; 19b4c
	ASCII "C" ; 19b51
	DB 16h, 96h, 01h, 0E7h, 14h, 96h, 02h, 0E6h ; 19b52
	DB 23h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 19b5a
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 0Eh ; 19b62
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 19b6a
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 5Bh, 87h ; 19b72
	DB 0F2h, 13h, 87h, 0F8h, 0CEh, 0D0h, 0C9h, 1Bh ; 19b7a
	DB 0C5h, 0C1h, 13h, 0F2h, 0C6h, 0FAh, 0F8h, 0CEh ; 19b82
	DB 0D0h, 80h, 1Bh, 0B1h, 00h, 0C5h, 0CBh, 1Ah ; 19b8a
	DB 0CFh, 20h ; 19b92
	ASCII "E" ; 19b94
	DB 99h ; 19b95
	ASCII "h" ; 19b96
	DB 91h ; 19b97
	ASCII "2" ; 19b98
	DB 0FFh, 0E6h, 04h, 91h, 0F1h, 0F6h, 0F8h, 0CEh ; 19b99
	DB 0D0h, 80h, 1Bh, 28h, 0E3h, 0E3h, 0C5h, 0CBh ; 19ba1
	DB 1Ah, 0CEh ; 19ba9
	ASCII "5" ; 19bab
	DB 0FFh, 0E6h, 04h, 91h, 0F1h, 0F9h, 0CEh, 0D0h ; 19bac
	DB 0C9h, 1Bh ; 19bb4
	ASCII "h" ; 19bb6
	DB 0F8h, 07h, 04h, 3Eh, 00h, 0A4h, 05h, 00h ; 19bb7
	DB 0A4h, 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 19bbf
	ASCIZ "m/" ; 19bc7
	ASCII "U" ; 19bca
	DB 9Ch, 03h, 0C1h, 97h, 03h, 0B7h, 98h, 03h ; 19bcb
	DB 18h, 08h, 07h ; 19bd3
	ASCIZ "B&" ; 19bd6
	ASCII "X}" ; 19bd9
	DB 03h, 0Ch, 08h, 0F2h, 11h, 00h, 0C5h, 89h ; 19bdb
	DB 0EBh, 0B1h, 03h, 0CEh, 0C4h, 00h, 0F2h, 0DCh ; 19be3
	DB 86h, 0F8h, 0F2h, 02h, 00h, 0F8h ; 19beb
	ASCII "8" ; 19bf1
	DB 0CEh, 0D4h, 80h, 1Bh, 0C5h, 0CBh, 1Ah, 0CEh ; 19bf2
	ASCII "5" ; 19bfa
	DB 0FFh, 0E6h, 05h, 91h, 80h, 0F1h, 0F8h, 0CEh ; 19bfb
	DB 0D4h, 7Fh, 1Bh, 0F2h, 0ECh, 85h, 0F2h, 2Dh ; 19c03
	DB 87h, 0CEh, 0C4h, 02h, 0F2h, 0CBh, 0FEh, 0CEh ; 19c0b
	DB 0C4h, 00h, 0F2h, 0E2h, 8Fh, 0CEh, 0C4h, 07h ; 19c13
	DB 0F2h, 0D7h, 0E6h, 0C7h, 0B8h, 9Bh, 0CEh, 0C7h ; 19c1b
	DB 01h, 0F2h ; 19c23
	ASCII "L" ; 19c25
	DB 91h, 0F2h, 0Ch, 0FAh, 0F2h, 2Dh, 00h, 0C5h ; 19c26
	DB 00h, 00h, 0C7h, 1Fh, 26h, 0CEh, 0C4h, 02h ; 19c2e
	DB 0F2h ; 19c36
	ASCII "L" ; 19c37
	DB 0FFh, 0C5h, 00h, 06h, 0C7h, 0F2h, 94h, 0CEh ; 19c38
	DB 0C4h, 07h, 0F2h, 26h, 0E7h, 0C7h, 0AEh, 13h ; 19c40
	DB 0CEh, 0C4h, 02h, 0F2h ; 19c48
	ASCII "7" ; 19c4c
	DB 0FFh, 0F2h, 0EFh, 86h, 0F2h, 0A8h, 85h, 0F8h ; 19c4d
	DB 0F2h, 0EFh, 86h, 0F8h, 0C5h ; 19c55
	ASCII "a" ; 19c5a
	DB 13h, 0B1h, 0Ah, 0B5h, 00h, 91h, 0F5h, 0FCh ; 19c5b
	DB 0C5h, 0F0h, 13h, 0C7h, 0B8h, 7Dh, 0CEh, 0C7h ; 19c63
	DB 03h, 0B1h, 02h, 0CFh, 0B1h, 0B1h, 0Ch ; 19c6b
	ASCII "Gh" ; 19c72
	DB 93h, 91h, 0F5h, 0FBh, 0C1h, 0Ch, 00h, 0CFh ; 19c74
	DB 0B5h, 0F5h, 0F0h, 0F8h, 07h, 04h, 3Eh, 00h ; 19c7c
	DB 0A4h, 05h, 00h, 0A4h, 05h, 00h, 80h, 05h ; 19c84
	DB 00h, 80h, 05h ; 19c8c
	ASCIZ "m/" ; 19c8f
	DB 01h, 9Dh, 03h, 0C1h, 97h, 03h ; 19c92
	ASCII "I" ; 19c98
	DB 0E9h, 03h, 18h, 08h, 07h ; 19c99
	ASCIZ "B&" ; 19c9e
	ASCII "X}" ; 19ca1
	DB 03h, 0Ch, 08h, 0B0h, 01h, 0CEh, 0D4h, 80h ; 19ca3
	DB 1Bh, 0C5h, 0CBh, 1Ah, 0B0h, 00h, 0CEh ; 19cab
	ASCII "5" ; 19cb2
	DB 0FFh, 0E6h, 05h, 91h, 80h, 0F1h, 0F8h, 0CEh ; 19cb3
	DB 0D4h, 7Fh, 1Bh, 0F2h ; 19cbb
	ASCII "4" ; 19cbf
	DB 85h, 0F2h ; 19cc0
	ASCII "u" ; 19cc2
	DB 86h, 0CEh, 0C4h, 02h, 0F2h, 13h, 0FEh, 0CEh ; 19cc3
	DB 0C4h, 00h, 0F2h, 2Ah, 8Fh, 0CEh, 0C4h, 07h ; 19ccb
	DB 0F2h, 1Fh, 0E6h, 0C7h, 80h, 9Ch, 0CEh, 0C7h ; 19cd3
	DB 01h, 0F2h, 94h, 90h, 0F2h ; 19cdb
	ASCII "T" ; 19ce0
	DB 0F9h, 0F2h, 21h, 00h, 0C5h, 00h, 00h, 0C7h ; 19ce1
	DB 25h, 26h, 0CEh, 0C4h, 02h, 0F2h, 94h, 0FEh ; 19ce9
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 8Bh ; 19cf1
	DB 0FEh, 0F2h ; 19cf9
	ASCII "C" ; 19cfb
	DB 86h, 0F2h, 0FCh, 84h, 0F8h, 0F2h ; 19cfc
	ASCII "C" ; 19d02
	DB 86h, 0F8h, 0C5h ; 19d03
	ASCII "a" ; 19d06
	DB 13h, 0B1h, 0Ah, 0B5h, 00h, 91h, 0F5h, 0FCh ; 19d07
	DB 0C5h, 0F0h, 13h, 0C7h, 00h, 7Eh, 0CEh, 0C7h ; 19d0f
	DB 03h, 0B1h, 02h, 0CFh, 0B1h, 0B1h, 0Ch ; 19d17
	ASCII "Gh" ; 19d1e
	DB 93h, 91h, 0F5h, 0FBh, 0C1h, 0Ch, 00h, 0CFh ; 19d20
	DB 0B5h, 0F5h, 0F0h, 0F8h, 07h, 04h, 3Eh, 00h ; 19d28
	DB 0A4h, 05h, 00h, 0A4h, 05h, 00h, 80h, 05h ; 19d30
	DB 00h, 80h, 05h ; 19d38
	ASCIZ "m/" ; 19d3b
	DB 86h, 9Dh, 03h, 0C1h, 97h, 03h, 00h, 00h ; 19d3e
	DB 00h, 18h, 08h, 07h ; 19d46
	ASCIZ "B&" ; 19d4a
	ASCII "X}" ; 19d4d
	DB 03h, 0Ch, 08h, 0F2h, 0A0h, 84h, 0F2h, 0E1h ; 19d4f
	DB 85h, 0CEh, 0C4h, 02h, 0F2h, 7Fh, 0FDh, 0CEh ; 19d57
	DB 0C4h, 00h, 0F2h, 96h, 8Eh, 0CEh, 0C4h, 07h ; 19d5f
	DB 0F2h, 8Bh, 0E5h, 0C7h, 2Ch, 9Dh, 0CEh, 0C7h ; 19d67
	DB 01h, 0F2h, 00h, 90h, 0F2h ; 19d6f
	ASCIZ "H" ; 19d74
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 06h ; 19d76
	DB 0FEh, 0F2h, 0BEh, 85h, 0F2h ; 19d7e
	ASCII "w" ; 19d83
	DB 84h, 0F8h, 0F2h, 0BEh, 85h, 0CEh, 0D0h ; 19d84
	ASCII "C" ; 19d8b
	DB 16h, 96h, 01h, 0E7h, 19h, 96h, 02h, 0E6h ; 19d8c
	DB 28h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 19d94
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 19d9c
	ASCII "J" ; 19da3
	DB 85h, 0F1h, 13h, 0F1h, 14h, 0CEh, 0D0h, 0B6h ; 19da4
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h ; 19dac
	DB 0FAh, 14h, 0F2h ; 19db4
	ASCII "6" ; 19db7
	DB 85h, 0F2h, 0D4h, 84h, 0F8h, 0C5h ; 19db8
	ASCII "a" ; 19dbe
	DB 13h, 0B1h, 0Ah, 0B5h, 00h, 91h, 0F5h, 0FCh ; 19dbf
	DB 0C5h, 0F0h, 13h, 0C7h, 0D0h, 7Dh, 0CEh, 0C7h ; 19dc7
	DB 03h, 0B1h, 02h, 0CFh, 0B1h, 0B1h, 0Ch ; 19dcf
	ASCII "Gh" ; 19dd6
	DB 93h, 91h, 0F5h, 0FBh, 0C1h, 0Ch, 00h, 0CFh ; 19dd8
	DB 0B5h, 0F5h, 0F0h, 0F8h, 07h, 04h, 3Eh, 00h ; 19de0
	ASCII "J" ; 19de8
	DB 06h, 00h ; 19de9
	ASCII "N" ; 19deb
	DB 06h, 00h, 00h, 06h, 00h, 00h, 06h ; 19dec
	ASCIZ "03" ; 19df3
	DB 5Eh, 9Eh, 03h, 15h, 9Eh, 03h, 0C2h, 0E1h ; 19df6
	DB 03h, 18h, 08h, 02h ; 19dfe
	ASCIZ "B&" ; 19e02
	DB 18h, 7Eh, 03h, 0Ch, 08h, 0CEh, 0C4h, 00h ; 19e05
	DB 0F2h ; 19e0d
	ASCII "n" ; 19e0e
	DB 8Ah ; 19e0f
	ASCII "8" ; 19e10
	DB 0CEh, 0D4h ; 19e11
	ASCII "D" ; 19e13
	DB 1Bh, 0F2h, 0FCh, 0ACh, 0F2h, 9Ch, 0A8h, 0F2h ; 19e14
	DB 0D7h, 83h, 0F2h, 18h, 85h, 0CEh, 0C4h, 02h ; 19e1c
	DB 0F2h, 0B6h, 0FCh, 0CEh, 0C4h, 00h, 0F2h, 0CDh ; 19e24
	DB 8Dh, 0CEh, 0C4h, 07h, 0F2h, 0C2h, 0E4h, 0C7h ; 19e2c
	DB 0E4h, 9Dh, 0CEh, 0C7h, 01h, 0F2h ; 19e34
	ASCII "7" ; 19e3a
	DB 8Fh, 0C5h, 0D1h, 15h, 0BDh ; 19e3b
	ASCII "m" ; 19e40
	DB 16h, 0C5h, 00h ; 19e41
	ASCII "0" ; 19e44
	DB 0C7h, 0EBh, 26h, 0CEh, 0C4h, 02h, 0F2h ; 19e45
	ASCII "7" ; 19e4c
	DB 0FDh, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 19e4d
	DB 2Eh, 0FDh, 0F2h, 0E6h, 84h, 0F2h, 9Fh, 83h ; 19e55
	DB 0F8h, 0F2h, 0E6h, 84h, 0CEh, 0D0h ; 19e5d
	ASCII "C" ; 19e63
	DB 16h, 96h, 04h, 0E6h, 10h, 0CEh, 0D0h, 0CAh ; 19e64
	DB 1Ah, 12h, 01h, 0E5h, 03h, 0B0h, 02h, 0CEh ; 19e6c
	DB 0D4h, 0CAh, 1Ah, 0F8h, 96h, 01h, 0E6h ; 19e74
	ASCII "H" ; 19e7b
	DB 0CEh, 0D0h, 0C9h, 1Ah ; 19e7c
	ASCIZ "2" ; 19e80
	DB 0E6h, 15h, 88h, 0E6h, 23h, 88h, 0E6h, 08h ; 19e82
	DB 0C5h, 00h, 0A6h, 0B1h, 03h, 0F1h, 23h, 0C5h ; 19e8a
	DB 8Dh, 94h, 0B1h, 03h, 0F1h, 1Ch, 0F2h, 3Ah ; 19e92
	DB 84h, 0CEh, 0D0h, 0D6h, 1Ah, 28h, 0E7h, 12h ; 19e9a
	DB 0C5h ; 19ea2
	ASCII "9" ; 19ea3
	DB 86h, 0B1h, 03h, 0F1h, 0Bh ; 19ea4
	ASCII "8" ; 19ea9
	DB 0CEh, 0D4h ; 19eaa
	ASCII "6" ; 19eac
	DB 1Bh, 0C5h, 0EFh, 80h, 0B1h, 03h, 0F2h, 0DAh ; 19ead
	DB 83h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 19eb5
	DB 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0F8h, 0Dh ; 19ebd
	DB 04h, 3Eh, 00h ; 19ec5
	ASCII "P" ; 19ec8
	DB 03h, 00h ; 19ec9
	ASCII "W" ; 19ecb
	DB 03h, 00h, 00h, 07h, 00h, 00h, 07h, 0CAh ; 19ecc
	DB 2Fh, 00h, 0B9h, 9Fh, 03h, 0B5h, 86h, 03h ; 19ed4
	DB 00h, 00h, 00h, 18h, 08h, 01h ; 19edc
	ASCIZ "B&" ; 19ee2
	DB 0E0h ; 19ee5
	ASCII "y" ; 19ee6
	DB 03h, 0Ch, 08h ; 19ee7
	ASCII "8" ; 19eea
	DB 0CEh, 0D4h, 3Fh, 1Bh, 0CEh, 0D4h, 40h, 1Bh ; 19eeb
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0F2h, 0FBh, 82h, 0F2h ; 19ef3
	DB 3Ch, 84h, 0CEh, 0C4h, 02h, 0F2h, 0DAh, 0FBh ; 19efb
	DB 0CEh, 0C4h, 00h, 0F2h, 0F1h, 8Ch, 0CEh, 0C4h ; 19f03
	DB 07h, 0F2h, 0E6h, 0E3h, 0C7h, 0C4h, 9Eh, 0CEh ; 19f0b
	DB 0C7h, 01h, 0F2h, 5Bh, 8Eh, 0CEh, 0D0h, 0E9h ; 19f13
	DB 1Ah, 0CEh, 0C4h, 02h, 0F2h ; 19f1b
	ASCII "U" ; 19f20
	DB 05h ; 19f21
	ASCII "2" ; 19f22
	DB 05h, 0E7h, 09h, 0C5h, 27h ; 19f23
	ASCII "0" ; 19f28
	DB 0B1h, 00h, 0F2h, 16h, 83h, 0CEh, 0D0h, 0D7h ; 19f29
	DB 1Ah ; 19f31
	ASCIZ "H" ; 19f32
	DB 01h, 0B1h, 00h, 0C7h, 0A9h, 9Fh, 0CEh, 0C7h ; 19f34
	DB 01h, 0CFh ; 19f3c
	ASCII "B" ; 19f3e
	DB 0CFh, 0D8h, 0BCh ; 19f3f
	ASCII "4" ; 19f42
	DB 16h, 0BCh ; 19f43
	ASCII "7" ; 19f45
	DB 16h, 0CEh ; 19f46
	ASCII "A" ; 19f48
	DB 02h, 0CEh, 0D4h ; 19f49
	ASCII "6" ; 19f4c
	DB 16h, 0CEh, 0D4h ; 19f4d
	ASCII "9" ; 19f50
	DB 16h, 0F2h, 0BFh, 00h, 0C5h ; 19f51
	ASCII "K-" ; 19f56
	DB 0C7h ; 19f58
	ASCII "u'" ; 19f59
	DB 0CEh, 0C4h, 02h, 0F2h, 24h, 0FCh, 0C5h, 01h ; 19f5b
	DB 00h, 0C7h, 92h, 8Dh, 0CEh, 0C4h, 07h, 0F2h ; 19f63
	DB 0FEh, 0E3h, 0C5h, 00h, 01h, 0C7h, 3Dh, 8Eh ; 19f6b
	DB 0CEh, 0C4h, 07h, 0F2h, 0F2h, 0E3h, 0C5h, 05h ; 19f73
	DB 03h, 0C7h, 0F4h, 8Dh, 0CEh, 0C4h, 07h, 0F2h ; 19f7b
	DB 0E6h, 0E3h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h ; 19f83
	DB 0F2h, 0F7h, 0FBh, 0F2h, 0AFh, 83h, 0F2h ; 19f8b
	ASCII "h" ; 19f92
	DB 82h, 0CEh, 0D0h, 0E9h, 1Ah, 0CEh, 0C4h, 02h ; 19f93
	DB 0F2h, 0D9h, 04h ; 19f9b
	ASCII "2" ; 19f9e
	DB 01h, 0E7h, 07h, 0B0h, 0Ah, 0CEh, 0D4h, 0F4h ; 19f9f
	DB 14h, 0F8h, 00h, 00h, 07h, 00h, 40h, 07h ; 19fa7
	DB 00h, 80h, 07h, 0F2h, 3Dh, 0EAh, 0F2h, 8Fh ; 19faf
	DB 83h, 0F8h, 0F2h ; 19fb7
	ASCII "6" ; 19fba
	DB 0EAh, 0F2h, 88h, 83h, 0B9h, 1Fh, 16h, 0D5h ; 19fbb
	DB 0B9h, 9Fh, 0E7h ; 19fc3
	ASCII "L" ; 19fc6
	DB 0C5h, 3Fh, 1Bh ; 19fc7
	ASCII "E(" ; 19fca
	DB 0E6h, 04h, 8Eh, 0E7h, 13h, 0CEh, 0C4h, 01h ; 19fcc
	DB 0F2h ; 19fd4
	ASCII "p" ; 19fd5
	DB 0Ah, 0E7h, 0Bh, 0C5h, 0B2h, 9Fh, 0B1h, 03h ; 19fd6
	DB 0F2h, 9Ch, 82h, 0F1h, 09h, 0CEh, 0D0h ; 19fde
	ASCII "C" ; 19fe5
	DB 16h, 96h, 02h, 0E6h, 28h, 0CEh, 0D0h, 0E9h ; 19fe6
	DB 1Ah, 0CEh, 0C4h, 02h, 0F2h, 82h, 04h ; 19fee
	ASCII "2" ; 19ff5
	DB 06h, 0E7h, 07h, 0B0h, 2Ch, 0CEh, 0D4h, 13h ; 19ff6
	DB 1Bh, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 19ffe
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 0E0h ; 1a006
	DB 82h, 0F2h, 7Eh, 82h, 0F8h, 0CEh, 0D0h, 0E9h ; 1a00e
	DB 1Ah, 0CEh, 0C4h, 02h, 0F2h ; 1a016
	ASCII "Z" ; 1a01b
	DB 04h ; 1a01c
	ASCII "2" ; 1a01d
	DB 06h, 0EEh, 9Ah, 00h ; 1a01e
	ASCII "2" ; 1a022
	DB 01h, 0E6h ; 1a023
	ASCIZ "P2" ; 1a025
	DB 0EEh, 0C8h, 00h ; 1a028
	ASCII "2" ; 1a02b
	DB 02h, 0EEh, 0F1h, 00h ; 1a02c
	ASCII "2" ; 1a030
	DB 04h, 0EEh, 17h, 01h ; 1a031
	ASCII "2" ; 1a035
	DB 05h, 0EEh ; 1a036
	ASCII "a" ; 1a038
	DB 01h ; 1a039
	ASCII "2" ; 1a03a
	DB 07h, 0EEh, 98h, 01h ; 1a03b
	ASCII "2" ; 1a03f
	DB 03h, 0EEh, 01h, 00h, 0C5h, 00h, 00h, 0BDh ; 1a040
	ASCII "9" ; 1a048
	DB 1Bh, 0C5h, 00h, 00h, 0C7h ; 1a049
	ASCII "E" ; 1a04e
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a04f
	ASCII "Y" ; 1a057
	DB 0FEh, 0C5h ; 1a058
	ASCII "P" ; 1a05a
	DB 1Bh, 0C7h, 00h ; 1a05b
	ASCII "h" ; 1a05e
	DB 0CEh, 0C4h, 02h, 0F2h, 20h, 0FBh, 0C5h, 40h ; 1a05f
	DB 2Ch, 0BDh, 12h, 1Bh, 0C7h, 90h ; 1a067
	ASCII "m" ; 1a06d
	DB 0CEh, 0C4h, 02h, 0F2h, 11h, 0FBh, 0F8h, 0C5h ; 1a06e
	DB 00h, 00h, 0C7h ; 1a076
	ASCII "E" ; 1a079
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a07a
	DB 2Eh, 0FEh, 0C5h, 40h, 10h, 0BDh, 12h, 1Bh ; 1a082
	DB 0C7h ; 1a08a
	ASCII "SN" ; 1a08b
	DB 0CEh, 0C4h, 02h, 0F2h, 0F2h, 0FAh, 0C5h, 28h ; 1a08d
	DB 2Ch, 0BDh, 12h, 1Bh, 0C7h ; 1a095
	ASCII "oO" ; 1a09a
	DB 0CEh, 0C4h, 02h, 0F2h, 0E3h, 0FAh, 0C5h, 07h ; 1a09c
	DB 19h, 0C7h, 89h ; 1a0a4
	ASCII "O" ; 1a0a7
	DB 0CEh, 0C4h, 02h, 0F2h, 0D7h, 0FAh, 0C5h, 07h ; 1a0a8
	DB 19h, 0C7h, 95h ; 1a0b0
	ASCII "O" ; 1a0b3
	DB 0CEh, 0C4h, 02h, 0F2h, 0CBh, 0FAh, 0F8h, 0C5h ; 1a0b4
	DB 00h, 00h, 0C7h ; 1a0bc
	ASCII "E" ; 1a0bf
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a0c0
	DB 0E8h, 0FDh, 0C5h, 20h, 0Fh, 0C7h, 0F7h ; 1a0c8
	ASCII "J" ; 1a0cf
	DB 0CEh, 0C4h, 02h, 0F2h, 0AFh, 0FAh, 0C5h, 20h ; 1a0d0
	DB 0Fh, 0C7h, 8Eh ; 1a0d8
	ASCII "J" ; 1a0db
	DB 0CEh, 0C4h, 02h, 0F2h, 0A3h, 0FAh, 0C5h, 28h ; 1a0dc
	ASCII "0" ; 1a0e4
	DB 0BDh, 12h, 1Bh, 0C7h ; 1a0e5
	ASCII "7M" ; 1a0e9
	DB 0CEh, 0C4h, 02h, 0F2h, 94h, 0FAh, 0F8h, 0C5h ; 1a0eb
	DB 00h, 00h, 0C7h ; 1a0f3
	ASCII "E" ; 1a0f6
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a0f7
	DB 0B1h, 0FDh, 0C5h, 00h, 08h, 0BDh, 10h, 1Bh ; 1a0ff
	DB 0C7h, 0EAh ; 1a107
	ASCII "O" ; 1a109
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a10a
	ASCII "u" ; 1a10e
	DB 0FAh, 0C5h, 28h, 2Ch, 0BDh, 12h, 1Bh, 0C7h ; 1a10f
	DB 92h ; 1a117
	ASCII "V" ; 1a118
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a119
	ASCII "f" ; 1a11d
	DB 0FAh, 0F8h, 0C5h, 00h, 08h, 0C7h, 1Dh ; 1a11e
	ASCII "Z" ; 1a125
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a126
	ASCII "Y" ; 1a12a
	DB 0FAh, 0C5h, 00h, 00h, 0C7h ; 1a12b
	ASCII "E" ; 1a130
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a131
	ASCII "w" ; 1a139
	DB 0FDh, 0C5h, 28h, 2Ch, 0BDh, 12h, 1Bh, 0C7h ; 1a13a
	DB 0A7h ; 1a142
	ASCII "Z" ; 1a143
	DB 0CEh, 0C4h, 02h, 0F2h, 3Bh, 0FAh, 0F8h ; 1a144
	ASCII "8" ; 1a14b
	DB 0CEh, 0D4h, 3Dh, 1Bh, 0CEh, 0D4h, 3Eh, 1Bh ; 1a14c
	DB 0C5h, 2Dh, 2Ch, 0C7h, 0B3h ; 1a154
	ASCII "Z" ; 1a159
	DB 0CEh, 0C4h, 02h, 0F2h, 25h, 0FAh, 0C5h ; 1a15a
	ASCII "F" ; 1a161
	DB 12h, 0C7h, 0E6h ; 1a162
	ASCII "Z" ; 1a165
	DB 0CEh, 0C4h, 02h, 0F2h, 19h, 0FAh, 0C5h, 00h ; 1a166
	DB 00h, 0C7h ; 1a16e
	ASCII "E" ; 1a170
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a171
	ASCII "7" ; 1a179
	DB 0FDh, 0C5h, 1Eh, 2Ch, 0BDh, 12h, 1Bh, 0C5h ; 1a17a
	DB 2Dh, 2Ch, 0C7h, 0E5h, 5Bh, 0CEh, 0C4h, 02h ; 1a182
	DB 0F2h, 0F8h, 0F9h, 0C5h, 2Dh, 2Ch, 0C7h, 2Fh ; 1a18a
	DB 5Ch, 0CEh, 0C4h, 02h, 0F2h, 0ECh, 0F9h, 0F8h ; 1a192
	ASCII "8" ; 1a19a
	DB 0CEh, 0D4h ; 1a19b
	ASCII "A" ; 1a19d
	DB 1Bh, 0C5h ; 1a19e
	ASCII "O-" ; 1a1a0
	DB 0BDh, 10h, 1Bh, 0C7h, 0DAh, 5Dh, 0CEh, 0C4h ; 1a1a2
	DB 02h, 0F2h, 0D7h, 0F9h, 0C5h, 00h, 00h, 0C7h ; 1a1aa
	DB 0A0h ; 1a1b2
	ASCII "a" ; 1a1b3
	DB 0CEh, 0C4h, 02h, 0F2h, 0CBh, 0F9h, 0C5h, 00h ; 1a1b4
	DB 2Ch, 0BDh, 12h, 1Bh, 0C7h, 18h ; 1a1bc
	ASCII "a" ; 1a1c2
	DB 0CEh, 0C4h, 02h, 0F2h, 0BCh, 0F9h, 0C5h, 00h ; 1a1c3
	DB 00h, 0C7h ; 1a1cb
	ASCII "Oa" ; 1a1cd
	DB 0CEh, 0C4h, 02h, 0F2h, 0B0h, 0F9h, 0F8h ; 1a1cf
	ASCII "8" ; 1a1d6
	DB 0CEh, 0D4h ; 1a1d7
	ASCII "B" ; 1a1d9
	DB 1Bh, 0C5h, 00h, 00h, 0C7h, 0A0h ; 1a1da
	ASCII "a" ; 1a1e0
	DB 0CEh, 0C4h, 02h, 0F2h, 9Eh, 0F9h, 0C5h, 00h ; 1a1e1
	DB 08h, 0C7h, 90h ; 1a1e9
	ASCII "g" ; 1a1ec
	DB 0CEh, 0C4h, 02h, 0F2h, 92h, 0F9h, 0C5h, 18h ; 1a1ed
	DB 2Ch, 0BDh, 10h, 1Bh, 0C7h, 25h ; 1a1f5
	ASCII "f" ; 1a1fb
	DB 0CEh, 0C4h, 02h, 0F2h, 83h, 0F9h, 0C5h ; 1a1fc
	ASCII "8," ; 1a203
	DB 0BDh, 12h, 1Bh, 0C7h, 21h ; 1a205
	ASCII "d" ; 1a20a
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a20b
	ASCII "t" ; 1a20f
	DB 0F9h, 0F8h, 07h, 04h, 0Eh, 00h ; 1a210
	ASCII "A" ; 1a216
	DB 02h, 00h ; 1a217
	ASCII "A" ; 1a219
	DB 02h, 00h, 00h, 02h, 00h, 00h, 02h ; 1a21a
	ASCIZ "m/" ; 1a221
	DB 7Bh, 0A2h, 03h, 0EFh, 80h, 03h, 0Ah, 9Eh ; 1a224
	DB 03h, 18h, 08h, 09h, 1Ah, 26h, 00h ; 1a22c
	ASCII "cR" ; 1a233
	DB 02h, 0Ch, 08h, 0F2h, 0BAh, 7Fh, 0F2h, 0FBh ; 1a235
	DB 80h, 0CEh, 0C4h, 02h, 0F2h, 99h, 0F8h, 0CEh ; 1a23d
	DB 0C4h, 00h, 0F2h, 0B0h, 89h, 0CEh, 0C4h, 07h ; 1a245
	DB 0F2h, 0A5h, 0E0h, 0C7h, 12h, 0A2h, 0CEh, 0C7h ; 1a24d
	DB 01h, 0F2h, 1Ah, 8Bh, 0B0h, 01h, 0CEh, 0D4h ; 1a255
	DB 8Eh, 16h, 0C5h, 00h, 00h, 0C7h, 97h, 06h ; 1a25d
	DB 0CEh, 0C4h, 02h, 0F2h, 1Ah, 0F9h, 0C7h, 0AEh ; 1a265
	DB 13h, 0CEh, 0C4h, 02h, 0F2h, 11h, 0F9h, 0F2h ; 1a26d
	DB 0C9h, 80h, 0F2h, 82h, 7Fh, 0F8h, 0F2h, 0C9h ; 1a275
	DB 80h, 0C5h ; 1a27d
	ASCII "C" ; 1a27f
	DB 16h, 95h, 01h, 0E7h, 09h, 0C5h ; 1a280
	ASCII "C" ; 1a286
	DB 16h, 95h, 02h, 0E7h, 23h, 0F8h, 0CEh, 0D0h ; 1a287
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 1a28f
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 8Eh, 16h, 20h ; 1a297
	DB 0E7h, 1Bh, 0B0h, 0FFh, 0CEh, 0D4h, 0D6h, 1Ah ; 1a29f
	DB 0F2h, 2Bh, 80h, 0F2h, 0E3h, 7Fh, 0F8h, 0CEh ; 1a2a7
	DB 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 02h ; 1a2af
	DB 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1a2b7
	ASCII "1" ; 1a2bc
	DB 80h, 0F2h, 0CFh, 7Fh, 0F8h, 07h, 04h, 0Eh ; 1a2bd
	DB 00h ; 1a2c5
	ASCII "A" ; 1a2c6
	DB 02h, 00h ; 1a2c7
	ASCII "A" ; 1a2c9
	DB 02h, 00h, 00h, 02h, 00h, 00h, 02h ; 1a2ca
	ASCIZ "m/" ; 1a2d1
	DB 2Bh, 0A3h, 03h ; 1a2d4
	ASCII "M" ; 1a2d7
	DB 91h, 03h, 0Ah, 9Eh, 03h, 18h, 08h, 09h ; 1a2d8
	DB 1Ah, 26h, 00h, 0D8h, 81h, 03h, 0Ch, 08h ; 1a2e0
	DB 0F2h, 0Ah, 7Fh, 0F2h ; 1a2e8
	ASCII "K" ; 1a2ec
	DB 80h, 0CEh, 0C4h, 02h, 0F2h, 0E9h, 0F7h, 0CEh ; 1a2ed
	DB 0C4h, 00h, 0F2h, 00h, 89h, 0CEh, 0C4h, 07h ; 1a2f5
	DB 0F2h, 0F5h, 0DFh, 0C7h, 0C2h, 0A2h, 0CEh, 0C7h ; 1a2fd
	DB 01h, 0F2h ; 1a305
	ASCII "j" ; 1a307
	DB 8Ah, 0B0h, 01h, 0CEh, 0D4h, 8Eh, 16h, 0C5h ; 1a308
	DB 00h, 00h, 0C7h, 97h, 06h, 0CEh, 0C4h, 02h ; 1a310
	DB 0F2h ; 1a318
	ASCII "j" ; 1a319
	DB 0F8h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1a31a
	ASCII "a" ; 1a322
	DB 0F8h, 0F2h, 19h, 80h, 0F2h, 0D2h, 7Eh, 0F8h ; 1a323
	DB 0F2h, 19h, 80h, 0C5h ; 1a32b
	ASCII "C" ; 1a32f
	DB 16h, 95h, 01h, 0E7h, 09h, 0C5h ; 1a330
	ASCII "C" ; 1a336
	DB 16h, 95h, 02h, 0E7h, 1Dh, 0F8h, 0CEh, 0D0h ; 1a337
	DB 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh ; 1a33f
	DB 0D4h, 0FAh, 14h, 0CEh, 0D0h, 8Eh, 16h, 20h ; 1a347
	DB 0E7h, 15h, 0F2h, 81h, 7Fh, 0F2h ; 1a34f
	ASCII "9" ; 1a355
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1a357
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 87h ; 1a35f
	DB 7Fh, 0F2h, 25h, 7Fh, 0F8h, 07h, 04h, 3Eh ; 1a367
	DB 00h, 0CCh, 07h, 00h, 0CCh, 07h, 00h, 0C0h ; 1a36f
	DB 07h, 00h, 0C0h, 07h ; 1a377
	ASCIZ "m/" ; 1a37b
	DB 0CFh, 0A3h, 03h, 00h, 00h, 00h, 7Eh, 0E3h ; 1a37e
	DB 03h, 18h, 08h, 00h ; 1a386
	ASCIZ "B&" ; 1a38a
	DB 08h, 0CCh, 07h, 0Ch, 08h, 0F2h, 60h, 7Eh ; 1a38d
	DB 0F2h, 0A1h, 7Fh, 0CEh, 0C4h, 02h, 0F2h, 3Fh ; 1a395
	DB 0F7h, 0CEh, 0C4h, 00h, 0F2h ; 1a39d
	ASCII "V" ; 1a3a2
	DB 88h, 0CEh, 0C4h, 07h, 0F2h ; 1a3a3
	ASCII "K" ; 1a3a8
	DB 0DFh, 0C7h ; 1a3a9
	ASCII "l" ; 1a3ab
	DB 0A3h, 0CEh, 0C7h, 01h, 0F2h, 0C0h, 89h, 0C5h ; 1a3ac
	DB 00h, 00h, 0C7h, 0B3h ; 1a3b4
	ASCII "p" ; 1a3b8
	DB 0CEh, 0C4h, 02h, 0F2h, 0C6h, 0F7h, 0C7h, 0AEh ; 1a3b9
	DB 13h, 0CEh, 0C4h, 02h, 0F2h, 0BDh, 0F7h, 0F2h ; 1a3c1
	ASCII "u" ; 1a3c9
	DB 0F2h, 2Eh, 7Eh, 0F8h, 0F2h ; 1a3cb
	ASCII "u" ; 1a3d0
	DB 0F8h, 07h, 04h, 3Eh, 00h ; 1a3d2
	ASCII "P" ; 1a3d7
	DB 03h, 00h ; 1a3d8
	ASCII "W" ; 1a3da
	DB 03h, 00h, 00h, 07h, 00h, 00h, 07h, 0CAh ; 1a3db
	DB 2Fh, 00h, 0D7h, 0A4h, 03h, 00h, 00h, 00h ; 1a3e3
	DB 0Fh, 0E3h, 03h, 18h, 08h, 01h ; 1a3eb
	ASCIZ "B&" ; 1a3f1
	DB 0E0h ; 1a3f4
	ASCII "y" ; 1a3f5
	DB 03h, 0Ch, 08h, 0B0h, 00h, 0CEh, 0D4h ; 1a3f6
	ASCII "M" ; 1a3fd
	DB 16h, 0B0h, 01h, 0CEh, 0D4h, 0D8h, 1Ah, 0F2h ; 1a3fe
	DB 00h, 0E9h, 0F2h, 8Ch, 0E8h, 0B0h, 00h, 0CEh ; 1a406
	DB 0D4h, 0DBh, 1Ah, 0B0h, 28h, 0CEh, 0D4h, 0DAh ; 1a40e
	DB 1Ah, 0B0h, 00h, 0CEh, 0D4h, 14h, 1Bh, 0CEh ; 1a416
	DB 0D3h, 23h, 1Bh, 0B2h, 28h, 0BDh, 12h, 1Bh ; 1a41e
	DB 0C5h, 00h, 08h, 0BDh, 10h, 1Bh, 0B0h, 0FFh ; 1a426
	DB 0CEh, 0D4h, 0D6h, 1Ah, 0F2h, 0C0h, 7Dh, 0F2h ; 1a42e
	DB 01h, 7Fh, 0CEh, 0C4h, 02h, 0F2h, 9Fh, 0F6h ; 1a436
	DB 0CEh, 0C4h, 00h, 0F2h, 0B6h, 87h, 0CEh, 0C4h ; 1a43e
	DB 07h, 0F2h, 0ABh, 0DEh, 0C7h, 0D3h, 0A3h, 0CEh ; 1a446
	DB 0C7h, 01h, 0F2h, 20h, 89h, 0B0h, 13h, 0CEh ; 1a44e
	DB 0D4h, 60h, 13h, 0B9h, 10h, 1Bh, 0C7h, 0D3h ; 1a456
	DB 0BCh, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a45e
	ASCII "J" ; 1a466
	DB 0FAh, 0C5h ; 1a467
	ASCII "K-" ; 1a469
	DB 0C7h ; 1a46b
	ASCII "o'" ; 1a46c
	DB 0CEh, 0C4h, 02h, 0F2h, 11h, 0F7h, 0B9h, 12h ; 1a46e
	DB 1Bh, 0C7h ; 1a476
	ASCII "M" ; 1a478
	DB 0CEh, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a479
	DB 2Fh, 0FAh, 0C5h, 00h, 00h, 0C7h, 0F2h, 0B8h ; 1a481
	DB 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h, 20h ; 1a489
	DB 0FAh, 0C5h ; 1a491
	ASCII "K-" ; 1a493
	DB 0C7h ; 1a495
	ASCII "u'" ; 1a496
	DB 0CEh, 0C4h, 02h, 0F2h, 0E7h, 0F6h, 0C5h, 01h ; 1a498
	DB 00h, 0C7h, 92h, 8Dh, 0CEh, 0C4h, 07h, 0F2h ; 1a4a0
	DB 0C1h, 0DEh, 0C5h, 00h, 01h, 0C7h, 3Dh, 8Eh ; 1a4a8
	DB 0CEh, 0C4h, 07h, 0F2h, 0B5h, 0DEh, 0C5h, 05h ; 1a4b0
	DB 03h, 0C7h, 0F4h, 8Dh, 0CEh, 0C4h, 07h, 0F2h ; 1a4b8
	DB 0A9h, 0DEh, 0B0h, 00h, 0F2h, 0C6h, 0E4h, 0C7h ; 1a4c0
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0B5h, 0F6h ; 1a4c8
	DB 0F2h ; 1a4d0
	ASCII "m~" ; 1a4d1
	DB 0F2h, 26h, 7Dh, 0F8h, 0F2h ; 1a4d3
	ASCII "m~" ; 1a4d8
	DB 0F8h, 07h, 04h, 3Eh, 00h ; 1a4da
	ASCII "P" ; 1a4df
	DB 03h, 00h ; 1a4e0
	ASCII "W" ; 1a4e2
	DB 03h, 00h, 00h, 07h, 00h, 00h, 07h, 0CAh ; 1a4e3
	DB 2Fh, 00h, 0D6h, 0A5h, 03h, 00h, 00h, 00h ; 1a4eb
	DB 92h, 0A3h, 03h, 18h, 08h, 01h ; 1a4f3
	ASCIZ "B&" ; 1a4f9
	DB 0E0h ; 1a4fc
	ASCII "y" ; 1a4fd
	DB 03h, 0Ch, 08h, 0F2h, 93h, 0E7h, 0B0h, 01h ; 1a4fe
	DB 0CEh, 0D4h, 0DBh, 1Ah, 0B0h, 28h, 0CEh, 0D4h ; 1a506
	DB 0DAh, 1Ah, 0B0h, 00h, 0CEh, 0D4h, 14h, 1Bh ; 1a50e
	DB 0B0h, 01h, 0CEh, 0D4h, 0EAh, 1Ah, 0B0h, 0FEh ; 1a516
	DB 0CEh, 0D4h, 0D6h, 1Ah, 0F2h, 0D0h, 7Ch, 0F2h ; 1a51e
	DB 11h, 7Eh, 0CEh, 0C4h, 02h, 0F2h, 0AFh, 0F5h ; 1a526
	DB 0CEh, 0C4h, 00h, 0F2h, 0C6h, 86h, 0CEh, 0C4h ; 1a52e
	DB 07h, 0F2h, 0BBh, 0DDh, 0C7h, 0DBh, 0A4h, 0CEh ; 1a536
	DB 0C7h, 01h, 0F2h ; 1a53e
	ASCII "0" ; 1a541
	DB 88h, 0B0h, 13h, 0CEh, 0D4h, 60h, 13h, 0C5h ; 1a542
	DB 00h, 00h, 0C7h ; 1a54a
	ASCII "E" ; 1a54d
	DB 0C4h, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a54e
	ASCII "Z" ; 1a556
	DB 0F9h, 0B9h, 10h, 1Bh, 0C7h, 0D3h, 0BCh, 0CEh ; 1a557
	DB 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a55f
	ASCII "K" ; 1a565
	DB 0F9h, 0C5h ; 1a566
	ASCII "K-" ; 1a568
	DB 0C7h ; 1a56a
	ASCII "o'" ; 1a56b
	DB 0CEh, 0C4h, 02h, 0F2h, 12h, 0F6h, 0B9h, 12h ; 1a56d
	DB 1Bh, 0C7h ; 1a575
	ASCII "D" ; 1a577
	DB 0CFh, 0CEh, 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h ; 1a578
	ASCII "0" ; 1a580
	DB 0F9h, 0C5h, 00h, 00h, 0C7h, 0F2h, 0B8h, 0CEh ; 1a581
	DB 0C7h, 00h, 0CEh, 0C4h, 02h, 0F2h, 21h, 0F9h ; 1a589
	DB 0C5h ; 1a591
	ASCII "K-" ; 1a592
	DB 0C7h ; 1a594
	ASCII "u'" ; 1a595
	DB 0CEh, 0C4h, 02h, 0F2h, 0E8h, 0F5h, 0C5h, 01h ; 1a597
	DB 00h, 0C7h, 92h, 8Dh, 0CEh, 0C4h, 07h, 0F2h ; 1a59f
	DB 0C2h, 0DDh, 0C5h, 00h, 01h, 0C7h, 3Dh, 8Eh ; 1a5a7
	DB 0CEh, 0C4h, 07h, 0F2h, 0B6h, 0DDh, 0C5h, 05h ; 1a5af
	DB 03h, 0C7h, 0F4h, 8Dh, 0CEh, 0C4h, 07h, 0F2h ; 1a5b7
	DB 0AAh, 0DDh, 0B0h, 00h, 0F2h, 0C7h, 0E3h, 0C7h ; 1a5bf
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0B6h, 0F5h ; 1a5c7
	DB 0F2h ; 1a5cf
	ASCII "n}" ; 1a5d0
	DB 0F2h, 27h, 7Ch, 0F8h, 0F2h ; 1a5d2
	ASCII "n}" ; 1a5d7
	DB 0F8h, 07h, 04h, 3Eh, 00h ; 1a5d9
	ASCII "s" ; 1a5de
	DB 06h, 00h ; 1a5df
	ASCII "s" ; 1a5e1
	DB 06h, 00h, 08h, 06h, 00h, 0Ch, 06h ; 1a5e2
	ASCIZ "m/" ; 1a5e9
	ASCII "a" ; 1a5ec
	DB 0A6h, 03h, 00h, 00h, 00h, 10h, 9Eh, 03h ; 1a5ed
	DB 18h, 08h, 09h ; 1a5f5
	ASCIZ "B&" ; 1a5f8
	DB 80h, 0B0h, 06h, 0Ch, 08h, 0F2h, 0F2h, 7Bh ; 1a5fb
	DB 0F2h ; 1a603
	ASCII "3}" ; 1a604
	DB 0CEh, 0C4h, 02h, 0F2h, 0D1h, 0F4h, 0CEh, 0C4h ; 1a606
	DB 00h, 0F2h, 0E8h, 85h, 0CEh, 0C4h, 07h, 0F2h ; 1a60e
	DB 0DDh, 0DCh, 0C7h, 0DAh, 0A5h, 0CEh, 0C7h, 01h ; 1a616
	DB 0F2h ; 1a61e
	ASCII "R" ; 1a61f
	DB 87h, 0C5h, 00h, 00h, 0C7h, 0E8h ; 1a620
	ASCII "r" ; 1a626
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a627
	ASCII "X" ; 1a62b
	DB 0F5h, 0C5h, 00h, 00h, 0C7h, 1Ch ; 1a62c
	ASCII "s" ; 1a632
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a633
	ASCII "L" ; 1a637
	DB 0F5h, 0C5h, 00h, 00h, 0C7h ; 1a638
	ASCII "6s" ; 1a63d
	DB 0CEh, 0C4h, 02h, 0F2h, 40h, 0F5h, 0C5h, 0Ah ; 1a63f
	DB 06h, 0C7h, 1Bh, 95h, 0CEh, 0C4h, 07h, 0F2h ; 1a647
	DB 1Ah, 0DDh, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h ; 1a64f
	DB 0F2h, 2Bh, 0F5h, 0F2h, 0E3h, 7Ch, 0F2h, 9Ch ; 1a657
	DB 7Bh, 0F8h, 0F2h, 0E3h, 7Ch, 0CEh, 0D0h ; 1a65f
	ASCII "C" ; 1a666
	DB 16h, 96h, 01h, 0E7h, 14h, 96h, 02h, 0E6h ; 1a667
	DB 23h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1a66f
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 0Eh ; 1a677
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 1a67f
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1a687
	ASCII "F|" ; 1a68d
	DB 0F2h, 0FEh, 7Bh, 0F8h, 07h, 04h, 3Eh, 00h ; 1a68f
	ASCII "P" ; 1a697
	DB 03h, 00h ; 1a698
	ASCII "W" ; 1a69a
	DB 03h, 00h, 00h, 07h, 00h, 00h, 07h, 0CAh ; 1a69b
	DB 2Fh, 00h, 8Bh, 0A7h, 03h, 00h, 00h, 00h ; 1a6a3
	DB 0D2h, 0E4h, 03h, 18h, 08h, 01h ; 1a6ab
	ASCIZ "B&" ; 1a6b1
	DB 0E0h ; 1a6b4
	ASCII "y" ; 1a6b5
	DB 03h, 0Ch, 08h, 0F2h, 0DBh, 0E5h ; 1a6b6
	ASCII "8" ; 1a6bc
	DB 0CEh, 0D4h, 15h, 1Bh, 0CEh, 0D4h, 2Ah, 1Bh ; 1a6bd
	DB 0B0h, 01h, 0CEh, 0D4h, 14h, 1Bh, 0F2h, 27h ; 1a6c5
	DB 7Bh, 0F2h ; 1a6cd
	ASCII "h|" ; 1a6cf
	DB 0CEh, 0C4h, 02h, 0F2h, 06h, 0F4h, 0CEh, 0C4h ; 1a6d1
	DB 00h, 0F2h, 1Dh, 85h, 0CEh, 0C4h, 07h, 0F2h ; 1a6d9
	DB 12h, 0DCh, 0C7h, 93h, 0A6h, 0CEh, 0C7h, 01h ; 1a6e1
	DB 0F2h, 87h, 86h, 0C5h, 00h, 08h, 0BDh, 10h ; 1a6e9
	DB 1Bh, 0C7h, 0D3h, 0BCh, 0CEh, 0C7h, 00h, 0CEh ; 1a6f1
	DB 0C4h, 02h, 0F2h, 0B4h, 0F7h, 0C5h, 00h, 00h ; 1a6f9
	DB 0C7h, 24h ; 1a701
	ASCII "u" ; 1a703
	DB 0CEh, 0C4h, 02h, 0F2h, 7Bh, 0F4h, 0C5h, 00h ; 1a704
	DB 00h, 0C7h, 2Ah ; 1a70c
	ASCII "u" ; 1a70f
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a710
	ASCII "o" ; 1a714
	DB 0F4h, 0C5h ; 1a715
	ASCII "K-" ; 1a717
	DB 0C7h ; 1a719
	ASCII "o'" ; 1a71a
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a71c
	ASCII "c" ; 1a720
	DB 0F4h, 0CEh, 0D3h, 23h, 1Bh, 0B2h, 28h, 0BDh ; 1a721
	DB 12h, 1Bh, 0C7h, 13h, 0B8h, 0CEh, 0C7h, 00h ; 1a729
	DB 0CEh, 0C4h, 02h, 0F2h, 7Bh, 0F7h, 0C5h, 00h ; 1a731
	DB 00h, 0C7h, 0F2h, 0B8h, 0CEh, 0C7h, 00h, 0CEh ; 1a739
	DB 0C4h, 02h, 0F2h ; 1a741
	ASCII "l" ; 1a744
	DB 0F7h, 0C5h ; 1a745
	ASCII "K-" ; 1a747
	DB 0C7h ; 1a749
	ASCII "u'" ; 1a74a
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a74c
	ASCII "3" ; 1a750
	DB 0F4h, 0C5h, 01h, 00h, 0C7h, 92h, 8Dh, 0CEh ; 1a751
	DB 0C4h, 07h, 0F2h, 0Dh, 0DCh, 0C5h, 00h, 01h ; 1a759
	DB 0C7h, 3Dh, 8Eh, 0CEh, 0C4h, 07h, 0F2h, 01h ; 1a761
	DB 0DCh, 0C5h, 05h, 03h, 0C7h, 0F4h, 8Dh, 0CEh ; 1a769
	DB 0C4h, 07h, 0F2h, 0F5h, 0DBh, 0B0h, 01h, 0F2h ; 1a771
	DB 12h, 0E2h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h ; 1a779
	DB 0F2h, 01h, 0F4h, 0F2h, 0B9h, 7Bh, 0F2h ; 1a781
	ASCII "rz" ; 1a788
	DB 0F8h, 0F2h, 0B9h, 7Bh, 0CEh, 0D0h ; 1a78a
	ASCII "C" ; 1a790
	DB 16h, 96h, 02h, 0E6h, 14h, 0CEh, 0D0h, 0B6h ; 1a791
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h ; 1a799
	DB 0FAh, 14h, 0F2h, 2Fh, 7Bh, 0F2h, 0E7h ; 1a7a1
	ASCII "z" ; 1a7a8
	DB 0F8h, 0Dh, 04h, 3Eh, 00h, 8Fh, 06h, 00h ; 1a7a9
	DB 8Fh, 06h, 00h, 80h, 05h, 00h, 80h, 05h ; 1a7b1
	ASCIZ "m/" ; 1a7b9
	ASCII "I" ; 1a7bc
	DB 0A8h, 03h ; 1a7bd
	ASCII "M" ; 1a7bf
	DB 91h, 03h, 0C4h, 0E8h, 03h, 18h, 08h, 06h ; 1a7c0
	ASCIZ "B&" ; 1a7c8
	DB 0E0h, 0B0h, 06h, 0Ch, 08h, 0F2h, 22h ; 1a7cb
	ASCII "z" ; 1a7d2
	DB 0F2h ; 1a7d3
	ASCII "c{" ; 1a7d4
	DB 0CEh, 0C4h, 02h, 0F2h, 01h, 0F3h, 0CEh, 0C4h ; 1a7d6
	DB 00h, 0F2h, 18h, 84h, 0CEh, 0C4h, 07h, 0F2h ; 1a7de
	DB 0Dh, 0DBh, 0C7h, 0AAh, 0A7h, 0CEh, 0C7h, 01h ; 1a7e6
	DB 0F2h, 82h, 85h, 0C5h, 00h, 18h, 0C7h, 0B5h ; 1a7ee
	DB 23h, 0CEh, 0C4h, 02h, 0F2h, 88h, 0F3h, 0C5h ; 1a7f6
	ASCII "X" ; 1a7fe
	DB 18h, 0C7h, 0A3h, 23h, 0CEh, 0C4h, 02h, 0F2h ; 1a7ff
	DB 7Ch, 0F3h, 0C5h, 10h, 18h, 0C7h, 0B2h ; 1a807
	ASCII "v" ; 1a80e
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a80f
	ASCII "p" ; 1a813
	DB 0F3h, 0C5h, 40h, 18h, 0C7h, 9Ah ; 1a814
	ASCII "v" ; 1a81a
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a81b
	ASCII "d" ; 1a81f
	DB 0F3h, 0C5h, 28h, 18h, 0C7h, 83h ; 1a820
	ASCII "v" ; 1a826
	DB 0CEh, 0C4h, 02h, 0F2h ; 1a827
	ASCII "X" ; 1a82b
	DB 0F3h, 0C5h, 02h, 06h, 0C7h, 0B4h, 94h, 0CEh ; 1a82c
	DB 0C4h, 07h, 0F2h ; 1a834
	ASCII "2" ; 1a837
	DB 0DBh, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1a838
	ASCII "C" ; 1a840
	DB 0F3h, 0F2h, 0FBh ; 1a841
	ASCII "z" ; 1a844
	DB 0F2h, 0B4h ; 1a845
	ASCII "y" ; 1a847
	DB 0F8h, 0F2h, 0A6h, 0E1h, 0F2h, 0F8h ; 1a848
	ASCII "z" ; 1a84e
	DB 0CEh, 0D0h ; 1a84f
	ASCII "C" ; 1a851
	DB 16h, 96h, 01h, 0E7h, 19h, 96h, 02h, 0E6h ; 1a852
	DB 28h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1a85a
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 84h ; 1a862
	ASCII "z" ; 1a86a
	DB 0F2h, 22h ; 1a86b
	ASCII "z" ; 1a86d
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1a86e
	DB 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1a876
	ASCII "Vz" ; 1a87d
	DB 0F2h, 0Eh ; 1a87f
	ASCII "z" ; 1a881
	DB 0F8h, 07h, 04h, 0Eh, 00h ; 1a882
	ASCII "s" ; 1a887
	DB 06h, 00h ; 1a888
	ASCII "s" ; 1a88a
	DB 06h, 00h, 08h, 06h, 00h, 0Ch, 06h ; 1a88b
	ASCIZ "m/" ; 1a892
	DB 0Bh, 0A9h, 03h, 00h, 00h, 00h, 0Ah, 9Eh ; 1a895
	DB 03h, 18h, 08h, 09h, 1Ah, 26h, 00h, 80h ; 1a89d
	DB 0B0h, 06h, 0Ch, 08h, 0F2h ; 1a8a5
	ASCII "Iy" ; 1a8aa
	DB 0F2h, 8Ah ; 1a8ac
	ASCII "z" ; 1a8ae
	DB 0F2h, 95h, 00h, 0CEh, 0C4h, 02h, 0F2h, 25h ; 1a8af
	DB 0F2h, 0CEh, 0C4h, 00h, 0F2h, 3Ch, 83h, 0CEh ; 1a8b7
	DB 0C4h, 07h, 0F2h ; 1a8bf
	ASCII "1" ; 1a8c2
	DB 0DAh, 0C7h, 83h, 0A8h, 0CEh, 0C7h, 01h, 0F2h ; 1a8c3
	DB 0A6h, 84h, 0CEh, 0D0h, 0D4h, 1Ah, 0CEh, 0C4h ; 1a8cb
	DB 02h, 0F2h ; 1a8d3
	ASCII "vI" ; 1a8d5
	DB 0C5h, 00h, 00h, 0C7h, 0EEh ; 1a8d7
	ASCII "r" ; 1a8dc
	DB 0CEh, 0C4h, 02h, 0F2h, 0A2h, 0F2h, 0C5h, 00h ; 1a8dd
	DB 00h, 0C7h, 02h ; 1a8e5
	ASCII "s" ; 1a8e8
	DB 0CEh, 0C4h, 02h, 0F2h, 96h, 0F2h, 0C5h, 00h ; 1a8e9
	DB 00h, 0C7h ; 1a8f1
	ASCII "Bs" ; 1a8f3
	DB 0CEh, 0C4h, 02h, 0F2h, 8Ah, 0F2h, 0C7h, 0AEh ; 1a8f5
	DB 13h, 0CEh, 0C4h, 02h, 0F2h, 81h, 0F2h, 0F2h ; 1a8fd
	ASCII "9z" ; 1a905
	DB 0F2h, 0F2h ; 1a907
	ASCII "x" ; 1a909
	DB 0F8h, 0F2h ; 1a90a
	ASCII "9z" ; 1a90c
	DB 0CEh, 0D0h ; 1a90e
	ASCII "C" ; 1a910
	DB 16h, 96h, 01h, 0E7h, 14h, 96h, 02h, 0E6h ; 1a911
	DB 2Ch, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1a919
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 0Eh ; 1a921
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 1a929
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1a931
	ASCIZ "R" ; 1a937
	DB 0B0h, 0FFh, 0CEh, 0D4h, 0D6h, 1Ah, 0F2h, 93h ; 1a939
	ASCII "y" ; 1a941
	DB 0F2h ; 1a942
	ASCII "Ky" ; 1a943
	DB 0F8h, 0CEh, 0D0h, 0DDh, 1Ah ; 1a945
	ASCII "2@" ; 1a94a
	DB 0E4h, 26h, 0CEh, 0D0h, 0DFh, 1Ah ; 1a94c
	ASCII "2@" ; 1a952
	DB 0E4h, 1Eh, 0CEh, 0D0h, 0E1h, 1Ah ; 1a954
	ASCII "2@" ; 1a95a
	DB 0E4h, 16h, 0CEh, 0D0h, 0E3h, 1Ah ; 1a95c
	ASCII "2@" ; 1a962
	DB 0E4h, 0Eh ; 1a964
	ASCII "8" ; 1a966
	DB 0CEh, 0D1h, 0C2h, 1Ah, 0CEh, 0BCh, 02h, 0E7h ; 1a967
	DB 09h, 80h, 0F1h, 06h, 0F2h ; 1a96f
	ASCIZ "6" ; 1a974
	DB 02h, 02h, 0CFh, 0B0h, 0CEh, 0D0h, 0D7h, 1Ah ; 1a976
	ASCIZ "H" ; 1a97e
	DB 01h, 00h, 0CFh, 0B5h, 01h, 0CEh, 0D4h, 0D4h ; 1a980
	DB 1Ah, 0F8h, 0CEh, 0D0h, 0D4h, 1Ah ; 1a988
	ASCII "2" ; 1a98e
	DB 10h, 0E4h, 0Dh, 12h, 10h, 0F2h ; 1a98f
	ASCII "Bz" ; 1a995
	DB 0C5h, 0D3h, 1Ah, 0CEh, 2Ch, 0F1h, 0Dh, 0F2h ; 1a997
	ASCII "8z" ; 1a99f
	DB 0C5h, 0D1h, 1Ah, 0CEh, 2Ch, 91h ; 1a9a1
	ASCII "A" ; 1a9a7
	DB 0CEh, 2Ch, 0F8h, 0CEh, 0D0h, 0DDh, 1Ah, 0CEh ; 1a9a8
	DB 0D1h, 0DFh, 1Ah ; 1a9b0
	ASCII "1" ; 1a9b3
	DB 0E4h, 13h, 0CEh, 0D1h, 0E1h, 1Ah ; 1a9b4
	ASCII "1" ; 1a9ba
	DB 0E4h, 1Fh, 0CEh, 0D1h, 0E3h, 1Ah ; 1a9bb
	ASCII "1" ; 1a9c1
	DB 0E4h, 24h, 0B0h, 00h, 0F1h, 22h ; 1a9c2
	ASCII "A" ; 1a9c8
	DB 0CEh, 0D1h, 0E1h, 1Ah ; 1a9c9
	ASCII "1" ; 1a9cd
	DB 0E4h, 0Ch, 0CEh, 0D1h, 0E3h, 1Ah ; 1a9ce
	ASCII "1" ; 1a9d4
	DB 0E4h, 11h, 0B0h, 01h, 0F1h, 0Fh ; 1a9d5
	ASCII "A" ; 1a9db
	DB 0CEh, 0D1h, 0E3h, 1Ah ; 1a9dc
	ASCII "1" ; 1a9e0
	DB 0E4h, 05h, 0B0h, 02h, 0F1h, 03h, 0B0h, 03h ; 1a9e1
	DB 0F8h, 0CEh, 0D0h, 0EBh, 1Ah, 3Ah, 0FFh, 0CEh ; 1a9e9
	DB 0D1h, 0EAh, 1Ah, 21h, 0B1h, 08h, 0CEh, 8Ch ; 1a9f1
	DB 0E4h, 06h, 0F5h, 0FBh, 0B0h, 0FFh, 0F8h, 0B0h ; 1a9f9
	DB 08h, 11h, 0CEh, 0C4h, 02h, 0F2h ; 1aa01
	ASCII "n" ; 1aa07
	DB 0FAh, 0F8h ; 1aa08
	ASCII "2" ; 1aa0a
	DB 08h, 0E5h, 0Fh, 0CEh, 0C4h, 02h, 0F2h, 82h ; 1aa0b
	DB 0FAh, 0F2h, 0C2h ; 1aa13
	ASCII "y" ; 1aa16
	DB 0C5h, 0EBh, 1Ah, 0CEh, 2Ch, 0F8h, 0Dh, 04h ; 1aa17
	DB 3Eh, 00h, 97h, 06h, 00h, 97h, 06h, 00h ; 1aa1f
	DB 08h, 06h, 00h, 0Ch, 06h ; 1aa27
	ASCIZ "m/" ; 1aa2c
	DB 84h, 0AAh, 03h, 00h, 00h, 00h, 0B8h, 86h ; 1aa2f
	DB 03h, 18h, 08h, 01h ; 1aa37
	ASCIZ "B&" ; 1aa3b
	DB 40h, 0B1h, 06h, 0Ch, 08h, 0F2h, 0AFh ; 1aa3e
	ASCII "w" ; 1aa45
	DB 0F2h, 0F0h ; 1aa46
	ASCII "x" ; 1aa48
	DB 0CEh, 0C4h, 02h, 0F2h, 8Eh, 0F0h, 0CEh, 0C4h ; 1aa49
	DB 00h, 0F2h, 0A5h, 81h, 0CEh, 0C4h, 07h, 0F2h ; 1aa51
	DB 9Ah, 0D8h, 0C7h, 1Dh, 0AAh, 0CEh, 0C7h, 01h ; 1aa59
	DB 0F2h, 0Fh, 83h, 0F2h ; 1aa61
	ASCIZ "Y" ; 1aa65
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 15h ; 1aa67
	DB 0F1h, 0F2h, 0CDh ; 1aa6f
	ASCII "x" ; 1aa72
	DB 0F2h, 86h ; 1aa73
	ASCII "w" ; 1aa75
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 1aa76
	DB 22h, 0CEh, 0D4h, 0FAh, 14h, 0F8h, 0F2h ; 1aa7e
	ASCII "k" ; 1aa85
	DB 0DFh, 0F2h, 0BDh ; 1aa86
	ASCII "x" ; 1aa89
	DB 0CEh, 0D0h ; 1aa8a
	ASCII "C" ; 1aa8c
	DB 16h, 96h, 01h, 0E7h, 14h, 96h, 02h, 0E6h ; 1aa8d
	DB 29h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1aa95
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0F1h, 0Eh ; 1aa9d
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 1aaa5
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 20h ; 1aaad
	ASCII "x" ; 1aab4
	DB 0F2h, 0D8h ; 1aab5
	ASCII "w" ; 1aab7
	DB 0B0h, 0FFh, 0CEh, 0D4h ; 1aab8
	ASCII "i" ; 1aabc
	DB 1Bh, 0F8h, 0CEh, 0D0h, 0D7h, 1Ah ; 1aabd
	ASCIZ "2" ; 1aac3
	DB 0E6h ; 1aac5
	ASCII "e2" ; 1aac6
	DB 01h, 0E6h, 1Ah, 0C4h, 00h, 0A9h, 0BCh, 2Ch ; 1aac8
	DB 16h, 0B0h, 06h, 0CEh, 0D4h, 2Eh, 16h, 0C4h ; 1aad0
	DB 00h, 0ACh, 0BCh, 2Fh, 16h, 0B0h, 06h, 0CEh ; 1aad8
	DB 0D4h ; 1aae0
	ASCII "1" ; 1aae1
	DB 16h, 0F8h, 0C6h, 0AAh, 15h, 0CEh, 0C6h, 00h ; 1aae2
	DB 0F2h, 1Ah, 9Ch, 0CEh, 0D0h, 0ADh, 15h ; 1aaea
	ASCII "2" ; 1aaf1
	DB 06h, 0E4h, 05h ; 1aaf2
	ASCII "2" ; 1aaf5
	DB 12h, 0E4h, 1Ah, 0C4h, 00h, 0A3h, 0BCh, 2Ch ; 1aaf6
	DB 16h, 0B0h, 06h, 0CEh, 0D4h, 2Eh, 16h, 0C4h ; 1aafe
	DB 00h, 0A6h, 0BCh, 2Fh, 16h, 0B0h, 06h, 0CEh ; 1ab06
	DB 0D4h ; 1ab0e
	ASCII "1" ; 1ab0f
	DB 16h, 0F8h, 0C4h, 00h, 9Dh, 0BCh, 2Ch, 16h ; 1ab10
	DB 0B0h, 06h, 0CEh, 0D4h, 2Eh, 16h, 0C4h, 00h ; 1ab18
	DB 0A0h, 0BCh, 2Fh, 16h, 0B0h, 06h, 0CEh, 0D4h ; 1ab20
	ASCII "1" ; 1ab28
	DB 16h, 0F8h, 0C4h, 00h, 97h, 0BCh, 2Ch, 16h ; 1ab29
	DB 0B0h, 06h, 0CEh, 0D4h, 2Eh, 16h, 0C4h, 00h ; 1ab31
	DB 9Ah, 0BCh, 2Fh, 16h, 0B0h, 06h, 0CEh, 0D4h ; 1ab39
	ASCII "1" ; 1ab41
	DB 16h, 0F8h, 06h, 04h, 0Eh, 00h, 0AFh, 06h ; 1ab42
	DB 00h, 0AFh, 06h, 00h, 00h, 00h, 00h, 00h ; 1ab4a
	DB 00h, 16h, 2Fh, 00h, 0C4h, 0ABh, 03h, 00h ; 1ab52
	DB 00h, 00h, 10h, 9Eh, 03h, 18h, 08h, 01h ; 1ab5a
	DB 12h, 26h, 00h, 0C0h, 0B2h, 06h, 0Ch, 08h ; 1ab62
	DB 0F2h, 88h ; 1ab6a
	ASCII "v" ; 1ab6c
	DB 0F2h, 0C9h ; 1ab6d
	ASCII "w" ; 1ab6f
	DB 0CEh, 0C4h, 02h, 0F2h ; 1ab70
	ASCII "g" ; 1ab74
	DB 0EFh, 0CEh, 0C4h, 00h, 0F2h, 7Eh, 80h, 0CEh ; 1ab75
	DB 0C4h, 07h, 0F2h ; 1ab7d
	ASCII "s" ; 1ab80
	DB 0D7h, 0CEh, 0C4h, 00h, 0F2h, 0F6h, 7Ch, 0F1h ; 1ab81
	DB 19h, 0F2h ; 1ab89
	ASCII "hv" ; 1ab8b
	DB 0F2h, 0A9h ; 1ab8d
	ASCII "w" ; 1ab8f
	DB 0CEh, 0C4h, 02h, 0F2h ; 1ab90
	ASCII "G" ; 1ab94
	DB 0EFh, 0CEh, 0C4h, 00h, 0F2h, 5Eh, 80h, 0CEh ; 1ab95
	DB 0C4h, 07h, 0F2h ; 1ab9d
	ASCII "S" ; 1aba0
	DB 0D7h, 0C7h ; 1aba1
	ASCII "D" ; 1aba3
	DB 0ABh, 0CEh, 0C7h, 01h, 0F2h, 0C8h, 81h, 0C7h ; 1aba4
	DB 0E7h ; 1abac
	ASCII "v" ; 1abad
	DB 0CEh, 0C4h, 02h, 0F2h, 0D1h, 0EFh, 0C7h, 0AEh ; 1abae
	DB 13h, 0CEh, 0C4h, 02h, 0F2h, 0C8h, 0EFh, 0F2h ; 1abb6
	DB 80h ; 1abbe
	ASCII "w" ; 1abbf
	DB 0F2h ; 1abc0
	ASCII "9v" ; 1abc1
	DB 0F8h, 0F2h, 80h ; 1abc3
	ASCII "w" ; 1abc6
	DB 0F8h, 00h, 00h, 01h, 08h, 10h, 00h, 02h ; 1abc7
	DB 88h, 00h, 00h, 03h, 08h, 10h, 00h, 04h ; 1abcf
	DB 88h, 00h, 00h, 05h, 88h, 00h, 00h, 06h ; 1abd7
	DB 88h, 08h ; 1abdf
	ASCII "0" ; 1abe1
	DB 07h, 08h, 18h ; 1abe2
	ASCII "0" ; 1abe5
	DB 08h, 08h, 28h ; 1abe6
	ASCII "0" ; 1abe9
	DB 09h, 08h ; 1abea
	ASCII "80" ; 1abec
	DB 0Ah, 08h ; 1abee
	ASCII "H0" ; 1abf0
	DB 0Bh, 88h, 08h ; 1abf2
	ASCII "0" ; 1abf5
	DB 07h, 08h, 18h ; 1abf6
	ASCII "0" ; 1abf9
	DB 08h, 08h, 28h ; 1abfa
	ASCII "0" ; 1abfd
	DB 0Ch, 08h ; 1abfe
	ASCII "80" ; 1ac00
	DB 0Ah, 08h ; 1ac02
	ASCII "H0" ; 1ac04
	DB 0Bh, 88h, 07h, 00h, 01h, 08h, 17h, 00h ; 1ac06
	DB 02h, 88h, 07h, 0FFh, 01h, 08h, 17h, 0FFh ; 1ac0e
	DB 02h, 88h, 07h, 00h, 03h, 08h, 17h, 00h ; 1ac16
	DB 04h, 88h, 07h, 0FFh, 03h, 08h, 17h, 0FFh ; 1ac1e
	DB 04h, 88h, 07h, 00h, 05h, 08h, 17h, 00h ; 1ac26
	DB 06h, 08h, 27h, 00h, 07h, 88h, 07h, 0FFh ; 1ac2e
	DB 05h, 08h, 17h, 0FFh, 06h, 08h, 27h, 0FFh ; 1ac36
	DB 07h, 88h, 07h, 00h, 08h, 08h, 17h, 00h ; 1ac3e
	DB 09h, 08h, 27h, 00h, 0Ah, 88h, 07h, 0FFh ; 1ac46
	DB 08h, 08h, 17h, 0FFh, 09h, 08h, 27h, 0FFh ; 1ac4e
	DB 0Ah, 88h, 07h, 00h, 20h, 08h, 17h, 00h ; 1ac56
	DB 21h, 08h, 27h, 00h, 22h, 88h, 07h, 0FFh ; 1ac5e
	DB 20h, 08h, 17h, 0FFh, 21h, 08h, 27h, 0FFh ; 1ac66
	DB 22h, 88h, 07h, 00h, 23h, 08h, 17h, 00h ; 1ac6e
	DB 24h, 08h, 27h, 00h, 25h, 08h ; 1ac76
	ASCIZ "7" ; 1ac7c
	DB 26h, 88h, 07h, 0FFh, 23h, 08h, 17h, 0FFh ; 1ac7e
	DB 24h, 08h, 27h, 0FFh, 25h, 08h ; 1ac86
	ASCII "7" ; 1ac8c
	DB 0FFh, 26h, 88h, 07h, 00h, 2Ch, 08h, 17h ; 1ac8d
	DB 00h, 2Dh, 08h, 27h, 00h, 2Eh, 08h ; 1ac95
	ASCIZ "7" ; 1ac9c
	DB 2Fh, 88h, 07h, 0FFh, 2Ch, 08h, 17h, 0FFh ; 1ac9e
	DB 2Dh, 08h, 27h, 0FFh, 2Eh, 08h ; 1aca6
	ASCII "7" ; 1acac
	DB 0FFh, 2Fh, 88h, 3Dh, 03h, 12h, 08h ; 1acad
	ASCII "M" ; 1acb4
	DB 03h, 13h, 88h, 3Dh, 03h, 16h, 08h ; 1acb5
	ASCII "M" ; 1acbc
	DB 03h, 17h, 88h, 3Dh, 0Fh, 10h, 08h ; 1acbd
	ASCII "M" ; 1acc4
	DB 0Fh, 11h, 88h, 3Dh, 0Fh, 12h, 08h ; 1acc5
	ASCII "M" ; 1accc
	DB 0Fh, 13h, 88h, 3Dh, 0Fh, 14h, 08h ; 1accd
	ASCII "M" ; 1acd4
	DB 0Fh, 15h, 88h, 3Dh, 0Fh, 16h, 08h ; 1acd5
	ASCII "M" ; 1acdc
	DB 0Fh, 17h, 88h ; 1acdd
	ASCII "B$" ; 1ace0
	DB 0Bh, 08h ; 1ace2
	ASCII "R$" ; 1ace4
	DB 0Ch, 08h ; 1ace6
	ASCII "N%" ; 1ace8
	DB 18h, 88h ; 1acea
	ASCII "B$" ; 1acec
	DB 0Bh, 08h ; 1acee
	ASCII "R$" ; 1acf0
	DB 0Ch, 08h ; 1acf2
	ASCII "N%" ; 1acf4
	DB 19h, 88h, 3Fh, 24h, 0Dh, 08h ; 1acf6
	ASCII "O$" ; 1acfc
	DB 0Eh, 08h, 2Eh, 25h, 18h, 89h, 3Fh, 24h ; 1acfe
	DB 0Dh, 08h ; 1ad06
	ASCII "O$" ; 1ad08
	DB 0Eh, 08h, 2Eh, 25h, 19h, 89h, 0FDh, 0FCh ; 1ad0a
	DB 1Ah, 88h, 0FDh, 0FCh, 1Bh, 88h ; 1ad12
	ASCIZ "P" ; 1ad18
	DB 1Ch, 89h ; 1ad1a
	ASCIZ "P" ; 1ad1c
	DB 1Dh, 89h ; 1ad1e
	ASCII "P0" ; 1ad20
	DB 1Ch, 8Bh ; 1ad22
	ASCII "P0" ; 1ad24
	DB 1Dh, 8Bh, 0Eh ; 1ad26
	ASCII "8'" ; 1ad29
	DB 08h, 1Eh ; 1ad2b
	ASCII "8(" ; 1ad2d
	DB 88h, 0Eh ; 1ad2f
	ASCII "8)" ; 1ad31
	DB 08h, 1Eh ; 1ad33
	ASCII "8*" ; 1ad35
	DB 88h, 2Dh ; 1ad37
	ASCII "8'" ; 1ad39
	DB 08h, 3Dh ; 1ad3b
	ASCII "8(" ; 1ad3d
	DB 88h, 2Dh ; 1ad3f
	ASCII "8)" ; 1ad41
	DB 08h, 3Dh ; 1ad43
	ASCII "8*" ; 1ad45
	DB 88h, 08h, 00h ; 1ad47
	ASCII "0" ; 1ad4a
	DB 08h, 18h, 00h ; 1ad4b
	ASCII "1" ; 1ad4e
	DB 08h, 28h, 00h ; 1ad4f
	ASCII "2" ; 1ad52
	DB 88h, 08h, 0FFh ; 1ad53
	ASCII "0" ; 1ad56
	DB 08h, 18h, 0FFh ; 1ad57
	ASCII "1" ; 1ad5a
	DB 08h, 28h, 0FFh ; 1ad5b
	ASCII "2" ; 1ad5e
	DB 88h, 0FDh, 0FCh, 00h, 08h, 0Dh, 0FCh, 01h ; 1ad5f
	DB 88h, 0FDh, 0FCh, 02h, 08h, 0Dh, 0FCh, 03h ; 1ad67
	DB 88h, 00h, 00h, 00h, 88h, 00h, 00h, 00h ; 1ad6f
	DB 8Ah, 00h, 00h, 01h, 88h, 00h, 00h, 02h ; 1ad77
	DB 88h, 00h, 00h, 03h, 88h, 00h, 00h, 04h ; 1ad7f
	DB 88h, 00h, 00h, 05h, 88h, 00h, 00h, 06h ; 1ad87
	DB 88h, 00h, 00h, 07h, 88h, 00h, 00h, 08h ; 1ad8f
	DB 88h, 00h, 00h, 09h, 88h, 00h, 00h, 0Ah ; 1ad97
	DB 88h, 00h, 00h, 00h, 88h, 00h, 00h, 01h ; 1ad9f
	DB 88h, 00h, 00h, 02h, 88h, 00h, 00h, 03h ; 1ada7
	DB 88h, 00h, 00h, 04h, 88h, 00h, 00h, 05h ; 1adaf
	DB 88h, 00h, 00h, 06h, 88h, 00h, 00h, 07h ; 1adb7
	DB 88h, 00h, 00h, 08h, 88h, 00h, 01h, 09h ; 1adbf
	DB 88h, 00h, 00h, 0Ah, 88h, 00h, 00h, 0Bh ; 1adc7
	DB 88h, 00h, 00h, 0Ch, 88h, 00h, 00h, 0Dh ; 1adcf
	DB 88h, 00h, 00h, 0Eh, 88h, 00h, 00h, 0Fh ; 1add7
	DB 88h, 00h, 00h, 1Eh, 88h, 00h, 0F0h, 20h ; 1addf
	DB 88h, 00h, 0F0h, 21h, 88h, 00h, 0F8h, 22h ; 1ade7
	DB 88h, 00h, 0F8h, 23h, 88h, 00h, 0EFh, 25h ; 1adef
	DB 88h, 00h, 0EDh, 24h, 88h, 00h, 0F0h, 25h ; 1adf7
	DB 88h, 00h, 0F0h, 24h, 88h, 00h, 0EEh, 26h ; 1adff
	DB 88h, 00h, 0ECh, 26h, 88h, 00h, 0EDh, 26h ; 1ae07
	DB 88h, 00h, 0EEh, 27h, 88h, 09h, 0F6h, 28h ; 1ae0f
	DB 88h, 09h, 0F6h, 29h, 88h, 09h, 0F6h, 2Ah ; 1ae17
	DB 88h, 0F6h, 0F6h, 28h, 89h, 0F6h, 0F6h, 29h ; 1ae1f
	DB 89h, 0F6h, 0F6h, 2Ah, 89h, 00h, 0F0h, 2Bh ; 1ae27
	DB 88h, 00h, 0F0h, 2Ch, 88h, 05h, 00h, 2Dh ; 1ae2f
	DB 08h, 0F1h, 00h, 2Dh, 89h, 09h, 00h, 2Eh ; 1ae37
	DB 08h, 0EEh, 00h, 2Eh, 89h, 0Dh, 00h, 2Fh ; 1ae3f
	DB 08h, 0EAh, 00h, 2Fh, 89h, 00h, 0F0h ; 1ae47
	ASCII "0" ; 1ae4e
	DB 88h, 00h, 0F0h ; 1ae4f
	ASCII "1" ; 1ae52
	DB 88h, 09h, 0F8h ; 1ae53
	ASCII "2" ; 1ae56
	DB 88h, 0Ah, 0F7h ; 1ae57
	ASCII "3" ; 1ae5a
	DB 88h, 00h, 0F0h ; 1ae5b
	ASCII "4" ; 1ae5e
	DB 88h, 00h, 0F0h ; 1ae5f
	ASCII "5" ; 1ae62
	DB 88h, 00h, 0F0h ; 1ae63
	ASCII "6" ; 1ae66
	DB 88h, 00h, 0F0h ; 1ae67
	ASCII "8" ; 1ae6a
	DB 88h, 00h, 0F0h ; 1ae6b
	ASCII "7" ; 1ae6e
	DB 88h, 00h, 0F0h ; 1ae6f
	ASCII "R" ; 1ae72
	DB 88h, 00h, 0F0h ; 1ae73
	ASCII "S" ; 1ae76
	DB 88h, 00h, 00h, 00h, 08h, 0FBh, 00h, 14h ; 1ae77
	DB 88h, 00h, 00h, 01h, 08h, 0FBh, 02h, 14h ; 1ae7f
	DB 88h, 00h, 00h, 02h, 08h, 0FBh, 04h, 14h ; 1ae87
	DB 88h, 00h, 00h, 05h, 08h, 0FBh, 01h, 14h ; 1ae8f
	DB 88h, 00h, 00h, 05h, 08h, 0FBh, 01h, 15h ; 1ae97
	DB 88h, 00h, 00h, 05h, 08h, 0FBh, 01h, 16h ; 1ae9f
	DB 88h, 0F8h, 00h ; 1aea7
	ASCII "9" ; 1aeaa
	DB 08h, 08h, 00h, 3Ah, 88h, 0F8h, 00h, 3Bh ; 1aeab
	DB 08h, 08h, 00h, 3Ch, 88h, 00h, 00h, 3Dh ; 1aeb3
	DB 08h, 0Ah, 11h, 3Eh, 08h, 0F6h, 10h, 3Fh ; 1aebb
	DB 88h, 00h, 0FBh, 3Dh, 08h, 0Fh, 16h, 3Eh ; 1aec3
	DB 08h, 0F1h, 15h, 3Fh, 88h, 0FDh, 01h, 3Dh ; 1aecb
	DB 08h, 07h, 12h, 3Eh, 08h, 0F3h, 11h, 3Fh ; 1aed3
	DB 88h, 0FDh, 0FCh, 3Dh, 08h, 0Ch, 17h, 3Eh ; 1aedb
	DB 08h, 0EEh, 16h, 3Fh, 88h, 02h, 02h, 3Dh ; 1aee3
	DB 08h, 0Ch, 13h, 3Eh, 08h, 0F8h, 12h, 3Fh ; 1aeeb
	DB 88h, 02h, 0FDh, 3Dh, 08h, 11h, 18h, 3Eh ; 1aef3
	DB 08h, 0F3h, 17h, 3Fh, 88h, 00h, 00h, 40h ; 1aefb
	DB 88h, 00h, 00h ; 1af03
	ASCII "A" ; 1af06
	DB 88h, 00h, 00h ; 1af07
	ASCII "B" ; 1af0a
	DB 88h, 00h, 00h ; 1af0b
	ASCII "C" ; 1af0e
	DB 88h, 00h, 00h ; 1af0f
	ASCII "D" ; 1af12
	DB 88h, 00h, 00h ; 1af13
	ASCII "E" ; 1af16
	DB 88h, 00h, 00h ; 1af17
	ASCII "F" ; 1af1a
	DB 88h, 00h, 00h ; 1af1b
	ASCII "G" ; 1af1e
	DB 88h, 00h, 00h ; 1af1f
	ASCII "H" ; 1af22
	DB 88h, 00h, 00h ; 1af23
	ASCII "I" ; 1af26
	DB 88h, 00h, 00h ; 1af27
	ASCII "J" ; 1af2a
	DB 08h, 10h, 00h ; 1af2b
	ASCII "K" ; 1af2e
	DB 08h, 07h, 04h, 40h, 08h, 0Dh, 04h, 40h ; 1af2f
	DB 08h, 11h, 04h, 40h, 88h, 0F7h, 00h ; 1af37
	ASCII "L" ; 1af3e
	DB 08h, 07h, 00h ; 1af3f
	ASCII "M" ; 1af42
	DB 08h, 0FEh, 04h, 40h, 08h, 04h, 04h, 40h ; 1af43
	DB 08h, 08h, 04h, 40h, 88h, 00h, 00h ; 1af4b
	ASCII "N" ; 1af52
	DB 08h, 10h, 00h ; 1af53
	ASCII "O" ; 1af56
	DB 08h, 07h, 04h, 40h, 08h, 0Dh, 04h, 40h ; 1af57
	DB 08h, 11h, 04h, 40h, 88h, 00h, 0F9h ; 1af5f
	ASCII "P" ; 1af66
	DB 88h, 00h, 0F9h ; 1af67
	ASCII "Q" ; 1af6a
	DB 88h, 01h, 0F9h ; 1af6b
	ASCII "P" ; 1af6e
	DB 89h, 05h, 00h, 2Dh, 88h, 09h, 00h, 2Eh ; 1af6f
	DB 88h, 0Dh, 00h, 2Fh, 88h, 10h, 00h ; 1af77
	ASCII "T" ; 1af7e
	DB 88h, 11h, 00h ; 1af7f
	ASCII "U" ; 1af82
	DB 88h, 12h, 00h ; 1af83
	ASCII "V" ; 1af86
	DB 88h, 00h, 00h, 00h, 08h, 0FBh, 00h, 17h ; 1af87
	DB 88h, 00h, 00h, 01h, 08h, 0FBh, 02h, 17h ; 1af8f
	DB 88h, 00h, 00h, 02h, 08h, 0FBh, 04h, 17h ; 1af97
	DB 88h, 00h, 00h, 05h, 08h, 0FBh, 01h, 17h ; 1af9f
	DB 88h, 00h, 00h, 05h, 08h, 0FBh, 01h, 18h ; 1afa7
	DB 88h, 00h, 00h, 05h, 08h, 0FBh, 01h, 19h ; 1afaf
	DB 88h, 20h, 18h ; 1afb7
	ASCII "W" ; 1afba
	DB 08h ; 1afbb
	ASCII "0" ; 1afbc
	DB 18h ; 1afbd
	ASCII "X" ; 1afbe
	DB 88h, 20h, 17h ; 1afbf
	ASCII "W" ; 1afc2
	DB 08h ; 1afc3
	ASCII "0" ; 1afc4
	DB 17h ; 1afc5
	ASCII "X" ; 1afc6
	DB 88h, 28h, 18h ; 1afc7
	ASCII "Y" ; 1afca
	DB 88h, 28h, 18h ; 1afcb
	ASCII "Z" ; 1afce
	DB 88h, 00h, 00h, 1Ah, 88h, 00h, 0FFh, 1Ah ; 1afcf
	DB 88h, 0F8h, 00h, 5Bh, 88h, 0F0h, 00h, 5Ch ; 1afd7
	DB 88h, 0F0h, 00h, 5Dh, 88h, 0Fh, 00h, 2Dh ; 1afdf
	DB 08h, 0FBh, 00h, 2Dh, 89h, 13h, 00h, 2Eh ; 1afe7
	DB 08h, 0F8h, 00h, 2Eh, 89h, 17h, 00h, 2Fh ; 1afef
	DB 08h, 0F4h, 00h, 2Fh, 89h, 00h, 00h, 60h ; 1aff7
	DB 88h, 00h, 00h ; 1afff
	ASCII "a" ; 1b002
	DB 88h, 0FFh, 00h, 60h, 89h, 00h, 00h ; 1b003
	ASCII "b" ; 1b00a
	DB 88h, 00h, 00h ; 1b00b
	ASCII "c" ; 1b00e
	DB 88h, 0FFh, 00h ; 1b00f
	ASCII "b" ; 1b012
	DB 89h, 0FFh, 00h ; 1b013
	ASCII "c" ; 1b016
	DB 89h, 00h, 00h ; 1b017
	ASCII "d" ; 1b01a
	DB 88h, 00h, 00h ; 1b01b
	ASCII "e" ; 1b01e
	DB 88h, 00h, 00h ; 1b01f
	ASCII "f" ; 1b022
	DB 88h, 00h, 00h ; 1b023
	ASCII "g" ; 1b026
	DB 88h, 00h, 00h ; 1b027
	ASCII "h" ; 1b02a
	DB 88h, 00h, 00h ; 1b02b
	ASCII "i" ; 1b02e
	DB 88h, 00h, 00h ; 1b02f
	ASCII "j" ; 1b032
	DB 88h, 00h, 00h ; 1b033
	ASCII "k" ; 1b036
	DB 88h, 00h, 00h ; 1b037
	ASCII "l" ; 1b03a
	DB 88h, 0FFh, 00h ; 1b03b
	ASCII "m" ; 1b03e
	DB 88h, 0FFh, 00h ; 1b03f
	ASCII "n" ; 1b042
	DB 88h, 0FFh, 00h ; 1b043
	ASCII "o" ; 1b046
	DB 88h, 00h, 00h, 7Ch, 88h, 00h, 00h, 7Dh ; 1b047
	DB 88h, 00h, 00h, 7Eh, 88h, 00h, 00h, 7Fh ; 1b04f
	DB 88h, 00h, 00h, 80h, 88h, 00h, 00h, 81h ; 1b057
	DB 88h, 00h, 00h, 82h, 88h, 00h, 00h, 83h ; 1b05f
	DB 88h, 00h, 00h, 84h, 88h, 00h, 00h, 85h ; 1b067
	DB 88h, 00h, 0FEh, 86h, 88h, 0FFh, 00h, 60h ; 1b06f
	DB 89h, 0FFh, 00h, 7Ch, 89h, 00h, 00h ; 1b077
	ASCII "h" ; 1b07e
	DB 89h, 00h, 00h, 87h, 88h, 00h, 0FEh, 88h ; 1b07f
	DB 88h, 0FFh, 00h, 80h, 89h, 0FFh, 00h, 87h ; 1b087
	DB 89h, 0FFh, 00h ; 1b08f
	ASCII "h" ; 1b092
	DB 88h, 00h, 00h, 8Ah, 88h, 00h, 00h, 8Bh ; 1b093
	DB 88h, 00h, 00h, 8Ch, 88h, 00h, 0FEh, 7Eh ; 1b09b
	DB 88h, 00h, 00h, 8Dh, 88h, 0FDh, 00h, 8Eh ; 1b0a3
	DB 88h, 0FCh, 00h, 8Fh, 88h, 0FCh, 00h, 90h ; 1b0ab
	DB 88h, 00h, 00h, 91h, 88h, 00h, 00h, 92h ; 1b0b3
	DB 88h, 00h, 00h, 93h, 88h, 0FFh, 00h, 94h ; 1b0bb
	DB 88h, 00h, 00h, 95h, 88h, 00h, 00h, 96h ; 1b0c3
	DB 88h, 00h, 00h, 97h, 88h, 00h, 00h, 98h ; 1b0cb
	DB 88h, 00h, 00h, 99h, 88h, 00h, 0FFh, 9Ah ; 1b0d3
	DB 88h, 00h, 0FFh, 9Bh, 88h, 00h, 00h, 9Ch ; 1b0db
	DB 88h, 0FFh, 00h, 9Ch, 89h, 00h, 00h, 9Eh ; 1b0e3
	DB 88h, 00h, 00h, 9Fh, 88h, 0FFh, 00h, 9Fh ; 1b0eb
	DB 89h, 00h, 00h, 0A1h, 88h, 00h, 00h, 0A2h ; 1b0f3
	DB 88h, 00h, 00h, 0A3h, 88h, 00h, 00h, 0A4h ; 1b0fb
	DB 88h, 00h, 00h, 0A5h, 88h, 00h, 00h, 0A6h ; 1b103
	DB 88h, 00h, 00h, 0A7h, 88h, 00h, 00h, 0A8h ; 1b10b
	DB 88h, 00h, 00h, 0A9h, 88h, 00h, 00h, 0AAh ; 1b113
	DB 88h, 00h, 00h, 0ABh, 88h, 0FFh, 00h, 0ABh ; 1b11b
	DB 89h, 00h, 00h, 91h, 88h, 00h, 00h, 8Dh ; 1b123
	DB 88h, 00h, 00h, 0AFh, 88h, 00h, 00h, 0B0h ; 1b12b
	DB 88h, 00h, 00h, 0B1h, 88h, 00h, 00h, 0B2h ; 1b133
	DB 88h, 00h, 00h, 0B3h, 88h, 0FFh, 00h, 0B3h ; 1b13b
	DB 89h, 00h, 00h, 0B4h, 88h, 00h, 00h, 0B5h ; 1b143
	DB 88h, 00h, 00h, 0B6h, 88h, 00h, 02h, 0B7h ; 1b14b
	DB 88h, 00h, 02h, 0B8h, 88h, 00h, 00h, 0B9h ; 1b153
	DB 88h, 00h, 0F2h, 0D2h, 08h, 00h, 02h, 0D4h ; 1b15b
	DB 88h, 00h, 0F2h, 0D2h, 08h, 00h, 02h, 0D3h ; 1b163
	DB 88h, 00h, 0F2h, 0D0h, 08h, 00h, 02h, 0D1h ; 1b16b
	DB 88h, 00h, 0F2h, 0D2h, 08h, 00h, 02h, 0D5h ; 1b173
	DB 88h, 00h, 0F2h, 0D6h, 08h, 00h, 02h, 0D7h ; 1b17b
	DB 88h, 00h, 0F8h, 7Eh, 88h, 00h, 0F9h, 7Eh ; 1b183
	DB 88h, 00h, 0FAh, 0D8h, 88h, 00h, 0F9h, 0DBh ; 1b18b
	DB 88h, 00h, 0FAh, 0DAh, 88h, 00h, 0F2h, 0D9h ; 1b193
	DB 88h, 00h, 0F8h, 0DCh, 88h, 00h, 0F7h, 0DDh ; 1b19b
	DB 88h, 00h, 0F8h, 0DEh, 88h, 00h, 00h, 8Fh ; 1b1a3
	DB 88h, 00h, 00h, 0DFh, 88h, 00h, 00h, 0E0h ; 1b1ab
	DB 88h, 00h, 0F9h, 0FFh, 88h, 00h, 0F7h, 0E1h ; 1b1b3
	DB 88h, 00h, 0F7h, 0E2h, 88h, 01h, 0F8h, 87h ; 1b1bb
	DB 88h, 00h, 0FAh, 0E1h, 88h, 00h, 0FAh, 0E2h ; 1b1c3
	DB 88h, 01h, 0FAh, 87h, 88h, 0FDh, 03h, 0E3h ; 1b1cb
	DB 88h, 0FDh, 07h, 0E4h, 88h, 0FBh, 0Ah, 0E5h ; 1b1d3
	DB 88h, 0FBh, 0Bh, 0E6h, 88h, 0FBh, 0Ch, 0E5h ; 1b1db
	DB 88h, 0FBh, 11h, 0E6h, 88h, 0FCh, 0Bh, 0E7h ; 1b1e3
	DB 88h, 0FCh, 11h, 0E7h, 88h, 0FFh, 05h, 0E8h ; 1b1eb
	DB 88h, 0FFh, 07h, 0E9h, 88h, 0FFh, 06h, 0EAh ; 1b1f3
	DB 88h, 0FFh, 09h, 0E9h, 88h, 0FFh, 08h, 0EAh ; 1b1fb
	DB 88h, 00h, 00h, 0CEh, 88h, 00h, 00h, 0EBh ; 1b203
	DB 88h, 00h, 00h, 0ECh, 88h, 00h, 00h, 0EDh ; 1b20b
	DB 88h, 00h, 00h, 0EEh, 88h, 00h, 00h, 0EFh ; 1b213
	DB 88h, 00h, 00h, 0F0h, 88h, 00h, 00h, 0F1h ; 1b21b
	DB 88h, 0FEh, 00h, 0F2h, 88h, 0FEh, 00h, 0F3h ; 1b223
	DB 88h, 0FEh, 00h, 0F4h, 88h, 0FEh, 00h, 0F5h ; 1b22b
	DB 88h, 0FEh, 00h, 0F6h, 88h, 0FEh, 00h, 0F7h ; 1b233
	DB 88h, 0FEh, 00h, 0F8h, 88h, 00h, 00h, 0F9h ; 1b23b
	DB 08h, 08h, 09h, 0FAh, 88h, 00h, 0FFh, 0F9h ; 1b243
	DB 08h, 08h, 0Ah, 0FAh, 88h, 00h, 00h, 0FBh ; 1b24b
	DB 88h, 00h, 0FAh, 0FCh, 08h, 00h, 0Ah, 0FDh ; 1b253
	DB 88h, 01h, 01h, 0FEh, 88h, 00h, 00h, 0CFh ; 1b25b
	DB 88h, 00h, 00h, 60h, 88h, 00h, 00h ; 1b263
	ASCII "a" ; 1b26a
	DB 88h, 0FEh, 00h, 60h, 89h, 00h, 00h ; 1b26b
	ASCII "b" ; 1b272
	DB 88h, 00h, 00h ; 1b273
	ASCII "c" ; 1b276
	DB 88h, 0FEh, 00h ; 1b277
	ASCII "b" ; 1b27a
	DB 89h, 0FEh, 00h ; 1b27b
	ASCII "c" ; 1b27e
	DB 89h, 00h, 00h ; 1b27f
	ASCII "d" ; 1b282
	DB 88h, 00h, 00h ; 1b283
	ASCII "e" ; 1b286
	DB 88h, 00h, 00h ; 1b287
	ASCII "f" ; 1b28a
	DB 88h, 00h, 00h ; 1b28b
	ASCII "g" ; 1b28e
	DB 88h, 00h, 00h ; 1b28f
	ASCII "h" ; 1b292
	DB 88h, 00h, 00h ; 1b293
	ASCII "i" ; 1b296
	DB 88h, 00h, 00h ; 1b297
	ASCII "j" ; 1b29a
	DB 88h, 00h, 00h ; 1b29b
	ASCII "k" ; 1b29e
	DB 88h, 00h, 00h ; 1b29f
	ASCII "l" ; 1b2a2
	DB 88h, 00h, 00h ; 1b2a3
	ASCII "m" ; 1b2a6
	DB 88h, 00h, 00h ; 1b2a7
	ASCII "n" ; 1b2aa
	DB 88h, 00h, 00h ; 1b2ab
	ASCII "o" ; 1b2ae
	DB 88h, 00h, 00h ; 1b2af
	ASCII "p" ; 1b2b2
	DB 88h, 00h, 00h ; 1b2b3
	ASCII "q" ; 1b2b6
	DB 88h, 00h, 00h ; 1b2b7
	ASCII "r" ; 1b2ba
	DB 88h, 00h, 00h ; 1b2bb
	ASCII "t" ; 1b2be
	DB 88h, 00h, 00h ; 1b2bf
	ASCII "u" ; 1b2c2
	DB 88h, 00h, 00h ; 1b2c3
	ASCII "v" ; 1b2c6
	DB 88h, 00h, 00h ; 1b2c7
	ASCII "x" ; 1b2ca
	DB 88h, 00h, 00h ; 1b2cb
	ASCII "y" ; 1b2ce
	DB 88h, 00h, 00h ; 1b2cf
	ASCII "z" ; 1b2d2
	DB 88h, 00h, 00h, 7Ch, 88h, 00h, 00h, 7Dh ; 1b2d3
	DB 88h, 00h, 00h, 7Eh, 88h, 00h, 00h, 7Fh ; 1b2db
	DB 88h, 0FEh, 00h, 80h, 88h, 0FEh, 00h, 81h ; 1b2e3
	DB 88h, 00h, 00h, 82h, 88h, 00h, 00h, 83h ; 1b2eb
	DB 88h, 00h, 00h, 84h, 88h, 00h, 00h, 85h ; 1b2f3
	DB 88h, 00h, 0FFh, 86h, 89h, 0FEh, 00h, 60h ; 1b2fb
	DB 89h, 0FEh, 00h, 7Ch, 89h, 0FEh, 00h, 86h ; 1b303
	DB 88h, 0FDh, 00h, 87h, 88h, 0FBh, 00h, 88h ; 1b30b
	DB 88h, 0FCh, 00h, 89h, 88h, 00h, 00h, 8Ah ; 1b313
	DB 88h, 00h, 00h, 8Bh, 88h, 00h, 00h, 8Ch ; 1b31b
	DB 88h, 00h, 0FEh, 7Eh, 88h, 00h, 00h, 8Dh ; 1b323
	DB 88h, 0FDh, 00h, 8Eh, 88h, 0FCh, 00h, 8Fh ; 1b32b
	DB 88h, 0FCh, 00h, 90h, 88h, 0FFh, 00h, 91h ; 1b333
	DB 88h, 0FCh, 00h, 92h, 88h, 0FCh, 00h, 93h ; 1b33b
	DB 88h, 0FCh, 00h, 94h, 88h, 0FCh, 00h, 95h ; 1b343
	DB 88h, 00h, 00h, 96h, 88h, 00h, 00h, 97h ; 1b34b
	DB 88h, 0FFh, 00h, 98h, 88h, 0FFh, 0FEh, 99h ; 1b353
	DB 88h, 0FFh, 0FEh, 9Ah, 88h, 0FFh, 0FFh, 9Bh ; 1b35b
	DB 88h, 00h, 00h, 9Ch, 88h, 00h, 00h, 9Dh ; 1b363
	DB 88h, 00h, 00h, 9Eh, 88h, 00h, 00h, 9Fh ; 1b36b
	DB 88h, 00h, 00h, 0A0h, 88h, 00h, 00h, 0A1h ; 1b373
	DB 88h, 00h, 00h, 0A2h, 88h, 00h, 00h, 0A3h ; 1b37b
	DB 88h, 00h, 00h, 0A4h, 88h, 00h, 00h, 0A5h ; 1b383
	DB 88h, 00h, 00h, 0A6h, 88h, 00h, 00h, 0A7h ; 1b38b
	DB 88h, 00h, 00h, 0A8h, 88h, 00h, 00h, 90h ; 1b393
	DB 88h, 00h, 00h ; 1b39b
	ASCII "b" ; 1b39e
	DB 88h, 0FFh, 00h, 0ABh, 88h, 00h, 00h, 0ACh ; 1b39f
	DB 88h, 00h, 00h, 0ADh, 88h, 00h, 00h, 8Dh ; 1b3a7
	DB 88h, 00h, 00h, 0AFh, 88h, 00h, 00h, 8Ch ; 1b3af
	DB 88h, 00h, 00h, 0B1h, 88h, 00h, 00h, 0B2h ; 1b3b7
	DB 88h, 01h, 00h, 0B3h, 88h, 0FCh, 00h, 0B3h ; 1b3bf
	DB 89h, 0FFh, 00h, 0D8h, 88h, 00h, 00h, 0B5h ; 1b3c7
	DB 88h, 00h, 00h, 0B6h, 88h, 00h, 00h, 0B7h ; 1b3cf
	DB 88h, 00h, 00h, 0B8h, 88h, 0FCh, 00h, 0B9h ; 1b3d7
	DB 88h, 00h, 00h, 0D0h, 88h, 00h, 00h, 0D1h ; 1b3df
	DB 88h, 00h, 00h, 0D2h, 88h, 00h, 00h, 0D3h ; 1b3e7
	DB 88h, 00h, 00h, 0D4h, 88h, 0FFh, 06h, 0D5h ; 1b3ef
	DB 08h, 00h, 06h, 0D5h, 89h, 0FFh, 06h, 0D6h ; 1b3f7
	DB 08h, 00h, 06h, 0D6h, 89h, 0FFh, 06h, 0D7h ; 1b3ff
	DB 08h, 00h, 06h, 0D7h, 89h, 00h, 00h, 0D8h ; 1b407
	DB 88h, 00h, 00h, 0D9h, 88h, 00h, 0FDh, 0DAh ; 1b40f
	DB 88h, 00h, 0FDh, 0DBh, 88h, 00h, 00h, 0DCh ; 1b417
	DB 88h, 00h, 00h, 0DDh, 88h, 00h, 00h, 0DEh ; 1b41f
	DB 88h, 00h, 00h, 0DFh, 88h, 00h, 00h, 0E0h ; 1b427
	DB 88h, 00h, 00h, 0E1h, 88h, 00h, 00h, 0E2h ; 1b42f
	DB 88h, 00h, 00h, 0E3h, 88h, 00h, 00h, 0E4h ; 1b437
	DB 88h, 00h, 00h, 0E5h, 88h, 00h, 00h, 0E6h ; 1b43f
	DB 88h, 00h, 00h, 0E7h, 88h, 00h, 0FEh, 0E8h ; 1b447
	DB 88h, 00h, 0FBh, 0E9h, 88h, 00h, 00h, 0E9h ; 1b44f
	DB 88h, 00h, 0FBh, 0EAh, 88h, 00h, 00h, 0EBh ; 1b457
	DB 88h, 01h, 00h, 0ECh, 88h, 01h, 02h, 0EDh ; 1b45f
	DB 88h, 00h, 06h, 0EEh, 88h, 00h, 00h, 0EFh ; 1b467
	DB 88h, 00h, 02h, 0F0h, 88h, 00h, 05h, 0F1h ; 1b46f
	DB 88h, 00h, 00h, 0F1h, 88h, 00h, 05h, 0EFh ; 1b477
	DB 88h, 00h, 01h, 0F2h, 88h, 00h, 02h, 0F3h ; 1b47f
	DB 88h, 00h, 00h, 0F4h, 88h, 00h, 00h, 0F5h ; 1b487
	DB 88h, 0FFh, 00h, 0F6h, 88h, 00h, 00h, 0F7h ; 1b48f
	DB 88h, 02h, 00h, 0F8h, 88h, 02h, 00h, 92h ; 1b497
	DB 88h, 0FFh, 00h, 0D8h, 88h, 0FEh, 00h, 0F9h ; 1b49f
	DB 88h, 00h, 00h, 0FAh, 88h, 0FDh, 00h ; 1b4a7
	ASCII "h" ; 1b4ae
	DB 89h, 0FDh, 00h, 0FBh, 88h, 0FEh, 00h, 0FCh ; 1b4af
	DB 88h, 0FEh, 00h, 0FDh, 88h, 0FEh, 00h, 0FEh ; 1b4b7
	DB 88h, 0FEh, 00h, 0FFh, 88h, 0FEh, 00h, 0CAh ; 1b4bf
	DB 88h, 00h, 00h, 0CBh, 88h, 00h, 00h, 0CCh ; 1b4c7
	DB 88h, 00h, 00h, 0CDh, 88h, 0FEh, 01h, 0CEh ; 1b4cf
	DB 88h, 00h, 00h, 8Fh, 88h, 00h, 00h, 90h ; 1b4d7
	DB 88h, 04h, 00h, 8Ch, 88h, 00h, 00h, 60h ; 1b4df
	DB 88h, 00h, 00h ; 1b4e7
	ASCII "a" ; 1b4ea
	DB 88h, 00h, 00h ; 1b4eb
	ASCII "a" ; 1b4ee
	DB 89h, 00h, 00h ; 1b4ef
	ASCII "b" ; 1b4f2
	DB 88h, 00h, 00h ; 1b4f3
	ASCII "c" ; 1b4f6
	DB 88h, 00h, 00h ; 1b4f7
	ASCII "b" ; 1b4fa
	DB 89h, 00h, 00h ; 1b4fb
	ASCII "c" ; 1b4fe
	DB 89h, 00h, 00h ; 1b4ff
	ASCII "d" ; 1b502
	DB 88h, 00h, 00h ; 1b503
	ASCII "e" ; 1b506
	DB 88h, 00h, 00h ; 1b507
	ASCII "f" ; 1b50a
	DB 88h, 00h, 00h ; 1b50b
	ASCII "g" ; 1b50e
	DB 88h, 00h, 00h ; 1b50f
	ASCII "h" ; 1b512
	DB 88h, 00h, 00h ; 1b513
	ASCII "i" ; 1b516
	DB 88h, 00h, 00h ; 1b517
	ASCII "j" ; 1b51a
	DB 88h, 00h, 00h ; 1b51b
	ASCII "k" ; 1b51e
	DB 88h, 00h, 00h ; 1b51f
	ASCII "l" ; 1b522
	DB 88h, 00h, 00h ; 1b523
	ASCII "m" ; 1b526
	DB 88h, 00h, 00h ; 1b527
	ASCII "n" ; 1b52a
	DB 88h, 00h, 00h ; 1b52b
	ASCII "o" ; 1b52e
	DB 88h, 00h, 00h ; 1b52f
	ASCII "p" ; 1b532
	DB 88h, 00h, 00h ; 1b533
	ASCII "q" ; 1b536
	DB 88h, 00h, 00h ; 1b537
	ASCII "r" ; 1b53a
	DB 88h, 00h, 00h ; 1b53b
	ASCII "s" ; 1b53e
	DB 88h, 00h, 00h ; 1b53f
	ASCII "t" ; 1b542
	DB 88h, 00h, 00h ; 1b543
	ASCII "u" ; 1b546
	DB 88h, 00h, 00h ; 1b547
	ASCII "v" ; 1b54a
	DB 88h, 00h, 00h ; 1b54b
	ASCII "w" ; 1b54e
	DB 88h, 00h, 00h ; 1b54f
	ASCII "x" ; 1b552
	DB 88h, 00h, 00h ; 1b553
	ASCII "y" ; 1b556
	DB 88h, 00h, 00h ; 1b557
	ASCII "z" ; 1b55a
	DB 88h, 00h, 00h, 7Bh, 88h, 00h, 00h, 7Ch ; 1b55b
	DB 88h, 00h, 00h, 7Dh, 88h, 00h, 00h, 7Eh ; 1b563
	DB 88h, 00h, 00h, 7Fh, 88h, 00h, 00h, 80h ; 1b56b
	DB 88h, 00h, 00h, 81h, 88h, 00h, 00h, 82h ; 1b573
	DB 88h, 00h, 00h, 83h, 88h, 00h, 00h, 84h ; 1b57b
	DB 88h, 00h, 00h, 85h, 88h, 00h, 00h, 86h ; 1b583
	DB 88h, 00h, 0FEh, 87h, 88h, 00h, 0FBh, 88h ; 1b58b
	DB 88h, 00h, 00h, 89h, 88h, 00h, 00h, 8Ah ; 1b593
	DB 88h, 00h, 00h, 8Bh, 88h, 00h, 00h, 8Ch ; 1b59b
	DB 88h, 00h, 0FEh, 7Dh, 88h, 00h, 00h, 8Dh ; 1b5a3
	DB 88h, 0FDh, 00h, 8Eh, 88h, 0FCh, 00h, 8Fh ; 1b5ab
	DB 88h, 0FCh, 00h, 90h, 88h, 0FFh, 00h, 91h ; 1b5b3
	DB 88h, 0FDh, 00h, 92h, 88h, 0FDh, 00h, 93h ; 1b5bb
	DB 88h, 0FDh, 00h, 94h, 88h, 0FDh, 00h, 95h ; 1b5c3
	DB 88h, 00h, 00h, 96h, 88h, 00h, 00h, 97h ; 1b5cb
	DB 88h, 00h, 00h, 98h, 88h, 0FFh, 0FCh, 99h ; 1b5d3
	DB 88h, 0FFh, 0FEh, 9Ah, 88h, 00h, 00h, 9Bh ; 1b5db
	DB 88h, 00h, 00h, 9Ch, 88h, 00h, 00h, 9Dh ; 1b5e3
	DB 88h, 00h, 00h, 9Eh, 88h, 00h, 00h, 9Fh ; 1b5eb
	DB 88h, 00h, 00h, 0A0h, 88h, 00h, 00h, 0A1h ; 1b5f3
	DB 88h, 00h, 00h, 0A2h, 88h, 00h, 00h, 0A3h ; 1b5fb
	DB 88h, 00h, 00h, 0A4h, 88h, 00h, 00h, 0A5h ; 1b603
	DB 88h, 00h, 00h, 0A6h, 88h, 00h, 00h, 0A7h ; 1b60b
	DB 88h, 00h, 00h, 0A8h, 88h, 00h, 00h, 0A9h ; 1b613
	DB 88h, 00h, 00h ; 1b61b
	ASCII "b" ; 1b61e
	DB 88h, 00h, 00h, 0ABh, 88h, 00h, 00h, 0ACh ; 1b61f
	DB 88h, 00h, 00h, 0ADh, 88h, 00h, 00h, 0AEh ; 1b627
	DB 88h, 00h, 00h, 7Ch, 88h, 00h, 00h, 0B0h ; 1b62f
	DB 88h, 00h, 00h, 0B1h, 88h, 00h, 00h, 0B2h ; 1b637
	DB 88h, 02h, 00h, 0B3h, 88h, 0FEh, 00h, 0B3h ; 1b63f
	DB 89h, 00h, 00h, 0B4h, 88h, 00h, 00h, 0B5h ; 1b647
	DB 88h, 00h, 00h, 0B6h, 88h, 00h, 04h, 0B7h ; 1b64f
	DB 88h, 00h, 04h, 0B8h, 88h, 0FDh, 00h, 0B9h ; 1b657
	DB 88h, 0F7h, 07h, 0D0h, 08h, 07h, 07h, 0D0h ; 1b65f
	DB 89h, 0F7h, 08h, 0D0h, 08h, 07h, 08h, 0D0h ; 1b667
	DB 89h, 0F7h, 08h, 0D1h, 08h, 07h, 08h, 0D1h ; 1b66f
	DB 89h, 0F7h, 08h, 0D2h, 08h, 07h, 08h, 0D2h ; 1b677
	DB 89h, 00h, 00h, 0D3h, 88h, 00h, 00h, 0D4h ; 1b67f
	DB 88h, 00h, 00h, 0D5h, 88h, 00h, 00h, 0D6h ; 1b687
	DB 88h, 00h, 00h, 0D7h, 88h, 00h, 0FFh, 0D8h ; 1b68f
	DB 88h, 00h, 00h, 0D9h, 88h, 00h, 00h, 0DBh ; 1b697
	DB 88h, 00h, 00h, 0DAh, 88h, 00h, 00h, 0DCh ; 1b69f
	DB 88h, 00h, 00h, 0DDh, 88h, 0FFh, 00h, 0DEh ; 1b6a7
	DB 88h, 00h, 00h, 0DFh, 88h, 00h, 00h, 0E0h ; 1b6af
	DB 88h, 00h, 00h, 0E1h, 88h, 00h, 00h, 0E2h ; 1b6b7
	DB 88h, 0FBh, 00h, 0E3h, 08h, 0Bh, 00h, 0E4h ; 1b6bf
	DB 88h, 0FBh, 03h, 0E5h, 08h, 0Bh, 03h, 0E6h ; 1b6c7
	DB 88h, 0FBh, 08h, 0E7h, 08h, 0Bh, 08h, 0E8h ; 1b6cf
	DB 88h, 00h, 00h, 0E9h, 88h, 07h, 0F8h, 0EAh ; 1b6d7
	DB 88h, 0Bh, 0F3h, 0EBh, 88h, 10h, 0F4h, 0ECh ; 1b6df
	DB 88h, 0Fh, 0F4h, 0EDh, 88h, 00h, 00h, 0EDh ; 1b6e7
	DB 88h, 00h, 00h, 0E9h, 88h, 01h, 0F9h, 0EBh ; 1b6ef
	DB 88h, 03h, 0FAh, 0ECh, 88h, 02h, 0FAh, 0EDh ; 1b6f7
	DB 88h, 00h, 00h, 0EEh, 88h, 0FEh, 02h, 0EFh ; 1b6ff
	DB 88h, 0FEh, 06h, 7Fh, 88h, 0FEh, 06h, 0F0h ; 1b707
	DB 88h, 00h, 00h, 0EEh, 88h, 0FBh, 01h, 0EFh ; 1b70f
	DB 88h, 0F4h, 07h, 7Fh, 88h, 0F1h, 0Ch, 7Fh ; 1b717
	DB 88h, 0F1h, 0Ch, 0F0h, 88h, 00h, 00h, 0F1h ; 1b71f
	DB 88h, 0FFh, 03h, 0F2h, 88h, 0FEh, 06h, 0F3h ; 1b727
	DB 88h, 00h, 00h, 0F4h, 88h, 0FFh, 03h, 0F5h ; 1b72f
	DB 88h, 0FEh, 06h, 0F6h, 88h, 00h, 00h, 0F7h ; 1b737
	DB 88h, 0FFh, 04h, 0F8h, 88h, 00h, 07h, 0F9h ; 1b73f
	DB 88h, 00h, 07h, 0FAh, 88h, 00h, 00h, 0FBh ; 1b747
	DB 88h, 00h, 00h, 0FCh, 88h, 00h, 00h, 0FDh ; 1b74f
	DB 88h, 00h, 00h, 0FEh, 88h, 00h, 00h, 0FFh ; 1b757
	DB 88h, 00h, 00h, 0CEh, 88h, 00h, 00h, 0CAh ; 1b75f
	DB 88h, 00h, 00h, 0CBh, 88h, 00h, 00h, 0CCh ; 1b767
	DB 88h, 00h, 00h, 0CDh, 88h, 00h, 00h, 0C8h ; 1b76f
	DB 88h, 00h, 00h, 0C9h, 88h, 00h, 00h, 0C5h ; 1b777
	DB 88h, 00h, 0FDh, 0C6h, 88h, 00h, 0FEh, 0C6h ; 1b77f
	DB 88h, 00h, 0FFh, 0C7h, 88h, 00h, 00h, 0CFh ; 1b787
	DB 88h, 00h, 00h, 60h, 08h, 10h, 00h ; 1b78f
	ASCII "a" ; 1b796
	DB 08h, 00h, 10h ; 1b797
	ASCII "p" ; 1b79a
	DB 08h, 10h, 10h ; 1b79b
	ASCII "q" ; 1b79e
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1b79f
	DB 88h, 00h, 00h ; 1b7a7
	ASCII "b" ; 1b7aa
	DB 08h, 10h, 00h ; 1b7ab
	ASCII "c" ; 1b7ae
	DB 08h, 00h, 10h ; 1b7af
	ASCII "r" ; 1b7b2
	DB 08h, 10h, 10h ; 1b7b3
	ASCII "s" ; 1b7b6
	DB 08h, 00h, 20h, 82h, 08h, 10h, 20h, 83h ; 1b7b7
	DB 88h, 00h, 00h ; 1b7bf
	ASCII "d" ; 1b7c2
	DB 08h, 10h, 00h ; 1b7c3
	ASCII "e" ; 1b7c6
	DB 08h, 00h, 10h ; 1b7c7
	ASCII "t" ; 1b7ca
	DB 08h, 10h, 10h ; 1b7cb
	ASCII "u" ; 1b7ce
	DB 08h, 00h, 20h, 84h, 08h, 10h, 20h, 85h ; 1b7cf
	DB 88h, 08h, 10h ; 1b7d7
	ASCII "v" ; 1b7da
	DB 08h, 00h, 20h, 86h, 08h, 10h, 20h, 87h ; 1b7db
	DB 88h, 00h, 00h ; 1b7e3
	ASCII "h" ; 1b7e6
	DB 08h, 10h, 00h ; 1b7e7
	ASCII "i" ; 1b7ea
	DB 08h, 00h, 10h ; 1b7eb
	ASCII "x" ; 1b7ee
	DB 08h, 10h, 10h ; 1b7ef
	ASCII "y" ; 1b7f2
	DB 08h, 00h, 20h, 88h, 08h, 10h, 20h, 89h ; 1b7f3
	DB 88h, 00h, 00h ; 1b7fb
	ASCII "j" ; 1b7fe
	DB 08h, 10h, 00h ; 1b7ff
	ASCII "k" ; 1b802
	DB 08h, 00h, 10h ; 1b803
	ASCII "z" ; 1b806
	DB 08h, 10h, 10h, 7Bh, 08h, 00h, 20h, 8Ah ; 1b807
	DB 08h, 10h, 20h, 8Bh, 88h, 00h, 00h ; 1b80f
	ASCII "l" ; 1b816
	DB 08h, 10h, 00h ; 1b817
	ASCII "m" ; 1b81a
	DB 08h, 00h, 10h, 7Ch, 08h, 10h, 10h, 7Dh ; 1b81b
	DB 08h, 00h, 20h, 8Ch, 08h, 10h, 20h, 8Dh ; 1b823
	DB 88h, 00h, 00h ; 1b82b
	ASCII "n" ; 1b82e
	DB 08h, 10h, 00h ; 1b82f
	ASCII "o" ; 1b832
	DB 08h, 00h, 10h, 7Eh, 08h, 10h, 10h, 7Fh ; 1b833
	DB 08h, 00h, 20h, 8Eh, 08h, 10h, 20h, 8Fh ; 1b83b
	DB 88h, 01h, 00h, 90h, 08h, 11h, 00h, 91h ; 1b843
	DB 08h, 01h, 10h, 0A0h, 08h, 11h, 10h, 0A1h ; 1b84b
	DB 08h, 01h, 20h, 0B0h, 08h, 11h, 20h, 0B1h ; 1b853
	DB 88h, 0Eh, 00h, 90h, 09h, 0Eh, 10h, 0A0h ; 1b85b
	DB 09h, 0Eh, 20h, 0B0h, 09h, 0FEh, 00h, 91h ; 1b863
	DB 09h, 0FEh, 10h, 0A1h, 09h, 0FEh, 20h, 0B1h ; 1b86b
	DB 89h, 0Ch, 00h, 92h, 08h, 01h, 10h, 0A2h ; 1b873
	DB 08h, 11h, 10h, 0A3h, 08h, 01h, 20h, 0B2h ; 1b87b
	DB 08h, 11h, 20h, 0B3h, 88h, 03h, 00h, 92h ; 1b883
	DB 09h, 0Eh, 10h, 0A2h, 09h, 0Eh, 20h, 0B2h ; 1b88b
	DB 09h, 0FEh, 10h, 0A3h, 09h, 0FEh, 20h, 0B3h ; 1b893
	DB 89h, 00h, 00h, 94h, 08h, 10h, 00h, 95h ; 1b89b
	DB 08h, 00h, 10h, 0A4h, 08h, 10h, 10h, 0A5h ; 1b8a3
	DB 08h, 00h, 20h, 0B4h, 08h, 10h, 20h, 0B5h ; 1b8ab
	DB 88h, 0Fh, 00h, 94h, 09h, 0Fh, 10h, 0A4h ; 1b8b3
	DB 09h, 0Fh, 20h, 0B4h, 09h, 0FFh, 00h, 95h ; 1b8bb
	DB 09h, 0FFh, 10h, 0A5h, 09h, 0FFh, 20h, 0B5h ; 1b8c3
	DB 89h, 00h, 00h, 96h, 08h, 10h, 00h, 97h ; 1b8cb
	DB 08h, 00h, 10h, 0A6h, 08h, 10h, 10h, 0A7h ; 1b8d3
	DB 08h, 00h, 20h, 0B6h, 08h, 10h, 20h, 0B7h ; 1b8db
	DB 88h, 00h, 00h, 98h, 08h, 10h, 00h, 99h ; 1b8e3
	DB 08h, 00h, 10h, 0A8h, 08h, 10h, 10h, 0A9h ; 1b8eb
	DB 08h, 00h, 20h, 0B8h, 08h, 10h, 20h, 0B9h ; 1b8f3
	DB 88h, 08h, 00h, 9Ah, 08h, 00h, 10h, 0AAh ; 1b8fb
	DB 08h, 10h, 10h, 0ABh, 08h, 00h, 20h, 0BAh ; 1b903
	DB 08h, 10h, 20h, 0BBh, 88h, 00h, 00h, 9Ch ; 1b90b
	DB 08h, 10h, 00h, 9Dh, 08h, 00h, 10h, 0ACh ; 1b913
	DB 08h, 10h, 10h, 0ADh, 08h, 00h, 20h, 0BCh ; 1b91b
	DB 08h, 10h, 20h, 0BDh, 88h, 00h, 18h ; 1b923
	ASCII "f" ; 1b92a
	DB 08h, 10h, 18h ; 1b92b
	ASCII "g" ; 1b92e
	DB 88h, 00h, 19h ; 1b92f
	ASCII "f" ; 1b932
	DB 08h, 10h, 19h ; 1b933
	ASCII "g" ; 1b936
	DB 88h, 00h, 20h, 9Eh, 08h, 0Fh, 20h, 9Eh ; 1b937
	DB 89h, 00h, 20h, 9Fh, 08h, 0Fh, 20h, 9Fh ; 1b93f
	DB 89h, 00h, 21h, 9Eh, 08h, 0Fh, 21h, 9Eh ; 1b947
	DB 89h, 00h, 21h, 9Fh, 08h, 0Fh, 21h, 9Fh ; 1b94f
	DB 89h, 00h, 0F8h, 0C2h, 08h, 00h, 08h, 0C3h ; 1b957
	DB 88h, 0F8h, 0F8h, 0C4h, 08h, 08h, 0F8h, 0C5h ; 1b95f
	DB 08h, 0F8h, 08h, 0C6h, 08h, 08h, 08h, 0C7h ; 1b967
	DB 88h, 0F8h, 0F8h, 0C8h, 08h, 08h, 0F8h, 0C9h ; 1b96f
	DB 08h, 0F8h, 08h, 0CAh, 08h, 08h, 08h, 0CBh ; 1b977
	DB 88h, 00h, 0F8h, 0CCh, 08h, 00h, 08h, 0CDh ; 1b97f
	DB 88h, 01h, 00h, 90h, 08h, 11h, 00h, 91h ; 1b987
	DB 08h, 01h, 10h, 0A0h, 08h, 11h, 10h, 0A1h ; 1b98f
	DB 08h, 01h, 20h, 0D8h, 08h, 11h, 20h, 0D9h ; 1b997
	DB 88h, 0Eh, 00h, 90h, 09h, 0FEh, 00h, 91h ; 1b99f
	DB 09h, 0Eh, 10h, 0A0h, 09h, 0FEh, 10h, 0A1h ; 1b9a7
	DB 09h, 0Eh, 20h, 0D8h, 09h, 0FEh, 20h, 0D9h ; 1b9af
	DB 89h, 00h, 18h, 0DAh, 08h, 10h, 18h, 0DBh ; 1b9b7
	DB 08h, 00h, 00h, 60h, 08h, 10h, 00h ; 1b9bf
	ASCII "a" ; 1b9c6
	DB 08h, 00h, 10h ; 1b9c7
	ASCII "p" ; 1b9ca
	DB 08h, 10h, 10h ; 1b9cb
	ASCII "q" ; 1b9ce
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1b9cf
	DB 88h, 00h, 18h, 0DCh, 08h, 10h, 18h, 0DDh ; 1b9d7
	DB 08h, 00h, 00h, 60h, 08h, 10h, 00h ; 1b9df
	ASCII "a" ; 1b9e6
	DB 08h, 00h, 10h ; 1b9e7
	ASCII "p" ; 1b9ea
	DB 08h, 10h, 10h ; 1b9eb
	ASCII "q" ; 1b9ee
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1b9ef
	DB 88h, 00h, 18h, 0CFh, 88h, 00h, 18h, 0DEh ; 1b9f7
	DB 88h, 0F9h, 1Eh, 0CFh, 88h, 12h, 18h, 0CFh ; 1b9ff
	DB 88h, 10h, 18h, 0DFh, 88h, 19h, 1Eh, 0CFh ; 1ba07
	DB 88h, 00h, 18h, 0E0h, 08h, 10h, 18h, 0E1h ; 1ba0f
	DB 88h, 00h, 19h, 0E0h, 08h, 10h, 19h, 0E1h ; 1ba17
	DB 88h, 0F5h, 26h, 0CFh, 88h, 1Dh, 26h, 0CFh ; 1ba1f
	DB 88h, 00h, 18h, 0E2h, 08h, 10h, 18h, 0E3h ; 1ba27
	DB 88h, 00h, 19h, 0E2h, 08h, 10h, 19h, 0E3h ; 1ba2f
	DB 88h, 00h, 20h, 9Eh, 08h, 0Fh, 20h, 9Eh ; 1ba37
	DB 09h, 00h, 18h, 0E2h, 08h, 10h, 18h, 0E3h ; 1ba3f
	DB 88h, 00h, 20h, 9Fh, 08h, 0Fh, 20h, 9Fh ; 1ba47
	DB 09h, 00h, 18h, 0E2h, 08h, 10h, 18h, 0E3h ; 1ba4f
	DB 88h, 00h, 21h, 9Eh, 08h, 0Fh, 21h, 9Eh ; 1ba57
	DB 09h, 00h, 19h, 0E2h, 08h, 10h, 19h, 0E3h ; 1ba5f
	DB 88h, 00h, 21h, 9Fh, 08h, 0Fh, 21h, 9Fh ; 1ba67
	DB 09h, 00h, 19h, 0E2h, 08h, 10h, 19h, 0E3h ; 1ba6f
	DB 88h, 0FEh, 00h, 0E4h, 08h, 0EEh, 10h, 0E5h ; 1ba77
	DB 08h, 0FEh, 10h, 0E6h, 08h, 0Eh, 10h, 0E7h ; 1ba7f
	DB 08h, 0FEh, 20h, 0E8h, 08h, 0Eh, 20h, 0E9h ; 1ba87
	DB 88h, 00h, 00h, 60h, 08h, 10h, 00h ; 1ba8f
	ASCII "a" ; 1ba96
	DB 08h, 00h, 10h ; 1ba97
	ASCII "p" ; 1ba9a
	DB 08h, 10h, 10h ; 1ba9b
	ASCII "q" ; 1ba9e
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1ba9f
	DB 08h, 20h, 20h, 0C0h, 88h, 00h, 00h ; 1baa7
	ASCII "b" ; 1baae
	DB 08h, 10h, 00h ; 1baaf
	ASCII "c" ; 1bab2
	DB 08h, 00h, 10h ; 1bab3
	ASCII "r" ; 1bab6
	DB 08h, 10h, 10h ; 1bab7
	ASCII "s" ; 1baba
	DB 08h, 00h, 20h, 82h, 08h, 10h, 20h, 83h ; 1babb
	DB 08h, 20h, 20h, 0C1h, 88h, 00h, 00h ; 1bac3
	ASCII "d" ; 1baca
	DB 08h, 10h, 00h ; 1bacb
	ASCII "e" ; 1bace
	DB 08h, 00h, 10h ; 1bacf
	ASCII "t" ; 1bad2
	DB 08h, 10h, 10h ; 1bad3
	ASCII "u" ; 1bad6
	DB 08h, 00h, 20h, 84h, 08h, 10h, 20h, 85h ; 1bad7
	DB 08h, 20h, 20h, 0C2h, 88h, 0Ch, 10h ; 1badf
	ASCII "v" ; 1bae6
	DB 08h, 00h, 20h, 86h, 08h, 10h, 20h, 87h ; 1bae7
	DB 88h, 00h, 00h ; 1baef
	ASCII "h" ; 1baf2
	DB 08h, 10h, 00h ; 1baf3
	ASCII "i" ; 1baf6
	DB 08h, 00h, 10h ; 1baf7
	ASCII "x" ; 1bafa
	DB 08h, 10h, 10h ; 1bafb
	ASCII "y" ; 1bafe
	DB 08h, 00h, 20h, 88h, 08h, 10h, 20h, 89h ; 1baff
	DB 08h, 20h, 20h, 0C3h, 88h, 0Ch, 0F0h ; 1bb07
	ASCII "v" ; 1bb0e
	DB 08h, 00h, 00h ; 1bb0f
	ASCII "j" ; 1bb12
	DB 08h, 10h, 00h ; 1bb13
	ASCII "k" ; 1bb16
	DB 08h, 00h, 10h ; 1bb17
	ASCII "z" ; 1bb1a
	DB 08h, 10h, 10h, 7Bh, 08h, 00h, 20h, 8Ah ; 1bb1b
	DB 08h, 10h, 20h, 8Bh, 08h, 20h, 20h, 0C4h ; 1bb23
	DB 88h, 00h, 00h ; 1bb2b
	ASCII "l" ; 1bb2e
	DB 08h, 10h, 00h ; 1bb2f
	ASCII "m" ; 1bb32
	DB 08h, 00h, 10h, 7Ch, 08h, 10h, 10h, 7Dh ; 1bb33
	DB 08h, 00h, 20h, 8Ch, 08h, 10h, 20h, 8Dh ; 1bb3b
	DB 08h, 20h, 20h, 0C5h, 88h, 00h, 00h ; 1bb43
	ASCII "n" ; 1bb4a
	DB 08h, 10h, 00h ; 1bb4b
	ASCII "o" ; 1bb4e
	DB 08h, 00h, 10h, 7Eh, 08h, 10h, 10h, 7Fh ; 1bb4f
	DB 08h, 00h, 20h, 8Eh, 08h, 10h, 20h, 8Fh ; 1bb57
	DB 08h, 20h, 20h, 0C6h, 88h, 00h, 00h, 90h ; 1bb5f
	DB 08h, 10h, 00h, 91h, 08h, 00h, 10h, 0A0h ; 1bb67
	DB 08h, 10h, 10h, 0A1h, 08h, 00h, 20h, 0B0h ; 1bb6f
	DB 08h, 10h, 20h, 0B1h, 08h, 20h, 20h, 0C7h ; 1bb77
	DB 88h, 19h, 00h, 90h, 09h, 19h, 10h, 0A0h ; 1bb7f
	DB 09h, 19h, 20h, 0B0h, 09h, 09h, 00h, 91h ; 1bb87
	DB 09h, 09h, 10h, 0A1h, 09h, 09h, 20h, 0B1h ; 1bb8f
	DB 09h, 0F9h, 20h, 0C7h, 89h, 00h, 00h, 92h ; 1bb97
	DB 08h, 10h, 00h, 93h, 08h, 00h, 10h, 0A2h ; 1bb9f
	DB 08h, 10h, 10h, 0A3h, 08h, 00h, 20h, 0B2h ; 1bba7
	DB 08h, 10h, 20h, 0B3h, 08h, 20h, 20h, 0C8h ; 1bbaf
	DB 88h, 19h, 00h, 92h, 09h, 19h, 10h, 0A2h ; 1bbb7
	DB 09h, 19h, 20h, 0B2h, 09h, 09h, 00h, 93h ; 1bbbf
	DB 09h, 09h, 10h, 0A3h, 09h, 09h, 20h, 0B3h ; 1bbc7
	DB 09h, 0F9h, 20h, 0C8h, 89h, 00h, 00h, 94h ; 1bbcf
	DB 08h, 10h, 00h, 95h, 08h, 00h, 10h, 0A4h ; 1bbd7
	DB 08h, 10h, 10h, 0A5h, 08h, 00h, 20h, 0B4h ; 1bbdf
	DB 08h, 10h, 20h, 0B5h, 08h, 20h, 20h, 0C9h ; 1bbe7
	DB 88h, 19h, 00h, 94h, 09h, 19h, 10h, 0A4h ; 1bbef
	DB 09h, 19h, 20h, 0B4h, 09h, 09h, 00h, 95h ; 1bbf7
	DB 09h, 09h, 10h, 0A5h, 09h, 09h, 20h, 0B5h ; 1bbff
	DB 09h, 0FAh, 20h, 0C9h, 89h, 00h, 00h, 96h ; 1bc07
	DB 08h, 10h, 00h, 97h, 08h, 00h, 10h, 0A6h ; 1bc0f
	DB 08h, 10h, 10h, 0A7h, 08h, 00h, 20h, 0B6h ; 1bc17
	DB 08h, 10h, 20h, 0B7h, 08h, 20h, 20h, 0CAh ; 1bc1f
	DB 88h, 00h, 00h, 98h, 08h, 10h, 00h, 99h ; 1bc27
	DB 08h, 00h, 10h, 0A8h, 08h, 10h, 10h, 0A9h ; 1bc2f
	DB 08h, 00h, 20h, 0B8h, 08h, 10h, 20h, 0B9h ; 1bc37
	DB 08h, 20h, 20h, 0CBh, 88h, 0Ch, 0F1h ; 1bc3f
	ASCII "v" ; 1bc46
	DB 08h, 00h, 00h, 9Ah, 08h, 10h, 00h, 9Bh ; 1bc47
	DB 08h, 00h, 10h, 0AAh, 08h, 10h, 10h, 0ABh ; 1bc4f
	DB 08h, 00h, 20h, 0BAh, 08h, 10h, 20h, 0BBh ; 1bc57
	DB 08h, 20h, 20h, 0CCh, 88h, 00h, 0FCh, 9Ch ; 1bc5f
	DB 08h, 00h, 0Ch, 0ACh, 08h, 00h, 1Ch ; 1bc67
	ASCII "w" ; 1bc6e
	DB 08h, 10h, 00h, 9Dh, 08h, 10h, 10h, 0ADh ; 1bc6f
	DB 08h, 10h, 20h, 0BDh, 08h, 20h, 20h, 0CDh ; 1bc77
	DB 88h, 00h, 0FCh, 9Ch, 08h, 00h, 0Ch, 0ACh ; 1bc7f
	DB 08h, 00h, 1Ch, 0BCh, 08h, 10h, 00h, 9Dh ; 1bc87
	DB 08h, 10h, 10h, 0ADh, 08h, 10h, 20h, 0BDh ; 1bc8f
	DB 08h, 20h, 20h, 0CDh, 88h, 00h, 08h ; 1bc97
	ASCII "f" ; 1bc9e
	DB 08h, 10h, 08h ; 1bc9f
	ASCII "g" ; 1bca2
	DB 88h, 00h, 09h ; 1bca3
	ASCII "f" ; 1bca6
	DB 08h, 10h, 09h ; 1bca7
	ASCII "g" ; 1bcaa
	DB 88h, 00h, 10h, 9Eh, 08h, 19h, 10h, 9Eh ; 1bcab
	DB 89h, 00h, 10h, 9Fh, 08h, 19h, 10h, 9Fh ; 1bcb3
	DB 89h, 00h, 11h, 9Eh, 08h, 19h, 11h, 9Eh ; 1bcbb
	DB 89h, 00h, 11h, 9Fh, 08h, 19h, 11h, 9Fh ; 1bcc3
	DB 89h, 0F8h, 0F8h, 0D1h, 08h, 08h, 0F8h, 0D2h ; 1bccb
	DB 08h, 0F8h, 08h, 0D3h, 08h, 08h, 08h, 0D4h ; 1bcd3
	DB 88h, 0F8h, 0F8h, 0D6h, 08h, 08h, 0F8h, 0D7h ; 1bcdb
	DB 08h, 0F8h, 08h, 0D8h, 08h, 08h, 08h, 0D9h ; 1bce3
	DB 88h, 0F8h, 0F8h, 0DAh, 08h, 08h, 0F8h, 0DBh ; 1bceb
	DB 08h, 0F8h, 08h, 0DCh, 08h, 08h, 08h, 0DDh ; 1bcf3
	DB 88h, 0F8h, 0F8h, 0DEh, 08h, 08h, 0F8h, 0DFh ; 1bcfb
	DB 08h, 0F8h, 08h, 0E0h, 08h, 08h, 08h, 0E1h ; 1bd03
	DB 88h, 00h, 00h, 90h, 08h, 10h, 00h, 91h ; 1bd0b
	DB 08h, 00h, 10h, 0A0h, 08h, 10h, 10h, 0A1h ; 1bd13
	DB 08h, 00h, 20h, 0B0h, 08h, 10h, 20h, 0B1h ; 1bd1b
	DB 08h, 20h, 20h, 0C0h, 88h, 19h, 00h, 90h ; 1bd23
	DB 09h, 09h, 00h, 91h, 09h, 19h, 10h, 0A0h ; 1bd2b
	DB 09h, 09h, 10h, 0A1h, 09h, 00h, 20h, 0B0h ; 1bd33
	DB 08h, 10h, 20h, 0B1h, 08h, 20h, 20h, 0C0h ; 1bd3b
	DB 88h, 00h, 08h, 0E2h, 08h, 10h, 08h, 0E3h ; 1bd43
	DB 08h, 00h, 00h, 60h, 08h, 10h, 00h ; 1bd4b
	ASCII "a" ; 1bd52
	DB 08h, 00h, 10h ; 1bd53
	ASCII "p" ; 1bd56
	DB 08h, 10h, 10h ; 1bd57
	ASCII "q" ; 1bd5a
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1bd5b
	DB 08h, 20h, 20h, 0C0h, 88h, 00h, 08h, 0E4h ; 1bd63
	DB 08h, 10h, 08h, 0E5h, 08h, 00h, 00h, 60h ; 1bd6b
	DB 08h, 10h, 00h ; 1bd73
	ASCII "a" ; 1bd76
	DB 08h, 00h, 10h ; 1bd77
	ASCII "p" ; 1bd7a
	DB 08h, 10h, 10h ; 1bd7b
	ASCII "q" ; 1bd7e
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1bd7f
	DB 08h, 20h, 20h, 0C0h, 88h, 08h, 08h, 0E6h ; 1bd87
	DB 88h, 08h, 08h, 0E7h, 88h, 0FFh, 11h, 0CFh ; 1bd8f
	DB 88h, 11h, 08h, 0E6h, 89h, 11h, 08h, 0E7h ; 1bd97
	DB 89h, 1Dh, 11h, 0CFh, 88h, 00h, 08h, 0E9h ; 1bd9f
	DB 08h, 10h, 08h, 0EAh, 88h, 00h, 09h, 0E9h ; 1bda7
	DB 08h, 10h, 09h, 0EAh, 88h, 0FBh, 19h, 0CFh ; 1bdaf
	DB 88h, 21h, 19h, 0CFh, 88h, 00h, 10h, 0EBh ; 1bdb7
	DB 08h, 10h, 10h, 0ECh, 88h, 00h, 11h, 0EBh ; 1bdbf
	DB 08h, 10h, 11h, 0ECh, 88h, 00h, 10h, 9Eh ; 1bdc7
	DB 08h, 19h, 10h, 9Eh, 09h, 00h, 10h, 0EBh ; 1bdcf
	DB 08h, 10h, 10h, 0ECh, 88h, 00h, 10h, 9Fh ; 1bdd7
	DB 08h, 19h, 10h, 9Fh, 09h, 00h, 10h, 0EBh ; 1bddf
	DB 08h, 10h, 10h, 0ECh, 88h, 00h, 11h, 9Eh ; 1bde7
	DB 08h, 19h, 11h, 9Eh, 09h, 00h, 11h, 0EBh ; 1bdef
	DB 08h, 10h, 11h, 0ECh, 88h, 00h, 11h, 9Fh ; 1bdf7
	DB 08h, 19h, 11h, 9Fh, 09h, 00h, 11h, 0EBh ; 1bdff
	DB 08h, 10h, 11h, 0ECh, 88h, 00h, 00h, 0EDh ; 1be07
	DB 08h, 10h, 00h, 0EEh, 08h, 00h, 10h, 0EFh ; 1be0f
	DB 08h, 10h, 10h, 0F0h, 08h, 00h, 20h, 80h ; 1be17
	DB 08h, 10h, 20h, 81h, 08h, 20h, 20h, 0C0h ; 1be1f
	DB 88h, 10h, 00h ; 1be27
	ASCII "a" ; 1be2a
	DB 08h, 00h, 10h ; 1be2b
	ASCII "p" ; 1be2e
	DB 08h, 10h, 10h ; 1be2f
	ASCII "q" ; 1be32
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1be33
	DB 08h, 20h, 1Eh, 60h, 88h, 10h, 00h ; 1be3b
	ASCII "c" ; 1be42
	DB 08h, 00h, 10h ; 1be43
	ASCII "r" ; 1be46
	DB 08h, 10h, 10h ; 1be47
	ASCII "s" ; 1be4a
	DB 08h, 00h, 20h, 82h, 08h, 10h, 20h, 83h ; 1be4b
	DB 08h, 20h, 1Dh ; 1be53
	ASCII "b" ; 1be56
	DB 88h, 10h, 00h ; 1be57
	ASCII "e" ; 1be5a
	DB 08h, 00h, 10h ; 1be5b
	ASCII "t" ; 1be5e
	DB 08h, 10h, 10h ; 1be5f
	ASCII "u" ; 1be62
	DB 08h, 00h, 20h, 84h, 08h, 10h, 20h, 85h ; 1be63
	DB 08h, 20h, 1Eh ; 1be6b
	ASCII "d" ; 1be6e
	DB 88h, 08h, 10h ; 1be6f
	ASCII "v" ; 1be72
	DB 08h, 00h, 20h, 86h, 08h, 10h, 20h, 87h ; 1be73
	DB 88h, 10h, 00h ; 1be7b
	ASCII "i" ; 1be7e
	DB 08h, 00h, 10h ; 1be7f
	ASCII "x" ; 1be82
	DB 08h, 10h, 10h ; 1be83
	ASCII "y" ; 1be86
	DB 08h, 00h, 20h, 88h, 08h, 10h, 20h, 89h ; 1be87
	DB 08h, 20h, 20h ; 1be8f
	ASCII "h" ; 1be92
	DB 88h, 10h, 00h ; 1be93
	ASCII "k" ; 1be96
	DB 08h, 00h, 10h ; 1be97
	ASCII "z" ; 1be9a
	DB 08h, 10h, 10h, 7Bh, 08h, 00h, 20h, 8Ah ; 1be9b
	DB 08h, 10h, 20h, 8Bh, 08h, 20h, 18h ; 1bea3
	ASCII "j" ; 1beaa
	DB 88h, 10h, 00h ; 1beab
	ASCII "m" ; 1beae
	DB 08h, 00h, 10h, 7Ch, 08h, 10h, 10h, 7Dh ; 1beaf
	DB 08h, 00h, 20h, 8Ch, 08h, 10h, 20h, 8Dh ; 1beb7
	DB 08h, 20h, 1Eh ; 1bebf
	ASCII "l" ; 1bec2
	DB 88h, 10h, 00h ; 1bec3
	ASCII "o" ; 1bec6
	DB 08h, 00h, 10h, 7Eh, 08h, 10h, 10h, 7Fh ; 1bec7
	DB 08h, 00h, 20h, 8Eh, 08h, 10h, 20h, 8Fh ; 1becf
	DB 08h, 20h, 1Dh ; 1bed7
	ASCII "n" ; 1beda
	DB 88h, 0Eh, 00h, 91h, 08h, 00h, 10h, 0A0h ; 1bedb
	DB 08h, 10h, 10h, 0A1h, 08h, 00h, 20h, 0B0h ; 1bee3
	DB 08h, 10h, 20h, 0B1h, 08h, 20h, 1Eh, 90h ; 1beeb
	DB 88h, 06h, 00h, 91h, 09h, 14h, 10h, 0A0h ; 1bef3
	DB 09h, 04h, 10h, 0A1h, 09h, 14h, 20h, 0B0h ; 1befb
	DB 09h, 04h, 20h, 0B1h, 09h, 0F4h, 1Eh, 90h ; 1bf03
	DB 89h, 0Fh, 00h, 93h, 08h, 00h, 10h, 0A2h ; 1bf0b
	DB 08h, 10h, 10h, 0A3h, 08h, 00h, 20h, 0B2h ; 1bf13
	DB 08h, 10h, 20h, 0B3h, 08h, 20h, 18h, 92h ; 1bf1b
	DB 88h, 05h, 00h, 93h, 09h, 14h, 10h, 0A2h ; 1bf23
	DB 09h, 04h, 10h, 0A3h, 09h, 14h, 20h, 0B2h ; 1bf2b
	DB 09h, 04h, 20h, 0B3h, 09h, 0F4h, 18h, 92h ; 1bf33
	DB 89h, 08h, 00h, 95h, 08h, 00h, 10h, 0A4h ; 1bf3b
	DB 08h, 10h, 10h, 0A5h, 08h, 00h, 20h, 0B4h ; 1bf43
	DB 08h, 10h, 20h, 0B5h, 08h, 20h, 18h, 94h ; 1bf4b
	DB 88h, 0Ch, 00h, 95h, 09h, 14h, 10h, 0A4h ; 1bf53
	DB 09h, 04h, 10h, 0A5h, 09h, 14h, 20h, 0B4h ; 1bf5b
	DB 09h, 04h, 20h, 0B5h, 09h, 0F4h, 18h, 94h ; 1bf63
	DB 89h, 10h, 00h, 97h, 08h, 00h, 10h, 0A6h ; 1bf6b
	DB 08h, 10h, 10h, 0A7h, 08h, 00h, 20h, 0B6h ; 1bf73
	DB 08h, 10h, 20h, 0B7h, 08h, 20h, 1Dh, 96h ; 1bf7b
	DB 88h, 0Fh, 00h, 99h, 08h, 0FFh, 10h, 0A8h ; 1bf83
	DB 08h, 0Fh, 10h, 0A9h, 08h, 0FFh, 20h, 0B8h ; 1bf8b
	DB 08h, 0Fh, 20h, 0B9h, 08h, 1Fh, 1Dh, 98h ; 1bf93
	DB 88h, 10h, 00h, 9Bh, 08h, 00h, 10h, 0AAh ; 1bf9b
	DB 08h, 10h, 10h, 0ABh, 08h, 00h, 20h, 0BAh ; 1bfa3
	DB 08h, 10h, 20h, 0BBh, 08h, 20h, 18h, 9Ah ; 1bfab
	DB 88h, 10h, 00h, 9Dh, 08h, 00h, 10h, 0ACh ; 1bfb3
	DB 08h, 10h, 10h, 0ADh, 08h, 00h, 20h ; 1bfbb
	ASCII "w" ; 1bfc2
	DB 08h, 10h, 20h, 0BDh, 08h, 20h, 1Eh, 9Ch ; 1bfc3
	DB 88h, 10h, 00h, 9Dh, 08h, 00h, 10h, 0ACh ; 1bfcb
	DB 08h, 10h, 10h, 0ADh, 08h, 00h, 20h, 0BCh ; 1bfd3
	DB 08h, 10h, 20h, 0BDh, 08h, 20h, 1Eh, 9Ch ; 1bfdb
	DB 88h, 00h, 18h ; 1bfe3
	ASCII "f" ; 1bfe6
	DB 08h, 10h, 18h ; 1bfe7
	ASCII "g" ; 1bfea
	DB 88h, 00h, 19h ; 1bfeb
	ASCII "f" ; 1bfee
	DB 08h, 10h, 19h ; 1bfef
	ASCII "g" ; 1bff2
	DB 88h, 00h, 20h, 9Eh, 08h, 14h, 20h, 9Eh ; 1bff3
	DB 89h, 00h, 20h, 9Fh, 08h, 14h, 20h, 9Fh ; 1bffb
	DB 89h, 00h, 21h, 9Eh, 08h, 14h, 21h, 9Eh ; 1c003
	DB 89h, 00h, 21h, 9Fh, 08h, 14h, 21h, 9Fh ; 1c00b
	DB 89h, 0F8h, 0F8h, 0D3h, 08h, 08h, 0F8h, 0D4h ; 1c013
	DB 08h, 0F8h, 08h, 0D5h, 08h, 08h, 08h, 0D6h ; 1c01b
	DB 88h, 00h, 0F8h, 0D7h, 08h, 00h, 08h, 0D8h ; 1c023
	DB 88h, 0Eh, 00h, 91h, 08h, 00h, 10h, 0A0h ; 1c02b
	DB 08h, 10h, 10h, 0A1h, 08h, 00h, 20h, 0B0h ; 1c033
	DB 08h, 10h, 20h, 0CEh, 08h, 20h, 1Eh, 90h ; 1c03b
	DB 88h, 06h, 00h, 91h, 09h, 14h, 10h, 0A0h ; 1c043
	DB 09h, 04h, 10h, 0A1h, 09h, 14h, 20h, 0B0h ; 1c04b
	DB 09h, 04h, 20h, 0CEh, 09h, 0F4h, 1Eh, 90h ; 1c053
	DB 89h, 00h, 18h, 0D9h, 08h, 10h, 18h, 0DAh ; 1c05b
	DB 08h, 10h, 00h ; 1c063
	ASCII "a" ; 1c066
	DB 08h, 00h, 10h ; 1c067
	ASCII "p" ; 1c06a
	DB 08h, 10h, 10h ; 1c06b
	ASCII "q" ; 1c06e
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1c06f
	DB 08h, 20h, 1Eh, 60h, 88h, 00h, 18h, 0DBh ; 1c077
	DB 08h, 10h, 18h, 0DCh, 08h, 10h, 00h ; 1c07f
	ASCII "a" ; 1c086
	DB 08h, 00h, 10h ; 1c087
	ASCII "p" ; 1c08a
	DB 08h, 10h, 10h ; 1c08b
	ASCII "q" ; 1c08e
	DB 08h, 00h, 20h, 80h, 08h, 10h, 20h, 81h ; 1c08f
	DB 08h, 20h, 1Eh, 60h, 88h, 00h, 18h, 0DDh ; 1c097
	DB 88h, 00h, 18h, 0CFh, 88h, 0FFh, 1Fh, 0DEh ; 1c09f
	DB 88h, 14h, 18h, 0DDh, 89h, 10h, 18h, 0DFh ; 1c0a7
	DB 88h, 18h, 1Fh, 0DEh, 88h, 00h, 18h, 0E0h ; 1c0af
	DB 08h, 10h, 18h, 0E1h, 88h, 00h, 19h, 0E0h ; 1c0b7
	DB 08h, 10h, 19h, 0E1h, 88h, 0FBh, 27h, 0DEh ; 1c0bf
	DB 88h, 1Ch, 27h, 0DEh, 88h, 00h, 18h, 0E2h ; 1c0c7
	DB 08h, 10h, 18h, 0E3h, 88h, 00h, 19h, 0E2h ; 1c0cf
	DB 08h, 10h, 19h, 0E3h, 88h, 00h, 20h, 9Eh ; 1c0d7
	DB 08h, 14h, 20h, 9Eh, 09h, 00h, 18h, 0E2h ; 1c0df
	DB 08h, 10h, 18h, 0E3h, 88h, 00h, 20h, 9Fh ; 1c0e7
	DB 08h, 14h, 20h, 9Fh, 09h, 00h, 18h, 0E2h ; 1c0ef
	DB 08h, 10h, 18h, 0E3h, 88h, 00h, 21h, 9Eh ; 1c0f7
	DB 08h, 14h, 21h, 9Eh, 09h, 00h, 19h, 0E2h ; 1c0ff
	DB 08h, 10h, 19h, 0E3h, 88h, 00h, 21h, 9Fh ; 1c107
	DB 08h, 14h, 21h, 9Fh, 09h, 00h, 19h, 0E2h ; 1c10f
	DB 08h, 10h, 19h, 0E3h, 88h, 00h, 00h, 0E4h ; 1c117
	DB 08h, 0F8h, 10h, 0E5h, 08h, 08h, 10h, 0E6h ; 1c11f
	DB 08h, 18h, 10h, 0E7h, 08h, 0F8h, 20h, 0E8h ; 1c127
	DB 08h, 08h, 20h, 0E9h, 08h, 18h, 20h, 0EAh ; 1c12f
	DB 88h, 00h, 00h ; 1c137
	ASCII "g" ; 1c13a
	DB 89h, 00h, 00h ; 1c13b
	ASCII "h" ; 1c13e
	DB 89h, 00h, 00h ; 1c13f
	ASCII "i" ; 1c142
	DB 89h, 03h, 00h, 8Eh, 89h, 04h, 00h, 8Fh ; 1c143
	DB 89h, 04h, 00h, 90h, 89h, 00h, 00h, 0A1h ; 1c14b
	DB 89h, 00h, 00h, 0A2h, 89h, 00h, 00h, 0A3h ; 1c153
	DB 89h, 00h, 00h ; 1c15b
	ASCII "g" ; 1c15e
	DB 89h, 00h, 00h ; 1c15f
	ASCII "h" ; 1c162
	DB 89h, 00h, 00h ; 1c163
	ASCII "i" ; 1c166
	DB 89h, 03h, 00h, 8Eh, 89h, 04h, 00h, 8Fh ; 1c167
	DB 89h, 04h, 00h, 90h, 89h, 00h, 00h, 0A1h ; 1c16f
	DB 89h, 00h, 00h, 0A2h, 89h, 00h, 00h, 0A3h ; 1c177
	DB 89h, 00h, 00h ; 1c17f
	ASCII "p" ; 1c182
	DB 89h, 00h, 00h ; 1c183
	ASCII "q" ; 1c186
	DB 89h, 00h, 00h ; 1c187
	ASCII "r" ; 1c18a
	DB 89h, 00h, 00h ; 1c18b
	ASCII "g" ; 1c18e
	DB 89h, 00h, 00h ; 1c18f
	ASCII "h" ; 1c192
	DB 89h, 00h, 00h ; 1c193
	ASCII "i" ; 1c196
	DB 89h, 00h, 00h ; 1c197
	ASCII "p" ; 1c19a
	DB 89h, 00h, 00h ; 1c19b
	ASCII "q" ; 1c19e
	DB 89h, 00h, 00h ; 1c19f
	ASCII "r" ; 1c1a2
	DB 89h, 00h, 00h ; 1c1a3
	ASCII "s" ; 1c1a6
	DB 89h, 03h, 00h, 8Eh, 89h, 04h, 00h, 8Fh ; 1c1a7
	DB 89h, 04h, 00h, 90h, 89h, 00h, 00h, 0A1h ; 1c1af
	DB 89h, 00h, 00h, 0A2h, 89h, 00h, 00h, 0A3h ; 1c1b7
	DB 89h, 00h, 00h, 13h, 88h, 00h, 00h, 10h ; 1c1bf
	DB 88h, 00h, 00h, 13h, 89h, 00h, 00h, 11h ; 1c1c7
	DB 08h, 00h, 00h, 12h, 88h, 00h, 00h, 11h ; 1c1cf
	DB 08h, 00h, 02h, 12h, 88h, 00h, 00h, 11h ; 1c1d7
	DB 08h, 00h, 03h, 12h, 88h, 00h, 00h, 11h ; 1c1df
	DB 08h, 0FEh, 02h, 12h, 88h, 00h, 00h, 11h ; 1c1e7
	DB 08h, 0FDh, 03h, 12h, 88h, 00h, 00h, 11h ; 1c1ef
	DB 08h, 0FEh, 00h, 12h, 88h, 00h, 00h, 11h ; 1c1f7
	DB 08h, 0FDh, 00h, 12h, 88h, 00h, 00h, 11h ; 1c1ff
	DB 08h, 0FEh, 0FEh, 12h, 88h, 00h, 00h, 11h ; 1c207
	DB 08h, 0FDh, 0FDh, 12h, 88h, 00h, 00h, 11h ; 1c20f
	DB 08h, 00h, 0FEh, 12h, 88h, 00h, 00h, 11h ; 1c217
	DB 08h, 00h, 0FDh, 12h, 88h, 00h, 00h, 11h ; 1c21f
	DB 08h, 02h, 0FEh, 12h, 88h, 00h, 00h, 11h ; 1c227
	DB 08h, 03h, 0FDh, 12h, 88h, 00h, 00h, 11h ; 1c22f
	DB 08h, 02h, 00h, 12h, 88h, 00h, 00h, 11h ; 1c237
	DB 08h, 03h, 00h, 12h, 88h, 00h, 00h, 11h ; 1c23f
	DB 08h, 02h, 02h, 12h, 88h, 00h, 00h, 11h ; 1c247
	DB 08h, 03h, 03h, 12h, 88h, 00h, 20h, 0AEh ; 1c24f
	DB 88h, 00h, 21h, 0AEh, 88h, 00h, 21h, 0AEh ; 1c257
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 00h, 0C1h ; 1c25f
	DB 88h, 00h, 1Ah, 0AEh, 88h, 00h, 1Dh, 0AEh ; 1c267
	DB 88h, 00h, 00h, 0C1h, 88h, 0FDh, 20h, 0AEh ; 1c26f
	DB 88h, 04h, 20h, 0AEh, 88h, 0FDh, 1Eh, 0AEh ; 1c277
	DB 88h, 04h, 1Eh, 0AEh, 88h, 00h, 00h, 0C1h ; 1c27f
	DB 88h, 04h, 22h, 0AEh, 88h, 00h, 21h, 0AEh ; 1c287
	DB 88h, 00h, 1Fh, 0AEh, 88h, 00h, 1Bh, 0AEh ; 1c28f
	DB 88h, 00h, 23h, 0AEh, 88h, 0FDh, 20h, 0AEh ; 1c297
	DB 88h, 04h, 20h, 0AEh, 88h, 00h, 20h, 0AEh ; 1c29f
	DB 08h, 10h, 20h, 0AFh, 08h, 00h, 10h, 0BEh ; 1c2a7
	DB 08h, 10h, 10h, 0BFh, 08h, 08h, 20h, 0C0h ; 1c2af
	DB 88h, 00h, 22h, 0AEh, 88h, 00h, 23h, 0AEh ; 1c2b7
	DB 88h, 0FFh, 21h, 0AEh, 88h, 10h, 20h, 0AFh ; 1c2bf
	DB 88h, 10h, 21h, 0AFh, 88h, 10h, 21h, 0AFh ; 1c2c7
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 00h, 0C1h ; 1c2cf
	DB 88h, 10h, 1Ah, 0AFh, 88h, 10h, 1Dh, 0AFh ; 1c2d7
	DB 88h, 00h, 00h, 0C1h, 88h, 0Dh, 20h, 0AFh ; 1c2df
	DB 88h, 14h, 20h, 0AFh, 88h, 0Dh, 1Fh, 0AFh ; 1c2e7
	DB 88h, 14h, 1Eh, 0AFh, 88h, 0Eh, 22h, 0AFh ; 1c2ef
	DB 88h, 00h, 00h, 0C1h, 88h, 10h, 21h, 0AFh ; 1c2f7
	DB 88h, 10h, 1Fh, 0AFh, 88h, 10h, 1Bh, 0AFh ; 1c2ff
	DB 88h, 10h, 23h, 0AFh, 88h, 0Dh, 20h, 0AFh ; 1c307
	DB 88h, 14h, 20h, 0AFh, 88h, 00h, 20h, 0AEh ; 1c30f
	DB 08h, 10h, 20h, 0AFh, 08h, 00h, 10h, 0BEh ; 1c317
	DB 08h, 10h, 10h, 0BFh, 08h, 08h, 20h, 0C0h ; 1c31f
	DB 88h, 10h, 22h, 0AFh, 88h, 10h, 23h, 0AFh ; 1c327
	DB 88h, 10h, 20h, 0AFh, 88h, 00h, 10h, 0BEh ; 1c32f
	DB 88h, 00h, 11h, 0BEh, 88h, 00h, 12h, 0BEh ; 1c337
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 16h, 0BEh ; 1c33f
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 00h, 0C1h ; 1c347
	DB 88h, 00h, 13h, 0BEh, 88h, 0FDh, 10h, 0BEh ; 1c34f
	DB 88h, 03h, 10h, 0BEh, 88h, 00h, 00h, 0C1h ; 1c357
	DB 88h, 03h, 0Eh, 0BEh, 88h, 0FDh, 12h, 0BEh ; 1c35f
	DB 88h, 04h, 12h, 0BEh, 88h, 00h, 0Fh, 0BEh ; 1c367
	DB 88h, 00h, 10h, 0BEh, 88h, 00h, 00h, 0C1h ; 1c36f
	DB 88h, 0FFh, 12h, 0BEh, 88h, 0FDh, 10h, 0BEh ; 1c377
	DB 88h, 03h, 10h, 0BEh, 88h, 00h, 20h, 0AEh ; 1c37f
	DB 08h, 10h, 20h, 0AFh, 08h, 00h, 10h, 0BEh ; 1c387
	DB 08h, 10h, 10h, 0BFh, 08h, 08h, 20h, 0C0h ; 1c38f
	DB 88h, 00h, 10h, 0BEh, 88h, 00h, 11h, 0BEh ; 1c397
	DB 88h, 0FCh, 12h, 0BEh, 88h, 10h, 10h, 0BFh ; 1c39f
	DB 88h, 10h, 11h, 0BFh, 88h, 10h, 12h, 0BFh ; 1c3a7
	DB 88h, 00h, 00h, 0C1h, 88h, 10h, 16h, 0BFh ; 1c3af
	DB 88h, 10h, 0Ah, 0BFh, 88h, 10h, 0Dh, 0BFh ; 1c3b7
	DB 88h, 10h, 13h, 0BFh, 88h, 0Dh, 10h, 0BFh ; 1c3bf
	DB 88h, 13h, 10h, 0BFh, 88h, 0Dh, 0Eh, 0BFh ; 1c3c7
	DB 88h, 13h, 0Eh, 0BFh, 88h, 0Dh, 12h, 0BFh ; 1c3cf
	DB 88h, 13h, 12h, 0BFh, 88h, 10h, 0Fh, 0BFh ; 1c3d7
	DB 88h, 10h, 10h, 0BFh, 88h, 10h, 0Bh, 0BFh ; 1c3df
	DB 88h, 11h, 12h, 0BFh, 88h, 0Dh, 10h, 0BFh ; 1c3e7
	DB 88h, 13h, 10h, 0BFh, 88h, 00h, 20h, 0AEh ; 1c3ef
	DB 08h, 10h, 20h, 0AFh, 08h, 00h, 10h, 0BEh ; 1c3f7
	DB 08h, 10h, 10h, 0BFh, 08h, 08h, 20h, 0C0h ; 1c3ff
	DB 88h, 10h, 10h, 0BFh, 88h, 10h, 11h, 0BFh ; 1c407
	DB 88h, 0Ch, 0Eh, 0BFh, 88h, 08h, 20h, 0C0h ; 1c40f
	DB 88h, 08h, 21h, 0C0h, 88h, 08h, 22h, 0C0h ; 1c417
	DB 88h, 00h, 00h, 0C1h, 88h, 08h, 22h, 0C0h ; 1c41f
	DB 88h, 08h, 1Eh, 0C0h, 88h, 08h, 1Fh, 0C0h ; 1c427
	DB 88h, 08h, 21h, 0C0h, 88h, 06h, 20h, 0C0h ; 1c42f
	DB 88h, 0Ah, 20h, 0C0h, 88h, 06h, 20h, 0C0h ; 1c437
	DB 88h, 0Ah, 20h, 0C0h, 88h, 06h, 21h, 0C0h ; 1c43f
	DB 88h, 0Ah, 21h, 0C0h, 88h, 08h, 20h, 0C0h ; 1c447
	DB 88h, 08h, 20h, 0C0h, 88h, 08h, 1Fh, 0C0h ; 1c44f
	DB 88h, 08h, 21h, 0C0h, 88h, 08h, 20h, 0C0h ; 1c457
	DB 88h, 08h, 20h, 0C0h, 88h, 00h, 20h, 0AEh ; 1c45f
	DB 08h, 10h, 20h, 0AFh, 08h, 00h, 10h, 0BEh ; 1c467
	DB 08h, 10h, 10h, 0BFh, 08h, 08h, 20h, 0C0h ; 1c46f
	DB 88h, 08h, 20h, 0C0h, 88h, 08h, 21h, 0C0h ; 1c477
	DB 88h, 08h, 1Fh, 0C0h, 88h, 10h, 10h, 0AEh ; 1c47f
	DB 88h, 10h, 11h, 0AEh, 88h, 00h, 00h, 0CEh ; 1c487
	DB 88h, 00h, 00h, 0CEh, 88h, 00h, 00h, 0CEh ; 1c48f
	DB 88h, 10h, 0Bh, 0AEh, 88h, 10h, 0Ch, 0AEh ; 1c497
	DB 88h, 00h, 00h, 0CEh, 88h, 0Eh, 10h, 0AEh ; 1c49f
	DB 88h, 11h, 10h, 0AEh, 88h, 0Dh, 0Ch, 0AEh ; 1c4a7
	DB 88h, 11h, 0Ch, 0AEh, 88h, 10h, 11h, 0AEh ; 1c4af
	DB 88h, 10h, 11h, 0AEh, 88h, 10h, 11h, 0AEh ; 1c4b7
	DB 88h, 10h, 0Fh, 0AEh, 88h, 10h, 0Bh, 0AEh ; 1c4bf
	DB 88h, 00h, 00h, 0CEh, 88h, 00h, 00h, 0CEh ; 1c4c7
	DB 88h, 0Eh, 10h, 0AEh, 88h, 11h, 10h, 0AEh ; 1c4cf
	DB 88h, 10h, 10h, 0AEh, 08h, 08h, 00h, 0AFh ; 1c4d7
	DB 08h, 10h, 08h, 0BEh, 08h, 08h, 20h, 0BFh ; 1c4df
	DB 88h, 10h, 11h, 0AEh, 88h, 10h, 12h, 0AEh ; 1c4e7
	DB 88h, 0Fh, 0Fh, 0AEh, 88h, 08h, 00h, 0AFh ; 1c4ef
	DB 88h, 08h, 01h, 0AFh, 88h, 08h, 01h, 0AFh ; 1c4f7
	DB 88h, 08h, 1Dh, 0AFh, 88h, 08h, 05h, 0AFh ; 1c4ff
	DB 88h, 08h, 0FDh, 0AFh, 88h, 08h, 0FDh, 0AFh ; 1c507
	DB 88h, 08h, 02h, 0AFh, 88h, 07h, 00h, 0AFh ; 1c50f
	DB 88h, 0Bh, 00h, 0AFh, 88h, 0Ah, 00h, 0AFh ; 1c517
	DB 88h, 09h, 00h, 0AFh, 88h, 05h, 02h, 0AFh ; 1c51f
	DB 88h, 0Ch, 01h, 0AFh, 88h, 08h, 0FFh, 0AFh ; 1c527
	DB 88h, 08h, 00h, 0AFh, 88h, 08h, 0FCh, 0AFh ; 1c52f
	DB 88h, 08h, 04h, 0AFh, 88h, 08h, 04h, 0AFh ; 1c537
	DB 88h, 07h, 00h, 0AFh, 88h, 0Bh, 00h, 0AFh ; 1c53f
	DB 88h, 08h, 00h, 0AFh, 88h, 08h, 01h, 0AFh ; 1c547
	DB 88h, 03h, 02h, 0AFh, 88h, 10h, 08h, 0BEh ; 1c54f
	DB 88h, 10h, 09h, 0BEh, 88h, 10h, 0Ah, 0BEh ; 1c557
	DB 88h, 00h, 00h, 0CEh, 88h, 10h, 0Fh, 0BEh ; 1c55f
	DB 88h, 10h, 03h, 0BEh, 88h, 10h, 04h, 0BEh ; 1c567
	DB 88h, 10h, 0Dh, 0BEh, 88h, 0Dh, 08h, 0BEh ; 1c56f
	DB 88h, 14h, 08h, 0BEh, 88h, 0Dh, 06h, 0BEh ; 1c577
	DB 88h, 14h, 04h, 0BEh, 88h, 0Bh, 0Ah, 0BEh ; 1c57f
	DB 88h, 15h, 0Ah, 0BEh, 88h, 10h, 07h, 0BEh ; 1c587
	DB 88h, 10h, 08h, 0BEh, 88h, 10h, 03h, 0BEh ; 1c58f
	DB 88h, 10h, 0Dh, 0BEh, 88h, 10h, 0Dh, 0BEh ; 1c597
	DB 88h, 0Dh, 08h, 0BEh, 88h, 14h, 08h, 0BEh ; 1c59f
	DB 88h, 10h, 08h, 0BEh, 88h, 10h, 09h, 0BEh ; 1c5a7
	DB 88h, 0Dh, 07h, 0BEh, 88h, 08h, 20h, 0BFh ; 1c5af
	DB 88h, 08h, 21h, 0BFh, 88h, 08h, 21h, 0BFh ; 1c5b7
	DB 88h, 00h, 00h, 0CEh, 88h, 08h, 22h, 0BFh ; 1c5bf
	DB 88h, 08h, 1Fh, 0BFh, 88h, 08h, 20h, 0BFh ; 1c5c7
	DB 88h, 08h, 20h, 0BFh, 88h, 08h, 20h, 0BFh ; 1c5cf
	DB 88h, 08h, 20h, 0BFh, 88h, 08h, 20h, 0BFh ; 1c5d7
	DB 88h, 08h, 20h, 0BFh, 88h, 08h, 20h, 0BFh ; 1c5df
	DB 88h, 08h, 20h, 0BFh, 88h, 08h, 20h, 0BFh ; 1c5e7
	DB 88h, 08h, 20h, 0BFh, 88h, 08h, 20h, 0BFh ; 1c5ef
	DB 88h, 08h, 23h, 0BFh, 88h, 08h, 23h, 0BFh ; 1c5f7
	DB 88h, 08h, 20h, 0BFh, 88h, 08h, 20h, 0BFh ; 1c5ff
	DB 88h, 08h, 20h, 0BFh, 88h, 08h, 21h, 0BFh ; 1c607
	DB 88h, 08h, 20h, 0BFh, 88h, 00h, 20h, 0AEh ; 1c60f
	DB 88h, 00h, 21h, 0AEh, 88h, 00h, 1Fh, 0AEh ; 1c617
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 26h, 0AEh ; 1c61f
	DB 88h, 00h, 19h, 0AEh, 88h, 00h, 1Ah, 0AEh ; 1c627
	DB 88h, 00h, 22h, 0AEh, 88h, 0FDh, 20h, 0AEh ; 1c62f
	DB 88h, 03h, 20h, 0AEh, 88h, 0FDh, 1Bh, 0AEh ; 1c637
	DB 88h, 03h, 1Bh, 0AEh, 88h, 0FDh, 21h, 0AEh ; 1c63f
	DB 88h, 03h, 21h, 0AEh, 88h, 00h, 20h, 0AEh ; 1c647
	DB 88h, 00h, 1Fh, 0AEh, 88h, 00h, 19h, 0AEh ; 1c64f
	DB 88h, 00h, 21h, 0AEh, 88h, 00h, 21h, 0AEh ; 1c657
	DB 88h, 0FDh, 20h, 0AEh, 88h, 03h, 20h, 0AEh ; 1c65f
	DB 88h, 00h, 20h, 0AEh, 08h, 10h, 20h, 0AFh ; 1c667
	DB 08h, 00h, 10h, 0BEh, 08h, 10h, 10h, 0BFh ; 1c66f
	DB 08h, 10h, 20h, 0C0h, 88h, 00h, 20h, 0AEh ; 1c677
	DB 88h, 00h, 21h, 0AEh, 88h, 00h, 22h, 0AEh ; 1c67f
	DB 88h, 10h, 20h, 0AFh, 88h, 10h, 21h, 0AFh ; 1c687
	DB 88h, 10h, 21h, 0AFh, 88h, 00h, 00h, 0C1h ; 1c68f
	DB 88h, 10h, 26h, 0AFh, 88h, 10h, 19h, 0AFh ; 1c697
	DB 88h, 10h, 1Ah, 0AFh, 88h, 10h, 22h, 0AFh ; 1c69f
	DB 88h, 0Dh, 20h, 0AFh, 88h, 13h, 20h, 0AFh ; 1c6a7
	DB 88h, 0Dh, 1Bh, 0AFh, 88h, 13h, 1Bh, 0AFh ; 1c6af
	DB 88h, 0Dh, 21h, 0AFh, 88h, 13h, 21h, 0AFh ; 1c6b7
	DB 88h, 10h, 22h, 0AFh, 88h, 10h, 1Fh, 0AFh ; 1c6bf
	DB 88h, 10h, 19h, 0AFh, 88h, 10h, 21h, 0AFh ; 1c6c7
	DB 88h, 10h, 21h, 0AFh, 88h, 0Dh, 20h, 0AFh ; 1c6cf
	DB 88h, 13h, 20h, 0AFh, 88h, 10h, 21h, 0AFh ; 1c6d7
	DB 88h, 10h, 22h, 0AFh, 88h, 12h, 1Fh, 0AFh ; 1c6df
	DB 88h, 00h, 10h, 0BEh, 88h, 00h, 11h, 0BEh ; 1c6e7
	DB 88h, 00h, 0Fh, 0BEh, 88h, 00h, 00h, 0C1h ; 1c6ef
	DB 88h, 00h, 16h, 0BEh, 88h, 00h, 00h, 0C1h ; 1c6f7
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 13h, 0BEh ; 1c6ff
	DB 88h, 0FFh, 10h, 0BEh, 88h, 03h, 10h, 0BEh ; 1c707
	DB 88h, 00h, 00h, 0C1h, 88h, 03h, 0Ch, 0BEh ; 1c70f
	DB 88h, 0FFh, 12h, 0BEh, 88h, 03h, 12h, 0BEh ; 1c717
	DB 88h, 00h, 10h, 0BEh, 88h, 00h, 10h, 0BEh ; 1c71f
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 12h, 0BEh ; 1c727
	DB 88h, 00h, 12h, 0BEh, 88h, 0FFh, 10h, 0BEh ; 1c72f
	DB 88h, 03h, 10h, 0BEh, 88h, 00h, 10h, 0BEh ; 1c737
	DB 88h, 00h, 11h, 0BEh, 88h, 0FEh, 13h, 0BEh ; 1c73f
	DB 88h, 10h, 10h, 0BFh, 88h, 10h, 11h, 0BFh ; 1c747
	DB 88h, 10h, 0Fh, 0BFh, 88h, 00h, 00h, 0C1h ; 1c74f
	DB 88h, 10h, 16h, 0BFh, 88h, 00h, 00h, 0C1h ; 1c757
	DB 88h, 00h, 00h, 0C1h, 88h, 10h, 13h, 0BFh ; 1c75f
	DB 88h, 0Dh, 10h, 0BFh, 88h, 13h, 10h, 0BFh ; 1c767
	DB 88h, 0Dh, 0Ch, 0BFh, 88h, 00h, 00h, 0C1h ; 1c76f
	DB 88h, 0Dh, 12h, 0BFh, 88h, 13h, 12h, 0BFh ; 1c777
	DB 88h, 10h, 10h, 0BFh, 88h, 10h, 10h, 0BFh ; 1c77f
	DB 88h, 00h, 00h, 0C1h, 88h, 10h, 12h, 0BFh ; 1c787
	DB 88h, 10h, 12h, 0BFh, 88h, 0Dh, 10h, 0BFh ; 1c78f
	DB 88h, 13h, 10h, 0BFh, 88h, 10h, 10h, 0BFh ; 1c797
	DB 88h, 10h, 11h, 0BFh, 88h, 0Eh, 10h, 0BFh ; 1c79f
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7a7
	DB 88h, 10h, 20h, 0C0h, 88h, 00h, 00h, 0C1h ; 1c7af
	DB 88h, 00h, 00h, 0C1h, 88h, 10h, 1Eh, 0C0h ; 1c7b7
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7bf
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7c7
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7cf
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7d7
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7df
	DB 88h, 10h, 1Eh, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7e7
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7ef
	DB 88h, 10h, 20h, 0C0h, 88h, 10h, 20h, 0C0h ; 1c7f7
	DB 88h, 10h, 20h, 0C0h, 88h, 11h, 20h, 0C0h ; 1c7ff
	DB 88h, 00h, 00h, 00h, 88h, 00h, 00h, 02h ; 1c807
	DB 88h, 01h, 00h, 02h, 88h, 02h, 00h, 02h ; 1c80f
	DB 88h, 00h, 00h, 03h, 88h, 00h, 01h, 03h ; 1c817
	DB 88h, 00h, 02h, 03h, 88h, 00h, 00h, 01h ; 1c81f
	DB 88h, 40h, 00h, 04h, 08h ; 1c827
	ASCIZ "P" ; 1c82c
	DB 05h, 08h, 40h, 10h, 06h, 08h ; 1c82e
	ASCII "P" ; 1c834
	DB 10h, 07h, 08h, 40h, 20h, 08h, 08h ; 1c835
	ASCII "P " ; 1c83c
	DB 09h, 08h, 40h ; 1c83e
	ASCII "0" ; 1c841
	DB 0Ah, 08h ; 1c842
	ASCII "P0" ; 1c844
	DB 0Bh, 88h, 40h, 00h, 0Ch, 08h ; 1c846
	ASCIZ "P" ; 1c84c
	DB 0Dh, 08h, 40h, 10h, 0Eh, 08h ; 1c84e
	ASCII "P" ; 1c854
	DB 10h, 07h, 08h, 40h, 20h, 10h, 08h ; 1c855
	ASCII "P " ; 1c85c
	DB 0Fh, 08h, 40h ; 1c85e
	ASCII "0" ; 1c861
	DB 0Ah, 08h ; 1c862
	ASCII "P0" ; 1c864
	DB 11h, 88h, 40h, 10h, 12h, 08h ; 1c866
	ASCII "P" ; 1c86c
	DB 10h, 13h, 88h, 40h, 10h, 14h, 08h ; 1c86d
	ASCII "P" ; 1c874
	DB 10h, 15h, 88h, 40h, 10h, 16h, 08h ; 1c875
	ASCII "P" ; 1c87c
	DB 10h, 17h, 88h, 40h, 18h, 18h, 08h ; 1c87d
	ASCII "P" ; 1c884
	DB 18h, 19h, 88h, 40h, 18h, 1Ah, 08h ; 1c885
	ASCII "P" ; 1c88c
	DB 18h, 1Bh, 88h, 00h, 00h, 00h, 08h, 0F4h ; 1c88d
	DB 0F8h, 06h, 88h, 00h, 00h, 01h, 08h, 0F4h ; 1c895
	DB 0F8h, 07h, 88h, 00h, 00h, 02h, 08h, 0F4h ; 1c89d
	DB 0F8h, 06h, 88h, 00h, 00h, 03h, 08h, 0F4h ; 1c8a5
	DB 0F8h, 07h, 88h, 00h, 00h, 04h, 08h, 0F4h ; 1c8ad
	DB 0F8h, 06h, 88h, 00h, 00h, 05h, 08h, 0F4h ; 1c8b5
	DB 0F8h, 07h, 88h, 0FCh, 00h, 0Dh, 88h, 0FCh ; 1c8bd
	DB 00h, 0Ch, 88h, 0FCh, 00h, 0Dh, 89h, 0FCh ; 1c8c5
	DB 00h, 0Ch, 89h, 00h, 00h, 0Eh, 88h, 00h ; 1c8cd
	DB 00h, 0Fh, 88h, 00h, 00h, 18h, 88h, 00h ; 1c8d5
	DB 00h, 19h, 88h, 00h, 00h, 1Ah, 88h, 00h ; 1c8dd
	DB 00h, 1Bh, 88h, 00h, 00h, 1Ch, 88h, 00h ; 1c8e5
	DB 00h, 1Dh, 88h, 00h, 00h, 1Eh, 88h, 00h ; 1c8ed
	DB 00h, 1Fh, 88h, 00h, 00h, 20h, 88h, 00h ; 1c8f5
	DB 00h, 21h, 88h, 00h, 00h, 22h, 88h, 00h ; 1c8fd
	DB 00h, 23h, 88h, 00h, 00h, 24h, 88h, 00h ; 1c905
	DB 00h, 25h, 88h, 00h, 00h, 26h, 88h, 00h ; 1c90d
	DB 00h, 27h, 88h, 00h, 00h, 28h, 88h, 00h ; 1c915
	DB 00h, 29h, 88h, 00h, 00h, 2Ah, 88h, 00h ; 1c91d
	DB 00h, 2Bh, 88h, 00h, 00h, 2Ch, 88h, 00h ; 1c925
	DB 00h, 2Dh, 88h, 00h, 00h, 2Eh, 88h, 00h ; 1c92d
	DB 00h, 2Fh, 88h, 00h, 00h ; 1c935
	ASCII "0" ; 1c93a
	DB 88h, 00h, 00h ; 1c93b
	ASCII "1" ; 1c93e
	DB 88h, 00h, 00h ; 1c93f
	ASCII "2" ; 1c942
	DB 88h, 00h, 00h ; 1c943
	ASCII "3" ; 1c946
	DB 88h, 00h, 00h ; 1c947
	ASCII "4" ; 1c94a
	DB 88h, 00h, 00h ; 1c94b
	ASCII "5" ; 1c94e
	DB 88h, 00h, 00h ; 1c94f
	ASCII "6" ; 1c952
	DB 88h, 00h, 00h ; 1c953
	ASCII "7" ; 1c956
	DB 88h, 00h, 00h ; 1c957
	ASCII "8" ; 1c95a
	DB 88h, 00h, 00h ; 1c95b
	ASCII "l" ; 1c95e
	DB 88h, 00h, 00h ; 1c95f
	ASCII "m" ; 1c962
	DB 88h, 00h, 00h, 3Bh, 88h, 00h, 00h, 3Ch ; 1c963
	DB 88h, 00h, 00h, 3Dh, 88h, 00h, 00h, 3Eh ; 1c96b
	DB 88h, 00h, 00h, 3Fh, 88h, 00h, 00h, 40h ; 1c973
	DB 88h, 00h, 00h ; 1c97b
	ASCII "A" ; 1c97e
	DB 88h, 00h, 00h ; 1c97f
	ASCII "B" ; 1c982
	DB 88h, 00h, 00h ; 1c983
	ASCII "C" ; 1c986
	DB 88h, 00h, 00h ; 1c987
	ASCII "D" ; 1c98a
	DB 88h, 00h, 00h ; 1c98b
	ASCII "E" ; 1c98e
	DB 88h, 00h, 00h ; 1c98f
	ASCII "F" ; 1c992
	DB 88h, 00h, 00h ; 1c993
	ASCII "G" ; 1c996
	DB 88h, 00h, 00h ; 1c997
	ASCII "H" ; 1c99a
	DB 88h, 00h, 00h ; 1c99b
	ASCII "I" ; 1c99e
	DB 88h, 00h, 00h ; 1c99f
	ASCII "J" ; 1c9a2
	DB 88h, 00h, 00h ; 1c9a3
	ASCII "K" ; 1c9a6
	DB 88h, 00h, 00h ; 1c9a7
	ASCII "L" ; 1c9aa
	DB 88h, 00h, 00h ; 1c9ab
	ASCII "M" ; 1c9ae
	DB 88h, 00h, 00h ; 1c9af
	ASCII "N" ; 1c9b2
	DB 88h, 00h, 00h ; 1c9b3
	ASCII "O" ; 1c9b6
	DB 88h, 00h, 00h ; 1c9b7
	ASCII "P" ; 1c9ba
	DB 88h, 00h, 00h ; 1c9bb
	ASCII "Q" ; 1c9be
	DB 88h, 00h, 00h ; 1c9bf
	ASCII "R" ; 1c9c2
	DB 88h, 00h, 00h ; 1c9c3
	ASCII "S" ; 1c9c6
	DB 88h, 00h, 00h ; 1c9c7
	ASCII "T" ; 1c9ca
	DB 88h, 00h, 00h ; 1c9cb
	ASCII "U" ; 1c9ce
	DB 88h, 00h, 00h ; 1c9cf
	ASCII "V" ; 1c9d2
	DB 88h, 00h, 00h ; 1c9d3
	ASCII "W" ; 1c9d6
	DB 88h, 00h, 00h ; 1c9d7
	ASCII "X" ; 1c9da
	DB 88h, 00h, 00h ; 1c9db
	ASCII "Y" ; 1c9de
	DB 88h, 00h, 00h ; 1c9df
	ASCII "Z" ; 1c9e2
	DB 88h, 00h, 00h, 5Bh, 88h, 00h, 00h, 5Ch ; 1c9e3
	DB 88h, 00h, 00h, 5Dh, 88h, 00h, 00h, 5Eh ; 1c9eb
	DB 88h, 00h, 00h, 5Fh, 88h, 00h, 00h, 60h ; 1c9f3
	DB 88h, 00h, 00h ; 1c9fb
	ASCII "a" ; 1c9fe
	DB 88h, 00h, 00h ; 1c9ff
	ASCII "b" ; 1ca02
	DB 88h, 00h, 00h ; 1ca03
	ASCII "c" ; 1ca06
	DB 88h, 00h, 00h ; 1ca07
	ASCII "d" ; 1ca0a
	DB 88h, 00h, 00h ; 1ca0b
	ASCII "e" ; 1ca0e
	DB 88h, 00h, 00h ; 1ca0f
	ASCII "f" ; 1ca12
	DB 88h, 00h, 00h ; 1ca13
	ASCII "g" ; 1ca16
	DB 88h, 00h, 00h ; 1ca17
	ASCII "h" ; 1ca1a
	DB 88h, 00h, 00h ; 1ca1b
	ASCII "i" ; 1ca1e
	DB 88h, 00h, 00h ; 1ca1f
	ASCII "j" ; 1ca22
	DB 88h, 00h, 00h ; 1ca23
	ASCII "k" ; 1ca26
	DB 88h, 00h, 00h, 10h, 88h, 00h, 00h, 11h ; 1ca27
	DB 88h, 00h, 00h, 12h, 88h, 00h, 00h, 13h ; 1ca2f
	DB 88h, 00h, 00h, 14h, 88h, 00h, 00h, 15h ; 1ca37
	DB 88h, 00h, 00h, 16h, 88h, 00h, 00h, 17h ; 1ca3f
	DB 88h, 28h, 0FBh, 0Ah, 88h, 28h, 0FBh, 0Bh ; 1ca47
	DB 88h, 28h ; 1ca4f
	ASCII "5" ; 1ca51
	DB 0Ah, 8Ah, 28h ; 1ca52
	ASCII "5" ; 1ca55
	DB 0Bh, 8Ah, 00h, 00h, 00h, 88h, 00h, 00h ; 1ca56
	DB 01h, 88h, 00h, 00h, 02h, 88h, 00h, 00h ; 1ca5e
	DB 03h, 88h, 00h, 00h, 04h, 88h, 00h, 00h ; 1ca66
	DB 05h, 88h, 00h, 00h, 06h, 88h, 00h, 00h ; 1ca6e
	DB 07h, 88h, 00h, 00h, 08h, 88h, 00h, 00h ; 1ca76
	DB 09h, 88h, 00h, 00h, 0Ah, 88h, 00h, 00h ; 1ca7e
	DB 0Bh, 08h, 0Ch, 00h, 0Bh, 88h, 00h, 00h ; 1ca86
	DB 0Ch, 08h, 10h, 00h, 0Dh, 88h, 00h, 00h ; 1ca8e
	DB 0Eh, 08h, 10h, 00h, 0Fh, 88h, 00h, 00h ; 1ca96
	DB 10h, 08h, 10h, 00h, 11h, 88h, 00h, 00h ; 1ca9e
	DB 12h, 08h, 10h, 00h, 13h, 88h, 00h, 00h ; 1caa6
	DB 14h, 08h, 10h, 00h, 15h, 88h, 00h, 00h ; 1caae
	DB 16h, 08h, 10h, 00h, 17h, 88h, 00h, 00h ; 1cab6
	DB 18h, 08h, 10h, 00h, 19h, 88h, 00h, 00h ; 1cabe
	DB 1Ah, 08h, 10h, 00h, 1Bh, 88h, 03h, 03h ; 1cac6
	DB 01h, 08h, 00h, 00h, 00h, 88h, 03h, 03h ; 1cace
	DB 03h, 08h, 00h, 00h, 02h, 88h, 00h, 00h ; 1cad6
	DB 04h, 88h, 0F8h, 0F5h, 05h, 08h, 08h, 0F5h ; 1cade
	DB 06h, 88h, 0F8h, 0F5h, 07h, 08h, 08h, 0F5h ; 1cae6
	DB 08h, 08h, 0F8h, 05h, 09h, 88h, 0F0h, 0F5h ; 1caee
	DB 0Ah, 08h, 00h, 0F5h, 0Bh, 08h, 10h, 0F5h ; 1caf6
	DB 0Ch, 88h, 00h, 00h, 0Dh, 88h, 00h, 00h ; 1cafe
	DB 0Eh, 88h, 0FEh, 00h, 0Fh, 88h, 0FCh, 00h ; 1cb06
	DB 10h, 88h, 02h, 00h, 11h, 88h, 04h, 00h ; 1cb0e
	DB 12h, 88h, 00h, 00h, 13h, 88h, 00h, 00h ; 1cb16
	DB 14h, 88h, 00h, 00h, 15h, 88h, 00h, 00h ; 1cb1e
	DB 16h, 88h, 00h, 00h, 17h, 88h, 00h, 0FFh ; 1cb26
	DB 18h, 88h, 00h, 0FEh, 19h, 88h, 00h, 0FEh ; 1cb2e
	DB 1Ah, 88h, 00h, 0FFh, 1Bh, 88h, 00h, 00h ; 1cb36
	DB 1Ch, 88h, 00h, 00h, 1Dh, 88h, 10h, 00h ; 1cb3e
	DB 1Eh, 88h, 10h, 00h, 1Fh, 88h, 10h, 00h ; 1cb46
	DB 22h, 88h, 00h, 0F8h, 2Bh, 08h, 00h, 00h ; 1cb4e
	DB 23h, 88h, 00h, 0F8h, 2Ch, 08h, 00h, 00h ; 1cb56
	DB 24h, 88h, 00h, 0F8h, 2Bh, 09h, 00h, 00h ; 1cb5e
	DB 23h, 89h, 00h, 0F8h, 2Ch, 09h, 00h, 00h ; 1cb66
	DB 24h, 89h, 0FFh, 0F8h, 2Dh, 08h, 00h, 00h ; 1cb6e
	DB 25h, 88h, 0FFh, 0F8h, 2Eh, 08h, 00h, 00h ; 1cb76
	DB 26h, 88h, 00h, 0F8h, 2Fh, 08h, 00h, 00h ; 1cb7e
	DB 27h, 88h, 01h, 0F8h ; 1cb86
	ASCII "0" ; 1cb8a
	DB 08h, 00h, 00h, 28h, 88h, 02h, 0F8h ; 1cb8b
	ASCII "1" ; 1cb92
	DB 08h, 00h, 00h, 29h, 88h, 00h, 0F8h ; 1cb93
	ASCII "2" ; 1cb9a
	DB 08h, 10h, 0F8h ; 1cb9b
	ASCII "3" ; 1cb9e
	DB 08h, 00h, 00h, 2Ah, 88h, 01h, 0F8h, 2Dh ; 1cb9f
	DB 09h, 00h, 00h, 25h, 89h, 01h, 0F8h, 2Eh ; 1cba7
	DB 09h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1cbaf
	DB 09h, 00h, 00h, 27h, 89h, 0FFh, 0F8h ; 1cbb7
	ASCII "0" ; 1cbbe
	DB 09h, 00h, 00h, 28h, 89h, 0FEh, 0F8h ; 1cbbf
	ASCII "1" ; 1cbc6
	DB 09h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1cbc7
	ASCII "2" ; 1cbce
	DB 09h, 0F0h, 0F8h ; 1cbcf
	ASCII "3" ; 1cbd2
	DB 09h, 00h, 00h, 2Ah, 89h, 0Eh, 00h ; 1cbd3
	ASCII "A" ; 1cbda
	DB 08h, 00h, 0F8h ; 1cbdb
	ASCII "4" ; 1cbde
	DB 08h, 10h, 00h ; 1cbdf
	ASCII "5" ; 1cbe2
	DB 88h, 0Eh, 00h ; 1cbe3
	ASCII "A" ; 1cbe6
	DB 08h, 00h, 00h ; 1cbe7
	ASCII "6" ; 1cbea
	DB 08h, 10h, 00h ; 1cbeb
	ASCII "5" ; 1cbee
	DB 88h, 0Eh, 00h ; 1cbef
	ASCII "A" ; 1cbf2
	DB 08h, 00h, 00h ; 1cbf3
	ASCII "7" ; 1cbf6
	DB 08h, 10h, 00h ; 1cbf7
	ASCII "5" ; 1cbfa
	DB 88h, 0Eh, 00h ; 1cbfb
	ASCII "A" ; 1cbfe
	DB 08h, 00h, 0F8h ; 1cbff
	ASCII "8" ; 1cc02
	DB 08h, 10h, 00h ; 1cc03
	ASCII "5" ; 1cc06
	DB 88h, 0Fh, 00h ; 1cc07
	ASCII "B" ; 1cc0a
	DB 08h, 10h, 00h, 3Dh, 08h, 00h, 0F8h, 3Eh ; 1cc0b
	DB 88h, 0Fh, 00h ; 1cc13
	ASCII "B" ; 1cc16
	DB 08h, 10h, 00h, 3Dh, 08h, 00h, 0F8h, 3Fh ; 1cc17
	DB 88h, 0Fh, 00h ; 1cc1f
	ASCII "B" ; 1cc22
	DB 08h, 10h, 00h, 3Dh, 08h, 00h, 00h, 40h ; 1cc23
	DB 88h, 00h, 00h ; 1cc2b
	ASCII "C" ; 1cc2e
	DB 88h, 00h, 00h ; 1cc2f
	ASCII "D" ; 1cc32
	DB 88h, 0FFh, 00h ; 1cc33
	ASCII "C" ; 1cc36
	DB 89h, 00h, 00h ; 1cc37
	ASCII "E" ; 1cc3a
	DB 88h, 00h, 00h ; 1cc3b
	ASCII "F" ; 1cc3e
	DB 88h, 0FFh, 00h ; 1cc3f
	ASCII "E" ; 1cc42
	DB 89h, 0FFh, 00h ; 1cc43
	ASCII "F" ; 1cc46
	DB 89h, 00h, 00h ; 1cc47
	ASCII "G" ; 1cc4a
	DB 88h, 00h, 00h ; 1cc4b
	ASCII "H" ; 1cc4e
	DB 88h, 00h, 00h ; 1cc4f
	ASCII "I" ; 1cc52
	DB 88h, 0FFh, 00h ; 1cc53
	ASCII "I" ; 1cc56
	DB 89h, 00h, 00h ; 1cc57
	ASCII "J" ; 1cc5a
	DB 88h, 00h, 00h ; 1cc5b
	ASCII "K" ; 1cc5e
	DB 88h, 0FFh, 00h ; 1cc5f
	ASCII "J" ; 1cc62
	DB 89h, 0FFh, 00h ; 1cc63
	ASCII "K" ; 1cc66
	DB 89h, 00h, 00h ; 1cc67
	ASCII "L" ; 1cc6a
	DB 88h, 00h, 00h ; 1cc6b
	ASCII "M" ; 1cc6e
	DB 88h, 00h, 00h, 0Dh, 88h, 00h, 00h ; 1cc6f
	ASCII "N" ; 1cc76
	DB 88h, 00h, 00h ; 1cc77
	ASCII "O" ; 1cc7a
	DB 88h, 00h, 00h ; 1cc7b
	ASCII "P" ; 1cc7e
	DB 88h, 00h, 00h ; 1cc7f
	ASCII "Q" ; 1cc82
	DB 88h, 00h, 00h ; 1cc83
	ASCII "R" ; 1cc86
	DB 88h, 00h, 00h ; 1cc87
	ASCII "S" ; 1cc8a
	DB 08h, 09h, 00h ; 1cc8b
	ASCII "e" ; 1cc8e
	DB 08h, 0F6h, 00h ; 1cc8f
	ASCII "e" ; 1cc92
	DB 89h, 00h, 00h ; 1cc93
	ASCII "S" ; 1cc96
	DB 08h, 0Ch, 00h ; 1cc97
	ASCII "f" ; 1cc9a
	DB 08h, 0F3h, 00h ; 1cc9b
	ASCII "f" ; 1cc9e
	DB 89h, 00h, 00h ; 1cc9f
	ASCII "T" ; 1cca2
	DB 08h, 0Eh, 00h ; 1cca3
	ASCII "g" ; 1cca6
	DB 08h, 0F1h, 00h ; 1cca7
	ASCII "g" ; 1ccaa
	DB 89h, 00h, 00h ; 1ccab
	ASCII "T" ; 1ccae
	DB 88h, 00h, 00h ; 1ccaf
	ASCII "U" ; 1ccb2
	DB 88h, 00h, 00h ; 1ccb3
	ASCII "V" ; 1ccb6
	DB 88h, 00h, 00h ; 1ccb7
	ASCII "W" ; 1ccba
	DB 88h, 0FEh, 00h ; 1ccbb
	ASCII "X" ; 1ccbe
	DB 88h, 0FEh, 00h ; 1ccbf
	ASCII "Y" ; 1ccc2
	DB 88h, 0FEh, 00h ; 1ccc3
	ASCII "Z" ; 1ccc6
	DB 88h, 0FEh, 00h, 5Bh, 88h, 0FEh, 00h, 5Ch ; 1ccc7
	DB 88h, 0FEh, 00h, 5Dh, 88h, 0FEh, 00h, 5Eh ; 1cccf
	DB 88h, 0FEh, 00h, 5Fh, 88h, 0FEh, 00h, 60h ; 1ccd7
	DB 88h, 0FEh, 00h ; 1ccdf
	ASCII "a" ; 1cce2
	DB 88h, 0FEh, 00h ; 1cce3
	ASCII "b" ; 1cce6
	DB 88h, 0FEh, 00h ; 1cce7
	ASCII "c" ; 1ccea
	DB 88h, 00h, 00h ; 1cceb
	ASCII "h" ; 1ccee
	DB 08h, 00h, 0F9h, 2Ch, 88h, 00h, 00h ; 1ccef
	ASCII "h" ; 1ccf6
	DB 09h, 00h, 0F9h, 2Ch, 89h, 00h, 00h ; 1ccf7
	ASCII "i" ; 1ccfe
	DB 08h, 00h, 0F0h ; 1ccff
	ASCII "j" ; 1cd02
	DB 88h, 0F0h, 01h ; 1cd03
	ASCII "k" ; 1cd06
	DB 08h, 00h, 01h ; 1cd07
	ASCII "l" ; 1cd0a
	DB 88h, 0F0h, 02h ; 1cd0b
	ASCII "m" ; 1cd0e
	DB 08h, 00h, 02h ; 1cd0f
	ASCII "n" ; 1cd12
	DB 88h, 00h, 00h ; 1cd13
	ASCII "o" ; 1cd16
	DB 88h, 02h, 0F1h ; 1cd17
	ASCII "p" ; 1cd1a
	DB 88h, 02h, 0F1h ; 1cd1b
	ASCII "q" ; 1cd1e
	DB 88h, 02h, 0F1h ; 1cd1f
	ASCII "r" ; 1cd22
	DB 88h, 02h, 0F1h ; 1cd23
	ASCII "s" ; 1cd26
	DB 88h, 0F2h, 00h ; 1cd27
	ASCII "t" ; 1cd2a
	DB 88h, 0F2h, 00h ; 1cd2b
	ASCII "u" ; 1cd2e
	DB 88h, 00h, 00h ; 1cd2f
	ASCII "v" ; 1cd32
	DB 08h, 10h, 00h ; 1cd33
	ASCII "v" ; 1cd36
	DB 09h, 00h, 08h ; 1cd37
	ASCII "v" ; 1cd3a
	DB 0Ah, 10h, 08h ; 1cd3b
	ASCII "v" ; 1cd3e
	DB 0Bh, 08h, 04h ; 1cd3f
	ASCII "x" ; 1cd42
	DB 88h, 00h, 00h ; 1cd43
	ASCII "v" ; 1cd46
	DB 08h, 10h, 00h ; 1cd47
	ASCII "v" ; 1cd4a
	DB 09h, 00h, 08h ; 1cd4b
	ASCII "v" ; 1cd4e
	DB 0Ah, 10h, 08h ; 1cd4f
	ASCII "v" ; 1cd52
	DB 0Bh, 08h, 04h ; 1cd53
	ASCII "y" ; 1cd56
	DB 88h, 00h, 00h ; 1cd57
	ASCII "v" ; 1cd5a
	DB 08h, 10h, 00h ; 1cd5b
	ASCII "v" ; 1cd5e
	DB 09h, 00h, 08h ; 1cd5f
	ASCII "v" ; 1cd62
	DB 0Ah, 10h, 08h ; 1cd63
	ASCII "v" ; 1cd66
	DB 0Bh, 08h, 04h ; 1cd67
	ASCII "z" ; 1cd6a
	DB 88h, 00h, 00h ; 1cd6b
	ASCII "v" ; 1cd6e
	DB 08h, 10h, 00h ; 1cd6f
	ASCII "v" ; 1cd72
	DB 09h, 00h, 08h ; 1cd73
	ASCII "v" ; 1cd76
	DB 0Ah, 10h, 08h ; 1cd77
	ASCII "v" ; 1cd7a
	DB 0Bh, 08h, 04h, 7Bh, 88h, 00h, 00h ; 1cd7b
	ASCII "v" ; 1cd82
	DB 08h, 10h, 00h ; 1cd83
	ASCII "v" ; 1cd86
	DB 09h, 00h, 08h ; 1cd87
	ASCII "v" ; 1cd8a
	DB 0Ah, 10h, 08h ; 1cd8b
	ASCII "v" ; 1cd8e
	DB 0Bh, 08h, 04h, 7Ch, 88h, 00h, 00h ; 1cd8f
	ASCII "v" ; 1cd96
	DB 08h, 10h, 00h ; 1cd97
	ASCII "v" ; 1cd9a
	DB 09h, 00h, 08h ; 1cd9b
	ASCII "v" ; 1cd9e
	DB 0Ah, 10h, 08h ; 1cd9f
	ASCII "v" ; 1cda2
	DB 0Bh, 08h, 04h, 7Dh, 88h, 00h, 00h ; 1cda3
	ASCII "v" ; 1cdaa
	DB 08h, 10h, 00h ; 1cdab
	ASCII "v" ; 1cdae
	DB 09h, 00h, 08h ; 1cdaf
	ASCII "v" ; 1cdb2
	DB 0Ah, 10h, 08h ; 1cdb3
	ASCII "v" ; 1cdb6
	DB 0Bh, 08h, 04h, 7Eh, 88h, 00h, 00h ; 1cdb7
	ASCII "v" ; 1cdbe
	DB 08h, 10h, 00h ; 1cdbf
	ASCII "v" ; 1cdc2
	DB 09h, 00h, 08h ; 1cdc3
	ASCII "v" ; 1cdc6
	DB 0Ah, 10h, 08h ; 1cdc7
	ASCII "v" ; 1cdca
	DB 0Bh, 08h, 04h, 7Fh, 88h, 00h, 00h ; 1cdcb
	ASCII "v" ; 1cdd2
	DB 08h, 10h, 00h ; 1cdd3
	ASCII "v" ; 1cdd6
	DB 09h, 00h, 08h ; 1cdd7
	ASCII "v" ; 1cdda
	DB 0Ah, 10h, 08h ; 1cddb
	ASCII "v" ; 1cdde
	DB 0Bh, 08h, 04h, 80h, 88h, 00h, 00h ; 1cddf
	ASCII "v" ; 1cde6
	DB 08h, 10h, 00h ; 1cde7
	ASCII "v" ; 1cdea
	DB 09h, 00h, 08h ; 1cdeb
	ASCII "v" ; 1cdee
	DB 0Ah, 10h, 08h ; 1cdef
	ASCII "v" ; 1cdf2
	DB 0Bh, 08h, 04h, 81h, 88h, 00h, 00h ; 1cdf3
	ASCII "w" ; 1cdfa
	DB 08h, 10h, 00h ; 1cdfb
	ASCII "w" ; 1cdfe
	DB 09h, 00h, 08h ; 1cdff
	ASCII "w" ; 1ce02
	DB 0Ah, 10h, 08h ; 1ce03
	ASCII "w" ; 1ce06
	DB 8Bh, 00h, 00h ; 1ce07
	ASCII "w" ; 1ce0a
	DB 08h, 10h, 00h ; 1ce0b
	ASCII "w" ; 1ce0e
	DB 09h, 00h, 08h ; 1ce0f
	ASCII "w" ; 1ce12
	DB 0Ah, 10h, 08h ; 1ce13
	ASCII "w" ; 1ce16
	DB 0Bh, 00h, 00h, 82h, 08h, 10h, 00h, 82h ; 1ce17
	DB 09h, 00h, 08h, 82h, 0Ah, 10h, 08h, 82h ; 1ce1f
	DB 8Bh, 00h, 00h ; 1ce27
	ASCII "w" ; 1ce2a
	DB 08h, 10h, 00h ; 1ce2b
	ASCII "w" ; 1ce2e
	DB 09h, 00h, 08h ; 1ce2f
	ASCII "w" ; 1ce32
	DB 0Ah, 10h, 08h ; 1ce33
	ASCII "w" ; 1ce36
	DB 0Bh, 00h, 00h, 83h, 08h, 10h, 00h, 83h ; 1ce37
	DB 09h, 00h, 08h, 83h, 0Ah, 10h, 08h, 83h ; 1ce3f
	DB 8Bh, 00h, 00h ; 1ce47
	ASCII "w" ; 1ce4a
	DB 08h, 10h, 00h ; 1ce4b
	ASCII "w" ; 1ce4e
	DB 09h, 00h, 08h ; 1ce4f
	ASCII "w" ; 1ce52
	DB 0Ah, 10h, 08h ; 1ce53
	ASCII "w" ; 1ce56
	DB 0Bh, 00h, 00h, 84h, 08h, 10h, 00h, 84h ; 1ce57
	DB 09h, 00h, 08h, 84h, 0Ah, 10h, 08h, 84h ; 1ce5f
	DB 8Bh, 00h, 00h ; 1ce67
	ASCII "w" ; 1ce6a
	DB 08h, 10h, 00h ; 1ce6b
	ASCII "w" ; 1ce6e
	DB 09h, 00h, 08h ; 1ce6f
	ASCII "w" ; 1ce72
	DB 0Ah, 10h, 08h ; 1ce73
	ASCII "w" ; 1ce76
	DB 0Bh, 00h, 00h, 85h, 08h, 10h, 00h, 85h ; 1ce77
	DB 09h, 00h, 08h, 85h, 0Ah, 10h, 08h, 85h ; 1ce7f
	DB 8Bh, 06h, 0E7h, 8Ah, 08h, 0F7h, 0E7h, 8Ah ; 1ce87
	DB 08h, 00h, 0E8h, 86h, 08h, 00h, 0F0h, 8Ch ; 1ce8f
	DB 08h, 00h, 00h, 8Dh, 88h, 06h, 0E6h, 8Ah ; 1ce97
	DB 08h, 0F7h, 0E6h, 8Ah, 08h, 00h, 0E8h, 86h ; 1ce9f
	DB 08h, 00h, 0F0h, 8Ch, 08h, 00h, 00h, 8Dh ; 1cea7
	DB 88h, 07h, 0E6h, 8Ah, 08h, 0F6h, 0E6h, 8Ah ; 1ceaf
	DB 08h, 00h, 0E8h, 87h, 08h, 00h, 0F0h, 8Ch ; 1ceb7
	DB 08h, 00h, 00h, 8Dh, 88h, 0F8h, 0E7h, 8Bh ; 1cebf
	DB 08h, 06h, 0E7h, 8Bh, 09h, 00h, 0E8h, 88h ; 1cec7
	DB 08h, 00h, 0F0h, 8Ch, 08h, 00h, 00h, 8Dh ; 1cecf
	DB 88h, 0F7h, 0E6h, 8Bh, 08h, 07h, 0E6h, 8Bh ; 1ced7
	DB 09h, 00h, 0E8h, 88h, 08h, 00h, 0F0h, 8Ch ; 1cedf
	DB 08h, 00h, 00h, 8Dh, 88h, 0F9h, 0E7h, 8Ah ; 1cee7
	DB 09h, 08h, 0E7h, 8Ah, 09h, 0FFh, 0E8h, 86h ; 1ceef
	DB 09h, 0FFh, 0F0h, 8Ch, 09h, 00h, 00h, 8Fh ; 1cef7
	DB 88h, 0F9h, 0E6h, 8Ah, 09h, 08h, 0E6h, 8Ah ; 1ceff
	DB 09h, 0FFh, 0E8h, 86h, 09h, 0FFh, 0F0h, 8Ch ; 1cf07
	DB 09h, 00h, 00h, 8Fh, 88h, 0F8h, 0E6h, 8Ah ; 1cf0f
	DB 09h, 09h, 0E6h, 8Ah, 09h, 0FFh, 0E8h, 87h ; 1cf17
	DB 09h, 0FFh, 0F0h, 8Ch, 09h, 00h, 00h, 8Fh ; 1cf1f
	DB 88h, 0F9h, 0E7h, 8Bh, 08h, 07h, 0E7h, 8Bh ; 1cf27
	DB 09h, 0FFh, 0E8h, 88h, 09h, 0FFh, 0F0h, 8Ch ; 1cf2f
	DB 09h, 00h, 00h, 8Fh, 88h, 0F8h, 0E6h, 8Bh ; 1cf37
	DB 08h, 08h, 0E6h, 8Bh, 09h, 0FFh, 0E8h, 88h ; 1cf3f
	DB 09h, 0FFh, 0F0h, 8Ch, 09h, 00h, 00h, 8Fh ; 1cf47
	DB 88h, 0F8h, 0E7h, 8Ah, 08h, 07h, 0E7h, 8Ah ; 1cf4f
	DB 08h, 00h, 0E8h, 89h, 08h, 00h, 0F0h, 8Ch ; 1cf57
	DB 08h, 00h, 00h, 8Eh, 88h, 00h, 00h, 90h ; 1cf5f
	DB 08h, 08h, 0F8h, 9Bh, 88h, 00h, 00h, 90h ; 1cf67
	DB 08h, 09h, 0F7h, 9Ch, 88h, 0FFh, 00h, 90h ; 1cf6f
	DB 09h, 0F7h, 0F8h, 9Bh, 89h, 0FFh, 00h, 90h ; 1cf77
	DB 09h, 0F6h, 0F7h, 9Ch, 89h, 00h, 00h, 91h ; 1cf7f
	DB 88h, 00h, 00h, 92h, 88h, 00h, 00h, 93h ; 1cf87
	DB 88h, 00h, 00h, 94h, 88h, 00h, 00h, 95h ; 1cf8f
	DB 88h, 01h, 00h, 96h, 88h, 0FEh, 00h, 97h ; 1cf97
	DB 08h, 04h, 0F8h, 9Dh, 88h, 0FEh, 00h, 98h ; 1cf9f
	DB 08h, 04h, 0F8h, 9Eh, 88h, 0FEh, 00h, 99h ; 1cfa7
	DB 08h, 04h, 0F8h, 9Dh, 88h, 0FEh, 00h, 9Ah ; 1cfaf
	DB 08h, 04h, 0F8h, 9Eh, 88h, 00h, 00h, 9Fh ; 1cfb7
	DB 88h, 00h, 00h, 0A0h, 88h, 00h, 00h, 0A1h ; 1cfbf
	DB 88h, 00h, 00h, 0A2h, 88h, 00h, 00h, 0A3h ; 1cfc7
	DB 88h, 00h, 00h, 0A4h, 88h, 00h, 00h, 0A5h ; 1cfcf
	DB 88h, 00h, 04h, 0A5h, 8Bh, 02h, 02h, 0A7h ; 1cfd7
	DB 88h, 0FEh, 02h, 0A7h, 8Bh, 00h, 01h, 0A9h ; 1cfdf
	DB 09h, 0FBh, 06h, 0ABh, 89h, 00h, 03h, 0A8h ; 1cfe7
	DB 0Ah, 0FBh, 0FEh, 0AAh, 8Ah, 00h, 01h, 0A8h ; 1cfef
	DB 09h, 05h, 06h, 0AAh, 89h, 00h, 03h, 0A9h ; 1cff7
	DB 0Ah, 05h, 0FEh, 0ABh, 8Ah, 00h, 00h, 0ADh ; 1cfff
	DB 88h, 01h, 00h, 0BDh, 88h, 0FAh, 0FEh, 0A8h ; 1d007
	DB 09h, 0FFh, 03h, 0AAh, 89h, 00h, 0FDh, 0A5h ; 1d00f
	DB 08h, 00h, 00h, 0AEh, 88h, 00h, 0FEh, 0A5h ; 1d017
	DB 08h, 00h, 00h, 0AEh, 88h, 00h, 0FCh, 0A5h ; 1d01f
	DB 08h, 00h, 00h, 0AFh, 88h, 09h, 0F5h, 9Dh ; 1d027
	DB 08h, 00h, 0FCh, 0A5h, 08h, 00h, 00h, 0AFh ; 1d02f
	DB 88h, 09h, 0F5h, 9Eh, 08h, 00h, 0FCh, 0A5h ; 1d037
	DB 08h, 00h, 00h, 0AFh, 88h, 09h, 0F5h, 9Dh ; 1d03f
	DB 08h, 00h, 0FDh, 0A6h, 08h, 00h, 00h, 0B0h ; 1d047
	DB 88h, 09h, 0F5h, 9Eh, 08h, 00h, 0FCh, 0A6h ; 1d04f
	DB 08h, 00h, 00h, 0B1h, 88h, 09h, 0F5h, 9Dh ; 1d057
	DB 08h, 00h, 0FDh, 0A6h, 08h, 00h, 00h, 0B2h ; 1d05f
	DB 88h, 09h, 0F5h, 9Eh, 08h, 00h, 0FCh, 0A6h ; 1d067
	DB 08h, 00h, 00h, 0B3h, 88h, 00h, 0FEh, 0ACh ; 1d06f
	DB 08h, 00h, 00h, 0B4h, 08h, 0F6h, 0EFh, 0B8h ; 1d077
	DB 88h, 0F4h, 0EDh, 0B9h, 08h, 04h, 0EDh, 0BAh ; 1d07f
	DB 08h, 00h, 0FEh, 0ACh, 08h, 00h, 00h, 0B4h ; 1d087
	DB 88h, 00h, 00h, 0B5h, 88h, 04h, 00h, 0B6h ; 1d08f
	DB 88h, 04h, 00h, 0B7h, 88h, 04h, 0F7h, 0BBh ; 1d097
	DB 08h, 04h, 00h, 0B7h, 88h, 04h, 0F7h, 0BCh ; 1d09f
	DB 08h, 04h, 00h, 0B7h, 88h, 05h, 0F7h, 0BBh ; 1d0a7
	DB 09h, 04h, 00h, 0B7h, 88h, 00h, 00h, 0BEh ; 1d0af
	DB 88h, 00h, 00h, 0BEh, 08h, 0FAh, 00h, 0BFh ; 1d0b7
	DB 88h, 00h, 00h, 0BEh, 08h, 0F9h, 00h, 0BFh ; 1d0bf
	DB 88h, 00h, 00h, 0BEh, 08h, 0F7h, 00h, 0BFh ; 1d0c7
	DB 88h, 00h, 00h, 0BEh, 08h, 0F6h, 00h, 0C0h ; 1d0cf
	DB 88h, 00h, 00h, 0BEh, 08h, 0F5h, 00h, 0C1h ; 1d0d7
	DB 88h, 00h, 00h, 0BEh, 08h, 0F4h, 00h, 0C2h ; 1d0df
	DB 88h, 00h, 00h, 0BEh, 08h, 0F3h, 00h, 0C3h ; 1d0e7
	DB 88h, 00h, 00h, 0BEh, 08h, 0F3h, 00h, 0CDh ; 1d0ef
	DB 88h, 00h, 00h, 0BFh, 88h, 00h, 00h, 0C0h ; 1d0f7
	DB 88h, 00h, 00h, 0C1h, 88h, 00h, 00h, 0C2h ; 1d0ff
	DB 88h, 00h, 00h, 0C3h, 88h, 00h, 00h, 0C4h ; 1d107
	DB 88h, 00h, 00h, 0C5h, 88h, 00h, 00h, 0C6h ; 1d10f
	DB 88h, 00h, 00h, 0C7h, 88h, 00h, 00h, 0C8h ; 1d117
	DB 88h, 00h, 00h, 0C9h, 88h, 00h, 00h, 0CAh ; 1d11f
	DB 88h, 00h, 00h, 0CBh, 88h, 00h, 00h, 0CCh ; 1d127
	DB 88h, 00h, 00h, 0CDh, 88h, 00h, 00h, 0CEh ; 1d12f
	DB 88h, 00h, 00h, 0CFh, 88h, 00h, 00h, 0D0h ; 1d137
	DB 88h, 00h, 0F0h, 0D1h, 88h, 00h, 0F0h, 0D2h ; 1d13f
	DB 88h, 0FDh, 03h, 01h, 09h, 00h, 00h, 00h ; 1d147
	DB 89h, 0FDh, 03h, 03h, 09h, 00h, 00h, 02h ; 1d14f
	DB 89h, 00h, 00h, 04h, 89h, 08h, 0F5h, 05h ; 1d157
	DB 09h, 0F8h, 0F5h, 06h, 89h, 08h, 0F5h, 07h ; 1d15f
	DB 09h, 0F8h, 0F5h, 08h, 09h, 08h, 05h, 09h ; 1d167
	DB 89h, 10h, 0F5h, 0Ah, 09h, 00h, 0F5h, 0Bh ; 1d16f
	DB 09h, 0F0h, 0F5h, 0Ch, 89h, 00h, 00h, 0Dh ; 1d177
	DB 89h, 00h, 00h, 0Eh, 89h, 02h, 00h, 0Fh ; 1d17f
	DB 89h, 04h, 00h, 10h, 89h, 0FEh, 00h, 11h ; 1d187
	DB 89h, 0FCh, 00h, 12h, 89h, 00h, 00h, 13h ; 1d18f
	DB 89h, 00h, 00h, 14h, 89h, 00h, 00h, 15h ; 1d197
	DB 89h, 00h, 00h, 16h, 89h, 00h, 00h, 17h ; 1d19f
	DB 89h, 00h, 0FFh, 18h, 89h, 00h, 0FEh, 19h ; 1d1a7
	DB 89h, 00h, 0FEh, 1Ah, 89h, 00h, 0FFh, 1Bh ; 1d1af
	DB 89h, 00h, 00h, 1Ch, 89h, 00h, 00h, 1Dh ; 1d1b7
	DB 89h, 0F0h, 00h, 1Eh, 89h, 0F0h, 00h, 1Fh ; 1d1bf
	DB 89h, 0F0h, 00h, 22h, 89h, 00h, 0F8h, 2Bh ; 1d1c7
	DB 09h, 00h, 00h, 23h, 89h, 00h, 0F8h, 2Ch ; 1d1cf
	DB 09h, 00h, 00h, 24h, 89h, 00h, 0F8h, 2Bh ; 1d1d7
	DB 08h, 00h, 00h, 23h, 89h, 00h, 0F8h, 2Ch ; 1d1df
	DB 08h, 00h, 00h, 24h, 89h, 01h, 0F8h, 2Dh ; 1d1e7
	DB 09h, 00h, 00h, 25h, 89h, 01h, 0F8h, 2Eh ; 1d1ef
	DB 09h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1d1f7
	DB 09h, 00h, 00h, 27h, 89h, 0FFh, 0F8h ; 1d1ff
	ASCII "0" ; 1d206
	DB 09h, 00h, 00h, 28h, 89h, 0FEh, 0F8h ; 1d207
	ASCII "1" ; 1d20e
	DB 09h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1d20f
	ASCII "2" ; 1d216
	DB 09h, 0F0h, 0F8h ; 1d217
	ASCII "3" ; 1d21a
	DB 09h, 00h, 00h, 2Ah, 89h, 0FFh, 0F8h, 2Dh ; 1d21b
	DB 08h, 00h, 00h, 25h, 89h, 0FFh, 0F8h, 2Eh ; 1d223
	DB 08h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1d22b
	DB 08h, 00h, 00h, 27h, 89h, 01h, 0F8h ; 1d233
	ASCII "0" ; 1d23a
	DB 08h, 00h, 00h, 28h, 89h, 02h, 0F8h ; 1d23b
	ASCII "1" ; 1d242
	DB 08h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1d243
	ASCII "2" ; 1d24a
	DB 08h, 10h, 0F8h ; 1d24b
	ASCII "3" ; 1d24e
	DB 08h, 00h, 00h, 2Ah, 89h, 0F2h, 00h ; 1d24f
	ASCII "A" ; 1d256
	DB 09h, 00h, 0F8h ; 1d257
	ASCII "4" ; 1d25a
	DB 09h, 0F0h, 00h ; 1d25b
	ASCII "5" ; 1d25e
	DB 89h, 0F2h, 00h ; 1d25f
	ASCII "A" ; 1d262
	DB 09h, 00h, 00h ; 1d263
	ASCII "6" ; 1d266
	DB 09h, 0F0h, 00h ; 1d267
	ASCII "5" ; 1d26a
	DB 89h, 0F2h, 00h ; 1d26b
	ASCII "A" ; 1d26e
	DB 09h, 00h, 00h ; 1d26f
	ASCII "7" ; 1d272
	DB 09h, 0F0h, 00h ; 1d273
	ASCII "5" ; 1d276
	DB 89h, 0F2h, 00h ; 1d277
	ASCII "A" ; 1d27a
	DB 09h, 00h, 0F8h ; 1d27b
	ASCII "8" ; 1d27e
	DB 09h, 0F0h, 00h ; 1d27f
	ASCII "5" ; 1d282
	DB 89h, 0F1h, 00h ; 1d283
	ASCII "B" ; 1d286
	DB 09h, 0F0h, 00h, 3Dh, 09h, 00h, 0F8h, 3Eh ; 1d287
	DB 89h, 0F1h, 00h ; 1d28f
	ASCII "B" ; 1d292
	DB 09h, 0F0h, 00h, 3Dh, 09h, 00h, 0F8h, 3Fh ; 1d293
	DB 89h, 0F1h, 00h ; 1d29b
	ASCII "B" ; 1d29e
	DB 09h, 0F0h, 00h, 3Dh, 09h, 00h, 00h, 40h ; 1d29f
	DB 89h, 00h, 00h ; 1d2a7
	ASCII "C" ; 1d2aa
	DB 89h, 00h, 00h ; 1d2ab
	ASCII "D" ; 1d2ae
	DB 89h, 01h, 00h ; 1d2af
	ASCII "C" ; 1d2b2
	DB 89h, 00h, 00h ; 1d2b3
	ASCII "E" ; 1d2b6
	DB 89h, 00h, 00h ; 1d2b7
	ASCII "F" ; 1d2ba
	DB 89h, 01h, 00h ; 1d2bb
	ASCII "E" ; 1d2be
	DB 89h, 01h, 00h ; 1d2bf
	ASCII "F" ; 1d2c2
	DB 89h, 00h, 00h ; 1d2c3
	ASCII "G" ; 1d2c6
	DB 89h, 00h, 00h ; 1d2c7
	ASCII "H" ; 1d2ca
	DB 89h, 00h, 00h ; 1d2cb
	ASCII "I" ; 1d2ce
	DB 89h, 01h, 00h ; 1d2cf
	ASCII "I" ; 1d2d2
	DB 89h, 00h, 00h ; 1d2d3
	ASCII "J" ; 1d2d6
	DB 89h, 00h, 00h ; 1d2d7
	ASCII "K" ; 1d2da
	DB 89h, 01h, 00h ; 1d2db
	ASCII "J" ; 1d2de
	DB 89h, 01h, 00h ; 1d2df
	ASCII "K" ; 1d2e2
	DB 89h, 00h, 00h ; 1d2e3
	ASCII "L" ; 1d2e6
	DB 89h, 00h, 00h ; 1d2e7
	ASCII "M" ; 1d2ea
	DB 89h, 00h, 00h, 0Dh, 89h, 00h, 00h ; 1d2eb
	ASCII "N" ; 1d2f2
	DB 89h, 00h, 00h ; 1d2f3
	ASCII "O" ; 1d2f6
	DB 89h, 00h, 00h ; 1d2f7
	ASCII "P" ; 1d2fa
	DB 89h, 00h, 00h ; 1d2fb
	ASCII "Q" ; 1d2fe
	DB 89h, 00h, 00h ; 1d2ff
	ASCII "R" ; 1d302
	DB 89h, 00h, 00h ; 1d303
	ASCII "S" ; 1d306
	DB 09h, 0F7h, 00h ; 1d307
	ASCII "e" ; 1d30a
	DB 09h, 0Ah, 00h ; 1d30b
	ASCII "e" ; 1d30e
	DB 89h, 00h, 00h ; 1d30f
	ASCII "S" ; 1d312
	DB 09h, 0F4h, 00h ; 1d313
	ASCII "f" ; 1d316
	DB 09h, 0Dh, 00h ; 1d317
	ASCII "f" ; 1d31a
	DB 89h, 00h, 00h ; 1d31b
	ASCII "T" ; 1d31e
	DB 09h, 0F2h, 00h ; 1d31f
	ASCII "g" ; 1d322
	DB 09h, 0Fh, 00h ; 1d323
	ASCII "g" ; 1d326
	DB 89h, 00h, 00h ; 1d327
	ASCII "T" ; 1d32a
	DB 89h, 00h, 00h ; 1d32b
	ASCII "U" ; 1d32e
	DB 89h, 00h, 00h ; 1d32f
	ASCII "V" ; 1d332
	DB 89h, 00h, 00h ; 1d333
	ASCII "W" ; 1d336
	DB 89h, 02h, 00h ; 1d337
	ASCII "X" ; 1d33a
	DB 89h, 02h, 00h ; 1d33b
	ASCII "Y" ; 1d33e
	DB 89h, 02h, 00h ; 1d33f
	ASCII "Z" ; 1d342
	DB 89h, 02h, 00h, 5Bh, 89h, 02h, 00h, 5Ch ; 1d343
	DB 89h, 02h, 00h, 5Dh, 89h, 02h, 00h, 5Eh ; 1d34b
	DB 89h, 02h, 00h, 5Fh, 89h, 02h, 00h, 60h ; 1d353
	DB 89h, 02h, 00h ; 1d35b
	ASCII "a" ; 1d35e
	DB 89h, 02h, 00h ; 1d35f
	ASCII "b" ; 1d362
	DB 89h, 02h, 00h ; 1d363
	ASCII "c" ; 1d366
	DB 89h, 00h, 00h ; 1d367
	ASCII "h" ; 1d36a
	DB 09h, 00h, 0F9h, 2Ch, 89h, 00h, 00h ; 1d36b
	ASCII "h" ; 1d372
	DB 08h, 00h, 0F9h, 2Ch, 89h, 00h, 00h ; 1d373
	ASCII "i" ; 1d37a
	DB 09h, 00h, 0F0h ; 1d37b
	ASCII "j" ; 1d37e
	DB 89h, 10h, 01h ; 1d37f
	ASCII "k" ; 1d382
	DB 09h, 00h, 01h ; 1d383
	ASCII "l" ; 1d386
	DB 89h, 10h, 02h ; 1d387
	ASCII "m" ; 1d38a
	DB 09h, 00h, 02h ; 1d38b
	ASCII "n" ; 1d38e
	DB 89h, 00h, 00h ; 1d38f
	ASCII "o" ; 1d392
	DB 89h, 0FEh, 0F1h ; 1d393
	ASCII "p" ; 1d396
	DB 89h, 0FEh, 0F1h ; 1d397
	ASCII "q" ; 1d39a
	DB 89h, 0FEh, 0F1h ; 1d39b
	ASCII "r" ; 1d39e
	DB 89h, 0FEh, 0F1h ; 1d39f
	ASCII "s" ; 1d3a2
	DB 89h, 0Eh, 00h ; 1d3a3
	ASCII "t" ; 1d3a6
	DB 89h, 0Eh, 00h ; 1d3a7
	ASCII "u" ; 1d3aa
	DB 89h, 00h, 00h ; 1d3ab
	ASCII "v" ; 1d3ae
	DB 09h, 0F0h, 00h ; 1d3af
	ASCII "v" ; 1d3b2
	DB 08h, 00h, 08h ; 1d3b3
	ASCII "v" ; 1d3b6
	DB 0Bh, 0F0h, 08h ; 1d3b7
	ASCII "v" ; 1d3ba
	DB 0Ah, 0F8h, 04h ; 1d3bb
	ASCII "x" ; 1d3be
	DB 89h, 00h, 00h ; 1d3bf
	ASCII "v" ; 1d3c2
	DB 09h, 0F0h, 00h ; 1d3c3
	ASCII "v" ; 1d3c6
	DB 08h, 00h, 08h ; 1d3c7
	ASCII "v" ; 1d3ca
	DB 0Bh, 0F0h, 08h ; 1d3cb
	ASCII "v" ; 1d3ce
	DB 0Ah, 0F8h, 04h ; 1d3cf
	ASCII "y" ; 1d3d2
	DB 89h, 00h, 00h ; 1d3d3
	ASCII "v" ; 1d3d6
	DB 09h, 0F0h, 00h ; 1d3d7
	ASCII "v" ; 1d3da
	DB 08h, 00h, 08h ; 1d3db
	ASCII "v" ; 1d3de
	DB 0Bh, 0F0h, 08h ; 1d3df
	ASCII "v" ; 1d3e2
	DB 0Ah, 0F8h, 04h ; 1d3e3
	ASCII "z" ; 1d3e6
	DB 89h, 00h, 00h ; 1d3e7
	ASCII "v" ; 1d3ea
	DB 09h, 0F0h, 00h ; 1d3eb
	ASCII "v" ; 1d3ee
	DB 08h, 00h, 08h ; 1d3ef
	ASCII "v" ; 1d3f2
	DB 0Bh, 0F0h, 08h ; 1d3f3
	ASCII "v" ; 1d3f6
	DB 0Ah, 0F8h, 04h, 7Bh, 89h, 00h, 00h ; 1d3f7
	ASCII "v" ; 1d3fe
	DB 09h, 0F0h, 00h ; 1d3ff
	ASCII "v" ; 1d402
	DB 08h, 00h, 08h ; 1d403
	ASCII "v" ; 1d406
	DB 0Bh, 0F0h, 08h ; 1d407
	ASCII "v" ; 1d40a
	DB 0Ah, 0F8h, 04h, 7Ch, 89h, 00h, 00h ; 1d40b
	ASCII "v" ; 1d412
	DB 09h, 0F0h, 00h ; 1d413
	ASCII "v" ; 1d416
	DB 08h, 00h, 08h ; 1d417
	ASCII "v" ; 1d41a
	DB 0Bh, 0F0h, 08h ; 1d41b
	ASCII "v" ; 1d41e
	DB 0Ah, 0F8h, 04h, 7Dh, 89h, 00h, 00h ; 1d41f
	ASCII "v" ; 1d426
	DB 09h, 0F0h, 00h ; 1d427
	ASCII "v" ; 1d42a
	DB 08h, 00h, 08h ; 1d42b
	ASCII "v" ; 1d42e
	DB 0Bh, 0F0h, 08h ; 1d42f
	ASCII "v" ; 1d432
	DB 0Ah, 0F8h, 04h, 7Eh, 89h, 00h, 00h ; 1d433
	ASCII "v" ; 1d43a
	DB 09h, 0F0h, 00h ; 1d43b
	ASCII "v" ; 1d43e
	DB 08h, 00h, 08h ; 1d43f
	ASCII "v" ; 1d442
	DB 0Bh, 0F0h, 08h ; 1d443
	ASCII "v" ; 1d446
	DB 0Ah, 0F8h, 04h, 7Fh, 89h, 00h, 00h ; 1d447
	ASCII "v" ; 1d44e
	DB 09h, 0F0h, 00h ; 1d44f
	ASCII "v" ; 1d452
	DB 08h, 00h, 08h ; 1d453
	ASCII "v" ; 1d456
	DB 0Bh, 0F0h, 08h ; 1d457
	ASCII "v" ; 1d45a
	DB 0Ah, 0F8h, 04h, 80h, 89h, 00h, 00h ; 1d45b
	ASCII "v" ; 1d462
	DB 09h, 0F0h, 00h ; 1d463
	ASCII "v" ; 1d466
	DB 08h, 00h, 08h ; 1d467
	ASCII "v" ; 1d46a
	DB 0Bh, 0F0h, 08h ; 1d46b
	ASCII "v" ; 1d46e
	DB 0Ah, 0F8h, 04h, 81h, 89h, 00h, 00h ; 1d46f
	ASCII "w" ; 1d476
	DB 09h, 0F0h, 00h ; 1d477
	ASCII "w" ; 1d47a
	DB 08h, 00h, 08h ; 1d47b
	ASCII "w" ; 1d47e
	DB 0Bh, 0F0h, 08h ; 1d47f
	ASCII "w" ; 1d482
	DB 8Bh, 00h, 00h ; 1d483
	ASCII "w" ; 1d486
	DB 09h, 0F0h, 00h ; 1d487
	ASCII "w" ; 1d48a
	DB 08h, 00h, 08h ; 1d48b
	ASCII "w" ; 1d48e
	DB 0Bh, 0F0h, 08h ; 1d48f
	ASCII "w" ; 1d492
	DB 0Ah, 00h, 00h, 82h, 09h, 0F0h, 00h, 82h ; 1d493
	DB 08h, 00h, 08h, 82h, 0Bh, 0F0h, 08h, 82h ; 1d49b
	DB 8Bh, 00h, 00h ; 1d4a3
	ASCII "w" ; 1d4a6
	DB 09h, 0F0h, 00h ; 1d4a7
	ASCII "w" ; 1d4aa
	DB 08h, 00h, 08h ; 1d4ab
	ASCII "w" ; 1d4ae
	DB 0Bh, 0F0h, 08h ; 1d4af
	ASCII "w" ; 1d4b2
	DB 0Ah, 00h, 00h, 83h, 09h, 0F0h, 00h, 83h ; 1d4b3
	DB 08h, 00h, 08h, 83h, 0Bh, 0F0h, 08h, 83h ; 1d4bb
	DB 8Bh, 00h, 00h ; 1d4c3
	ASCII "w" ; 1d4c6
	DB 09h, 0F0h, 00h ; 1d4c7
	ASCII "w" ; 1d4ca
	DB 08h, 00h, 08h ; 1d4cb
	ASCII "w" ; 1d4ce
	DB 0Bh, 0F0h, 08h ; 1d4cf
	ASCII "w" ; 1d4d2
	DB 0Ah, 00h, 00h, 84h, 09h, 0F0h, 00h, 84h ; 1d4d3
	DB 08h, 00h, 08h, 84h, 0Bh, 0F0h, 08h, 84h ; 1d4db
	DB 8Bh, 00h, 00h ; 1d4e3
	ASCII "w" ; 1d4e6
	DB 09h, 0F0h, 00h ; 1d4e7
	ASCII "w" ; 1d4ea
	DB 08h, 00h, 08h ; 1d4eb
	ASCII "w" ; 1d4ee
	DB 0Bh, 0F0h, 08h ; 1d4ef
	ASCII "w" ; 1d4f2
	DB 0Ah, 00h, 00h, 85h, 09h, 0F0h, 00h, 85h ; 1d4f3
	DB 08h, 00h, 08h, 85h, 0Bh, 0F0h, 08h, 85h ; 1d4fb
	DB 8Bh, 0FAh, 0E7h, 8Ah, 09h, 09h, 0E7h, 8Ah ; 1d503
	DB 09h, 00h, 0E8h, 86h, 09h, 00h, 0F0h, 8Ch ; 1d50b
	DB 09h, 00h, 00h, 8Dh, 89h, 0FAh, 0E6h, 8Ah ; 1d513
	DB 09h, 09h, 0E6h, 8Ah, 09h, 00h, 0E8h, 86h ; 1d51b
	DB 09h, 00h, 0F0h, 8Ch, 09h, 00h, 00h, 8Dh ; 1d523
	DB 89h, 0F9h, 0E6h, 8Ah, 09h, 0Ah, 0E6h, 8Ah ; 1d52b
	DB 09h, 00h, 0E8h, 87h, 09h, 00h, 0F0h, 8Ch ; 1d533
	DB 09h, 00h, 00h, 8Dh, 89h, 08h, 0E7h, 8Bh ; 1d53b
	DB 09h, 0FAh, 0E7h, 8Bh, 08h, 00h, 0E8h, 88h ; 1d543
	DB 09h, 00h, 0F0h, 8Ch, 09h, 00h, 00h, 8Dh ; 1d54b
	DB 89h, 09h, 0E6h, 8Bh, 09h, 0F9h, 0E6h, 8Bh ; 1d553
	DB 08h, 00h, 0E8h, 88h, 09h, 00h, 0F0h, 8Ch ; 1d55b
	DB 09h, 00h, 00h, 8Dh, 89h, 07h, 0E7h, 8Ah ; 1d563
	DB 08h, 0F8h, 0E7h, 8Ah, 08h, 01h, 0E8h, 86h ; 1d56b
	DB 08h, 01h, 0F0h, 8Ch, 08h, 00h, 00h, 8Fh ; 1d573
	DB 89h, 07h, 0E6h, 8Ah, 08h, 0F8h, 0E6h, 8Ah ; 1d57b
	DB 08h, 01h, 0E8h, 86h, 08h, 01h, 0F0h, 8Ch ; 1d583
	DB 08h, 00h, 00h, 8Fh, 89h, 08h, 0E6h, 8Ah ; 1d58b
	DB 08h, 0F7h, 0E6h, 8Ah, 08h, 01h, 0E8h, 87h ; 1d593
	DB 08h, 01h, 0F0h, 8Ch, 08h, 00h, 00h, 8Fh ; 1d59b
	DB 89h, 07h, 0E7h, 8Bh, 09h, 0F9h, 0E7h, 8Bh ; 1d5a3
	DB 08h, 01h, 0E8h, 88h, 08h, 01h, 0F0h, 8Ch ; 1d5ab
	DB 08h, 00h, 00h, 8Fh, 89h, 08h, 0E6h, 8Bh ; 1d5b3
	DB 09h, 0F8h, 0E6h, 8Bh, 08h, 01h, 0E8h, 88h ; 1d5bb
	DB 08h, 01h, 0F0h, 8Ch, 08h, 00h, 00h, 8Fh ; 1d5c3
	DB 89h, 08h, 0E7h, 8Ah, 09h, 0F9h, 0E7h, 8Ah ; 1d5cb
	DB 09h, 00h, 0E8h, 89h, 09h, 00h, 0F0h, 8Ch ; 1d5d3
	DB 09h, 00h, 00h, 8Eh, 89h, 00h, 00h, 90h ; 1d5db
	DB 09h, 0F8h, 0F8h, 9Bh, 89h, 00h, 00h, 90h ; 1d5e3
	DB 09h, 0F7h, 0F7h, 9Ch, 89h, 01h, 00h, 90h ; 1d5eb
	DB 08h, 09h, 0F8h, 9Bh, 89h, 01h, 00h, 90h ; 1d5f3
	DB 08h, 0Ah, 0F7h, 9Ch, 89h, 00h, 00h, 91h ; 1d5fb
	DB 89h, 00h, 00h, 92h, 89h, 00h, 00h, 93h ; 1d603
	DB 89h, 00h, 00h, 94h, 89h, 00h, 00h, 95h ; 1d60b
	DB 89h, 0FFh, 00h, 96h, 89h, 02h, 00h, 97h ; 1d613
	DB 09h, 0FCh, 0F8h, 9Dh, 89h, 02h, 00h, 98h ; 1d61b
	DB 09h, 0FCh, 0F8h, 9Eh, 89h, 02h, 00h, 99h ; 1d623
	DB 09h, 0FCh, 0F8h, 9Dh, 89h, 02h, 00h, 9Ah ; 1d62b
	DB 09h, 0FCh, 0F8h, 9Eh, 89h, 00h, 00h, 9Fh ; 1d633
	DB 89h, 00h, 00h, 0A0h, 89h, 00h, 00h, 0A1h ; 1d63b
	DB 89h, 00h, 00h, 0A2h, 89h, 00h, 00h, 0A3h ; 1d643
	DB 89h, 00h, 00h, 0A4h, 89h, 00h, 00h, 0A5h ; 1d64b
	DB 89h, 00h, 04h, 0A5h, 8Bh, 0FEh, 02h, 0A7h ; 1d653
	DB 89h, 02h, 02h, 0A7h, 8Bh, 00h, 01h, 0A9h ; 1d65b
	DB 08h, 05h, 06h, 0ABh, 89h, 00h, 03h, 0A8h ; 1d663
	DB 0Bh, 05h, 0FEh, 0AAh, 8Bh, 00h, 01h, 0A8h ; 1d66b
	DB 08h, 0FBh, 06h, 0AAh, 89h, 00h, 03h, 0A9h ; 1d673
	DB 0Bh, 0FBh, 0FEh, 0ABh, 8Bh, 00h, 00h, 0ADh ; 1d67b
	DB 89h, 0FFh, 00h, 0BDh, 89h, 06h, 0FEh, 0A8h ; 1d683
	DB 08h, 01h, 03h, 0AAh, 89h, 00h, 0FDh, 0A5h ; 1d68b
	DB 09h, 00h, 00h, 0AEh, 89h, 00h, 0FEh, 0A5h ; 1d693
	DB 09h, 00h, 00h, 0AEh, 89h, 00h, 0FCh, 0A5h ; 1d69b
	DB 09h, 00h, 00h, 0AFh, 89h, 0F7h, 0F5h, 9Dh ; 1d6a3
	DB 09h, 00h, 0FCh, 0A5h, 09h, 00h, 00h, 0AFh ; 1d6ab
	DB 89h, 0F7h, 0F5h, 9Eh, 09h, 00h, 0FCh, 0A5h ; 1d6b3
	DB 09h, 00h, 00h, 0AFh, 89h, 0F7h, 0F5h, 9Dh ; 1d6bb
	DB 09h, 00h, 0FDh, 0A6h, 09h, 00h, 00h, 0B0h ; 1d6c3
	DB 89h, 0F7h, 0F5h, 9Eh, 09h, 00h, 0FCh, 0A6h ; 1d6cb
	DB 09h, 00h, 00h, 0B1h, 89h, 0F7h, 0F5h, 9Dh ; 1d6d3
	DB 09h, 00h, 0FDh, 0A6h, 09h, 00h, 00h, 0B2h ; 1d6db
	DB 89h, 0F7h, 0F5h, 9Eh, 09h, 00h, 0FCh, 0A6h ; 1d6e3
	DB 09h, 00h, 00h, 0B3h, 89h, 00h, 0FEh, 0ACh ; 1d6eb
	DB 09h, 00h, 00h, 0B4h, 09h, 0Ah, 0EFh, 0B8h ; 1d6f3
	DB 89h, 0Ch, 0EDh, 0B9h, 09h, 0FCh, 0EDh, 0BAh ; 1d6fb
	DB 09h, 00h, 0FEh, 0ACh, 09h, 00h, 00h, 0B4h ; 1d703
	DB 89h, 00h, 00h, 0B5h, 89h, 0FCh, 00h, 0B6h ; 1d70b
	DB 89h, 0FCh, 00h, 0B7h, 89h, 0FCh, 0F7h, 0BBh ; 1d713
	DB 09h, 0FCh, 00h, 0B7h, 89h, 0FCh, 0F7h, 0BCh ; 1d71b
	DB 09h, 0FCh, 00h, 0B7h, 89h, 0FBh, 0F7h, 0BBh ; 1d723
	DB 08h, 0FCh, 00h, 0B7h, 89h, 00h, 00h, 0BEh ; 1d72b
	DB 89h, 00h, 00h, 0BEh, 09h, 06h, 00h, 0BFh ; 1d733
	DB 89h, 00h, 00h, 0BEh, 09h, 07h, 00h, 0BFh ; 1d73b
	DB 89h, 00h, 00h, 0BEh, 09h, 09h, 00h, 0BFh ; 1d743
	DB 89h, 00h, 00h, 0BEh, 09h, 0Ah, 00h, 0C0h ; 1d74b
	DB 89h, 00h, 00h, 0BEh, 09h, 0Bh, 00h, 0C1h ; 1d753
	DB 89h, 00h, 00h, 0BEh, 09h, 0Ch, 00h, 0C2h ; 1d75b
	DB 89h, 00h, 00h, 0BEh, 09h, 0Dh, 00h, 0C3h ; 1d763
	DB 89h, 00h, 00h, 0BEh, 09h, 0Dh, 00h, 0CDh ; 1d76b
	DB 89h, 00h, 00h, 0BFh, 89h, 00h, 00h, 0C0h ; 1d773
	DB 89h, 00h, 00h, 0C1h, 89h, 00h, 00h, 0C2h ; 1d77b
	DB 89h, 00h, 00h, 0C3h, 89h, 00h, 00h, 0C4h ; 1d783
	DB 89h, 00h, 00h, 0C5h, 89h, 00h, 00h, 0C6h ; 1d78b
	DB 89h, 00h, 00h, 0C7h, 89h, 00h, 00h, 0C8h ; 1d793
	DB 89h, 00h, 00h, 0C9h, 89h, 00h, 00h, 0CAh ; 1d79b
	DB 89h, 00h, 00h, 0CBh, 89h, 00h, 00h, 0CCh ; 1d7a3
	DB 89h, 00h, 00h, 0CDh, 89h, 00h, 00h, 0CEh ; 1d7ab
	DB 89h, 00h, 00h, 0CFh, 89h, 00h, 00h, 0D0h ; 1d7b3
	DB 89h, 00h, 0F0h, 0D1h, 89h, 00h, 0F0h, 0D2h ; 1d7bb
	DB 89h, 00h, 00h, 0Dh, 88h, 00h, 00h, 0Eh ; 1d7c3
	DB 88h, 0FEh, 00h, 0Fh, 88h, 0FCh, 00h, 10h ; 1d7cb
	DB 88h, 02h, 00h, 11h, 88h, 04h, 00h, 12h ; 1d7d3
	DB 88h, 00h, 00h, 13h, 88h, 00h, 00h, 14h ; 1d7db
	DB 88h, 00h, 00h, 15h, 88h, 00h, 00h, 16h ; 1d7e3
	DB 88h, 00h, 00h, 17h, 88h, 00h, 0FFh, 18h ; 1d7eb
	DB 88h, 00h, 0FEh, 19h, 88h, 00h, 0FEh, 1Ah ; 1d7f3
	DB 88h, 00h, 0FFh, 1Bh, 88h, 00h, 0F8h, 2Bh ; 1d7fb
	DB 08h, 00h, 00h, 23h, 88h, 00h, 0F8h, 2Ch ; 1d803
	DB 08h, 00h, 00h, 24h, 88h, 00h, 0F8h, 2Bh ; 1d80b
	DB 09h, 00h, 00h, 23h, 89h, 00h, 0F8h, 2Ch ; 1d813
	DB 09h, 00h, 00h, 24h, 89h, 0FFh, 0F8h, 2Dh ; 1d81b
	DB 08h, 00h, 00h, 25h, 88h, 0FFh, 0F8h, 2Eh ; 1d823
	DB 08h, 00h, 00h, 26h, 88h, 00h, 0F8h, 2Fh ; 1d82b
	DB 08h, 00h, 00h, 27h, 88h, 01h, 0F8h ; 1d833
	ASCII "0" ; 1d83a
	DB 08h, 00h, 00h, 28h, 88h, 02h, 0F8h ; 1d83b
	ASCII "1" ; 1d842
	DB 08h, 00h, 00h, 29h, 88h, 00h, 0F8h ; 1d843
	ASCII "2" ; 1d84a
	DB 08h, 10h, 0F8h ; 1d84b
	ASCII "3" ; 1d84e
	DB 08h, 00h, 00h, 2Ah, 88h, 01h, 0F8h, 2Dh ; 1d84f
	DB 09h, 00h, 00h, 25h, 89h, 01h, 0F8h, 2Eh ; 1d857
	DB 09h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1d85f
	DB 09h, 00h, 00h, 27h, 89h, 0FFh, 0F8h ; 1d867
	ASCII "0" ; 1d86e
	DB 09h, 00h, 00h, 28h, 89h, 0FEh, 0F8h ; 1d86f
	ASCII "1" ; 1d876
	DB 09h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1d877
	ASCII "2" ; 1d87e
	DB 09h, 0F0h, 0F8h ; 1d87f
	ASCII "3" ; 1d882
	DB 09h, 00h, 00h, 2Ah, 89h, 00h, 00h ; 1d883
	ASCII "C" ; 1d88a
	DB 88h, 00h, 00h ; 1d88b
	ASCII "D" ; 1d88e
	DB 88h, 0FEh, 00h ; 1d88f
	ASCII "C" ; 1d892
	DB 89h, 00h, 00h ; 1d893
	ASCII "E" ; 1d896
	DB 88h, 00h, 00h ; 1d897
	ASCII "F" ; 1d89a
	DB 88h, 0FEh, 00h ; 1d89b
	ASCII "E" ; 1d89e
	DB 89h, 0FEh, 00h ; 1d89f
	ASCII "F" ; 1d8a2
	DB 89h, 00h, 00h ; 1d8a3
	ASCII "G" ; 1d8a6
	DB 88h, 00h, 00h ; 1d8a7
	ASCII "H" ; 1d8aa
	DB 88h, 00h, 00h ; 1d8ab
	ASCII "I" ; 1d8ae
	DB 88h, 0FEh, 00h ; 1d8af
	ASCII "I" ; 1d8b2
	DB 89h, 00h, 00h ; 1d8b3
	ASCII "J" ; 1d8b6
	DB 88h, 00h, 00h ; 1d8b7
	ASCII "K" ; 1d8ba
	DB 88h, 0FEh, 00h ; 1d8bb
	ASCII "J" ; 1d8be
	DB 89h, 0FEh, 00h ; 1d8bf
	ASCII "K" ; 1d8c2
	DB 89h, 00h, 00h ; 1d8c3
	ASCII "L" ; 1d8c6
	DB 88h, 00h, 00h ; 1d8c7
	ASCII "M" ; 1d8ca
	DB 88h, 00h, 00h ; 1d8cb
	ASCII "d" ; 1d8ce
	DB 88h, 00h, 00h ; 1d8cf
	ASCII "N" ; 1d8d2
	DB 88h, 00h, 00h ; 1d8d3
	ASCII "O" ; 1d8d6
	DB 88h, 00h, 00h ; 1d8d7
	ASCII "P" ; 1d8da
	DB 88h, 00h, 00h ; 1d8db
	ASCII "Q" ; 1d8de
	DB 88h, 00h, 00h ; 1d8df
	ASCII "R" ; 1d8e2
	DB 88h, 00h, 00h ; 1d8e3
	ASCII "S" ; 1d8e6
	DB 08h, 09h, 00h ; 1d8e7
	ASCII "e" ; 1d8ea
	DB 08h, 0F6h, 00h ; 1d8eb
	ASCII "e" ; 1d8ee
	DB 89h, 00h, 00h ; 1d8ef
	ASCII "S" ; 1d8f2
	DB 08h, 0Ch, 00h ; 1d8f3
	ASCII "f" ; 1d8f6
	DB 08h, 0F3h, 00h ; 1d8f7
	ASCII "f" ; 1d8fa
	DB 89h, 00h, 00h ; 1d8fb
	ASCII "T" ; 1d8fe
	DB 08h, 0Eh, 00h ; 1d8ff
	ASCII "g" ; 1d902
	DB 08h, 0F1h, 00h ; 1d903
	ASCII "g" ; 1d906
	DB 89h, 00h, 00h ; 1d907
	ASCII "T" ; 1d90a
	DB 88h, 00h, 00h ; 1d90b
	ASCII "U" ; 1d90e
	DB 88h, 00h, 00h ; 1d90f
	ASCII "V" ; 1d912
	DB 88h, 00h, 00h ; 1d913
	ASCII "W" ; 1d916
	DB 88h, 00h, 00h ; 1d917
	ASCII "X" ; 1d91a
	DB 88h, 00h, 00h ; 1d91b
	ASCII "Y" ; 1d91e
	DB 88h, 00h, 00h ; 1d91f
	ASCII "Z" ; 1d922
	DB 88h, 00h, 00h, 5Bh, 88h, 00h, 00h, 5Ch ; 1d923
	DB 88h, 00h, 00h, 5Dh, 88h, 00h, 00h, 5Eh ; 1d92b
	DB 88h, 00h, 00h, 5Fh, 88h, 00h, 00h, 60h ; 1d933
	DB 88h, 00h, 00h ; 1d93b
	ASCII "a" ; 1d93e
	DB 88h, 00h, 00h ; 1d93f
	ASCII "b" ; 1d942
	DB 88h, 00h, 00h ; 1d943
	ASCII "c" ; 1d946
	DB 88h, 00h, 00h ; 1d947
	ASCII "h" ; 1d94a
	DB 08h, 00h, 0F9h, 2Ch, 88h, 00h, 00h ; 1d94b
	ASCII "h" ; 1d952
	DB 09h, 00h, 0F9h, 2Ch, 89h, 0F3h, 00h ; 1d953
	ASCII "t" ; 1d95a
	DB 88h, 0F3h, 00h ; 1d95b
	ASCII "u" ; 1d95e
	DB 88h, 00h, 00h, 90h, 08h, 08h, 0F8h, 9Bh ; 1d95f
	DB 88h, 00h, 00h, 90h, 08h, 09h, 0F7h, 9Ch ; 1d967
	DB 88h, 0FEh, 00h, 90h, 09h, 0F6h, 0F8h, 9Bh ; 1d96f
	DB 89h, 0FEh, 00h, 90h, 09h, 0F5h, 0F7h, 9Ch ; 1d977
	DB 89h, 00h, 00h, 91h, 88h, 00h, 00h, 92h ; 1d97f
	DB 88h, 00h, 00h, 93h, 88h, 00h, 00h, 94h ; 1d987
	DB 88h, 00h, 00h, 95h, 88h, 01h, 00h, 96h ; 1d98f
	DB 88h, 00h, 00h, 97h, 08h, 04h, 0F8h, 9Dh ; 1d997
	DB 88h, 00h, 00h, 98h, 08h, 04h, 0F8h, 9Eh ; 1d99f
	DB 88h, 00h, 00h, 99h, 08h, 04h, 0F8h, 9Dh ; 1d9a7
	DB 88h, 00h, 00h, 9Ah, 88h, 09h, 0F5h, 9Dh ; 1d9af
	DB 08h, 00h, 0FDh, 0A6h, 09h, 00h, 00h, 0B0h ; 1d9b7
	DB 88h, 09h, 0F5h, 9Eh, 08h, 00h, 0FEh, 0A6h ; 1d9bf
	DB 09h, 00h, 00h, 0B1h, 88h, 09h, 0F5h, 9Dh ; 1d9c7
	DB 08h, 00h, 0FDh, 0A6h, 08h, 00h, 00h, 0B2h ; 1d9cf
	DB 88h, 00h, 00h, 0Dh, 89h, 00h, 00h, 0Eh ; 1d9d7
	DB 89h, 02h, 00h, 0Fh, 89h, 04h, 00h, 10h ; 1d9df
	DB 89h, 0FEh, 00h, 11h, 89h, 0FCh, 00h, 12h ; 1d9e7
	DB 89h, 00h, 00h, 13h, 89h, 00h, 00h, 14h ; 1d9ef
	DB 89h, 00h, 00h, 15h, 89h, 00h, 00h, 16h ; 1d9f7
	DB 89h, 00h, 00h, 17h, 89h, 00h, 0FFh, 18h ; 1d9ff
	DB 89h, 00h, 0FEh, 19h, 89h, 00h, 0FEh, 1Ah ; 1da07
	DB 89h, 00h, 0FFh, 1Bh, 89h, 00h, 0F8h, 2Bh ; 1da0f
	DB 09h, 00h, 00h, 23h, 89h, 00h, 0F8h, 2Ch ; 1da17
	DB 09h, 00h, 00h, 24h, 89h, 00h, 0F8h, 2Bh ; 1da1f
	DB 08h, 00h, 00h, 23h, 89h, 00h, 0F8h, 2Ch ; 1da27
	DB 08h, 00h, 00h, 24h, 89h, 01h, 0F8h, 2Dh ; 1da2f
	DB 09h, 00h, 00h, 25h, 89h, 01h, 0F8h, 2Eh ; 1da37
	DB 09h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1da3f
	DB 09h, 00h, 00h, 27h, 89h, 0FFh, 0F8h ; 1da47
	ASCII "0" ; 1da4e
	DB 09h, 00h, 00h, 28h, 89h, 0FEh, 0F8h ; 1da4f
	ASCII "1" ; 1da56
	DB 09h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1da57
	ASCII "2" ; 1da5e
	DB 09h, 0F0h, 0F8h ; 1da5f
	ASCII "3" ; 1da62
	DB 09h, 00h, 00h, 2Ah, 89h, 0FFh, 0F8h, 2Dh ; 1da63
	DB 08h, 00h, 00h, 25h, 89h, 0FFh, 0F8h, 2Eh ; 1da6b
	DB 08h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1da73
	DB 08h, 00h, 00h, 27h, 89h, 01h, 0F8h ; 1da7b
	ASCII "0" ; 1da82
	DB 08h, 00h, 00h, 28h, 89h, 02h, 0F8h ; 1da83
	ASCII "1" ; 1da8a
	DB 08h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1da8b
	ASCII "2" ; 1da92
	DB 08h, 10h, 0F8h ; 1da93
	ASCII "3" ; 1da96
	DB 08h, 00h, 00h, 2Ah, 89h, 00h, 00h ; 1da97
	ASCII "C" ; 1da9e
	DB 89h, 00h, 00h ; 1da9f
	ASCII "D" ; 1daa2
	DB 89h, 02h, 00h ; 1daa3
	ASCII "C" ; 1daa6
	DB 89h, 00h, 00h ; 1daa7
	ASCII "E" ; 1daaa
	DB 89h, 00h, 00h ; 1daab
	ASCII "F" ; 1daae
	DB 89h, 02h, 00h ; 1daaf
	ASCII "E" ; 1dab2
	DB 89h, 02h, 00h ; 1dab3
	ASCII "F" ; 1dab6
	DB 89h, 00h, 00h ; 1dab7
	ASCII "G" ; 1daba
	DB 89h, 00h, 00h ; 1dabb
	ASCII "H" ; 1dabe
	DB 89h, 00h, 00h ; 1dabf
	ASCII "I" ; 1dac2
	DB 89h, 02h, 00h ; 1dac3
	ASCII "I" ; 1dac6
	DB 89h, 00h, 00h ; 1dac7
	ASCII "J" ; 1daca
	DB 89h, 00h, 00h ; 1dacb
	ASCII "K" ; 1dace
	DB 89h, 02h, 00h ; 1dacf
	ASCII "J" ; 1dad2
	DB 89h, 02h, 00h ; 1dad3
	ASCII "K" ; 1dad6
	DB 89h, 00h, 00h ; 1dad7
	ASCII "L" ; 1dada
	DB 89h, 00h, 00h ; 1dadb
	ASCII "M" ; 1dade
	DB 89h, 00h, 00h ; 1dadf
	ASCII "d" ; 1dae2
	DB 89h, 00h, 00h ; 1dae3
	ASCII "N" ; 1dae6
	DB 89h, 00h, 00h ; 1dae7
	ASCII "O" ; 1daea
	DB 89h, 00h, 00h ; 1daeb
	ASCII "P" ; 1daee
	DB 89h, 00h, 00h ; 1daef
	ASCII "Q" ; 1daf2
	DB 89h, 00h, 00h ; 1daf3
	ASCII "R" ; 1daf6
	DB 89h, 00h, 00h ; 1daf7
	ASCII "S" ; 1dafa
	DB 09h, 0F7h, 00h ; 1dafb
	ASCII "e" ; 1dafe
	DB 09h, 0Ah, 00h ; 1daff
	ASCII "e" ; 1db02
	DB 89h, 00h, 00h ; 1db03
	ASCII "S" ; 1db06
	DB 09h, 0F4h, 00h ; 1db07
	ASCII "f" ; 1db0a
	DB 09h, 0Dh, 00h ; 1db0b
	ASCII "f" ; 1db0e
	DB 89h, 00h, 00h ; 1db0f
	ASCII "T" ; 1db12
	DB 09h, 0F2h, 00h ; 1db13
	ASCII "g" ; 1db16
	DB 09h, 0Fh, 00h ; 1db17
	ASCII "g" ; 1db1a
	DB 89h, 00h, 00h ; 1db1b
	ASCII "T" ; 1db1e
	DB 89h, 00h, 00h ; 1db1f
	ASCII "U" ; 1db22
	DB 89h, 00h, 00h ; 1db23
	ASCII "V" ; 1db26
	DB 89h, 00h, 00h ; 1db27
	ASCII "W" ; 1db2a
	DB 89h, 00h, 00h ; 1db2b
	ASCII "X" ; 1db2e
	DB 89h, 00h, 00h ; 1db2f
	ASCII "Y" ; 1db32
	DB 89h, 00h, 00h ; 1db33
	ASCII "Z" ; 1db36
	DB 89h, 00h, 00h, 5Bh, 89h, 00h, 00h, 5Ch ; 1db37
	DB 89h, 00h, 00h, 5Dh, 89h, 00h, 00h, 5Eh ; 1db3f
	DB 89h, 00h, 00h, 5Fh, 89h, 00h, 00h, 60h ; 1db47
	DB 89h, 00h, 00h ; 1db4f
	ASCII "a" ; 1db52
	DB 89h, 00h, 00h ; 1db53
	ASCII "b" ; 1db56
	DB 89h, 00h, 00h ; 1db57
	ASCII "c" ; 1db5a
	DB 89h, 00h, 00h ; 1db5b
	ASCII "h" ; 1db5e
	DB 09h, 00h, 0F9h, 2Ch, 89h, 00h, 00h ; 1db5f
	ASCII "h" ; 1db66
	DB 08h, 00h, 0F9h, 2Ch, 89h, 0Dh, 00h ; 1db67
	ASCII "t" ; 1db6e
	DB 89h, 0Dh, 00h ; 1db6f
	ASCII "u" ; 1db72
	DB 89h, 00h, 00h, 90h, 09h, 0F8h, 0F8h, 9Bh ; 1db73
	DB 89h, 00h, 00h, 90h, 09h, 0F7h, 0F7h, 9Ch ; 1db7b
	DB 89h, 02h, 00h, 90h, 08h, 0Ah, 0F8h, 9Bh ; 1db83
	DB 89h, 02h, 00h, 90h, 08h, 0Bh, 0F7h, 9Ch ; 1db8b
	DB 89h, 00h, 00h, 91h, 89h, 00h, 00h, 92h ; 1db93
	DB 89h, 00h, 00h, 93h, 89h, 00h, 00h, 94h ; 1db9b
	DB 89h, 00h, 00h, 95h, 89h, 0FFh, 00h, 96h ; 1dba3
	DB 89h, 00h, 00h, 97h, 09h, 0FCh, 0F8h, 9Dh ; 1dbab
	DB 89h, 00h, 00h, 98h, 09h, 0FCh, 0F8h, 9Eh ; 1dbb3
	DB 89h, 00h, 00h, 99h, 09h, 0FCh, 0F8h, 9Dh ; 1dbbb
	DB 89h, 00h, 00h, 9Ah, 89h, 0F7h, 0F5h, 9Dh ; 1dbc3
	DB 09h, 00h, 0FDh, 0A6h, 08h, 00h, 00h, 0B0h ; 1dbcb
	DB 89h, 0F7h, 0F5h, 9Eh, 09h, 00h, 0FEh, 0A6h ; 1dbd3
	DB 08h, 00h, 00h, 0B1h, 89h, 0F7h, 0F5h, 9Dh ; 1dbdb
	DB 09h, 00h, 0FDh, 0A6h, 09h, 00h, 00h, 0B2h ; 1dbe3
	DB 89h, 00h, 00h, 0Dh, 88h, 00h, 00h, 0Eh ; 1dbeb
	DB 88h, 0FEh, 00h, 0Fh, 88h, 0FCh, 00h, 10h ; 1dbf3
	DB 88h, 02h, 00h, 11h, 88h, 04h, 00h, 12h ; 1dbfb
	DB 88h, 00h, 00h, 13h, 88h, 00h, 00h, 14h ; 1dc03
	DB 88h, 00h, 00h, 15h, 88h, 00h, 00h, 16h ; 1dc0b
	DB 88h, 00h, 00h, 17h, 88h, 00h, 0FFh, 18h ; 1dc13
	DB 88h, 00h, 0FEh, 19h, 88h, 00h, 0FEh, 1Ah ; 1dc1b
	DB 88h, 00h, 0FFh, 1Bh, 88h, 00h, 0F8h, 2Bh ; 1dc23
	DB 08h, 00h, 00h, 23h, 88h, 00h, 0F8h, 2Ch ; 1dc2b
	DB 08h, 00h, 00h, 24h, 88h, 00h, 0F8h, 2Bh ; 1dc33
	DB 09h, 00h, 00h, 23h, 89h, 00h, 0F8h, 2Ch ; 1dc3b
	DB 09h, 00h, 00h, 24h, 89h, 0FFh, 0F8h, 2Dh ; 1dc43
	DB 08h, 00h, 00h, 25h, 88h, 0FFh, 0F8h, 2Eh ; 1dc4b
	DB 08h, 00h, 00h, 26h, 88h, 00h, 0F8h, 2Fh ; 1dc53
	DB 08h, 00h, 00h, 27h, 88h, 01h, 0F8h ; 1dc5b
	ASCII "0" ; 1dc62
	DB 08h, 00h, 00h, 28h, 88h, 02h, 0F8h ; 1dc63
	ASCII "1" ; 1dc6a
	DB 08h, 00h, 00h, 29h, 88h, 00h, 0F8h ; 1dc6b
	ASCII "2" ; 1dc72
	DB 08h, 10h, 0F8h ; 1dc73
	ASCII "3" ; 1dc76
	DB 08h, 00h, 00h, 2Ah, 88h, 01h, 0F8h, 2Dh ; 1dc77
	DB 09h, 00h, 00h, 25h, 89h, 01h, 0F8h, 2Eh ; 1dc7f
	DB 09h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1dc87
	DB 09h, 00h, 00h, 27h, 89h, 0FFh, 0F8h ; 1dc8f
	ASCII "0" ; 1dc96
	DB 09h, 00h, 00h, 28h, 89h, 0FEh, 0F8h ; 1dc97
	ASCII "1" ; 1dc9e
	DB 09h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1dc9f
	ASCII "2" ; 1dca6
	DB 09h, 0F0h, 0F8h ; 1dca7
	ASCII "3" ; 1dcaa
	DB 09h, 00h, 00h, 2Ah, 89h, 00h, 00h ; 1dcab
	ASCII "C" ; 1dcb2
	DB 88h, 00h, 00h ; 1dcb3
	ASCII "D" ; 1dcb6
	DB 88h, 00h, 00h ; 1dcb7
	ASCII "C" ; 1dcba
	DB 89h, 00h, 00h ; 1dcbb
	ASCII "E" ; 1dcbe
	DB 88h, 00h, 00h ; 1dcbf
	ASCII "F" ; 1dcc2
	DB 88h, 00h, 00h ; 1dcc3
	ASCII "E" ; 1dcc6
	DB 89h, 00h, 00h ; 1dcc7
	ASCII "F" ; 1dcca
	DB 89h, 00h, 00h ; 1dccb
	ASCII "G" ; 1dcce
	DB 88h, 00h, 00h ; 1dccf
	ASCII "H" ; 1dcd2
	DB 88h, 00h, 00h ; 1dcd3
	ASCII "I" ; 1dcd6
	DB 88h, 00h, 00h ; 1dcd7
	ASCII "I" ; 1dcda
	DB 89h, 00h, 00h ; 1dcdb
	ASCII "J" ; 1dcde
	DB 88h, 00h, 00h ; 1dcdf
	ASCII "K" ; 1dce2
	DB 88h, 00h, 00h ; 1dce3
	ASCII "J" ; 1dce6
	DB 89h, 00h, 00h ; 1dce7
	ASCII "K" ; 1dcea
	DB 89h, 00h, 00h ; 1dceb
	ASCII "L" ; 1dcee
	DB 88h, 00h, 00h ; 1dcef
	ASCII "M" ; 1dcf2
	DB 88h, 00h, 00h, 0Dh, 88h, 00h, 00h ; 1dcf3
	ASCII "N" ; 1dcfa
	DB 88h, 00h, 00h ; 1dcfb
	ASCII "O" ; 1dcfe
	DB 88h, 00h, 00h ; 1dcff
	ASCII "P" ; 1dd02
	DB 88h, 00h, 00h ; 1dd03
	ASCII "Q" ; 1dd06
	DB 88h, 00h, 00h ; 1dd07
	ASCII "R" ; 1dd0a
	DB 88h, 00h, 00h ; 1dd0b
	ASCII "S" ; 1dd0e
	DB 08h, 09h, 00h ; 1dd0f
	ASCII "e" ; 1dd12
	DB 08h, 0F6h, 00h ; 1dd13
	ASCII "e" ; 1dd16
	DB 89h, 00h, 00h ; 1dd17
	ASCII "S" ; 1dd1a
	DB 08h, 0Ch, 00h ; 1dd1b
	ASCII "f" ; 1dd1e
	DB 08h, 0F3h, 00h ; 1dd1f
	ASCII "f" ; 1dd22
	DB 89h, 00h, 00h ; 1dd23
	ASCII "T" ; 1dd26
	DB 08h, 0Eh, 00h ; 1dd27
	ASCII "g" ; 1dd2a
	DB 08h, 0F1h, 00h ; 1dd2b
	ASCII "g" ; 1dd2e
	DB 89h, 00h, 00h ; 1dd2f
	ASCII "T" ; 1dd32
	DB 88h, 00h, 00h ; 1dd33
	ASCII "U" ; 1dd36
	DB 88h, 00h, 00h ; 1dd37
	ASCII "V" ; 1dd3a
	DB 88h, 00h, 00h ; 1dd3b
	ASCII "W" ; 1dd3e
	DB 88h, 00h, 00h ; 1dd3f
	ASCII "X" ; 1dd42
	DB 88h, 00h, 00h ; 1dd43
	ASCII "Y" ; 1dd46
	DB 88h, 00h, 00h ; 1dd47
	ASCII "Z" ; 1dd4a
	DB 88h, 00h, 00h, 5Bh, 88h, 00h, 00h, 5Ch ; 1dd4b
	DB 88h, 00h, 00h, 5Dh, 88h, 00h, 00h, 5Eh ; 1dd53
	DB 88h, 00h, 00h, 5Fh, 88h, 00h, 00h, 60h ; 1dd5b
	DB 88h, 00h, 00h ; 1dd63
	ASCII "a" ; 1dd66
	DB 88h, 00h, 00h ; 1dd67
	ASCII "b" ; 1dd6a
	DB 88h, 00h, 00h ; 1dd6b
	ASCII "c" ; 1dd6e
	DB 88h, 00h, 00h ; 1dd6f
	ASCII "h" ; 1dd72
	DB 08h, 00h, 0F9h, 2Ch, 88h, 00h, 00h ; 1dd73
	ASCII "h" ; 1dd7a
	DB 09h, 00h, 0F9h, 2Ch, 89h, 0F2h, 00h ; 1dd7b
	ASCII "t" ; 1dd82
	DB 88h, 0F3h, 00h ; 1dd83
	ASCII "u" ; 1dd86
	DB 88h, 00h, 00h, 90h, 08h, 08h, 0F8h, 9Bh ; 1dd87
	DB 88h, 00h, 00h, 90h, 08h, 09h, 0F7h, 9Ch ; 1dd8f
	DB 88h, 00h, 00h, 90h, 09h, 0F8h, 0F8h, 9Bh ; 1dd97
	DB 89h, 00h, 00h, 90h, 09h, 0F7h, 0F7h, 9Ch ; 1dd9f
	DB 89h, 00h, 00h, 91h, 88h, 00h, 00h, 92h ; 1dda7
	DB 88h, 00h, 00h, 93h, 88h, 00h, 00h, 94h ; 1ddaf
	DB 88h, 00h, 00h, 95h, 88h, 01h, 00h, 96h ; 1ddb7
	DB 88h, 04h, 0F6h, 9Dh, 08h, 00h, 00h, 97h ; 1ddbf
	DB 88h, 04h, 0F6h, 9Eh, 08h, 00h, 00h, 98h ; 1ddc7
	DB 88h, 04h, 0F6h, 9Dh, 08h, 00h, 00h, 99h ; 1ddcf
	DB 88h, 04h, 0F6h, 9Eh, 08h, 00h, 00h, 9Ah ; 1ddd7
	DB 88h, 09h, 0F5h, 9Dh, 08h, 00h, 0FEh, 0A6h ; 1dddf
	DB 08h, 00h, 00h, 0B0h, 88h, 09h, 0F5h, 9Eh ; 1dde7
	DB 08h, 00h, 0FCh, 0A6h, 08h, 00h, 00h, 0B1h ; 1ddef
	DB 88h, 09h, 0F4h, 9Dh, 08h, 00h, 0FBh, 0A6h ; 1ddf7
	DB 08h, 00h, 00h, 0B2h, 88h, 09h, 0F6h, 9Eh ; 1ddff
	DB 08h, 00h, 0FEh, 0A6h, 08h, 00h, 00h, 0B3h ; 1de07
	DB 88h, 00h, 0FDh, 0ACh, 08h, 00h, 00h, 0B4h ; 1de0f
	DB 08h, 0F6h, 0EFh, 0B8h, 88h, 0F4h, 0EDh, 0B9h ; 1de17
	DB 08h, 04h, 0EDh, 0BAh, 08h, 00h, 0FDh, 0ACh ; 1de1f
	DB 08h, 00h, 00h, 0B4h, 88h, 00h, 00h, 0Dh ; 1de27
	DB 89h, 00h, 00h, 0Eh, 89h, 02h, 00h, 0Fh ; 1de2f
	DB 89h, 04h, 00h, 10h, 89h, 0FEh, 00h, 11h ; 1de37
	DB 89h, 0FCh, 00h, 12h, 89h, 00h, 00h, 13h ; 1de3f
	DB 89h, 00h, 00h, 14h, 89h, 00h, 00h, 15h ; 1de47
	DB 89h, 00h, 00h, 16h, 89h, 00h, 00h, 17h ; 1de4f
	DB 89h, 00h, 0FFh, 18h, 89h, 00h, 0FEh, 19h ; 1de57
	DB 89h, 00h, 0FEh, 1Ah, 89h, 00h, 0FFh, 1Bh ; 1de5f
	DB 89h, 00h, 0F8h, 2Bh, 09h, 00h, 00h, 23h ; 1de67
	DB 89h, 00h, 0F8h, 2Ch, 09h, 00h, 00h, 24h ; 1de6f
	DB 89h, 00h, 0F8h, 2Bh, 08h, 00h, 00h, 23h ; 1de77
	DB 89h, 00h, 0F8h, 2Ch, 08h, 00h, 00h, 24h ; 1de7f
	DB 89h, 01h, 0F8h, 2Dh, 09h, 00h, 00h, 25h ; 1de87
	DB 89h, 01h, 0F8h, 2Eh, 09h, 00h, 00h, 26h ; 1de8f
	DB 89h, 00h, 0F8h, 2Fh, 09h, 00h, 00h, 27h ; 1de97
	DB 89h, 0FFh, 0F8h ; 1de9f
	ASCII "0" ; 1dea2
	DB 09h, 00h, 00h, 28h, 89h, 0FEh, 0F8h ; 1dea3
	ASCII "1" ; 1deaa
	DB 09h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1deab
	ASCII "2" ; 1deb2
	DB 09h, 0F0h, 0F8h ; 1deb3
	ASCII "3" ; 1deb6
	DB 09h, 00h, 00h, 2Ah, 89h, 0FFh, 0F8h, 2Dh ; 1deb7
	DB 08h, 00h, 00h, 25h, 89h, 0FFh, 0F8h, 2Eh ; 1debf
	DB 08h, 00h, 00h, 26h, 89h, 00h, 0F8h, 2Fh ; 1dec7
	DB 08h, 00h, 00h, 27h, 89h, 01h, 0F8h ; 1decf
	ASCII "0" ; 1ded6
	DB 08h, 00h, 00h, 28h, 89h, 02h, 0F8h ; 1ded7
	ASCII "1" ; 1dede
	DB 08h, 00h, 00h, 29h, 89h, 00h, 0F8h ; 1dedf
	ASCII "2" ; 1dee6
	DB 08h, 10h, 0F8h ; 1dee7
	ASCII "3" ; 1deea
	DB 08h, 00h, 00h, 2Ah, 89h, 00h, 00h ; 1deeb
	ASCII "C" ; 1def2
	DB 89h, 00h, 00h ; 1def3
	ASCII "D" ; 1def6
	DB 89h, 00h, 00h ; 1def7
	ASCII "C" ; 1defa
	DB 89h, 00h, 00h ; 1defb
	ASCII "E" ; 1defe
	DB 89h, 00h, 00h ; 1deff
	ASCII "F" ; 1df02
	DB 89h, 00h, 00h ; 1df03
	ASCII "E" ; 1df06
	DB 89h, 00h, 00h ; 1df07
	ASCII "F" ; 1df0a
	DB 89h, 00h, 00h ; 1df0b
	ASCII "G" ; 1df0e
	DB 89h, 00h, 00h ; 1df0f
	ASCII "H" ; 1df12
	DB 89h, 00h, 00h ; 1df13
	ASCII "I" ; 1df16
	DB 89h, 00h, 00h ; 1df17
	ASCII "I" ; 1df1a
	DB 89h, 00h, 00h ; 1df1b
	ASCII "J" ; 1df1e
	DB 89h, 00h, 00h ; 1df1f
	ASCII "K" ; 1df22
	DB 89h, 00h, 00h ; 1df23
	ASCII "J" ; 1df26
	DB 89h, 00h, 00h ; 1df27
	ASCII "K" ; 1df2a
	DB 89h, 00h, 00h ; 1df2b
	ASCII "L" ; 1df2e
	DB 89h, 00h, 00h ; 1df2f
	ASCII "M" ; 1df32
	DB 89h, 00h, 00h, 0Dh, 89h, 00h, 00h ; 1df33
	ASCII "N" ; 1df3a
	DB 89h, 00h, 00h ; 1df3b
	ASCII "O" ; 1df3e
	DB 89h, 00h, 00h ; 1df3f
	ASCII "P" ; 1df42
	DB 89h, 00h, 00h ; 1df43
	ASCII "Q" ; 1df46
	DB 89h, 00h, 00h ; 1df47
	ASCII "R" ; 1df4a
	DB 89h, 00h, 00h ; 1df4b
	ASCII "S" ; 1df4e
	DB 09h, 0F7h, 00h ; 1df4f
	ASCII "e" ; 1df52
	DB 09h, 0Ah, 00h ; 1df53
	ASCII "e" ; 1df56
	DB 89h, 00h, 00h ; 1df57
	ASCII "S" ; 1df5a
	DB 09h, 0F4h, 00h ; 1df5b
	ASCII "f" ; 1df5e
	DB 09h, 0Dh, 00h ; 1df5f
	ASCII "f" ; 1df62
	DB 89h, 00h, 00h ; 1df63
	ASCII "T" ; 1df66
	DB 09h, 0F2h, 00h ; 1df67
	ASCII "g" ; 1df6a
	DB 09h, 0Fh, 00h ; 1df6b
	ASCII "g" ; 1df6e
	DB 89h, 00h, 00h ; 1df6f
	ASCII "T" ; 1df72
	DB 89h, 00h, 00h ; 1df73
	ASCII "U" ; 1df76
	DB 89h, 00h, 00h ; 1df77
	ASCII "V" ; 1df7a
	DB 89h, 00h, 00h ; 1df7b
	ASCII "W" ; 1df7e
	DB 89h, 00h, 00h ; 1df7f
	ASCII "X" ; 1df82
	DB 89h, 00h, 00h ; 1df83
	ASCII "Y" ; 1df86
	DB 89h, 00h, 00h ; 1df87
	ASCII "Z" ; 1df8a
	DB 89h, 00h, 00h, 5Bh, 89h, 00h, 00h, 5Ch ; 1df8b
	DB 89h, 00h, 00h, 5Dh, 89h, 00h, 00h, 5Eh ; 1df93
	DB 89h, 00h, 00h, 5Fh, 89h, 00h, 00h, 60h ; 1df9b
	DB 89h, 00h, 00h ; 1dfa3
	ASCII "a" ; 1dfa6
	DB 89h, 00h, 00h ; 1dfa7
	ASCII "b" ; 1dfaa
	DB 89h, 00h, 00h ; 1dfab
	ASCII "c" ; 1dfae
	DB 89h, 00h, 00h ; 1dfaf
	ASCII "h" ; 1dfb2
	DB 09h, 00h, 0F9h, 2Ch, 89h, 00h, 00h ; 1dfb3
	ASCII "h" ; 1dfba
	DB 08h, 00h, 0F9h, 2Ch, 89h, 0Eh, 00h ; 1dfbb
	ASCII "t" ; 1dfc2
	DB 89h, 0Dh, 00h ; 1dfc3
	ASCII "u" ; 1dfc6
	DB 89h, 00h, 00h, 90h, 09h, 0F8h, 0F8h, 9Bh ; 1dfc7
	DB 89h, 00h, 00h, 90h, 09h, 0F7h, 0F7h, 9Ch ; 1dfcf
	DB 89h, 01h, 00h, 90h, 08h, 09h, 0F8h, 9Bh ; 1dfd7
	DB 89h, 01h, 00h, 90h, 08h, 0Ah, 0F7h, 9Ch ; 1dfdf
	DB 89h, 00h, 00h, 91h, 89h, 00h, 00h, 92h ; 1dfe7
	DB 89h, 00h, 00h, 93h, 89h, 00h, 00h, 94h ; 1dfef
	DB 89h, 00h, 00h, 95h, 89h, 0FFh, 00h, 96h ; 1dff7
	DB 89h, 0FCh, 0F6h, 9Dh, 09h, 00h, 00h, 97h ; 1dfff
	DB 89h, 0FCh, 0F6h, 9Eh, 09h, 00h, 00h, 98h ; 1e007
	DB 89h, 0FCh, 0F6h, 9Dh, 09h, 00h, 00h, 99h ; 1e00f
	DB 89h, 0FCh, 0F6h, 9Eh, 09h, 00h, 00h, 9Ah ; 1e017
	DB 89h, 0F7h, 0F5h, 9Dh, 09h, 00h, 0FEh, 0A6h ; 1e01f
	DB 09h, 00h, 00h, 0B0h, 89h, 0F7h, 0F5h, 9Eh ; 1e027
	DB 09h, 00h, 0FCh, 0A6h, 09h, 00h, 00h, 0B1h ; 1e02f
	DB 89h, 0F7h, 0F4h, 9Dh, 09h, 00h, 0FBh, 0A6h ; 1e037
	DB 09h, 00h, 00h, 0B2h, 89h, 0F7h, 0F6h, 9Eh ; 1e03f
	DB 09h, 00h, 0FEh, 0A6h, 09h, 00h, 00h, 0B3h ; 1e047
	DB 89h, 00h, 0FDh, 0ACh, 09h, 00h, 00h, 0B4h ; 1e04f
	DB 09h, 0Ah, 0EFh, 0B8h, 89h, 0Ch, 0EDh, 0B9h ; 1e057
	DB 09h, 0FCh, 0EDh, 0BAh, 09h, 00h, 0FDh, 0ACh ; 1e05f
	DB 09h, 00h, 00h, 0B4h, 89h, 00h, 00h, 00h ; 1e067
	DB 88h, 00h, 0FFh, 00h, 88h, 0FFh, 00h, 01h ; 1e06f
	DB 88h, 0FFh, 00h, 02h, 88h, 0FFh, 00h, 03h ; 1e077
	DB 88h, 00h, 00h, 04h, 88h, 00h, 00h, 05h ; 1e07f
	DB 88h, 00h, 00h, 06h, 88h, 00h, 00h, 07h ; 1e087
	DB 88h, 00h, 00h, 08h, 88h, 00h, 00h, 09h ; 1e08f
	DB 88h, 00h, 00h, 0Ah, 08h, 10h, 00h, 0Bh ; 1e097
	DB 08h, 16h, 00h, 10h, 08h, 26h, 00h, 11h ; 1e09f
	DB 08h ; 1e0a7
	ASCIZ "6" ; 1e0a8
	DB 12h, 88h, 00h, 00h, 0Ch, 08h, 10h, 00h ; 1e0aa
	DB 0Dh, 08h, 13h, 00h, 10h, 08h, 23h, 00h ; 1e0b2
	DB 11h, 08h ; 1e0ba
	ASCIZ "3" ; 1e0bc
	DB 12h, 88h, 00h, 00h, 0Eh, 08h, 10h, 00h ; 1e0be
	DB 0Fh, 08h, 1Ah, 00h, 10h, 08h, 2Ah, 00h ; 1e0c6
	DB 11h, 08h, 3Ah, 00h, 12h, 88h ; 1e0ce
	ASCII "L" ; 1e0d4
	DB 18h, 00h, 88h, 04h, 18h, 00h, 89h, 18h ; 1e0d5
	DB 04h, 01h, 08h, 28h, 04h, 02h, 08h, 18h ; 1e0dd
	DB 14h, 03h, 08h, 28h, 14h, 04h, 08h, 18h ; 1e0e5
	DB 24h, 05h, 08h, 28h, 24h, 06h, 88h, 18h ; 1e0ed
	ASCII "0" ; 1e0f5
	DB 07h, 08h, 28h ; 1e0f6
	ASCII "0" ; 1e0f9
	DB 08h, 08h ; 1e0fa
	ASCII "80" ; 1e0fc
	DB 09h, 88h ; 1e0fe
	ASCII "P0" ; 1e100
	DB 0Ah, 88h, 07h, 04h, 3Eh, 80h ; 1e102
	ASCII "q" ; 1e108
	DB 03h, 80h ; 1e109
	ASCII "q" ; 1e10b
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 1e10c
	ASCIZ "m/" ; 1e113
	DB 0EDh, 0E3h, 03h ; 1e116
	ASCII "M" ; 1e119
	DB 91h, 03h ; 1e11a
	ASCII "1" ; 1e11c
	DB 0E2h, 03h, 18h, 08h, 08h ; 1e11d
	ASCIZ "B&" ; 1e122
	DB 0A0h ; 1e125
	ASCII "z" ; 1e126
	DB 03h, 0Ch, 08h, 07h, 04h, 3Eh, 80h ; 1e127
	ASCII "q" ; 1e12e
	DB 03h, 80h ; 1e12f
	ASCII "q" ; 1e131
	DB 03h, 00h, 3Ah, 06h, 00h, 3Ah, 06h ; 1e132
	ASCIZ "m/" ; 1e139
	DB 0EDh, 0E3h, 03h, 0C2h, 0E1h, 03h, 0A0h, 0E2h ; 1e13c
	DB 03h, 18h, 08h, 08h ; 1e144
	ASCIZ "B&" ; 1e148
	DB 60h, 0B2h, 06h, 0Ch, 08h, 07h, 04h, 3Eh ; 1e14b
	DB 80h ; 1e153
	ASCII "q" ; 1e154
	DB 03h, 80h ; 1e155
	ASCII "q" ; 1e157
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 1e158
	ASCIZ "m/" ; 1e15f
	DB 0EDh, 0E3h, 03h ; 1e162
	ASCII "1" ; 1e165
	DB 0E2h, 03h, 0F9h, 0A3h, 03h, 18h, 08h, 08h ; 1e166
	ASCIZ "B&" ; 1e16e
	DB 0A0h ; 1e171
	ASCII "z" ; 1e172
	DB 03h, 0Ch, 08h, 07h, 04h, 3Eh, 80h ; 1e173
	ASCII "q" ; 1e17a
	DB 03h, 80h ; 1e17b
	ASCII "q" ; 1e17d
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 1e17e
	ASCIZ "m/" ; 1e185
	DB 0EDh, 0E3h, 03h, 0A0h, 0E2h, 03h, 01h, 0A5h ; 1e188
	DB 03h, 18h, 08h, 08h ; 1e190
	ASCIZ "B&" ; 1e194
	DB 0A0h ; 1e197
	ASCII "z" ; 1e198
	DB 03h, 0Ch, 08h, 07h, 04h, 3Eh, 80h ; 1e199
	ASCII "q" ; 1e1a0
	DB 03h, 80h ; 1e1a1
	ASCII "q" ; 1e1a3
	DB 03h, 00h, 22h, 06h, 00h, 22h, 06h ; 1e1a4
	ASCIZ "m/" ; 1e1ab
	DB 0EDh, 0E3h, 03h, 0Fh, 0E3h, 03h ; 1e1ae
	ASCII "9" ; 1e1b4
	DB 86h, 03h, 18h, 08h, 08h ; 1e1b5
	ASCIZ "B&" ; 1e1ba
	DB 60h, 0B2h, 06h, 0Ch, 08h, 0F2h ; 1e1bd
	ASCII "0@" ; 1e1c3
	DB 0F2h ; 1e1c5
	ASCII "qA" ; 1e1c6
	DB 0CEh, 0C4h, 02h, 0F2h, 0Fh, 0B9h, 0CEh, 0C4h ; 1e1c8
	DB 00h, 0F2h, 26h ; 1e1d0
	ASCII "J" ; 1e1d3
	DB 0CEh, 0C4h, 07h, 0F2h, 1Bh, 0A1h, 0C7h, 04h ; 1e1d4
	DB 0E1h, 0CEh, 0C7h, 01h, 0F2h, 90h ; 1e1dc
	ASCII "K" ; 1e1e2
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e1e3
	ASCII "M" ; 1e1e7
	DB 16h, 0B0h, 00h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e1e8
	ASCII "8" ; 1e1ef
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e1f0
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h, 85h, 0B9h ; 1e1f8
	DB 0C5h, 00h, 00h, 0C7h ; 1e200
	ASCII "o" ; 1e204
	DB 11h, 0CEh, 0C4h, 02h, 0F2h ; 1e205
	ASCII "y" ; 1e20a
	DB 0B9h, 0C5h, 00h, 00h, 0C7h, 8Bh, 10h, 0CEh ; 1e20b
	DB 0C4h, 02h, 0F2h ; 1e213
	ASCII "m" ; 1e216
	DB 0B9h, 0C7h, 80h, 9Ch, 0CEh, 0C4h, 07h, 0F2h ; 1e217
	ASCII "J" ; 1e21f
	DB 0A1h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1e220
	DB 5Bh, 0B9h, 0F2h, 13h ; 1e228
	ASCII "A" ; 1e22c
	DB 0F2h, 0CCh, 3Fh, 0F8h, 0F2h, 0C1h, 3Fh, 0F2h ; 1e22d
	DB 02h ; 1e235
	ASCII "A" ; 1e236
	DB 0CEh, 0C4h, 02h, 0F2h, 0A0h, 0B8h, 0CEh, 0C4h ; 1e237
	DB 00h, 0F2h, 0B7h ; 1e23f
	ASCII "I" ; 1e242
	DB 0CEh, 0C4h, 07h, 0F2h, 0ACh, 0A0h, 0C7h, 2Ah ; 1e243
	DB 0E1h, 0CEh, 0C7h, 01h, 0F2h, 21h ; 1e24b
	ASCII "K" ; 1e251
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e252
	ASCII "M" ; 1e256
	DB 16h, 0B0h, 02h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e257
	ASCII "8" ; 1e25e
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e25f
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h ; 1e267
	ASCII "b" ; 1e26d
	DB 0B5h, 0C5h, 00h, 00h, 0C7h ; 1e26e
	ASCII "o" ; 1e273
	DB 11h, 0CEh, 0C4h, 02h, 0F2h ; 1e274
	ASCII "V" ; 1e279
	DB 0B5h, 0C5h, 00h, 00h, 0C7h, 8Bh, 10h, 0CEh ; 1e27a
	DB 0C4h, 02h, 0F2h ; 1e282
	ASCII "J" ; 1e285
	DB 0B5h, 0C7h, 86h, 9Ch, 0CEh, 0C4h, 07h, 0F2h ; 1e286
	DB 0DBh, 0A0h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h ; 1e28e
	DB 0F2h, 0ECh, 0B8h, 0F2h, 0A4h, 40h, 0F2h, 5Dh ; 1e296
	DB 3Fh, 0F8h, 0F2h ; 1e29e
	ASCII "R?" ; 1e2a1
	DB 0F2h, 93h, 40h, 0CEh, 0C4h, 02h, 0F2h ; 1e2a3
	ASCII "1" ; 1e2aa
	DB 0B8h, 0CEh, 0C4h, 00h, 0F2h ; 1e2ab
	ASCII "HI" ; 1e2b0
	DB 0CEh, 0C4h, 07h, 0F2h, 3Dh, 0A0h, 0C7h ; 1e2b2
	ASCII "P" ; 1e2b9
	DB 0E1h, 0CEh, 0C7h, 01h, 0F2h, 0B2h ; 1e2ba
	ASCII "J" ; 1e2c0
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e2c1
	ASCII "M" ; 1e2c5
	DB 16h, 0B0h, 00h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e2c6
	ASCII "8" ; 1e2cd
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e2ce
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h, 0A7h, 0B8h ; 1e2d6
	DB 0C5h, 00h, 00h, 0C7h ; 1e2de
	ASCII "o" ; 1e2e2
	DB 11h, 0CEh, 0C4h, 02h, 0F2h, 9Bh, 0B8h, 0C5h ; 1e2e3
	DB 00h, 00h, 0C7h, 8Bh, 10h, 0CEh, 0C4h, 02h ; 1e2eb
	DB 0F2h, 8Fh, 0B8h, 0C7h, 8Ch, 9Ch, 0CEh, 0C4h ; 1e2f3
	DB 07h, 0F2h ; 1e2fb
	ASCII "l" ; 1e2fd
	DB 0A0h, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1e2fe
	DB 7Dh, 0B8h, 0F2h ; 1e306
	ASCII "5@" ; 1e309
	DB 0F2h, 0EEh, 3Eh, 0F8h, 0F2h, 0E3h, 3Eh, 0F2h ; 1e30b
	DB 24h, 40h, 0CEh, 0C4h, 02h, 0F2h, 0C2h, 0B7h ; 1e313
	DB 0CEh, 0C4h, 00h, 0F2h, 0D9h ; 1e31b
	ASCII "H" ; 1e320
	DB 0CEh, 0C4h, 07h, 0F2h, 0CEh, 9Fh, 0C7h ; 1e321
	ASCII "v" ; 1e328
	DB 0E1h, 0CEh, 0C7h, 01h, 0F2h ; 1e329
	ASCII "CJ" ; 1e32e
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e330
	ASCII "M" ; 1e334
	DB 16h, 0B0h, 00h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e335
	ASCII "8" ; 1e33c
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e33d
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h ; 1e345
	ASCII "8" ; 1e34b
	DB 0B8h, 0C5h, 00h, 00h, 0C7h ; 1e34c
	ASCII "o" ; 1e351
	DB 11h, 0CEh, 0C4h, 02h, 0F2h, 2Ch, 0B8h, 0C5h ; 1e352
	DB 00h, 00h, 0C7h, 8Bh, 10h, 0CEh, 0C4h, 02h ; 1e35a
	DB 0F2h, 20h, 0B8h, 0C7h, 92h, 9Ch, 0CEh, 0C4h ; 1e362
	DB 07h, 0F2h, 0FDh, 9Fh, 0C7h, 0AEh, 13h, 0CEh ; 1e36a
	DB 0C4h, 02h, 0F2h, 0Eh, 0B8h, 0F2h, 0C6h, 3Fh ; 1e372
	DB 0F2h, 7Fh, 3Eh, 0F8h, 0F2h ; 1e37a
	ASCII "t>" ; 1e37f
	DB 0F2h, 0B5h, 3Fh, 0CEh, 0C4h, 02h, 0F2h ; 1e381
	ASCII "S" ; 1e388
	DB 0B7h, 0CEh, 0C4h, 00h, 0F2h ; 1e389
	ASCII "jH" ; 1e38e
	DB 0CEh, 0C4h, 07h, 0F2h, 5Fh, 9Fh, 0C7h, 9Ch ; 1e390
	DB 0E1h, 0CEh, 0C7h, 01h, 0F2h, 0D4h ; 1e398
	ASCII "I" ; 1e39e
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e39f
	ASCII "M" ; 1e3a3
	DB 16h, 0B0h, 01h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e3a4
	ASCII "8" ; 1e3ab
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e3ac
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h, 0C9h, 0B7h ; 1e3b4
	DB 0C5h, 00h, 00h, 0C7h ; 1e3bc
	ASCII "o" ; 1e3c0
	DB 11h, 0CEh, 0C4h, 02h, 0F2h, 0BDh, 0B7h, 0C5h ; 1e3c1
	DB 00h, 00h, 0C7h, 8Bh, 10h, 0CEh, 0C4h, 02h ; 1e3c9
	DB 0F2h, 0B1h, 0B7h, 0C7h, 98h, 9Ch, 0CEh, 0C4h ; 1e3d1
	DB 07h, 0F2h, 8Eh, 9Fh, 0C7h, 0AEh, 13h, 0CEh ; 1e3d9
	DB 0C4h, 02h, 0F2h, 9Fh, 0B7h, 0F2h ; 1e3e1
	ASCII "W?" ; 1e3e7
	DB 0F2h, 10h, 3Eh, 0F8h
;
	CARL loc_0x002346
	RET
;
	DB 07h, 04h, 3Eh, 80h ; 1e3f1
	ASCII "q" ; 1e3f5
	DB 03h, 80h ; 1e3f6
	ASCII "q" ; 1e3f8
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 1e3f9
	ASCIZ "m/" ; 1e400
	DB 98h, 0E5h, 03h ; 1e403
	ASCII "M" ; 1e406
	DB 91h, 03h, 0B9h, 0A6h, 03h, 18h, 08h, 09h ; 1e407
	ASCIZ "B&" ; 1e40f
	DB 0A0h ; 1e412
	ASCII "z" ; 1e413
	DB 03h, 0Ch, 08h, 07h, 04h, 3Eh, 80h ; 1e414
	ASCII "q" ; 1e41b
	DB 03h, 80h ; 1e41c
	ASCII "q" ; 1e41e
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 1e41f
	ASCIZ "m/" ; 1e426
	DB 98h, 0E5h, 03h, 0B9h, 0A6h, 03h ; 1e429
	ASCII "A" ; 1e42f
	DB 0E5h, 03h, 18h, 08h, 09h ; 1e430
	ASCIZ "B&" ; 1e435
	DB 0A0h ; 1e438
	ASCII "z" ; 1e439
	DB 03h, 0Ch, 08h, 07h, 04h, 3Eh, 80h ; 1e43a
	ASCII "q" ; 1e441
	DB 03h, 80h ; 1e442
	ASCII "q" ; 1e444
	DB 03h, 00h ; 1e445
	ASCII "B" ; 1e447
	DB 06h, 00h ; 1e448
	ASCII "B" ; 1e44a
	DB 06h ; 1e44b
	ASCIZ "m/" ; 1e44c
	DB 98h, 0E5h, 03h, 0D2h, 0E4h, 03h, 0A9h, 0A8h ; 1e44f
	DB 03h, 18h, 08h, 09h ; 1e457
	ASCIZ "B&" ; 1e45b
	DB 60h, 0B2h, 06h, 0Ch, 08h, 0F2h, 8Fh, 3Dh ; 1e45e
	DB 0F2h, 0D0h, 3Eh, 0CEh, 0C4h, 02h, 0F2h ; 1e466
	ASCII "n" ; 1e46d
	DB 0B6h, 0CEh, 0C4h, 00h, 0F2h, 85h ; 1e46e
	ASCII "G" ; 1e474
	DB 0CEh, 0C4h, 07h, 0F2h ; 1e475
	ASCII "z" ; 1e479
	DB 9Eh, 0C7h, 0F1h, 0E3h, 0CEh, 0C7h, 01h, 0F2h ; 1e47a
	DB 0EFh ; 1e482
	ASCII "H" ; 1e483
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e484
	ASCII "M" ; 1e488
	DB 16h, 0B0h, 00h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e489
	ASCII "8" ; 1e490
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e491
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h, 0E4h, 0B6h ; 1e499
	DB 0C5h, 00h, 00h, 0C7h ; 1e4a1
	ASCII "o" ; 1e4a5
	DB 11h, 0CEh, 0C4h, 02h, 0F2h, 0D8h, 0B6h, 0C5h ; 1e4a6
	DB 00h, 00h, 0C7h, 8Bh, 10h, 0CEh, 0C4h, 02h ; 1e4ae
	DB 0F2h, 0CCh, 0B6h, 0C7h ; 1e4b6
	ASCII "a" ; 1e4ba
	DB 9Eh, 0CEh, 0C4h, 07h, 0F2h, 0A9h, 9Eh, 0C7h ; 1e4bb
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0BAh, 0B6h ; 1e4c3
	DB 0F2h ; 1e4cb
	ASCII "r>" ; 1e4cc
	DB 0F2h, 2Bh, 3Dh, 0F8h, 0F2h, 20h, 3Dh, 0F2h ; 1e4ce
	ASCII "a>" ; 1e4d6
	DB 0CEh, 0C4h, 02h, 0F2h, 0FFh, 0B5h, 0CEh, 0C4h ; 1e4d8
	DB 00h, 0F2h, 16h ; 1e4e0
	ASCII "G" ; 1e4e3
	DB 0CEh, 0C4h, 07h, 0F2h, 0Bh, 9Eh, 0C7h, 17h ; 1e4e4
	DB 0E4h, 0CEh, 0C7h, 01h, 0F2h, 80h ; 1e4ec
	ASCII "H" ; 1e4f2
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e4f3
	ASCII "M" ; 1e4f7
	DB 16h, 0B0h, 00h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e4f8
	ASCII "8" ; 1e4ff
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e500
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h ; 1e508
	ASCII "u" ; 1e50e
	DB 0B6h, 0C5h, 00h, 00h, 0C7h ; 1e50f
	ASCII "o" ; 1e514
	DB 11h, 0CEh, 0C4h, 02h, 0F2h ; 1e515
	ASCII "i" ; 1e51a
	DB 0B6h, 0C5h, 00h, 00h, 0C7h, 8Bh, 10h, 0CEh ; 1e51b
	DB 0C4h, 02h, 0F2h, 5Dh, 0B6h, 0C7h ; 1e523
	ASCII "g" ; 1e529
	DB 9Eh, 0CEh, 0C4h, 07h, 0F2h, 3Ah, 9Eh, 0C7h ; 1e52a
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1e532
	ASCII "K" ; 1e538
	DB 0B6h, 0F2h, 03h, 3Eh, 0F2h, 0BCh, 3Ch, 0F8h ; 1e539
	DB 0F2h, 0B1h, 3Ch, 0F2h, 0F2h, 3Dh, 0CEh, 0C4h ; 1e541
	DB 02h, 0F2h, 90h, 0B5h, 0CEh, 0C4h, 00h, 0F2h ; 1e549
	DB 0A7h ; 1e551
	ASCII "F" ; 1e552
	DB 0CEh, 0C4h, 07h, 0F2h, 9Ch, 9Dh, 0C7h, 3Dh ; 1e553
	DB 0E4h, 0CEh, 0C7h, 01h, 0F2h, 11h ; 1e55b
	ASCII "H" ; 1e561
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e562
	ASCII "M" ; 1e566
	DB 16h, 0B0h, 01h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e567
	ASCII "8" ; 1e56e
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e56f
	DB 8Bh, 10h, 0CEh, 0C4h, 02h, 0F2h, 06h, 0B6h ; 1e577
	DB 0C7h ; 1e57f
	ASCII "m" ; 1e580
	DB 9Eh, 0CEh, 0C4h, 07h, 0F2h, 0E3h, 9Dh, 0C7h ; 1e581
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0F4h, 0B5h ; 1e589
	DB 0F2h, 0ACh, 3Dh, 0F2h ; 1e591
	ASCII "e<" ; 1e595
	DB 0F8h, 0F2h, 0ACh, 3Dh, 0F8h, 0Dh, 04h, 3Eh ; 1e597
	DB 80h ; 1e59f
	ASCII "q" ; 1e5a0
	DB 03h, 80h ; 1e5a1
	ASCII "q" ; 1e5a3
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 1e5a4
	ASCIZ "m/" ; 1e5ab
	ASCII "1" ; 1e5ae
	DB 0E6h, 03h ; 1e5af
	ASCII "9" ; 1e5b1
	DB 86h, 03h ; 1e5b2
	ASCII "9" ; 1e5b4
	DB 86h, 03h, 18h, 08h, 02h ; 1e5b5
	ASCIZ "B&" ; 1e5ba
	DB 0A0h ; 1e5bd
	ASCII "z" ; 1e5be
	DB 03h, 0Ch, 08h, 0F2h ; 1e5bf
	ASCII "0<" ; 1e5c3
	DB 0F2h ; 1e5c5
	ASCII "q=" ; 1e5c6
	DB 0CEh, 0C4h, 02h, 0F2h, 0Fh, 0B5h, 0CEh, 0C4h ; 1e5c8
	DB 00h, 0F2h, 26h ; 1e5d0
	ASCII "F" ; 1e5d3
	DB 0CEh, 0C4h, 07h, 0F2h, 1Bh, 9Dh, 0C7h, 9Ch ; 1e5d4
	DB 0E5h, 0CEh, 0C7h, 01h, 0F2h, 90h ; 1e5dc
	ASCII "G" ; 1e5e2
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e5e3
	ASCII "M" ; 1e5e7
	DB 16h, 0B0h, 00h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e5e8
	ASCII "8" ; 1e5ef
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e5f0
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h, 85h, 0B5h ; 1e5f8
	DB 0C5h, 00h, 00h, 0C7h ; 1e600
	ASCII "o" ; 1e604
	DB 11h, 0CEh, 0C4h, 02h, 0F2h ; 1e605
	ASCII "y" ; 1e60a
	DB 0B5h, 0C5h, 00h, 00h, 0C7h, 8Bh, 10h, 0CEh ; 1e60b
	DB 0C4h, 02h, 0F2h ; 1e613
	ASCII "m" ; 1e616
	DB 0B5h, 0C7h, 0C9h, 9Eh, 0CEh, 0C4h, 07h, 0F2h ; 1e617
	ASCII "J" ; 1e61f
	DB 9Dh, 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1e620
	DB 5Bh, 0B5h, 0F2h, 13h, 3Dh, 0F2h, 0CCh, 3Bh ; 1e628
	DB 0F8h, 0F2h, 0BEh, 0A3h, 0F2h, 10h, 3Dh, 0F8h ; 1e630
	DB 06h, 04h, 3Eh, 80h ; 1e638
	ASCII "q" ; 1e63c
	DB 03h, 80h ; 1e63d
	ASCII "q" ; 1e63f
	DB 03h, 00h, 20h, 06h, 00h, 20h, 06h ; 1e640
	ASCIZ "m/" ; 1e647
	DB 5Bh, 0E7h, 03h, 0EFh, 80h, 03h, 0EFh, 80h ; 1e64a
	DB 03h, 10h, 02h, 03h ; 1e652
	ASCIZ "B&" ; 1e656
	DB 0A0h, 0B1h, 06h, 0Ch, 08h, 0C5h, 0ACh, 1Bh ; 1e659
	ASCII "8" ; 1e661
	DB 0B1h, 05h, 0CEh ; 1e662
	ASCII "5" ; 1e665
	DB 0F4h, 0E6h, 02h, 80h, 91h, 0F5h, 0F8h, 0F8h ; 1e666
	DB 0F2h, 84h, 3Bh, 0F2h, 0C5h, 3Ch, 0CEh, 0C4h ; 1e66e
	DB 02h, 0F2h ; 1e676
	ASCII "c" ; 1e678
	DB 0B4h, 0CEh, 0C4h, 00h, 0F2h ; 1e679
	ASCII "zE" ; 1e67e
	DB 0CEh, 0C4h, 07h, 0F2h ; 1e680
	ASCII "o" ; 1e684
	DB 9Ch, 0F2h, 0F5h ; 1e685
	ASCII "A" ; 1e688
	DB 0F1h, 19h, 0F2h ; 1e689
	ASCII "g;" ; 1e68c
	DB 0F2h, 0A8h, 3Ch, 0CEh, 0C4h, 02h, 0F2h ; 1e68e
	ASCII "F" ; 1e695
	DB 0B4h, 0CEh, 0C4h, 00h, 0F2h, 5Dh ; 1e696
	ASCII "E" ; 1e69c
	DB 0CEh, 0C4h, 07h, 0F2h ; 1e69d
	ASCII "R" ; 1e6a1
	DB 9Ch, 0CEh, 0D0h, 0BCh, 1Ah, 20h, 0EFh, 0E0h ; 1e6a2
	DB 0C4h, 0F2h, 0E4h, 00h ; 1e6aa
	ASCII "8" ; 1e6ae
	DB 0F1h, 1Bh, 0F2h ; 1e6af
	ASCII "A;" ; 1e6b2
	DB 0F2h, 82h, 3Ch, 0CEh, 0C4h, 02h, 0F2h, 20h ; 1e6b4
	DB 0B4h, 0CEh, 0C4h, 00h, 0F2h ; 1e6bc
	ASCII "7E" ; 1e6c1
	DB 0CEh, 0C4h, 07h, 0F2h, 2Ch, 9Ch, 0B0h, 01h ; 1e6c3
	DB 0CEh, 0D4h, 0ABh, 1Bh, 0C7h ; 1e6cb
	ASCII "8" ; 1e6d0
	DB 0E6h, 0CEh, 0C7h, 01h, 0F2h, 9Bh ; 1e6d1
	ASCII "F" ; 1e6d7
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e6d8
	ASCII "M" ; 1e6dc
	DB 16h, 0F2h, 0D4h, 00h ; 1e6dd
	ASCII "8" ; 1e6e1
	DB 0CEh, 0D4h, 0B3h, 1Bh, 0CEh, 0D4h, 0B4h, 1Bh ; 1e6e2
	DB 0CEh, 0C4h, 03h, 0F2h ; 1e6ea
	ASCII "o" ; 1e6ee
	DB 0FFh ; 1e6ef
	ASCIZ "2" ; 1e6f0
	DB 0E6h, 03h, 0B0h, 3Bh, 0CEh, 0D4h, 0B6h, 1Bh ; 1e6f2
	DB 0CEh, 0C4h, 03h, 0F2h, 5Fh, 0FFh ; 1e6fa
	ASCII "2" ; 1e700
	DB 05h, 0E7h, 02h, 88h, 0CEh, 0D4h, 0B5h, 1Bh ; 1e701
	DB 0C5h, 00h, 00h, 0C7h ; 1e709
	ASCII "t" ; 1e70d
	DB 0Dh, 0CEh, 0C4h, 02h, 0F2h ; 1e70e
	ASCII "p" ; 1e713
	DB 0B4h, 0C5h, 18h, 00h, 0C7h, 0B6h, 07h, 0CEh ; 1e714
	DB 0C4h, 02h, 0F2h ; 1e71c
	ASCII "d" ; 1e71f
	DB 0B4h, 0C5h, 60h, 00h, 0C7h, 7Fh, 0Eh, 0CEh ; 1e720
	DB 0C4h, 02h, 0F2h ; 1e728
	ASCII "X" ; 1e72b
	DB 0B4h, 0C5h, 40h, 00h, 0C7h, 0A5h, 0Dh, 0CEh ; 1e72c
	DB 0C4h, 02h, 0F2h ; 1e734
	ASCII "L" ; 1e737
	DB 0B4h, 0C7h, 0EEh, 95h, 0CEh, 0C4h, 07h, 0F2h ; 1e738
	DB 29h, 9Ch, 0C7h ; 1e740
	ASCII "C" ; 1e743
	DB 96h, 0CEh, 0C4h, 07h, 0F2h, 20h, 9Ch, 0C7h ; 1e744
	DB 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h ; 1e74c
	ASCII "1" ; 1e752
	DB 0B4h, 0F2h, 0E9h, 3Bh, 0F2h, 0A2h, 3Ah, 0F8h ; 1e753
	DB 0F2h, 0E9h, 3Bh, 0C5h ; 1e75b
	ASCII "C" ; 1e75f
	DB 16h, 95h, 01h, 0E7h, 02h, 0F8h, 0CEh, 0D0h ; 1e760
	DB 0B3h, 1Bh ; 1e768
	ASCII "2" ; 1e76a
	DB 02h, 0E7h, 23h, 0F2h ; 1e76b
	ASCIZ "g" ; 1e76f
	DB 0CEh, 0D0h, 0ABh, 1Bh, 20h, 0E7h, 10h, 0B0h ; 1e771
	DB 01h, 0CEh, 0D4h, 0BCh, 1Ah, 0C5h ; 1e779
	ASCII "j" ; 1e77f
	DB 0ABh, 0B1h, 03h, 0F2h, 0Ah, 3Bh, 0F8h, 0C5h ; 1e780
	DB 0CFh, 80h, 0B1h, 03h, 0F2h, 01h, 3Bh, 0F8h ; 1e788
	DB 0F8h, 0C4h, 0F4h, 0F4h, 0BCh, 0BDh, 1Ah, 0BCh ; 1e790
	DB 0BFh, 1Ah, 0CEh, 0D4h, 0C1h, 1Ah, 0BCh, 0ACh ; 1e798
	DB 1Bh, 0BCh, 0AEh, 1Bh, 0CEh, 0D4h, 0B0h, 1Bh ; 1e7a0
	DB 0B0h, 0FDh, 0CEh, 0D4h, 0B1h, 1Bh ; 1e7a8
	ASCII "8" ; 1e7ae
	DB 0CEh, 0D4h, 0B2h, 1Bh, 0F8h, 0B8h, 0BDh, 1Ah ; 1e7af
	DB 0BCh, 0ACh, 1Bh, 0B8h, 0BFh, 1Ah, 0BCh, 0AEh ; 1e7b7
	DB 1Bh, 0CEh, 0D0h, 0C1h, 1Ah, 0CEh, 0D4h, 0B0h ; 1e7bf
	DB 1Bh, 0B0h, 0FDh, 0CEh, 0D4h, 0B1h, 1Bh, 0CEh ; 1e7c7
	DB 0D0h, 0C2h, 1Ah, 0CEh, 0D4h, 0B2h, 1Bh, 0F8h ; 1e7cf
	DB 0B8h, 0ACh, 1Bh, 0BCh, 0BDh, 1Ah, 0B8h, 0AEh ; 1e7d7
	DB 1Bh, 0BCh, 0BFh, 1Ah, 0CEh, 0D0h, 0B0h, 1Bh ; 1e7df
	DB 0CEh, 0D4h, 0C1h, 1Ah, 0CEh, 0D0h, 0B2h, 1Bh ; 1e7e7
	DB 0CEh, 0D4h, 0C2h, 1Ah, 0F8h, 0C6h, 0ACh, 1Bh ; 1e7ef
	DB 0B0h, 0F4h, 0B1h, 05h ; 1e7f7
	ASCII "6" ; 1e7fb
	DB 0E7h, 04h, 92h, 0F5h, 0FBh, 0F8h, 0Dh, 04h ; 1e7fc
	DB 3Eh, 80h ; 1e804
	ASCII "q" ; 1e806
	DB 03h, 80h ; 1e807
	ASCII "q" ; 1e809
	DB 03h, 00h, 22h, 06h, 00h, 22h, 06h ; 1e80a
	ASCIZ "m/" ; 1e811
	DB 97h, 0E8h, 03h, 0Fh, 0E3h, 03h, 0B5h, 86h ; 1e814
	DB 03h, 18h, 08h, 02h ; 1e81c
	ASCIZ "B&" ; 1e820
	DB 60h, 0B2h, 06h, 0Ch, 08h, 0F2h, 0CAh ; 1e823
	ASCII "9" ; 1e82a
	DB 0F2h, 0Bh, 3Bh, 0CEh, 0C4h, 02h, 0F2h, 0A9h ; 1e82b
	DB 0B2h, 0CEh, 0C4h, 00h, 0F2h, 0C0h ; 1e833
	ASCII "C" ; 1e839
	DB 0CEh, 0C4h, 07h, 0F2h, 0B5h, 9Ah, 0C7h, 02h ; 1e83a
	DB 0E8h, 0CEh, 0C7h, 01h, 0F2h, 2Ah ; 1e842
	ASCII "E" ; 1e848
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e849
	ASCII "M" ; 1e84d
	DB 16h, 0B0h, 01h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e84e
	ASCII "8" ; 1e855
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0C5h, 00h, 00h, 0C7h ; 1e856
	DB 06h, 11h, 0CEh, 0C4h, 02h, 0F2h, 1Fh, 0B3h ; 1e85e
	DB 0C5h, 00h, 00h, 0C7h ; 1e866
	ASCII "o" ; 1e86a
	DB 11h, 0CEh, 0C4h, 02h, 0F2h, 13h, 0B3h, 0C5h ; 1e86b
	DB 00h, 00h, 0C7h, 8Bh, 10h, 0CEh, 0C4h, 02h ; 1e873
	DB 0F2h, 07h, 0B3h, 0C7h, 0D7h, 0D3h, 0CEh, 0C4h ; 1e87b
	DB 07h, 0F2h, 0E4h, 9Ah, 0C7h, 0AEh, 13h, 0CEh ; 1e883
	DB 0C4h, 02h, 0F2h, 0F5h, 0B2h, 0F2h, 0ADh, 3Ah ; 1e88b
	DB 0F2h ; 1e893
	ASCII "f9" ; 1e894
	DB 0F8h, 0F2h ; 1e896
	ASCII "X" ; 1e898
	DB 0A1h, 0F2h, 0AAh, 3Ah, 0F8h, 0Dh, 04h, 3Eh ; 1e899
	DB 80h ; 1e8a1
	ASCII "q" ; 1e8a2
	DB 03h, 80h ; 1e8a3
	ASCII "q" ; 1e8a5
	DB 03h, 00h, 40h, 03h, 00h, 40h, 03h ; 1e8a6
	ASCIZ "m/" ; 1e8ad
	DB 1Ch, 0E9h, 03h, 0D0h, 0A7h, 03h, 0D0h, 0A7h ; 1e8b0
	DB 03h, 18h, 08h, 02h, 00h, 00h, 00h, 0A0h ; 1e8b8
	ASCII "z" ; 1e8c0
	DB 03h, 0Ch, 08h, 0F2h, 2Eh ; 1e8c1
	ASCII "9" ; 1e8c6
	DB 0F2h ; 1e8c7
	ASCII "o:" ; 1e8c8
	DB 0CEh, 0C4h, 02h, 0F2h, 0Dh, 0B2h, 0CEh, 0C4h ; 1e8ca
	DB 00h, 0F2h, 24h ; 1e8d2
	ASCII "C" ; 1e8d5
	DB 0CEh, 0C4h, 07h, 0F2h, 19h, 9Ah, 0C7h, 9Eh ; 1e8d6
	DB 0E8h, 0CEh, 0C7h, 01h, 0F2h, 8Eh ; 1e8de
	ASCII "D" ; 1e8e4
	DB 0B0h, 00h, 0CEh, 0D4h ; 1e8e5
	ASCII "M" ; 1e8e9
	DB 16h, 0B0h, 00h, 0CEh, 0D4h, 0A4h, 1Bh ; 1e8ea
	ASCII "8" ; 1e8f1
	DB 0CEh, 0D4h, 0A5h, 1Bh, 0CEh, 0D0h, 0D5h, 1Ah ; 1e8f2
	DB 0CEh, 0D4h, 0A8h, 1Bh ; 1e8fa
	ASCII "8" ; 1e8fe
	DB 0CEh, 0D4h, 0AAh, 1Bh, 0C7h, 5Fh, 0A3h, 0CEh ; 1e8ff
	DB 0C4h, 07h, 0F2h, 5Fh, 9Ah, 0C7h, 0AEh, 13h ; 1e907
	DB 0CEh, 0C4h, 02h, 0F2h ; 1e90f
	ASCII "p" ; 1e913
	DB 0B2h, 0F2h, 28h, 3Ah, 0F2h, 0E1h ; 1e914
	ASCII "8" ; 1e91a
	DB 0F8h, 0F2h, 0D3h, 0A0h, 0F2h, 25h, 3Ah, 0F8h ; 1e91b
	DB 07h, 04h, 3Eh, 00h ; 1e923
	ASCII "R" ; 1e927
	DB 06h, 00h ; 1e928
	ASCII "R" ; 1e92a
	DB 06h, 00h, 80h, 05h, 00h, 80h, 05h ; 1e92b
	ASCIZ "m/" ; 1e932
	DB 8Ch, 0E9h, 03h, 00h, 00h, 00h, 00h, 00h ; 1e935
	DB 00h, 18h, 08h, 01h ; 1e93d
	ASCIZ "B&" ; 1e941
	DB 0D8h, 7Eh, 03h, 0Ch, 08h, 0F2h, 0A9h ; 1e944
	ASCII "8" ; 1e94b
	DB 0F2h, 0EAh ; 1e94c
	ASCII "9" ; 1e94e
	DB 0CEh, 0C4h, 02h, 0F2h, 88h, 0B1h, 0CEh, 0C4h ; 1e94f
	DB 00h, 0F2h, 9Fh ; 1e957
	ASCII "B" ; 1e95a
	DB 0CEh, 0C4h, 07h, 0F2h, 94h, 99h, 0C7h, 23h ; 1e95b
	DB 0E9h, 0CEh, 0C7h, 01h, 0F2h, 09h ; 1e963
	ASCII "D" ; 1e969
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 12h ; 1e96a
	DB 0B2h, 0F2h, 0CAh ; 1e972
	ASCII "9" ; 1e975
	DB 0F2h, 83h ; 1e976
	ASCII "8" ; 1e978
	DB 0F8h, 0C6h, 0D8h, 7Eh, 0CEh, 0C6h, 03h, 0F2h ; 1e979
	DB 0C0h, 3Ch, 0C5h, 8Ch, 0E9h, 0B1h, 03h, 0F2h ; 1e981
	DB 0F2h ; 1e989
	ASCII "8" ; 1e98a
	DB 0F8h, 0F2h, 0B8h ; 1e98b
	ASCII "9" ; 1e98e
	DB 0CEh, 0D0h ; 1e98f
	ASCII "C" ; 1e991
	DB 16h, 96h, 01h, 0E7h, 06h, 96h, 02h, 0E7h ; 1e992
	DB 13h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1e99a
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1e9a2
	DB 18h, 00h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 1e9aa
	DB 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h ; 1e9b2
	DB 0C5h, 0ACh, 9Ch, 0B1h, 03h, 0F2h, 0CEh ; 1e9ba
	ASCII "8" ; 1e9c1
	DB 0F8h, 0C6h ; 1e9c2
	ASCII "8" ; 1e9c4
	DB 0CEh, 0C6h, 03h, 0F2h ; 1e9c6
	ASCII "w<" ; 1e9ca
	DB 0C5h, 0D5h, 0E9h, 0B1h, 03h, 0F2h, 0A9h ; 1e9cc
	ASCII "8" ; 1e9d3
	DB 0F8h, 0B1h, 18h, 0CFh, 0B1h, 0F2h ; 1e9d4
	ASCII "k9" ; 1e9da
	DB 0CFh, 0B5h, 0CEh, 0D0h ; 1e9dc
	ASCII "C" ; 1e9e0
	DB 16h, 96h, 02h, 0E7h ; 1e9e1
	ASCII "q" ; 1e9e5
	DB 0F5h, 0F0h, 0F2h, 9Ch ; 1e9e6
	ASCII "l" ; 1e9ea
	DB 0B1h ; 1e9eb
	ASCII "K" ; 1e9ec
	DB 0CFh, 0B1h, 0B0h, 01h, 0B1h, 00h, 0F2h, 91h ; 1e9ed
	ASCII "m" ; 1e9f5
	DB 0CFh, 0B5h ; 1e9f6
	ASCIZ "2" ; 1e9f8
	DB 0E6h, 0Ah, 0F2h ; 1e9fa
	ASCII "u" ; 1e9fd
	DB 03h, 0E7h ; 1e9fe
	ASCII "V" ; 1ea00
	DB 0F5h, 0EBh, 0F1h ; 1ea01
	ASCII "c" ; 1ea04
	DB 0B1h ; 1ea05
	ASCII "2" ; 1ea06
	DB 0CFh, 0B1h, 0B0h, 01h, 0B1h, 10h, 0C6h, 9Ah ; 1ea07
	DB 0EDh, 0CEh, 0C6h, 01h, 0F2h ; 1ea0f
	ASCII "qm" ; 1ea14
	DB 0CFh, 0B5h ; 1ea16
	ASCIZ "2" ; 1ea18
	DB 0E6h, 0Ah, 0F2h ; 1ea1a
	ASCII "U" ; 1ea1d
	DB 03h, 0E7h ; 1ea1e
	ASCII "6" ; 1ea20
	DB 0F5h, 0E5h, 0F1h ; 1ea21
	ASCII "C" ; 1ea24
	DB 0B1h ; 1ea25
	ASCII "2" ; 1ea26
	DB 0CFh, 0B1h, 0B0h, 01h, 0B1h, 01h, 0C6h, 0C9h ; 1ea27
	DB 1Bh, 0CEh, 0C6h, 00h, 0F2h ; 1ea2f
	ASCII "Qm" ; 1ea34
	DB 0CFh, 0B5h ; 1ea36
	ASCIZ "2" ; 1ea38
	DB 0E6h, 0Ah, 0F2h ; 1ea3a
	ASCII "5" ; 1ea3d
	DB 03h, 0E7h, 16h, 0F5h, 0E5h, 0F1h, 23h, 0CEh ; 1ea3e
	DB 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h, 01h ; 1ea46
	DB 0CEh, 0D4h, 0FAh, 14h, 0F2h, 24h, 00h, 0F8h ; 1ea4e
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 1ea56
	DB 02h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1ea5e
	ASCIZ "g" ; 1ea64
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1ea66
	DB 0B0h, 03h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 0A4h ; 1ea6e
	DB 00h, 0F8h, 0C6h, 0F8h, 7Fh, 0CEh, 0C6h, 03h ; 1ea76
	DB 0F2h, 0C2h, 3Bh, 0C5h, 90h, 0EAh, 0B1h, 03h ; 1ea7e
	DB 0F2h, 0F4h ; 1ea86
	ASCII "7" ; 1ea88
	DB 0CEh, 0C4h, 03h, 0F2h, 0FBh, 0B0h, 0F8h, 0F2h ; 1ea89
	DB 0B4h ; 1ea91
	ASCII "8" ; 1ea92
	DB 0CEh, 0D0h ; 1ea93
	ASCII "C" ; 1ea95
	DB 16h, 96h, 01h, 0E7h, 06h, 96h, 02h, 0E7h ; 1ea96
	DB 18h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1ea9e
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h ; 1eaa6
	DB 0C1h, 97h, 0B1h, 03h, 0F2h, 0DBh ; 1eaae
	ASCII "7" ; 1eab4
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1eab5
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0C1h ; 1eabd
	DB 97h, 0B1h, 03h, 0F2h, 0C5h ; 1eac5
	ASCII "7" ; 1eaca
	DB 0F8h, 0C6h, 0B8h, 80h, 0CEh, 0C6h, 03h, 0F2h ; 1eacb
	ASCII "n;" ; 1ead3
	DB 0C5h, 0DEh, 0EAh, 0B1h, 03h, 0F2h, 0A0h ; 1ead5
	ASCII "7" ; 1eadc
	DB 0F8h, 0F2h ; 1eadd
	ASCII "f8" ; 1eadf
	DB 0CEh, 0D0h ; 1eae1
	ASCII "C" ; 1eae3
	DB 16h, 96h, 01h, 0E7h, 06h, 96h, 02h, 0E7h ; 1eae4
	DB 18h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1eaec
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h ; 1eaf4
	DB 0C1h, 97h, 0B1h, 03h, 0F2h, 8Dh ; 1eafc
	ASCII "7" ; 1eb02
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1eb03
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0C1h ; 1eb0b
	DB 97h, 0B1h, 03h, 0F2h ; 1eb13
	ASCII "w7" ; 1eb17
	DB 0F8h, 0C6h ; 1eb19
	ASCII "X" ; 1eb1b
	DB 80h, 0CEh, 0C6h, 03h, 0F2h, 20h, 3Bh, 0C5h ; 1eb1c
	DB 2Ch, 0EBh, 0B1h, 03h, 0F2h ; 1eb24
	ASCII "R7" ; 1eb29
	DB 0F8h, 0F2h, 18h ; 1eb2b
	ASCII "8" ; 1eb2e
	DB 0CEh, 0D0h ; 1eb2f
	ASCII "C" ; 1eb31
	DB 16h, 96h, 01h, 0E7h, 06h, 96h, 02h, 0E7h ; 1eb32
	DB 13h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1eb3a
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1eb42
	DB 2Fh, 0FEh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 1eb4a
	DB 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h ; 1eb52
	DB 0C5h, 0C1h, 97h, 0B1h, 03h, 0F2h, 2Eh ; 1eb5a
	ASCII "7" ; 1eb61
	DB 0F8h, 07h, 04h, 3Eh, 00h ; 1eb62
	ASCII "R" ; 1eb67
	DB 06h, 00h ; 1eb68
	ASCII "R" ; 1eb6a
	DB 06h, 00h, 80h, 05h, 00h, 80h, 05h ; 1eb6b
	ASCIZ "m/" ; 1eb72
	DB 0BAh, 0EBh, 03h, 00h, 00h, 00h, 00h, 00h ; 1eb75
	DB 00h, 18h, 08h, 01h ; 1eb7d
	ASCIZ "B&" ; 1eb81
	DB 98h, 7Fh, 03h, 0Ch, 08h, 0F2h ; 1eb84
	ASCII "i6" ; 1eb8a
	DB 0F2h, 0AAh ; 1eb8c
	ASCII "7" ; 1eb8e
	DB 0CEh, 0C4h, 02h, 0F2h ; 1eb8f
	ASCII "H" ; 1eb93
	DB 0AFh, 0CEh, 0C4h, 00h, 0F2h, 5Fh, 40h, 0CEh ; 1eb94
	DB 0C4h, 07h, 0F2h ; 1eb9c
	ASCII "T" ; 1eb9f
	DB 97h, 0C7h ; 1eba0
	ASCII "c" ; 1eba2
	DB 0EBh, 0CEh, 0C7h, 01h, 0F2h, 0C9h ; 1eba3
	ASCII "A" ; 1eba9
	DB 0C7h, 0AEh, 13h, 0CEh, 0C4h, 02h, 0F2h, 0D2h ; 1ebaa
	DB 0AFh, 0F2h, 8Ah ; 1ebb2
	ASCII "7" ; 1ebb5
	DB 0F2h ; 1ebb6
	ASCII "C6" ; 1ebb7
	DB 0F8h, 0F2h, 8Ah ; 1ebb9
	ASCII "7" ; 1ebbc
	DB 0C5h ; 1ebbd
	ASCII "k" ; 1ebbe
	DB 16h, 95h, 04h, 0E7h, 02h, 0F8h, 0C6h, 98h ; 1ebbf
	DB 7Fh, 0CEh, 0C6h, 03h, 0F2h ; 1ebc7
	ASCII "u:" ; 1ebcc
	DB 0C5h, 0D7h, 0EBh, 0B1h, 03h, 0F2h, 0A7h ; 1ebce
	ASCII "6" ; 1ebd5
	DB 0F8h, 0B1h, 18h, 0CFh, 0B1h, 0F2h ; 1ebd6
	ASCII "i7" ; 1ebdc
	DB 0CFh, 0B5h, 0CEh, 0D0h ; 1ebde
	ASCII "C" ; 1ebe2
	DB 16h, 96h, 02h, 0E7h, 7Fh, 0F5h, 0F0h, 0F2h ; 1ebe3
	DB 9Ah ; 1ebeb
	ASCII "j" ; 1ebec
	DB 0B1h, 0B5h, 0CFh, 0B1h, 0B0h, 00h, 0C7h, 0FFh ; 1ebed
	DB 0Fh, 0F2h ; 1ebf5
	ASCII "Jl" ; 1ebf7
	DB 0CFh, 0B5h ; 1ebf9
	ASCIZ "2" ; 1ebfb
	DB 0E6h, 0Ah, 0F2h ; 1ebfd
	ASCII "r" ; 1ec00
	DB 01h, 0E7h ; 1ec01
	ASCII "c" ; 1ec03
	DB 0F5h, 0EAh, 0F1h ; 1ec04
	ASCII "p" ; 1ec07
	DB 0B1h ; 1ec08
	ASCII "2" ; 1ec09
	DB 0CFh, 0B1h, 0B0h, 10h, 0C6h, 0B9h, 1Bh, 0CEh ; 1ec0a
	DB 0C6h, 00h, 0C7h, 0FFh, 0Fh, 0F2h, 29h ; 1ec12
	ASCII "l" ; 1ec19
	DB 0CFh, 0B5h ; 1ec1a
	ASCIZ "2" ; 1ec1c
	DB 0E6h, 0Ah, 0F2h ; 1ec1e
	ASCII "Q" ; 1ec21
	DB 01h, 0E7h ; 1ec22
	ASCII "B" ; 1ec24
	DB 0F5h, 0E4h, 0F1h ; 1ec25
	ASCII "O" ; 1ec28
	DB 0C6h, 9Ah, 0EDh, 0CEh, 0C6h, 01h, 0F2h ; 1ec29
	ASCII "V" ; 1ec30
	DB 01h, 0E7h ; 1ec31
	ASCII "D" ; 1ec33
	DB 0B1h ; 1ec34
	ASCII "2" ; 1ec35
	DB 0CFh, 0B1h, 0B0h, 01h, 0C6h, 0C9h, 1Bh, 0CEh ; 1ec36
	DB 0C6h, 00h, 0C7h, 0FFh, 0Fh, 0F2h, 0FDh ; 1ec3e
	ASCII "k" ; 1ec45
	DB 0CFh, 0B5h ; 1ec46
	ASCIZ "2" ; 1ec48
	DB 0E6h, 0Ah, 0F2h, 25h, 01h, 0E7h, 16h, 0F5h ; 1ec4a
	DB 0E4h, 0F1h, 23h, 0CEh, 0D0h, 0B6h, 1Ah, 20h ; 1ec52
	DB 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h ; 1ec5a
	DB 0F2h, 24h, 00h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah ; 1ec62
	DB 20h, 0E6h, 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh ; 1ec6a
	DB 14h, 0F2h ; 1ec72
	ASCIZ "g" ; 1ec74
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1ec76
	DB 0B0h, 03h, 0CEh, 0D4h, 0FAh, 14h, 0F2h, 0A4h ; 1ec7e
	DB 00h, 0F8h, 0C6h, 0F8h, 7Fh, 0CEh, 0C6h, 03h ; 1ec86
	DB 0F2h, 0B2h ; 1ec8e
	ASCII "9" ; 1ec90
	DB 0C5h, 0A0h, 0ECh, 0B1h, 03h, 0F2h, 0E4h ; 1ec91
	ASCII "5" ; 1ec98
	DB 0CEh, 0C4h, 03h, 0F2h, 02h, 0AFh, 0F8h, 0F2h ; 1ec99
	DB 0A4h ; 1eca1
	ASCII "6" ; 1eca2
	DB 0CEh, 0D0h ; 1eca3
	ASCII "C" ; 1eca5
	DB 16h, 96h, 01h, 0E7h, 06h, 96h, 02h, 0E7h ; 1eca6
	DB 18h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1ecae
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h ; 1ecb6
	DB 18h, 9Bh, 0B1h, 03h, 0F2h, 0CBh ; 1ecbe
	ASCII "5" ; 1ecc4
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1ecc5
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 18h ; 1eccd
	DB 9Bh, 0B1h, 03h, 0F2h, 0B5h ; 1ecd5
	ASCII "5" ; 1ecda
	DB 0F8h, 0C6h, 0B8h, 80h, 0CEh, 0C6h, 03h, 0F2h ; 1ecdb
	DB 5Eh ; 1ece3
	ASCII "9" ; 1ece4
	DB 0C5h, 0EEh, 0ECh, 0B1h, 03h, 0F2h, 90h ; 1ece5
	ASCII "5" ; 1ecec
	DB 0F8h, 0F2h ; 1eced
	ASCII "V6" ; 1ecef
	DB 0CEh, 0D0h ; 1ecf1
	ASCII "C" ; 1ecf3
	DB 16h, 96h, 01h, 0E7h, 06h, 96h, 02h, 0E7h ; 1ecf4
	DB 18h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1ecfc
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0C5h ; 1ed04
	DB 0C1h, 97h, 0B1h, 03h, 0F2h, 7Dh ; 1ed0c
	ASCII "5" ; 1ed12
	DB 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h ; 1ed13
	DB 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C5h, 0C1h ; 1ed1b
	DB 97h, 0B1h, 03h, 0F2h ; 1ed23
	ASCII "g5" ; 1ed27
	DB 0F8h, 0C6h ; 1ed29
	ASCII "X" ; 1ed2b
	DB 80h, 0CEh, 0C6h, 03h, 0F2h, 10h ; 1ed2c
	ASCII "9" ; 1ed32
	DB 0C5h, 3Ch, 0EDh, 0B1h, 03h, 0F2h ; 1ed33
	ASCII "B5" ; 1ed39
	DB 0F8h, 0F2h, 08h ; 1ed3b
	ASCII "6" ; 1ed3e
	DB 0CEh, 0D0h ; 1ed3f
	ASCII "C" ; 1ed41
	DB 16h, 96h, 01h, 0E7h, 06h, 96h, 02h, 0E7h ; 1ed42
	DB 13h, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1ed4a
	DB 07h, 0B0h, 01h, 0CEh, 0D4h, 0FAh, 14h, 0F2h ; 1ed52
	ASCII "j" ; 1ed5a
	DB 0FEh, 0F8h, 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h ; 1ed5b
	DB 07h, 0B0h, 02h, 0CEh, 0D4h, 0FAh, 14h, 0C5h ; 1ed63
	DB 0C1h, 97h, 0B1h, 03h, 0F2h, 1Eh ; 1ed6b
	ASCII "5" ; 1ed71
	DB 0F8h, 0CFh, 0B9h, 0F2h, 10h, 3Ch, 0CEh, 0C4h ; 1ed72
	DB 00h, 0F2h, 0E0h ; 1ed7a
	ASCII "5" ; 1ed7d
	DB 0CEh, 0D0h, 3Dh, 16h, 96h, 02h, 0CFh, 0BDh ; 1ed7e
	DB 0F8h, 0C5h, 0B9h, 1Bh, 0B1h, 10h, 0CEh ; 1ed86
	ASCII "6" ; 1ed8d
	DB 0E7h, 07h, 91h, 92h, 0F5h, 0F9h ; 1ed8e
	ASCII "8" ; 1ed94
	DB 0F8h, 0B0h, 0FFh, 20h, 0F8h, 0BFh, 0C0h, 0DEh ; 1ed95
	DB 0C3h, 0D4h, 0BBh, 0DDh, 20h, 0B1h, 0B2h, 0C3h ; 1ed9d
	DB 0D1h, 0BAh, 0B3h, 0B6h, 0DDh, 0CFh, 0B9h ; 1eda5
	ASCII "F" ; 1edac
	DB 96h, 80h, 0E7h, 05h, 0B0h, 00h, 0F1h, 03h ; 1edad
	DB 0B0h, 01h, 0CEh, 0D4h, 89h, 1Dh, 0A2h, 0A1h ; 1edb5
	DB 0CFh, 0E6h, 0C6h, 8Bh, 1Dh ; 1edbd
	ASCII "c" ; 1edc2
	DB 92h ; 1edc3
	ASCII "b" ; 1edc4
	DB 0A9h, 0C6h, 8Dh, 1Dh ; 1edc5
	ASCII "c" ; 1edc9
	DB 92h ; 1edca
	ASCII "b" ; 1edcb
	DB 0AAh, 0C5h, 8Fh, 1Dh, 0B5h, 08h, 91h, 0B0h ; 1edcc
	DB 00h ; 1edd4
	ASCII "h" ; 1edd5
	DB 91h ; 1edd6
	ASCII "h" ; 1edd7
	DB 91h ; 1edd8
	ASCII "h" ; 1edd9
	DB 0B1h, 08h ; 1edda
	ASCII "F" ; 1eddc
	DB 0CEh, 80h, 60h, 0E4h, 05h, 0B0h, 00h, 0F1h ; 1eddd
	DB 03h, 0B0h, 01h, 0CFh, 0B1h, 0F0h ; 1ede5
	ASCII "Y" ; 1edeb
	DB 0CFh, 0B5h, 0C5h, 90h, 1Dh, 86h, 0E7h, 04h ; 1edec
	DB 0B0h, 0FFh ; 1edf4
	ASCII "h" ; 1edf6
	DB 0F5h, 0E4h, 92h, 0C5h, 8Eh, 1Dh, 8Eh, 0E7h ; 1edf7
	DB 0DBh, 99h ; 1edff
	ASCII "E " ; 1ee01
	DB 0E6h, 04h, 8Eh, 0F1h, 0D3h, 0CEh, 0D0h, 90h ; 1ee03
	DB 1Dh, 0F0h, 7Fh, 0C5h, 8Ah, 1Dh ; 1ee0b
	ASCII "M" ; 1ee11
	DB 0CEh, 81h, 29h ; 1ee12
	ASCII "h" ; 1ee15
	DB 0C5h, 8Fh, 1Dh, 8Eh, 0E6h, 0Bh ; 1ee16
	ASCII "M" ; 1ee1c
	DB 0C5h, 8Ah, 1Dh ; 1ee1d
	ASCII "E" ; 1ee20
	DB 0CEh, 80h, 0F5h, 0FDh ; 1ee21
	ASCII "h" ; 1ee25
	DB 0C5h, 8Bh, 1Dh ; 1ee26
	ASCII "E" ; 1ee29
	DB 91h ; 1ee2a
	ASCII "UX" ; 1ee2b
	DB 0CEh, 0D0h, 8Ah, 1Dh ; 1ee2d
	ASCII "h" ; 1ee31
	DB 0C5h, 92h, 1Dh, 86h, 0E7h, 03h, 99h, 86h ; 1ee32
	DB 0CFh, 0BDh, 0C5h, 91h, 1Dh ; 1ee3a
	ASCII "E" ; 1ee3f
	DB 91h ; 1ee40
	ASCII "UX" ; 1ee41
	DB 0F8h, 0C5h, 89h, 1Dh ; 1ee43
	ASCII "M1" ; 1ee47
	DB 0E7h, 02h, 0F8h ; 1ee49
	ASCII "A:" ; 1ee4c
	DB 01h ; 1ee4e
	ASCII "h" ; 1ee4f
	DB 0CEh, 0D0h, 90h, 1Dh, 0F0h ; 1ee50
	ASCII "7H" ; 1ee55
	DB 0B0h, 00h, 0CEh, 0D4h, 90h, 1Dh, 0C5h, 8Ah ; 1ee57
	DB 1Dh ; 1ee5f
	ASCII "E" ; 1ee60
	DB 0CEh, 80h, 29h ; 1ee61
	ASCII "h" ; 1ee64
	DB 0C5h, 8Fh, 1Dh, 8Eh, 0E7h, 21h, 0B0h, 08h ; 1ee65
	ASCII "h" ; 1ee6d
	DB 0C5h, 8Bh, 1Dh ; 1ee6e
	ASCII "E" ; 1ee71
	DB 91h ; 1ee72
	ASCII "UX" ; 1ee73
	DB 0CEh, 0D0h, 8Ah, 1Dh ; 1ee75
	ASCII "h" ; 1ee79
	DB 91h ; 1ee7a
	ASCII "CJ" ; 1ee7b
	DB 0C5h, 8Bh, 1Dh ; 1ee7d
	ASCII "h" ; 1ee80
	DB 91h ; 1ee81
	ASCII "i" ; 1ee82
	DB 0C5h, 92h, 1Dh, 86h, 0E7h, 03h, 99h, 86h ; 1ee83
	DB 0F8h, 0CFh, 0B3h, 0A3h, 0B1h, 05h, 5Fh, 0CEh ; 1ee8b
	DB 0BEh, 00h, 0E6h, 07h ; 1ee93
	ASCII "7" ; 1ee97
	DB 0E6h, 08h, 93h, 0F5h, 0F5h, 0B0h, 00h, 0F1h ; 1ee98
	DB 03h, 0B0h, 01h, 0ABh, 0CFh, 0B7h, 0F8h, 0B4h ; 1eea0
	DB 20h, 0CEh, 0C5h, 00h, 0DDh, 60h ; 1eea8
	ASCII "2" ; 1eeae
	DB 0DDh ; 1eeaf
	ASCIZ "a" ; 1eeb0
	DB 0D8h, 26h, 7Fh, 0B1h, 0C8h, 0FFh, 0FFh, 0FFh ; 1eeb2
	DB 89h, 0E7h, 0FBh, 0B0h, 00h, 0CEh, 0D4h, 0CAh ; 1eeba
	DB 1Bh, 0CEh, 0D4h, 88h, 1Dh, 0F8h, 40h, 88h ; 1eec2
	DB 88h, 0FFh, 0FFh, 0FFh, 88h, 0E7h, 0FBh, 0FFh ; 1eeca
	DB 40h, 0F8h, 0CEh, 0C5h, 00h, 0B0h, 01h, 0CEh ; 1eed2
	DB 0D4h, 0CAh, 1Bh, 0B4h, 20h, 0CEh, 0C6h, 00h ; 1eeda
	DB 0CEh, 0C7h, 00h, 0C6h, 0CBh, 1Bh, 0C5h, 0C8h ; 1eee2
	DB 01h, 0B0h, 00h, 60h, 92h, 99h, 0E7h, 0FCh ; 1eeea
	DB 0C7h, 00h, 00h, 0F2h, 0E7h, 01h ; 1eef2
	ASCII "2" ; 1eef8
	DB 0FFh, 0EEh, 0D9h, 01h, 0F2h, 0Dh, 02h ; 1eef9
	ASCII "2" ; 1ef00
	DB 01h, 0EEh, 0A4h, 01h ; 1ef01
	ASCII "2" ; 1ef05
	DB 02h, 0EEh, 0A8h, 01h ; 1ef06
	ASCII "2" ; 1ef0a
	DB 10h, 0EEh, 0BEh, 01h ; 1ef0b
	ASCII "2" ; 1ef0f
	DB 0FFh, 0EEh, 0C2h, 01h, 0CEh, 0C6h, 00h, 0C6h ; 1ef10
	DB 0CBh, 1Bh, 0C7h, 0C8h, 00h, 0F2h ; 1ef18
	ASCII "F" ; 1ef1e
	DB 02h, 0BFh, 5Bh, 1Dh, 0D7h, 0C8h, 00h, 0EEh ; 1ef1f
	DB 28h, 00h, 0C7h, 0Ah, 1Ah, 0F2h, 0B0h, 01h ; 1ef27
	ASCII "2" ; 1ef2f
	DB 10h, 0EEh, 2Eh, 00h ; 1ef30
	ASCII "2" ; 1ef34
	DB 0FFh, 0EEh, 9Dh, 01h, 0F2h, 0D1h, 01h ; 1ef35
	ASCII "2" ; 1ef3c
	DB 01h, 0EEh ; 1ef3d
	ASCII "h" ; 1ef3f
	DB 01h ; 1ef40
	ASCII "2" ; 1ef41
	DB 02h, 0EEh ; 1ef42
	ASCII "l" ; 1ef44
	DB 01h ; 1ef45
	ASCII "2" ; 1ef46
	DB 10h, 0EEh, 17h, 00h ; 1ef47
	ASCII "2" ; 1ef4b
	DB 0FFh, 0EEh, 86h, 01h, 0CEh, 0C6h, 00h, 0C6h ; 1ef4c
	DB 93h, 1Ch, 0C7h, 0C8h, 00h, 0F2h, 0Ah, 02h ; 1ef54
	DB 0BFh, 5Dh, 1Dh, 0F1h, 07h, 0B0h, 81h, 0CEh ; 1ef5c
	DB 0D4h, 88h, 1Dh, 0BBh, 5Bh, 1Dh, 0CEh, 0C6h ; 1ef64
	DB 00h, 0C6h, 0CBh, 1Bh, 0F2h ; 1ef6c
	ASCII "O" ; 1ef71
	DB 02h, 0CEh, 0C6h, 00h, 0C6h, 0CBh, 1Bh, 0BBh ; 1ef72
	DB 5Bh, 1Dh, 0C5h, 5Fh, 1Dh, 0F2h, 0A3h, 02h ; 1ef7a
	DB 0B2h, 1Dh, 0CEh, 0C6h, 00h, 0C6h, 5Fh, 1Dh ; 1ef82
	DB 0CEh, 0C7h, 00h, 0C7h, 7Dh, 1Dh, 0F2h, 0F4h ; 1ef8a
	DB 02h ; 1ef92
	ASCII "2" ; 1ef93
	DB 01h, 0EEh, 2Ch, 01h, 0C6h, 0CBh, 1Bh, 0C7h ; 1ef94
	DB 7Dh, 1Dh, 0B9h, 5Bh, 1Dh, 0F2h, 07h, 0FEh ; 1ef9c
	DB 0BDh, 5Bh, 1Dh, 0CEh, 0C6h, 00h, 0C6h, 0CBh ; 1efa4
	DB 1Bh, 0BBh, 5Bh, 1Dh, 0F2h, 11h, 03h, 0BDh ; 1efac
	DB 84h, 1Dh, 0C6h, 0CBh, 1Bh, 0CEh, 0D1h, 5Bh ; 1efb4
	DB 1Dh, 0F2h ; 1efbc
	ASCII "l" ; 1efbe
	DB 03h, 0B8h, 84h, 1Dh, 0CFh, 20h, 0BDh, 84h ; 1efbf
	DB 1Dh, 0CEh, 0D0h, 88h, 1Dh ; 1efc7
	ASCII "2" ; 1efcc
	DB 80h, 0EDh, 9Ah, 00h, 0BBh, 5Dh, 1Dh, 0CEh ; 1efcd
	DB 0C6h, 00h, 0C6h, 93h, 1Ch, 0F2h, 0E5h, 01h ; 1efd5
	DB 0C6h, 5Fh, 1Dh, 0B0h, 00h, 0B2h, 00h, 0CEh ; 1efdd
	ASCII "F" ; 1efe5
	DB 82h, 0CEh, 0BDh, 1Eh, 0E7h, 0F9h, 0C6h, 93h ; 1efe6
	DB 1Ch, 0BBh, 5Dh, 1Dh, 0C5h, 5Fh, 1Dh, 0F2h ; 1efee
	DB 2Dh, 02h, 0C6h, 5Fh, 1Dh, 0B2h, 00h, 0B0h ; 1eff6
	DB 00h, 0CEh ; 1effe
	ASCII "J" ; 1f000
	DB 01h, 82h, 0CEh, 0BDh, 1Eh, 0E7h, 0F8h ; 1f001
	ASCII "2" ; 1f008
	DB 04h, 0E5h, 0Ah, 0B0h, 81h, 0CEh, 0D4h, 88h ; 1f009
	DB 1Dh, 0F3h ; 1f011
	ASCIZ "V" ; 1f013
	DB 0C6h, 7Dh, 1Dh, 0B0h, 00h, 0B2h, 00h, 0CEh ; 1f015
	ASCII "F" ; 1f01d
	DB 82h, 0CEh, 0BDh, 05h, 0E7h, 0F9h, 0B2h, 1Dh ; 1f01e
	DB 0CEh, 0C6h, 00h, 0C6h, 5Fh, 1Dh, 0CEh, 0C7h ; 1f026
	DB 00h, 0C7h, 7Dh, 1Dh, 0F2h ; 1f02e
	ASCII "R" ; 1f033
	DB 02h ; 1f034
	ASCII "2" ; 1f035
	DB 01h, 0EEh, 8Ah, 00h, 0C6h, 93h, 1Ch, 0C7h ; 1f036
	DB 7Dh, 1Dh, 0B9h, 5Dh, 1Dh, 0F2h ; 1f03e
	ASCII "e" ; 1f044
	DB 0FDh, 0BDh, 5Dh, 1Dh, 0CEh, 0C6h, 00h, 0C6h ; 1f045
	DB 93h, 1Ch, 0BBh, 5Dh, 1Dh, 0F2h ; 1f04d
	ASCII "o" ; 1f053
	DB 02h, 0BDh, 86h, 1Dh, 0C6h, 93h, 1Ch, 0CEh ; 1f054
	DB 0D1h, 5Dh, 1Dh, 0F2h, 0CAh, 02h, 0B8h, 86h ; 1f05c
	DB 1Dh, 0CFh, 20h, 0BDh, 86h, 1Dh, 0CEh, 0C6h ; 1f064
	DB 00h, 0C6h, 0CBh, 1Bh, 0BBh, 5Bh, 1Dh, 0C5h ; 1f06c
	DB 0FFh, 0FFh, 0F2h ; 1f074
	ASCII "i" ; 1f077
	DB 02h, 0CEh, 0D0h, 88h, 1Dh ; 1f078
	ASCII "2" ; 1f07d
	DB 80h, 0E5h, 1Ch, 0B8h, 84h, 1Dh, 0BAh, 86h ; 1f07e
	DB 1Dh, 0CFh, 1Ah, 0E6h, 12h, 0CEh, 0C6h, 00h ; 1f086
	DB 0C6h, 93h, 1Ch, 0BBh, 5Dh, 1Dh, 0F2h ; 1f08e
	ASCII "K" ; 1f095
	DB 02h, 0B8h, 86h, 1Dh, 0CFh, 20h, 0B8h, 84h ; 1f096
	DB 1Dh, 0CFh, 20h, 0B0h, 00h, 0CEh, 0D4h, 0CAh ; 1f09e
	DB 1Bh, 0F8h, 0B0h, 00h, 0CEh, 0D4h, 0CAh, 1Bh ; 1f0a6
	DB 0B0h, 01h, 0F8h, 0B0h, 00h, 0CEh, 0D4h, 0CAh ; 1f0ae
	DB 1Bh, 0B0h, 02h, 0F8h, 0B0h, 00h, 0CEh, 0D4h ; 1f0b6
	DB 0CAh, 1Bh, 0B0h, 03h, 0F8h, 0B0h, 00h, 0CEh ; 1f0be
	DB 0D4h, 0CAh, 1Bh, 0B0h, 10h, 0F8h, 0B0h, 00h ; 1f0c6
	DB 0CEh, 0D4h, 0CAh, 1Bh, 0B0h, 20h, 0F8h, 0B0h ; 1f0ce
	DB 00h, 0CEh, 0D4h, 0CAh, 1Bh, 0B0h, 0FFh, 0F8h ; 1f0d6
	DB 0DDh, 2Ah, 80h, 0B0h, 0FFh, 0C5h, 0CAh, 1Bh ; 1f0de
	DB 0D7h, 00h, 00h, 0E6h, 10h, 0CEh ; 1f0e6
	ASCII "4" ; 1f0ec
	DB 0E6h, 1Bh, 9Bh, 0E6h, 15h, 0DCh, 2Ah, 80h ; 1f0ed
	DB 0E6h, 0F5h, 0B0h, 00h, 0F8h, 0CEh ; 1f0f5
	ASCII "4" ; 1f0fb
	DB 0E6h, 0Ch, 0DCh, 2Ah, 80h, 0E6h, 0F8h, 0B0h ; 1f0fc
	DB 00h, 0F8h, 0B0h, 10h, 0F8h, 0B0h, 0FFh, 0F8h ; 1f104
	DB 0B1h, 00h, 0DDh, 2Ah, 80h, 0B0h, 03h, 0F2h ; 1f10c
	DB 0B3h, 0FDh, 0FFh, 81h, 0CEh, 0BCh, 0FAh, 0EDh ; 1f114
	DB 3Ch, 00h, 0DCh, 2Ah, 80h, 0E7h, 0ECh, 0CEh ; 1f11c
	DB 0BCh, 03h, 0EDh, 0Eh, 00h, 0B0h, 06h, 0F2h ; 1f124
	DB 9Bh, 0FDh, 0DCh, 2Ah, 80h, 0EEh, 29h, 00h ; 1f12c
	DB 0F1h, 0D9h, 0B0h, 06h, 0F2h, 8Eh, 0FDh, 0DCh ; 1f134
	DB 2Ah, 80h, 0E7h, 0CFh, 0B1h, 00h, 0B0h, 0FFh ; 1f13c
	DB 0C5h, 0CAh, 1Bh, 0C7h, 9Ah, 02h, 0CEh ; 1f144
	ASCII "4" ; 1f14b
	DB 0E6h, 15h, 9Bh, 0E6h, 0Fh, 0DCh, 2Ah, 80h ; 1f14c
	DB 0E6h, 0F5h, 0B0h, 00h, 0F8h, 0B0h, 01h, 0F8h ; 1f154
	DB 0B0h, 02h, 0F8h, 0B0h, 10h, 0F8h, 0B0h, 0FFh ; 1f15c
	DB 0F8h, 0A3h, 0B0h, 00h, 0B1h, 08h, 0B3h, 05h ; 1f164
	DB 0DCh, 2Ah, 80h, 0E7h, 05h, 0CEh, 80h, 0F1h ; 1f16c
	DB 05h, 0CEh, 80h, 2Ah, 01h, 89h, 0E6h, 16h ; 1f174
	DB 0FFh, 0FFh, 0DDh, 2Ah, 80h, 0FFh, 0FFh, 0FFh ; 1f17c
	DB 0CFh, 0B0h, 0B0h, 06h, 0F2h, 3Eh, 0FDh, 0CFh ; 1f184
	DB 0B4h, 0FFh, 40h, 0F1h, 0DCh, 0FFh, 0FFh, 0DDh ; 1f18c
	DB 2Ah, 80h, 60h ; 1f194
	ASCIZ "2" ; 1f197
	DB 0E7h, 06h, 8Bh, 0E6h, 1Ch, 0F1h, 03h, 0B3h ; 1f199
	DB 05h, 92h, 0B1h, 08h, 0B0h, 00h, 9Bh, 0E6h ; 1f1a1
	DB 10h, 0CFh, 0B0h, 0B0h, 05h, 0F2h, 18h, 0FDh ; 1f1a9
	DB 0CFh, 0B4h, 0FFh, 0FFh, 0FFh, 40h, 0F1h, 0B4h ; 1f1b1
	DB 0A8h, 0CFh, 0Bh, 0CFh, 0ECh, 0B0h, 00h, 0F8h ; 1f1b9
	DB 0B2h, 00h, 0B1h, 80h ; 1f1c1
	ASCII "F" ; 1f1c5
	DB 0CEh, 80h, 0E4h, 0Fh, 0CEh, 0BDh, 00h, 0E6h ; 1f1c6
	ASCII "K" ; 1f1ce
	DB 0CEh, 0BDh, 02h, 0E4h, 08h, 0B2h, 00h, 0F1h ; 1f1cf
	ASCII "B" ; 1f1d7
	DB 82h, 0F1h, 3Fh, 0CFh, 0B0h, 0CFh, 0B1h, 0A2h ; 1f1d8
	DB 0CEh, 0BCh, 80h, 0E7h, 08h, 9Ah ; 1f1e0
	ASCII "F", 22h, "" ; 1f1e6
	DB 0FCh, 60h, 0F1h, 27h, 0CEh, 0BCh, 40h, 0E7h ; 1f1e8
	DB 0Dh, 9Ah ; 1f1f0
	ASCII "F", 22h, "" ; 1f1f2
	DB 0FEh, 60h, 92h ; 1f1f4
	ASCII "F", 22h, "`" ; 1f1f7
	DB 0F1h, 16h, 0CFh, 0B1h, 0CEh, 81h ; 1f1fb
	ASCII "F9`" ; 1f201
	DB 0CFh, 0B5h, 0CEh, 0BDh, 02h, 0E7h, 08h, 0CEh ; 1f204
	DB 81h, 0CEh, 81h ; 1f20c
	ASCII "F9`" ; 1f20f
	DB 0B2h, 00h, 0AAh, 0CFh, 0B5h, 0CFh, 0B4h, 0CEh ; 1f212
	DB 8Dh, 0E5h, 0AAh, 92h, 0B1h, 80h, 9Bh, 0E7h ; 1f21a
	DB 0A3h, 0F8h, 0BFh, 82h, 1Dh, 0CFh, 0EDh, 0B3h ; 1f222
	DB 00h, 0B1h, 80h, 0B2h, 00h ; 1f22a
	ASCII "F" ; 1f22f
	DB 0CEh, 80h, 0E4h, 1Fh, 0CEh, 0BEh, 00h, 0E7h ; 1f230
	DB 08h, 82h, 0E7h ; 1f238
	ASCII "5" ; 1f23b
	DB 0B2h, 0FFh, 0F1h ; 1f23c
	ASCII "1" ; 1f23f
	DB 0CEh, 0BDh, 1Dh, 0E4h, 03h, 0B2h, 00h, 0CEh ; 1f240
	DB 5Bh, 83h, 0CEh, 5Fh, 0B3h, 00h, 0B2h, 01h ; 1f248
	DB 0F1h, 1Fh, 0CEh, 0BEh, 01h, 0E6h, 13h, 0CEh ; 1f250
	DB 0BDh, 1Dh, 0E4h, 03h, 0B2h, 00h, 0CEh, 5Bh ; 1f258
	DB 83h, 0CEh, 5Fh, 0B3h, 01h, 0B2h, 01h, 0F1h ; 1f260
	DB 08h, 82h, 0E7h, 05h, 0B2h, 0FFh, 0F1h, 01h ; 1f268
	DB 0CEh, 8Dh, 0E5h, 0BDh, 0B1h, 80h, 92h, 0A3h ; 1f270
	DB 0BBh, 82h, 1Dh, 9Bh, 0E6h, 07h, 0BFh, 82h ; 1f278
	DB 1Dh, 0ABh, 0F1h, 0ACh, 0ABh, 0F8h, 8Ah, 0B3h ; 1f280
	DB 02h, 0B1h, 00h, 0CEh ; 1f288
	ASCIZ "B2" ; 1f28c
	DB 0E7h, 07h, 8Ah, 0EEh, 1Ch, 00h, 0F1h, 0F5h ; 1f28f
	ASCII "r" ; 1f297
	DB 93h, 81h, 0CEh, 0BCh, 05h, 0EEh, 14h, 00h ; 1f298
	DB 8Ah, 0EEh, 0Dh, 00h, 0CEh ; 1f2a0
	ASCIZ "B2" ; 1f2a5
	DB 0E7h, 0EEh, 8Bh, 0E7h, 0EBh, 0B0h, 00h, 0F8h ; 1f2a8
	DB 0B0h, 01h, 0F8h, 0B0h, 01h, 0F8h, 0B1h, 00h ; 1f2b0
	DB 0C5h, 00h, 00h ; 1f2b8
	ASCII "F" ; 1f2bb
	DB 0CFh, 20h, 92h, 9Bh, 0E7h, 0FAh, 0F8h, 0C5h ; 1f2bc
	DB 00h, 00h, 0D7h, 02h, 00h, 0E4h, 16h, 0CFh ; 1f2c4
	DB 0E3h, 0CEh, 8Ch, 0CEh, 8Dh, 0E5h, 03h, 2Ah ; 1f2cc
	DB 80h, 0CFh, 0ECh, 0CFh, 0D0h, 0CFh, 20h, 92h ; 1f2d4
	DB 92h, 9Bh, 0E7h, 0F8h, 0F8h, 0BFh, 82h, 1Dh ; 1f2dc
	DB 0CFh, 0EDh, 0B3h, 08h, 0CFh, 0E3h, 0CEh, 80h ; 1f2e4
	DB 0E4h, 07h, 0CEh, 81h, 0E4h, 0Fh, 0F1h, 12h ; 1f2ec
	DB 0CEh, 81h, 0E4h, 06h, 0CEh, 0B4h, 01h, 0F1h ; 1f2f4
	DB 09h, 0CEh, 0B4h, 01h, 0CEh, 0B8h, 10h, 3Ah ; 1f2fc
	DB 21h, 0CFh, 0ECh ; 1f304
	ASCII "F" ; 1f307
	DB 0CEh, 80h, 0E5h, 08h, 60h, 0CFh, 0E3h, 3Ah ; 1f308
	DB 01h, 0CFh, 0ECh, 60h, 8Bh, 0E7h, 0D2h, 0B3h ; 1f310
	DB 08h, 92h, 0A3h, 0BBh, 82h, 1Dh, 9Bh, 0E6h ; 1f318
	DB 07h, 0BFh, 82h, 1Dh, 0ABh, 0F1h, 0C2h, 0ABh ; 1f320
	DB 0CFh, 0E7h, 0F8h, 0C5h, 01h, 00h ; 1f328
	ASCIZ "F2" ; 1f32e
	DB 0E6h, 08h, 0CFh, 0EDh, 0CFh, 23h, 88h, 0E7h ; 1f331
	DB 0FCh, 92h, 89h, 0E7h, 0F1h, 0F8h, 0FFh, 0FFh ; 1f339
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f341
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f349
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f351
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f359
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f361
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f369
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f371
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f379
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f381
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f389
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f391
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f399
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3a1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3a9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3b1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3b9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3c1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3c9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3d1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3d9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3e1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3e9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3f1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f3f9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f401
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f409
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f411
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f419
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f421
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f429
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f431
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f439
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f441
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f449
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f451
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f459
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f461
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f469
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f471
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f479
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f481
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f489
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f491
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f499
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4a1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4a9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4b1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4b9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4c1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4c9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4d1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4d9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4e1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4e9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4f1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f4f9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f501
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f509
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f511
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f519
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f521
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f529
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f531
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f539
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f541
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f549
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f551
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f559
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f561
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f569
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f571
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f579
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f581
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f589
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f591
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f599
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5a1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5a9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5b1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5b9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5c1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5c9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5d1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5d9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5e1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5e9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5f1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f5f9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f601
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f609
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f611
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f619
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f621
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f629
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f631
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f639
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f641
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f649
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f651
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f659
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f661
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f669
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f671
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f679
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f681
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f689
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f691
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f699
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6a1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6a9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6b1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6b9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6c1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6c9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6d1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6d9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6e1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6e9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6f1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f6f9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f701
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f709
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f711
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f719
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f721
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f729
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f731
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f739
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f741
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f749
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f751
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f759
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f761
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f769
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f771
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f779
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f781
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f789
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f791
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f799
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7a1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7a9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7b1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7b9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7c1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7c9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7d1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7d9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7e1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7e9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7f1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f7f9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f801
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f809
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f811
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f819
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f821
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f829
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f831
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f839
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f841
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f849
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f851
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f859
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f861
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f869
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f871
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f879
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f881
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f889
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f891
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f899
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8a1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8a9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8b1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8b9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8c1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8c9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8d1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8d9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8e1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8e9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8f1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f8f9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f901
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f909
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f911
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f919
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f921
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f929
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f931
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f939
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f941
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f949
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f951
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f959
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f961
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f969
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f971
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f979
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f981
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f989
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f991
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f999
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9a1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9a9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9b1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9b9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9c1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9c9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9d1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9d9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9e1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9e9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9f1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1f9f9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa01
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa09
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa11
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa19
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa21
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa29
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa31
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa39
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa41
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa49
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa51
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa59
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa61
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa69
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa71
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa79
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa81
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa89
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa91
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fa99
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1faa1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1faa9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fab1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fab9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fac1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fac9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fad1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fad9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fae1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fae9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1faf1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1faf9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb01
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb09
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb11
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb19
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb21
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb29
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb31
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb39
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb41
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb49
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb51
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb59
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb61
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb69
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb71
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb79
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb81
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb89
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb91
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fb99
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fba1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fba9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbb1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbb9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbc1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbc9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbd1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbd9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbe1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbe9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbf1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fbf9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc01
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc09
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc11
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc19
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc21
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc29
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc31
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc39
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc41
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc49
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc51
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc59
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc61
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc69
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc71
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc79
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc81
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc89
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc91
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fc99
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fca1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fca9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcb1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcb9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcc1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcc9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcd1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcd9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fce1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fce9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcf1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fcf9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd01
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd09
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd11
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd19
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd21
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd29
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd31
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd39
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd41
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd49
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd51
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd59
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd61
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd69
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd71
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd79
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd81
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd89
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd91
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fd99
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fda1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fda9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdb1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdb9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdc1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdc9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdd1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdd9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fde1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fde9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdf1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fdf9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe01
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe09
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe11
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe19
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe21
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe29
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe31
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe39
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe41
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe49
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe51
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe59
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe61
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe69
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe71
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe79
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe81
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe89
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe91
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fe99
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fea1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fea9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1feb1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1feb9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fec1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fec9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fed1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fed9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fee1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fee9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fef1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fef9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff01
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff09
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff11
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff19
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff21
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff29
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff31
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff39
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff41
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff49
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff51
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff59
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff61
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff69
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff71
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff79
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff81
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff89
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff91
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ff99
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffa1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffa9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffb1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffb9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffc1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffc9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffd1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffd9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffe1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1ffe9
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fff1
	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 1fff9

	INCLUDE "graphics/graphics1.asm"

	INCLUDE "rom2.asm"

	INCLUDE "dialogue.asm"

	INCLUDE "graphics/graphics2.asm"

	END
