include "src/global.inc"

DEFSECT ".ram", CODE AT 1000H
SECT ".ram"

screenbuf: DS 300h
sprite_oam: DS 60h
tilemap: DS 0C0h

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

	; SJIS name
	DB 0BFh, 0C0h, 0DEh, 0C3h, 0D4h, 0BBh, 0DDh, 00h

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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Wait for PRC counter
    PRC_DELAY equ 65
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
WaitNextFrame:

	LD HL, #REG_BASE + PRC_CNT

loc_0x002332:

	CP [HL], #PRC_DELAY
	JRS C, loc_0x002332 ; 2335

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

	LD EP, #00h
	LD XP, #00h

	LD HL, #163Ch
	LD IX, #163Bh
	LD [IX], [HL]

	; power button
	LD A,[BR:KEY_PAD]
	XOR A, #0FFh

	LD [HL], A
	XOR A, [IX]

	LD B, A

	AND A,[HL]
	LD [163Dh], A

	LD A, B

	AND A, [IX]
	LD [163Eh], A

	CP [HL], [IX]
	JRS NZ, loc_0x0023A1

	LD A, [1640h]
	DEC A

	LD [1640h], A
	JRS NZ, loc_0x00239A

	LD A, [1648h]
	LD [1640h], A

	LD A, [HL]
	LD [163Fh], A

	JRS loc_0x0023B1

loc_0x00239A:

	XOR A, A

	LD [163Fh], A

	JRS loc_0x0023B1

loc_0x0023A1:

	LD A, [1647h]
	LD [1640h], A

	LD A, [163Dh]
	LD [163Fh], A

loc_0x0023B1:

	LD HL, #166Bh
	BIT [HL], #04h
	JRS Z, loc_0x0023CB

	LD BA, [163Bh]
	LD [1641h], BA

	LD BA, [163Dh]
	LD [1643h], BA

	LD BA, [163Fh]
	LD [1645h], BA

	RET

loc_0x0023CB:

	LD BA, #0000h

	LD [1641h], BA
	LD [1643h], BA
	LD [1645h], BA

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   Args:
;     A: index
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x0023D8:

	PUSH EP

	LD B, #00h

	ADD BA, BA
	LD HL, BA

	ADD HL, #pool_0x0023e9
	LD EP, #00h

	LD BA, [HL]

	POP EP

	RET

; ---------------------- ; 23e8
pool_0x0023e9:
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
loc_0x00268D:
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
	DB 00h, 01h, 03h, 00h, 81h, 83h, 01h, 03h
; ---------------------- ; 2705
loc_0x00270D:

	PUSH ALE ; 270d

	CARL loc_0x00433F ; 270f

	LD [164Ah],BA ; 2712

	POP ALE ; 2715

	LD BA,[164Ah] ; 2717

	RET

; ---------------------- ; 271a
loc_0x00271B:

	PUSH ALE ; 271b

	CARL loc_0x00438D ; 271d

	LD [164Ah],BA ; 2720

	POP ALE ; 2723

	LD BA,[164Ah] ; 2725

	RET

; ---------------------- ; 2728
loc_0x002729:

	PUSH ALE ; 2729

	CARL loc_0x00445F ; 272b

	LD [164Ah],BA ; 272e

	POP ALE ; 2731

	LD BA,[164Ah] ; 2733

	RET

; ---------------------- ; 2736
loc_0x002737:

	PUSH ALE ; 2737

	CARL loc_0x0044DF ; 2739

	LD [164Ah],BA ; 273c

	POP ALE ; 273f

	LD BA,[164Ah] ; 2741

	RET

; ---------------------- ; 2743
loc_0x002745:

	PUSH ALE ; 2745

	CARL loc_0x0044F5 ; 2747

	LD [164Ah],BA ; 274a

	POP ALE ; 274d

	LD BA,[164Ah] ; 274f

	RET

; ---------------------- ; 2752
loc_0x002753:

	LD L,#11h ; 2753
	MLT ; 2755

	LD IX,HL ; 2757
	ADD IX,#1539h ; 2759

	PUSH IX ; 275c

	ADD IX,#0001h ; 275d
	LD XP,#00h ; 2760
	CARL loc_0x00270D ; 2763

	POP IX ; 2766

	LD XP,#00h ; 2767
	LD [IX+00h],A ; 276a

	RET

; ---------------------- ; 276d
loc_0x00276E:

	LD IX,#1539h ; 276e

	XOR A,A ; 2771

loc_0x002772:

	PUSH A ; 2772

	PUSH IX ; 2774

	ADD IX,#0001h ; 2775
	LD XP,#00h ; 2778
	CARL loc_0x00270D ; 277b

	POP IX ; 277e

	LD XP,#00h ; 277f
	LD [IX+00h],A ; 2782

	POP A ; 2785

	ADD IX,#0011h ; 2787
	INC A ; 278a

	CP A,#06h ; 278b
	JRS NZ,loc_0x002772 ; 278d

	RET

; ---------------------- ; 278f
loc_0x002790:

	LD HL,#153Ah ; 2790
	LD EP,#00h ; 2793

	LD A,#00h ; 2796

loc_0x002798:

	PUSH A ; 2798
	PUSH HL ; 279a

	LD IX,#21ACh ; 279b
	LD XP,#00h ; 279e

	LD B,#10h ; 27a1

loc_0x0027A3:

	CP [HL],[IX] ; 27a3
	JRS NZ,loc_0x0027AD ; 27a5

	INC HL ; 27a7
	INC IX ; 27a8

	DJR NZ,loc_0x0027A3 ; 27a9

	JRS loc_0x0027BC

loc_0x0027AD:

	POP HL ; 27ad
	POP A ; 27ae

	ADD HL,#0011h ; 27b0
	INC A ; 27b3

	CP A,#06h ; 27b4
	JRS NZ,loc_0x002798 ; 27b6

	LD A,#0FFh ; 27b8
	AND A,A ; 27ba

	RET

loc_0x0027BC:

	XOR A,A ; 27bc
	POP HL ; 27bd
	POP A ; 27be

	RET

; ---------------------- ; 27c0
loc_0x0027C1:

	PUSH IP ; 27c1
	PUSH IY ; 27c2

	LD IY,#1539h ; 27c3
	LD YP,#00h ; 27c6

	LD B,#00h ; 27c9

loc_0x0027CB:

	LD A,[IY+00h] ; 27cb

	CP A,#05h ; 27ce
	JRS Z,loc_0x0027E0 ; 27d0

	ADD IY,#0011h ; 27d2

	INC B ; 27d5

	CP B,#06h ; 27d6
	JRS NZ,loc_0x0027CB ; 27d9

	POP IY ; 27db
	POP IP ; 27dc

	LD A,#0FFh ; 27dd

	RET

loc_0x0027E0:
	POP IY ; 27e0
	POP IP ; 27e1

	LD A,B ; 27e2

	RET

; ---------------------- ; 27e3
loc_0x0027E4:

	LD L,#11h ; 27e4
	MLT ; 27e6

	LD IY,HL ; 27e8

	ADD IY,#153Ah ; 27ea
	LD YP,#00h ; 27ed

	LD B,#10h ; 27f0

loc_0x0027F2:

	LD [IY],[IX] ; 27f2

	INC IX ; 27f3
	INC IY ; 27f4

	DJR NZ,loc_0x0027F2 ; 27f5

	RET

; ---------------------- ; 27f7
loc_0x0027F8:

	LD L,#11h ; 27f8
	MLT ; 27fa

	LD IX,HL ; 27fc

	ADD IX,#153Ah ; 27fe
	LD XP,#00h ; 2801

	CARL loc_0x00271B ; 2804

	RET

; ---------------------- ; 2807
loc_0x002808:

	LD IX,#21ACh ; 2808
	LD XP,#00h ; 280b

	LD BA,[IX] ; 280e
	LD [159Fh],BA ; 2810

	ADD IX,#0002h ; 2813

	LD BA,[IX] ; 2816
	LD [15A1h],BA ; 2818

	LD BA,#0000h ; 281b
	LD [15A3h],BA ; 281e

	LD BA,#1AB5h ; 2821
	LD [15A5h],BA ; 2824

	LD A,#00h ; 2827
	LD [15A7h],A ; 2829

	LD BA,#005Ah ; 282d
	LD [15A8h],BA ; 2830

	LD A,[168Ch] ; 2833

	CP A,#0FFh ; 2837
	JRS Z,loc_0x002845 ; 2839

	LD IX,#159Fh ; 283b
	LD XP,#00h ; 283e
	CARL loc_0x002737 ; 2841

	RET

loc_0x002845:

	XOR A,A ; 2845

	RET

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
	INC HL ; 285

	DEC IY ; 2858
	JRS NZ,loc_0x002854 ; 2859

	LD [1B0Dh],IX ; 285b

	POP IX ; 285e
	POP IY ; 285f

	RET

; ---------------------- ; 2860
loc_0x002861:

	PUSH IY ; 2861
	PUSH IX ; 2862

	LD IY,#0058h ; 2863
	LD HL,#1AB5h ; 2866
	LD IX,#0000h ; 2869

	LD B,#00h ; 286c

loc_0x00286E:

	LD A,[HL] ; 286e
	ADD IX,BA ; 286f

	INC HL ; 2871

	DEC IY ; 2872
	JRS NZ,loc_0x00286E ; 2873

	LD HL,[1B0Dh] ; 2875
	CP HL,IX ; 2878

	POP IX ; 287a
	POP IY ; 287b

	RET

; ---------------------- ; 287c
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
loc_0x0028BF:

	PUSH BA ; 28bf

	CARL loc_0x002847 ; 28c0

	LD IX,#21ACh ; 28c3

	LD XP,#00h ; 28c6
	LD BA,[IX] ; 28c9
	LD [159Fh],BA ; 28cb

	ADD IX,#0002h ; 28ce
	LD BA,[IX] ; 28d1
	LD [15A1h],BA ; 28d3

	LD BA,#0000h ; 28d6
	LD [15A3h],BA ; 28d9

	LD BA,#1AB5h ; 28dc
	LD [15A5h],BA ; 28df

	LD A,#00h ; 28e2
	LD [15A7h],A ; 28e4

	POP BA ; 28e8
	LD [15A8h],BA ; 28e9

	LD A,[168Ch] ; 28ec
	CP A,#0FFh ; 28f0
	JRS Z,loc_0x00293D ; 28f2

	LD IX,#159Fh ; 28f4
	LD XP,#00h ; 28f7
	CARL loc_0x002745 ; 28fa

	LD IX,#21ACh ; 28fd

	LD XP,#00h ; 2900
	LD BA,[IX] ; 2903
	LD [159Fh],BA ; 2905

	ADD IX,#0002h ; 2908
	LD BA,[IX] ; 290b
	LD [15A1h],BA ; 290d

	LD BA,#1B0Dh ; 2910
	SUB BA,#1AB5h ; 2913
	LD [15A3h],BA ; 2916

	LD BA,#1B0Dh ; 2919
	LD [15A5h],BA ; 291c

	LD A,#00h ; 291f
	LD [15A7h],A ; 2921

	LD BA,#0008h ; 2925
	LD [15A8h],BA ; 2928

	LD A,[168Ch] ; 292b
	CP A,#0FFh ; 292f
	JRS Z,loc_0x00293D ; 2931

	LD IX,#159Fh ; 2933
	LD XP,#00h ; 2936

	CARL loc_0x002745 ; 2939

	RET

loc_0x00293D:

	XOR A,A ; 293d

	RET

; ---------------------- ; 293e
loc_0x00293F:

	PUSH A ; 293f

	LD L,#11h ; 2941
	MLT ; 2943

	LD IX,HL ; 2945
	ADD IX,#153Ah ; 2947

	LD XP,#00h ; 294a

	PUSH IX ; 294d

	CARL loc_0x002729 ; 294e

	POP IY ; 2951
	POP B ; 2952

	XOR A,A ; 2954

loc_0x002955:

	PUSH A ; 2955
	PUSH B ; 2957
	PUSH IY ; 2959

	CP A,B ; 295a
	JRS Z,loc_0x00297C ; 295b

	LD L,#11h ; 295d
	MLT ; 295f

	ADD HL,#153Ah ; 2961
	LD XP,#00h ; 2964
	LD YP,#00h ; 2967
	LD EP,#00h ; 296a
	LD IX,HL ; 296d

	LD B,#10h ; 296f

loc_0x002971:

	CP [HL],[IY] ; 2971
	JRS NZ,loc_0x00297C ; 2973

	INC HL ; 2975
	INC IY ; 2976

	DJR NZ,loc_0x002971 ; 2977

	CARL loc_0x002729 ; 2979

loc_0x00297C:

	POP IY ; 297c
	POP B ; 297d
	POP A ; 297f

	INC A ; 2981

	CP A,#06h ; 2982
	JRS NZ,loc_0x002955 ; 2984
	
	RET

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
	LD A,[BR:KEY_PAD] ; 29bd

	; clear upper bits, leave only A button
	XOR A,#0FFh ; 29bf

	LD [1649h],A ; 29c1

	; was A pressed?
	LD A,[1649h] ; 29c5
	AND A,A ; 29c9
	JRS Z,timeout_a_not_pressed ; 29ca

	; A pressed
	LD BA,#0000h ; 29cc
	LD [1667h],BA ; 29cf
	JRS timeout_a_pressed

timeout_a_not_pressed:

	LD BA,[1667h] ; 29d4
	INC BA ; 29d7
	LD [1667h],BA ; 29d8

	; did we reach the number of timeout frames?
	CP BA, #sleep_timeout
	JRL Z, timeout_sleep

timeout_a_pressed:

	LD HL, #1649h ; 29e1
	BIT [HL], #80h ; 29e4
	JRS Z, loc_0x0029F2 ; 29e6

	LD HL ,#1669h ; 29e8
	INC [HL] ; 29eb
	CP [HL], #02h ; 29ec

	JRS Z, timeout_sleep ; 29ef

	RET

loc_0x0029F2:

	XOR A, A
	
	; simulate power press?
	LD [1669h], A
	LD HL, #166Ch
	AND [HL], #11110001b

	RET

timeout_sleep:

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
loc_0x002BF2:
	LD A,#01h ; 2bf2
	LD [161Dh],A ; 2bf4
	RET
; ---------------------- ; 2bf8
loc_0x002BF9:
	LD EP,#00h ; 2bf9
	XOR A,A ; 2bfc
	LD [164Eh],A ; 2bfd
	LD [164Fh],A ; 2c01
	LD BA,#0000h ; 2c05
	LD [1654h],BA ; 2c08
	LD [1656h],A ; 2c0b
	LD BA,#0000h ; 2c0f
	LD [1659h],BA ; 2c12
	LD [165Bh],BA ; 2c15
	SUB BA,#0010h ; 2c18
	LD [165Dh],BA ; 2c1b
	LD [165Fh],BA ; 2c1e
	RET
; ---------------------- ; 2c21
loc_0x002C22:
	PUSH IP ; 2c22
	PUSH IY ; 2c23
	LD EP,#00h ; 2c24
	LD [164Eh],A ; 2c27
	LD [164Fh],B ; 2c2b
	CP A,#19h ; 2c2f
	JRS NC,loc_0x002C3C ; 2c31
	CP B,#11h ; 2c33
	JRS NC,loc_0x002C3C ; 2c36
	LD A,#00h ; 2c38
	JRS loc_0x002C3E
; ---------------------- ; 2c3a
loc_0x002C3C:
	LD A,#01h ; 2c3c
loc_0x002C3E:
	LD [164Dh],A ; 2c3e
	LD [1654h],IX ; 2c42
	LD A,XP ; 2c45
	LD [1656h],A ; 2c47
	LD A,[164Eh] ; 2c4b
	LD B,#00h ; 2c4f
	SLA A ; 2c51
	RL B ; 2c53
	SLA A ; 2c55
	RL B ; 2c57
	SLA A ; 2c59
	RL B ; 2c5b
	SUB BA,#0060h ; 2c5d
	LD [1650h],BA ; 2c60
	LD A,[164Fh] ; 2c63
	LD B,#00h ; 2c67
	SLA A ; 2c69
	RL B ; 2c6b
	SLA A ; 2c6d
	RL B ; 2c6f
	SLA A ; 2c71
	RL B ; 2c73
	SUB BA,#0040h ; 2c75
	LD [1652h],BA ; 2c78
	POP IY ; 2c7b
	POP IP ; 2c7c
	RET
; ---------------------- ; 2c7d
loc_0x002C7E:
	PUSH IP ; 2c7e
	PUSH IY ; 2c7f
	LD EP,#00h ; 2c80
	PUSH B ; 2c83
	LD B,#00h ; 2c85
	SLA A ; 2c87
	RL B ; 2c89
	SLA A ; 2c8b
	RL B ; 2c8d
	SLA A ; 2c8f
	RL B ; 2c91
	SUB BA,#0060h ; 2c93
	LD [1650h],BA ; 2c96
	POP A ; 2c99
	LD B,#00h ; 2c9b
	SLA A ; 2c9d
	RL B ; 2c9f
	SLA A ; 2ca1
	RL B ; 2ca3
	SLA A ; 2ca5
	RL B ; 2ca7
	SUB BA,#0040h ; 2ca9
	LD [1652h],BA ; 2cac
	LD BA,#1018h ; 2caf
	LD [164Eh],A ; 2cb2
	LD [164Fh],B ; 2cb6
	LD [1654h],IX ; 2cba
	LD A,XP ; 2cbd
	LD [1656h],A ; 2cbf
	POP IY ; 2cc3
	POP IP ; 2cc4
	RET
; ---------------------- ; 2cc5
loc_0x002CC6:
	LD BA,[165Bh] ; 2cc6
	SRL B ; 2cc9
	RR A ; 2ccb
	SRL B ; 2ccd
	RR A ; 2ccf
	SRL B ; 2cd1
	RR A ; 2cd3
	LD L,[164Eh] ; 2cd5
	MLT ; 2cd9
	LD IX,HL ; 2cdb
	LD A,B ; 2cdd
	LD L,[164Eh] ; 2cde
	MLT ; 2ce2
	LD H,L ; 2ce4
	LD L,#00h ; 2ce5
	ADD HL,IX ; 2ce7
	LD BA,[1659h] ; 2ce9
	SRL B ; 2cec
	RR A ; 2cee
	SRL B ; 2cf0
	RR A ; 2cf2
	SRL B ; 2cf4
	RR A ; 2cf6
	ADD HL,BA ; 2cf8
	LD BA,[1654h] ; 2cfa
	ADD HL,BA ; 2cfd
	LD [1657h],HL ; 2cff
	LD A,[1659h] ; 2d02
	AND A,#07h ; 2d06
	LD [1633h],A ; 2d08
	LD A,[165Bh] ; 2d0c
	AND A,#07h ; 2d10
	LD [1632h],A ; 2d12
	RET
; ---------------------- ; 2d16
loc_0x002D17:
	LD EP,#00h ; 2d17
	LD BA,[1654h] ; 2d1a
	OR A,B ; 2d1d
	OR A,[1656h] ; 2d1e
	JRS Z,loc_0x002D6B ; 2d21
	LD IX,[1657h] ; 2d23
	LD A,[1656h] ; 2d26
	LD XP,A ; 2d2a
	LD IY,#1360h ; 2d2c
	LD YP,#00h ; 2d2f
	LD L,[164Eh] ; 2d32
	LD H,#00h ; 2d36
	SUB HL,#000Ch ; 2d38
	LD A,#09h ; 2d3b
loc_0x002D3D:
	LD [IY],[IX] ; 2d3d
	INC IX ; 2d3e
	INC IY ; 2d3f
	LD [IY],[IX] ; 2d40
	INC IX ; 2d41
	INC IY ; 2d42
	LD [IY],[IX] ; 2d43
	INC IX ; 2d44
	INC IY ; 2d45
	LD [IY],[IX] ; 2d46
	INC IX ; 2d47
	INC IY ; 2d48
	LD [IY],[IX] ; 2d49
	INC IX ; 2d4a
	INC IY ; 2d4b
	LD [IY],[IX] ; 2d4c
	INC IX ; 2d4d
	INC IY ; 2d4e
	LD [IY],[IX] ; 2d4f
	INC IX ; 2d50
	INC IY ; 2d51
	LD [IY],[IX] ; 2d52
	INC IX ; 2d53
	INC IY ; 2d54
	LD [IY],[IX] ; 2d55
	INC IX ; 2d56
	INC IY ; 2d57
	LD [IY],[IX] ; 2d58
	INC IX ; 2d59
	INC IY ; 2d5a
	LD [IY],[IX] ; 2d5b
	INC IX ; 2d5c
	INC IY ; 2d5d
	LD [IY],[IX] ; 2d5e
	INC IX ; 2d5f
	INC IY ; 2d60
	LD [IY],[IX] ; 2d61
	INC IY ; 2d62
	INC IY ; 2d63
	INC IY ; 2d64
	INC IY ; 2d65
	ADD IX,HL ; 2d66
	DEC A ; 2d68
	JRS NZ,loc_0x002D3D ; 2d69
loc_0x002D6B:
	RET
; ---------------------- ; 2d6b
MainLoop:
	CARL Main ; 2d6c
	JRS MainLoop
	RET
; ---------------------- ; 2D71
loc_0x002D72:

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

; ---------------------- ; 2e61
loc_0x002E62:
	LD NB,A ; 2e62
	JP HL
; ---------------------- ; 2e64
loc_0x002E65:
	LD EP,#00h ; 2e65
	LD A,[162Bh] ; 2e68
	LD [BR:PRC_MODE],A ; 2e6c
	LD BA,[1632h] ; 2e6e
	LD [REG_BASE + PRC_SCROLL_Y],BA ; 2e71
	LD HL,#1671h ; 2e74
	BIT [HL],#01h ; 2e77
	JRS NZ,loc_0x002E95 ; 2e79
	LD BA,[162Ch] ; 2e7b
	LD [REG_BASE + PRC_MAP_LO],BA ; 2e7e
	LD A,[162Eh] ; 2e81
	LD [BR:PRC_MAP_HI],A ; 2e85
	LD BA,[1634h] ; 2e87
	LD [REG_BASE + PRC_SPR_LO],BA ; 2e8a
	LD A,[1636h] ; 2e8d
	LD [BR:PRC_SPR_HI],A ; 2e91
	JRS loc_0x002EAD
; ---------------------- ; 2e93
loc_0x002E95:
	LD BA,[162Fh] ; 2e95
	LD [REG_BASE + PRC_MAP_LO],BA ; 2e98
	LD A,[1631h] ; 2e9b
	LD [BR:PRC_MAP_HI],A ; 2e9f
	LD BA,[1637h] ; 2ea1
	LD [REG_BASE + PRC_SPR_LO],BA ; 2ea4
	LD A,[1639h] ; 2ea7
	LD [BR:PRC_SPR_HI],A ; 2eab
loc_0x002EAD:
	LD A,[163Ah] ; 2ead
	LD [BR:40h],A ; 2eb1
	RET
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
	CARL loc_0x00235D

	LD NB, #07h
	CARL loc_0x038EDF

	LD NB, #02h 
	CARL loc_0x011BA5

	LD NB, #02h
	CARL loc_0x011C7B

	LD NB, #02h
	CARL loc_0x011CF5

	LD NB, #07h
	CARL loc_0x0383C6

	LD NB, #07h
	CARL loc_0x03842F

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
	CARL loc_0x038EDF

	LD NB, #02h
	CARL loc_0x011ECF

	LD NB, #02h
	CARL loc_0x011C7B

	LD NB, #02h
	CARL loc_0x011CF5

	LD NB, #07h
	CARL loc_0x0383C6

	LD NB, #07h
	CARL loc_0x03842F

	RET

; ---------------------- ; 3026
loc_0x003027:
	LD HL,#1672h ; 3027
	BIT [HL],#0FFh ; 302a
	JRL Z,loc_0x002F11 ; 302c
	LD [HL],#00h ; 302f
	LD NB,#07h ; 3031
	CARL loc_0x03852E ; 3034
	LD NB,#02h ; 3037
	CARL loc_0x011D05 ; 303a
	CARL loc_0x002E65 ; 303d
	AND SC,#3Fh ; 3040
	LD EP,#00h ; 3042
	LD HL,#1671h ; 3045
	INC [HL] ; 3048
	LD HL,#1676h ; 3049
	LD A,[HL] ; 304c
	LD [1677h],A ; 304d
	LD [HL],#00h ; 3051
	LD HL,#15B1h ; 3053
	LD [190Fh],HL ; 3056
	LD NB,#00h ; 3059
	CARL loc_0x00235D ; 305c
	LD NB,#07h ; 305f
	CARL loc_0x038EDF ; 3062
	LD NB,#02h ; 3065
	CARL loc_0x011ECF ; 3068
	LD NB,#02h ; 306b
	CARL loc_0x011909 ; 306e
	LD NB,#02h ; 3071
	CARL loc_0x011CF5 ; 3074
	LD NB,#07h ; 3077
	CARL loc_0x0383C6 ; 307a
	LD NB,#07h ; 307d
	CARL loc_0x03842F ; 3080
	LD HL,#1672h ; 3083
	BIT [HL],#0FFh ; 3086
	JRL Z,loc_0x002F11 ; 3088
	LD [HL],#00h ; 308b
	LD NB,#07h ; 308d
	CARL loc_0x03852E ; 3090
	LD NB,#02h ; 3093
	CARL loc_0x011D05 ; 3096
	CARL loc_0x002E65 ; 3099
	AND SC,#3Fh ; 309c
	LD EP,#00h ; 309e
	LD HL,#1671h ; 30a1
	INC [HL] ; 30a4
	LD HL,#1676h ; 30a5
	LD A,[HL] ; 30a8
	LD [1677h],A ; 30a9
	LD [HL],#00h ; 30ad
	LD HL,#15B1h ; 30af
	LD [190Fh],HL ; 30b2
	LD NB,#00h ; 30b5
	CARL loc_0x00235D ; 30b8
	LD NB,#07h ; 30bb
	CARL loc_0x038EDF ; 30be
	LD NB,#02h ; 30c1
	CARL loc_0x011ECF ; 30c4
	LD NB,#02h ; 30c7
	CARL loc_0x011875 ; 30ca
	LD NB,#02h ; 30cd
	CARL loc_0x011CF5 ; 30d0
	LD NB,#07h ; 30d3
	CARL loc_0x0383C6 ; 30d6
	LD NB,#07h ; 30d9
	CARL loc_0x03842F ; 30dc
	RET
; ---------------------- ; 30df
loc_0x0030E0:
	LD HL,#1672h ; 30e0
	BIT [HL],#0FFh ; 30e3
	JRL Z,loc_0x002F11 ; 30e5
	LD [HL],#00h ; 30e8
	LD NB,#00h ; 30ea
	CARL loc_0x002D17 ; 30ed
	LD NB,#07h ; 30f0
	CARL loc_0x03852E ; 30f3
	LD NB,#02h ; 30f6
	CARL loc_0x011D05 ; 30f9
	CARL loc_0x002E65 ; 30fc
	AND SC,#3Fh ; 30ff
	LD EP,#00h ; 3101
	LD HL,#1671h ; 3104
	INC [HL] ; 3107
	LD HL,#1676h ; 3108
	LD A,[HL] ; 310b
	LD [1677h],A ; 310c
	LD [HL],#00h ; 3110
	LD HL,#15B1h ; 3112
	LD [190Fh],HL ; 3115
	LD NB,#00h ; 3118
	CARL loc_0x00235D ; 311b
	LD NB,#02h ; 311e
	CARL loc_0x011BA5 ; 3121
	LD NB,#02h ; 3124
	CARL loc_0x011C7B ; 3127
	LD NB,#02h ; 312a
	CARL loc_0x011CF5 ; 312d
	LD NB,#00h ; 3130
	CARL loc_0x002CC6 ; 3133
	LD NB,#07h ; 3136
	CARL loc_0x0383C6 ; 3139
	LD NB,#07h ; 313c
	CARL loc_0x03842F ; 313f
	RET
; ---------------------- ; 3142
loc_0x003143:
	LD HL,#1672h ; 3143
	BIT [HL],#0FFh ; 3146
	JRL Z,loc_0x002F11 ; 3148
	LD [HL],#00h ; 314b
	LD NB,#07h ; 314d
	CARL loc_0x03852E ; 3150
	LD NB,#02h ; 3153
	CARL loc_0x011D05 ; 3156
	CARL loc_0x002E65 ; 3159
	AND SC,#3Fh ; 315c
	LD EP,#00h ; 315e
	LD HL,#1671h ; 3161
	INC [HL] ; 3164
	LD HL,#1676h ; 3165
	LD A,[HL] ; 3168
	LD [1677h],A ; 3169
	LD [HL],#00h ; 316d
	LD HL,[166Dh] ; 316f
	LD [190Fh],HL ; 3172
	LD NB,#00h ; 3175
	CARL loc_0x00235D ; 3178
	LD NB,#02h ; 317b
	CARL loc_0x011BA5 ; 317e
	LD NB,#02h ; 3181
	CARL loc_0x01168D ; 3184
	LD NB,#02h ; 3187
	CARL loc_0x0116D0 ; 318a
	LD NB,#02h ; 318d
	CARL loc_0x01172F ; 3190
	LD NB,#02h ; 3193
	CARL loc_0x011CF5 ; 3196
	LD NB,#07h ; 3199
	CARL loc_0x0383C6 ; 319c
	LD NB,#07h ; 319f
	CARL loc_0x03842F ; 31a2
	RET
; ---------------------- ; 31a5
loc_0x0031A6:
	LD HL,#1672h ; 31a6
	BIT [HL],#0FFh ; 31a9
	JRL Z,loc_0x002F11 ; 31ab
	LD [HL],#00h ; 31ae
	LD NB,#00h ; 31b0
	CARL loc_0x002D17 ; 31b3
	LD NB,#07h ; 31b6
	CARL loc_0x03852E ; 31b9
	LD NB,#02h ; 31bc
	CARL loc_0x011D05 ; 31bf
	CARL loc_0x002E65 ; 31c2
	AND SC,#3Fh ; 31c5
	LD EP,#00h ; 31c7
	LD HL,#1671h ; 31ca
	INC [HL] ; 31cd
	LD HL,#1676h ; 31ce
	LD A,[HL] ; 31d1
	LD [1677h],A ; 31d2
	LD [HL],#00h ; 31d6
	LD HL,[166Dh] ; 31d8
	LD [190Fh],HL ; 31db
	LD NB,#00h ; 31de
	CARL loc_0x00235D ; 31e1
	LD NB,#02h ; 31e4
	CARL loc_0x011BA5 ; 31e7
	LD NB,#02h ; 31ea
	CARL loc_0x01168D ; 31ed
	LD NB,#02h ; 31f0
	CARL loc_0x0116D0 ; 31f3
	LD NB,#02h ; 31f6
	CARL loc_0x01172F ; 31f9
	LD NB,#02h ; 31fc
	CARL loc_0x011CF5 ; 31ff
	LD NB,#00h ; 3202
	CARL loc_0x002CC6 ; 3205
	LD NB,#07h ; 3208
	CARL loc_0x0383C6 ; 320b
	LD NB,#07h ; 320e
	CARL loc_0x03842F ; 3211
	RET
; ---------------------- ; 3214
loc_0x003215:
	LD HL,#1672h ; 3215
	BIT [HL],#0FFh ; 3218
	JRL Z,loc_0x002F11 ; 321a
	LD [HL],#00h ; 321d
	LD NB,#02h ; 321f
	CARL loc_0x011D05 ; 3222
	CARL loc_0x002E65 ; 3225
	AND SC,#3Fh ; 3228
	LD EP,#00h ; 322a
	LD HL,#1671h ; 322d
	INC [HL] ; 3230
	LD HL,#1676h ; 3231
	LD A,[HL] ; 3234
	LD [1677h],A ; 3235
	LD [HL],#00h ; 3239
	LD HL,[166Dh] ; 323b
	LD [190Fh],HL ; 323e
	LD NB,#02h ; 3241
	CARL loc_0x011BA5 ; 3244
	LD NB,#02h ; 3247
	CARL loc_0x01168D ; 324a
	LD NB,#02h ; 324d
	CARL loc_0x0116D0 ; 3250
	LD NB,#02h ; 3253
	CARL loc_0x01172F ; 3256
	LD NB,#02h ; 3259
	CARL loc_0x011CF5 ; 325c
	RET
; ---------------------- ; 325f
loc_0x003260:
	LD HL,#1672h ; 3260
	BIT [HL],#0FFh ; 3263
	JRL Z,loc_0x002F11 ; 3265
	LD [HL],#00h ; 3268
	LD NB,#00h ; 326a
	CARL loc_0x002D17 ; 326d
	LD NB,#02h ; 3270
	CARL loc_0x011D05 ; 3273
	CARL loc_0x002E65 ; 3276
	AND SC,#3Fh ; 3279
	LD EP,#00h ; 327b
	LD HL,#1671h ; 327e
	INC [HL] ; 3281
	LD HL,#1676h ; 3282
	LD A,[HL] ; 3285
	LD [1677h],A ; 3286
	LD [HL],#00h ; 328a
	LD HL,[166Dh] ; 328c
	LD [190Fh],HL ; 328f
	LD NB,#02h ; 3292
	CARL loc_0x011BA5 ; 3295
	LD NB,#02h ; 3298
	CARL loc_0x01168D ; 329b
	LD NB,#02h ; 329e
	CARL loc_0x0116D0 ; 32a1
	LD NB,#02h ; 32a4
	CARL loc_0x01172F ; 32a7
	LD NB,#02h ; 32aa
	CARL loc_0x011CF5 ; 32ad
	LD NB,#00h ; 32b0
	CARL loc_0x002CC6 ; 32b3
	LD NB,#07h ; 32b6
	CARL loc_0x03842F ; 32b9
	RET
; ---------------------- ; 32bc
loc_0x0032BD:
	LD HL,#1672h ; 32bd
	BIT [HL],#0FFh ; 32c0
	JRL Z,loc_0x002F11 ; 32c2
	LD [HL],#00h ; 32c5
	LD HL,#164Dh ; 32c7
	CP [HL],#00h ; 32ca
	JRS Z,loc_0x0032D5 ; 32cd
	LD NB,#00h ; 32cf
	CARL loc_0x002D17 ; 32d2
loc_0x0032D5:
	LD NB,#02h ; 32d5
	CARL loc_0x011D05 ; 32d8
	CARL loc_0x002E65 ; 32db
	AND SC,#3Fh ; 32de
	LD EP,#00h ; 32e0
	LD HL,#1671h ; 32e3
	INC [HL] ; 32e6
	LD HL,#1676h ; 32e7
	LD A,[HL] ; 32ea
	LD [1677h],A ; 32eb
	LD [HL],#00h ; 32ef
	LD HL,#15B1h ; 32f1
	LD [190Fh],HL ; 32f4
	LD NB,#00h ; 32f7
	CARL loc_0x00235D ; 32fa
	LD NB,#02h ; 32fd
	CARL loc_0x011BA5 ; 3300
	LD NB,#02h ; 3303
	CARL loc_0x01168D ; 3306
	LD NB,#02h ; 3309
	CARL loc_0x0116D0 ; 330c
	LD NB,#02h ; 330f
	CARL loc_0x01172F ; 3312
	LD NB,#02h ; 3315
	CARL loc_0x011CF5 ; 3318
	LD HL,#164Dh ; 331b
	CP [HL],#00h ; 331e
	JRS Z,loc_0x003329 ; 3321
	LD NB,#00h ; 3323
	CARL loc_0x002CC6 ; 3326
loc_0x003329:
	LD NB,#07h ; 3329
	CARL loc_0x03842F ; 332c
	RET
; ---------------------- ; 332f
loc_0x003330:
	LD HL,#1672h ; 3330
	BIT [HL],#0FFh ; 3333
	JRL Z,loc_0x002F11 ; 3335
	LD [HL],#00h ; 3338
	LD NB,#07h ; 333a
	CARL loc_0x03852E ; 333d
	LD NB,#02h ; 3340
	CARL loc_0x011D05 ; 3343
	CARL loc_0x002E65 ; 3346
	AND SC,#3Fh ; 3349
	LD EP,#00h ; 334b
	LD HL,#1671h ; 334e
	INC [HL] ; 3351
	LD HL,#1676h ; 3352
	LD A,[HL] ; 3355
	LD [1677h],A ; 3356
	LD [HL],#00h ; 335a
	LD HL,[166Dh] ; 335c
	LD [190Fh],HL ; 335f
	LD NB,#00h ; 3362
	CARL loc_0x00235D ; 3365
	LD NB,#07h ; 3368
	CARL loc_0x038EDF ; 336b
	LD NB,#02h ; 336e
	CARL loc_0x011BA5 ; 3371
	LD NB,#02h ; 3374
	CARL loc_0x011C7B ; 3377
	LD NB,#02h ; 337a
	CARL loc_0x011CF5 ; 337d
	LD NB,#07h ; 3380
	CARL loc_0x0383C6 ; 3383
	LD NB,#07h ; 3386
	CARL loc_0x03842F ; 3389
	CARL loc_0x003390 ; 338c
	RET
; ---------------------- ; 338f
loc_0x003390:
	LD A,[1ACAh] ; 3390
	LD IY,#339Eh ; 3394
	LD YP,#00h ; 3397
	CARL loc_0x002586 ; 339a
	RET
; ---------------------- ; 339d
	DB 0A4h ; 339e
	ASCII "3K4" ; 339f
	DB 0C6h ; 33a2
	ASCII "3" ; 33a3
loc_0x0033A4:
	XOR A,A ; 33a4
	LD [15B4h],A ; 33a5
	LD [15B8h],A ; 33a9
	LD [15BCh],A ; 33ad
	LD [15C0h],A ; 33b1
	LD [15C4h],A ; 33b5
	LD [15C8h],A ; 33b9
	LD [15CCh],A ; 33bd
	LD [15D0h],A ; 33c1
	RET
; ---------------------- ; 33c5
loc_0x0033C6:
	PUSH IP ; 33c6
	PUSH IX ; 33c7
	LD IX,#15AAh ; 33c8
	LD XP,#00h ; 33cb
	CARL loc_0x004706 ; 33ce
	POP IX ; 33d1
	POP IP ; 33d2
	LD B,#10h ; 33d3
	LD A,#58h ; 33d5
	LD [15B1h],BA ; 33d7
	LD A,#5Ch ; 33da
	LD [15B5h],BA ; 33dc
	LD A,#60h ; 33df
	LD [15B9h],BA ; 33e1
	LD A,#64h ; 33e4
	LD [15BDh],BA ; 33e6
	LD A,#68h ; 33e9
	LD [15C1h],BA ; 33eb
	LD A,#08h ; 33ee
	LD [15B4h],A ; 33f0
	LD [15B8h],A ; 33f4
	LD [15C0h],A ; 33f8
	LD [15C4h],A ; 33fc
	LD B,#08h ; 3400
	LD HL,#1B44h ; 3402
	LD A,[HL] ; 3405
	INC A ; 3406
	CP A,#12h ; 3407
	JRS C,loc_0x003414 ; 3409
	LD B,#00h ; 340b
	CP A,#24h ; 340d
	JRS C,loc_0x003414 ; 340f
	LD B,#08h ; 3411
	XOR A,A ; 3413
loc_0x003414:
	LD [HL],A ; 3414
	LD [15BCh],B ; 3415
	XOR A,A ; 3419
	LD [15C8h],A ; 341a
	LD [15CCh],A ; 341e
	LD [15D0h],A ; 3422
	LD A,[15ADh] ; 3426
	CARL loc_0x002575 ; 342a
	LD [15B3h],B ; 342d
	LD [15B7h],A ; 3431
	LD A,#0Ah ; 3435
	LD [15BBh],A ; 3437
	LD A,[15AEh] ; 343b
	CARL loc_0x002575 ; 343f
	LD [15BFh],B ; 3442
	LD [15C3h],A ; 3446
	RET
; ---------------------- ; 344a
loc_0x00344B:
	PUSH IP ; 344b
	PUSH IX ; 344c
	LD IX,#15AAh ; 344d
	LD XP,#00h ; 3450
	CARL loc_0x004706 ; 3453
	POP IX ; 3456
	POP IP ; 3457
	LD B,#10h ; 3458
	LD A,#4Ch ; 345a
	LD [15B1h],BA ; 345c
	LD A,#50h ; 345f
	LD [15B5h],BA ; 3461
	LD A,#54h ; 3464
	LD [15B9h],BA ; 3466
	LD A,#58h ; 3469
	LD [15BDh],BA ; 346b
	LD A,#5Ch ; 346e
	LD [15C1h],BA ; 3470
	LD A,#60h ; 3473
	LD [15C5h],BA ; 3475
	LD A,#64h ; 3478
	LD [15C9h],BA ; 347a
	LD A,#68h ; 347d
	LD [15CDh],BA ; 347f
	LD A,#08h ; 3482
	LD [15B4h],A ; 3484
	LD [15B8h],A ; 3488
	LD [15BCh],A ; 348c
	LD [15C0h],A ; 3490
	LD [15C4h],A ; 3494
	LD [15C8h],A ; 3498
	LD [15CCh],A ; 349c
	LD [15D0h],A ; 34a0
	LD A,[15AAh] ; 34a4
	CARL loc_0x002575 ; 34a8
	LD [15B3h],B ; 34ab
	LD [15B7h],A ; 34af
	LD A,[15ABh] ; 34b3
	CARL loc_0x002575 ; 34b7
	LD [15BFh],B ; 34ba
	LD [15C3h],A ; 34be
	LD A,[15ACh] ; 34c2
	CARL loc_0x002575 ; 34c6
	LD [15CBh],B ; 34c9
	LD [15CFh],A ; 34cd
	LD A,#0Bh ; 34d1
	LD [15BBh],A ; 34d3
	LD [15C7h],A ; 34d7
	RET
; ---------------------- ; 34db
	DB 0F8h
; ---------------------- ; 34dc
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
loc_0x0034FE:
	PUSH ALE ; 34fe
	XOR A,A ; 3500
	LD EP,A ; 3501
	LD BR,#20h ; 3503
	LD [BR:27h],#20h ; 3505
	LD XP,A ; 3508
	LD YP,A ; 350a
	AND SC,#0CFh ; 350c
	CARL IRQ_Timer2HI_Underflow ; 350e
	POP ALE ; 3511
	RETE
; ---------------------- ; 3513
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
loc_0x0035C6:
	PUSH ALE ; 35c6
	LD A,[168Ch] ; 35c8
	CARL loc_0x00293F ; 35cc
	POP ALE ; 35cf
loc_0x0035D1:
	PUSH ALE ; 35d1
	LD IX,#21ACh ; 35d3
	LD XP,#00h ; 35d6
	LD A,[168Ch] ; 35d9
	CARL loc_0x0027E4 ; 35dd
	LD A,[168Ch] ; 35e0
	CARL loc_0x0027F8 ; 35e4
	CARL loc_0x00287D ; 35e7
	LD A,[168Ch] ; 35ea
	CARL loc_0x002753 ; 35ee
	POP ALE ; 35f1
	RET
; ---------------------- ; 35f3
loc_0x0035F4:
	LD A,[1AB6h] ; 35f4
	AND A,A ; 35f8
	JRS Z,loc_0x003601 ; 35f9
	LD A,#01h ; 35fb
	LD [14FAh],A ; 35fd
loc_0x003601:
	CARL loc_0x0022D4 ; 3601
	CARL loc_0x00228F ; 3604
	RET
; ---------------------- ; 3607
loc_0x003608:
	CARL loc_0x0021F4 ; 3608
	CARL loc_0x002338 ; 360b
	XOR A,A ; 360e
	LD [168Dh],A ; 360f
	LD HL,#166Bh ; 3613
	AND [HL],#0FEh ; 3616
	AND [HL],#0FDh ; 3619
	CARL loc_0x00276E ; 361c
	CARL loc_0x002790 ; 361f
	LD [168Bh],A ; 3622
	JRL NZ,loc_0x00365C ; 3626
	LD [168Ch],A ; 3629
	CARL loc_0x002808 ; 362d
	AND A,A ; 3630
	JRS NZ,loc_0x003647 ; 3631
	CARL loc_0x002861 ; 3633
	JRS NZ,loc_0x003647 ; 3636
	CARL loc_0x0026B7 ; 3638
	CARL loc_0x0026C6 ; 363b
	LD HL,#8388h ; 363e
	LD B,#03h ; 3641
	CARL loc_0x00227C ; 3643
	RET
; ---------------------- ; 3646
loc_0x003647:
	LD A,#0FFh ; 3647
	LD [168Ch],A ; 3649
	LD NB,#03h ; 364d
	CARL loc_0x018035 ; 3650
	LD HL,#36ACh ; 3653
	LD B,#00h ; 3656
	CARL loc_0x00227C ; 3658
	RET
; ---------------------- ; 365b
loc_0x00365C:
	LD A,#0FFh ; 365c
	LD [168Ch],A ; 365e
	CARL loc_0x0027C1 ; 3662
	CP A,#0FFh ; 3665
	JRS Z,loc_0x003679 ; 3667
	LD [168Ch],A ; 3669
	CARL loc_0x0035D1 ; 366d
	LD HL,#8388h ; 3670
	LD B,#03h ; 3673
	CARL loc_0x00227C ; 3675
	RET
; ---------------------- ; 3678
loc_0x003679:
	LD [168Ch],A ; 3679
	LD HL,#379Fh ; 367d
	LD B,#00h ; 3680
	CARL loc_0x00227C ; 3682
	RET
; ---------------------- ; 3685
	DB 04h, 04h, 0Eh, 40h, 1Fh, 02h, 40h, 1Fh ; 3686
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 368e
	ASCIZ "m/" ; 3695
	DB 0E6h ; 3698
	ASCIZ "6" ; 3699
	DB 00h, 00h, 00h, 18h ; 369b
	ASCIZ "7" ; 369f
	DB 18h, 08h, 00h, 0EEh, 25h, 00h, 00h, 00h ; 36a1
	DB 00h, 00h, 00h
; ---------------------- ; 36a9
loc_0x0036AC:
	CARL loc_0x0021F4 ; 36ac
	CARL loc_0x002338 ; 36af
	LD NB,#02h ; 36b2
	CARL loc_0x011ADC ; 36b5
	LD NB,#00h ; 36b8
	CARL loc_0x002BF9 ; 36bb
	LD NB,#07h ; 36be
	CARL loc_0x0382F4 ; 36c1
	LD IY,#3686h ; 36c4
	LD YP,#00h ; 36c7
	CARL loc_0x002D72 ; 36ca
	LD IY,#0012h ; 36cd
	LD NB,#02h ; 36d0
	CARL loc_0x011B84 ; 36d3
	LD IY,#13AEh ; 36d6
	LD NB,#02h ; 36d9
	CARL loc_0x011B84 ; 36dc
	CARL loc_0x00233F ; 36df
	CARL loc_0x0021FB ; 36e2
	RET
; ---------------------- ; 36e5
loc_0x0036E6:
	CARL loc_0x002346 ; 36e6
	LD HL,#1643h ; 36e9
	BIT [HL],#01h ; 36ec
	JRL NZ,loc_0x0035F4 ; 36ee
	RET
; ---------------------- ; 36f1
	DB 04h, 04h, 0Eh, 40h, 22h, 02h, 40h, 22h ; 36f2
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 36fa
	ASCIZ "m/" ; 3701
	ASCIZ "R7" ; 3704
	DB 00h, 00h, 00h ; 3707
	ASCII "h" ; 370a
	DB 83h, 03h, 18h, 08h, 0FFh, 0EEh, 25h, 00h ; 370b
	DB 00h, 00h, 00h, 00h, 00h
; ---------------------- ; 3713
loc_0x003718:
	CARL loc_0x0021F4 ; 3718
	CARL loc_0x002338 ; 371b
	LD NB,#02h ; 371e
	CARL loc_0x011ADC ; 3721
	LD NB,#00h ; 3724
	CARL loc_0x002BF9 ; 3727
	LD NB,#07h ; 372a
	CARL loc_0x0382F4 ; 372d
	LD IY,#36F2h ; 3730
	LD YP,#00h ; 3733
	CARL loc_0x002D72 ; 3736
	LD IY,#0012h ; 3739
	LD NB,#02h ; 373c
	CARL loc_0x011B84 ; 373f
	LD IY,#13AEh ; 3742
	LD NB,#02h ; 3745
	CARL loc_0x011B84 ; 3748
	CARL loc_0x00233F ; 374b
	CARL loc_0x0021FB ; 374e
	RET
; ---------------------- ; 3751
loc_0x003752:
	CARL loc_0x002346 ; 3752
	LD HL,#1643h ; 3755
	BIT [HL],#01h ; 3758
	JRS NZ,loc_0x00375D ; 375a
	RET
; ---------------------- ; 375c
loc_0x00375D:
	LD A,[1AB6h] ; 375d
	AND A,A ; 3761
	JRS Z,loc_0x00376A ; 3762
	LD A,#01h ; 3764
	LD [14FAh],A ; 3766
loc_0x00376A:
	LD A,[168Bh] ; 376a
	LD [168Ch],A ; 376e
	CARL loc_0x0022D4 ; 3772
	CARL loc_0x00228F ; 3775
	RET
; ---------------------- ; 3778
	DB 04h, 04h, 0Eh, 40h, 25h, 02h, 40h, 25h ; 3779
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 3781
	ASCIZ "m/" ; 3788
	DB 0D9h ; 378b
	ASCIZ "7" ; 378c
	DB 00h, 00h, 00h, 0Bh ; 378e
	ASCIZ "8" ; 3792
	DB 18h, 08h, 00h, 0EEh, 25h, 00h, 00h, 00h ; 3794
	DB 00h, 00h, 00h
; ---------------------- ; 379c
loc_0x00379F:
	CARL loc_0x0021F4 ; 379f
	CARL loc_0x002338 ; 37a2
	LD NB,#02h ; 37a5
	CARL loc_0x011ADC ; 37a8
	LD NB,#00h ; 37ab
	CARL loc_0x002BF9 ; 37ae
	LD NB,#07h ; 37b1
	CARL loc_0x0382F4 ; 37b4
	LD IY,#3779h ; 37b7
	LD YP,#00h ; 37ba
	CARL loc_0x002D72 ; 37bd
	LD IY,#0012h ; 37c0
	LD NB,#02h ; 37c3
	CARL loc_0x011B84 ; 37c6
	LD IY,#13AEh ; 37c9
	LD NB,#02h ; 37cc
	CARL loc_0x011B84 ; 37cf
	CARL loc_0x00233F ; 37d2
	CARL loc_0x0021FB ; 37d5
	RET
; ---------------------- ; 37d8
loc_0x0037D9:
	CARL loc_0x002346 ; 37d9
	LD HL,#1643h ; 37dc
	BIT [HL],#01h ; 37df
	JRL NZ,loc_0x0035F4 ; 37e1
	RET
; ---------------------- ; 37e4
	DB 04h, 04h, 0Eh, 40h ; 37e5
	ASCII "4" ; 37e9
	DB 02h, 40h ; 37ea
	ASCII "4" ; 37ec
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 37ed
	ASCIZ "m/" ; 37f4
	ASCIZ "K8" ; 37f7
	DB 0E5h, 3Ah, 00h, 0B2h ; 37fa
	ASCIZ "8" ; 37fe
	DB 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h, 00h ; 3800
	DB 00h, 00h, 00h
; ---------------------- ; 3808
loc_0x00380B:
	CARL loc_0x0021F4 ; 380b
	CARL loc_0x002338 ; 380e
	LD NB,#02h ; 3811
	CARL loc_0x011ADC ; 3814
	LD NB,#00h ; 3817
	CARL loc_0x002BF9 ; 381a
	LD NB,#07h ; 381d
	CARL loc_0x0382F4 ; 3820
	LD IY,#37E5h ; 3823
	LD YP,#00h ; 3826
	CARL loc_0x002D72 ; 3829
	LD A,#00h ; 382c
	LD [168Eh],A ; 382e
	LD IY,#0051h ; 3832
	LD NB,#02h ; 3835
	CARL loc_0x011B84 ; 3838
	LD IY,#13AEh ; 383b
	LD NB,#02h ; 383e
	CARL loc_0x011B84 ; 3841
	CARL loc_0x00233F ; 3844
	CARL loc_0x0021FB ; 3847
	RET
; ---------------------- ; 384a
loc_0x00384B:
	CARL loc_0x002346 ; 384b
	LD HL,#1643h ; 384e
	BIT [HL],#01h ; 3851
	JRS NZ,loc_0x00385D ; 3853
	LD HL,#1643h ; 3855
	BIT [HL],#02h ; 3858
	JRS NZ,loc_0x003878 ; 385a
	RET
; ---------------------- ; 385c
loc_0x00385D:
	LD A,[1AB6h] ; 385d
	AND A,A ; 3861
	JRS Z,loc_0x00386A ; 3862
	LD A,#01h ; 3864
	LD [14FAh],A ; 3866
loc_0x00386A:
	LD A,[168Eh] ; 386a
	AND A,A ; 386e
	JRS NZ,loc_0x003885 ; 386f
	CARL loc_0x0022D4 ; 3871
	CARL loc_0x00228F ; 3874
	RET
; ---------------------- ; 3877
loc_0x003878:
	LD A,[1AB6h] ; 3878
	AND A,A ; 387c
	JRS Z,loc_0x003885 ; 387d
	LD A,#02h ; 387f
	LD [14FAh],A ; 3881
loc_0x003885:
	CARL loc_0x0022EE ; 3885
	CARL loc_0x00228F ; 3888
	RET
; ---------------------- ; 388b
	DB 04h, 04h, 0Eh, 40h, 28h, 02h, 40h, 28h ; 388c
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 3894
	ASCIZ "m/" ; 389b
	DB 0ECh ; 389e
	ASCIZ "8" ; 389f
	DB 00h, 00h, 00h, 1Eh ; 38a1
	ASCIZ "9" ; 38a5
	DB 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h, 00h ; 38a7
	DB 00h, 00h, 00h
; ---------------------- ; 38af
loc_0x0038B2:
	CARL loc_0x0021F4 ; 38b2
	CARL loc_0x002338 ; 38b5
	LD NB,#02h ; 38b8
	CARL loc_0x011ADC ; 38bb
	LD NB,#00h ; 38be
	CARL loc_0x002BF9 ; 38c1
	LD NB,#07h ; 38c4
	CARL loc_0x0382F4 ; 38c7
	LD IY,#388Ch ; 38ca
	LD YP,#00h ; 38cd
	CARL loc_0x002D72 ; 38d0
	LD IY,#0012h ; 38d3
	LD NB,#02h ; 38d6
	CARL loc_0x011B84 ; 38d9
	LD IY,#13AEh ; 38dc
	LD NB,#02h ; 38df
	CARL loc_0x011B84 ; 38e2
	CARL loc_0x00233F ; 38e5
	CARL loc_0x0021FB ; 38e8
	RET
; ---------------------- ; 38eb
loc_0x0038EC:
	CARL loc_0x002346 ; 38ec
	LD HL,#1643h ; 38ef
	BIT [HL],#01h ; 38f2
	JRL NZ,loc_0x0035F4 ; 38f4
	RET
; ---------------------- ; 38f7
	DB 04h, 04h, 3Eh, 40h, 17h, 02h, 40h, 17h ; 38f8
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 3900
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
	DB 02h, 0Ch, 08h
; ---------------------- ; 391b
loc_0x00391E:
	CARL loc_0x0021F4 ; 391e
	CARL loc_0x002338 ; 3921
	LD NB,#02h ; 3924
	CARL loc_0x011ADC ; 3927
	LD NB,#00h ; 392a
	CARL loc_0x002BF9 ; 392d
	LD NB,#07h ; 3930
	CARL loc_0x0382F4 ; 3933
	LD IY,#38F8h ; 3936
	LD YP,#00h ; 3939
	CARL loc_0x002D72 ; 393c
	LD IY,#87D4h ; 393f
	LD NB,#07h ; 3942
	CARL loc_0x03836A ; 3945
	LD IY,#00B0h ; 3948
	LD NB,#02h ; 394b
	CARL loc_0x011B84 ; 394e
	LD IY,#13AEh ; 3951
	LD NB,#02h ; 3954
	CARL loc_0x011B84 ; 3957
	CARL loc_0x00233F ; 395a
	CARL loc_0x0021FB ; 395d
	RET
; ---------------------- ; 3960
loc_0x003961:
	CARL loc_0x002346 ; 3961
	LD HL,#1643h ; 3964
	BIT [HL],#01h ; 3967
	JRS NZ,loc_0x003973 ; 3969
	LD HL,#1643h ; 396b
	BIT [HL],#02h ; 396e
	JRS NZ,loc_0x003987 ; 3970
	RET
; ---------------------- ; 3972
loc_0x003973:
	LD A,[1AB6h] ; 3973
	AND A,A ; 3977
	JRS Z,loc_0x003980 ; 3978
	LD A,#01h ; 397a
	LD [14FAh],A ; 397c
loc_0x003980:
	CARL loc_0x0022D4 ; 3980
	CARL loc_0x00228F ; 3983
	RET
; ---------------------- ; 3986
loc_0x003987:
	LD A,[1AB6h] ; 3987
	AND A,A ; 398b
	JRS Z,loc_0x003994 ; 398c
	LD A,#02h ; 398e
	LD [14FAh],A ; 3990
loc_0x003994:
	CARL loc_0x0022EE ; 3994
	CARL loc_0x00228F ; 3997
	RET
; ---------------------- ; 399a
	DB 04h, 04h, 3Eh, 40h, 17h, 02h, 40h, 17h ; 399b
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 39a3
	ASCIZ "m/" ; 39aa
	DB 0Ah, 3Ah, 00h, 1Eh ; 39ad
	ASCIZ "9" ; 39b1
	ASCII "h" ; 39b3
	DB 83h, 03h, 18h, 08h, 0FFh ; 39b4
	ASCIZ "B&" ; 39b9
	DB 23h ; 39bc
	ASCII "S" ; 39bd
	DB 02h, 0Ch, 08h
; ---------------------- ; 39be
loc_0x0039C1:
	CARL loc_0x0021F4 ; 39c1
	CARL loc_0x002338 ; 39c4
	LD NB,#02h ; 39c7
	CARL loc_0x011ADC ; 39ca
	LD NB,#00h ; 39cd
	CARL loc_0x002BF9 ; 39d0
	LD NB,#07h ; 39d3
	CARL loc_0x0382F4 ; 39d6
	LD IY,#399Bh ; 39d9
	LD YP,#00h ; 39dc
	CARL loc_0x002D72 ; 39df
	LD IY,#87D4h ; 39e2
	LD NB,#07h ; 39e5
	CARL loc_0x03836A ; 39e8
	LD A,#01h ; 39eb
	LD [168Eh],A ; 39ed
	LD IY,#0051h ; 39f1
	LD NB,#02h ; 39f4
	CARL loc_0x011B84 ; 39f7
	LD IY,#13AEh ; 39fa
	LD NB,#02h ; 39fd
	CARL loc_0x011B84 ; 3a00
	CARL loc_0x00233F ; 3a03
	CARL loc_0x0021FB ; 3a06
	RET
; ---------------------- ; 3a09
loc_0x003A0A:
	CARL loc_0x002346 ; 3a0a
	LD HL,#1643h ; 3a0d
	BIT [HL],#01h ; 3a10
	JRS NZ,loc_0x003A1C ; 3a12
	LD HL,#1643h ; 3a14
	BIT [HL],#02h ; 3a17
	JRS NZ,loc_0x003A3F ; 3a19
	RET
; ---------------------- ; 3a1b
loc_0x003A1C:
	LD A,[1AB6h] ; 3a1c
	AND A,A ; 3a20
	JRS Z,loc_0x003A29 ; 3a21
	LD A,#01h ; 3a23
	LD [14FAh],A ; 3a25
loc_0x003A29:
	LD A,[168Eh] ; 3a29
	AND A,A ; 3a2d
	JRS NZ,loc_0x003A4C ; 3a2e
	LD A,[168Dh] ; 3a30
	LD [168Ch],A ; 3a34
	CARL loc_0x0022D4 ; 3a38
	CARL loc_0x00228F ; 3a3b
	RET
; ---------------------- ; 3a3e
loc_0x003A3F:
	LD A,[1AB6h] ; 3a3f
	AND A,A ; 3a43
	JRS Z,loc_0x003A4C ; 3a44
	LD A,#02h ; 3a46
	LD [14FAh],A ; 3a48
loc_0x003A4C:
	CARL loc_0x0022EE ; 3a4c
	CARL loc_0x00228F ; 3a4f
	RET
; ---------------------- ; 3a52
	DB 04h, 04h, 0Eh, 40h, 2Eh, 02h, 40h, 2Eh ; 3a53
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 3a5b
	ASCIZ "m/" ; 3a62
	DB 0B3h, 3Ah, 00h, 00h, 00h, 00h, 0E5h, 3Ah ; 3a65
	DB 00h, 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h ; 3a6d
	DB 00h, 00h, 00h, 00h
; ---------------------- ; 3a75
loc_0x003A79:
	CARL loc_0x0021F4 ; 3a79
	CARL loc_0x002338 ; 3a7c
	LD NB,#02h ; 3a7f
	CARL loc_0x011ADC ; 3a82
	LD NB,#00h ; 3a85
	CARL loc_0x002BF9 ; 3a88
	LD NB,#07h ; 3a8b
	CARL loc_0x0382F4 ; 3a8e
	LD IY,#3A53h ; 3a91
	LD YP,#00h ; 3a94
	CARL loc_0x002D72 ; 3a97
	LD IY,#0012h ; 3a9a
	LD NB,#02h ; 3a9d
	CARL loc_0x011B84 ; 3aa0
	LD IY,#13AEh ; 3aa3
	LD NB,#02h ; 3aa6
	CARL loc_0x011B84 ; 3aa9
	CARL loc_0x00233F ; 3aac
	CARL loc_0x0021FB ; 3aaf
	RET
; ---------------------- ; 3ab2
loc_0x003AB3:
	CARL loc_0x002346 ; 3ab3
	LD HL,#1643h ; 3ab6
	BIT [HL],#01h ; 3ab9
	JRL NZ,loc_0x0035F4 ; 3abb
	RET
; ---------------------- ; 3abe
	DB 04h, 04h, 0Eh, 40h, 2Bh, 02h, 40h, 2Bh ; 3abf
	DB 02h, 00h, 14h, 02h, 00h, 14h, 02h ; 3ac7
	ASCIZ "m/" ; 3ace
	DB 1Fh, 3Bh, 00h, 00h, 00h, 00h, 88h, 83h ; 3ad1
	DB 03h, 18h, 08h, 0FFh, 0EEh, 25h, 00h, 00h ; 3ad9
	DB 00h, 00h, 00h, 00h
; ---------------------- ; 3ae1
loc_0x003AE5:
	CARL loc_0x0021F4 ; 3ae5
	CARL loc_0x002338 ; 3ae8
	LD NB,#02h ; 3aeb
	CARL loc_0x011ADC ; 3aee
	LD NB,#00h ; 3af1
	CARL loc_0x002BF9 ; 3af4
	LD NB,#07h ; 3af7
	CARL loc_0x0382F4 ; 3afa
	LD IY,#3ABFh ; 3afd
	LD YP,#00h ; 3b00
	CARL loc_0x002D72 ; 3b03
	LD IY,#0012h ; 3b06
	LD NB,#02h ; 3b09
	CARL loc_0x011B84 ; 3b0c
	LD IY,#13AEh ; 3b0f
	LD NB,#02h ; 3b12
	CARL loc_0x011B84 ; 3b15
	CARL loc_0x00233F ; 3b18
	CARL loc_0x0021FB ; 3b1b
	RET
; ---------------------- ; 3b1e
loc_0x003B1F:
	CARL loc_0x002346 ; 3b1f
	LD HL,#1643h ; 3b22
	BIT [HL],#01h ; 3b25
	JRL NZ,loc_0x0035F4 ; 3b27
	RET
; ---------------------- ; 3b2a



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
	DB 94h, 01h, 0FFh
; ---------------------- ; 7945
loc_0x007948:
	LD [IX+04h],A ; 7948
	LD [IX+05h],B ; 794b
	RET
; ---------------------- ; 794e
loc_0x00794F:
	LD [IX+02h],A ; 794f
	LD [IX+03h],B ; 7952
	LD A,#01h ; 7955
	LD [IX+06h],A ; 7957
	RET
; ---------------------- ; 795a
	DB 0CEh ; 795b
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
; ---------------------- ; 796e
loc_0x007970:
	LD [IX+04h],L ; 7970
	LD [IX+05h],H ; 7973
	LD [IX+02h],A ; 7976
	LD [IX+03h],B ; 7979
	LD A,#01h ; 797c
	LD [IX+06h],A ; 797e
	RET
; ---------------------- ; 7981
loc_0x007982:
	LD [IX+0Ah],A ; 7982
	LD [IX+0Eh],B ; 7985
	XOR A,A ; 7988
	LD [IX+09h],A ; 7989
	LD [IX+0Bh],A ; 798c
	LD [IX+0Dh],A ; 798f
	LD [IX+0Fh],A ; 7992
	RET
; ---------------------- ; 7995

	DB 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh ; 7994
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
	DB 0B7h, 0C1h, 99h, 0Eh, 80h
loc_0x009A10:
	DB 0A6h, 0A3h, 0CEh ; 9a0b
	DB 0D2h, 0DFh, 1Ah, 0C7h, 1Fh, 9Ah, 0CEh, 0C7h ; 9a13
	DB 00h, 0F3h, 0C2h, 00h ; 9a1b
	ASCII "F<2" ; 9a1f
loc_0x009A22:
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0E1h, 1Ah, 0C7h ; 9a22
	ASCII "1" ; 9a29
	DB 9Ah, 0CEh, 0C7h, 00h, 0F3h, 0B0h, 00h ; 9a2a
	ASCII "F<2" ; 9a31

; ---------------------- ; 9a31
loc_0x009A34:
	PUSH IP ; 9a34
	PUSH IY ; 9a35
	LD L,[1ADFh] ; 9a36
	LD IY,#9A43h ; 9a3a
	LD YP,#00h ; 9a3d
	JRL loc_0x009AE0
; ---------------------- ; 9a40
	DB 3Ch ; 9a43
	ASCII "2("
; ---------------------- ; 9a44
loc_0x009A46:
	PUSH IP ; 9a46
	PUSH IY ; 9a47
	LD L,[1ADFh] ; 9a48
	LD IY,#9A55h ; 9a4c
	LD YP,#00h ; 9a4f
	JRL loc_0x009AE0
; ---------------------- ; 9a52
	ASCII "2(" ; 9a55
	DB 1Eh
; ---------------------- ; 9a57
loc_0x009A58:
	PUSH IP ; 9a58
	PUSH IY ; 9a59
	LD L,[1ADFh] ; 9a5a
	LD IY,#9A66h ; 9a5e
	LD YP,#00h ; 9a61
	JRS loc_0x009AE0
; ---------------------- ; 9a64
	DB 28h, 1Eh, 14h
; ---------------------- ; 9a66
loc_0x009A69:
	PUSH IP ; 9a69
	PUSH IY ; 9a6a
	LD L,[1ADFh] ; 9a6b
	LD IY,#9A77h ; 9a6f
	LD YP,#00h ; 9a72
	JRS loc_0x009AE0
; ---------------------- ; 9a75
	ASCII "F<2"
; ---------------------- ; 9a77
loc_0x009A7A:
	PUSH IP ; 9a7a
	PUSH IY ; 9a7b
	LD L,[1ADFh] ; 9a7c
	LD IY,#9A88h ; 9a80
	LD YP,#00h ; 9a83
	JRS loc_0x009AE0
; ---------------------- ; 9a86
	DB 3Ch ; 9a88
	ASCII "2("
; ---------------------- ; 9a89
loc_0x009A8B:
	PUSH IP ; 9a8b
	PUSH IY ; 9a8c
	LD L,[1ADFh] ; 9a8d
	LD IY,#9A99h ; 9a91
	LD YP,#00h ; 9a94
	JRS loc_0x009AE0
; ---------------------- ; 9a97
	ASCII "2(" ; 9a99
	DB 1Eh
; ---------------------- ; 9a9b
loc_0x009A9C:
	PUSH IP ; 9a9c
	PUSH IY ; 9a9d
	LD L,[1AE3h] ; 9a9e
	LD IY,#9AAAh ; 9aa2
	LD YP,#00h ; 9aa5
	JRS loc_0x009AE0
; ---------------------- ; 9aa8
	ASCII "F<2"
; ---------------------- ; 9aaa
loc_0x009AAD:
	PUSH IP ; 9aad
	PUSH IY ; 9aae
	LD L,[1ADDh] ; 9aaf
	LD IY,#9ABBh ; 9ab3
	LD YP,#00h ; 9ab6
	JRS loc_0x009AE0
; ---------------------- ; 9ab9
	ASCII "F<2"
; ---------------------- ; 9abb
loc_0x009ABE:
	PUSH IP ; 9abe
	PUSH IY ; 9abf
	LD L,[1ADDh] ; 9ac0
	LD IY,#9ACCh ; 9ac4
	LD YP,#00h ; 9ac7
	JRS loc_0x009AE0
; ---------------------- ; 9aca
	ASCII "F<2"
; ---------------------- ; 9acc
loc_0x009ACF:
	PUSH IP ; 9acf
	PUSH IY ; 9ad0
	LD L,[1ADDh] ; 9ad1
	LD IY,#9ADDh ; 9ad5
	LD YP,#00h ; 9ad8
	JRS loc_0x009AE0
; ---------------------- ; 9adb
	ASCII "F<2"
; ---------------------- ; 9add
loc_0x009AE0:
	CARL loc_0x00AA46 ; 9ae0
	JRS Z,loc_0x009B0A ; 9ae3
	LD A,[1ADCh] ; 9ae5
	LD B,#00h ; 9ae9
	ADD IY,BA ; 9aeb
	LD A,#64h ; 9aed
	SUB A,[IY] ; 9aef
	MLT ; 9af0
	LD A,#40h ; 9af2
	DIV ; 9af4
	LD A,L ; 9af6
	ADD A,[IY] ; 9af7
	PUSH A ; 9af8
	LD BA,#0064h ; 9afa
	LD NB,#03h ; 9afd
	CARL loc_0x018FFE ; 9b00
	POP B ; 9b03
	CP A,B ; 9b05
	JRS Z,loc_0x009B0E ; 9b06
	JRS C,loc_0x009B0E ; 9b08
loc_0x009B0A:
	AND SC,#0FEh ; 9b0a
	JRS loc_0x009B10
; ---------------------- ; 9b0c
loc_0x009B0E:
	OR SC,#01h ; 9b0e
loc_0x009B10:
	POP IY ; 9b10
	POP IP ; 9b11
	RET
; ---------------------- ; 9b12
	DB 04h, 00h ; 9b13
	ASCII "m" ; 9b15
	DB 1Ah, 8Eh, 99h, 0F8h
; ---------------------- ; 9b16
loc_0x009B1A:
	LD A,[1B12h] ; 9b1a
	SUB A,#02h ; 9b1e
	JRS NC,loc_0x009B23 ; 9b20
	XOR A,A ; 9b22
loc_0x009B23:
	LD B,[1B10h] ; 9b23
	CP A,B ; 9b27
	JRS Z,loc_0x009B35 ; 9b28
	JRS NC,loc_0x009B53 ; 9b2a
	LD A,[1B12h] ; 9b2c
	ADD A,#02h ; 9b30
	CP A,B ; 9b32
	JRS C,loc_0x009B53 ; 9b33
loc_0x009B35:
	LD A,[1B13h] ; 9b35
	SUB A,#0Dh ; 9b39
	JRS NC,loc_0x009B3E ; 9b3b
	XOR A,A ; 9b3d
loc_0x009B3E:
	LD B,[1B11h] ; 9b3e
	CP A,B ; 9b42
	JRS Z,loc_0x009B50 ; 9b43
	JRS NC,loc_0x009B53 ; 9b45
	LD A,[1B13h] ; 9b47
	ADD A,#10h ; 9b4b
	CP A,B ; 9b4d
	JRS C,loc_0x009B53 ; 9b4e
loc_0x009B50:
	AND SC,#0FEh ; 9b50
	RET
; ---------------------- ; 9b52
loc_0x009B53:
	OR SC,#01h ; 9b53
	RET
; ---------------------- ; 9b55
loc_0x009B56:
	LD A,[1B12h] ; 9b56
	SUB A,#02h ; 9b5a
	JRS NC,loc_0x009B5F ; 9b5c
	XOR A,A ; 9b5e
loc_0x009B5F:
	LD B,[1B10h] ; 9b5f
	CP A,B ; 9b63
	JRS Z,loc_0x009B71 ; 9b64
	JRS NC,loc_0x009B8A ; 9b66
	LD A,[1B12h] ; 9b68
	ADD A,#05h ; 9b6c
	CP A,B ; 9b6e
	JRS C,loc_0x009B8A ; 9b6f
loc_0x009B71:
	LD B,[1B13h] ; 9b71
	LD A,[1B11h] ; 9b75
	ADD A,#10h ; 9b79
	CP A,B ; 9b7b
	JRS C,loc_0x009B8A ; 9b7c
	LD A,[1B11h] ; 9b7e
	CP A,B ; 9b82
	JRS Z,loc_0x009B87 ; 9b83
	JRS NC,loc_0x009B8A ; 9b85
loc_0x009B87:
	AND SC,#0FEh ; 9b87
	RET
; ---------------------- ; 9b89
loc_0x009B8A:
	OR SC,#01h ; 9b8a
	RET
; ---------------------- ; 9b8c
loc_0x009B8D:
	LD A,[1B14h] ; 9b8d
	CP A,#00h ; 9b91
	JRS NZ,loc_0x009BA3 ; 9b93
	LD A,[1AD7h] ; 9b95
	CP A,#00h ; 9b99
	JRS Z,loc_0x009BF6 ; 9b9b
	CP A,#01h ; 9b9d
	JRS Z,loc_0x009BA6 ; 9b9f
	JRS loc_0x009BC6
; ---------------------- ; 9ba1
loc_0x009BA3:
	OR SC,#01h ; 9ba3
	RET
; ---------------------- ; 9ba5
loc_0x009BA6:
	LD HL,[1B37h] ; 9ba6
	ADD HL,#0018h ; 9ba9
	LD BA,[HL] ; 9bac
	CP BA,#976Ah ; 9bae
	JRS C,loc_0x009BC3 ; 9bb1
	CP BA,#9849h ; 9bb3
	JRS NC,loc_0x009BC3 ; 9bb6
	LD A,[1B10h] ; 9bb8
	CP A,#30h ; 9bbc
	JRS C,loc_0x009BC3 ; 9bbe
	AND SC,#0FEh ; 9bc0
	RET
; ---------------------- ; 9bc2
loc_0x009BC3:
	OR SC,#01h ; 9bc3
	RET
; ---------------------- ; 9bc5
loc_0x009BC6:
	LD HL,[1B37h] ; 9bc6
	ADD HL,#0018h ; 9bc9
	LD BA,[HL] ; 9bcc
	CP BA,#9883h ; 9bce
	JRS C,loc_0x009BF3 ; 9bd1
	CP BA,#9967h ; 9bd3
	JRS NC,loc_0x009BF3 ; 9bd6
	LD A,[1B10h] ; 9bd8
	CP A,#2Bh ; 9bdc
	JRS C,loc_0x009BF3 ; 9bde
	CP A,#32h ; 9be0
	JRS NC,loc_0x009BF3 ; 9be2
	LD A,[1B11h] ; 9be4
	CP A,#27h ; 9be8
	JRS C,loc_0x009BF3 ; 9bea
	CP A,#33h ; 9bec
	JRS NC,loc_0x009BF3 ; 9bee
	AND SC,#0FEh ; 9bf0
	RET
; ---------------------- ; 9bf2
loc_0x009BF3:
	OR SC,#01h ; 9bf3
	RET
; ---------------------- ; 9bf5
loc_0x009BF6:
	LD HL,[1B37h] ; 9bf6
	ADD HL,#0018h ; 9bf9
	LD BA,[HL] ; 9bfc
	CP BA,#965Eh ; 9bfe
	JRS C,loc_0x009C23 ; 9c01
	CP BA,#96FDh ; 9c03
	JRS NC,loc_0x009C23 ; 9c06
	LD A,[1B10h] ; 9c08
	CP A,#27h ; 9c0c
	JRS C,loc_0x009C23 ; 9c0e
	CP A,#2Eh ; 9c10
	JRS NC,loc_0x009C23 ; 9c12
	LD A,[1B11h] ; 9c14
	CP A,#20h ; 9c18
	JRS C,loc_0x009C23 ; 9c1a
	CP A,#2Ch ; 9c1c
	JRS NC,loc_0x009C23 ; 9c1e
	AND SC,#0FEh ; 9c20
	RET
; ---------------------- ; 9c22
loc_0x009C23:
	OR SC,#01h ; 9c23
	RET
; ---------------------- ; 9c25
loc_0x009C26:
	LD A,[1B15h] ; 9c26
	CP A,#03h ; 9c2a
	JRS Z,loc_0x009C4F ; 9c2c
	CP A,#04h ; 9c2e
	JRS Z,loc_0x009C4F ; 9c30
	LD A,[1B28h] ; 9c32
	CP A,#03h ; 9c36
	JRS Z,loc_0x009C3B ; 9c38
	RETS
; ---------------------- ; 9c3a
loc_0x009C3B:
	LD A,#00h ; 9c3b
	LD [1B28h],A ; 9c3d
	LD NB,#02h ; 9c41
	CARL loc_0x012F7C ; 9c44
	LD BA,#8D42h ; 9c47
	CARL loc_0x00A97D ; 9c4a
	RET
; ---------------------- ; 9c4d
	DB 0F8h
; ---------------------- ; 9c4e
loc_0x009C4F:
	LD BA,#8D6Ah ; 9c4f
	CARL loc_0x00A97D ; 9c52
	RET
; ---------------------- ; 9c55
loc_0x009C56:
	LD A,[1B17h] ; 9c56
	CP A,#02h ; 9c5a
	JRS Z,loc_0x009C5F ; 9c5c
	RETS
; ---------------------- ; 9c5e
loc_0x009C5F:
	LD BA,#829Eh ; 9c5f
	CARL loc_0x00A97D ; 9c62
	RET
; ---------------------- ; 9c65
loc_0x009C66:
	CARL loc_0x009B56 ; 9c66
	JRS NZ,loc_0x009C6C ; 9c69
	RETS
; ---------------------- ; 9c6b
loc_0x009C6C:
	LD BA,#82DBh ; 9c6c
	CARL loc_0x00A97D ; 9c6f
	RET
; ---------------------- ; 9c72
loc_0x009C73:
	CARL loc_0x00AAFE ; 9c73
	JRS NZ,loc_0x009C79 ; 9c76
	RETS
; ---------------------- ; 9c78
loc_0x009C79:
	LD BA,#8335h ; 9c79
	CARL loc_0x00A97D ; 9c7c
	RET
; ---------------------- ; 9c7f
loc_0x009C80:
	CARL loc_0x00AA46 ; 9c80
	JRS Z,loc_0x009C86 ; 9c83
	RETS
; ---------------------- ; 9c85
loc_0x009C86:
	LD HL,#8280h ; 9c86
	LD A,[1ADBh] ; 9c89
	OR A,A ; 9c8d
	JRS Z,loc_0x009C93 ; 9c8e
	LD HL,#8262h ; 9c90
loc_0x009C93:
	LD BA,HL ; 9c93
	CARL loc_0x00A97D ; 9c95
	RET
; ---------------------- ; 9c98
loc_0x009C99:
	LD A,[1B15h] ; 9c99
	CP A,#02h ; 9c9d
	JRS Z,loc_0x009CA2 ; 9c9f
	RETS
; ---------------------- ; 9ca1
loc_0x009CA2:
	LD BA,[1B10h] ; 9ca2
	LD [1B1Eh],BA ; 9ca5
	LD A,[1AB6h] ; 9ca8
	AND A,A ; 9cac
	JRS Z,loc_0x009CB5 ; 9cad
	LD A,#01h ; 9caf
	LD [14FAh],A ; 9cb1
loc_0x009CB5:
	CARL loc_0x00AA46 ; 9cb5
	JRS Z,loc_0x009CCC ; 9cb8
	LD A,[1ADCh] ; 9cba
	CP A,#02h ; 9cbe
	JRS Z,loc_0x009CC7 ; 9cc0
	LD BA,#8356h ; 9cc2
	JRS loc_0x009CCF
; ---------------------- ; 9cc5
loc_0x009CC7:
	LD BA,#8587h ; 9cc7
	JRS loc_0x009CCF
; ---------------------- ; 9cca
loc_0x009CCC:
	LD BA,#8217h ; 9ccc
loc_0x009CCF:
	CARL loc_0x00A97D ; 9ccf
	RET
; ---------------------- ; 9cd2
loc_0x009CD3:
	LD A,[1AD8h] ; 9cd3
	CP A,#01h ; 9cd7
	JRS NZ,loc_0x009CE6 ; 9cd9
	LD HL,#1B12h ; 9cdb
	LD NB,#02h ; 9cde
	CARL loc_0x012718 ; 9ce1
	JRS NZ,loc_0x009CE7 ; 9ce4
loc_0x009CE6:
	RETS
; ---------------------- ; 9ce6
loc_0x009CE7:
	LD A,[1AD6h] ; 9ce7
	OR A,A ; 9ceb
	JRS NZ,loc_0x009CFC ; 9cec
	LD A,[1ADAh] ; 9cee
	CP A,#02h ; 9cf2
	JRS NC,loc_0x009CFC ; 9cf4
	LD A,#02h ; 9cf6
	LD [1ADAh],A ; 9cf8
loc_0x009CFC:
	LD A,#0FFh ; 9cfc
	LD [1AE8h],A ; 9cfe
	LD BA,#8658h ; 9d02
loc_0x009D05:
	CARL loc_0x00A97D ; 9d05
	RET
; ---------------------- ; 9d08
loc_0x009D09:
	CARL loc_0x00AACC ; 9d09
	JRS NZ,loc_0x009D21 ; 9d0c
	LD A,#1Ch ; 9d0e
	LD [1B1Eh],A ; 9d10
	LD A,#05h ; 9d14
	LD [1B20h],A ; 9d16
	LD BA,#99BCh ; 9d1a
	CARL loc_0x00A97D ; 9d1d
	RET
; ---------------------- ; 9d20
loc_0x009D21:
	RETS
; ---------------------- ; 9d21
loc_0x009D22:
	CARL loc_0x00AA8F ; 9d22
	JRS NZ,loc_0x009D4F ; 9d25
	LD A,[1AD7h] ; 9d27
	CP A,#00h ; 9d2b
	JRS Z,loc_0x009D36 ; 9d2d
	LD BA,#976Ah ; 9d2f
	CARL loc_0x00A97D ; 9d32
	RET
; ---------------------- ; 9d35
loc_0x009D36:
	LD BA,#9634h ; 9d36
	CARL loc_0x00A97D ; 9d39
	LD BA,[1B12h] ; 9d3c
	CARL loc_0x007982 ; 9d3f
	LD A,#20h ; 9d42
	LD [1B1Eh],A ; 9d44
	LD A,#05h ; 9d48
	LD [1B20h],A ; 9d4a
	RET
; ---------------------- ; 9d4e
loc_0x009D4F:
	RETS
; ---------------------- ; 9d4f
loc_0x009D50:
	LD A,[1AD8h] ; 9d50
	CP A,#00h ; 9d54
	JRS NZ,loc_0x009DBC ; 9d56
	CARL loc_0x00AA46 ; 9d58
	JRS Z,loc_0x009DBC ; 9d5b
	LD A,[1AD7h] ; 9d5d
	CP A,#00h ; 9d61
	JRS Z,loc_0x009DA7 ; 9d63
	CP A,#01h ; 9d65
	JRS Z,loc_0x009D84 ; 9d67
	LD A,[1B13h] ; 9d69
	CP A,#10h ; 9d6d
	JRS NZ,loc_0x009DBC ; 9d6f
	LD A,#04h ; 9d71
	LD [1B1Eh],A ; 9d73
	LD A,#07h ; 9d77
	LD [1B20h],A ; 9d79
	LD BA,#9371h ; 9d7d
	CARL loc_0x00A97D ; 9d80
	RET
; ---------------------- ; 9d83
loc_0x009D84:
	LD A,[1B13h] ; 9d84
	CP A,#10h ; 9d88
	JRS NZ,loc_0x009DBC ; 9d8a
	LD A,[1B12h] ; 9d8c
	CP A,#15h ; 9d90
	JRS NC,loc_0x009DBC ; 9d92
	LD A,#04h ; 9d94
	LD [1B1Eh],A ; 9d96
	LD A,#07h ; 9d9a
	LD [1B20h],A ; 9d9c
	LD BA,#9371h ; 9da0
	CARL loc_0x00A97D ; 9da3
	RET
; ---------------------- ; 9da6
loc_0x009DA7:
	LD A,[1B13h] ; 9da7
	CP A,#10h ; 9dab
	JRS NZ,loc_0x009DBC ; 9dad
	LD A,#25h ; 9daf
	LD [1B1Eh],A ; 9db1
	LD BA,#923Dh ; 9db5
	CARL loc_0x00A97D ; 9db8
	RET
; ---------------------- ; 9dbb
loc_0x009DBC:
	RETS
; ---------------------- ; 9dbc
loc_0x009DBD:
	CARL loc_0x009D22 ; 9dbd
	JRS loc_0x009DDC
; ---------------------- ; 9dc0
loc_0x009DC2:
	CARL loc_0x009C26 ; 9dc2
	JRS loc_0x009DDC
; ---------------------- ; 9dc5
loc_0x009DC7:
	CARL loc_0x009C73 ; 9dc7
	JRS loc_0x009DDC
; ---------------------- ; 9dca
	DB 0F2h, 88h, 0FEh, 0F1h, 0Ch, 0F2h, 93h, 0FEh ; 9dcc
	DB 0F1h, 07h, 0F2h ; 9dd4
	ASCII "x" ; 9dd7
	DB 0FFh, 0F1h, 02h, 0FAh
; ---------------------- ; 9dd8
loc_0x009DDC:
	RET
; ---------------------- ; 9ddc
loc_0x009DDD:
	CARL loc_0x009DBD ; 9ddd
	NOP ; 9de0
	RET
; ---------------------- ; 9de1
	DB 0F8h
; ---------------------- ; 9de2
loc_0x009DE3:
	LD HL,#1B20h ; 9de3
	LD A,[HL] ; 9de6
	LD [HL],#00h ; 9de7
	CP A,#07h ; 9de9
	JRS Z,loc_0x009E0F ; 9deb
	CP A,#06h ; 9ded
	JRS Z,loc_0x009E1F ; 9def
	CP A,#05h ; 9df1
	JRS Z,loc_0x009E23 ; 9df3
	CP A,#02h ; 9df5
	JRS Z,loc_0x009E2F ; 9df7
	CP A,#04h ; 9df9
	JRS Z,loc_0x009E47 ; 9dfb
	CP A,#03h ; 9dfd
	JRS Z,loc_0x009E57 ; 9dff
	CP A,#01h ; 9e01
	JRS NZ,loc_0x009E51 ; 9e03
	LD NB,#02h ; 9e05
	CARL loc_0x012FFB ; 9e08
	LD BA,#8DFEh ; 9e0b
	RET
; ---------------------- ; 9e0e
loc_0x009E0F:
	LD A,[1AD7h] ; 9e0f
	CP A,#02h ; 9e13
	JRS Z,loc_0x009E1B ; 9e15
	LD BA,#949Eh ; 9e17
	RET
; ---------------------- ; 9e1a
loc_0x009E1B:
	LD BA,#93BBh ; 9e1b
	RET
; ---------------------- ; 9e1e
loc_0x009E1F:
	LD BA,#8DB5h ; 9e1f
	RET
; ---------------------- ; 9e22
loc_0x009E23:
	LD A,[1AD7h] ; 9e23
	CP A,#02h ; 9e27
	JRS Z,loc_0x009E3D ; 9e29
	LD BA,#965Eh ; 9e2b
	RET
; ---------------------- ; 9e2e
loc_0x009E2F:
	LD NB,#02h ; 9e2f
	CARL loc_0x012FFB ; 9e32
	LD A,[1AD7h] ; 9e35
	CP A,#02h ; 9e39
	JRS NZ,loc_0x009E43 ; 9e3b
loc_0x009E3D:
	LD A,#29h ; 9e3d
	LD [1B13h],A ; 9e3f
loc_0x009E43:
	LD BA,#960Ah ; 9e43
	RET
; ---------------------- ; 9e46
loc_0x009E47:
	LD NB,#02h ; 9e47
	CARL loc_0x012FFB ; 9e4a
	LD BA,#8EE4h ; 9e4d
	RET
; ---------------------- ; 9e50
loc_0x009E51:
	LD NB,#02h ; 9e51
	CARL loc_0x012FFB ; 9e54
loc_0x009E57:
	LD BA,#800Eh ; 9e57
	RET
; ---------------------- ; 9e5a
loc_0x009E5B:
	CARL loc_0x009C56 ; 9e5b
	RET
; ---------------------- ; 9e5e
	DB 0FFh
; ---------------------- ; 9e5f
	JRS loc_0x009E67
; ---------------------- ; 9e60
	DB 0F2h ; 9e62
	ASCII "Y" ; 9e63
	DB 0FFh, 0FFh, 0F8h
; ---------------------- ; 9e64
loc_0x009E67:
	CARL loc_0x00ABDA ; 9e67
	LD HL,#1B12h ; 9e6a
	SUB [HL],A ; 9e6d
	JRS NC,loc_0x009E73 ; 9e6f
	XOR A,A ; 9e71
	LD [HL],A ; 9e72
loc_0x009E73:
	LD A,[HL] ; 9e73
	LD B,[1B1Eh] ; 9e74
	CP A,B ; 9e78
	JRS Z,loc_0x009E7D ; 9e79
	JRS NC,loc_0x009E87 ; 9e7b
loc_0x009E7D:
	LD [1B12h],B ; 9e7d
	CARL loc_0x009DE3 ; 9e81
	CARL loc_0x00A97D ; 9e84
loc_0x009E87:
	LD BA,[1B12h] ; 9e87
	CARL loc_0x007982 ; 9e8a
	RET
; ---------------------- ; 9e8d
loc_0x009E8E:
	CARL loc_0x009C56 ; 9e8e
	RET
; ---------------------- ; 9e91
loc_0x009E92:
	NOP ; 9e92
	JRS loc_0x009E9A
; ---------------------- ; 9e93
	DB 0F2h, 26h, 0FFh, 0FFh, 0F8h
; ---------------------- ; 9e95
loc_0x009E9A:
	CARL loc_0x00ABDA ; 9e9a
	LD HL,#1B12h ; 9e9d
	ADD A,[HL] ; 9ea0
	CP A,#50h ; 9ea1
	JRS C,loc_0x009EA7 ; 9ea3
	LD A,#50h ; 9ea5
loc_0x009EA7:
	LD [1B12h],A ; 9ea7
	CARL loc_0x00AA62 ; 9eab
	JRS Z,loc_0x009EC4 ; 9eae
	LD [1B12h],B ; 9eb0
	LD A,[1B20h] ; 9eb4
	CP A,#04h ; 9eb8
	JRS Z,loc_0x009ED3 ; 9eba
	LD A,#00h ; 9ebc
	LD [1B20h],A ; 9ebe
	JRS loc_0x009ED3
; ---------------------- ; 9ec2
loc_0x009EC4:
	LD A,[1B12h] ; 9ec4
	LD B,[1B1Eh] ; 9ec8
	CP A,B ; 9ecc
	JRS C,loc_0x009ED9 ; 9ecd
	LD [1B12h],B ; 9ecf
loc_0x009ED3:
	CARL loc_0x009DE3 ; 9ed3
	CARL loc_0x00A97D ; 9ed6
loc_0x009ED9:
	LD BA,[1B12h] ; 9ed9
	CARL loc_0x007982 ; 9edc
	RET
; ---------------------- ; 9edf
loc_0x009EE0:
	CARL loc_0x009C56 ; 9ee0
	RET
; ---------------------- ; 9ee3
	DB 0FFh, 0F1h, 06h, 0F2h, 0D4h, 0FEh, 0FFh, 0F8h
; ---------------------- ; 9ee4
loc_0x009EEC:
	LD A,[1B1Eh] ; 9eec
	LD B,[1B12h] ; 9ef0
	CP A,B ; 9ef4
	JRS Z,loc_0x009EFE ; 9ef5
	DEC B ; 9ef7
	LD [1B12h],B ; 9ef8
	JRS loc_0x009F04
; ---------------------- ; 9efc
loc_0x009EFE:
	CARL loc_0x009DE3 ; 9efe
	CARL loc_0x00A97D ; 9f01
loc_0x009F04:
	LD BA,[1B12h] ; 9f04
	CARL loc_0x007982 ; 9f07
	RET
; ---------------------- ; 9f0a
	DB 0F2h ; 9f0b
	ASCII "I" ; 9f0c
	DB 0FDh, 0F8h, 0FFh, 0F1h, 06h, 0F2h, 0A9h, 0FEh ; 9f0d
	DB 0FFh, 0F8h
; ---------------------- ; 9f15
loc_0x009F17:
	LD A,[1B1Eh] ; 9f17
	LD B,[1B12h] ; 9f1b
	CP A,B ; 9f1f
	JRS Z,loc_0x009F3E ; 9f20
	INC B ; 9f22
	LD [1B12h],B ; 9f23
	CARL loc_0x00AA62 ; 9f27
	JRS Z,loc_0x009F44 ; 9f2a
	LD [1B12h],B ; 9f2c
	LD A,[1B20h] ; 9f30
	CP A,#04h ; 9f34
	JRS Z,loc_0x009F3E ; 9f36
	LD A,#00h ; 9f38
	LD [1B20h],A ; 9f3a
loc_0x009F3E:
	CARL loc_0x009DE3 ; 9f3e
	CARL loc_0x00A97D ; 9f41
loc_0x009F44:
	LD BA,[1B12h] ; 9f44
	CARL loc_0x007982 ; 9f47
	RET
; ---------------------- ; 9f4a
	DB 0F2h, 09h, 0FDh, 0F8h, 0FFh, 0F1h, 06h, 0F2h ; 9f4b
	ASCII "i" ; 9f53
	DB 0FEh, 0F8h, 0FFh
; ---------------------- ; 9f54
loc_0x009F57:
	LD A,[1B1Eh] ; 9f57
	LD B,[1B12h] ; 9f5b
	CP A,B ; 9f5f
	JRS Z,loc_0x009F71 ; 9f60
	LD A,[1671h] ; 9f62
	BIT A,#01h ; 9f66
	JRS NZ,loc_0x009F6F ; 9f68
	DEC B ; 9f6a
	LD [1B12h],B ; 9f6b
loc_0x009F6F:
	JRS loc_0x009F77
; ---------------------- ; 9f6f
loc_0x009F71:
	CARL loc_0x009DE3 ; 9f71
	CARL loc_0x00A97D ; 9f74
loc_0x009F77:
	LD BA,[1B12h] ; 9f77
	CARL loc_0x007982 ; 9f7a
	RET
; ---------------------- ; 9f7d
	DB 0F2h, 0D6h, 0FCh, 0F8h, 0FFh, 0F1h, 06h, 0F2h ; 9f7e
	ASCII "6" ; 9f86
	DB 0FEh, 0FFh, 0F8h
; ---------------------- ; 9f87
loc_0x009F8A:
	LD A,[1B1Eh] ; 9f8a
	LD B,[1B12h] ; 9f8e
	CP A,B ; 9f92
	JRS Z,loc_0x009FB9 ; 9f93
	LD A,[1671h] ; 9f95
	BIT A,#01h ; 9f99
	JRS NZ,loc_0x009FA2 ; 9f9b
	INC B ; 9f9d
	LD [1B12h],B ; 9f9e
loc_0x009FA2:
	CARL loc_0x00AA62 ; 9fa2
	JRS Z,loc_0x009FBF ; 9fa5
	LD [1B12h],B ; 9fa7
	LD A,[1B20h] ; 9fab
	CP A,#04h ; 9faf
	JRS Z,loc_0x009FB9 ; 9fb1
	LD A,#00h ; 9fb3
	LD [1B20h],A ; 9fb5
loc_0x009FB9:
	CARL loc_0x009DE3 ; 9fb9
	CARL loc_0x00A97D ; 9fbc
loc_0x009FBF:
	LD BA,[1B12h] ; 9fbf
	CARL loc_0x007982 ; 9fc2
	RET
; ---------------------- ; 9fc5
loc_0x009FC6:
	CARL loc_0x009DBD ; 9fc6
	NOP ; 9fc9
	RET
; ---------------------- ; 9fca
loc_0x009FCB:
	RET
; ---------------------- ; 9fcb
loc_0x009FCC:
	CARL loc_0x009C56 ; 9fcc
	RET
; ---------------------- ; 9fcf
loc_0x009FD0:
	NOP ; 9fd0
	LD A,[1B13h] ; 9fd1
	CP A,#18h ; 9fd5
	JRS NZ,loc_0x009FE0 ; 9fd7
	LD BA,#800Eh ; 9fd9
	CARL loc_0x00A97D ; 9fdc
	RET
; ---------------------- ; 9fdf
loc_0x009FE0:
	DEC A ; 9fe0
	LD [1B13h],A ; 9fe1
	LD BA,[1B12h] ; 9fe5
	CARL loc_0x007982 ; 9fe8
	RET
; ---------------------- ; 9feb
loc_0x009FEC:
	CARL loc_0x009C26 ; 9fec
	JRS loc_0x00A00F
; ---------------------- ; 9fef
loc_0x009FF1:
	CARL loc_0x009B56 ; 9ff1
	JRS NZ,loc_0x009FFD ; 9ff4
	LD BA,#800Eh ; 9ff6
	CARL loc_0x00A97D ; 9ff9
	RET
; ---------------------- ; 9ffc
loc_0x009FFD:
	LD A,[1B17h] ; 9ffd
	CP A,#02h ; 0a001
	JRS NZ,loc_0x00A00C ; 0a003
	LD BA,#829Eh ; 0a005
	CARL loc_0x00A97D ; 0a008
	RET
; ---------------------- ; 0a00b
loc_0x00A00C:
	CARL loc_0x00A010 ; 0a00c
loc_0x00A00F:
	RET
; ---------------------- ; 0a00f
loc_0x00A010:
	LD A,[1642h] ; 0a010
	BIT A,#60h ; 0a014
	JRS Z,loc_0x00A044 ; 0a016
	LD HL,#1B18h ; 0a018
	INC [HL] ; 0a01b
	LD A,[HL] ; 0a01c
	CP A,#08h ; 0a01d
	JRS C,loc_0x00A03E ; 0a01f
	LD [HL],#00h ; 0a021
	LD NB,#02h ; 0a023
	CARL loc_0x012F7C ; 0a026
	LD A,[1AD6h] ; 0a029
	OR A,A ; 0a02d
	JRS NZ,loc_0x00A035 ; 0a02e
	CARL loc_0x009ABE ; 0a030
	JRS NZ,loc_0x00A03E ; 0a033
loc_0x00A035:
	LD NB,#02h ; 0a035
	CARL loc_0x012FF6 ; 0a038
	CARL loc_0x00C0E9 ; 0a03b
loc_0x00A03E:
	LD BA,#82DBh ; 0a03e
	CARL loc_0x00A97D ; 0a041
loc_0x00A044:
	RET
; ---------------------- ; 0a044
loc_0x00A045:
	LD A,[1B17h] ; 0a045
	CP A,#02h ; 0a049
	JRS Z,loc_0x00A062 ; 0a04b
	CARL loc_0x009D22 ; 0a04d
	JRS loc_0x00A062
; ---------------------- ; 0a050
	DB 0F2h, 1Fh, 0FCh, 0F1h, 0Ch, 0F2h, 0F7h, 0FCh ; 0a052
	DB 0F1h, 07h, 0C4h, 0Eh, 80h, 0F2h, 1Ch, 09h
; ---------------------- ; 0a05a
loc_0x00A062:
	LD BA,[1B12h] ; 0a062
	CARL loc_0x007982 ; 0a065
	RET
; ---------------------- ; 0a068
loc_0x00A069:
	XOR A,A ; 0a069
	LD [1AE8h],A ; 0a06a
	CARL loc_0x009D22 ; 0a06e
	JRS loc_0x00A0AD
; ---------------------- ; 0a071
loc_0x00A073:
	CARL loc_0x009C56 ; 0a073
loc_0x00A076:
	JRS loc_0x00A0BA
; ---------------------- ; 0a076
loc_0x00A078:
	CARL loc_0x00AAFE ; 0a078
	JRS NZ,loc_0x00A0BB ; 0a07b
	CARL loc_0x009D09 ; 0a07d
	JRS loc_0x00A0AD
; ---------------------- ; 0a080
loc_0x00A082:
	CARL loc_0x009D50 ; 0a082
	JRS loc_0x00A0AD
; ---------------------- ; 0a085
loc_0x00A087:
	LD A,[1AD8h] ; 0a087
	CP A,#01h ; 0a08b
	JRS Z,loc_0x00A0A7 ; 0a08d
	LD A,[1AD7h] ; 0a08f
	CP A,#02h ; 0a093
	JRS NZ,loc_0x00A0A7 ; 0a095
	LD B,[1B23h] ; 0a097
	LD A,[1B13h] ; 0a09b
	CP A,B ; 0a09f
	JRS C,loc_0x00A0A7 ; 0a0a0
	LD BA,#9988h ; 0a0a2
	JRS loc_0x00A0AA
; ---------------------- ; 0a0a5
loc_0x00A0A7:
	LD BA,#800Eh ; 0a0a7
loc_0x00A0AA:
	CARL loc_0x00A97D ; 0a0aa
loc_0x00A0AD:
	LD A,[1AB6h] ; 0a0ad
	AND A,A ; 0a0b1
	JRS Z,loc_0x00A0BA ; 0a0b2
	LD A,#12h ; 0a0b4
	LD [14FAh],A ; 0a0b6
loc_0x00A0BA:
	RET
; ---------------------- ; 0a0ba
loc_0x00A0BB:
	CARL loc_0x009CD3 ; 0a0bb
	JRS loc_0x00A0AD
; ---------------------- ; 0a0be
loc_0x00A0C0:
	LD A,#01h ; 0a0c0
	LD [1AE8h],A ; 0a0c2
	LD HL,#1B13h ; 0a0c6
	INC [HL] ; 0a0c9
	LD BA,[1B12h] ; 0a0ca
	CARL loc_0x007982 ; 0a0cd
	RET
; ---------------------- ; 0a0d0
loc_0x00A0D1:
	CARL loc_0x009C56 ; 0a0d1
	JRS loc_0x00A0F6
; ---------------------- ; 0a0d4
loc_0x00A0D6:
	CARL loc_0x00AAFE ; 0a0d6
	JRS NZ,loc_0x00A0F7 ; 0a0d9
	LD A,[1B13h] ; 0a0db
	CP A,#10h ; 0a0df
	JRS Z,loc_0x00A0F7 ; 0a0e1
	LD A,[1AB6h] ; 0a0e3
	AND A,A ; 0a0e7
	JRS Z,loc_0x00A0F0 ; 0a0e8
	LD A,#12h ; 0a0ea
	LD [14FAh],A ; 0a0ec
loc_0x00A0F0:
	LD BA,#9993h ; 0a0f0
	CARL loc_0x00A97D ; 0a0f3
loc_0x00A0F6:
	RET
; ---------------------- ; 0a0f6
loc_0x00A0F7:
	LD HL,#1B13h ; 0a0f7
	INC [HL] ; 0a0fa
	LD BA,[1B12h] ; 0a0fb
	CARL loc_0x007982 ; 0a0fe
	RET
; ---------------------- ; 0a101
loc_0x00A102:
	CARL loc_0x009C56 ; 0a102
	JRS loc_0x00A132
; ---------------------- ; 0a105
loc_0x00A107:
	CARL loc_0x00AAFE ; 0a107
	JRS NZ,loc_0x00A133 ; 0a10a
	LD A,[1AB6h] ; 0a10c
	AND A,A ; 0a110
	JRS Z,loc_0x00A119 ; 0a111
	LD A,#12h ; 0a113
	LD [14FAh],A ; 0a115
loc_0x00A119:
	LD BA,#915Fh ; 0a119
	LD L,[IX+02h] ; 0a11c
	LD H,[IX+03h] ; 0a11f
	CP HL,#9173h ; 0a122
	JRS C,loc_0x00A12F ; 0a125
	CP HL,#91EAh ; 0a127
	JRS NC,loc_0x00A12F ; 0a12a
	LD BA,#91EAh ; 0a12c
loc_0x00A12F:
	CARL loc_0x00A97D ; 0a12f
loc_0x00A132:
	RET
; ---------------------- ; 0a132
loc_0x00A133:
	LD HL,#1B13h ; 0a133
	INC [HL] ; 0a136
	LD BA,[1B12h] ; 0a137
	CARL loc_0x007982 ; 0a13a
	RET
; ---------------------- ; 0a13d
loc_0x00A13E:
	CARL loc_0x009C56 ; 0a13e
	JRS loc_0x00A177
; ---------------------- ; 0a141
loc_0x00A143:
	PUSH IP ; 0a143
	PUSH IY ; 0a144
	LD A,[IX+14h] ; 0a145
	LD B,[IX+15h] ; 0a148
	LD IY,BA ; 0a14b
	LD A,[IX+16h] ; 0a14d
	LD YP,A ; 0a150
	LD A,[IY] ; 0a152
	ADD A,[IX+0Ah] ; 0a153
	LD [1B12h],A ; 0a156
	INC IY ; 0a15a
	LD A,[IY] ; 0a15b
	ADD A,[IX+0Eh] ; 0a15c
	LD [1B13h],A ; 0a15f
	POP IY ; 0a163
	POP IP ; 0a164
	LD A,[1B13h] ; 0a165
	BIT A,#80h ; 0a169
	JRS Z,loc_0x00A177 ; 0a16b
	CP A,#0F0h ; 0a16d
	JRS NC,loc_0x00A177 ; 0a16f
	LD BA,#9339h ; 0a171
	CARL loc_0x00A97D ; 0a174
loc_0x00A177:
	RET
; ---------------------- ; 0a177
loc_0x00A178:
	CARL loc_0x009C56 ; 0a178
	JRS loc_0x00A180
; ---------------------- ; 0a17b
	DB 0F0h, 09h, 0F8h
; ---------------------- ; 0a17d
loc_0x00A180:
	LD NB,#02h ; 0a180
	CARL loc_0x0129A6 ; 0a183
	RET
; ---------------------- ; 0a186
loc_0x00A187:
	PUSH IP ; 0a187
	PUSH IY ; 0a188
	LD A,[IX+14h] ; 0a189
	LD B,[IX+15h] ; 0a18c
	LD IY,BA ; 0a18f
	LD A,[IX+16h] ; 0a191
	LD YP,A ; 0a194
	LD A,[IY] ; 0a196
	ADD A,[IX+0Ah] ; 0a197
	LD [1B12h],A ; 0a19a
	INC IY ; 0a19e
	LD A,[IY] ; 0a19f
	ADD A,[IX+0Eh] ; 0a1a0
	LD B,[1B23h] ; 0a1a3
	CP A,B ; 0a1a7
	JRS C,loc_0x00A1AB ; 0a1a8
	LD A,B ; 0a1aa
loc_0x00A1AB:
	LD [1B13h],A ; 0a1ab
	POP IY ; 0a1af
	POP IP ; 0a1b0
	RET
; ---------------------- ; 0a1b1
loc_0x00A1B2:
	CARL loc_0x009C56 ; 0a1b2
	JRS loc_0x00A1C6
; ---------------------- ; 0a1b5
loc_0x00A1B7:
	LD A,[1B28h] ; 0a1b7
	CP A,#03h ; 0a1bb
	JRS Z,loc_0x00A1D2 ; 0a1bd
	LD A,#0FFh ; 0a1bf
	LD [1AE8h],A ; 0a1c1
	RET
; ---------------------- ; 0a1c5
loc_0x00A1C6:
	XOR A,A ; 0a1c6
	LD [1AE8h],A ; 0a1c7
	LD NB,#02h ; 0a1cb
	CARL loc_0x0129A6 ; 0a1ce
	RET
; ---------------------- ; 0a1d1
loc_0x00A1D2:
	LD A,#00h ; 0a1d2
	LD [1B28h],A ; 0a1d4
	LD BA,#8CB0h ; 0a1d8
	CARL loc_0x00A97D ; 0a1db
	LD NB,#02h ; 0a1de
	CARL loc_0x0129A6 ; 0a1e1
	RET
; ---------------------- ; 0a1e4
loc_0x00A1E5:
	CARL loc_0x009C56 ; 0a1e5
	JRS loc_0x00A1F1
; ---------------------- ; 0a1e8
loc_0x00A1EA:
	LD A,#0FFh ; 0a1ea
	LD [1AE8h],A ; 0a1ec
	RET
; ---------------------- ; 0a1f0
loc_0x00A1F1:
	XOR A,A ; 0a1f1
	LD [1AE8h],A ; 0a1f2
	LD NB,#02h ; 0a1f6
	CARL loc_0x0129A6 ; 0a1f9
	RET
; ---------------------- ; 0a1fc
loc_0x00A1FD:
	CARL loc_0x009C56 ; 0a1fd
	JRS loc_0x00A202
; ---------------------- ; 0a200
loc_0x00A202:
	RET
; ---------------------- ; 0a202
	DB 0F2h ; 0a203
	ASCII "Q" ; 0a204
	DB 0FAh, 0F1h, 01h, 0F8h
; ---------------------- ; 0a205
loc_0x00A209:
	CARL loc_0x009C56 ; 0a209
	JRS loc_0x00A22E
; ---------------------- ; 0a20c
loc_0x00A20E:
	LD A,[1B1Eh] ; 0a20e
	LD B,[1B12h] ; 0a212
	CP A,B ; 0a216
	JRS Z,loc_0x00A220 ; 0a217
	DEC B ; 0a219
	LD [1B12h],B ; 0a21a
	JRS loc_0x00A226
; ---------------------- ; 0a21e
loc_0x00A220:
	LD BA,#9634h ; 0a220
	CARL loc_0x00A97D ; 0a223
loc_0x00A226:
	LD BA,[1B12h] ; 0a226
	DEC B ; 0a229
	DEC B ; 0a22a
	CARL loc_0x007982 ; 0a22b
loc_0x00A22E:
	RET
; ---------------------- ; 0a22e
loc_0x00A22F:
	CARL loc_0x009C56 ; 0a22f
	JRS loc_0x00A254
; ---------------------- ; 0a232
loc_0x00A234:
	LD A,[1B1Eh] ; 0a234
	LD B,[1B12h] ; 0a238
	CP A,B ; 0a23c
	JRS Z,loc_0x00A246 ; 0a23d
	INC B ; 0a23f
	LD [1B12h],B ; 0a240
	JRS loc_0x00A24C
; ---------------------- ; 0a244
loc_0x00A246:
	LD BA,#9634h ; 0a246
	CARL loc_0x00A97D ; 0a249
loc_0x00A24C:
	LD BA,[1B12h] ; 0a24c
	DEC B ; 0a24f
	DEC B ; 0a250
	CARL loc_0x007982 ; 0a251
loc_0x00A254:
	RET
; ---------------------- ; 0a254
loc_0x00A255:
	CARL loc_0x009C56 ; 0a255
	JRS loc_0x00A263
; ---------------------- ; 0a258
	DB 0C5h, 13h, 1Bh ; 0a25a
	ASCII "E2" ; 0a25d
	DB 14h, 0E5h, 02h, 86h
; ---------------------- ; 0a25f
loc_0x00A263:
	LD BA,[1B12h] ; 0a263
	CARL loc_0x007982 ; 0a266
	RET
; ---------------------- ; 0a269
loc_0x00A26A:
	CARL loc_0x009C56 ; 0a26a
	JRS loc_0x00A2AF
; ---------------------- ; 0a26d
loc_0x00A26F:
	LD A,[1671h] ; 0a26f
	AND A,#07h ; 0a273
	JRS NZ,loc_0x00A2AF ; 0a275
	LD B,[1B1Eh] ; 0a277
	CP B,#25h ; 0a27b
	JRS Z,loc_0x00A295 ; 0a27e
	LD A,[1B12h] ; 0a280
	CP A,B ; 0a284
	JRS Z,loc_0x00A28E ; 0a285
	DEC A ; 0a287
	LD [1B12h],A ; 0a288
	JRS loc_0x00A2AF
; ---------------------- ; 0a28c
loc_0x00A28E:
	LD BA,#9297h ; 0a28e
	CARL loc_0x00A97D ; 0a291
	RET
; ---------------------- ; 0a294
loc_0x00A295:
	LD A,[1B12h] ; 0a295
	CP A,B ; 0a299
	JRS NC,loc_0x00A2A3 ; 0a29a
	INC A ; 0a29c
	LD [1B12h],A ; 0a29d
	JRS loc_0x00A2AF
; ---------------------- ; 0a2a1
loc_0x00A2A3:
	LD A,#14h ; 0a2a3
	LD [1B1Eh],A ; 0a2a5
	LD BA,#9236h ; 0a2a9
	CARL loc_0x00A97D ; 0a2ac
loc_0x00A2AF:
	LD BA,[1B12h] ; 0a2af
	CARL loc_0x007982 ; 0a2b2
	RET
; ---------------------- ; 0a2b5
loc_0x00A2B6:
	CARL loc_0x009C56 ; 0a2b6
	JRS loc_0x00A2F3
; ---------------------- ; 0a2b9
loc_0x00A2BB:
	LD B,[1B1Eh] ; 0a2bb
	CP B,#25h ; 0a2bf
	JRS Z,loc_0x00A2D9 ; 0a2c2
	LD A,[1B12h] ; 0a2c4
	CP A,B ; 0a2c8
	JRS Z,loc_0x00A2D2 ; 0a2c9
	DEC A ; 0a2cb
	LD [1B12h],A ; 0a2cc
	JRS loc_0x00A2F3
; ---------------------- ; 0a2d0
loc_0x00A2D2:
	LD BA,#9297h ; 0a2d2
	CARL loc_0x00A97D ; 0a2d5
	RET
; ---------------------- ; 0a2d8
loc_0x00A2D9:
	LD A,[1B12h] ; 0a2d9
	CP A,B ; 0a2dd
	JRS NC,loc_0x00A2E7 ; 0a2de
	INC A ; 0a2e0
	LD [1B12h],A ; 0a2e1
	JRS loc_0x00A2F3
; ---------------------- ; 0a2e5
loc_0x00A2E7:
	LD A,#14h ; 0a2e7
	LD [1B1Eh],A ; 0a2e9
	LD BA,#922Eh ; 0a2ed
	CARL loc_0x00A97D ; 0a2f0
loc_0x00A2F3:
	LD BA,[1B12h] ; 0a2f3
	CARL loc_0x007982 ; 0a2f6
	RET
; ---------------------- ; 0a2f9
	DB 0F2h ; 0a2fa
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
loc_0x00A352:
	LD A,[1B12h] ; 0a352
	DEC A ; 0a356
	LD [1B12h],A ; 0a357
	CP A,#06h ; 0a35b
	JRS Z,loc_0x00A38D ; 0a35d
	CP A,#0Fh ; 0a35f
	JRS NC,loc_0x00A375 ; 0a361
	CP A,#0Dh ; 0a363
	JRS NC,loc_0x00A370 ; 0a365
	LD A,[1B13h] ; 0a367
	INC A ; 0a36b
	LD [1B13h],A ; 0a36c
loc_0x00A370:
	LD BA,#932Dh ; 0a370
	JRS loc_0x00A383
; ---------------------- ; 0a373
loc_0x00A375:
	LD A,[1B13h] ; 0a375
	DEC A ; 0a379
	LD [1B13h],A ; 0a37a
	LD BA,#92ABh ; 0a37e
	JRS loc_0x00A383
; ---------------------- ; 0a381
loc_0x00A383:
	CARL loc_0x00A97D ; 0a383
	LD BA,[1B12h] ; 0a386
	CARL loc_0x007982 ; 0a389
	RET
; ---------------------- ; 0a38c
loc_0x00A38D:
	LD BA,#92B4h ; 0a38d
	CARL loc_0x00A97D ; 0a390
	RET
; ---------------------- ; 0a393
loc_0x00A394:
	CARL loc_0x009C56 ; 0a394
	JRS loc_0x00A3D4
; ---------------------- ; 0a397
loc_0x00A399:
	LD A,[1B12h] ; 0a399
	DEC A ; 0a39d
	LD [1B12h],A ; 0a39e
	CP A,#06h ; 0a3a2
	JRS Z,loc_0x00A3DB ; 0a3a4
	CP A,#0Fh ; 0a3a6
	JRS NC,loc_0x00A3C2 ; 0a3a8
	CP A,#0Dh ; 0a3aa
	JRS NC,loc_0x00A3BD ; 0a3ac
	LD A,[1B13h] ; 0a3ae
	INC A ; 0a3b2
	INC A ; 0a3b3
	LD [1B13h],A ; 0a3b4
	LD BA,#8344h ; 0a3b8
	JRS loc_0x00A3D1
; ---------------------- ; 0a3bb
loc_0x00A3BD:
	LD BA,#9333h ; 0a3bd
	JRS loc_0x00A3D1
; ---------------------- ; 0a3c0
loc_0x00A3C2:
	LD A,[1B13h] ; 0a3c2
	DEC A ; 0a3c6
	DEC A ; 0a3c7
	LD [1B13h],A ; 0a3c8
	LD BA,#8DF8h ; 0a3cc
	JRS loc_0x00A3D1
; ---------------------- ; 0a3cf
loc_0x00A3D1:
	CARL loc_0x00A97D ; 0a3d1
loc_0x00A3D4:
	LD BA,[1B12h] ; 0a3d4
	CARL loc_0x007982 ; 0a3d7
	RET
; ---------------------- ; 0a3da
loc_0x00A3DB:
	LD BA,#92DBh ; 0a3db
	CARL loc_0x00A97D ; 0a3de
	RET
; ---------------------- ; 0a3e1
loc_0x00A3E2:
	CARL loc_0x009C56 ; 0a3e2
	JRS loc_0x00A421
; ---------------------- ; 0a3e5
loc_0x00A3E7:
	LD A,[1B12h] ; 0a3e7
	DEC A ; 0a3eb
	DEC A ; 0a3ec
	LD [1B12h],A ; 0a3ed
	CP A,#06h ; 0a3f1
	JRS Z,loc_0x00A428 ; 0a3f3
	CP A,#0Fh ; 0a3f5
	JRS NC,loc_0x00A410 ; 0a3f7
	CP A,#0Dh ; 0a3f9
	JRS NC,loc_0x00A40B ; 0a3fb
	LD A,[1B13h] ; 0a3fd
	INC A ; 0a401
	LD [1B13h],A ; 0a402
	LD BA,#9321h ; 0a406
	JRS loc_0x00A41E
; ---------------------- ; 0a409
loc_0x00A40B:
	LD BA,#931Bh ; 0a40b
	JRS loc_0x00A41E
; ---------------------- ; 0a40e
loc_0x00A410:
	LD A,[1B13h] ; 0a410
	DEC A ; 0a414
	LD [1B13h],A ; 0a415
	LD BA,#92FEh ; 0a419
	JRS loc_0x00A41E
; ---------------------- ; 0a41c
loc_0x00A41E:
	CARL loc_0x00A97D ; 0a41e
loc_0x00A421:
	LD BA,[1B12h] ; 0a421
	CARL loc_0x007982 ; 0a424
	RET
; ---------------------- ; 0a427
loc_0x00A428:
	LD BA,#9307h ; 0a428
	CARL loc_0x00A97D ; 0a42b
	RET
; ---------------------- ; 0a42e
loc_0x00A42F:
	CARL loc_0x009C56 ; 0a42f
	JRS loc_0x00A459
; ---------------------- ; 0a432
loc_0x00A434:
	LD A,[1B12h] ; 0a434
	DEC A ; 0a438
	LD [1B12h],A ; 0a439
	CP A,#0F0h ; 0a43d
	JRS Z,loc_0x00A452 ; 0a43f
	LD HL,#1B13h ; 0a441
	BIT A,#80h ; 0a444
	JRS NZ,loc_0x00A44C ; 0a446
	CP A,#02h ; 0a448
	JRS NC,loc_0x00A44F ; 0a44a
loc_0x00A44C:
	INC [HL] ; 0a44c
	JRS loc_0x00A459
; ---------------------- ; 0a44d
loc_0x00A44F:
	DEC [HL] ; 0a44f
	JRS loc_0x00A459
; ---------------------- ; 0a450
loc_0x00A452:
	LD BA,#9339h ; 0a452
	CARL loc_0x00A97D ; 0a455
	RET
; ---------------------- ; 0a458
loc_0x00A459:
	LD BA,[1B12h] ; 0a459
	CARL loc_0x007982 ; 0a45c
	RET
; ---------------------- ; 0a45f
loc_0x00A460:
	CARL loc_0x009C56 ; 0a460
	JRS loc_0x00A487
; ---------------------- ; 0a463
loc_0x00A465:
	LD A,[1B12h] ; 0a465
	DEC A ; 0a469
	LD [1B12h],A ; 0a46a
	CP A,#0F0h ; 0a46e
	JRS Z,loc_0x00A480 ; 0a470
	LD A,[1671h] ; 0a472
	AND A,#01h ; 0a476
	JRS Z,loc_0x00A487 ; 0a478
	LD HL,#1B13h ; 0a47a
	DEC [HL] ; 0a47d
	JRS loc_0x00A487
; ---------------------- ; 0a47e
loc_0x00A480:
	LD BA,#9339h ; 0a480
	CARL loc_0x00A97D ; 0a483
	RET
; ---------------------- ; 0a486
loc_0x00A487:
	LD BA,[1B12h] ; 0a487
	CARL loc_0x007982 ; 0a48a
	RET
; ---------------------- ; 0a48d
loc_0x00A48E:
	CARL loc_0x009C56 ; 0a48e
	JRS loc_0x00A4B6
; ---------------------- ; 0a491
loc_0x00A493:
	LD A,[1B12h] ; 0a493
	DEC A ; 0a497
	DEC A ; 0a498
	LD [1B12h],A ; 0a499
	CP A,#0F0h ; 0a49d
	JRS Z,loc_0x00A4AF ; 0a49f
	LD A,[1671h] ; 0a4a1
	AND A,#01h ; 0a4a5
	JRS NZ,loc_0x00A4B6 ; 0a4a7
	LD HL,#1B13h ; 0a4a9
	DEC [HL] ; 0a4ac
	JRS loc_0x00A4B6
; ---------------------- ; 0a4ad
loc_0x00A4AF:
	LD BA,#9339h ; 0a4af
	CARL loc_0x00A97D ; 0a4b2
	RET
; ---------------------- ; 0a4b5
loc_0x00A4B6:
	LD BA,[1B12h] ; 0a4b6
	CARL loc_0x007982 ; 0a4b9
	RET
; ---------------------- ; 0a4bc
loc_0x00A4BD:
	NOP ; 0a4bd
	CARL loc_0x009C56 ; 0a4be
	JRS loc_0x00A4FB
; ---------------------- ; 0a4c1
loc_0x00A4C3:
	CARL loc_0x00A187 ; 0a4c3
	LD A,[1B12h] ; 0a4c6
	CP A,#1Fh ; 0a4ca
	JRS Z,loc_0x00A4FB ; 0a4cc
	JRS NC,loc_0x00A4E1 ; 0a4ce
	LD B,A ; 0a4d0
	LD A,#1Fh ; 0a4d1
	SUB A,B ; 0a4d3
	SRL A ; 0a4d4
	OR A,A ; 0a4d6
	JRS NZ,loc_0x00A4DA ; 0a4d7
	INC A ; 0a4d9
loc_0x00A4DA:
	ADD A,B ; 0a4da
	LD [1B12h],A ; 0a4db
	JRS loc_0x00A4F5
; ---------------------- ; 0a4df
loc_0x00A4E1:
	SUB A,#1Fh ; 0a4e1
	SRL A ; 0a4e3
	OR A,A ; 0a4e5
	JRS NZ,loc_0x00A4E9 ; 0a4e6
	INC A ; 0a4e8
loc_0x00A4E9:
	LD B,A ; 0a4e9
	LD A,[1B12h] ; 0a4ea
	SUB A,B ; 0a4ee
	LD [1B12h],A ; 0a4ef
	JRS loc_0x00A4F5
; ---------------------- ; 0a4f3
loc_0x00A4F5:
	LD BA,[1B12h] ; 0a4f5
	CARL loc_0x007982 ; 0a4f8
loc_0x00A4FB:
	RET
; ---------------------- ; 0a4fb
loc_0x00A4FC:
	CARL loc_0x009C56 ; 0a4fc
	JRS loc_0x00A538
; ---------------------- ; 0a4ff
loc_0x00A501:
	CARL loc_0x00AA46 ; 0a501
	JRS NZ,loc_0x00A50D ; 0a504
	LD BA,#8335h ; 0a506
	CARL loc_0x00A97D ; 0a509
	RET
; ---------------------- ; 0a50c
loc_0x00A50D:
	LD A,[1B15h] ; 0a50d
	CP A,#07h ; 0a511
	JRS NZ,loc_0x00A538 ; 0a513
	LD A,#0Ah ; 0a515
	LD [1B26h],A ; 0a517
	LD A,#06h ; 0a51b
	LD [1B24h],A ; 0a51d
	XOR A,A ; 0a521
	LD [1B25h],A ; 0a522
	LD A,#00h ; 0a526
	LD [1B27h],A ; 0a528
	LD BA,#97C4h ; 0a52c
	CARL loc_0x00A97D ; 0a52f
	LD BA,#0A610h ; 0a532
	CARL loc_0x007948 ; 0a535
loc_0x00A538:
	RET
; ---------------------- ; 0a538
loc_0x00A539:
	CARL loc_0x009C56 ; 0a539
	JRS loc_0x00A5A0
; ---------------------- ; 0a53c
loc_0x00A53E:
	CARL loc_0x00AA46 ; 0a53e
	JRS Z,loc_0x00A599 ; 0a541
	CARL loc_0x00A6D5 ; 0a543
	LD A,[IX+14h] ; 0a546
	LD B,[IX+15h] ; 0a549
	CP BA,#0B434h ; 0a54c
	JRS Z,loc_0x00A599 ; 0a54f
	LD HL,#1B26h ; 0a551
	DEC [HL] ; 0a554
	JRS NZ,loc_0x00A5A0 ; 0a555
	LD HL,#1B27h ; 0a557
	LD A,[HL] ; 0a55a
	OR A,A ; 0a55b
	JRS Z,loc_0x00A582 ; 0a55c
	DEC [HL] ; 0a55e
	LD A,#06h ; 0a55f
	LD [1B26h],A ; 0a561
	LD [1B24h],A ; 0a565
	XOR A,A ; 0a569
	LD [1B25h],A ; 0a56a
	LD BA,#0A5A1h ; 0a56e
	CARL loc_0x007948 ; 0a571
	LD HL,#1B13h ; 0a574
	ADD [HL],#01h ; 0a577
	LD BA,[1B12h] ; 0a57a
	CARL loc_0x007982 ; 0a57d
	JRS loc_0x00A5A0
; ---------------------- ; 0a580
loc_0x00A582:
	LD A,#06h ; 0a582
	LD [1B26h],A ; 0a584
	LD [1B24h],A ; 0a588
	XOR A,A ; 0a58c
	LD [1B25h],A ; 0a58d
	LD BA,#0A610h ; 0a591
	CARL loc_0x007948 ; 0a594
	JRS loc_0x00A5A0
; ---------------------- ; 0a597
loc_0x00A599:
	LD BA,#97EEh ; 0a599
	CARL loc_0x00A97D ; 0a59c
	RET
; ---------------------- ; 0a59f
loc_0x00A5A0:
	RET
; ---------------------- ; 0a5a0
loc_0x00A5A1:
	CARL loc_0x009C56 ; 0a5a1
	JRS loc_0x00A60F
; ---------------------- ; 0a5a4
loc_0x00A5A6:
	LD A,[1B27h] ; 0a5a6
	CP A,#02h ; 0a5aa
	JRS Z,loc_0x00A5E8 ; 0a5ac
	CARL loc_0x00A6D5 ; 0a5ae
	LD A,[IX+14h] ; 0a5b1
	LD B,[IX+15h] ; 0a5b4
	CP BA,#0B434h ; 0a5b7
	JRS NZ,loc_0x00A5E8 ; 0a5ba
	LD A,#02h ; 0a5bc
	LD [1B27h],A ; 0a5be
	LD A,[1B24h] ; 0a5c2
	LD HL,#1B26h ; 0a5c6
	SUB A,[HL] ; 0a5c9
	BIT A,#80h ; 0a5ca
	JRS Z,loc_0x00A5CF ; 0a5cc
	XOR A,A ; 0a5ce
loc_0x00A5CF:
	ADD A,A ; 0a5cf
	LD [1B25h],A ; 0a5d0
	ADD A,#0Fh ; 0a5d4
	LD [1B26h],A ; 0a5d6
	LD BA,#0A677h ; 0a5da
	CARL loc_0x007948 ; 0a5dd
	LD BA,#97CEh ; 0a5e0
	CARL loc_0x00A97D ; 0a5e3
	JRS loc_0x00A60F
; ---------------------- ; 0a5e6
loc_0x00A5E8:
	LD HL,#1B26h ; 0a5e8
	DEC [HL] ; 0a5eb
	JRS NZ,loc_0x00A60F ; 0a5ec
	LD A,#06h ; 0a5ee
	LD [1B26h],A ; 0a5f0
	LD [1B24h],A ; 0a5f4
	XOR A,A ; 0a5f8
	LD [1B25h],A ; 0a5f9
	LD BA,#0A610h ; 0a5fd
	CARL loc_0x007948 ; 0a600
	LD HL,#1B13h ; 0a603
	SUB [HL],#01h ; 0a606
	LD BA,[1B12h] ; 0a609
	CARL loc_0x007982 ; 0a60c
loc_0x00A60F:
	RET
; ---------------------- ; 0a60f
loc_0x00A610:
	CARL loc_0x009C56 ; 0a610
	JRS loc_0x00A676
; ---------------------- ; 0a613
loc_0x00A615:
	LD A,[1B27h] ; 0a615
	CP A,#00h ; 0a619
	JRS NZ,loc_0x00A649 ; 0a61b
	CARL loc_0x00A6D5 ; 0a61d
	LD A,[IX+14h] ; 0a620
	LD B,[IX+15h] ; 0a623
	CP BA,#0B434h ; 0a626
	JRS NZ,loc_0x00A649 ; 0a629
	LD A,#01h ; 0a62b
	LD [1B27h],A ; 0a62d
	LD A,[1B24h] ; 0a631
	LD HL,#1B26h ; 0a635
	SUB A,[HL] ; 0a638
	JRS NC,loc_0x00A63C ; 0a639
	XOR A,A ; 0a63b
loc_0x00A63C:
	ADD A,A ; 0a63c
	LD [1B25h],A ; 0a63d
	LD BA,#97CEh ; 0a641
	CARL loc_0x00A97D ; 0a644
	JRS loc_0x00A656
; ---------------------- ; 0a647
loc_0x00A649:
	LD HL,#1B26h ; 0a649
	DEC [HL] ; 0a64c
	JRS NZ,loc_0x00A676 ; 0a64d
	LD A,[1B27h] ; 0a64f
	OR A,A ; 0a653
	JRS Z,loc_0x00A670 ; 0a654
loc_0x00A656:
	LD A,[1B25h] ; 0a656
	ADD A,#00h ; 0a65a
	CP A,#08h ; 0a65c
	JRS NC,loc_0x00A664 ; 0a65e
	LD A,#08h ; 0a660
	JRS loc_0x00A664
; ---------------------- ; 0a662
loc_0x00A664:
	LD [1B26h],A ; 0a664
	LD BA,#0A677h ; 0a668
	CARL loc_0x007948 ; 0a66b
	JRS loc_0x00A676
; ---------------------- ; 0a66e
loc_0x00A670:
	LD BA,#976Ah ; 0a670
	CARL loc_0x00A97D ; 0a673
loc_0x00A676:
	RET
; ---------------------- ; 0a676
loc_0x00A677:
	CARL loc_0x009C56 ; 0a677
	JRS loc_0x00A695
; ---------------------- ; 0a67a
loc_0x00A67C:
	CARL loc_0x00A6D5 ; 0a67c
	LD HL,#1B26h ; 0a67f
	DEC [HL] ; 0a682
	JRS Z,loc_0x00A696 ; 0a683
	LD A,[1671h] ; 0a685
	AND A,#01h ; 0a689
	LD HL,#1B13h ; 0a68b
	DEC [HL] ; 0a68e
	LD BA,[1B12h] ; 0a68f
	CARL loc_0x007982 ; 0a692
loc_0x00A695:
	RET
; ---------------------- ; 0a695
loc_0x00A696:
	LD BA,#97DEh ; 0a696
	CARL loc_0x00A97D ; 0a699
	RET
; ---------------------- ; 0a69c
loc_0x00A69D:
	CARL loc_0x009C56 ; 0a69d
	JRS loc_0x00A6D1
; ---------------------- ; 0a6a0
loc_0x00A6A2:
	CARL loc_0x00A6D5 ; 0a6a2
	LD HL,#1B13h ; 0a6a5
	LD A,[HL] ; 0a6a8
	CP A,#23h ; 0a6a9
	JRS Z,loc_0x00A6BB ; 0a6ab
	LD A,[1671h] ; 0a6ad
	AND A,#01h ; 0a6b1
	INC [HL] ; 0a6b3
	LD BA,[1B12h] ; 0a6b4
	CARL loc_0x007982 ; 0a6b7
	RET
; ---------------------- ; 0a6ba
loc_0x00A6BB:
	LD B,#04h ; 0a6bb
	LD A,[1B27h] ; 0a6bd
	CP A,#02h ; 0a6c1
	JRS NZ,loc_0x00A6C7 ; 0a6c3
	LD B,#02h ; 0a6c5
loc_0x00A6C7:
	LD [1B26h],B ; 0a6c7
	LD BA,#0A539h ; 0a6cb
	CARL loc_0x007948 ; 0a6ce
loc_0x00A6D1:
	RET
; ---------------------- ; 0a6d1
	DB 0F3h, 0A4h, 0FAh
; ---------------------- ; 0a6d2
loc_0x00A6D5:
	LD A,[1642h] ; 0a6d5
	BIT A,#01h ; 0a6d9
	JRS NZ,loc_0x00A6FE ; 0a6db
	LD A,[IX+14h] ; 0a6dd
	LD B,[IX+15h] ; 0a6e0
	CP BA,#0B42Ch ; 0a6e3
	JRS Z,loc_0x00A6ED ; 0a6e6
	CP BA,#0B430h ; 0a6e8
	JRS NZ,loc_0x00A71A ; 0a6eb
loc_0x00A6ED:
	LD BA,#97D4h ; 0a6ed
	CARL loc_0x00A97D ; 0a6f0
	LD BA,#0B434h ; 0a6f3
	LD [IX+14h],A ; 0a6f6
	LD [IX+15h],B ; 0a6f9
	JRS loc_0x00A71A
; ---------------------- ; 0a6fc
loc_0x00A6FE:
	LD A,[IX+14h] ; 0a6fe
	LD B,[IX+15h] ; 0a701
	CP BA,#0B434h ; 0a704
	JRS Z,loc_0x00A71A ; 0a707
	LD A,[IX+18h] ; 0a709
	LD B,[IX+19h] ; 0a70c
	CP BA,#97C4h ; 0a70f
	JRS Z,loc_0x00A71A ; 0a712
	LD BA,#97C4h ; 0a714
	CARL loc_0x00A97D ; 0a717
loc_0x00A71A:
	RET
; ---------------------- ; 0a71a
loc_0x00A71B:
	LD A,[1B66h] ; 0a71b
	OR A,A ; 0a71f
	JRS NZ,loc_0x00A735 ; 0a720
	LD HL,#1B67h ; 0a722
	INC [HL] ; 0a725
	LD A,[HL] ; 0a726
	CP A,#64h ; 0a727
	JRS C,loc_0x00A753 ; 0a729
	LD [HL],#00h ; 0a72b
	LD A,#01h ; 0a72d
	LD [1B66h],A ; 0a72f
	JRS loc_0x00A753
; ---------------------- ; 0a733
loc_0x00A735:
	LD HL,#1B67h ; 0a735
	LD A,[1B68h] ; 0a738
	CP A,[HL] ; 0a73c
	JRS Z,loc_0x00A742 ; 0a73d
	INC [HL] ; 0a73f
	JRS loc_0x00A753
; ---------------------- ; 0a740
loc_0x00A742:
	LD A,[1B66h] ; 0a742
	LD B,[1B69h] ; 0a746
	CP A,B ; 0a74a
	JRS Z,loc_0x00A772 ; 0a74b
	LD HL,#1B66h ; 0a74d
	INC [HL] ; 0a750
	JRS loc_0x00A753
; ---------------------- ; 0a751
loc_0x00A753:
	LD A,[1B67h] ; 0a753
	CARL loc_0x002575 ; 0a757
	ADD A,#40h ; 0a75a
	LD [1B64h],A ; 0a75c
	LD A,B ; 0a760
	ADD A,#40h ; 0a761
	LD [1B60h],A ; 0a763
	LD A,[1B66h] ; 0a767
	ADD A,#40h ; 0a76b
	LD [1B5Ch],A ; 0a76d
	RET
; ---------------------- ; 0a771
loc_0x00A772:
	CARL loc_0x00AC56 ; 0a772
	JRS NZ,loc_0x00A78F ; 0a775
	LD A,[1B69h] ; 0a777
	CP A,#09h ; 0a77b
	JRS NZ,loc_0x00A78F ; 0a77d
	LD HL,#96BAh ; 0a77f
	LD B,#03h ; 0a782
	PUSH IY ; 0a784
	CARL loc_0x00228F ; 0a785
	POP IY ; 0a788
	LD BR,#20h ; 0a789
	AND [BR:26h],#0BFh ; 0a78b
	RET
; ---------------------- ; 0a78e
loc_0x00A78F:
	LD A,[1643h] ; 0a78f
	BIT A,#01h ; 0a793
	JRS Z,loc_0x00A753 ; 0a795
	LD A,[1AB6h] ; 0a797
	AND A,A ; 0a79b
	JRS Z,loc_0x00A7A4 ; 0a79c
	LD A,#01h ; 0a79e
	LD [14FAh],A ; 0a7a0
loc_0x00A7A4:
	CARL loc_0x00AC56 ; 0a7a4
	JRS NZ,loc_0x00A7D3 ; 0a7a7
	LD A,[1AD7h] ; 0a7a9
	CP A,#00h ; 0a7ad
	JRS Z,loc_0x00A7BA ; 0a7af
	CP A,#01h ; 0a7b1
	JRS Z,loc_0x00A7BF ; 0a7b3
	LD HL,#99D6h ; 0a7b5
	JRS loc_0x00A7C2
; ---------------------- ; 0a7b8
loc_0x00A7BA:
	LD HL,#9345h ; 0a7ba
	JRS loc_0x00A7C2
; ---------------------- ; 0a7bd
loc_0x00A7BF:
	LD HL,#955Eh ; 0a7bf
loc_0x00A7C2:
	LD BA,HL ; 0a7c2
	CARL loc_0x00A97D ; 0a7c4
	LD A,#01h ; 0a7c7
	LD [IX+16h],A ; 0a7c9
	LD BA,[1B12h] ; 0a7cc
	CARL loc_0x007982 ; 0a7cf
	RET
; ---------------------- ; 0a7d2
loc_0x00A7D3:
	LD HL,#96BAh ; 0a7d3
	LD B,#03h ; 0a7d6
	PUSH IY ; 0a7d8
	CARL loc_0x00228F ; 0a7d9
	POP IY ; 0a7dc
	LD BR,#20h ; 0a7dd
	AND [BR:26h],#0BFh ; 0a7df
	RET
; ---------------------- ; 0a7e2
	DB 0B0h, 00h, 0CEh, 0D4h, 20h, 1Bh, 0F2h, 0D2h ; 0a7e3
	DB 0F5h, 0F1h, 0Dh, 0F2h, 0A9h, 0F4h, 0F1h, 08h ; 0a7eb
	DB 0F2h, 8Bh, 0F4h, 0F1h, 03h, 0F1h, 0Ah, 0B0h ; 0a7f3
	DB 24h, 0CEh, 0D4h, 1Bh, 1Bh, 0F3h, 0EFh, 00h ; 0a7fb
	DB 0C5h, 1Bh, 1Bh ; 0a803
	ASCII "E(" ; 0a806
	DB 0E6h, 05h, 8Eh, 0EFh, 8Dh, 00h
; ---------------------- ; 0a808
loc_0x00A80E:
	LD A,[1ADCh] ; 0a80e
	CP A,#02h ; 0a812
	JRS Z,loc_0x00A846 ; 0a814
	PUSH IP ; 0a816
	PUSH IX ; 0a817
	LD IX,#15AAh ; 0a818
	LD XP,#00h ; 0a81b
	CARL loc_0x004706 ; 0a81e
	LD A,[15ADh] ; 0a821
	POP IX ; 0a825
	POP IP ; 0a826
	CP A,#06h ; 0a827
	JRS C,loc_0x00A82F ; 0a829
	CP A,#12h ; 0a82b
	JRS C,loc_0x00A846 ; 0a82d
loc_0x00A82F:
	LD BA,#000Ah ; 0a82f
	LD NB,#03h ; 0a832
	CARL loc_0x018FFE ; 0a835
	OR A,A ; 0a838
	JRS NZ,loc_0x00A846 ; 0a839
	LD A,#24h ; 0a83b
	LD [1B1Bh],A ; 0a83d
	LD BA,#8BE0h ; 0a841
	JRS loc_0x00A897
; ---------------------- ; 0a844
loc_0x00A846:
	LD A,[1ADCh] ; 0a846
	CP A,#00h ; 0a84a
	JRS NZ,loc_0x00A860 ; 0a84c
	LD BA,#000Ah ; 0a84e
	LD NB,#03h ; 0a851
	CARL loc_0x018FFE ; 0a854
	OR A,A ; 0a857
	JRS NZ,loc_0x00A860 ; 0a858
	LD NB,#02h ; 0a85a
	CARL loc_0x01299E ; 0a85d
loc_0x00A860:
	PUSH IP ; 0a860
	PUSH IY ; 0a861
	LD IY,#0A8F8h ; 0a862
	LD YP,#00h ; 0a865
	LD A,[1ADCh] ; 0a868
	ADD A,A ; 0a86c
	LD B,#00h ; 0a86d
	ADD IY,BA ; 0a86f
	LD IY,[IY] ; 0a871
	LD BA,#000Ah ; 0a873
	LD NB,#03h ; 0a876
	CARL loc_0x018FFE ; 0a879
	LD B,A ; 0a87c
	ADD A,A ; 0a87d
	ADD A,B ; 0a87e
	LD B,#00h ; 0a87f
	ADD IY,BA ; 0a881
	LD A,[IY] ; 0a883
	INC IY ; 0a884
	LD [1B1Bh],A ; 0a885
	LD BA,[IY] ; 0a889
	POP IY ; 0a88b
	POP IP ; 0a88c
	LD L,[IX+18h] ; 0a88d
	LD H,[IX+19h] ; 0a890
	CP HL,BA ; 0a893
	JRS Z,loc_0x00A89A ; 0a895
loc_0x00A897:
	CARL loc_0x00A97D ; 0a897
loc_0x00A89A:
	LD L,[IX+18h] ; 0a89a
	LD H,[IX+19h] ; 0a89d
	CP HL,#80D2h ; 0a8a0
	JRS Z,loc_0x00A8E3 ; 0a8a3
	CP HL,#8126h ; 0a8a5
	JRS Z,loc_0x00A8C9 ; 0a8a8
	CP HL,#802Ah ; 0a8aa
	JRS Z,loc_0x00A8BF ; 0a8ad
	CP HL,#807Eh ; 0a8af
	JRS NZ,loc_0x00A8F1 ; 0a8b2
	LD HL,#1B12h ; 0a8b4
	LD A,[HL] ; 0a8b7
	CP A,#50h ; 0a8b8
	JRS NC,loc_0x00A8F1 ; 0a8ba
	INC [HL] ; 0a8bc
	JRS loc_0x00A8D8
; ---------------------- ; 0a8bd
loc_0x00A8BF:
	LD HL,#1B12h ; 0a8bf
	LD A,[HL] ; 0a8c2
	OR A,A ; 0a8c3
	JRS Z,loc_0x00A8F1 ; 0a8c4
	DEC [HL] ; 0a8c6
	JRS loc_0x00A8F1
; ---------------------- ; 0a8c7
loc_0x00A8C9:
	LD HL,#1B12h ; 0a8c9
	CARL loc_0x00ABDA ; 0a8cc
	ADD [HL],A ; 0a8cf
	LD A,[HL] ; 0a8d1
	CP A,#50h ; 0a8d2
	JRS C,loc_0x00A8D8 ; 0a8d4
	LD [HL],#50h ; 0a8d6
loc_0x00A8D8:
	CARL loc_0x00AA62 ; 0a8d8
	JRS Z,loc_0x00A8F1 ; 0a8db
	LD [1B12h],B ; 0a8dd
	JRS loc_0x00A8F1
; ---------------------- ; 0a8e1
loc_0x00A8E3:
	LD HL,#1B12h ; 0a8e3
	CARL loc_0x00ABDA ; 0a8e6
	SUB [HL],A ; 0a8e9
	JRS NC,loc_0x00A8F1 ; 0a8eb
	LD [HL],#00h ; 0a8ed
	JRS loc_0x00A8F1
; ---------------------- ; 0a8ef
loc_0x00A8F1:
	LD BA,[1B12h] ; 0a8f1
	CARL loc_0x007982 ; 0a8f4
	RET
; ---------------------- ; 0a8f7
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
	DB 0Ah, 0D9h, 81h, 0Ah, 0D9h, 81h
; ---------------------- ; 0a96d
loc_0x00A973:
	LD [IX+1Ah],A ; 0a973
	LD [IX+1Bh],B ; 0a976
	CARL loc_0x00794F ; 0a979
	RET
; ---------------------- ; 0a97c
loc_0x00A97D:
	LD [IX+18h],A ; 0a97d
	LD [IX+19h],B ; 0a980
	CARL loc_0x00794F ; 0a983
	RET
; ---------------------- ; 0a986
loc_0x00A987:
	LD A,[1643h] ; 0a987
	BIT A,#02h ; 0a98b
	JRS Z,loc_0x00A995 ; 0a98d
	LD BA,#800Eh ; 0a98f
	CARL loc_0x00A97D ; 0a992
loc_0x00A995:
	RET
; ---------------------- ; 0a995
loc_0x00A996:
	LD [1B37h],IX ; 0a996
	LD A,[1B12h] ; 0a999
	CP A,#50h ; 0a99d
	JRS C,loc_0x00A9AD ; 0a99f
	LD B,#50h ; 0a9a1
	CP A,#80h ; 0a9a3
	JRS C,loc_0x00A9A9 ; 0a9a5
	LD B,#00h ; 0a9a7
loc_0x00A9A9:
	LD [1B12h],B ; 0a9a9
loc_0x00A9AD:
	LD A,[1B13h] ; 0a9ad
	CP A,#30h ; 0a9b1
	JRS C,loc_0x00A9C1 ; 0a9b3
	LD B,#30h ; 0a9b5
	CP A,#80h ; 0a9b7
	JRS C,loc_0x00A9BD ; 0a9b9
	LD B,#00h ; 0a9bb
loc_0x00A9BD:
	LD [1B13h],B ; 0a9bd
loc_0x00A9C1:
	LD BA,#800Eh ; 0a9c1
	CARL loc_0x00A97D ; 0a9c4
	LD A,[1B2Ah] ; 0a9c7
	OR A,A ; 0a9cb
	JRS Z,loc_0x00A9D5 ; 0a9cc
	LD BA,#8D12h ; 0a9ce
	CARL loc_0x00A97D ; 0a9d1
	RET
; ---------------------- ; 0a9d4
loc_0x00A9D5:
	LD A,[1B2Bh] ; 0a9d5
	OR A,A ; 0a9d9
	JRS NZ,loc_0x00AA07 ; 0a9da
	LD A,[1B14h] ; 0a9dc
	OR A,A ; 0a9e0
	JRS Z,loc_0x00A9EA ; 0a9e1
	LD BA,#0AD0Fh ; 0a9e3
	CARL loc_0x00A973 ; 0a9e6
	RET
; ---------------------- ; 0a9e9
loc_0x00A9EA:
	LD A,[1B69h] ; 0a9ea
	CP A,#0FFh ; 0a9ee
	JRS Z,loc_0x00AA14 ; 0a9f0
	LD A,[1AE8h] ; 0a9f2
	CP A,#0FFh ; 0a9f6
	JRS NZ,loc_0x00AA06 ; 0a9f8
	LD BA,#254Ch ; 0a9fa
	LD [1B12h],BA ; 0a9fd
	LD BA,#8658h ; 0aa00
	CARL loc_0x00A97D ; 0aa03
loc_0x00AA06:
	RET
; ---------------------- ; 0aa06
loc_0x00AA07:
	LD A,#01h ; 0aa07
	LD [1B14h],A ; 0aa09
	LD BA,#0B6F7h ; 0aa0d
	CARL loc_0x00A973 ; 0aa10
	RET
; ---------------------- ; 0aa13
loc_0x00AA14:
	XOR A,A ; 0aa14
	LD [1B69h],A ; 0aa15
	LD HL,#9345h ; 0aa19
	LD A,[1AD7h] ; 0aa1c
	CP A,#00h ; 0aa20
	JRS Z,loc_0x00AA2E ; 0aa22
	LD HL,#955Eh ; 0aa24
	CP A,#01h ; 0aa27
	JRS Z,loc_0x00AA2E ; 0aa29
	LD HL,#99D6h ; 0aa2b
loc_0x00AA2E:
	LD BA,HL ; 0aa2e
	CARL loc_0x00A973 ; 0aa30
	RET
; ---------------------- ; 0aa33
	DB 96h, 0A9h, 01h, 19h, 9Bh, 01h, 17h, 9Bh ; 0aa34
	DB 00h ; 0aa3c
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
loc_0x00AA62:
	LD B,#18h ; 0aa62
	LD L,#43h ; 0aa64
	LD A,[1AD7h] ; 0aa66
	CP A,#00h ; 0aa6a
	JRS Z,loc_0x00AA7A ; 0aa6c
	LD B,#10h ; 0aa6e
	LD L,#40h ; 0aa70
	CP A,#01h ; 0aa72
	JRS Z,loc_0x00AA7A ; 0aa74
	LD B,#18h ; 0aa76
	LD L,#42h ; 0aa78
loc_0x00AA7A:
	LD A,[1B13h] ; 0aa7a
	CP A,B ; 0aa7e
	JRS NZ,loc_0x00AA8C ; 0aa7f
	LD B,L ; 0aa81
	LD A,[1B12h] ; 0aa82
	CP A,B ; 0aa86
	JRS C,loc_0x00AA8C ; 0aa87
	AND SC,#0FEh ; 0aa89
	RET
; ---------------------- ; 0aa8b
loc_0x00AA8C:
	OR SC,#01h ; 0aa8c
	RET
; ---------------------- ; 0aa8e
loc_0x00AA8F:
	LD A,[1AD8h] ; 0aa8f
	CP A,#00h ; 0aa93
	JRS NZ,loc_0x00AAC9 ; 0aa95
	CARL loc_0x00AA46 ; 0aa97
	JRS Z,loc_0x00AAC9 ; 0aa9a
	LD A,[1AD7h] ; 0aa9c
	CP A,#00h ; 0aaa0
	JRS Z,loc_0x00AAB2 ; 0aaa2
	CP A,#01h ; 0aaa4
	JRS NZ,loc_0x00AAC9 ; 0aaa6
	LD A,[1B13h] ; 0aaa8
	CP A,#23h ; 0aaac
	JRS NZ,loc_0x00AAC9 ; 0aaae
	JRS Z,loc_0x00AABA ; 0aab0
loc_0x00AAB2:
	LD A,[1B13h] ; 0aab2
	CP A,#25h ; 0aab6
	JRS NZ,loc_0x00AAC9 ; 0aab8
loc_0x00AABA:
	LD A,[1B12h] ; 0aaba
	CP A,#18h ; 0aabe
	JRS C,loc_0x00AAC9 ; 0aac0
	CP A,#2Eh ; 0aac2
	JRS NC,loc_0x00AAC9 ; 0aac4
	OR SC,#01h ; 0aac6
	RET
; ---------------------- ; 0aac8
loc_0x00AAC9:
	AND SC,#0FEh ; 0aac9
	RET
; ---------------------- ; 0aacb
loc_0x00AACC:
	LD A,[1AD8h] ; 0aacc
	CP A,#00h ; 0aad0
	JRS NZ,loc_0x00AAFB ; 0aad2
	CARL loc_0x00AA46 ; 0aad4
	JRS Z,loc_0x00AAFB ; 0aad7
	LD A,[1AD7h] ; 0aad9
	CP A,#02h ; 0aadd
	JRS NZ,loc_0x00AAFB ; 0aadf
	LD A,[1B13h] ; 0aae1
	LD B,[1B23h] ; 0aae5
	CP A,B ; 0aae9
	JRS NZ,loc_0x00AAFB ; 0aaea
	LD A,[1B12h] ; 0aaec
	CP A,#07h ; 0aaf0
	JRS C,loc_0x00AAFB ; 0aaf2
	CP A,#2Bh ; 0aaf4
	JRS NC,loc_0x00AAFB ; 0aaf6
	OR SC,#01h ; 0aaf8
	RET
; ---------------------- ; 0aafa
loc_0x00AAFB:
	AND SC,#0FEh ; 0aafb
	RET
; ---------------------- ; 0aafd
loc_0x00AAFE:
	CARL loc_0x00AA8F ; 0aafe
	JRS NZ,loc_0x00AB04 ; 0ab01
	RET
; ---------------------- ; 0ab03
loc_0x00AB04:
	LD A,[1B13h] ; 0ab04
	LD B,[1B23h] ; 0ab08
	CP A,B ; 0ab0c
	JRS NZ,loc_0x00AB12 ; 0ab0d
	OR SC,#01h ; 0ab0f
	RET
; ---------------------- ; 0ab11
loc_0x00AB12:
	LD A,[1AD8h] ; 0ab12
	CP A,#00h ; 0ab16
	JRS Z,loc_0x00AB1E ; 0ab18
	CARL loc_0x00ABC4 ; 0ab1a
	RET
; ---------------------- ; 0ab1d
loc_0x00AB1E:
	LD A,[1B13h] ; 0ab1e
	CP A,#03h ; 0ab22
	JRS NC,loc_0x00AB30 ; 0ab24
	LD A,[1B12h] ; 0ab26
	CP A,#3Ch ; 0ab2a
	JRS C,loc_0x00AB48 ; 0ab2c
	JRS loc_0x00AB4B
; ---------------------- ; 0ab2e
loc_0x00AB30:
	LD A,[1AD7h] ; 0ab30
	CP A,#00h ; 0ab34
	JRS Z,loc_0x00AB40 ; 0ab36
	CP A,#01h ; 0ab38
	JRS Z,loc_0x00AB44 ; 0ab3a
	CARL loc_0x00AB9C ; 0ab3c
	RET
; ---------------------- ; 0ab3f
loc_0x00AB40:
	CARL loc_0x00AB4E ; 0ab40
	RET
; ---------------------- ; 0ab43
loc_0x00AB44:
	CARL loc_0x00AB7A ; 0ab44
	RET
; ---------------------- ; 0ab47
loc_0x00AB48:
	AND SC,#0FEh ; 0ab48
	RET
; ---------------------- ; 0ab4a
loc_0x00AB4B:
	OR SC,#01h ; 0ab4b
	RET
; ---------------------- ; 0ab4d
loc_0x00AB4E:
	LD A,[1B13h] ; 0ab4e
	CP A,#10h ; 0ab52
	JRS Z,loc_0x00AB68 ; 0ab54
	CP A,#18h ; 0ab56
	JRS NZ,loc_0x00AB74 ; 0ab58
	LD A,[1B12h] ; 0ab5a
	CP A,#26h ; 0ab5e
	JRS C,loc_0x00AB74 ; 0ab60
	CP A,#44h ; 0ab62
	JRS C,loc_0x00AB77 ; 0ab64
	JRS loc_0x00AB74
; ---------------------- ; 0ab66
loc_0x00AB68:
	LD A,[1B12h] ; 0ab68
	CP A,#08h ; 0ab6c
	JRS C,loc_0x00AB74 ; 0ab6e
	CP A,#30h ; 0ab70
	JRS C,loc_0x00AB77 ; 0ab72
loc_0x00AB74:
	AND SC,#0FEh ; 0ab74
	RET
; ---------------------- ; 0ab76
loc_0x00AB77:
	OR SC,#01h ; 0ab77
	RET
; ---------------------- ; 0ab79
loc_0x00AB7A:
	LD A,[1B13h] ; 0ab7a
	CP A,#10h ; 0ab7e
	JRS NZ,loc_0x00AB96 ; 0ab80
	LD A,[1B12h] ; 0ab82
	CP A,#15h ; 0ab86
	JRS C,loc_0x00AB99 ; 0ab88
	LD A,[1B12h] ; 0ab8a
	CP A,#28h ; 0ab8e
	JRS C,loc_0x00AB96 ; 0ab90
	CP A,#41h ; 0ab92
	JRS C,loc_0x00AB99 ; 0ab94
loc_0x00AB96:
	AND SC,#0FEh ; 0ab96
	RET
; ---------------------- ; 0ab98
loc_0x00AB99:
	OR SC,#01h ; 0ab99
	RET
; ---------------------- ; 0ab9b
loc_0x00AB9C:
	LD A,[1B13h] ; 0ab9c
	CP A,#10h ; 0aba0
	JRS Z,loc_0x00ABB6 ; 0aba2
	CP A,#18h ; 0aba4
	JRS NZ,loc_0x00ABBE ; 0aba6
	LD A,[1B12h] ; 0aba8
	CP A,#20h ; 0abac
	JRS C,loc_0x00ABBE ; 0abae
	CP A,#43h ; 0abb0
	JRS C,loc_0x00ABC1 ; 0abb2
	JRS loc_0x00ABBE
; ---------------------- ; 0abb4
loc_0x00ABB6:
	LD A,[1B12h] ; 0abb6
	CP A,#15h ; 0abba
	JRS C,loc_0x00ABC1 ; 0abbc
loc_0x00ABBE:
	AND SC,#0FEh ; 0abbe
	RET
; ---------------------- ; 0abc0
loc_0x00ABC1:
	OR SC,#01h ; 0abc1
	RET
; ---------------------- ; 0abc3
loc_0x00ABC4:
	LD A,[1B13h] ; 0abc4
	CP A,#18h ; 0abc8
	JRS NZ,loc_0x00ABD4 ; 0abca
	LD A,[1B12h] ; 0abcc
	CP A,#18h ; 0abd0
	JRS C,loc_0x00ABD7 ; 0abd2
loc_0x00ABD4:
	AND SC,#0FEh ; 0abd4
	RET
; ---------------------- ; 0abd6
loc_0x00ABD7:
	OR SC,#01h ; 0abd7
	RET
; ---------------------- ; 0abd9
loc_0x00ABDA:
	LD B,#02h ; 0abda
	LD A,[1671h] ; 0abdc
	AND A,#03h ; 0abe0
	JRS Z,loc_0x00ABE5 ; 0abe2
	DEC B ; 0abe4
loc_0x00ABE5:
	LD A,B ; 0abe5
	RET
; ---------------------- ; 0abe6
loc_0x00ABE7:
	LD A,[1B15h] ; 0abe7
	CP A,#07h ; 0abeb
	JRS NZ,loc_0x00ABF5 ; 0abed
	LD A,#0FFh ; 0abef
	LD [1B21h],A ; 0abf1
loc_0x00ABF5:
	CARL loc_0x00A178 ; 0abf5
	RET
; ---------------------- ; 0abf8
loc_0x00ABF9:
	LD HL,#1B21h ; 0abf9
	LD A,[HL] ; 0abfc
	CP A,#0FEh ; 0abfd
	JRS NC,loc_0x00AC0B ; 0abff
	LD A,[1B15h] ; 0ac01
	CP A,#07h ; 0ac05
	JRS NZ,loc_0x00AC0B ; 0ac07
	LD [HL],#0FEh ; 0ac09
loc_0x00AC0B:
	CARL loc_0x00A178 ; 0ac0b
	RET
; ---------------------- ; 0ac0e
loc_0x00AC0F:
	CARL loc_0x00AA46 ; 0ac0f
	JRS Z,loc_0x00AC26 ; 0ac12
	LD A,[1B15h] ; 0ac14
	CP A,#07h ; 0ac18
	JRS NZ,loc_0x00AC22 ; 0ac1a
	LD BA,#9686h ; 0ac1c
	CARL loc_0x00A97D ; 0ac1f
loc_0x00AC22:
	CARL loc_0x00A178 ; 0ac22
	RET
; ---------------------- ; 0ac25
loc_0x00AC26:
	LD BA,#8335h ; 0ac26
	CARL loc_0x00A97D ; 0ac29
	RET
; ---------------------- ; 0ac2c
loc_0x00AC2D:
	LD A,[1B15h] ; 0ac2d
	CP A,#07h ; 0ac31
	JRS NZ,loc_0x00AC40 ; 0ac33
	XOR A,A ; 0ac35
	LD [1B21h],A ; 0ac36
	LD BA,#98A5h ; 0ac3a
	CARL loc_0x00A97D ; 0ac3d
loc_0x00AC40:
	CARL loc_0x00A178 ; 0ac40
	RET
; ---------------------- ; 0ac43
loc_0x00AC44:
	LD A,[1B15h] ; 0ac44
	CP A,#07h ; 0ac48
	JRS NZ,loc_0x00AC52 ; 0ac4a
	LD A,#0FFh ; 0ac4c
	LD [1B21h],A ; 0ac4e
loc_0x00AC52:
	CARL loc_0x00A178 ; 0ac52
	RET
; ---------------------- ; 0ac55
loc_0x00AC56:
	PUSH IP ; 0ac56
	PUSH IY ; 0ac57
	LD A,[1B69h] ; 0ac58
	DEC A ; 0ac5c
	LD B,#00h ; 0ac5d
	LD IY,#0AC70h ; 0ac5f
	LD YP,#00h ; 0ac62
	ADD IY,BA ; 0ac65
	LD A,[1AEAh] ; 0ac67
	AND A,[IY] ; 0ac6b
	XOR A,[IY] ; 0ac6c
	POP IY ; 0ac6d
	POP IP ; 0ac6e
	RET
; ---------------------- ; 0ac6f
	DB 01h, 03h, 07h, 0Fh, 1Fh, 3Fh, 7Fh, 0FFh ; 0ac70
	DB 0FFh ; 0ac78
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
	DB 0BCh, 12h, 1Bh, 0C4h, 82h, 0AFh, 0F1h, 5Eh
; ---------------------- ; 0b0b5
loc_0x00B0BD:
	LD A,[1B15h] ; 0b0bd
	CP A,#04h ; 0b0c1
	JRS Z,loc_0x00B0C9 ; 0b0c3
	CP A,#05h ; 0b0c5
	JRS NZ,loc_0x00B0CD ; 0b0c7
loc_0x00B0C9:
	CARL loc_0x00B1D5 ; 0b0c9
	RET
; ---------------------- ; 0b0cc
loc_0x00B0CD:
	LD A,[1642h] ; 0b0cd
	BIT A,#01h ; 0b0d1
	JRS Z,loc_0x00B118 ; 0b0d3
	CARL loc_0x00B16B ; 0b0d5
	JRS Z,loc_0x00B118 ; 0b0d8
	LD A,[1643h] ; 0b0da
	BIT A,#01h ; 0b0de
	CARL NZ,loc_0x00B11E ; 0b0e0
	LD A,[1B15h] ; 0b0e3
	CP A,#03h ; 0b0e7
	CARL Z,loc_0x00B140 ; 0b0e9
	LD A,[1643h] ; 0b0ec
	BIT A,#01h ; 0b0f0
	JRS Z,loc_0x00B100 ; 0b0f2
	CARL loc_0x00B7C7 ; 0b0f4
	OR A,A ; 0b0f7
	JRS NZ,loc_0x00B100 ; 0b0f8
	LD NB,#02h ; 0b0fa
	CARL loc_0x012940 ; 0b0fd
loc_0x00B100:
	LD HL,#0AF1Eh ; 0b100
	PUSH IP ; 0b103
	PUSH IY ; 0b104
	CARL loc_0x00B38E ; 0b105
	POP IY ; 0b108
	POP IP ; 0b109
	LD A,[1B11h] ; 0b10a
	CP A,B ; 0b10e
	JRS C,loc_0x00B114 ; 0b10f
	LD HL,#0AF26h ; 0b111
loc_0x00B114:
	LD BA,HL ; 0b114
	JRS loc_0x00B11A
; ---------------------- ; 0b116
loc_0x00B118:
	JRS loc_0x00B11D
; ---------------------- ; 0b118
loc_0x00B11A:
	CARL loc_0x00A973 ; 0b11a
loc_0x00B11D:
	RET
; ---------------------- ; 0b11d
loc_0x00B11E:
	LD A,[1B15h] ; 0b11e
	CP A,#03h ; 0b122
	JRS NZ,loc_0x00B127 ; 0b124
	RET
; ---------------------- ; 0b126
loc_0x00B127:
	CARL loc_0x009AAD ; 0b127
	JRS NZ,loc_0x00B13F ; 0b12a
	CARL loc_0x00C0E9 ; 0b12c
	LD A,[1ADCh] ; 0b12f
	CP A,#00h ; 0b133
	JRS Z,loc_0x00B13F ; 0b135
	LD NB,#02h ; 0b137
	CARL loc_0x012F8A ; 0b13a
	JRS loc_0x00B13F
; ---------------------- ; 0b13d
loc_0x00B13F:
	RET
; ---------------------- ; 0b13f
loc_0x00B140:
	LD A,[1642h] ; 0b140
	AND A,#78h ; 0b144
	JRS Z,loc_0x00B16A ; 0b146
	LD HL,#1B19h ; 0b148
	INC [HL] ; 0b14b
	LD A,[HL] ; 0b14c
	CP A,#24h ; 0b14d
	JRS C,loc_0x00B16A ; 0b14f
	LD [HL],#00h ; 0b151
	LD NB,#02h ; 0b153
	CARL loc_0x012F7C ; 0b156
	CARL loc_0x009A9C ; 0b159
	JRS NZ,loc_0x00B16A ; 0b15c
	LD NB,#02h ; 0b15e
	CARL loc_0x01298A ; 0b161
	LD NB,#02h ; 0b164
	CARL loc_0x013005 ; 0b167
loc_0x00B16A:
	RET
; ---------------------- ; 0b16a
loc_0x00B16B:
	LD A,[1AD7h] ; 0b16b
	OR A,A ; 0b16f
	JRS Z,loc_0x00B1BB ; 0b170
	DEC A ; 0b172
	JRS Z,loc_0x00B1A1 ; 0b173
	LD A,[1B11h] ; 0b175
	CP A,#08h ; 0b179
	JRS C,loc_0x00B19E ; 0b17b
	CP A,#20h ; 0b17d
	JRS C,loc_0x00B18F ; 0b17f
	LD A,[1B10h] ; 0b181
	CP A,#23h ; 0b185
	JRS C,loc_0x00B19E ; 0b187
	CP A,#3Ch ; 0b189
	JRS NC,loc_0x00B19E ; 0b18b
	JRS loc_0x00B19B
; ---------------------- ; 0b18d
loc_0x00B18F:
	LD A,[1B10h] ; 0b18f
	CP A,#2Ch ; 0b193
	JRS C,loc_0x00B19E ; 0b195
	CP A,#30h ; 0b197
	JRS NC,loc_0x00B19E ; 0b199
loc_0x00B19B:
	AND SC,#0FEh ; 0b19b
	RET
; ---------------------- ; 0b19d
loc_0x00B19E:
	OR SC,#01h ; 0b19e
	RET
; ---------------------- ; 0b1a0
loc_0x00B1A1:
	LD A,[1B10h] ; 0b1a1
	CP A,#25h ; 0b1a5
	JRS C,loc_0x00B1B8 ; 0b1a7
	CP A,#37h ; 0b1a9
	JRS NC,loc_0x00B1B8 ; 0b1ab
	LD A,[1B11h] ; 0b1ad
	CP A,#0Ch ; 0b1b1
	JRS C,loc_0x00B1B8 ; 0b1b3
	AND SC,#0FEh ; 0b1b5
	RET
; ---------------------- ; 0b1b7
loc_0x00B1B8:
	OR SC,#01h ; 0b1b8
	RET
; ---------------------- ; 0b1ba
loc_0x00B1BB:
	LD A,[1B10h] ; 0b1bb
	CP A,#1Eh ; 0b1bf
	JRS C,loc_0x00B1D2 ; 0b1c1
	CP A,#3Fh ; 0b1c3
	JRS NC,loc_0x00B1D2 ; 0b1c5
	LD A,[1B11h] ; 0b1c7
	CP A,#0Dh ; 0b1cb
	JRS C,loc_0x00B1D2 ; 0b1cd
	AND SC,#0FEh ; 0b1cf
	RET
; ---------------------- ; 0b1d1
loc_0x00B1D2:
	OR SC,#01h ; 0b1d2
	RET
; ---------------------- ; 0b1d4
loc_0x00B1D5:
	PUSH IP ; 0b1d5
	PUSH IY ; 0b1d6
	CARL loc_0x00B34E ; 0b1d7
	LD A,[1B11h] ; 0b1da
	CP A,B ; 0b1de
	JRS C,loc_0x00B229 ; 0b1df
	CARL loc_0x00B356 ; 0b1e1
	LD A,[1B11h] ; 0b1e4
	CP A,B ; 0b1e8
	JRS C,loc_0x00B20A ; 0b1e9
	CARL loc_0x00B35E ; 0b1eb
	LD HL,#0AD53h ; 0b1ee
	LD A,[1B10h] ; 0b1f1
	CP A,B ; 0b1f5
	JRS C,loc_0x00B252 ; 0b1f6
	CARL loc_0x00B366 ; 0b1f8
	LD HL,#0AD5Bh ; 0b1fb
	LD A,[1B10h] ; 0b1fe
	CP A,B ; 0b202
	JRS C,loc_0x00B252 ; 0b203
	LD HL,#0AD63h ; 0b205
	JRS loc_0x00B252
; ---------------------- ; 0b208
loc_0x00B20A:
	CARL loc_0x00B35E ; 0b20a
	LD HL,#0AD6Bh ; 0b20d
	LD A,[1B10h] ; 0b210
	CP A,B ; 0b214
	JRS C,loc_0x00B252 ; 0b215
	CARL loc_0x00B366 ; 0b217
	LD HL,#0AD15h ; 0b21a
	LD A,[1B10h] ; 0b21d
	CP A,B ; 0b221
	JRS C,loc_0x00B248 ; 0b222
	LD HL,#0AD84h ; 0b224
	JRS loc_0x00B252
; ---------------------- ; 0b227
loc_0x00B229:
	CARL loc_0x00B35E ; 0b229
	LD HL,#0AD8Ch ; 0b22c
	LD A,[1B10h] ; 0b22f
	CP A,B ; 0b233
	JRS C,loc_0x00B252 ; 0b234
	CARL loc_0x00B366 ; 0b236
	LD HL,#0AD94h ; 0b239
	LD A,[1B10h] ; 0b23c
	CP A,B ; 0b240
	JRS C,loc_0x00B252 ; 0b241
	LD HL,#0AD9Ch ; 0b243
	JRS loc_0x00B252
; ---------------------- ; 0b246
loc_0x00B248:
	LD A,[1642h] ; 0b248
	BIT A,#01h ; 0b24c
	JRS Z,loc_0x00B252 ; 0b24e
	CARS loc_0x00B25A ; 0b250
loc_0x00B252:
	LD BA,HL ; 0b252
	CARL loc_0x00A973 ; 0b254
	POP IY ; 0b257
	POP IP ; 0b258
	RET
; ---------------------- ; 0b259
loc_0x00B25A:
	CARL loc_0x00B36E ; 0b25a
	LD A,[1B10h] ; 0b25d
	ADD A,#06h ; 0b261
	CP A,B ; 0b263
	JRS C,loc_0x00B2A4 ; 0b264
	CARL loc_0x00B376 ; 0b266
	LD A,[1B10h] ; 0b269
	SUB A,#02h ; 0b26d
	CP A,B ; 0b26f
	JRS NC,loc_0x00B2A4 ; 0b270
	CARL loc_0x00B37E ; 0b272
	LD A,[1B11h] ; 0b275
	ADD A,#0Ah ; 0b279
	CP A,B ; 0b27b
	JRS C,loc_0x00B2A4 ; 0b27c
	CARL loc_0x00B386 ; 0b27e
	LD A,[1B11h] ; 0b281
	ADD A,#04h ; 0b285
	CP A,B ; 0b287
	JRS NC,loc_0x00B2A4 ; 0b288
	LD A,[1B80h] ; 0b28a
	OR A,A ; 0b28e
	JRS Z,loc_0x00B29B ; 0b28f
	CARL loc_0x00B2A5 ; 0b291
	JRS NZ,loc_0x00B29B ; 0b294
	LD HL,#0B01Eh ; 0b296
	JRS loc_0x00B2A4
; ---------------------- ; 0b299
loc_0x00B29B:
	LD A,#06h ; 0b29b
	LD [1B15h],A ; 0b29d
	LD HL,#0AD73h ; 0b2a1
loc_0x00B2A4:
	RET
; ---------------------- ; 0b2a4
loc_0x00B2A5:
	PUSH IP ; 0b2a5
	PUSH IX ; 0b2a6
	PUSH IY ; 0b2a7
	LD IX,#1AECh ; 0b2a8
	LD XP,#00h ; 0b2ab
	LD HL,#1B8Ah ; 0b2ae
	LD B,#07h ; 0b2b1
loc_0x00B2B3:
	LD [HL],[IX] ; 0b2b3
	INC IX ; 0b2b4
	INC HL ; 0b2b5
	DJR NZ,loc_0x00B2B3 ; 0b2b6
	LD IX,#15AAh ; 0b2b8
	LD XP,#00h ; 0b2bb
	CARL loc_0x004706 ; 0b2be
	LD IX,#15AFh ; 0b2c1
	LD XP,#00h ; 0b2c4
	CARL loc_0x00B2F0 ; 0b2c7
	LD IX,#1B83h ; 0b2ca
	LD A,[IX+00h] ; 0b2cd
	OR A,A ; 0b2d0
	JRS NZ,loc_0x00B2E6 ; 0b2d1
	LD A,[IX+01h] ; 0b2d3
	OR A,A ; 0b2d6
	JRS NZ,loc_0x00B2E6 ; 0b2d7
	LD A,[IX+02h] ; 0b2d9
	OR A,A ; 0b2dc
	JRS NZ,loc_0x00B2E6 ; 0b2dd
	LD A,[IX+03h] ; 0b2df
	CP A,#03h ; 0b2e2
	JRS C,loc_0x00B2EA ; 0b2e4
loc_0x00B2E6:
	AND SC,#0FEh ; 0b2e6
	JRS loc_0x00B2EC
; ---------------------- ; 0b2e8
loc_0x00B2EA:
	OR SC,#01h ; 0b2ea
loc_0x00B2EC:
	POP IY ; 0b2ec
	POP IX ; 0b2ed
	POP IP ; 0b2ee
	RET
; ---------------------- ; 0b2ef
loc_0x00B2F0:
	LD HL,#1B8Fh ; 0b2f0
	LD IY,#1B88h ; 0b2f3
	LD YP,#00h ; 0b2f6
	LD A,[IX] ; 0b2f9
	SUB A,[HL] ; 0b2fa
	DEC HL ; 0b2fb
	JRS NC,loc_0x00B301 ; 0b2fc
	INC [HL] ; 0b2fe
	ADD A,#3Ch ; 0b2ff
loc_0x00B301:
	LD [IY],A ; 0b301
	DEC IX ; 0b302
	DEC IY ; 0b303
	LD A,[IX] ; 0b304
	SUB A,[HL] ; 0b305
	DEC HL ; 0b306
	JRS NC,loc_0x00B30C ; 0b307
	INC [HL] ; 0b309
	ADD A,#3Ch ; 0b30a
loc_0x00B30C:
	LD [IY],A ; 0b30c
	DEC IX ; 0b30d
	DEC IY ; 0b30e
	LD A,[IX] ; 0b30f
	SUB A,[HL] ; 0b310
	DEC HL ; 0b311
	JRS NC,loc_0x00B317 ; 0b312
	INC [HL] ; 0b314
	ADD A,#18h ; 0b315
loc_0x00B317:
	LD [IY],A ; 0b317
	DEC IX ; 0b318
	DEC IY ; 0b319
	LD A,[IX] ; 0b31a
	SUB A,[HL] ; 0b31b
	DEC HL ; 0b31c
	JRS NC,loc_0x00B338 ; 0b31d
	PUSH IP ; 0b31f
	PUSH IY ; 0b320
	PUSH A ; 0b321
	LD A,[1B8Ah] ; 0b323
	LD B,[1B8Bh] ; 0b327
	LD NB,#07h ; 0b32b
	CARL loc_0x0387E2 ; 0b32e
	LD B,A ; 0b331
	POP A ; 0b332
	POP IY ; 0b334
	POP IP ; 0b335
	INC [HL] ; 0b336
	ADD A,B ; 0b337
loc_0x00B338:
	LD [IY],A ; 0b338
	DEC IX ; 0b339
	DEC IY ; 0b33a
	LD A,[IX] ; 0b33b
	SUB A,[HL] ; 0b33c
	DEC HL ; 0b33d
	JRS NC,loc_0x00B343 ; 0b33e
	INC [HL] ; 0b340
	ADD A,#0Ch ; 0b341
loc_0x00B343:
	LD [IY],A ; 0b343
	DEC IX ; 0b344
	DEC IY ; 0b345
	LD A,[IX] ; 0b346
	SUB A,[HL] ; 0b347
	JRS NC,loc_0x00B34C ; 0b348
	LD A,#0FFh ; 0b34a
loc_0x00B34C:
	LD [IY],A ; 0b34c
	RET
; ---------------------- ; 0b34d
loc_0x00B34E:
	LD IY,#0B353h ; 0b34e
	JRS loc_0x00B396
; ---------------------- ; 0b351
	DB 21h, 15h, 1Ah
; ---------------------- ; 0b353
loc_0x00B356:
	LD IY,#0B35Bh ; 0b356
	JRS loc_0x00B396
; ---------------------- ; 0b359
	ASCII "3(1"
; ---------------------- ; 0b35b
loc_0x00B35E:
	LD IY,#0B363h ; 0b35e
	JRS loc_0x00B396
; ---------------------- ; 0b361
	DB 1Dh, 20h, 23h
; ---------------------- ; 0b363
loc_0x00B366:
	LD IY,#0B36Bh ; 0b366
	JRS loc_0x00B396
; ---------------------- ; 0b369
	DB 3Eh ; 0b36b
	ASCII "98"
; ---------------------- ; 0b36c
loc_0x00B36E:
	LD IY,#0B373h ; 0b36e
	JRS loc_0x00B396
; ---------------------- ; 0b371
	DB 2Dh, 29h, 2Bh
; ---------------------- ; 0b373
loc_0x00B376:
	LD IY,#0B37Bh ; 0b376
	JRS loc_0x00B396
; ---------------------- ; 0b379
	ASCII "578"
; ---------------------- ; 0b37b
loc_0x00B37E:
	LD IY,#0B383h ; 0b37e
	JRS loc_0x00B396
; ---------------------- ; 0b381
	DB 2Fh, 25h ; 0b383
	ASCII "1" ; 0b385
loc_0x00B386:
	LD IY,#0B38Bh ; 0b386
	JRS loc_0x00B396
; ---------------------- ; 0b389
	DB 33h ; 0b38b
	DB 2Ah ; 0b38c
	DB 38h
; ---------------------- ; 0b38d
loc_0x00B38E:
	LD IY,#0B393h ; 0b38e
	JRS loc_0x00B396
; ---------------------- ; 0b391
	DB 2Ah, 22h, 2Ah
; ---------------------- ; 0b393
loc_0x00B396:
	LD A,[1AD7h] ; 0b396
	LD B,#00h ; 0b39a
	LD YP,#00h ; 0b39c
	ADD IY,BA ; 0b39f
	LD B,[IY] ; 0b3a1
	RET
; ---------------------- ; 0b3a2
	DB 7Bh, 0A7h, 0ABh, 0B3h, 0BDh, 0B3h, 0CFh, 0B3h ; 0b3a3
	DB 0D6h, 99h, 21h, 00h, 10h, 00h, 0Ah, 00h ; 0b3ab
	DB 28h, 0B9h, 0Ah, 00h ; 0b3b3
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
	DB 1Bh, 28h, 0E6h, 0Eh
; ---------------------- ; 0b68c
loc_0x00B690:
	LD HL,[1B37h] ; 0b690
	ADD HL,#001Ah ; 0b693
	LD BA,[HL] ; 0b696
	CP BA,#0AD13h ; 0b698
	JRS Z,loc_0x00B6A2 ; 0b69b
loc_0x00B69D:
	LD BA,#9B13h ; 0b69d
	JRS loc_0x00B6DA
; ---------------------- ; 0b6a0
loc_0x00B6A2:
	CARL loc_0x00AA46 ; 0b6a2
	JRS Z,loc_0x00B6C0 ; 0b6a5
	LD A,[1ADCh] ; 0b6a7
	CP A,#02h ; 0b6ab
	JRS Z,loc_0x00B6D7 ; 0b6ad
	CP A,#00h ; 0b6af
	JRS Z,loc_0x00B6C5 ; 0b6b1
	LD A,[1ADDh] ; 0b6b3
	CP A,#40h ; 0b6b7
	JRS C,loc_0x00B69D ; 0b6b9
	LD BA,#0B3E1h ; 0b6bb
	JRS loc_0x00B6DA
; ---------------------- ; 0b6be
loc_0x00B6C0:
	LD BA,#0B4F7h ; 0b6c0
	JRS loc_0x00B6DA
; ---------------------- ; 0b6c3
loc_0x00B6C5:
	LD A,[1ADDh] ; 0b6c5
	CP A,#40h ; 0b6c9
	JRS C,loc_0x00B6D2 ; 0b6cb
	LD BA,#0B679h ; 0b6cd
	JRS loc_0x00B6DA
; ---------------------- ; 0b6d0
loc_0x00B6D2:
	LD BA,#0B681h ; 0b6d2
	JRS loc_0x00B6DA
; ---------------------- ; 0b6d5
loc_0x00B6D7:
	LD BA,#0B3A3h ; 0b6d7
loc_0x00B6DA:
	LD L,[IX+18h] ; 0b6da
	LD H,[IX+19h] ; 0b6dd
	CP HL,BA ; 0b6e0
	JRS Z,loc_0x00B6ED ; 0b6e2
	LD [IX+18h],A ; 0b6e4
	LD [IX+19h],B ; 0b6e7
	CARL loc_0x00794F ; 0b6ea
loc_0x00B6ED:
	RET
; ---------------------- ; 0b6ed
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
	DB 0Eh, 0F8h
; ---------------------- ; 0b7c5
loc_0x00B7C7:
	PUSH ALE ; 0b7c7
	CARL loc_0x004245 ; 0b7c9
	LD [164Ah],BA ; 0b7cc
	POP ALE ; 0b7cf
	LD BA,[164Ah] ; 0b7d1
	RET
; ---------------------- ; 0b7d4
	DB 7Bh, 0A7h, 0DDh, 0B7h, 0EFh, 0B7h, 01h, 0B8h ; 0b7d5
	DB 0D6h, 99h, 21h, 00h, 10h, 00h, 05h, 00h ; 0b7dd
	DB 0B8h, 0B9h, 05h, 00h, 0D8h, 0B9h, 0C1h, 99h ; 0b7e5
	DB 0DDh, 0B7h, 0D6h, 99h, 1Bh, 00h, 10h, 00h ; 0b7ed
	DB 05h, 00h ; 0b7f5
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
	DB 1Ah, 8Eh, 99h
; ---------------------- ; 0b845
loc_0x00B848:
	LD A,[1B15h] ; 0b848
	CP A,#07h ; 0b84c
	JRS Z,loc_0x00B85B ; 0b84e
	CP A,#01h ; 0b850
	JRS Z,loc_0x00B876 ; 0b852
	LD BA,#9B13h ; 0b854
	CARL loc_0x00794F ; 0b857
	RET
; ---------------------- ; 0b85a
loc_0x00B85B:
	LD A,[1AD7h] ; 0b85b
	CP A,#01h ; 0b85f
	JRS Z,loc_0x00B896 ; 0b861
	LD A,#00h ; 0b863
	LD [1B15h],A ; 0b865
	LD BA,#0B82Eh ; 0b869
	CARL loc_0x00794F ; 0b86c
	LD BA,[1B10h] ; 0b86f
	CARL loc_0x007982 ; 0b872
	RET
; ---------------------- ; 0b875
loc_0x00B876:
	LD A,[1B17h] ; 0b876
	LD B,A ; 0b87a
	ADD A,A ; 0b87b
	ADD A,B ; 0b87c
	LD B,#00h ; 0b87d
	PUSH IP ; 0b87f
	PUSH IY ; 0b880
	LD IY,#0B898h ; 0b881
	ADD IY,BA ; 0b884
	LD YP,#00h ; 0b886
	LD BA,[IY] ; 0b889
	CARL loc_0x00794F ; 0b88b
	POP IY ; 0b88e
	POP IP ; 0b88f
	LD BA,[1B10h] ; 0b890
	CARL loc_0x007982 ; 0b893
loc_0x00B896:
	RET
; ---------------------- ; 0b896
	DB 02h, 1Ch, 0B8h, 02h, 22h, 0B8h, 00h, 28h ; 0b897
	DB 0B8h
; ---------------------- ; 0b89f
loc_0x00B8A0:
	LD A,[1B17h] ; 0b8a0
	LD B,A ; 0b8a4
	ADD A,A ; 0b8a5
	ADD A,B ; 0b8a6
	LD B,#00h ; 0b8a7
loc_0x00B8A9:
	PUSH IP ; 0b8a9
	PUSH IY ; 0b8aa
	LD IY,#0B897h ; 0b8ab
	ADD IY,BA ; 0b8ae
	LD YP,#00h ; 0b8b0
	LD A,[IY] ; 0b8b3
	LD [1B16h],A ; 0b8b4
	POP IY ; 0b8b8
	POP IP ; 0b8b9
	RET
; ---------------------- ; 0b8ba
loc_0x00B8BB:
	LD A,[1B2Ah] ; 0b8bb
	OR A,A ; 0b8bf
	JRS NZ,loc_0x00B8C8 ; 0b8c0
	LD BA,#0B848h ; 0b8c2
	CARL loc_0x007948 ; 0b8c5
loc_0x00B8C8:
	RET
; ---------------------- ; 0b8c8
loc_0x00B8C9:
	LD A,[1B2Ah] ; 0b8c9
	OR A,A ; 0b8cd
	JRS Z,loc_0x00B8EB ; 0b8ce
	LD BA,#0B8BBh ; 0b8d0
	CARL loc_0x007948 ; 0b8d3
	LD A,[1B2Ch] ; 0b8d6
	LD B,[1AD7h] ; 0b8da
	CARL loc_0x00CCC8 ; 0b8de
	CARL loc_0x00794F ; 0b8e1
	LD BA,#1828h ; 0b8e4
	CARL loc_0x007982 ; 0b8e7
	RET
; ---------------------- ; 0b8ea
loc_0x00B8EB:
	LD BA,#0B848h ; 0b8eb
	CARL loc_0x007948 ; 0b8ee
	RET
; ---------------------- ; 0b8f1
	DB 0C9h, 0B8h, 01h, 19h, 9Bh, 01h, 17h, 9Bh ; 0b8f2
	DB 00h, 9Dh, 99h, 15h, 0BBh, 01h, 00h ; 0b8fa
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
	DB 0BEh, 0C4h, 17h, 9Bh, 0F1h, 16h
; ---------------------- ; 0bad0
loc_0x00BAD6:
	LD A,[1B2Ah] ; 0bad6
	OR A,A ; 0bada
	JRS Z,loc_0x00BAE8 ; 0badb
	LD BA,#0BFD9h ; 0badd
	CARL loc_0x007948 ; 0bae0
	LD BA,#9B17h ; 0bae3
	JRS loc_0x00BAEB
; ---------------------- ; 0bae6
loc_0x00BAE8:
	CARL loc_0x00BAEF ; 0bae8
loc_0x00BAEB:
	CARL loc_0x00794F ; 0baeb
	RET
; ---------------------- ; 0baee
loc_0x00BAEF:
	LD A,[1B15h] ; 0baef
	CP A,#03h ; 0baf3
	JRS Z,loc_0x00BB07 ; 0baf5
	CP A,#04h ; 0baf7
	JRS Z,loc_0x00BB0C ; 0baf9
	LD A,[1B14h] ; 0bafb
	OR A,A ; 0baff
	JRS Z,loc_0x00BB11 ; 0bb00
	LD BA,#0B90Dh ; 0bb02
	JRS loc_0x00BB14
; ---------------------- ; 0bb05
loc_0x00BB07:
	LD BA,#0B915h ; 0bb07
	JRS loc_0x00BB14
; ---------------------- ; 0bb0a
loc_0x00BB0C:
	LD BA,#0B91Dh ; 0bb0c
	JRS loc_0x00BB14
; ---------------------- ; 0bb0f
loc_0x00BB11:
	LD BA,#0B92Dh ; 0bb11
loc_0x00BB14:
	RET
; ---------------------- ; 0bb14
loc_0x00BB15:
	LD HL,[1B37h] ; 0bb15
	ADD HL,#0004h ; 0bb18
	LD BA,[HL] ; 0bb1b
	CP BA,#0A7E3h ; 0bb1d
	JRS NZ,loc_0x00BB28 ; 0bb20
	LD BA,#0B92Dh ; 0bb22
	CARL loc_0x00794F ; 0bb25
loc_0x00BB28:
	RET
; ---------------------- ; 0bb28
loc_0x00BB29:
	LD HL,#1B16h ; 0bb29
	LD A,[HL] ; 0bb2c
	OR A,A ; 0bb2d
	JRS Z,loc_0x00BB33 ; 0bb2e
	DEC [HL] ; 0bb30
	JRS NZ,loc_0x00BB63 ; 0bb31
loc_0x00BB33:
	LD HL,#1B17h ; 0bb33
	LD A,[1642h] ; 0bb36
	AND A,#01h ; 0bb3a
	JRS Z,loc_0x00BB4C ; 0bb3c
	CARL loc_0x009B56 ; 0bb3e
	JRS Z,loc_0x00BB4C ; 0bb41
	LD A,[HL] ; 0bb43
	CP A,#02h ; 0bb44
	JRS Z,loc_0x00BB63 ; 0bb46
	INC [HL] ; 0bb48
	LD A,[HL] ; 0bb49
	JRS loc_0x00BB51
; ---------------------- ; 0bb4a
loc_0x00BB4C:
	LD A,[HL] ; 0bb4c
	OR A,A ; 0bb4d
	JRS Z,loc_0x00BB56 ; 0bb4e
	DEC [HL] ; 0bb50
loc_0x00BB51:
	CARL loc_0x00B8A0 ; 0bb51
	JRS loc_0x00BB63
; ---------------------- ; 0bb54
loc_0x00BB56:
	LD A,#00h ; 0bb56
	LD [1B15h],A ; 0bb58
	LD BA,#0B92Dh ; 0bb5c
	CARL loc_0x00794F ; 0bb5f
	RET
; ---------------------- ; 0bb62
loc_0x00BB63:
	LD A,[1B17h] ; 0bb63
	CP A,#02h ; 0bb67
	CARL Z,loc_0x00BCDC ; 0bb69
	RET
; ---------------------- ; 0bb6c
loc_0x00BB6D:
	LD A,[1642h] ; 0bb6d
	BIT A,#01h ; 0bb71
	JRS Z,loc_0x00BB94 ; 0bb73
	LD A,[1643h] ; 0bb75
	BIT A,#01h ; 0bb79
	JRS Z,loc_0x00BB8A ; 0bb7b
	LD A,[1AB6h] ; 0bb7d
	AND A,A ; 0bb81
	JRS Z,loc_0x00BB8A ; 0bb82
	LD A,#15h ; 0bb84
	LD [14FAh],A ; 0bb86
loc_0x00BB8A:
	LD BA,#0BA91h ; 0bb8a
	CARL loc_0x00794F ; 0bb8d
	CARL loc_0x00BF32 ; 0bb90
	RET
; ---------------------- ; 0bb93
loc_0x00BB94:
	LD A,[1643h] ; 0bb94
	BIT A,#02h ; 0bb98
	JRS Z,loc_0x00BBB1 ; 0bb9a
	LD BA,[161Fh] ; 0bb9c
	CP BA,#88DEh ; 0bb9f
	JRS NZ,loc_0x00BBB1 ; 0bba2
	LD A,#00h ; 0bba4
	LD [1B15h],A ; 0bba6
	LD BA,#0B8FBh ; 0bbaa
	CARL loc_0x00794F ; 0bbad
	RET
; ---------------------- ; 0bbb0
loc_0x00BBB1:
	LD HL,#0B931h ; 0bbb1
	JRL loc_0x00BC53
; ---------------------- ; 0bbb4
loc_0x00BBB7:
	LD A,#00h ; 0bbb7
	LD [1B15h],A ; 0bbb9
	LD A,[1643h] ; 0bbbd
	BIT A,#01h ; 0bbc1
	JRS Z,loc_0x00BC41 ; 0bbc3
	CARL loc_0x009B8D ; 0bbc5
	JRS NZ,loc_0x00BC08 ; 0bbc8
	CARL loc_0x009B56 ; 0bbca
	JRS Z,loc_0x00BBE4 ; 0bbcd
	LD A,#01h ; 0bbcf
	LD [1B15h],A ; 0bbd1
	XOR A,A ; 0bbd5
	LD [1B17h],A ; 0bbd6
	CARL loc_0x00B8A0 ; 0bbda
	LD BA,#0BA6Fh ; 0bbdd
	CARL loc_0x00794F ; 0bbe0
	RET
; ---------------------- ; 0bbe3
loc_0x00BBE4:
	CARL loc_0x00BD58 ; 0bbe4
	JRS NZ,loc_0x00BC01 ; 0bbe7
	CARL loc_0x00BD94 ; 0bbe9
	JRS NZ,loc_0x00BC24 ; 0bbec
	LD A,[1AB6h] ; 0bbee
	AND A,A ; 0bbf2
	JRS Z,loc_0x00BBFB ; 0bbf3
	LD A,#09h ; 0bbf5
	LD [14FAh],A ; 0bbf7
loc_0x00BBFB:
	LD A,#02h ; 0bbfb
	LD [1B15h],A ; 0bbfd
loc_0x00BC01:
	LD BA,#0BA85h ; 0bc01
	CARL loc_0x00794F ; 0bc04
	RET
; ---------------------- ; 0bc07
loc_0x00BC08:
	LD A,#07h ; 0bc08
	LD [1B15h],A ; 0bc0a
	LD A,[1AD7h] ; 0bc0e
	CP A,#01h ; 0bc12
	JRS Z,loc_0x00BC1D ; 0bc14
	LD BA,#0BA79h ; 0bc16
	CARL loc_0x00794F ; 0bc19
	RET
; ---------------------- ; 0bc1c
loc_0x00BC1D:
	LD BA,#0C098h ; 0bc1d
	CARL loc_0x00794F ; 0bc20
	RET
; ---------------------- ; 0bc23
loc_0x00BC24:
	LD A,[1AB6h] ; 0bc24
	AND A,A ; 0bc28
	JRS Z,loc_0x00BC31 ; 0bc29
	LD A,#01h ; 0bc2b
	LD [14FAh],A ; 0bc2d
loc_0x00BC31:
	LD HL,#9301h ; 0bc31
	LD B,#03h ; 0bc34
	PUSH IY ; 0bc36
	CARL loc_0x00228F ; 0bc37
	POP IY ; 0bc3a
	LD BR,#20h ; 0bc3b
	AND [BR:26h],#0BFh ; 0bc3d
	RET
; ---------------------- ; 0bc40
loc_0x00BC41:
	LD A,[1B14h] ; 0bc41
	CP A,#01h ; 0bc45
	JRS NZ,loc_0x00BC50 ; 0bc47
	LD BA,#0B905h ; 0bc49
	CARL loc_0x00794F ; 0bc4c
	RET
; ---------------------- ; 0bc4f
loc_0x00BC50:
	LD HL,#0B92Dh ; 0bc50
loc_0x00BC53:
	LD A,[1644h] ; 0bc53
	BIT A,#04h ; 0bc57
	JRS Z,loc_0x00BC85 ; 0bc59
	LD BA,[161Fh] ; 0bc5b
	CP BA,#88DEh ; 0bc5e
	JRS NZ,loc_0x00BC85 ; 0bc61
	LD A,[1B82h] ; 0bc63
	OR A,A ; 0bc67
	JRS NZ,loc_0x00BC85 ; 0bc68
	LD A,[1AB6h] ; 0bc6a
	AND A,A ; 0bc6e
	JRS Z,loc_0x00BC77 ; 0bc6f
	LD A,#05h ; 0bc71
	LD [14FAh],A ; 0bc73
loc_0x00BC77:
	CARL loc_0x0022EE ; 0bc77
	LD HL,#914Dh ; 0bc7a
	LD B,#03h ; 0bc7d
	PUSH IY ; 0bc7f
	CARL loc_0x00228F ; 0bc80
	POP IY ; 0bc83
	RET
; ---------------------- ; 0bc84
loc_0x00BC85:
	LD A,[1642h] ; 0bc85
	BIT A,#40h ; 0bc89
	JRS NZ,loc_0x00BC9E ; 0bc8b
	BIT A,#20h ; 0bc8d
	JRS Z,loc_0x00BCAA ; 0bc8f
	LD HL,#1B10h ; 0bc91
	LD A,[HL] ; 0bc94
	OR A,A ; 0bc95
	JRS Z,loc_0x00BC99 ; 0bc96
	DEC [HL] ; 0bc98
loc_0x00BC99:
	LD HL,#0BA05h ; 0bc99
	JRS loc_0x00BCAA
; ---------------------- ; 0bc9c
loc_0x00BC9E:
	LD HL,#1B10h ; 0bc9e
	LD A,[HL] ; 0bca1
	CP A,#50h ; 0bca2
	JRS NC,loc_0x00BCA7 ; 0bca4
	INC [HL] ; 0bca6
loc_0x00BCA7:
	LD HL,#0B99Bh ; 0bca7
loc_0x00BCAA:
	LD BA,HL ; 0bcaa
	CARL loc_0x00794F ; 0bcac
	LD HL,#1B11h ; 0bcaf
	LD A,[1642h] ; 0bcb2
	BIT A,#08h ; 0bcb6
	JRS NZ,loc_0x00BCC6 ; 0bcb8
	BIT A,#10h ; 0bcba
	JRS Z,loc_0x00BCCC ; 0bcbc
	LD A,[HL] ; 0bcbe
	CP A,#3Ah ; 0bcbf
	JRS NC,loc_0x00BCCC ; 0bcc1
	INC [HL] ; 0bcc3
	JRS loc_0x00BCCC
; ---------------------- ; 0bcc4
loc_0x00BCC6:
	LD A,[HL] ; 0bcc6
	CP A,#01h ; 0bcc7
	JRS C,loc_0x00BCCC ; 0bcc9
	DEC [HL] ; 0bccb
loc_0x00BCCC:
	LD BA,[1B10h] ; 0bccc
	CARL loc_0x007982 ; 0bccf
	RET
; ---------------------- ; 0bcd2
	DB 0C1h, 0BAh, 01h, 19h, 9Bh, 01h, 17h, 9Bh ; 0bcd3
	DB 00h
; ---------------------- ; 0bcdb
loc_0x00BCDC:
	LD A,[1642h] ; 0bcdc
	BIT A,#08h ; 0bce0
	JRS NZ,loc_0x00BCFD ; 0bce2
	BIT A,#10h ; 0bce4
	JRS Z,loc_0x00BD15 ; 0bce6
	LD A,[1B13h] ; 0bce8
	LD B,[1B23h] ; 0bcec
	CP A,B ; 0bcf0
	JRS NC,loc_0x00BD15 ; 0bcf1
	LD HL,#1B11h ; 0bcf3
	INC [HL] ; 0bcf6
	LD HL,#1B13h ; 0bcf7
	INC [HL] ; 0bcfa
	JRS loc_0x00BD15
; ---------------------- ; 0bcfb
loc_0x00BCFD:
	LD A,[1B13h] ; 0bcfd
	CP A,#01h ; 0bd01
	JRS C,loc_0x00BD15 ; 0bd03
	LD A,[1B11h] ; 0bd05
	CP A,#01h ; 0bd09
	JRS C,loc_0x00BD15 ; 0bd0b
	LD HL,#1B11h ; 0bd0d
	DEC [HL] ; 0bd10
	LD HL,#1B13h ; 0bd11
	DEC [HL] ; 0bd14
loc_0x00BD15:
	LD A,[1642h] ; 0bd15
	BIT A,#20h ; 0bd19
	JRS NZ,loc_0x00BD3B ; 0bd1b
	BIT A,#40h ; 0bd1d
	JRS Z,loc_0x00BD51 ; 0bd1f
	LD A,[1B10h] ; 0bd21
	CP A,#50h ; 0bd25
	JRS NC,loc_0x00BD51 ; 0bd27
	LD A,[1B12h] ; 0bd29
	CP A,#50h ; 0bd2d
	JRS NC,loc_0x00BD51 ; 0bd2f
	LD HL,#1B10h ; 0bd31
	INC [HL] ; 0bd34
	LD HL,#1B12h ; 0bd35
	INC [HL] ; 0bd38
	JRS loc_0x00BD51
; ---------------------- ; 0bd39
loc_0x00BD3B:
	LD A,[1B10h] ; 0bd3b
	OR A,A ; 0bd3f
	JRS Z,loc_0x00BD51 ; 0bd40
	LD A,[1B12h] ; 0bd42
	OR A,A ; 0bd46
	JRS Z,loc_0x00BD51 ; 0bd47
	LD HL,#1B10h ; 0bd49
	DEC [HL] ; 0bd4c
	LD HL,#1B12h ; 0bd4d
	DEC [HL] ; 0bd50
loc_0x00BD51:
	LD BA,[1B10h] ; 0bd51
	CARL loc_0x007982 ; 0bd54
	RET
; ---------------------- ; 0bd57
loc_0x00BD58:
	LD A,[1AD8h] ; 0bd58
	CP A,#01h ; 0bd5c
	JRS NZ,loc_0x00BD91 ; 0bd5e
	LD A,[1B10h] ; 0bd60
	CP A,#0Fh ; 0bd64
	JRS C,loc_0x00BD91 ; 0bd66
	CP A,#15h ; 0bd68
	JRS NC,loc_0x00BD91 ; 0bd6a
	LD A,[1B11h] ; 0bd6c
	CP A,#16h ; 0bd70
	JRS C,loc_0x00BD91 ; 0bd72
	CP A,#1Ch ; 0bd74
	JRS NC,loc_0x00BD91 ; 0bd76
	LD A,[1AB6h] ; 0bd78
	AND A,A ; 0bd7c
	JRS Z,loc_0x00BD85 ; 0bd7d
	LD A,#0Ch ; 0bd7f
	LD [14FAh],A ; 0bd81
loc_0x00BD85:
	LD HL,#1AD9h ; 0bd85
	LD A,[HL] ; 0bd88
	XOR A,#01h ; 0bd89
	OR A,#80h ; 0bd8b
	LD [HL],A ; 0bd8d
	AND SC,#0FEh ; 0bd8e
	RET
; ---------------------- ; 0bd90
loc_0x00BD91:
	OR SC,#01h ; 0bd91
	RET
; ---------------------- ; 0bd93
loc_0x00BD94:
	LD A,[1AD6h] ; 0bd94
	OR A,A ; 0bd98
	JRS NZ,loc_0x00BDA0 ; 0bd99
	CARL loc_0x00AA46 ; 0bd9b
	JRS Z,loc_0x00BDC3 ; 0bd9e
loc_0x00BDA0:
	LD A,[1AD8h] ; 0bda0
	CP A,#01h ; 0bda4
	JRS NZ,loc_0x00BDC3 ; 0bda6
	LD A,[1B10h] ; 0bda8
	CP A,#05h ; 0bdac
	JRS C,loc_0x00BDC3 ; 0bdae
	CP A,#16h ; 0bdb0
	JRS NC,loc_0x00BDC3 ; 0bdb2
	LD A,[1B11h] ; 0bdb4
	CP A,#26h ; 0bdb8
	JRS C,loc_0x00BDC3 ; 0bdba
	CP A,#30h ; 0bdbc
	JRS NC,loc_0x00BDC3 ; 0bdbe
	AND SC,#0FEh ; 0bdc0
	RET
; ---------------------- ; 0bdc2
loc_0x00BDC3:
	OR SC,#01h ; 0bdc3
	RET
; ---------------------- ; 0bdc5
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
	DB 0CEh, 0D4h, 17h, 1Bh
; ---------------------- ; 0be31
loc_0x00BE35:
	LD A,[1642h] ; 0be35
	BIT A,#01h ; 0be39
	JRS Z,loc_0x00BE44 ; 0be3b
	LD BA,#0BDC6h ; 0be3d
	CARL loc_0x00794F ; 0be40
	RET
; ---------------------- ; 0be43
loc_0x00BE44:
	LD A,[1643h] ; 0be44
	BIT A,#02h ; 0be48
	JRS Z,loc_0x00BE59 ; 0be4a
	LD A,#00h ; 0be4c
	LD [1B15h],A ; 0be4e
	LD BA,#0B8FBh ; 0be52
	CARL loc_0x00794F ; 0be55
	RET
; ---------------------- ; 0be58
loc_0x00BE59:
	LD HL,#0B931h ; 0be59
	JRL loc_0x00BC53
; ---------------------- ; 0be5c
loc_0x00BE5F:
	LD A,[1642h] ; 0be5f
	BIT A,#01h ; 0be63
	JRS NZ,loc_0x00BE6E ; 0be65
	LD BA,#0B915h ; 0be67
	CARL loc_0x00794F ; 0be6a
	RET
; ---------------------- ; 0be6d
loc_0x00BE6E:
	CARL loc_0x00B16B ; 0be6e
	JRS Z,loc_0x00BE7B ; 0be71
	LD A,[1642h] ; 0be73
	AND A,#78h ; 0be77
	JRS NZ,loc_0x00BE89 ; 0be79
loc_0x00BE7B:
	LD A,[1B17h] ; 0be7b
	OR A,A ; 0be7f
	JRS Z,loc_0x00BEC7 ; 0be80
	DEC A ; 0be82
	LD [1B17h],A ; 0be83
	JRS loc_0x00BEC7
; ---------------------- ; 0be87
loc_0x00BE89:
	LD A,[1643h] ; 0be89
	AND A,#78h ; 0be8d
	JRS Z,loc_0x00BE9E ; 0be8f
	LD A,[1AB6h] ; 0be91
	AND A,A ; 0be95
	JRS Z,loc_0x00BE9E ; 0be96
	LD A,#13h ; 0be98
	LD [14FAh],A ; 0be9a
loc_0x00BE9E:
	LD A,[1B17h] ; 0be9e
	CP A,#02h ; 0bea2
	JRS NC,loc_0x00BEA7 ; 0bea4
	INC A ; 0bea6
loc_0x00BEA7:
	LD [1B17h],A ; 0bea7
	DEC A ; 0beab
	ADD A,A ; 0beac
	LD B,#00h ; 0bead
	PUSH IP ; 0beaf
	PUSH IY ; 0beb0
	LD IY,#0BECBh ; 0beb1
	ADD IY,BA ; 0beb4
	LD YP,#00h ; 0beb6
	LD IY,[IY] ; 0beb9
	CARL loc_0x00BEF3 ; 0bebb
	LD BA,[IY] ; 0bebe
	POP IY ; 0bec0
	POP IP ; 0bec1
	JRS loc_0x00BEC4
; ---------------------- ; 0bec2
loc_0x00BEC4:
	CARL loc_0x00794F ; 0bec4
loc_0x00BEC7:
	CARL loc_0x00BF32 ; 0bec7
	RET
; ---------------------- ; 0beca
	DB 0CFh, 0BEh, 0E1h, 0BEh, 0D4h, 0BDh, 04h, 0BEh ; 0becb
	DB 1Ch, 0BEh, 0ECh, 0BDh, 28h, 0BEh, 0E0h, 0BDh ; 0bed3
	DB 0F8h, 0BDh, 10h, 0BEh, 0C6h, 0BDh, 0D0h, 0BDh ; 0bedb
	DB 00h, 0BEh, 18h, 0BEh, 0E8h, 0BDh, 24h, 0BEh ; 0bee3
	DB 0DCh, 0BDh, 0Ch, 0BEh, 0F4h, 0BDh, 0C6h, 0BDh
; ---------------------- ; 0beeb
loc_0x00BEF3:
	LD A,[1642h] ; 0bef3
	AND A,#78h ; 0bef7
	CP A,#08h ; 0bef9
	JRS Z,loc_0x00BF31 ; 0befb
	CP A,#10h ; 0befd
	JRS Z,loc_0x00BF2E ; 0beff
	CP A,#20h ; 0bf01
	JRS Z,loc_0x00BF2B ; 0bf03
	CP A,#40h ; 0bf05
	JRS Z,loc_0x00BF28 ; 0bf07
	CP A,#28h ; 0bf09
	JRS Z,loc_0x00BF25 ; 0bf0b
	CP A,#48h ; 0bf0d
	JRS Z,loc_0x00BF22 ; 0bf0f
	CP A,#30h ; 0bf11
	JRS Z,loc_0x00BF1F ; 0bf13
	CP A,#50h ; 0bf15
	JRS Z,loc_0x00BF1C ; 0bf17
	ADD IY,#0002h ; 0bf19
loc_0x00BF1C:
	ADD IY,#0002h ; 0bf1c
loc_0x00BF1F:
	ADD IY,#0002h ; 0bf1f
loc_0x00BF22:
	ADD IY,#0002h ; 0bf22
loc_0x00BF25:
	ADD IY,#0002h ; 0bf25
loc_0x00BF28:
	ADD IY,#0002h ; 0bf28
loc_0x00BF2B:
	ADD IY,#0002h ; 0bf2b
loc_0x00BF2E:
	ADD IY,#0002h ; 0bf2e
loc_0x00BF31:
	RET
; ---------------------- ; 0bf31
loc_0x00BF32:
	LD HL,#1B10h ; 0bf32
	LD A,[1642h] ; 0bf35
	BIT A,#40h ; 0bf39
	JRS NZ,loc_0x00BF48 ; 0bf3b
	BIT A,#20h ; 0bf3d
	JRS Z,loc_0x00BF4E ; 0bf3f
	LD A,[HL] ; 0bf41
	OR A,A ; 0bf42
	JRS Z,loc_0x00BF46 ; 0bf43
	DEC [HL] ; 0bf45
loc_0x00BF46:
	JRS loc_0x00BF4E
; ---------------------- ; 0bf46
loc_0x00BF48:
	LD A,[HL] ; 0bf48
	CP A,#50h ; 0bf49
	JRS NC,loc_0x00BF4E ; 0bf4b
	INC [HL] ; 0bf4d
loc_0x00BF4E:
	LD HL,#1B11h ; 0bf4e
	LD A,[1642h] ; 0bf51
	BIT A,#08h ; 0bf55
	JRS NZ,loc_0x00BF65 ; 0bf57
	BIT A,#10h ; 0bf59
	JRS Z,loc_0x00BF6B ; 0bf5b
	LD A,[HL] ; 0bf5d
	CP A,#3Ah ; 0bf5e
	JRS NC,loc_0x00BF6B ; 0bf60
	INC [HL] ; 0bf62
	JRS loc_0x00BF6B
; ---------------------- ; 0bf63
loc_0x00BF65:
	LD A,[HL] ; 0bf65
	CP A,#01h ; 0bf66
	JRS C,loc_0x00BF6B ; 0bf68
	DEC [HL] ; 0bf6a
loc_0x00BF6B:
	LD BA,[1B10h] ; 0bf6b
	CARL loc_0x007982 ; 0bf6e
	RET
; ---------------------- ; 0bf71
loc_0x00BF72:
	LD A,[1642h] ; 0bf72
	BIT A,#01h ; 0bf76
	JRS Z,loc_0x00BF87 ; 0bf78
	LD A,#05h ; 0bf7a
	LD [1B15h],A ; 0bf7c
	LD BA,#0B925h ; 0bf80
	CARL loc_0x00794F ; 0bf83
	RET
; ---------------------- ; 0bf86
loc_0x00BF87:
	LD A,[1643h] ; 0bf87
	BIT A,#02h ; 0bf8b
	JRS Z,loc_0x00BF9C ; 0bf8d
	LD A,#00h ; 0bf8f
	LD [1B15h],A ; 0bf91
	LD BA,#0B8FBh ; 0bf95
	CARL loc_0x00794F ; 0bf98
	RET
; ---------------------- ; 0bf9b
loc_0x00BF9C:
	LD HL,#0B931h ; 0bf9c
	JRL loc_0x00BC53
; ---------------------- ; 0bf9f
loc_0x00BFA2:
	LD A,[1B15h] ; 0bfa2
	CP A,#06h ; 0bfa6
	JRS NZ,loc_0x00BFBE ; 0bfa8
	LD A,[1AB6h] ; 0bfaa
	AND A,A ; 0bfae
	JRS Z,loc_0x00BFB7 ; 0bfaf
	LD A,#14h ; 0bfb1
	LD [14FAh],A ; 0bfb3
loc_0x00BFB7:
	LD BA,#0BA97h ; 0bfb7
	CARL loc_0x00794F ; 0bfba
	RET
; ---------------------- ; 0bfbd
loc_0x00BFBE:
	LD A,[1642h] ; 0bfbe
	BIT A,#01h ; 0bfc2
	JRS NZ,loc_0x00BFD3 ; 0bfc4
	LD A,#04h ; 0bfc6
	LD [1B15h],A ; 0bfc8
	LD BA,#0B91Dh ; 0bfcc
	CARL loc_0x00794F ; 0bfcf
	RET
; ---------------------- ; 0bfd2
loc_0x00BFD3:
	LD HL,#0B931h ; 0bfd3
	JRL loc_0x00BC53
; ---------------------- ; 0bfd6
loc_0x00BFD9:
	LD A,[1643h] ; 0bfd9
	BIT A,#02h ; 0bfdd
	JRS Z,loc_0x00C00B ; 0bfdf
	LD A,[1AB6h] ; 0bfe1
	AND A,A ; 0bfe5
	JRS Z,loc_0x00BFEE ; 0bfe6
	LD A,#02h ; 0bfe8
	LD [14FAh],A ; 0bfea
loc_0x00BFEE:
	XOR A,A ; 0bfee
	LD [1B2Ah],A ; 0bfef
	LD A,#00h ; 0bff3
	LD [1B14h],A ; 0bff5
	LD NB,#03h ; 0bff9
	CARL loc_0x01898C ; 0bffc
	LD A,#00h ; 0bfff
	LD [1B15h],A ; 0c001
	LD BA,#0B92Dh ; 0c005
	CARL loc_0x00794F ; 0c008
loc_0x00C00B:
	RET
; ---------------------- ; 0c00b
loc_0x00C00C:
	LD A,[1642h] ; 0c00c
	OR A,A ; 0c010
	JRS Z,loc_0x00C02F ; 0c011
	LD A,[1AB6h] ; 0c013
	AND A,A ; 0c017
	JRS Z,loc_0x00C020 ; 0c018
	LD A,#01h ; 0c01a
	LD [14FAh],A ; 0c01c
loc_0x00C020:
	XOR A,A ; 0c020
	LD [1B2Bh],A ; 0c021
	LD [1B15h],A ; 0c025
	LD BA,#0B90Dh ; 0c029
	CARL loc_0x00794F ; 0c02c
loc_0x00C02F:
	RET
; ---------------------- ; 0c02f
	DB 01h, 00h, 0A4h, 0ADh, 8Eh, 99h
; ---------------------- ; 0c030
loc_0x00C036:
	LD A,[1645h] ; 0c036
	AND A,#78h ; 0c03a
	CP A,#08h ; 0c03c
	JRS Z,loc_0x00C04F ; 0c03e
	CP A,#10h ; 0c040
	JRS NZ,loc_0x00C068 ; 0c042
	LD A,[1B2Dh] ; 0c044
	CP A,#06h ; 0c048
	JRS NC,loc_0x00C068 ; 0c04a
	INC A ; 0c04c
	JRS loc_0x00C057
; ---------------------- ; 0c04d
loc_0x00C04F:
	LD A,[1B2Dh] ; 0c04f
	OR A,A ; 0c053
	JRS Z,loc_0x00C068 ; 0c054
	DEC A ; 0c056
loc_0x00C057:
	LD [1B2Dh],A ; 0c057
	LD A,[1AB6h] ; 0c05b
	AND A,A ; 0c05f
	JRS Z,loc_0x00C068 ; 0c060
	LD A,#04h ; 0c062
	LD [14FAh],A ; 0c064
loc_0x00C068:
	LD A,[1B2Dh] ; 0c068
	ADD A,A ; 0c06c
	LD B,#00h ; 0c06d
	PUSH IP ; 0c06f
	PUSH IY ; 0c070
	LD IY,#0C081h ; 0c071
	LD YP,#00h ; 0c074
	ADD IY,BA ; 0c077
	LD BA,[IY] ; 0c079
	POP IY ; 0c07b
	POP IP ; 0c07c
	CARL loc_0x007982 ; 0c07d
	RET
; ---------------------- ; 0c080
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
	DB 0FEh
; ---------------------- ; 0c0e8
loc_0x00C0E9:
	LD A,#02h ; 0c0e9
	LD [1B1Dh],A ; 0c0eb
	RET
; ---------------------- ; 0c0ef
loc_0x00C0F0:
	LD A,#12h ; 0c0f0
	LD [1B1Dh],A ; 0c0f2
	RET
; ---------------------- ; 0c0f6
loc_0x00C0F7:
	LD A,#13h ; 0c0f7
	LD [1B1Dh],A ; 0c0f9
	RET
; ---------------------- ; 0c0fd
loc_0x00C0FE:
	LD A,#00h ; 0c0fe
	LD [1B1Dh],A ; 0c100
	RET
; ---------------------- ; 0c104
	DB 40h, 0A9h, 9Dh, 99h, 0CBh, 0C3h, 04h, 00h ; 0c105
	DB 0ECh, 0ADh, 04h, 00h, 0F0h, 0ADh, 9Dh, 99h ; 0c10d
	DB 0C8h, 0C3h, 0C1h, 99h, 13h, 9Bh ; 0c115
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
	DB 9Bh
; ---------------------- ; 0c34b
loc_0x00C34C:
	LD A,[1B1Ch] ; 0c34c
	CP A,#1Ah ; 0c350
	JRS C,loc_0x00C356 ; 0c352
	LD A,#1Ah ; 0c354
loc_0x00C356:
	ADD A,A ; 0c356
	LD B,#00h ; 0c357
	PUSH IP ; 0c359
	PUSH IY ; 0c35a
	LD IY,#0C376h ; 0c35b
	LD YP,#00h ; 0c35e
	ADD IY,BA ; 0c361
	LD BA,[IY] ; 0c363
	POP IY ; 0c365
	POP IP ; 0c366
	CP BA,#0FFFFh ; 0c367
	JRS Z,loc_0x00C36F ; 0c36a
	CARL loc_0x00794F ; 0c36c
loc_0x00C36F:
	LD NB,#02h ; 0c36f
	CARL loc_0x0129B2 ; 0c372
	RET
; ---------------------- ; 0c375
	DB 0FFh, 0FFh, 05h, 0C1h, 0FFh, 0FFh, 1Bh, 0C1h ; 0c376
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
	DB 0C2h, 0F4h, 0C2h, 24h, 0C3h, 0FFh, 0FFh
; ---------------------- ; 0c3a5
loc_0x00C3AC:
	CARL loc_0x00C34C ; 0c3ac
	LD HL,#2029h ; 0c3af
	LD A,[1AD7h] ; 0c3b2
	OR A,A ; 0c3b6
	JRS Z,loc_0x00C3C2 ; 0c3b7
	LD HL,#1D1Ch ; 0c3b9
	DEC A ; 0c3bc
	JRS Z,loc_0x00C3C2 ; 0c3bd
	LD HL,#2327h ; 0c3bf
loc_0x00C3C2:
	LD BA,HL ; 0c3c2
	CARL loc_0x007982 ; 0c3c4
	RET
; ---------------------- ; 0c3c7
loc_0x00C3C8:
	CARL loc_0x00C34C ; 0c3c8
	LD A,[1B14h] ; 0c3cb
	OR A,A ; 0c3cf
	JRS Z,loc_0x00C3D7 ; 0c3d0
	LD BA,#2A3Ah ; 0c3d2
	JRS loc_0x00C3DA
; ---------------------- ; 0c3d5
loc_0x00C3D7:
	LD BA,[1B12h] ; 0c3d7
loc_0x00C3DA:
	CARL loc_0x007982 ; 0c3da
	RET
; ---------------------- ; 0c3dd
	ASCII "q" ; 0c3de
	DB 9Ah, 02h, 0C8h, 0C3h, 01h, 17h, 9Bh, 00h ; 0c3df
	DB 0C1h, 99h, 0EEh, 0C3h ; 0c3e7
	ASCII "O" ; 0c3eb
	DB 9Ah, 0Fh, 9Dh, 99h, 26h, 0C4h, 04h, 00h ; 0c3ec
	DB 0E4h, 0ADh, 04h, 00h, 0E8h, 0ADh, 9Dh, 99h ; 0c3f4
	DB 02h, 0C4h, 0C1h, 99h, 13h, 9Bh
; ---------------------- ; 0c3fc
loc_0x00C402:
	LD A,[1B1Dh] ; 0c402
	CP A,#13h ; 0c406
	JRS Z,loc_0x00C418 ; 0c408
	CP A,#12h ; 0c40a
	JRS Z,loc_0x00C41D ; 0c40c
	CP A,#02h ; 0c40e
	JRS Z,loc_0x00C413 ; 0c410
	RET
; ---------------------- ; 0c412
loc_0x00C413:
	LD BA,#0C3EBh ; 0c413
	JRS loc_0x00C420
; ---------------------- ; 0c416
loc_0x00C418:
	LD BA,#0C3E7h ; 0c418
	JRS loc_0x00C420
; ---------------------- ; 0c41b
loc_0x00C41D:
	LD BA,#0C3EBh ; 0c41d
loc_0x00C420:
	CARL loc_0x00794F ; 0c420
	CARL loc_0x00C0FE ; 0c423
	LD A,[1B14h] ; 0c426
	OR A,A ; 0c42a
	JRS Z,loc_0x00C432 ; 0c42b
	LD BA,#2A3Ah ; 0c42d
	JRS loc_0x00C441
; ---------------------- ; 0c430
loc_0x00C432:
	LD BA,[1B12h] ; 0c432
	CP B,#10h ; 0c435
	JRS C,loc_0x00C43F ; 0c438
	CP B,#50h ; 0c43a
	JRS C,loc_0x00C441 ; 0c43d
loc_0x00C43F:
	LD B,#10h ; 0c43f
loc_0x00C441:
	CARL loc_0x007982 ; 0c441
	RET
; ---------------------- ; 0c444
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
	DB 0B3h, 0F8h
; ---------------------- ; 0c5e3
loc_0x00C5E5:
	LD [IY],B ; 0c5e5
	DEC IX ; 0c5e6
	ADD A,#9Bh ; 0c5e7
	LD HL,#8B01h ; 0c5e9
	LD HL,#0CE00h ; 0c5ec
	SUB BA,#1B1Ch ; 0c5ef
	CP A,#0Dh ; 0c5f2
	JRS Z,loc_0x00C605 ; 0c5f4
	CP A,#09h ; 0c5f6
	JRS Z,loc_0x00C600 ; 0c5f8
	CP A,#00h ; 0c5fa
	JRS Z,loc_0x00C611 ; 0c5fc
	JRS loc_0x00C605
; ---------------------- ; 0c5fe
loc_0x00C600:
	LD BA,#0C630h ; 0c600
	JRS loc_0x00C608
; ---------------------- ; 0c603
loc_0x00C605:
	LD BA,#0C642h ; 0c605
loc_0x00C608:
	CARL loc_0x00794F ; 0c608
	LD NB,#02h ; 0c60b
	CARL loc_0x0129B2 ; 0c60e
loc_0x00C611:
	RET
; ---------------------- ; 0c611
loc_0x00C612:
	LD A,[1B1Ch] ; 0c612
	CP A,#0Dh ; 0c616
	JRS Z,loc_0x00C623 ; 0c618
	CP A,#09h ; 0c61a
	JRS NZ,loc_0x00C62F ; 0c61c
	LD BA,#0C630h ; 0c61e
	JRS loc_0x00C626
; ---------------------- ; 0c621
loc_0x00C623:
	LD BA,#0C642h ; 0c623
loc_0x00C626:
	CARL loc_0x00794F ; 0c626
	LD NB,#02h ; 0c629
	CARL loc_0x0129B2 ; 0c62c
loc_0x00C62F:
	RET
; ---------------------- ; 0c62f
	DB 9Dh, 99h, 19h, 9Bh, 02h, 00h, 0Ch, 0B2h ; 0c630
	DB 9Dh, 99h, 0EEh, 0C5h, 01h, 00h, 10h, 0B2h ; 0c638
	DB 8Eh, 99h, 02h, 00h, 0Ch, 0B2h, 02h, 00h ; 0c640
	DB 04h, 0B2h, 02h, 00h, 08h, 0B2h, 9Dh, 99h ; 0c648
	DB 12h, 0C6h, 01h, 00h, 04h, 0B2h, 8Eh, 99h ; 0c650
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
	DB 1Ah, 0F8h
; ---------------------- ; 0c6a6
loc_0x00C6A8:
	LD A,[1B14h] ; 0c6a8
	CP A,#00h ; 0c6ac
	JRS Z,loc_0x00C6B7 ; 0c6ae
	LD BA,#9B13h ; 0c6b0
	CARL loc_0x00794F ; 0c6b3
	RET
; ---------------------- ; 0c6b6
loc_0x00C6B7:
	LD A,[1B13h] ; 0c6b7
	LD B,[1B23h] ; 0c6bb
	CP A,B ; 0c6bf
	JRS NZ,loc_0x00C71E ; 0c6c0
	PUSH IP ; 0c6c2
	PUSH IY ; 0c6c3
	PUSH IX ; 0c6c4
	LD IX,[1B37h] ; 0c6c5
	LD A,[IX+14h] ; 0c6c8
	LD B,[IX+15h] ; 0c6cb
	LD IY,BA ; 0c6ce
	LD A,[IX+16h] ; 0c6d0
	LD YP,A ; 0c6d3
	LD A,[IY+01h] ; 0c6d5
	LD L,[IX+02h] ; 0c6d8
	LD H,[IX+03h] ; 0c6db
	POP IX ; 0c6de
	POP IY ; 0c6df
	POP IP ; 0c6e0
	BIT A,#80h ; 0c6e1
	JRS NZ,loc_0x00C71E ; 0c6e3
	CP HL,#9989h ; 0c6e5
	JRS C,loc_0x00C6F9 ; 0c6e8
	CP HL,#999Eh ; 0c6ea
	JRS C,loc_0x00C714 ; 0c6ed
	CP HL,#99F8h ; 0c6ef
	JRS C,loc_0x00C71E ; 0c6f2
	CP HL,#9A11h ; 0c6f4
	JRS C,loc_0x00C719 ; 0c6f7
loc_0x00C6F9:
	LD HL,#0C697h ; 0c6f9
	LD A,[IX+1Ah] ; 0c6fc
	XOR A,#01h ; 0c6ff
	LD [IX+1Ah],A ; 0c701
	JRS Z,loc_0x00C709 ; 0c704
	LD HL,#0C69Dh ; 0c706
loc_0x00C709:
	LD A,[IX+18h] ; 0c709
	LD B,[IX+19h] ; 0c70c
	CP BA,#9B13h ; 0c70f
	JRS NZ,loc_0x00C72C ; 0c712
loc_0x00C714:
	LD HL,#0C661h ; 0c714
	JRS loc_0x00C72C
; ---------------------- ; 0c717
loc_0x00C719:
	LD HL,#0C67Ah ; 0c719
	JRS loc_0x00C72C
; ---------------------- ; 0c71c
loc_0x00C71E:
	LD A,[IX+18h] ; 0c71e
	LD B,[IX+19h] ; 0c721
	CP BA,#0C697h ; 0c724
	JRS NC,loc_0x00C719 ; 0c727
	LD HL,#9B13h ; 0c729
loc_0x00C72C:
	LD [IX+18h],L ; 0c72c
	LD [IX+19h],H ; 0c72f
	LD BA,HL ; 0c732
	CARL loc_0x00794F ; 0c734
	PUSH IP ; 0c737
	PUSH IY ; 0c738
	PUSH IX ; 0c739
	LD IX,[1B37h] ; 0c73a
	LD A,[IX+14h] ; 0c73d
	LD B,[IX+15h] ; 0c740
	LD IY,BA ; 0c743
	LD A,[IX+16h] ; 0c745
	LD YP,A ; 0c748
	LD B,[1B23h] ; 0c74a
	LD A,[IY] ; 0c74e
	ADD A,[IX+0Ah] ; 0c74f
	POP IX ; 0c752
	POP IY ; 0c753
	POP IP ; 0c754
	CARL loc_0x007982 ; 0c755
	RET
; ---------------------- ; 0c758
	DB 0A3h, 0C6h, 01h, 0A8h, 0C6h, 01h, 97h, 0C6h ; 0c759
	DB 00h, 9Dh, 99h ; 0c761
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
	DB 0B0h, 0F8h
; ---------------------- ; 0c8d5
loc_0x00C8D7:
	LD A,[1AD8h] ; 0c8d7
	CP A,#00h ; 0c8db
	JRS NZ,loc_0x00C8ED ; 0c8dd
	LD A,[1AD7h] ; 0c8df
	CP A,#01h ; 0c8e3
	JRS NZ,loc_0x00C8ED ; 0c8e5
	LD BA,#0C8BEh ; 0c8e7
	CARL loc_0x007948 ; 0c8ea
loc_0x00C8ED:
	RET
; ---------------------- ; 0c8ed
	DB 0D7h, 0C8h, 01h, 19h, 9Bh, 01h, 17h, 9Bh ; 0c8ee
	DB 00h, 9Dh, 99h, 0D7h, 0C9h, 04h, 00h, 0E0h ; 0c8f6
	DB 0B3h, 06h, 00h, 0E4h, 0B3h, 04h, 00h, 0E0h ; 0c8fe
	DB 0B3h, 9Dh, 99h, 0EBh, 0C9h, 01h, 00h, 0E0h ; 0c906
	DB 0B3h, 8Eh, 99h, 9Dh, 99h, 99h, 0C9h, 06h ; 0c90e
	DB 00h, 0E8h, 0B3h, 9Dh, 99h, 0B1h, 0C9h, 06h ; 0c916
	DB 00h, 0E4h, 0B3h, 04h, 00h, 0E0h, 0B3h, 04h ; 0c91e
	DB 00h, 0ECh, 0B3h, 06h, 00h, 0F0h, 0B3h, 06h ; 0c926
	DB 00h, 0ECh, 0B3h, 04h, 00h, 0E0h, 0B3h, 04h ; 0c92e
	DB 00h, 0E4h, 0B3h, 04h, 00h, 0E0h, 0B3h, 9Dh ; 0c936
	DB 99h, 0EBh, 0C9h, 8Eh, 99h, 9Dh, 99h, 0EBh ; 0c93e
	DB 0C9h, 01h, 00h, 0E4h, 0B3h, 8Eh, 99h, 9Dh ; 0c946
	DB 99h, 0EBh, 0C9h, 06h, 00h, 0E4h, 0B3h, 04h ; 0c94e
	DB 00h, 0E0h, 0B3h, 06h, 00h, 0ECh, 0B3h, 04h ; 0c956
	DB 00h, 0E0h, 0B3h, 8Eh, 99h, 9Dh, 99h, 0B1h ; 0c95e
	DB 0C9h, 04h, 00h, 0E0h, 0B3h, 06h, 00h, 0ECh ; 0c966
	DB 0B3h, 04h, 00h, 0E0h, 0B3h, 04h, 00h, 0E4h ; 0c96e
	DB 0B3h, 04h, 00h, 0E0h, 0B3h, 9Dh, 99h, 0EBh ; 0c976
	DB 0C9h, 8Eh, 99h, 9Dh, 99h, 19h, 9Bh, 06h ; 0c97e
	DB 00h, 0E4h, 0B3h, 04h, 00h, 0E0h, 0B3h, 06h ; 0c986
	DB 00h, 0ECh, 0B3h, 04h, 00h, 0E0h, 0B3h, 0C1h ; 0c98e
	DB 99h, 07h, 0C9h, 0B9h ; 0c996
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
	DB 0F2h, 0E9h, 0AEh, 0F8h
; ---------------------- ; 0ca64
loc_0x00CA68:
	LD A,[1AD8h] ; 0ca68
	CP A,#00h ; 0ca6c
	JRS NZ,loc_0x00CA7E ; 0ca6e
	LD A,[1AD7h] ; 0ca70
	CP A,#01h ; 0ca74
	JRS NZ,loc_0x00CA7E ; 0ca76
	LD BA,#0C9EBh ; 0ca78
	CARL loc_0x007948 ; 0ca7b
loc_0x00CA7E:
	RET
; ---------------------- ; 0ca7e
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
	DB 0CCh
; ---------------------- ; 0cc43
loc_0x00CC44:
	LD A,[1643h] ; 0cc44
	BIT A,#01h ; 0cc48
	JRS NZ,loc_0x00CC5F ; 0cc4a
	BIT A,#02h ; 0cc4c
	JRS Z,loc_0x00CC75 ; 0cc4e
	LD A,[1AB6h] ; 0cc50
	AND A,A ; 0cc54
	JRS Z,loc_0x00CC5D ; 0cc55
	LD A,#02h ; 0cc57
	LD [14FAh],A ; 0cc59
loc_0x00CC5D:
	JRS loc_0x00CC6C
; ---------------------- ; 0cc5d
loc_0x00CC5F:
	LD A,[1AB6h] ; 0cc5f
	AND A,A ; 0cc63
	JRS Z,loc_0x00CC6C ; 0cc64
	LD A,#01h ; 0cc66
	LD [14FAh],A ; 0cc68
loc_0x00CC6C:
	CARL loc_0x0022EE ; 0cc6c
	PUSH IY ; 0cc6f
	CARL loc_0x00228F ; 0cc70
	POP IY ; 0cc73
	RET
; ---------------------- ; 0cc74
loc_0x00CC75:
	LD A,[1645h] ; 0cc75
	BIT A,#20h ; 0cc79
	JRS NZ,loc_0x00CC8D ; 0cc7b
	BIT A,#40h ; 0cc7d
	JRS Z,loc_0x00CCA9 ; 0cc7f
	LD A,[1B2Ch] ; 0cc81
	INC A ; 0cc85
	CP A,#0Ch ; 0cc86
	JRS C,loc_0x00CC98 ; 0cc88
	XOR A,A ; 0cc8a
	JRS loc_0x00CC98
; ---------------------- ; 0cc8b
loc_0x00CC8D:
	LD A,[1B2Ch] ; 0cc8d
	DEC A ; 0cc91
	CP A,#0FFh ; 0cc92
	JRS NZ,loc_0x00CC98 ; 0cc94
	LD A,#0Bh ; 0cc96
loc_0x00CC98:
	LD [1B2Ch],A ; 0cc98
	LD A,[1AB6h] ; 0cc9c
	AND A,A ; 0cca0
	JRS Z,loc_0x00CCA9 ; 0cca1
	LD A,#04h ; 0cca3
	LD [14FAh],A ; 0cca5
loc_0x00CCA9:
	LD A,[1B2Ch] ; 0cca9
	LD B,[1B97h] ; 0ccad
	CARL loc_0x00CCC8 ; 0ccb1
	LD L,[IX+18h] ; 0ccb4
	LD H,[IX+19h] ; 0ccb7
	CP BA,HL ; 0ccba
	JRS Z,loc_0x00CCC7 ; 0ccbc
	LD [IX+18h],A ; 0ccbe
	LD [IX+19h],B ; 0ccc1
	CARL loc_0x00794F ; 0ccc4
loc_0x00CCC7:
	RET
; ---------------------- ; 0ccc7
loc_0x00CCC8:
	CP A,#0Bh ; 0ccc8
	JRS C,loc_0x00CCCE ; 0ccca
	LD A,#0Bh ; 0cccc
loc_0x00CCCE:
	PUSH BA ; 0ccce
	LD NB,#03h ; 0cccf
	CARL loc_0x018FAF ; 0ccd2
	POP BA ; 0ccd5
	JRS NZ,loc_0x00CCDC ; 0ccd6
	LD BA,#0CA88h ; 0ccd8
	RET
; ---------------------- ; 0ccdb
loc_0x00CCDC:
	PUSH IP ; 0ccdc
	PUSH IY ; 0ccdd
	LD IY,#0CCFAh ; 0ccde
	LD YP,#00h ; 0cce1
	PUSH A ; 0cce4
	LD A,B ; 0cce6
	ADD A,A ; 0cce7
	LD B,#00h ; 0cce8
	ADD IY,BA ; 0ccea
	LD IY,[IY] ; 0ccec
	POP A ; 0ccee
	ADD A,A ; 0ccf0
	LD B,#00h ; 0ccf1
	ADD IY,BA ; 0ccf3
	LD BA,[IY] ; 0ccf5
	POP IY ; 0ccf7
	POP IP ; 0ccf8
	RET
; ---------------------- ; 0ccf9
	DB 00h, 0CDh, 18h, 0CDh ; 0ccfa
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
	DB 0CCh, 01h, 17h, 9Bh, 00h
; ---------------------- ; 0cd4c
loc_0x00CD51:
	LD A,[1B2Ch] ; 0cd51
	INC A ; 0cd55
	CP A,#0Ch ; 0cd56
	JRS C,loc_0x00CD5B ; 0cd58
	XOR A,A ; 0cd5a
loc_0x00CD5B:
	LD B,[1B97h] ; 0cd5b
	CARL loc_0x00CCC8 ; 0cd5f
	CARL loc_0x00794F ; 0cd62
	RET
; ---------------------- ; 0cd65
	ASCII "q" ; 0cd66
	DB 9Ah, 02h ; 0cd67
	ASCII "Q" ; 0cd69
	DB 0CDh, 01h, 17h, 9Bh, 00h
; ---------------------- ; 0cd6a
loc_0x00CD6F:
	LD A,[1B2Ch] ; 0cd6f
	DEC A ; 0cd73
	CP A,#0FFh ; 0cd74
	JRS NZ,loc_0x00CD7A ; 0cd76
	LD A,#0Bh ; 0cd78
loc_0x00CD7A:
	LD B,[1B97h] ; 0cd7a
	CARL loc_0x00CCC8 ; 0cd7e
	CARL loc_0x00794F ; 0cd81
	RET
; ---------------------- ; 0cd84
	ASCII "q" ; 0cd85
	DB 9Ah, 02h ; 0cd86
	ASCII "o" ; 0cd88
	DB 0CDh, 01h, 17h, 9Bh, 00h, 04h, 00h, 0D0h ; 0cd89
	DB 0AFh, 04h, 00h, 0D4h, 0AFh, 04h, 00h, 0D0h ; 0cd91
	DB 0AFh, 04h, 00h, 0D4h, 0AFh, 01h, 00h, 0D0h ; 0cd99
	DB 0AFh, 8Eh, 99h
; ---------------------- ; 0cda1
loc_0x00CDA4:
	LD A,[1B17h] ; 0cda4
	CP A,#02h ; 0cda8
	JRS Z,loc_0x00CDD0 ; 0cdaa
	CARL loc_0x00AAFE ; 0cdac
	JRS Z,loc_0x00CDC1 ; 0cdaf
	CARL loc_0x009CD3 ; 0cdb1
	JRS loc_0x00CDE4
; ---------------------- ; 0cdb4
	DB 0C5h, 13h, 1Bh, 86h, 0B8h, 12h, 1Bh, 0F2h ; 0cdb6
	DB 0C3h, 0ABh, 0F8h
; ---------------------- ; 0cdbe
loc_0x00CDC1:
	LD A,[1AB6h] ; 0cdc1
	AND A,A ; 0cdc5
	JRS Z,loc_0x00CDCE ; 0cdc6
	LD A,#12h ; 0cdc8
	LD [14FAh],A ; 0cdca
loc_0x00CDCE:
	JRS loc_0x00CDDD
; ---------------------- ; 0cdce
loc_0x00CDD0:
	LD A,[1AB6h] ; 0cdd0
	AND A,A ; 0cdd4
	JRS Z,loc_0x00CDDD ; 0cdd5
	LD A,#21h ; 0cdd7
	LD [14FAh],A ; 0cdd9
loc_0x00CDDD:
	LD BA,#0CE03h ; 0cddd
	CARL loc_0x007948 ; 0cde0
	RET
; ---------------------- ; 0cde3
loc_0x00CDE4:
	LD A,[1AB6h] ; 0cde4
	AND A,A ; 0cde8
	JRS Z,loc_0x00CDF1 ; 0cde9
	LD A,#12h ; 0cdeb
	LD [14FAh],A ; 0cded
loc_0x00CDF1:
	LD HL,#9B19h ; 0cdf1
	LD BA,#0CD9Eh ; 0cdf4
	CARL loc_0x007970 ; 0cdf7
	CARL loc_0x0022D4 ; 0cdfa
	PUSH IY ; 0cdfd
	CARL loc_0x00228F ; 0cdfe
	POP IY ; 0ce01
	RET
; ---------------------- ; 0ce02
loc_0x00CE03:
	LD A,[1B17h] ; 0ce03
	CP A,#02h ; 0ce07
	JRS Z,loc_0x00CE29 ; 0ce09
	CARL loc_0x00AAFE ; 0ce0b
	JRS Z,loc_0x00CE24 ; 0ce0e
	LD A,[1AB6h] ; 0ce10
	AND A,A ; 0ce14
	JRS Z,loc_0x00CE1D ; 0ce15
	LD A,#11h ; 0ce17
	LD [14FAh],A ; 0ce19
loc_0x00CE1D:
	LD BA,#0CDA4h ; 0ce1d
	CARL loc_0x007948 ; 0ce20
	RET
; ---------------------- ; 0ce23
loc_0x00CE24:
	CARL loc_0x009B56 ; 0ce24
	JRS NZ,loc_0x00CE2E ; 0ce27
loc_0x00CE29:
	LD BA,#0CD9Eh ; 0ce29
	JRS loc_0x00CE33
; ---------------------- ; 0ce2c
loc_0x00CE2E:
	LD BA,#0CD8Eh ; 0ce2e
	JRS loc_0x00CE33
; ---------------------- ; 0ce31
loc_0x00CE33:
	LD L,[IX+18h] ; 0ce33
	LD H,[IX+19h] ; 0ce36
	CP HL,BA ; 0ce39
	JRS Z,loc_0x00CE46 ; 0ce3b
	LD [IX+18h],L ; 0ce3d
	LD [IX+19h],H ; 0ce40
	CARL loc_0x00A97D ; 0ce43
loc_0x00CE46:
	LD BA,[1B12h] ; 0ce46
	CARL loc_0x007982 ; 0ce49
	RET
; ---------------------- ; 0ce4c
	ASCII "q" ; 0ce4d
	DB 9Ah, 02h, 03h, 0CEh, 01h, 9Eh, 0CDh, 00h
; ---------------------- ; 0ce4e
loc_0x00CE56:
	LD A,[1B17h] ; 0ce56
	CP A,#02h ; 0ce5a
	JRS Z,loc_0x00CE82 ; 0ce5c
	CARL loc_0x00AAFE ; 0ce5e
	JRS Z,loc_0x00CE73 ; 0ce61
	CARL loc_0x009CD3 ; 0ce63
	JRS loc_0x00CE96
; ---------------------- ; 0ce66
	DB 0C5h, 13h, 1Bh, 86h, 0B8h, 12h, 1Bh, 0F2h ; 0ce68
	DB 11h, 0ABh, 0F8h
; ---------------------- ; 0ce70
loc_0x00CE73:
	LD A,[1AB6h] ; 0ce73
	AND A,A ; 0ce77
	JRS Z,loc_0x00CE80 ; 0ce78
	LD A,#12h ; 0ce7a
	LD [14FAh],A ; 0ce7c
loc_0x00CE80:
	JRS loc_0x00CE8F
; ---------------------- ; 0ce80
loc_0x00CE82:
	LD A,[1AB6h] ; 0ce82
	AND A,A ; 0ce86
	JRS Z,loc_0x00CE8F ; 0ce87
	LD A,#21h ; 0ce89
	LD [14FAh],A ; 0ce8b
loc_0x00CE8F:
	LD BA,#0CEADh ; 0ce8f
	CARL loc_0x007948 ; 0ce92
	RET
; ---------------------- ; 0ce95
loc_0x00CE96:
	LD A,[1AB6h] ; 0ce96
	AND A,A ; 0ce9a
	JRS Z,loc_0x00CEA3 ; 0ce9b
	LD A,#12h ; 0ce9d
	LD [14FAh],A ; 0ce9f
loc_0x00CEA3:
	LD HL,#0CF06h ; 0cea3
	LD BA,#0CD9Eh ; 0cea6
	CARL loc_0x007970 ; 0cea9
	RET
; ---------------------- ; 0ceac
loc_0x00CEAD:
	LD A,[1B17h] ; 0cead
	CP A,#02h ; 0ceb1
	JRS Z,loc_0x00CED8 ; 0ceb3
	CARL loc_0x00AAFE ; 0ceb5
	JRS Z,loc_0x00CED3 ; 0ceb8
	CARL loc_0x009CD3 ; 0ceba
	JRS loc_0x00CEFC
; ---------------------- ; 0cebd
loc_0x00CEBF:
	LD A,[1AB6h] ; 0cebf
	AND A,A ; 0cec3
	JRS Z,loc_0x00CECC ; 0cec4
	LD A,#11h ; 0cec6
	LD [14FAh],A ; 0cec8
loc_0x00CECC:
	LD BA,#0CE56h ; 0cecc
	CARL loc_0x007948 ; 0cecf
	RET
; ---------------------- ; 0ced2
loc_0x00CED3:
	CARL loc_0x009B56 ; 0ced3
	JRS NZ,loc_0x00CEDD ; 0ced6
loc_0x00CED8:
	LD BA,#0CD9Eh ; 0ced8
	JRS loc_0x00CEE2
; ---------------------- ; 0cedb
loc_0x00CEDD:
	LD BA,#0CD8Eh ; 0cedd
	JRS loc_0x00CEE2
; ---------------------- ; 0cee0
loc_0x00CEE2:
	LD L,[IX+18h] ; 0cee2
	LD H,[IX+19h] ; 0cee5
	CP HL,BA ; 0cee8
	JRS Z,loc_0x00CEF5 ; 0ceea
	LD [IX+18h],L ; 0ceec
	LD [IX+19h],H ; 0ceef
	CARL loc_0x00A97D ; 0cef2
loc_0x00CEF5:
	LD BA,[1B12h] ; 0cef5
	CARL loc_0x007982 ; 0cef8
	RET
; ---------------------- ; 0cefb
loc_0x00CEFC:
	LD HL,#0CF06h ; 0cefc
	LD BA,#0CD9Eh ; 0ceff
	CARL loc_0x007970 ; 0cf02
	RET
; ---------------------- ; 0cf05
loc_0x00CF06:
	LD A,[1B17h] ; 0cf06
	CP A,#02h ; 0cf0a
	JRS Z,loc_0x00CF38 ; 0cf0c
	CARL loc_0x009B56 ; 0cf0e
	JRS Z,loc_0x00CF43 ; 0cf11
	CARL loc_0x00A010 ; 0cf13
	LD A,[1ADAh] ; 0cf16
	OR A,A ; 0cf1a
	JRS NZ,loc_0x00CF30 ; 0cf1b
	LD HL,#9B19h ; 0cf1d
	LD BA,#0CD9Eh ; 0cf20
	CARL loc_0x007970 ; 0cf23
	CARL loc_0x0022D4 ; 0cf26
	PUSH IY ; 0cf29
	CARL loc_0x00228F ; 0cf2a
	POP IY ; 0cf2d
	JRS loc_0x00CF43
; ---------------------- ; 0cf2e
loc_0x00CF30:
	LD BA,#0CD9Eh ; 0cf30
	CARL loc_0x00794F ; 0cf33
	JRS loc_0x00CF43
; ---------------------- ; 0cf36
loc_0x00CF38:
	XOR A,A ; 0cf38
	LD [1AE8h],A ; 0cf39
	LD BA,#0CEADh ; 0cf3d
	CARL loc_0x007948 ; 0cf40
loc_0x00CF43:
	RET
; ---------------------- ; 0cf43
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
loc_0x010096:
	LD A,[168Dh] ; 10096
	CARL loc_0x0115EE ; 1009a
	RET
; ---------------------- ; 1009d
loc_0x01009E:
	LD IY,#0057h ; 1009e
	LD YP,#01h ; 100a1
	LD A,[168Dh] ; 100a4
	CARL loc_0x011610 ; 100a8
	LD [168Dh],A ; 100ab
	RET
; ---------------------- ; 100af
	DB 93h, 80h, 9Eh, 80h, 87h, 00h
; ---------------------- ; 100b0
loc_0x0100B6:
	LD A,[1AB9h] ; 100b6
	LD B,#00h ; 100ba
	LD IY,#00CCh ; 100bc
	LD YP,#01h ; 100bf
	ADD IY,BA ; 100c2
	ADD IY,BA ; 100c4
	LD BA,[IY] ; 100c6
	CARL loc_0x007948 ; 100c8
	RET
; ---------------------- ; 100cb
	DB 0E4h, 80h, 0EDh, 80h ; 100cc
	ASCII "i" ; 100d0
	DB 81h
; ---------------------- ; 100d1
loc_0x0100D2:

	LD A,[1AB9h] ; 100d2
	INC A ; 100d6
	CP A,#03h ; 100d7
	JRS NZ,loc_0x0100DC ; 100d9

	XOR A,A ; 100db

loc_0x0100DC:

	LD [1AB9h],A ; 100dc

	CARL loc_0x0100B6 ; 100e0

	RET

; ---------------------- ; 100e3
loc_0x0100E4:

	LD HL,#1643h ; 100e4
	BIT [HL],#04h ; 100e7
	CARL NZ,loc_0x0100D2 ; 100e9

	RET

; ---------------------- ; 100ec
loc_0x0100ED:

	LD HL,#1643h ; 100ed
	BIT [HL],#04h ; 100f0
	CARL NZ,loc_0x0100D2 ; 100f2

	PUSH IP ; 100f5
	PUSH IX ; 100f6

	LD IX,#15AAh ; 100f7
	LD XP,#00h ; 100fa

	CARL loc_0x004706 ; 100fd

	POP IX ; 10100

	LD IY,[190Fh] ; 10101
	LD YP,#00h ; 10104

	LD A,[15ADh] ; 10107

	CARL loc_0x002575 ; 1010b

	PUSH B ; 1010e

	ADD A,#10h ; 10110

	LD B,#08h ; 10112
	LD L,#5Dh ; 10114
	LD H,#12h ; 10116
	CARL loc_0x00258F ; 10118

	POP A ; 1011b

	ADD A,#10h ; 1011d

	LD B,#08h ; 1011f
	LD L,#58h ; 10121
	LD H,#12h ; 10123
	CARL loc_0x00258F ; 10125

	LD A,[IX+18h] ; 10128
	INC A ; 1012b
	CP A,#24h ; 1012c
	JRS NZ,loc_0x010131 ; 1012e
	
	XOR A,A ; 10130

loc_0x010131:

	LD [IX+18h],A ; 10131

	CP A,#12h ; 10134
	JRS NC,loc_0x010143 ; 10136

	LD A,#1Bh ; 10138
	LD B,#08h ; 1013a
	LD L,#63h ; 1013c
	LD H,#12h ; 1013e
	CARL loc_0x00258F ; 10140

loc_0x010143:

	LD A,[15AEh] ; 10143
	CARL loc_0x002575 ; 10147

	PUSH B ; 1014a

	ADD A,#10h ; 1014c
	LD B,#08h ; 1014e
	LD L,#6Ah ; 10150
	LD H,#12h ; 10152
	CARL loc_0x00258F ; 10154

	POP A ; 10157

	ADD A,#10h ; 10159
	LD B,#08h ; 1015b
	LD L,#65h ; 1015d
	LD H,#12h ; 1015f
	CARL loc_0x00258F ; 10161

	LD [190Fh],IY ; 10164

	POP IP ; 10167

	RET

; ---------------------- ; 10168
loc_0x010169:

	LD HL,#1643h ; 10169
	BIT [HL],#04h ; 1016c
	CARL NZ,loc_0x0100D2 ; 1016e

	PUSH IP ; 10171
	PUSH IX ; 10172

	LD IX,#15AAh ; 10173
	LD XP,#00h ; 10176
	CARL loc_0x004706 ; 10179

	POP IX ; 1017c

	LD IY,[190Fh] ; 1017d
	LD YP,#00h ; 10180
	LD A,[15AAh] ; 10183
	CARL loc_0x002575 ; 10187

	PUSH B ; 1018a

	ADD A,#10h ; 1018c

	LD B,#08h ; 1018e
	LD L,#4Eh ; 10190
	LD H,#12h ; 10192
	CARL loc_0x00258F ; 10194

	POP A ; 10197

	ADD A,#10h ; 10199

	LD B,#08h ; 1019b
	LD L,#49h ; 1019d
	LD H,#12h ; 1019f
	CARL loc_0x00258F ; 101a1

	LD A,#1Ah ; 101a4

	LD B,#08h ; 101a6
	LD L,#53h ; 101a8
	LD H,#12h ; 101aa
	CARL loc_0x00258F ; 101ac

	LD A,[15ABh] ; 101af
	CARL loc_0x002575 ; 101b3

	PUSH B ; 101b6

	ADD A,#10h ; 101b8

	LD B,#08h ; 101ba
	LD L,#5Ch ; 101bc
	LD H,#12h ; 101be
	CARL loc_0x00258F ; 101c0

	POP A ; 101c3

	ADD A,#10h ; 101c5

	LD B,#08h ; 101c7
	LD L,#57h ; 101c9
	LD H,#12h ; 101cb
	CARL loc_0x00258F ; 101cd

	LD A,#1Ah ; 101d0

	LD B,#08h ; 101d2
	LD L,#61h ; 101d4
	LD H,#12h ; 101d6
	CARL loc_0x00258F ; 101d8

	LD A,[15ACh] ; 101db
	CARL loc_0x002575 ; 101df

	PUSH B ; 101e2

	ADD A,#10h ; 101e4

	LD B,#08h ; 101e6
	LD L,#6Ah ; 101e8
	LD H,#12h ; 101ea
	CARL loc_0x00258F ; 101ec

	POP A ; 101ef

	ADD A,#10h ; 101f1

	LD B,#08h ; 101f3
	LD L,#65h ; 101f5
	LD H,#12h ; 101f7
	CARL loc_0x00258F ; 101f9

	LD [190Fh],IY ; 101fc

	POP IP ; 101ff

	RET

; ---------------------- ; 10200
	DB 0B6h, 80h, 0E4h, 80h ; 10201
	ASCII "v" ; 10205
	DB 1Ah
; ---------------------- ; 10206
loc_0x010207:

	LD A,[1AB6h] ; 10207
	LD B,#00h ; 1020b

loc_0x01020D:

	LD IY,#021Dh ; 1020d
	LD YP,#01h ; 10210
	ADD IY,BA ; 10213
	ADD IY,BA ; 10215
	LD BA,[IY] ; 10217

	CARL loc_0x00794F ; 10219

	RET

; ---------------------- ; 1021c
	ASCII "r" ; 1021d
	DB 1Ah, 23h, 02h, 2Ch, 02h, 3Dh, 9Ah, 01h ; 1021e
	DB 08h, 00h, 0B0h, 0ACh, 8Eh, 99h, 3Dh, 9Ah ; 10226
	DB 01h, 08h, 00h, 0B8h, 0ACh, 8Eh, 99h
; ---------------------- ; 1022e
loc_0x010235:

	LD A,[1ABBh] ; 10235
	CP A,#00h ; 10239
	JRS NZ,loc_0x01024F ; 1023b

	LD A,[1645h] ; 1023d
	BIT A,#20h ; 10241
	CARL NZ,loc_0x010250 ; 10243

	LD A,[1645h] ; 10246
	BIT A,#40h ; 1024a
	CARL NZ,loc_0x010266 ; 1024c

loc_0x01024F:

	RET

; ---------------------- ; 1024f
loc_0x010250:

	LD HL,#1AB6h ; 10250
	CP [HL],#00h ; 10253
	JRS Z,loc_0x010265 ; 10256

	DEC [HL] ; 10258
	LD A,[HL] ; 10259

	XOR A,A ; 1025a
	LD [1AB5h],A ; 1025b

	CARL loc_0x0026C6 ; 1025f
	CARL loc_0x010207 ; 10262

loc_0x010265:

	RET

; ---------------------- ; 10265
loc_0x010266:
	LD HL,#1AB6h ; 10266
	CP [HL],#02h ; 10269
	JRS Z,loc_0x01027A ; 1026c

	INC [HL] ; 1026e

	XOR A,A ; 1026f
	LD [1AB5h],A ; 10270

	CARL loc_0x0026C6 ; 10274
	CARL loc_0x010207 ; 10277

loc_0x01027A:

	RET

; ---------------------- ; 1027a
	DB 07h, 82h ; 1027b
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
	DB 0FFh, 0F8h, 81h, 82h, 0C5h, 82h, 0A1h, 02h
; ---------------------- ; 10308
loc_0x010310:

	LD A,[1AB8h] ; 10310
	LD B,#00h ; 10314

	LD IY,#0327h ; 10316
	LD YP,#01h ; 10319

	ADD IY,BA ; 1031c
	ADD IY,BA ; 1031e

	LD BA,[IY] ; 10320
	CARL loc_0x00794F ; 10322

	RET

; ---------------------- ; 10325
	DB 0F8h, 2Bh, 03h, 3Ah, 03h, 3Dh, 9Ah, 01h ; 10326
	DB 08h, 00h, 0F8h, 0ACh, 08h, 00h, 04h, 0ADh ; 1032e
	DB 0C1h, 99h, 2Eh, 03h, 3Dh, 9Ah, 01h, 08h ; 10336
	DB 00h, 0E0h, 0ACh, 08h, 00h, 0ECh, 0ACh, 0C1h ; 1033e
	DB 99h, 3Dh, 03h, 0CEh, 0D0h, 0BBh, 1Ah ; 10346
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
	DB 06h, 0FFh, 0FEh, 0FEh, 5Bh, 04h
; ---------------------- ; 104a4
loc_0x0104AA:

	LD A,[IX+0Eh] ; 104aa
	LD B,[IX+0Fh] ; 104ad

	AND A,#0C0h ; 104b0

	LD [165Bh],BA ; 104b2
	LD [1632h],A ; 104b5

	SUB BA,#0010h ; 104b9
	LD [165Fh],BA ; 104bc

	RET

; ---------------------- ; 104bf
loc_0x0104C0:

	LD IY,#046Ah ; 104c0
	LD A,[1ABBh] ; 104c3
	CARL loc_0x0115EE ; 104c7
	CARL loc_0x0104AA ; 104ca

	RET

; ---------------------- ; 104cd
loc_0x0104CE:

	LD IY,#046Ah ; 104ce
	LD YP,#01h ; 104d1
	LD A,[1ABBh] ; 104d4
	CARL loc_0x011610 ; 104d8

	LD [1ABBh],A ; 104db

	CARL loc_0x0104AA ; 104df

	RET

; ---------------------- ; 104e2
	DB 0C0h, 84h, 0CEh, 84h, 0F2h, 03h, 3Dh, 9Ah ; 104e3
	DB 01h, 0D6h, 99h, 00h, 00h ; 104eb
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
	DB 07h, 0C1h, 99h, 85h, 07h, 0F8h
; ---------------------- ; 1078c
loc_0x010792:

	LD A,[1BB3h] ; 10792
	CP A,#00h ; 10796
	JRS Z,loc_0x0107A0 ; 10798

	LD A,#64h ; 1079a
	LD [IX+0Ah],A ; 1079c

	RET

; ---------------------- ; 1079f
loc_0x0107A0:

	LD A,[1BB5h] ; 107a0
	LD B,#00h ; 107a4

	LD IY,#07B0h ; 107a6
	ADD IY,BA ; 107a9

	LD A,[IY] ; 107ab
	LD [IX+0Ah],A ; 107ac

	RET

; ---------------------- ; 107af
	DB 18h, 20h, 28h ; 107b0
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
	DB 16h, 0D0h, 10h, 00h, 0BCh, 5Fh, 16h, 0F8h
; ---------------------- ; 115e6
loc_0x0115EE:
	LD L,#08h ; 115ee
	MLT ; 115f0

	ADD IY,HL ; 115f2
	PUSH IY ; 115f4

	LD YP,#01h ; 115f5
	LD BA,[IY] ; 115f8
	CARL loc_0x007982 ; 115fa

	POP IY ; 115fd

	LD YP,#01h ; 115fe
	LD A,[IY+06h] ; 11601
	LD B,[IY+07h] ; 11604

	CP BA,#0000h ; 11607
	JRS Z,loc_0x01160F ; 1160a

	CARL loc_0x00794F ; 1160c

loc_0x01160F:

	RET

; ---------------------- ; 1160f
loc_0x011610:

	PUSH A ; 11610

	LD HL,#1645h ; 11612
	BIT [HL],#78h ; 11615
	JRS Z,loc_0x01166A ; 11617

	PUSH IY ; 11619

	LD L,#08h ; 1161a
	MLT ; 1161c

	ADD IY,HL ; 1161e

	LD HL,#1645h ; 11620

	BIT [HL],#08h ; 11623
	CARL NZ,loc_0x01167D ; 11625

	BIT [HL],#10h ; 11628
	CARL NZ,loc_0x011681 ; 1162a

	BIT [HL],#20h ; 1162d
	CARL NZ,loc_0x011685 ; 1162f

	BIT [HL],#40h ; 11632
	CARL NZ,loc_0x011689 ; 11634

	POP IY ; 11637

	CP A,#0FEh ; 11638
	JRS Z,loc_0x01167A ; 1163a

	CP A,#0FFh ; 1163c
	JRS Z,loc_0x01166D ; 1163e

	LD L,#08h ; 11640
	MLT ; 11642

	ADD IY,HL ; 11644

	POP B ; 11646
	PUSH A ; 11648

	LD BA,[IY] ; 1164a
	CARL loc_0x007982 ; 1164c

	LD A,[IY+06h] ; 1164f
	LD B,[IY+07h] ; 11652

	CP BA,#0000h ; 11655
	JRS Z,loc_0x01165D ; 11658

	CARL loc_0x00794F ; 1165a

loc_0x01165D:

	LD A,[1AB6h] ; 1165d
	AND A,A ; 11661
	JRS Z,loc_0x01166A ; 11662

	LD A,#04h ; 11664
	LD [14FAh],A ; 11666

loc_0x01166A:

	POP A ; 1166a

	RET
; ---------------------- ; 1166c
loc_0x01166D:

	LD A,[1AB6h] ; 1166d
	AND A,A ; 11671
	JRS Z,loc_0x01167A ; 11672

	LD A,#03h ; 11674
	LD [14FAh],A ; 11676

loc_0x01167A:

	POP A ; 1167a

	RET

; ---------------------- ; 1167c
loc_0x01167D:

	LD A,[IY+02h] ; 1167d

	RET

; ---------------------- ; 11680
loc_0x011681:

	LD A,[IY+03h] ; 11681

	RET

; ---------------------- ; 11684
loc_0x011685:

	LD A,[IY+04h] ; 11685

	RET

; ---------------------- ; 11688
loc_0x011689:

	LD A,[IY+05h] ; 11689

	RET

; ---------------------- ; 1168c
loc_0x01168D:

	LD IX,#168Fh ; 1168d
	LD XP,#00h ; 11690
	LD HL,[190Fh] ; 11693
	LD EP,#00h ; 11696
	LD B,#04h ; 11699

loc_0x01169B:

	PUSH B ; 1169b

	LD A,[IX] ; 1169d
	OR A,[IX+01h] ; 1169e
	JRS Z,loc_0x0116C5 ; 116a1

	LD A,[IX+0Ah] ; 116a3
	ADD A,#10h ; 116a6
	LD [1913h],A ; 116a8

	LD A,[IX+0Eh] ; 116ac
	ADD A,#10h ; 116af
	LD [1914h],A ; 116b1

	LD A,[IX+14h] ; 116b5
	LD B,[IX+15h] ; 116b8
	LD IY,BA ; 116bb

	LD A,[IX+16h] ; 116bd
	LD YP,A ; 116c0
	CARL loc_0x011C35 ; 116c2

loc_0x0116C5:

	ADD IX,#0020h ; 116c5

	POP B ; 116c8

	DJR NZ,loc_0x01169B ; 116ca

	LD [190Fh],HL ; 116cc

	RET

; ---------------------- ; 116cf
loc_0x0116D0:

	LD IX,#170Fh ; 116d0
	LD XP,#00h ; 116d3

	LD HL,[190Fh] ; 116d6
	LD EP,#00h ; 116d9

	LD B,#02h ; 116dc

loc_0x0116DE:

	PUSH B ; 116de

	LD A,[IX] ; 116e0
	OR A,[IX+01h] ; 116e1
	JRS Z,loc_0x011724 ; 116e4

	LD IY,[165Dh] ; 116e6
	LD A,[IX+0Ah] ; 116e9
	LD B,[IX+0Bh] ; 116ec
	SUB BA,IY ; 116ef

	LD [1913h],A ; 116f1

	ADD BA,#0010h ; 116f5
	CP BA,#00A0h ; 116f8
	JRS NC,loc_0x011724 ; 116fb

	LD IY,[165Fh] ; 116fd
	LD A,[IX+0Eh] ; 11700
	LD B,[IX+0Fh] ; 11703
	SUB BA,IY ; 11706

	LD [1914h],A ; 11708

	ADD BA,#0010h ; 1170c
	CP BA,#0080h ; 1170f
	JRS NC,loc_0x011724 ; 11712

	LD A,[IX+14h] ; 11714
	LD B,[IX+15h] ; 11717
	LD IY,BA ; 1171a

	LD A,[IX+16h] ; 1171c
	LD YP,A ; 1171f
	CARL loc_0x011C35 ; 11721

loc_0x011724:

	ADD IX,#0020h ; 11724

	POP B ; 11727

	DJR NZ,loc_0x0116DE ; 11729

	LD [190Fh],HL ; 1172b

	RET

; ---------------------- ; 1172e
loc_0x01172F:

	LD IX,#174Fh ; 1172f
	LD XP,#00h ; 11732

	LD HL,[190Fh] ; 11735
	LD EP,#00h ; 11738

	LD B,#0Eh ; 1173b

loc_0x01173D:

	PUSH B ; 1173d

	LD A,[IX] ; 1173f
	OR A,[IX+01h] ; 11740
	JRS Z,loc_0x011783 ; 11743

	LD IY,[165Dh] ; 11745
	LD A,[IX+0Ah] ; 11748
	LD B,[IX+0Bh] ; 1174b

	SUB BA,IY ; 1174e
	LD [1913h],A ; 11750

	ADD BA,#0010h ; 11754
	CP BA,#00A0h ; 11757
	JRS NC,loc_0x011783 ; 1175a

	LD IY,[165Fh] ; 1175c
	LD A,[IX+0Eh] ; 1175f
	LD B,[IX+0Fh] ; 11762

	SUB BA,IY ; 11765
	LD [1914h],A ; 11767

	ADD BA,#0010h ; 1176b
	CP BA,#0080h ; 1176e
	JRS NC,loc_0x011783 ; 11771

	LD A,[IX+14h] ; 11773
	LD B,[IX+15h] ; 11776

	LD IY,BA ; 11779
	LD A,[IX+16h] ; 1177b

	LD YP,A ; 1177e
	CARL loc_0x011C35 ; 11780

loc_0x011783:

	ADD IX,#0020h ; 11783

	POP B ; 11786

	DJR NZ,loc_0x01173D ; 11788

	LD [190Fh],HL ; 1178a

	RET

; ---------------------- ; 1178d
	DB 0A6h, 0A2h, 0A0h, 0CEh, 0C7h, 01h, 0C6h, 8Fh ; 1178e
	DB 16h, 0CEh, 0C6h, 00h, 0CEh, 0C5h, 00h, 0B1h ; 11796
	DB 04h ; 1179e
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
	DB 0FFh, 20h, 0AAh, 0AEh, 0F8h
; ---------------------- ; 1183d
loc_0x011842:

	LD BA,[IX] ; 11842

	CP BA,#0AA34h ; 11844
	JRS Z,loc_0x011871 ; 11847

	CP BA,#354Ch ; 11849
	JRS Z,loc_0x011871 ; 1184c

	CP BA,#3B14h ; 1184e
	JRS Z,loc_0x011871 ; 11851

	CP BA,#401Ch ; 11853
	JRS Z,loc_0x011871 ; 11856

	CP BA,#4517h ; 11858
	JRS Z,loc_0x011871 ; 1185b

	CP BA,#4A12h ; 1185d
	JRS Z,loc_0x011871 ; 11860

	CP BA,#0B6EEh ; 11862
	JRS Z,loc_0x011871 ; 11865

	CP BA,#0C8EEh ; 11867
	JRS NZ,loc_0x011874 ; 1186a

	SUB IX,#00E0h ; 1186c

	JRS loc_0x011874

; ---------------------- ; 1186f
loc_0x011871:

	ADD IX,#0020h ; 11871

loc_0x011874:

	RET

; ---------------------- ; 11874
loc_0x011875:
	LD IX,#168Fh ; 11875
	LD XP,#00h ; 11878

	LD HL,[190Fh] ; 1187b
	LD EP,#00h ; 1187e

	LD B,#14h ; 11881

loc_0x011883:

	PUSH B ; 11883

	LD A,[IX] ; 11885
	OR A,[IX+01h] ; 11886
	JRS Z,loc_0x0118E9 ; 11889

	PUSH IX ; 1188b

	CARL loc_0x011842 ; 1188c

	LD A,[IX+17h] ; 1188f
	BIT A,#01h ; 11892
	JRS Z,loc_0x0118C6 ; 11894

	LD IY,[165Dh] ; 11896
	LD A,[IX+0Ah] ; 11899
	LD B,[IX+0Bh] ; 1189c

	SUB BA,IY ; 1189f
	LD [1913h],A ; 118a1

	ADD BA,#0010h ; 118a5
	CP BA,#00A0h ; 118a8
	JRS NC,loc_0x0118E9 ; 118ab

	LD IY,[165Fh] ; 118ad
	LD A,[IX+0Eh] ; 118b0
	LD B,[IX+0Fh] ; 118b3

	SUB BA,IY ; 118b6
	LD [1914h],A ; 118b8

	ADD BA,#0010h ; 118bc
	CP BA,#0080h ; 118bf
	JRS NC,loc_0x0118E9 ; 118c2

	JRS loc_0x0118D8

loc_0x0118C6:

	LD A,[IX+0Ah] ; 118c6
	ADD A,#10h ; 118c9
	LD [1913h],A ; 118cb

	LD A,[IX+0Eh] ; 118cf
	ADD A,#10h ; 118d2
	LD [1914h],A ; 118d4

loc_0x0118D8:

	LD A,[IX+14h] ; 118d8
	LD B,[IX+15h] ; 118db
	LD IY,BA ; 118de

	LD A,[IX+16h] ; 118e0
	LD YP,A ; 118e3
	CARL loc_0x011C35 ; 118e5

	POP IX ; 118e8

loc_0x0118E9:

	ADD IX,#0020h ; 118e9

	POP B ; 118ec

	DJR NZ,loc_0x011883 ; 118ee

	LD [190Fh],HL ; 118f0

	RET

; ---------------------- ; 118f3
loc_0x0118F4:

	LD BA,[IX] ; 118f4
	CP BA,#2775h ; 118f6
	JRS Z,loc_0x011908 ; 118f9

	CP BA,#614Fh ; 118fb
	JRS NZ,loc_0x011905 ; 118fe

	SUB IX,#0060h ; 11900

	JRS loc_0x011908

loc_0x011905:

	ADD IX,#0020h ; 11905

loc_0x011908:

	RET

; ---------------------- ; 11908
loc_0x011909:

	LD IX,#168Fh ; 11909
	LD XP,#00h ; 1190c

	LD HL,[190Fh] ; 1190f
	LD EP,#00h ; 11912

	LD B,#14h ; 11915

loc_0x011917:

	PUSH B ; 11917

	LD A,[IX] ; 11919
	OR A,[IX+01h] ; 1191a
	JRS Z,loc_0x01197D ; 1191d

	PUSH IX ; 1191f

	CARL loc_0x0118F4 ; 11920

	LD A,[IX+17h] ; 11923
	BIT A,#01h ; 11926
	JRS Z,loc_0x01195A ; 11928

	LD IY,[165Dh] ; 1192a
	LD A,[IX+0Ah] ; 1192d
	LD B,[IX+0Bh] ; 11930

	SUB BA,IY ; 11933
	LD [1913h],A ; 11935

	ADD BA,#0010h ; 11939
	CP BA,#00A0h ; 1193c
	JRS NC,loc_0x01197D ; 1193f

	LD IY,[165Fh] ; 11941
	LD A,[IX+0Eh] ; 11944
	LD B,[IX+0Fh] ; 11947

	SUB BA,IY ; 1194a
	LD [1914h],A ; 1194c

	ADD BA,#0010h ; 11950
	CP BA,#0080h ; 11953
	JRS NC,loc_0x01197D ; 11956

	JRS loc_0x01196C

loc_0x01195A:

	LD A,[IX+0Ah] ; 1195a
	ADD A,#10h ; 1195d
	LD [1913h],A ; 1195f

	LD A,[IX+0Eh] ; 11963
	ADD A,#10h ; 11966
	LD [1914h],A ; 11968

loc_0x01196C:

	LD A,[IX+14h] ; 1196c
	LD B,[IX+15h] ; 1196f
	LD IY,BA ; 11972

	LD A,[IX+16h] ; 11974
	LD YP,A ; 11977
	CARL loc_0x011C35 ; 11979

	POP IX ; 1197c

loc_0x01197D:

	ADD IX,#0020h ; 1197d

	POP B ; 11980

	DJR NZ,loc_0x011917 ; 11982

	LD [190Fh],HL ; 11984

	RET

; ---------------------- ; 11987
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
	DB 1Ah, 8Eh, 99h, 88h, 99h
; ---------------------- ; 11a75
loc_0x011A7A:

	XOR A,A ; 11a7a

	LD [15B4h],A ; 11a7b
	LD [15B8h],A ; 11a7f
	LD [15BCh],A ; 11a83
	LD [15C0h],A ; 11a87
	LD [15C4h],A ; 11a8b
	LD [15C8h],A ; 11a8f
	LD [15CCh],A ; 11a93
	LD [15D0h],A ; 11a97
	LD [15D4h],A ; 11a9b
	LD [15D8h],A ; 11a9f
	LD [15DCh],A ; 11aa3
	LD [15E0h],A ; 11aa7
	LD [15E4h],A ; 11aab
	LD [15E8h],A ; 11aaf
	LD [15ECh],A ; 11ab3
	LD [15F0h],A ; 11ab7
	LD [15F4h],A ; 11abb
	LD [15F8h],A ; 11abf
	LD [15FCh],A ; 11ac3
	LD [1600h],A ; 11ac7
	LD [1604h],A ; 11acb
	LD [1608h],A ; 11acf
	LD [160Ch],A ; 11ad3
	LD [1610h],A ; 11ad7

	RET

; ---------------------- ; 11adb
loc_0x011ADC:
	LD HL,#168Fh ; 11adc

	LD EP,#00h ; 11adf
	LD IY,#0000h ; 11ae2

	LD B,#14h ; 11ae5

	LD IX,#0020h ; 11ae7

loc_0x011AEA:

	LD [HL],IY ; 11aea
	ADD HL,IX ; 11aec

	DJR NZ,loc_0x011AEA ; 11aee

	LD NB,#02h ; 11af0
	CARL loc_0x011A7A ; 11af3

	LD BA,#15B1h ; 11af6
	LD [166Dh],BA ; 11af9

	LD HL,#15B1h ; 11afc
	LD [190Fh],HL ; 11aff

	RET

; ---------------------- ; 11b02
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

loc_0x011BE5:

	LD BA,IY ; 11be5
	LD [IX+02h],A ; 11be7
	LD [IX+03h],B ; 11bea
	JRS loc_0x011C05

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

loc_0x011C0D:

	JP HL

; ---------------------- ; 11c0d
loc_0x011C0E:

	LD YP,#01h ; 11c0e
	LD IX,#168Fh ; 11c11

	LD XP,#00h ; 11c14
	LD EP,#00h ; 11c17

	LD B,#14h ; 11c1a

loc_0x011C1C:

	PUSH B ; 11c1c

	LD A,[IX] ; 11c1e
	OR A,[IX+01h] ; 11c1f
	JRS Z,loc_0x011C2C ; 11c22

	LD L,[IX+04h] ; 11c24
	LD H,[IX+05h] ; 11c27
	CARS loc_0x011C34 ; 11c2a

loc_0x011C2C:

	ADD IX,#0020h ; 11c2c

	POP B ; 11c2f

	DJR NZ,loc_0x011C1C ; 11c31

	RET

loc_0x011C34:

	JP HL

; ---------------------- ; 11c34
loc_0x011C35:

	CP HL,#1611h ; 11c35
	JRS NC,loc_0x011C63 ; 11c38

	LD A,[IY] ; 11c3a
	ADD A,[1913h] ; 11c3b
	JRS Z,loc_0x011C64 ; 11c3e

	CP A,#70h ; 11c40
	JRS NC,loc_0x011C64 ; 11c42

	LD [HL],A ; 11c44
	INC IY ; 11c45
	INC HL ; 11c46

	LD A,[IY] ; 11c47
	ADD A,[1914h] ; 11c48
	JRS Z,loc_0x011C6C ; 11c4b

	CP A,#50h ; 11c4d
	JRS NC,loc_0x011C6C ; 11c4f

	LD [HL],A ; 11c51
	INC IY ; 11c52
	INC HL ; 11c53

	LD [HL],[IY] ; 11c54
	INC IY ; 11c55
	INC HL ; 11c56

	LD A,[IY] ; 11c57
	BIT A,#08h ; 11c58
	JRS Z,loc_0x011C75 ; 11c5a

	LD [HL],A ; 11c5c
	INC IY ; 11c5d
	INC HL ; 11c5e

loc_0x011C5F:

	BIT A,#80h ; 11c5f
	JRS Z,loc_0x011C35 ; 11c61

loc_0x011C63:

	RET

; ---------------------- ; 11c63
loc_0x011C64:

	LD A,[IY+03h] ; 11c64
	ADD IY,#0004h ; 11c67
	JRS loc_0x011C5F

loc_0x011C6C:

	LD A,[IY+02h] ; 11c6c
	ADD IY,#0003h ; 11c6f
	DEC HL ; 11c72
	JRS loc_0x011C5F

loc_0x011C75:

	INC IY ; 11c75
	SUB HL,#0003h ; 11c76
	JRS loc_0x011C5F

loc_0x011C7B:

	LD IX,#168Fh ; 11c7b
	LD XP,#00h ; 11c7e

	LD HL,[190Fh] ; 11c81
	LD EP,#00h ; 11c84

	LD B,#14h ; 11c87

loc_0x011C89:

	PUSH B ; 11c89

	LD A,[IX] ; 11c8b
	OR A,[IX+01h] ; 11c8c
	JRS Z,loc_0x011CEA ; 11c8f

	LD A,[IX+17h] ; 11c91
	BIT A,#01h ; 11c94
	JRS Z,loc_0x011CC8 ; 11c96

	LD IY,[165Dh] ; 11c98
	LD A,[IX+0Ah] ; 11c9b
	LD B,[IX+0Bh] ; 11c9e
	SUB BA,IY ; 11ca1

	LD [1913h],A ; 11ca3

	ADD BA,#0010h ; 11ca7
	CP BA,#00A0h ; 11caa
	JRS NC,loc_0x011CEA ; 11cad

	LD IY,[165Fh] ; 11caf
	LD A,[IX+0Eh] ; 11cb2
	LD B,[IX+0Fh] ; 11cb5
	SUB BA,IY ; 11cb8

	LD [1914h],A ; 11cba

	ADD BA,#0010h ; 11cbe
	CP BA,#0080h ; 11cc1
	JRS NC,loc_0x011CEA ; 11cc4

	JRS loc_0x011CDA

loc_0x011CC8:

	LD A,[IX+0Ah] ; 11cc8
	ADD A,#10h ; 11ccb
	LD [1913h],A ; 11ccd
	LD A,[IX+0Eh] ; 11cd1
	ADD A,#10h ; 11cd4
	LD [1914h],A ; 11cd6

loc_0x011CDA:

	LD A,[IX+14h] ; 11cda
	LD B,[IX+15h] ; 11cdd
	LD IY,BA ; 11ce0

	LD A,[IX+16h] ; 11ce2
	LD YP,A ; 11ce5
	CARL loc_0x011C35 ; 11ce7

loc_0x011CEA:

	ADD IX,#0020h ; 11cea

	POP B ; 11ced

	DJR NZ,loc_0x011C89 ; 11cef

	LD [190Fh],HL ; 11cf1

	RET

; ---------------------- ; 11cf4
loc_0x011CF5:

	LD HL,[190Fh] ; 11cf5
	XOR A,A ; 11cf8
	JRS loc_0x011CFF

loc_0x011CFB:

	LD [HL],A ; 11cfb
	ADD HL,#0004h ; 11cfc

loc_0x011CFF:

	CP HL,#1611h ; 11cff
	JRS C,loc_0x011CFB ; 11d02

	RET

; ---------------------- ; 11d04
loc_0x011D05:

	LD EP,#00h ; 11d05

	; DUP
	LD BA,[15B1h] ; 11d08
	LD [1300h],BA ; 11d0b
	LD BA,[15B3h] ; 11d0e
	LD [1302h],BA ; 11d11
	LD BA,[15B5h] ; 11d14
	LD [1304h],BA ; 11d17
	LD BA,[15B7h] ; 11d1a
	LD [1306h],BA ; 11d1d
	LD BA,[15B9h] ; 11d20
	LD [1308h],BA ; 11d23
	LD BA,[15BBh] ; 11d26
	LD [130Ah],BA ; 11d29
	LD BA,[15BDh] ; 11d2c
	LD [130Ch],BA ; 11d2f
	LD BA,[15BFh] ; 11d32
	LD [130Eh],BA ; 11d35
	LD BA,[15C1h] ; 11d38
	LD [1310h],BA ; 11d3b
	LD BA,[15C3h] ; 11d3e
	LD [1312h],BA ; 11d41
	LD BA,[15C5h] ; 11d44
	LD [1314h],BA ; 11d47
	LD BA,[15C7h] ; 11d4a
	LD [1316h],BA ; 11d4d
	LD BA,[15C9h] ; 11d50
	LD [1318h],BA ; 11d53
	LD BA,[15CBh] ; 11d56
	LD [131Ah],BA ; 11d59
	LD BA,[15CDh] ; 11d5c
	LD [131Ch],BA ; 11d5f
	LD BA,[15CFh] ; 11d62
	LD [131Eh],BA ; 11d65
	LD BA,[15D1h] ; 11d68
	LD [1320h],BA ; 11d6b
	LD BA,[15D3h] ; 11d6e
	LD [1322h],BA ; 11d71
	LD BA,[15D5h] ; 11d74
	LD [1324h],BA ; 11d77
	LD BA,[15D7h] ; 11d7a
	LD [1326h],BA ; 11d7d
	LD BA,[15D9h] ; 11d80
	LD [1328h],BA ; 11d83
	LD BA,[15DBh] ; 11d86
	LD [132Ah],BA ; 11d89
	LD BA,[15DDh] ; 11d8c
	LD [132Ch],BA ; 11d8f
	LD BA,[15DFh] ; 11d92
	LD [132Eh],BA ; 11d95
	LD BA,[15E1h] ; 11d98
	LD [1330h],BA ; 11d9b
	LD BA,[15E3h] ; 11d9e
	LD [1332h],BA ; 11da1
	LD BA,[15E5h] ; 11da4
	LD [1334h],BA ; 11da7
	LD BA,[15E7h] ; 11daa
	LD [1336h],BA ; 11dad
	LD BA,[15E9h] ; 11db0
	LD [1338h],BA ; 11db3
	LD BA,[15EBh] ; 11db6
	LD [133Ah],BA ; 11db9
	LD BA,[15EDh] ; 11dbc
	LD [133Ch],BA ; 11dbf
	LD BA,[15EFh] ; 11dc2
	LD [133Eh],BA ; 11dc5
	LD BA,[15F1h] ; 11dc8
	LD [1340h],BA ; 11dcb
	LD BA,[15F3h] ; 11dce
	LD [1342h],BA ; 11dd1
	LD BA,[15F5h] ; 11dd4
	LD [1344h],BA ; 11dd7
	LD BA,[15F7h] ; 11dda
	LD [1346h],BA ; 11ddd
	LD BA,[15F9h] ; 11de0
	LD [1348h],BA ; 11de3
	LD BA,[15FBh] ; 11de6
	LD [134Ah],BA ; 11de9
	LD BA,[15FDh] ; 11dec
	LD [134Ch],BA ; 11def
	LD BA,[15FFh] ; 11df2
	LD [134Eh],BA ; 11df5
	LD BA,[1601h] ; 11df8
	LD [1350h],BA ; 11dfb
	LD BA,[1603h] ; 11dfe
	LD [1352h],BA ; 11e01
	LD BA,[1605h] ; 11e04
	LD [1354h],BA ; 11e07
	LD BA,[1607h] ; 11e0a
	LD [1356h],BA ; 11e0d
	LD BA,[1609h] ; 11e10
	LD [1358h],BA ; 11e13
	LD BA,[160Bh] ; 11e16
	LD [135Ah],BA ; 11e19
	LD BA,[160Dh] ; 11e1c
	LD [135Ch],BA ; 11e1f
	LD BA,[160Fh] ; 11e22
	LD [135Eh],BA ; 11e25

	RET

; ---------------------- ; 11e28
loc_0x011E29:

	LD [IX],IY ; 11e29

	LD [IX+0Ah],L ; 11e2b
	LD [IX+0Eh],H ; 11e2e

	LD A,[IY+03h] ; 11e31
	LD B,[IY+04h] ; 11e34
	LD [IX+04h],A ; 11e37
	LD [IX+05h],B ; 11e3a

	LD A,[IY+05h] ; 11e3d
	LD [IX+1Fh],A ; 11e40

	LD A,[IY+06h] ; 11e43
	LD B,[IY+07h] ; 11e46
	LD [IX+02h],A ; 11e49
	LD [IX+03h],B ; 11e4c

	LD A,[IY+08h] ; 11e4f
	LD [IX+1Eh],A ; 11e52

	XOR A,A ; 11e55

	LD [IX+07h],A ; 11e56
	LD [IX+08h],A ; 11e59
	LD [IX+0Ch],A ; 11e5c
	LD [IX+10h],A ; 11e5f
	LD [IX+11h],A ; 11e62
	LD [IX+12h],A ; 11e65
	LD [IX+13h],A ; 11e68
	LD [IX+09h],A ; 11e6b
	LD [IX+0Bh],A ; 11e6e
	LD [IX+0Dh],A ; 11e71
	LD [IX+0Fh],A ; 11e74
	LD [IX+17h],A ; 11e77

	POP BA ; 11e7a

	LD [IX+18h],A ; 11e7b
	LD [IX+19h],B ; 11e7e

	XOR A,A ; 11e81

	LD [IX+1Ah],A ; 11e82
	LD [IX+1Bh],A ; 11e85
	LD [IX+1Ch],A ; 11e88
	LD [IX+1Dh],A ; 11e8b

	LD A,#01h ; 11e8e
	LD [IX+06h],A ; 11e90

	LD BA,#1A6Dh ; 11e93
	LD [IX+14h],A ; 11e96
	LD [IX+15h],B ; 11e99

	LD A,#01h ; 11e9c
	LD [IX+16h],A ; 11e9e

	LD HL,[IY] ; 11ea1
	LD A,[IY+02h] ; 11ea3
	ADD IY,#0006h ; 11ea6
	CARS loc_0x011EAE ; 11ea9

	POP IX ; 11eab
	POP IP ; 11eac

	RET

loc_0x011EAE:

	LD NB,A ; 11eae

	JP HL

; ---------------------- ; 11eb0
loc_0x011EB1:

	PUSH IP ; 11eb1
	PUSH IX ; 11eb2
	PUSH BA ; 11eb3

	LD IX,#168Fh ; 11eb4
	LD XP,#00h ; 11eb7
	LD EP,#00h ; 11eba
	LD B,#14h ; 11ebd

loc_0x011EBF:

	LD A,[IX] ; 11ebf
	OR A,[IX+01h] ; 11ec0
	JRL Z,loc_0x011E29 ; 11ec3

	ADD IX,#0020h ; 11ec6
	DJR NZ,loc_0x011EBF ; 11ec9

	POP BA ; 11ecb
	POP IX ; 11ecc
	POP IP ; 11ecd

	RET

; ---------------------- ; 11ece
loc_0x011ECF:

	LD IX,#168Fh ; 11ecf
	LD XP,#00h ; 11ed2

	LD EP,#00h ; 11ed5

	LD B,#14h ; 11ed8

loc_0x011EDA:

	PUSH B ; 11eda

	LD A,[IX] ; 11edc
	OR A,[IX+01h] ; 11edd
	JRS Z,loc_0x011F31 ; 11ee0

	LD L,[IX+04h] ; 11ee2
	LD H,[IX+05h] ; 11ee5
	LD A,[IX+1Fh] ; 11ee8
	CARS loc_0x011F39 ; 11eeb

	LD HL,IX ; 11eed
	ADD HL,#0006h ; 11eef
	DEC [HL] ; 11ef2
	JRS NZ,loc_0x011F31 ; 11ef3

	LD L,[IX+02h] ; 11ef5
	LD H,[IX+03h] ; 11ef8
	LD IY,HL ; 11efb

loc_0x011EFD:

	LD A,[IX+1Eh] ; 11efd
	LD YP,A ; 11f00
	LD BA,[IY] ; 11f02
	ADD IY,#0002h ; 11f04

	BIT B,#80h ; 11f07
	JRS Z,loc_0x011F1B ; 11f09

	LD HL,BA ; 11f0b
	CARS loc_0x011F3B ; 11f0d

	JRS loc_0x011EFD

; ---------------------- ; 11f0f
	DB 0CFh, 0E3h, 0CEh ; 11f11
	ASCII "D" ; 11f14
	DB 02h, 0CEh ; 11f15
	ASCII "L" ; 11f17
	DB 03h, 0F1h, 17h
; ---------------------- ; 11f18
loc_0x011F1B:

	LD [IX+06h],A ; 11f1b

	LD BA,[IY] ; 11f1e
	LD [IX+14h],A ; 11f20
	LD [IX+15h],B ; 11f23

	ADD IY,#0002h ; 11f26
	LD BA,IY ; 11f29

	LD [IX+02h],A ; 11f2b
	LD [IX+03h],B ; 11f2e

loc_0x011F31:

	ADD IX,#0020h ; 11f31

	POP B ; 11f34

	DJR NZ,loc_0x011EDA ; 11f36

	RET

; ---------------------- ; 11f38
loc_0x011F39:

	LD NB,A ; 11f39

loc_0x011F3B:

	JP HL

; ---------------------- ; 11f3b
	DB 0D6h, 99h, 2Bh, 00h, 11h, 00h, 08h, 00h ; 11f3c
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
; ---------------------- ;
loc_0x01218C:

	LD A,[1B77h] ; 1218c
	CP A,#03h ; 12190
	JRS NZ,loc_0x0121A2 ; 12192

	LD L,#08h ; 12194

	LD A,[1B7Ah] ; 12196
	OR A,A ; 1219a
	JRS Z,loc_0x01219F ; 1219b

	LD L,#20h ; 1219d

loc_0x01219F:

	LD A,L ; 1219f

	JRS loc_0x0121A9

loc_0x0121A2:

	LD A,[1B75h] ; 121a2
	ADD A,A ; 121a6
	ADD A,A ; 121a7
	ADD A,A ; 121a8

loc_0x0121A9:

	CARL loc_0x007982 ; 121a9

	RET

; ---------------------- ; 121ac
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
	DB 1Ah
; ---------------------- ; 12475
loc_0x012476:

	PUSH IP ; 12476
	PUSH IY ; 12477
	PUSH A ; 12478

	LD A,[1AD7h] ; 1247a
	ADD A,A ; 1247e

	LD B,#00h ; 1247f

	LD IY,#24BAh ; 12481
	LD YP,#01h ; 12484

	ADD IY,BA ; 12487
	LD IY,[IY] ; 12489

	POP A ; 1248b

	LD B,#00h ; 1248d

	ADD IY,BA ; 1248f
	LD A,[IY] ; 12491

	POP IY ; 12492
	POP IP ; 12493

	RET

; ---------------------- ; 12494
loc_0x012495:

	PUSH IP ; 12495
	PUSH IY ; 12496
	PUSH A ; 12497

	LD A,[1AD7h] ; 12499
	ADD A,A ; 1249d

	LD B,#00h ; 1249e

	LD IY,#24BAh ; 124a0
	LD YP,#01h ; 124a3

	ADD IY,BA ; 124a6
	LD IY,[IY] ; 124a8

	POP A ; 124aa

	LD B,#08h ; 124ac

loc_0x0124AE:

	CP A,[IY] ; 124ae
	JRS Z,loc_0x0124B4 ; 124af

	INC IY ; 124b1

	DJR NZ,loc_0x0124AE ; 124b2

loc_0x0124B4:

	LD A,#08h ; 124b4
	SUB A,B ; 124b6

	POP IY ; 124b7
	POP IP ; 124b8

	RET

; ---------------------- ; 124b9
	DB 0C0h, 24h, 0C8h, 24h, 0D0h, 24h, 00h, 01h ; 124ba
	DB 02h, 03h, 04h, 05h, 06h, 07h, 00h, 04h ; 124c2
	DB 03h, 05h, 02h, 01h, 06h, 07h, 00h, 03h ; 124ca
	DB 01h, 07h, 02h, 05h, 04h, 06h, 0CEh, 0D0h ; 124d2
	DB 0E9h, 1Ah, 80h ; 124da
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
	DB 0A7h, 01h, 00h, 0A8h, 0AEh, 8Eh, 99h
; ---------------------- ; 12711
loc_0x012718:

	LD A,[HL] ; 12718
	CP A,#47h ; 12719
	JRS C,loc_0x012726 ; 1271b

	INC HL ; 1271d

	LD A,[HL] ; 1271e
	CP A,#25h ; 1271f
	JRS NZ,loc_0x012726 ; 12721

	AND SC,#0FEh ; 12723

	RET

; ---------------------- ; 12725
loc_0x012726:

	OR SC,#01h ; 12726

	RET

; ---------------------- ; 12728
loc_0x012729:

	LD A,[1AE8h] ; 12729
	OR A,A ; 1272d
	JRS Z,loc_0x012747 ; 1272e

	LD HL,#1B12h ; 12730
	CARL loc_0x012718 ; 12733

	JRS Z,loc_0x012747 ; 12736

	LD L,[IX+18h] ; 12738
	LD H,[IX+19h] ; 1273b

	LD BA,#2706h ; 1273e
	CP BA,HL ; 12741
	JRS Z,loc_0x012753 ; 12743

	JRS loc_0x01274A

loc_0x012747:

	LD BA,#1A72h ; 12747

loc_0x01274A:

	LD [IX+18h],A ; 1274a
	LD [IX+19h],B ; 1274d
	CARL loc_0x00794F ; 12750

loc_0x012753:

	RET

; ---------------------- ; 12753
loc_0x012754:

	LD A,[1AE8h] ; 12754
	OR A,A ; 12758
	JRS Z,loc_0x012763 ; 12759

	LD HL,#1B12h ; 1275b
	CARL loc_0x012718 ; 1275e

	JRS NZ,loc_0x012768 ; 12761

loc_0x012763:

	LD BA,#2712h ; 12763

	JRS loc_0x01276B

loc_0x012768:

	LD BA,#1A76h ; 12768

loc_0x01276B:

	CARL loc_0x00794F ; 1276b

	RET

; ---------------------- ; 1276e
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
	DB 0CFh, 0DBh, 0F8h
; ---------------------- ; 12784
loc_0x012787:

	LD A,[1B15h] ; 12787
	CP A,#04h ; 1278b
	JRS Z,loc_0x0127C3 ; 1278d

	CP A,#03h ; 1278f
	JRS Z,loc_0x0127B9 ; 12791

	LD A,[1B14h] ; 12793
	OR A,A ; 12797
	JRS NZ,loc_0x0127AF ; 12798

	LD NB,#01h ; 1279a
	CARL loc_0x009B8D ; 1279d

	JRS NZ,loc_0x0127BE ; 127a0

	LD NB,#01h ; 127a2
	CARL loc_0x009B56 ; 127a5

	JRS Z,loc_0x0127CB ; 127a8

	ADD IY,#0002h ; 127aa
	JRS loc_0x0127CB

loc_0x0127AF:

	LD A,[1B15h] ; 127af
	CP A,#05h ; 127b3
	JRS Z,loc_0x0127C8 ; 127b5

	JRS loc_0x0127CB

loc_0x0127B9:

	ADD IY,#0004h ; 127b9
	JRS loc_0x0127CB

loc_0x0127BE:

	ADD IY,#000Ah ; 127be
	JRS loc_0x0127CB

loc_0x0127C3:

	ADD IY,#0006h ; 127c3
	JRS loc_0x0127CB

loc_0x0127C8:

	ADD IY,#0008h ; 127c8

loc_0x0127CB:

	LD IY,[IY] ; 127cb

	RET

; ---------------------- ; 127cd
loc_0x0127CE:

	LD A,[1B80h] ; 127ce
	OR A,A ; 127d2
	JRS Z,loc_0x0127D8 ; 127d3

	ADD IY,#0002h ; 127d5

loc_0x0127D8:

	LD IY,[IY] ; 127d8

	RET

; ---------------------- ; 127da
loc_0x0127DB:

	LD A,#00h ; 127db
	LD [1B15h],A ; 127dd

	PUSH IP ; 127e1
	PUSH IY ; 127e2

	LD A,[1B80h] ; 127e3
	OR A,A ; 127e7
	JRL Z,loc_0x01287E ; 127e8

	DEC A ; 127eb

	LD B,#00h ; 127ec

	LD IY,#1ACBh ; 127ee
	LD YP,#00h ; 127f1

	ADD IY,BA ; 127f4
	LD A,[IY] ; 127f6

loc_0x0127F7:

	CP A,#1Eh ; 127f7
	JRS C,loc_0x0127FF ; 127f9

	SUB A,#1Eh ; 127fb
	JRS loc_0x0127F7

loc_0x0127FF:

	LD L,A ; 127ff
	LD H,#00h ; 12800
	LD A,#06h ; 12802
	DIV ; 12804

	LD B,H ; 12806
	LD A,L ; 12807
	OR A,A ; 12808
	JRS Z,loc_0x012824 ; 12809

	DEC A ; 1280b
	JRS Z,loc_0x012835 ; 1280c

	DEC A ; 1280e
	JRS Z,loc_0x012846 ; 1280f

	DEC A ; 12811
	JRS Z,loc_0x012856 ; 12812

	INC B ; 12814
	SLA B ; 12815
	SLA B ; 12817

loc_0x012819:

	PUSH B ; 12819

	CARL loc_0x013000 ; 1281b

	POP B ; 1281e

	DJR NZ,loc_0x012819 ; 12820

	JRS loc_0x012865

loc_0x012824:

	INC B ; 12824
	SLA B ; 12825

loc_0x012827:

	PUSH B ; 12827

	CARL loc_0x013005 ; 12829
	CARL loc_0x012FFB ; 1282c

	POP B ; 1282f

	DJR NZ,loc_0x012827 ; 12831

	JRS loc_0x012865

loc_0x012835:

	INC B ; 12835
	SLA B ; 12836

loc_0x012838:

	PUSH B ; 12838

	CARL loc_0x013005 ; 1283a
	CARL loc_0x013000 ; 1283d

	POP B ; 12840

	DJR NZ,loc_0x012838 ; 12842

	JRS loc_0x012865

loc_0x012846:

	INC B ; 12846
	SLA B ; 12847
	SLA B ; 12849

loc_0x01284B:

	PUSH B ; 1284b

	CARL loc_0x012FFB ; 1284d

	POP B ; 12850

	DJR NZ,loc_0x01284B ; 12852

	JRS loc_0x012865

loc_0x012856:

	INC B ; 12856
	SLA B ; 12857

loc_0x012859:

	PUSH B ; 12859

	CARL loc_0x013005 ; 1285b
	CARL loc_0x012FF6 ; 1285e

	POP B ; 12861

	DJR NZ,loc_0x012859 ; 12863

loc_0x012865:

	LD A,[1B80h] ; 12865
	LD B,#00h ; 12869

	LD HL,#1ACBh ; 1286b
	ADD HL,BA ; 1286e

loc_0x012870:

	LD A,[HL] ; 12870

	DEC HL ; 12871
	LD [HL],A ; 12872

	INC HL ; 12873
	INC HL ; 12874

	CP A,#0FFh ; 12875
	JRS NZ,loc_0x012870 ; 12877

	CARL loc_0x012887 ; 12879

	JRS loc_0x012884

loc_0x01287E:

	CARL loc_0x012FC4 ; 1287e
	CARL loc_0x012FC4 ; 12881

loc_0x012884:

	POP IY ; 12884
	POP IP ; 12885

	RET

loc_0x012887:

	PUSH IX ; 12887

	LD IX,#15AAh ; 12888
	LD XP,#00h ; 1288b

	CARL loc_0x004706 ; 1288e

	LD IX,#15AAh ; 12891
	LD XP,#00h ; 12894

	LD HL,#1AECh ; 12897

	LD B,#07h ; 1289a

loc_0x01289C:

	LD [HL],[IX] ; 1289c
	INC IX ; 1289d
	INC HL ; 1289e

	DJR NZ,loc_0x01289C ; 1289f

	POP IX ; 128a1

	RET

; ---------------------- ; 128a2
loc_0x0128A3:

	LD HL,[1B37h] ; 128a3
	ADD HL,#0018h ; 128a6
	LD BA,[HL] ; 128a9
	CP BA,#9686h ; 128ab
	JRS Z,loc_0x0128CA ; 128ae
	CP BA,#96B8h ; 128b0
	JRS Z,loc_0x0128CF ; 128b3
	CP BA,#96FCh ; 128b5
	JRS Z,loc_0x0128D4 ; 128b8
	LD L,[IX+18h] ; 128ba
	LD H,[IX+19h] ; 128bd
	CP HL,#0C46Eh ; 128c0
	JRS Z,loc_0x0128CA ; 128c3
	LD BA,#0C44Eh ; 128c5
	JRS loc_0x0128D7
; ---------------------- ; 128c8
loc_0x0128CA:
	LD BA,#0C458h ; 128ca
	JRS loc_0x0128D7
; ---------------------- ; 128cd
loc_0x0128CF:
	LD BA,#0C46Eh ; 128cf
	JRS loc_0x0128D7
; ---------------------- ; 128d2
loc_0x0128D4:
	LD BA,#0C494h ; 128d4
loc_0x0128D7:
	LD L,[IX+18h] ; 128d7
	LD H,[IX+19h] ; 128da
	CP HL,BA ; 128dd
	JRS Z,loc_0x0128E9 ; 128df
	LD [IX+18h],A ; 128e1
	LD [IX+19h],B ; 128e4
	LD IY,BA ; 128e7
loc_0x0128E9:
	RET
; ---------------------- ; 128e9
loc_0x0128EA:
	LD HL,[1B37h] ; 128ea
	ADD HL,#0018h ; 128ed
	LD BA,[HL] ; 128f0
	CP BA,#9883h ; 128f2
	JRS Z,loc_0x012920 ; 128f5
	CP BA,#98A5h ; 128f7
	JRS Z,loc_0x012925 ; 128fa
	CP BA,#98D5h ; 128fc
	JRS Z,loc_0x01292A ; 128ff
	CP BA,#9905h ; 12901
	JRS Z,loc_0x01292F ; 12904
	CP BA,#9935h ; 12906
	JRS Z,loc_0x012934 ; 12909
	LD A,[IX+18h] ; 1290b
	LD B,[IX+19h] ; 1290e
	CP BA,#0C4F9h ; 12911
	JRS Z,loc_0x012925 ; 12914
	CP BA,#0C523h ; 12916
	JRS Z,loc_0x01292A ; 12919
	CP BA,#0C54Dh ; 1291b
	JRS Z,loc_0x01292F ; 1291e
loc_0x012920:
	LD BA,#0C577h ; 12920
	JRS loc_0x012937
; ---------------------- ; 12923
loc_0x012925:
	LD BA,#0C4CFh ; 12925
	JRS loc_0x012937
; ---------------------- ; 12928
loc_0x01292A:
	LD BA,#0C4F9h ; 1292a
	JRS loc_0x012937
; ---------------------- ; 1292d
loc_0x01292F:
	LD BA,#0C523h ; 1292f
	JRS loc_0x012937
; ---------------------- ; 12932
loc_0x012934:
	LD BA,#0C54Dh ; 12934
loc_0x012937:
	LD [IX+18h],A ; 12937
	LD [IX+19h],B ; 1293a
	LD IY,BA ; 1293d
	RET
; ---------------------- ; 1293f
loc_0x012940:
	LD A,#02h ; 12940
	LD B,#08h ; 12942
	CARL loc_0x0026A9 ; 12944
	RET
; ---------------------- ; 12947
loc_0x012948:
	LD A,#04h ; 12948
	LD B,#08h ; 1294a
	CARL loc_0x0026A9 ; 1294c
	RET
; ---------------------- ; 1294f
loc_0x012950:
	LD BA,#0AD13h ; 12950
	LD [IX+1Ah],A ; 12953
	LD [IX+1Bh],B ; 12956
	RET
; ---------------------- ; 12959
loc_0x01295A:
	LD A,#19h ; 1295a
	JRS loc_0x0129B4
; ---------------------- ; 1295c
loc_0x01295E:
	LD A,#18h ; 1295e
	JRS loc_0x0129B4
; ---------------------- ; 12960
loc_0x012962:
	LD A,#17h ; 12962
	JRS loc_0x0129B4
; ---------------------- ; 12964
loc_0x012966:
	LD A,#0Bh ; 12966
	JRS loc_0x0129B4
; ---------------------- ; 12968
loc_0x01296A:
	LD A,#14h ; 1296a
	JRS loc_0x0129B4
; ---------------------- ; 1296c
loc_0x01296E:
	LD A,#15h ; 1296e
	JRS loc_0x0129B4
; ---------------------- ; 12970
loc_0x012972:
	LD A,#0Ch ; 12972
	JRS loc_0x0129B4
; ---------------------- ; 12974
loc_0x012976:
	LD A,#0Ah ; 12976
	JRS loc_0x0129B4
; ---------------------- ; 12978
loc_0x01297A:
	LD A,#10h ; 1297a
	JRS loc_0x0129B4
; ---------------------- ; 1297c
loc_0x01297E:
	LD A,#11h ; 1297e
loc_0x012980:
	JRS loc_0x0129B4
; ---------------------- ; 12980
	DB 0B0h, 03h, 0F1h, 2Fh, 0B0h, 0Fh, 0F1h, 2Bh
; ---------------------- ; 12982
loc_0x01298A:
	LD A,#0Eh ; 1298a
	JRS loc_0x0129B4
; ---------------------- ; 1298c
	DB 0B0h, 09h, 0F1h, 23h, 0B0h, 0Dh, 0F1h, 1Fh ; 1298e
	DB 0B0h, 04h, 0F1h, 1Bh, 0B0h, 08h, 0F1h, 17h
; ---------------------- ; 12996
loc_0x01299E:
	LD A,#06h ; 1299e
	JRS loc_0x0129B4
; ---------------------- ; 129a0
	DB 0B0h, 07h, 0F1h, 0Fh
; ---------------------- ; 129a2
loc_0x0129A6:
	LD A,#05h ; 129a6
	JRS loc_0x0129B4
; ---------------------- ; 129a8
	DB 0B0h, 01h, 0F1h, 07h, 0B0h, 16h, 0F1h, 03h
; ---------------------- ; 129aa
loc_0x0129B2:
	LD A,#00h ; 129b2
loc_0x0129B4:
	LD [1B1Ch],A ; 129b4
	RET
; ---------------------- ; 129b8
loc_0x0129B9:
	LD A,[1ADBh] ; 129b9
	OR A,A ; 129bd
	JRS NZ,loc_0x0129C5 ; 129be
	ADD IY,#0008h ; 129c0
	JRS loc_0x0129D7
; ---------------------- ; 129c3
loc_0x0129C5:
	LD NB,#01h ; 129c5
	CARL loc_0x00AA46 ; 129c8
	JRS Z,loc_0x0129D7 ; 129cb
	LD A,[1ADCh] ; 129cd
	INC A ; 129d1
	ADD A,A ; 129d2
	LD B,#00h ; 129d3
	ADD IY,BA ; 129d5
loc_0x0129D7:
	LD IY,[IY] ; 129d7
	RET
; ---------------------- ; 129d9
loc_0x0129DA:
	LD BA,[1B12h] ; 129da
	CARL loc_0x007982 ; 129dd
	RET
; ---------------------- ; 129e0
loc_0x0129E1:
	LD A,[1B23h] ; 129e1
	LD [1B13h],A ; 129e5
	CARL loc_0x0129DA ; 129e9
	RET
; ---------------------- ; 129ec
loc_0x0129ED:
	LD NB,#01h ; 129ed
	CARL loc_0x009A34 ; 129f0
	JRS Z,loc_0x0129F8 ; 129f3
	ADD IY,#0002h ; 129f5
loc_0x0129F8:
	LD IY,[IY] ; 129f8
	RET
; ---------------------- ; 129fa
loc_0x0129FB:
	CARL loc_0x012FFB ; 129fb
	CARL loc_0x012FFB ; 129fe
	LD NB,#01h ; 12a01
	CARL loc_0x009A46 ; 12a04
	JRS Z,loc_0x012A0C ; 12a07
	ADD IY,#0002h ; 12a09
loc_0x012A0C:
	LD IY,[IY] ; 12a0c
	RET
; ---------------------- ; 12a0e
loc_0x012A0F:
	CARL loc_0x012FFB ; 12a0f
	CARL loc_0x012FFB ; 12a12
	CARL loc_0x012FFB ; 12a15
	LD NB,#01h ; 12a18
	CARL loc_0x009A58 ; 12a1b
	JRS Z,loc_0x012A26 ; 12a1e
	ADD IY,#0002h ; 12a20
	LD IY,[IY] ; 12a23
	RET
; ---------------------- ; 12a25
loc_0x012A26:
	CARL loc_0x012FFB ; 12a26
	CARL loc_0x012FFB ; 12a29
	CARL loc_0x012FFB ; 12a2c
	CARL loc_0x012FFB ; 12a2f
	LD IY,[IY] ; 12a32
	RET
; ---------------------- ; 12a34
loc_0x012A35:
	LD NB,#01h ; 12a35
	CARL loc_0x009A69 ; 12a38
	JRS Z,loc_0x012A40 ; 12a3b
	ADD IY,#0002h ; 12a3d
loc_0x012A40:
	LD IY,[IY] ; 12a40
	RET
; ---------------------- ; 12a42
loc_0x012A43:
	CARL loc_0x012FFB ; 12a43
	LD NB,#01h ; 12a46
	CARL loc_0x009A7A ; 12a49
	JRS Z,loc_0x012A51 ; 12a4c
	ADD IY,#0002h ; 12a4e
loc_0x012A51:
	LD IY,[IY] ; 12a51
	RET
; ---------------------- ; 12a53
loc_0x012A54:
	CARL loc_0x012FFB ; 12a54
	CARL loc_0x012FFB ; 12a57
	LD NB,#01h ; 12a5a
	CARL loc_0x009A8B ; 12a5d
	JRS Z,loc_0x012A68 ; 12a60
	ADD IY,#0002h ; 12a62
	LD IY,[IY] ; 12a65
	RET
; ---------------------- ; 12a67
loc_0x012A68:
	CARL loc_0x012FFB ; 12a68
	CARL loc_0x012FFB ; 12a6b
	CARL loc_0x012FFB ; 12a6e
	LD IY,[IY] ; 12a71
	RET
; ---------------------- ; 12a73
loc_0x012A74:
	LD A,[1ADCh] ; 12a74
	CP A,#02h ; 12a78
	JRS NZ,loc_0x012A7F ; 12a7a
	ADD IY,#0002h ; 12a7c
loc_0x012A7F:
	LD IY,[IY] ; 12a7f
	RET
; ---------------------- ; 12a81
loc_0x012A82:
	LD A,[1B13h] ; 12a82
	LD B,[1B1Fh] ; 12a86
	INC B ; 12a8a
	CP A,B ; 12a8b
	JRS NC,loc_0x012AA6 ; 12a8c
	ADD A,#10h ; 12a8e
	CP A,B ; 12a90
	JRS C,loc_0x012AB9 ; 12a91
	LD A,[1B12h] ; 12a93
	LD B,[1B1Eh] ; 12a97
	INC B ; 12a9b
	CP A,B ; 12a9c
	JRS NC,loc_0x012AE4 ; 12a9d
	ADD A,#10h ; 12a9f
	CP A,B ; 12aa1
	JRS C,loc_0x012AE1 ; 12aa2
	JRS loc_0x012AD2
; ---------------------- ; 12aa4
loc_0x012AA6:
	LD A,[1B12h] ; 12aa6
	LD B,[1B1Eh] ; 12aaa
	INC B ; 12aae
	CP A,B ; 12aaf
	JRS NC,loc_0x012ADE ; 12ab0
	ADD A,#10h ; 12ab2
	CP A,B ; 12ab4
	JRS C,loc_0x012AD8 ; 12ab5
	JRS loc_0x012ACF
; ---------------------- ; 12ab7
loc_0x012AB9:
	LD A,[1B12h] ; 12ab9
	LD B,[1B1Eh] ; 12abd
	INC B ; 12ac1
	CP A,B ; 12ac2
	JRS NC,loc_0x012ADB ; 12ac3
	ADD A,#10h ; 12ac5
	CP A,B ; 12ac7
	JRS C,loc_0x012AD5 ; 12ac8
	JRS loc_0x012ACC
; ---------------------- ; 12aca
loc_0x012ACC:
	ADD IY,#0002h ; 12acc
loc_0x012ACF:
	ADD IY,#0002h ; 12acf
loc_0x012AD2:
	ADD IY,#0002h ; 12ad2
loc_0x012AD5:
	ADD IY,#0002h ; 12ad5
loc_0x012AD8:
	ADD IY,#0002h ; 12ad8
loc_0x012ADB:
	ADD IY,#0002h ; 12adb
loc_0x012ADE:
	ADD IY,#0002h ; 12ade
loc_0x012AE1:
	ADD IY,#0002h ; 12ae1
loc_0x012AE4:
	LD IY,[IY] ; 12ae4
	RET
; ---------------------- ; 12ae6
loc_0x012AE7:
	LD A,[1AD8h] ; 12ae7
	CP A,#00h ; 12aeb
	JRS NZ,loc_0x012B05 ; 12aed
	LD A,[1B20h] ; 12aef
	CP A,#03h ; 12af3
	JRS Z,loc_0x012B05 ; 12af5
	CP A,#02h ; 12af7
	JRS Z,loc_0x012B05 ; 12af9
	CARL loc_0x012C09 ; 12afb
	JRS NZ,loc_0x012B19 ; 12afe
	CARL loc_0x012B67 ; 12b00
	JRS NZ,loc_0x012B19 ; 12b03
loc_0x012B05:
	LD A,[1B13h] ; 12b05
	LD B,[1B1Fh] ; 12b09
	CP A,B ; 12b0d
	JRS NC,loc_0x012B15 ; 12b0e
	ADD A,#10h ; 12b10
	CP A,B ; 12b12
	JRS NC,loc_0x012B19 ; 12b13
loc_0x012B15:
	LD A,#02h ; 12b15
	JRS loc_0x012B5F
; ---------------------- ; 12b17
loc_0x012B19:
	LD NB,#01h ; 12b19
	CARL loc_0x00AA46 ; 12b1c
	JRS NZ,loc_0x012B2E ; 12b1f
	LD A,#00h ; 12b21
	LD [1B20h],A ; 12b23
loc_0x012B27:
	CARL loc_0x012F7C ; 12b27
	LD A,#01h ; 12b2a
	JRS loc_0x012B5F
; ---------------------- ; 12b2c
loc_0x012B2E:
	LD NB,#01h ; 12b2e
	CARL loc_0x009A22 ; 12b31
	JRS NZ,loc_0x012B27 ; 12b34
	CARL loc_0x013000 ; 12b36
	CARL loc_0x012F7C ; 12b39
	LD NB,#01h ; 12b3c
	CARL loc_0x009A10 ; 12b3f
	JRS Z,loc_0x012B5A ; 12b42
	LD A,[1B12h] ; 12b44
	LD B,[1B1Eh] ; 12b48
	SUB A,B ; 12b4c
	SRA A ; 12b4d
	ADD A,B ; 12b4f
	LD [1B1Eh],A ; 12b50
	LD A,#06h ; 12b54
	LD [1B20h],A ; 12b56
loc_0x012B5A:
	CARL loc_0x012F7C ; 12b5a
	LD A,#00h ; 12b5d
loc_0x012B5F:
	ADD A,A ; 12b5f
	LD B,#00h ; 12b60
	ADD IY,BA ; 12b62
	LD IY,[IY] ; 12b64
	RET
; ---------------------- ; 12b66
loc_0x012B67:
	LD A,[1AD7h] ; 12b67
	CP A,#00h ; 12b6b
	JRS Z,loc_0x012BD7 ; 12b6d
	CP A,#01h ; 12b6f
	JRS Z,loc_0x012BA5 ; 12b71
	LD A,[1B1Fh] ; 12b73
	CP A,#2Bh ; 12b77
	JRS C,loc_0x012BA2 ; 12b79
	CP A,#37h ; 12b7b
	JRS NC,loc_0x012BA2 ; 12b7d
	LD A,[1B1Eh] ; 12b7f
	CP A,#17h ; 12b83
	JRS C,loc_0x012BA2 ; 12b85
	CP A,#2Bh ; 12b87
	JRS NC,loc_0x012BA2 ; 12b89
	LD A,[1B23h] ; 12b8b
	LD [1B1Fh],A ; 12b8f
	LD A,#1Ch ; 12b93
	LD [1B1Eh],A ; 12b95
	LD A,#02h ; 12b99
	LD [1B20h],A ; 12b9b
	AND SC,#0FEh ; 12b9f
	RET
; ---------------------- ; 12ba1
loc_0x012BA2:
	OR SC,#01h ; 12ba2
	RET
; ---------------------- ; 12ba4
loc_0x012BA5:
	LD A,[1B1Fh] ; 12ba5
	CP A,#25h ; 12ba9
	JRS C,loc_0x012BD4 ; 12bab
	CP A,#30h ; 12bad
	JRS NC,loc_0x012BD4 ; 12baf
	LD A,[1B1Eh] ; 12bb1
	CP A,#1Dh ; 12bb5
	JRS C,loc_0x012BD4 ; 12bb7
	CP A,#2Dh ; 12bb9
	JRS NC,loc_0x012BD4 ; 12bbb
	LD A,[1B23h] ; 12bbd
	LD [1B1Fh],A ; 12bc1
	LD A,#1Fh ; 12bc5
	LD [1B1Eh],A ; 12bc7
	LD A,#02h ; 12bcb
	LD [1B20h],A ; 12bcd
	AND SC,#0FEh ; 12bd1
	RET
; ---------------------- ; 12bd3
loc_0x012BD4:
	OR SC,#01h ; 12bd4
	RET
; ---------------------- ; 12bd6
loc_0x012BD7:
	LD A,[1B1Fh] ; 12bd7
	CP A,#1Eh ; 12bdb
	JRS C,loc_0x012C06 ; 12bdd
	CP A,#2Fh ; 12bdf
	JRS NC,loc_0x012C06 ; 12be1
	LD A,[1B1Eh] ; 12be3
	CP A,#21h ; 12be7
	JRS C,loc_0x012C06 ; 12be9
	CP A,#2Ch ; 12beb
	JRS NC,loc_0x012C06 ; 12bed
	LD A,[1B23h] ; 12bef
	LD [1B1Fh],A ; 12bf3
	LD A,#20h ; 12bf7
	LD [1B1Eh],A ; 12bf9
	LD A,#02h ; 12bfd
	LD [1B20h],A ; 12bff
	AND SC,#0FEh ; 12c03
	RET
; ---------------------- ; 12c05
loc_0x012C06:
	OR SC,#01h ; 12c06
	RET
; ---------------------- ; 12c08
loc_0x012C09:
	LD A,[1AD7h] ; 12c09
	CP A,#01h ; 12c0d
	JRS Z,loc_0x012C5D ; 12c0f
	CP A,#02h ; 12c11
	JRL Z,loc_0x012CA4 ; 12c13
	LD A,[1B1Fh] ; 12c16
	CP A,#18h ; 12c1a
	JRS C,loc_0x012C5A ; 12c1c
	CP A,#39h ; 12c1e
	JRS NC,loc_0x012C5A ; 12c20
	LD A,[1B1Eh] ; 12c22
	CP A,#38h ; 12c26
	JRS C,loc_0x012C5A ; 12c28
	CP A,#50h ; 12c2a
	JRS NC,loc_0x012C5A ; 12c2c
	LD A,[1B13h] ; 12c2e
	LD B,[1B23h] ; 12c32
	CP A,B ; 12c36
	JRS Z,loc_0x012C4B ; 12c37
	CP A,#18h ; 12c39
	JRS NZ,loc_0x012C5A ; 12c3b
	LD A,#3Fh ; 12c3d
	LD [1B1Eh],A ; 12c3f
	LD A,#04h ; 12c43
	LD [1B20h],A ; 12c45
	JRS loc_0x012C57
; ---------------------- ; 12c49
loc_0x012C4B:
	LD A,#3Eh ; 12c4b
	LD [1B1Eh],A ; 12c4d
	LD A,#01h ; 12c51
	LD [1B20h],A ; 12c53
loc_0x012C57:
	AND SC,#0FEh ; 12c57
	RET
; ---------------------- ; 12c59
loc_0x012C5A:
	OR SC,#01h ; 12c5a
	RET
; ---------------------- ; 12c5c
loc_0x012C5D:
	LD A,[1B1Fh] ; 12c5d
	CP A,#10h ; 12c61
	JRS C,loc_0x012CA1 ; 12c63
	CP A,#39h ; 12c65
	JRS NC,loc_0x012CA1 ; 12c67
	LD A,[1B1Eh] ; 12c69
	CP A,#30h ; 12c6d
	JRS C,loc_0x012CA1 ; 12c6f
	CP A,#50h ; 12c71
	JRS NC,loc_0x012CA1 ; 12c73
	LD A,[1B13h] ; 12c75
	LD B,[1B23h] ; 12c79
	CP A,B ; 12c7d
	JRS Z,loc_0x012C92 ; 12c7e
	CP A,#10h ; 12c80
	JRS NZ,loc_0x012CA1 ; 12c82
	LD A,#40h ; 12c84
	LD [1B1Eh],A ; 12c86
	LD A,#04h ; 12c8a
	LD [1B20h],A ; 12c8c
	JRS loc_0x012C9E
; ---------------------- ; 12c90
loc_0x012C92:
	LD A,#40h ; 12c92
	LD [1B1Eh],A ; 12c94
	LD A,#01h ; 12c98
	LD [1B20h],A ; 12c9a
loc_0x012C9E:
	AND SC,#0FEh ; 12c9e
	RET
; ---------------------- ; 12ca0
loc_0x012CA1:
	OR SC,#01h ; 12ca1
	RET
; ---------------------- ; 12ca3
loc_0x012CA4:
	LD A,[1B1Fh] ; 12ca4
	CP A,#18h ; 12ca8
	JRS C,loc_0x012CE8 ; 12caa
	CP A,#39h ; 12cac
	JRS NC,loc_0x012CE8 ; 12cae
	LD A,[1B1Eh] ; 12cb0
	CP A,#30h ; 12cb4
	JRS C,loc_0x012CE8 ; 12cb6
	CP A,#50h ; 12cb8
	JRS NC,loc_0x012CE8 ; 12cba
	LD A,[1B13h] ; 12cbc
	LD B,[1B23h] ; 12cc0
	CP A,B ; 12cc4
	JRS Z,loc_0x012CD9 ; 12cc5
	CP A,#18h ; 12cc7
	JRS NZ,loc_0x012CE8 ; 12cc9
	LD A,#41h ; 12ccb
	LD [1B1Eh],A ; 12ccd
	LD A,#04h ; 12cd1
	LD [1B20h],A ; 12cd3
	JRS loc_0x012CE5
; ---------------------- ; 12cd7
loc_0x012CD9:
	LD A,#2Eh ; 12cd9
	LD [1B1Eh],A ; 12cdb
	LD A,#01h ; 12cdf
	LD [1B20h],A ; 12ce1
loc_0x012CE5:
	AND SC,#0FEh ; 12ce5
	RET
; ---------------------- ; 12ce7
loc_0x012CE8:
	OR SC,#01h ; 12ce8
	RET
; ---------------------- ; 12cea
loc_0x012CEB:
	LD A,[1ADCh] ; 12ceb
	CP A,#00h ; 12cef
	JRS Z,loc_0x012CF6 ; 12cf1
	ADD IY,#0002h ; 12cf3
loc_0x012CF6:
	LD IY,[IY] ; 12cf6
	RET
; ---------------------- ; 12cf8
loc_0x012CF9:
	LD A,[1AD7h] ; 12cf9
	CP A,#02h ; 12cfd
	JRS NZ,loc_0x012D17 ; 12cff
	LD A,[1B13h] ; 12d01
	LD B,[1B23h] ; 12d05
	CP A,B ; 12d09
	JRS NZ,loc_0x012D17 ; 12d0a
	LD A,[1B20h] ; 12d0c
	CP A,#02h ; 12d10
	JRS NZ,loc_0x012D17 ; 12d12
	ADD IY,#0002h ; 12d14
loc_0x012D17:
	LD IY,[IY] ; 12d17
	RET
; ---------------------- ; 12d19
loc_0x012D1A:
	LD A,[1B1Eh] ; 12d1a
	LD B,[1B12h] ; 12d1e
	SUB A,B ; 12d22
	JRS C,loc_0x012D28 ; 12d23
	ADD IY,#0002h ; 12d25
loc_0x012D28:
	LD IY,[IY] ; 12d28
	RET
; ---------------------- ; 12d2a
loc_0x012D2B:
	LD A,[1B1Eh] ; 12d2b
	LD B,[1B12h] ; 12d2f
	SUB A,B ; 12d33
	JRS Z,loc_0x012D3E ; 12d34
	JRS C,loc_0x012D3B ; 12d36
	ADD IY,#0002h ; 12d38
loc_0x012D3B:
	ADD IY,#0002h ; 12d3b
loc_0x012D3E:
	LD IY,[IY] ; 12d3e
	RET
; ---------------------- ; 12d40
loc_0x012D41:
	LD NB,#01h ; 12d41
	CARL loc_0x009ACF ; 12d44
	JRS NZ,loc_0x012D4E ; 12d47
	CARL loc_0x012FF6 ; 12d49
	JRS loc_0x012D51
; ---------------------- ; 12d4c
loc_0x012D4E:
	ADD IY,#0002h ; 12d4e
loc_0x012D51:
	LD IY,[IY] ; 12d51
	RET
; ---------------------- ; 12d53
loc_0x012D54:
	LD A,#00h ; 12d54
	LD [1B14h],A ; 12d56
	LD NB,#03h ; 12d5a
	CARL loc_0x01898C ; 12d5d
	LD A,#28h ; 12d60
	LD B,[1B23h] ; 12d62
	LD [1B12h],BA ; 12d66
	CARL loc_0x007982 ; 12d69
	RET
; ---------------------- ; 12d6c
loc_0x012D6D:
	LD A,#01h ; 12d6d
	LD [1B14h],A ; 12d6f
	LD NB,#03h ; 12d73
	CARL loc_0x01898C ; 12d76
	LD BA,#0AC79h ; 12d79
	LD NB,#02h ; 12d7c
	CARL loc_0x012E73 ; 12d7f
	RET
; ---------------------- ; 12d82
loc_0x012D83:
	LD A,[IX+02h] ; 12d83
	LD B,[IX+03h] ; 12d86
	LD NB,#02h ; 12d89
	CARL loc_0x012E73 ; 12d8c
	RET
; ---------------------- ; 12d8f
loc_0x012D90:
	LD BA,#0AC9Bh ; 12d90
	LD NB,#02h ; 12d93
	CARL loc_0x012E73 ; 12d96
	RET
; ---------------------- ; 12d99
loc_0x012D9A:
	LD A,[IX+14h] ; 12d9a
	LD B,[IX+15h] ; 12d9d
	CP BA,#0C138h ; 12da0
	JRS C,loc_0x012DAD ; 12da3
	CP BA,#0C1C0h ; 12da5
	JRS NC,loc_0x012DAD ; 12da8
	ADD IY,#0002h ; 12daa
loc_0x012DAD:
	LD IY,[IY] ; 12dad
	RET
; ---------------------- ; 12daf
loc_0x012DB0:
	LD A,[1ADFh] ; 12db0
	CP A,#19h ; 12db4
	JRS C,loc_0x012DC2 ; 12db6
	ADD IY,#0002h ; 12db8
	CP A,#33h ; 12dbb
	JRS C,loc_0x012DC2 ; 12dbd
	ADD IY,#0002h ; 12dbf
loc_0x012DC2:
	LD IY,[IY] ; 12dc2
	RET
; ---------------------- ; 12dc4
loc_0x012DC5:
	PUSH IP ; 12dc5
	PUSH IY ; 12dc6
	LD YP,#01h ; 12dc7
	LD IY,#0AF28h ; 12dca
	LD A,[1AD7h] ; 12dcd
	CP A,#00h ; 12dd1
	JRS Z,loc_0x012DDF ; 12dd3
	LD IY,#0AF50h ; 12dd5
	CP A,#01h ; 12dd8
	JRS Z,loc_0x012DDF ; 12dda
	LD IY,#0AF3Ch ; 12ddc
loc_0x012DDF:
	LD HL,#1B52h ; 12ddf
	LD B,#14h ; 12de2
loc_0x012DE4:
	LD A,[IY] ; 12de4
	LD [HL],A ; 12de5
	INC IY ; 12de6
	INC HL ; 12de7
	DJR NZ,loc_0x012DE4 ; 12de8
	XOR A,A ; 12dea
	LD [1B66h],A ; 12deb
	LD [1B67h],A ; 12def
	LD A,[1ADFh] ; 12df3
	LD B,[1AE1h] ; 12df7
	ADD A,B ; 12dfb
	LD L,#04h ; 12dfc
	MLT ; 12dfe
	LD A,[1AE0h] ; 12e00
	LD B,[1AE2h] ; 12e04
	ADD A,B ; 12e08
	LD B,#00h ; 12e09
	ADD HL,BA ; 12e0b
	LD A,#40h ; 12e0d
	DIV ; 12e0f
	INC L ; 12e11
	LD [1B69h],L ; 12e12
	LD A,H ; 12e16
	LD L,#19h ; 12e17
	MLT ; 12e19
	LD A,#10h ; 12e1b
	DIV ; 12e1d
	LD [1B68h],L ; 12e1f
	XOR A,A ; 12e23
	LD [IX+16h],A ; 12e24
	LD A,[1AD7h] ; 12e27
	CP A,#00h ; 12e2b
	JRS Z,loc_0x012E3D ; 12e2d
	CP A,#01h ; 12e2f
	JRS Z,loc_0x012E44 ; 12e31
	LD A,[1B12h] ; 12e33
	LD B,[1B23h] ; 12e37
	JRS loc_0x012E48
; ---------------------- ; 12e3b
loc_0x012E3D:
	LD B,[1B13h] ; 12e3d
	XOR A,A ; 12e41
	JRS loc_0x012E48
; ---------------------- ; 12e42
loc_0x012E44:
	LD A,#0FCh ; 12e44
	LD B,#00h ; 12e46
loc_0x012E48:
	CARL loc_0x007982 ; 12e48
	POP IY ; 12e4b
	POP IP ; 12e4c
	RET
; ---------------------- ; 12e4d
loc_0x012E4E:
	LD A,[1B23h] ; 12e4e
	LD [1B13h],A ; 12e52
	LD [1B1Fh],A ; 12e56
	LD A,#28h ; 12e5a
	LD [1B1Eh],A ; 12e5c
	XOR A,A ; 12e60
	LD [1B12h],A ; 12e61
	LD A,#03h ; 12e65
	LD [1B20h],A ; 12e67
	RET
; ---------------------- ; 12e6b
loc_0x012E6C:
	LD [IX+18h],A ; 12e6c
	LD [IX+19h],B ; 12e6f
	RET
; ---------------------- ; 12e72
loc_0x012E73:
	LD [IX+1Ah],A ; 12e73
	LD [IX+1Bh],B ; 12e76
	RET
; ---------------------- ; 12e79
loc_0x012E7A:
	LD BA,#81D9h ; 12e7a
	CARL loc_0x012E6C ; 12e7d
	RET
; ---------------------- ; 12e80
	ASCII "8" ; 12e81
loc_0x012E82:
	LD [1B21h],A ; 12e82
	LD BA,#800Ch ; 12e86
	CARL loc_0x012E6C ; 12e89
	RET
; ---------------------- ; 12e8c
loc_0x012E8D:
	XOR A,A ; 12e8d
	LD [1B21h],A ; 12e8e
	LD BA,#965Eh ; 12e92
	CARL loc_0x012E6C ; 12e95
	RET
; ---------------------- ; 12e98
loc_0x012E99:
	XOR A,A ; 12e99
	LD [1B21h],A ; 12e9a
	LD BA,#9686h ; 12e9e
	CARL loc_0x012E6C ; 12ea1
	RET
; ---------------------- ; 12ea4
loc_0x012EA5:
	XOR A,A ; 12ea5
	LD [1B21h],A ; 12ea6
	LD BA,#96B8h ; 12eaa
	CARL loc_0x012E6C ; 12ead
	RET
; ---------------------- ; 12eb0
loc_0x012EB1:
	LD BA,#96FCh ; 12eb1
	CARL loc_0x012E6C ; 12eb4
	RET
; ---------------------- ; 12eb7
loc_0x012EB8:
	LD NB,#01h ; 12eb8
	CARL loc_0x00AA46 ; 12ebb
	JRS Z,loc_0x012ED9 ; 12ebe
	LD A,[1B21h] ; 12ec0
	CP A,#0FFh ; 12ec4
	JRS Z,loc_0x012ED9 ; 12ec6
	CP A,#0FEh ; 12ec8
	JRS Z,loc_0x012ED6 ; 12eca
	LD HL,#1B21h ; 12ecc
	INC [HL] ; 12ecf
	CP A,#04h ; 12ed0
	JRS C,loc_0x012EDF ; 12ed2
	JRS loc_0x012EDC
; ---------------------- ; 12ed4
loc_0x012ED6:
	ADD IY,#0002h ; 12ed6
loc_0x012ED9:
	ADD IY,#0002h ; 12ed9
loc_0x012EDC:
	ADD IY,#0002h ; 12edc
loc_0x012EDF:
	LD IY,[IY] ; 12edf
	RET
; ---------------------- ; 12ee1
loc_0x012EE2:
	LD NB,#01h ; 12ee2
	CARL loc_0x00AA46 ; 12ee5
	JRS Z,loc_0x012EF6 ; 12ee8
	LD NB,#01h ; 12eea
	CARL loc_0x00C0E9 ; 12eed
	CARL loc_0x012FF6 ; 12ef0
	CARL loc_0x012F7C ; 12ef3
loc_0x012EF6:
	RET
; ---------------------- ; 12ef6
loc_0x012EF7:
	LD BA,#979Ch ; 12ef7
	CARL loc_0x012E6C ; 12efa
	RET
; ---------------------- ; 12efd
loc_0x012EFE:
	LD A,[1B13h] ; 12efe
	CP A,#17h ; 12f02
	JRS NC,loc_0x012F12 ; 12f04
	LD NB,#01h ; 12f06
	CARL loc_0x00C0F0 ; 12f09
	CARL loc_0x012F7C ; 12f0c
	CARL loc_0x012FF6 ; 12f0f
loc_0x012F12:
	RET
; ---------------------- ; 12f12
loc_0x012F13:
	LD BA,#98A5h ; 12f13
	CARL loc_0x012E6C ; 12f16
	RET
; ---------------------- ; 12f19
loc_0x012F1A:
	LD BA,#98D5h ; 12f1a
	CARL loc_0x012E6C ; 12f1d
	RET
; ---------------------- ; 12f20
loc_0x012F21:
	LD BA,#9905h ; 12f21
	CARL loc_0x012E6C ; 12f24
	RET
; ---------------------- ; 12f27
loc_0x012F28:
	LD BA,#9935h ; 12f28
	CARL loc_0x012E6C ; 12f2b
	RET
; ---------------------- ; 12f2e
loc_0x012F2F:
	LD BA,#9883h ; 12f2f
	CARL loc_0x012E6C ; 12f32
	RET
; ---------------------- ; 12f35
loc_0x012F36:
	LD BA,#9967h ; 12f36
	CARL loc_0x012E6C ; 12f39
	RET
; ---------------------- ; 12f3c
loc_0x012F3D:
	LD NB,#01h ; 12f3d
	CARL loc_0x009C80 ; 12f40
	JRS Z,loc_0x012F5E ; 12f43
	LD A,[1B21h] ; 12f45
	CP A,#0FFh ; 12f49
	JRS Z,loc_0x012F61 ; 12f4b
	INC A ; 12f4d
	LD [1B21h],A ; 12f4e
	ADD IY,#0002h ; 12f52
	CP A,#04h ; 12f55
	JRS C,loc_0x012F66 ; 12f57
	ADD IY,#0002h ; 12f59
	JRS loc_0x012F61
; ---------------------- ; 12f5c
loc_0x012F5E:
	ADD IY,#0006h ; 12f5e
loc_0x012F61:
	XOR A,A ; 12f61
	LD [1B21h],A ; 12f62
loc_0x012F66:
	LD IY,[IY] ; 12f66
	RET
; ---------------------- ; 12f68
loc_0x012F69:
	LD A,#7Fh ; 12f69
	LD [1B13h],A ; 12f6b
	RET
; ---------------------- ; 12f6f
loc_0x012F70:
	LD A,[1B23h] ; 12f70
	LD [1B13h],A ; 12f74
	CARL loc_0x0129DA ; 12f78
	RET
; ---------------------- ; 12f7b
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
loc_0x012F8A:
	LD HL,#1ADCh ; 12f8a
	JRS loc_0x012F84
; ---------------------- ; 12f8d
loc_0x012F8F:
	LD HL,#1ADDh ; 12f8f
	JRS loc_0x012FA3
; ---------------------- ; 12f92
loc_0x012F94:
	LD HL,#1ADFh ; 12f94
	JRS loc_0x012FA3
; ---------------------- ; 12f97
loc_0x012F99:
	LD HL,#1AE1h ; 12f99
	JRS loc_0x012FA3
; ---------------------- ; 12f9c
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
loc_0x012FC4:
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
loc_0x012FF6:
	DB 0C5h, 0DDh, 1Ah, 0F1h, 0Eh
loc_0x012FFB:
	DB 0C5h, 0DFh, 1Ah ; 12ff6
	DB 0F1h, 09h
loc_0x013000:
	DB 0C5h, 0E1h, 1Ah, 0F1h, 04h
loc_0x013005:
	DB 0C5h ; 12ffe
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
loc_0x017171:
	LD A,[1AB6h] ; 17171
	AND A,A ; 17175
	JRS Z,loc_0x01717E ; 17176
	LD A,#08h ; 17178
	LD [14FAh],A ; 1717a
loc_0x01717E:
	POP IY ; 1717e
	XOR A,A ; 1717f
	LD [1AD6h],A ; 17180
	LD [1AE8h],A ; 17184
	LD [1AE9h],A ; 17188
	LD A,#28h ; 1718c
	LD [1ADAh],A ; 1718e
	LD NB,#03h ; 17192
	CARL loc_0x018F4E ; 17195
	RET
; ---------------------- ; 17198
loc_0x017199:
	PUSH IP ; 17199
	PUSH IY ; 1719a
	LD A,[1AD7h] ; 1719b
	ADD A,A ; 1719f
	LD B,#00h ; 171a0
	LD IY,#71B2h ; 171a2
	LD YP,#01h ; 171a5
	ADD IY,BA ; 171a8
	LD BA,[IY] ; 171aa
	CARL loc_0x00794F ; 171ac
	POP IY ; 171af
	POP IP ; 171b0
	RET
; ---------------------- ; 171b1
	DB 0B9h ; 171b2
	ASCII "p" ; 171b3
	DB 0F2h ; 171b4
	ASCII "p+q" ; 171b5
	DB 99h, 0F1h ; 171b8
	ASCII "q" ; 171ba
	DB 9Ah ; 171bb
	ASCII "v" ; 171bc
	DB 1Ah, 01h, 00h, 0DCh, 0E0h, 8Eh, 99h
; ---------------------- ; 171bd
loc_0x0171C4:
	LD A,[1645h] ; 171c4
	BIT A,#20h ; 171c8
	JRS NZ,loc_0x0171DF ; 171ca
	BIT A,#40h ; 171cc
	JRS NZ,loc_0x0171D2 ; 171ce
	JRS loc_0x0171FA
; ---------------------- ; 171d0
loc_0x0171D2:
	LD A,[1AD4h] ; 171d2
	CP A,#11h ; 171d6
	JRS C,loc_0x0171DC ; 171d8
	LD A,#0FFh ; 171da
loc_0x0171DC:
	INC A ; 171dc
	JRS loc_0x0171E9
; ---------------------- ; 171dd
loc_0x0171DF:
	LD A,[1AD4h] ; 171df
	OR A,A ; 171e3
	JRS NZ,loc_0x0171E8 ; 171e4
	LD A,#12h ; 171e6
loc_0x0171E8:
	DEC A ; 171e8
loc_0x0171E9:
	LD [1AD4h],A ; 171e9
	LD A,[1AB6h] ; 171ed
	AND A,A ; 171f1
	JRS Z,loc_0x0171FA ; 171f2
	LD A,#04h ; 171f4
	LD [14FAh],A ; 171f6
loc_0x0171FA:
	LD A,[1AD4h] ; 171fa
	CP A,#10h ; 171fe
	JRS C,loc_0x01720C ; 17200
	SUB A,#10h ; 17202
	CARL loc_0x0023D8 ; 17204
	LD HL,#1AD3h ; 17207
	JRS loc_0x017220
; ---------------------- ; 1720a
loc_0x01720C:
	CP A,#08h ; 1720c
	JRS C,loc_0x01721A ; 1720e
	SUB A,#08h ; 17210
	CARL loc_0x0023D8 ; 17212
	LD HL,#1AD2h ; 17215
	JRS loc_0x017220
; ---------------------- ; 17218
loc_0x01721A:
	CARL loc_0x0023D8 ; 1721a
	LD HL,#1AD1h ; 1721d
loc_0x017220:
	AND A,[HL] ; 17220
	JRS NZ,loc_0x017242 ; 17221
	LD BA,#1A72h ; 17223
	CARL loc_0x00794F ; 17226
	LD BA,#8B00h ; 17229
	LD [162Ch],BA ; 1722c
	LD A,#06h ; 1722f
	LD [162Eh],A ; 17231
	LD BA,#8D00h ; 17235
	LD [162Fh],BA ; 17238
	LD A,#06h ; 1723b
	LD [1631h],A ; 1723d
	RET
; ---------------------- ; 17241
loc_0x017242:
	LD BA,#71BEh ; 17242
	CARL loc_0x00794F ; 17245
	LD A,[1AD4h] ; 17248
loc_0x01724C:
	LD L,A ; 1724c
	LD H,#00h ; 1724d
	LD A,#06h ; 1724f
	DIV ; 17251
	PUSH IP ; 17253
	PUSH IY ; 17254
	PUSH H ; 17255
	LD A,L ; 17257
	LD B,L ; 17258
	ADD A,A ; 17259
	ADD A,B ; 1725a
	ADD A,A ; 1725b
	LD B,#00h ; 1725c
	LD IY,#72D6h ; 1725e
	LD YP,#01h ; 17261
	ADD IY,BA ; 17264
	LD BA,[IY] ; 17266
	LD [1634h],BA ; 17268
	LD A,[IY+02h] ; 1726b
	LD [1636h],A ; 1726e
	LD A,[IY+03h] ; 17272
	LD B,[IY+04h] ; 17275
	LD [1637h],BA ; 17278
	LD A,[IY+05h] ; 1727b
	LD [1639h],A ; 1727e
	POP H ; 17282
	LD A,H ; 17284
	LD B,H ; 17285
	ADD A,A ; 17286
	ADD A,B ; 17287
	ADD A,A ; 17288
	LD B,#00h ; 17289
	LD IY,#72B2h ; 1728b
	LD YP,#01h ; 1728e
	ADD IY,BA ; 17291
	LD BA,[IY] ; 17293
	LD [162Ch],BA ; 17295
	LD A,[IY+02h] ; 17298
	LD [162Eh],A ; 1729b
	LD A,[IY+03h] ; 1729f
	LD B,[IY+04h] ; 172a2
	LD [162Fh],BA ; 172a5
	LD A,[IY+05h] ; 172a8
	LD [1631h],A ; 172ab
	POP IY ; 172af
	POP IP ; 172b0
	RET
; ---------------------- ; 172b1
	DB 00h ; 172b2
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
	DB 16h, 0F8h
; ---------------------- ; 17374
loc_0x017376:
	LD A,[1671h] ; 17376
	CP A,#1Dh ; 1737a
	JRS NC,loc_0x017387 ; 1737c
	LD A,#01h ; 1737e
	LD [IX+06h],A ; 17380
	ADD IY,#0FFFEh ; 17383
	RETS
; ---------------------- ; 17386
loc_0x017387:
	RET
; ---------------------- ; 17387
	DB 9Dh, 99h ; 17388
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
	DB 84h, 0F8h
; ---------------------- ; 1750e
loc_0x017510:
	LD A,[1642h] ; 17510
	BIT A,#01h ; 17514
	JRS Z,loc_0x017523 ; 17516
	CARL loc_0x017586 ; 17518
	JRS Z,loc_0x017523 ; 1751b
	LD BA,#735Ch ; 1751d
	CARL loc_0x00794F ; 17520
loc_0x017523:
	RET
; ---------------------- ; 17523
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
	DB 15h, 0CFh, 0ECh, 0CEh, 40h, 16h, 0CEh, 0CFh
; ---------------------- ; 17537
loc_0x01753F:
	PUSH IX ; 1753f
	LD A,[1AD7h] ; 17540
	ADD A,A ; 17544
	ADD A,A ; 17545
	LD B,#00h ; 17546
	LD IX,#757Ah ; 17548
	ADD IX,BA ; 1754b
	LD XP,#01h ; 1754d
	LD A,[IY] ; 17550
	ADD A,[IX] ; 17551
	LD B,[1B10h] ; 17552
	CP A,B ; 17556
	JRS NC,loc_0x017574 ; 17557
	INC IX ; 17559
	LD A,[IY] ; 1755a
	ADD A,[IX] ; 1755b
	CP A,B ; 1755c
	JRS C,loc_0x017574 ; 1755d
	INC IY ; 1755f
	INC IX ; 17560
	LD A,[IY] ; 17561
	ADD A,[IX] ; 17562
	LD B,[1B11h] ; 17563
	CP A,B ; 17567
	JRS NC,loc_0x017574 ; 17568
	INC IX ; 1756a
	LD A,[IY] ; 1756b
	ADD A,[IX] ; 1756c
	CP A,B ; 1756d
	JRS C,loc_0x017574 ; 1756e
	AND SC,#0FEh ; 17570
	JRS loc_0x017576
; ---------------------- ; 17572
loc_0x017574:
	OR SC,#01h ; 17574
loc_0x017576:
	POP IX ; 17576
	POP IY ; 17577
	POP IP ; 17578
	RET
; ---------------------- ; 17579
	DB 22h, 27h, 0Eh, 17h, 1Ah, 1Fh, 11h, 1Ah ; 1757a
	DB 26h, 2Bh, 0Fh, 18h
; ---------------------- ; 17582
loc_0x017586:
	PUSH IP ; 17586
	PUSH IY ; 17587
	LD A,[IX+14h] ; 17588
	LD B,[IX+15h] ; 1758b
	LD IY,BA ; 1758e
	LD A,[IX+16h] ; 17590
	LD YP,A ; 17593
	PUSH IX ; 17595
	LD A,[1AD7h] ; 17596
	ADD A,A ; 1759a
	ADD A,A ; 1759b
	LD B,#00h ; 1759c
	LD IX,#75D0h ; 1759e
	ADD IX,BA ; 175a1
	LD XP,#01h ; 175a3
	LD A,[IY] ; 175a6
	ADD A,[IX] ; 175a7
	LD B,[1B10h] ; 175a8
	CP A,B ; 175ac
	JRS NC,loc_0x0175CA ; 175ad
	INC IX ; 175af
	LD A,[IY] ; 175b0
	ADD A,[IX] ; 175b1
	CP A,B ; 175b2
	JRS C,loc_0x0175CA ; 175b3
	INC IY ; 175b5
	INC IX ; 175b6
	LD A,[IY] ; 175b7
	ADD A,[IX] ; 175b8
	LD B,[1B11h] ; 175b9
	CP A,B ; 175bd
	JRS NC,loc_0x0175CA ; 175be
	INC IX ; 175c0
	LD A,[IY] ; 175c1
	ADD A,[IX] ; 175c2
	CP A,B ; 175c3
	JRS C,loc_0x0175CA ; 175c4
	AND SC,#0FEh ; 175c6
	JRS loc_0x0175CC
; ---------------------- ; 175c8
loc_0x0175CA:
	OR SC,#01h ; 175ca
loc_0x0175CC:
	POP IX ; 175cc
	POP IY ; 175cd
	POP IP ; 175ce
	RET
; ---------------------- ; 175cf
	DB 25h, 2Ah, 0Eh, 17h, 21h, 26h, 11h, 1Ah ; 175d0
	DB 22h, 27h, 0Fh, 18h, 08h, 00h, 28h, 0CAh ; 175d8
	DB 8Eh, 99h, 08h, 00h, 2Ch, 0CAh, 8Eh, 99h ; 175e0
	DB 08h, 00h ; 175e8
	ASCII "0" ; 175ea
	DB 0CAh, 8Eh, 99h, 08h, 00h ; 175eb
	ASCII "4" ; 175f0
	DB 0CAh, 8Eh, 99h, 08h, 00h ; 175f1
	ASCII "8" ; 175f6
	DB 0CAh, 8Eh, 99h, 08h, 00h, 3Ch, 0CAh, 8Eh ; 175f7
	DB 99h, 08h, 00h, 40h, 0CAh, 8Eh, 99h, 08h ; 175ff
	DB 00h ; 17607
	ASCII "D" ; 17608
	DB 0CAh, 8Eh, 99h
; ---------------------- ; 17609
loc_0x01760C:
	LD A,[1645h] ; 1760c
	BIT A,#20h ; 17610
	JRS NZ,loc_0x017624 ; 17612
	BIT A,#40h ; 17614
	JRS Z,loc_0x017640 ; 17616
	LD A,[1AD5h] ; 17618
	INC A ; 1761c
	CP A,#08h ; 1761d
	JRS C,loc_0x01762F ; 1761f
	XOR A,A ; 17621
	JRS loc_0x01762F
; ---------------------- ; 17622
loc_0x017624:
	LD A,[1AD5h] ; 17624
	DEC A ; 17628
	CP A,#0FFh ; 17629
	JRS NZ,loc_0x01762F ; 1762b
	LD A,#07h ; 1762d
loc_0x01762F:
	LD [1AD5h],A ; 1762f
	LD A,[1AB6h] ; 17633
	AND A,A ; 17637
	JRS Z,loc_0x017640 ; 17638
	LD A,#04h ; 1763a
	LD [14FAh],A ; 1763c
loc_0x017640:
	LD A,[1AD5h] ; 17640
	CARL loc_0x01765B ; 17644
	LD L,[IX+18h] ; 17647
	LD H,[IX+19h] ; 1764a
	CP BA,HL ; 1764d
	JRS Z,loc_0x01765A ; 1764f
	LD [IX+18h],A ; 17651
	LD [IX+19h],B ; 17654
	CARL loc_0x00794F ; 17657
loc_0x01765A:
	RET
; ---------------------- ; 1765a
loc_0x01765B:
	CP A,#07h ; 1765b
	JRS C,loc_0x017661 ; 1765d
	LD A,#07h ; 1765f
loc_0x017661:
	PUSH IP ; 17661
	PUSH IY ; 17662
	LD IY,#7673h ; 17663
	LD YP,#01h ; 17666
	ADD A,A ; 17669
	LD B,#00h ; 1766a
	ADD IY,BA ; 1766c
	LD BA,[IY] ; 1766e
	POP IY ; 17670
	POP IP ; 17671
	RET
; ---------------------- ; 17672
	DB 0DCh ; 17673
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

loc_0x01804C:

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
	DB 01h
; ---------------------- ; 1810c
loc_0x01810D:

	LD A,[1B36h] ; 1810d
	OR A,A ; 18111
	JRS Z,loc_0x018117 ; 18112

	LD IY,#80A9h ; 18114

loc_0x018117:

	CARL loc_0x002D72 ; 18117

	LD HL,#0000h ; 1811a
	LD IY,#04E3h ; 1811d
	LD NB,#02h ; 18120
	CARL loc_0x011B84 ; 18123

	LD HL,#0000h ; 18126
	LD IY,#0547h ; 18129
	LD NB,#02h ; 1812c
	CARL loc_0x011B84 ; 1812f

	LD HL,#0000h ; 18132
	LD IY,#027Bh ; 18135
	LD NB,#02h ; 18138
	CARL loc_0x011B84 ; 1813b

	LD HL,#0000h ; 1813e
	LD IY,#030Ah ; 18141
	LD NB,#02h ; 18144
	CARL loc_0x011B84 ; 18147

	LD HL,#0000h ; 1814a
	LD IY,#0385h ; 1814d
	LD NB,#02h ; 18150
	CARL loc_0x011B84 ; 18153

	LD HL,#0000h ; 18156
	LD IY,#03ECh ; 18159
	LD NB,#02h ; 1815c
	CARL loc_0x011B84 ; 1815f

	LD IY,#13AEh ; 18162
	LD NB,#02h ; 18165
	CARL loc_0x011B84 ; 18168
	CARL loc_0x00233F ; 1816b
	CARL loc_0x0021FB ; 1816e

	OR [BR:24h],#20h ; 18171
	OR [BR:40h],#02h ; 18174

	LD A,#01h ; 18177
	LD [163Ah],A ; 18179

	RET
	
; ---------------------- ; 1817d
loc_0x01817E:

	CARL loc_0x0189F1 ; 1817e
	CARL loc_0x002346 ; 18181

	LD HL,#1643h ; 18184
	BIT [HL],#02h ; 18187
	JRS NZ,loc_0x018193 ; 18189

	LD HL,#1643h ; 1818b
	BIT [HL],#01h ; 1818e
	JRS NZ,loc_0x0181B7 ; 18190

	RET

; ---------------------- ; 18192
loc_0x018193:

	LD A,[1AB6h] ; 18193
	AND A,A ; 18197
	JRS Z,loc_0x0181A0 ; 18198

	LD A,#02h ; 1819a
	LD [14FAh],A ; 1819c

loc_0x0181A0:

	LD BA,#1AD6h ; 181a0
	SUB BA,#1AB5h ; 181a3
	CARL loc_0x0028BF ; 181a6

	LD A,[1B0Fh] ; 181a9
	CARL loc_0x00268D ; 181ad
	CARL loc_0x0022EE ; 181b0
	CARL loc_0x00228F ; 181b3

	RET

; ---------------------- ; 181b6
loc_0x0181B7:
	LD A,[1ABBh] ; 181b7
	CP A,#04h ; 181bb
	JRS Z,loc_0x0181CC ; 181bd
	CP A,#05h ; 181bf
	JRS Z,loc_0x0181F2 ; 181c1
	CP A,#06h ; 181c3
	JRS Z,loc_0x018218 ; 181c5
	CP A,#07h ; 181c7
	JRS Z,loc_0x01823E ; 181c9
	RET
; ---------------------- ; 181cb
loc_0x0181CC:
	LD A,[1AB6h] ; 181cc
	AND A,A ; 181d0
	JRS Z,loc_0x0181D9 ; 181d1
	LD A,#01h ; 181d3
	LD [14FAh],A ; 181d5
loc_0x0181D9:
	LD BA,#1AD6h ; 181d9
	SUB BA,#1AB5h ; 181dc
	CARL loc_0x0028BF ; 181df
	LD A,[1B0Fh] ; 181e2
	CARL loc_0x00268D ; 181e6
	LD HL,#0E6B1h ; 181e9
	LD B,#03h ; 181ec
	CARL loc_0x00228F ; 181ee
	RET
; ---------------------- ; 181f1
loc_0x0181F2:
	LD A,[1AB6h] ; 181f2
	AND A,A ; 181f6
	JRS Z,loc_0x0181FF ; 181f7
	LD A,#01h ; 181f9
	LD [14FAh],A ; 181fb
loc_0x0181FF:
	LD BA,#1AD6h ; 181ff
	SUB BA,#1AB5h ; 18202
	CARL loc_0x0028BF ; 18205
	LD A,[1B0Fh] ; 18208
	CARL loc_0x00268D ; 1820c
	LD HL,#828Ah ; 1820f
	LD B,#03h ; 18212
	CARL loc_0x00228F ; 18214
	RET
; ---------------------- ; 18217
loc_0x018218:
	LD A,[1AB6h] ; 18218
	AND A,A ; 1821c
	JRS Z,loc_0x018225 ; 1821d
	LD A,#01h ; 1821f
	LD [14FAh],A ; 18221
loc_0x018225:
	LD BA,#1AD6h ; 18225
	SUB BA,#1AB5h ; 18228
	CARL loc_0x0028BF ; 1822b
	LD A,[1B0Fh] ; 1822e
	CARL loc_0x00268D ; 18232
	LD HL,#846Dh ; 18235
	LD B,#03h ; 18238
	CARL loc_0x00228F ; 1823a
	RET
; ---------------------- ; 1823d
loc_0x01823E:
	LD A,[1AB6h] ; 1823e
	AND A,A ; 18242
	JRS Z,loc_0x01824B ; 18243
	LD A,#01h ; 18245
	LD [14FAh],A ; 18247
loc_0x01824B:
	LD BA,#1AD6h ; 1824b
	SUB BA,#1AB5h ; 1824e
	CARL loc_0x0028BF ; 18251
	LD A,[1B0Fh] ; 18254
	CARL loc_0x00268D ; 18258
	LD HL,#0A238h ; 1825b
	LD B,#03h ; 1825e
	CARL loc_0x00228F ; 18260
	RET
; ---------------------- ; 18263
	DB 06h, 04h, 3Eh, 80h ; 18264
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
	DB 0A0h, 0F2h, 0Fh, 9Fh, 0F8h
; ---------------------- ; 182e9
loc_0x0182EE:
	CARL loc_0x002346 ; 182ee
	LD A,[1ABAh] ; 182f1
	CP A,#00h ; 182f5
	JRS NZ,loc_0x018300 ; 182f7
	LD HL,#1643h ; 182f9
	BIT [HL],#02h ; 182fc
	JRS NZ,loc_0x018310 ; 182fe
loc_0x018300:
	LD A,[1ABAh] ; 18300
	CP A,#06h ; 18304
	JRS NZ,loc_0x01830F ; 18306
	LD HL,#1643h ; 18308
	BIT [HL],#01h ; 1830b
	JRS NZ,loc_0x01832C ; 1830d
loc_0x01830F:
	RET
; ---------------------- ; 1830f
loc_0x018310:
	LD A,[1AB6h] ; 18310
	AND A,A ; 18314
	JRS Z,loc_0x01831D ; 18315
	LD A,#02h ; 18317
	LD [14FAh],A ; 18319
loc_0x01831D:
	LD A,[1915h] ; 1831d
	CP A,#0FCh ; 18321
	JRS NZ,loc_0x01832B ; 18323
	CARL loc_0x0022EE ; 18325
	CARL loc_0x00228F ; 18328
loc_0x01832B:
	RET
; ---------------------- ; 1832b
loc_0x01832C:
	LD IX,#15AAh ; 1832c
	LD XP,#00h ; 1832f
	CARL loc_0x004A54 ; 18332
	CARL loc_0x0022D4 ; 18335
	CARL loc_0x00228F ; 18338
	RET
; ---------------------- ; 1833b
	DB 06h, 04h, 3Eh, 80h ; 1833c
	ASCII "E" ; 18340
	DB 02h, 80h ; 18341
	ASCII "E" ; 18343
	DB 02h, 00h, 10h, 02h, 00h, 10h, 02h ; 18344
	ASCIZ "m/" ; 1834b
	DB 12h, 84h, 03h, 00h, 00h, 00h, 8Bh, 0E6h ; 1834e
	DB 03h, 18h, 04h, 03h, 0F8h, 25h, 00h, 00h ; 18356
	DB 00h, 00h, 00h, 00h
; ---------------------- ; 1835e
loc_0x018362:
	CARL loc_0x004B13 ; 18362
	JRL loc_0x01E68B
; ---------------------- ; 18365
loc_0x018368:
	CARL loc_0x0021F4 ; 18368
	CARL loc_0x002338 ; 1836b
	LD NB,#02h ; 1836e
	CARL loc_0x011ADC ; 18371
	LD NB,#00h ; 18374
	CARL loc_0x002BF9 ; 18377
	LD NB,#07h ; 1837a
	CARL loc_0x0382F4 ; 1837d
	LD NB,#00h ; 18380
	CARL loc_0x0035C6 ; 18383
	JRS loc_0x0183A0
; ---------------------- ; 18386
loc_0x018388:
	CARL loc_0x0021F4 ; 18388
	CARL loc_0x002338 ; 1838b
	LD NB,#02h ; 1838e
	CARL loc_0x011ADC ; 18391
	LD NB,#00h ; 18394
	CARL loc_0x002BF9 ; 18397
	LD NB,#07h ; 1839a
	CARL loc_0x0382F4 ; 1839d
loc_0x0183A0:
	CARL loc_0x0046B6 ; 183a0
	CP A,#00h ; 183a3
	JRL Z,loc_0x018362 ; 183a5
	CP A,#04h ; 183a8
	JRS Z,loc_0x0183AC ; 183aa
loc_0x0183AC:
	LD IX,#15AAh ; 183ac
	LD XP,#00h ; 183af
	LD A,#02h ; 183b2
	LD [IX+00h],A ; 183b4
	LD A,#0Ch ; 183b7
	LD [IX+01h],A ; 183b9
	LD A,#01h ; 183bc
	LD [IX+02h],A ; 183be
	LD A,#00h ; 183c1
	LD [IX+03h],A ; 183c3
	LD A,#00h ; 183c6
	LD [IX+04h],A ; 183c8
	LD A,#00h ; 183cb
	LD [IX+05h],A ; 183cd
	CARL loc_0x004A54 ; 183d0
	LD IY,#833Ch ; 183d3
	LD YP,#01h ; 183d6
	CARL loc_0x002D72 ; 183d9
	XOR A,A ; 183dc
	LD [1ABAh],A ; 183dd
	LD IY,#064Ch ; 183e1
	LD NB,#02h ; 183e4
	CARL loc_0x011B84 ; 183e7
	LD IY,#13AEh ; 183ea
	LD NB,#02h ; 183ed
	CARL loc_0x011B84 ; 183f0
	LD HL,#0303h ; 183f3
	LD IY,#897Eh ; 183f6
	LD NB,#07h ; 183f9
	CARL loc_0x03836A ; 183fc
	LD HL,#0503h ; 183ff
	LD IY,#8912h ; 18402
	LD NB,#07h ; 18405
	CARL loc_0x03836A ; 18408
	CARL loc_0x00233F ; 1840b
	CARL loc_0x0021FB ; 1840e
	RET
; ---------------------- ; 18411
loc_0x018412:
	CARL loc_0x002346 ; 18412
	LD A,[1ABAh] ; 18415
	AND A,A ; 18419
	JRS NZ,loc_0x018423 ; 1841a
	LD HL,#1643h ; 1841c
	BIT [HL],#02h ; 1841f
	JRS NZ,loc_0x018433 ; 18421
loc_0x018423:
	LD A,[1ABAh] ; 18423
	CP A,#06h ; 18427
	JRS NZ,loc_0x018432 ; 18429
	LD HL,#1643h ; 1842b
	BIT [HL],#01h ; 1842e
	JRS NZ,loc_0x018434 ; 18430
loc_0x018432:
	RET
; ---------------------- ; 18432
loc_0x018433:
	RET
; ---------------------- ; 18433
loc_0x018434:
	LD IX,#15AAh ; 18434
	LD XP,#00h ; 18437
	CARL loc_0x004A54 ; 1843a
	CARL loc_0x004B13 ; 1843d
	CARL loc_0x0022D4 ; 18440
	CARL loc_0x00228F ; 18443
	RET
; ---------------------- ; 18446
	DB 06h, 04h, 0Eh, 00h ; 18447
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
	DB 02h, 0Ch, 08h
; ---------------------- ; 1846a
loc_0x01846D:
	CARL loc_0x0021F4 ; 1846d
	CARL loc_0x002338 ; 18470
	LD NB,#02h ; 18473
	CARL loc_0x011ADC ; 18476
	LD NB,#00h ; 18479
	CARL loc_0x002BF9 ; 1847c
	LD NB,#07h ; 1847f
	CARL loc_0x0382F4 ; 18482
	LD IY,#8447h ; 18485
	LD YP,#01h ; 18488
	CARL loc_0x002D72 ; 1848b
	LD A,#01h ; 1848e
	LD [168Eh],A ; 18490
	LD HL,#0000h ; 18494
	LD IY,#0697h ; 18497
	LD NB,#02h ; 1849a
	CARL loc_0x011B84 ; 1849d
	LD IY,#13AEh ; 184a0
	LD NB,#02h ; 184a3
	CARL loc_0x011B84 ; 184a6
	CARL loc_0x00233F ; 184a9
	CARL loc_0x0021FB ; 184ac
	RET
; ---------------------- ; 184af
loc_0x0184B0:
	CARL loc_0x002346 ; 184b0
	LD HL,#1643h ; 184b3
	BIT [HL],#01h ; 184b6
	JRS NZ,loc_0x0184C2 ; 184b8
loc_0x0184BA:
	LD HL,#1643h ; 184ba
	BIT [HL],#02h ; 184bd
	JRS NZ,loc_0x0184E3 ; 184bf
	RET
; ---------------------- ; 184c1
loc_0x0184C2:
	LD A,[1AB6h] ; 184c2
	AND A,A ; 184c6
	JRS Z,loc_0x0184CF ; 184c7
	LD A,#01h ; 184c9
	LD [14FAh],A ; 184cb
loc_0x0184CF:
	LD A,[168Eh] ; 184cf
	AND A,A ; 184d3
	JRS NZ,loc_0x0184F0 ; 184d4
	LD NB,#03h ; 184d6
	CARL loc_0x01804C ; 184d9
	CARL loc_0x0022D4 ; 184dc
	CARL loc_0x00228F ; 184df
	RET
; ---------------------- ; 184e2
loc_0x0184E3:
	LD A,[1AB6h] ; 184e3
	AND A,A ; 184e7
	JRS Z,loc_0x0184F0 ; 184e8
	LD A,#02h ; 184ea
	LD [14FAh],A ; 184ec
loc_0x0184F0:
	CARL loc_0x0022EE ; 184f0
	CARL loc_0x00228F ; 184f3
	RET
; ---------------------- ; 184f6
	DB 07h, 04h, 1Eh, 00h ; 184f7
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
	DB 1Ah
; ---------------------- ; 18522
loc_0x018523:
	CARL loc_0x0021F4 ; 18523
	CARL loc_0x002338 ; 18526
	LD NB,#02h ; 18529
	CARL loc_0x011ADC ; 1852c
	LD NB,#00h ; 1852f
	CARL loc_0x002BF9 ; 18532
	LD NB,#07h ; 18535
	CARL loc_0x0382F4 ; 18538
	LD IY,#84F7h ; 1853b
	LD YP,#01h ; 1853e
	CARL loc_0x002D72 ; 18541
	LD HL,#0000h ; 18544
	LD IY,#1FA8h ; 18547
	LD NB,#02h ; 1854a
	CARL loc_0x011B84 ; 1854d
	LD HL,#0000h ; 18550
	LD IY,#1FAEh ; 18553
	LD NB,#02h ; 18556
	CARL loc_0x011B84 ; 18559
	LD HL,#1B2Fh ; 1855c
	LD IY,#2014h ; 1855f
	LD NB,#02h ; 18562
	CARL loc_0x011B84 ; 18565
	LD HL,#1B2Bh ; 18568
	LD IY,#2029h ; 1856b
	LD NB,#02h ; 1856e
	CARL loc_0x011B84 ; 18571
	LD IY,#13AEh ; 18574
	LD NB,#02h ; 18577
	CARL loc_0x011B84 ; 1857a
	CARL loc_0x00233F ; 1857d
	CARL loc_0x0021FB ; 18580
	RET
; ---------------------- ; 18583
loc_0x018584:
	CARL loc_0x002346 ; 18584
	LD A,[1643h] ; 18587
	BIT A,#04h ; 1858b
	JRS NZ,loc_0x018603 ; 1858d
	BIT A,#02h ; 1858f
	JRS NZ,loc_0x0185E1 ; 18591
	BIT A,#01h ; 18593
	JRS Z,loc_0x0185CA ; 18595
	LD A,[1AB6h] ; 18597
	AND A,A ; 1859b
	JRS Z,loc_0x0185A4 ; 1859c
	LD A,#01h ; 1859e
	LD [14FAh],A ; 185a0
loc_0x0185A4:
	LD HL,#0A3F9h ; 185a4
	LD B,#03h ; 185a7
	LD A,[1642h] ; 185a9
	BIT A,#60h ; 185ad
	JRS Z,loc_0x0185B9 ; 185af
	XOR A,A ; 185b1
	LD [1AD6h],A ; 185b2
	CARL loc_0x0022D4 ; 185b6
loc_0x0185B9:
	CARL loc_0x00228F ; 185b9
	LD A,[1AD7h] ; 185bc
	CP A,#03h ; 185c0
	JRS C,loc_0x0185CA ; 185c2
	LD A,#02h ; 185c4
	LD [1AD7h],A ; 185c6
loc_0x0185CA:
	RET
; ---------------------- ; 185ca
loc_0x0185CB:
	LD A,[1AB6h] ; 185cb
	AND A,A ; 185cf
	JRS Z,loc_0x0185D8 ; 185d0
	LD A,#02h ; 185d2
	LD [14FAh],A ; 185d4
loc_0x0185D8:
	LD HL,#80EFh ; 185d8
	LD B,#03h ; 185db
	CARL loc_0x00228F ; 185dd
	RET
; ---------------------- ; 185e0
loc_0x0185E1:
	LD A,[1AB6h] ; 185e1
	AND A,A ; 185e5
	JRS Z,loc_0x0185EE ; 185e6
	LD A,#21h ; 185e8
	LD [14FAh],A ; 185ea
loc_0x0185EE:
	RET
; ---------------------- ; 185ee
loc_0x0185EF:
	LD A,[1AB6h] ; 185ef
	AND A,A ; 185f3
	JRS Z,loc_0x0185FC ; 185f4
	LD A,#02h ; 185f6
	LD [14FAh],A ; 185f8
loc_0x0185FC:
	CARL loc_0x0022EE ; 185fc
	CARL loc_0x00228F ; 185ff
	RET
; ---------------------- ; 18602
loc_0x018603:
	LD A,[1AB6h] ; 18603
	AND A,A ; 18607
	JRS Z,loc_0x018612 ; 18608
	LD A,[1AD7h] ; 1860a
	LD [14FAh],A ; 1860e
loc_0x018612:
	RET
; ---------------------- ; 18612
	DB 0Dh, 04h, 3Eh, 00h ; 18613
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
	DB 03h, 0Ch, 08h
; ---------------------- ; 18636
loc_0x018639:
	CARL loc_0x018DE3 ; 18639
	LD HL,[1AE5h] ; 1863c
	CP HL,#0480h ; 1863f
	JRS C,loc_0x01864D ; 18642
	LD HL,#0E463h ; 18644
	LD B,#03h ; 18647
	CARL loc_0x00227C ; 18649
	RET
; ---------------------- ; 1864c
loc_0x01864D:
	LD A,[1ADBh] ; 1864d
	LD HL,#1ADAh ; 18651
	OR A,[HL] ; 18654
	JRS NZ,loc_0x01867A ; 18655
	LD NB,#02h ; 18657
	CARL loc_0x012FC4 ; 1865a
	LD B,#28h ; 1865d
loc_0x01865F:
	PUSH B ; 1865f
	LD NB,#02h ; 18661
	CARL loc_0x012F8F ; 18664
	POP B ; 18667
	DJR NZ,loc_0x01865F ; 18669
	LD A,#02h ; 1866b
	LD [1ADCh],A ; 1866d
	LD HL,#0E5C2h ; 18671
	LD B,#03h ; 18674
	CARL loc_0x00227C ; 18676
	RET
; ---------------------- ; 18679
loc_0x01867A:
	XOR A,A ; 1867a
	LD [1B22h],A ; 1867b
	LD [1B69h],A ; 1867f
	LD IX,#15AAh ; 18683
	LD XP,#00h ; 18686
	CARL loc_0x004706 ; 18689
	LD A,[15ADh] ; 1868c
	CP A,#07h ; 18690
	JRS C,loc_0x018698 ; 18692
	CP A,#15h ; 18694
	JRS C,loc_0x0186B2 ; 18696
loc_0x018698:
	LD A,#01h ; 18698
	LD [1B14h],A ; 1869a
	LD A,#00h ; 1869e
	LD [1B15h],A ; 186a0
	LD A,#0FFh ; 186a4
	LD [1AE8h],A ; 186a6
	LD A,#01h ; 186aa
	LD [1AD8h],A ; 186ac
	JRS loc_0x0186B5
; ---------------------- ; 186b0
loc_0x0186B2:
	CARL loc_0x018F5C ; 186b2
loc_0x0186B5:
	CARL loc_0x018D96 ; 186b5
loc_0x0186B8:
	LD A,[1B15h] ; 186b8
	CP A,#03h ; 186bc
	JRS Z,loc_0x0186CA ; 186be
	CP A,#04h ; 186c0
	JRS Z,loc_0x0186CA ; 186c2
	LD A,#00h ; 186c4
	LD [1B15h],A ; 186c6
loc_0x0186CA:
	XOR A,A ; 186ca
	LD [1B17h],A ; 186cb
	LD [1B29h],A ; 186cf
	LD [1B28h],A ; 186d3
	LD [1B1Ch],A ; 186d7
	LD [1B1Dh],A ; 186db
	LD [1B20h],A ; 186df
	CARL loc_0x018C96 ; 186e3
	CARL loc_0x0021F4 ; 186e6
	CARL loc_0x002338 ; 186e9
	LD NB,#02h ; 186ec
	CARL loc_0x011ADC ; 186ef
	LD NB,#00h ; 186f2
	CARL loc_0x002BF9 ; 186f5
	LD NB,#07h ; 186f8
	CARL loc_0x0382F4 ; 186fb
	LD IY,#8613h ; 186fe
	LD YP,#01h ; 18701
	CARL loc_0x002D72 ; 18704
	CARL loc_0x018904 ; 18707
	LD HL,#0000h ; 1870a
	LD IY,#0C445h ; 1870d
	LD YP,#00h ; 18710
	LD NB,#02h ; 18713
	CARL loc_0x011EB1 ; 18716
	LD HL,#0000h ; 18719
	LD IY,#0C3DEh ; 1871c
	LD YP,#00h ; 1871f
	LD NB,#02h ; 18722
	CARL loc_0x011EB1 ; 18725
	LD HL,[1B10h] ; 18728
	LD IY,#0BCD3h ; 1872b
	LD YP,#00h ; 1872e
	LD NB,#02h ; 18731
	CARL loc_0x011EB1 ; 18734
	LD A,[1AD8h] ; 18737
	CP A,#01h ; 1873b
	JRS NZ,loc_0x01874D ; 1873d
	LD HL,#2D4Bh ; 1873f
	LD IY,#276Fh ; 18742
	LD NB,#02h ; 18745
	CARL loc_0x011B84 ; 18748
	JRS loc_0x018764
; ---------------------- ; 1874b
loc_0x01874D:
	LD A,[1AD7h] ; 1874d
	CP A,#02h ; 18751
	JRS NZ,loc_0x018764 ; 18753
	LD HL,#0000h ; 18755
	LD IY,#0C759h ; 18758
	LD YP,#00h ; 1875b
	LD NB,#02h ; 1875e
	CARL loc_0x011EB1 ; 18761
loc_0x018764:
	LD HL,[1B12h] ; 18764
	LD IY,#0AA34h ; 18767
	LD YP,#00h ; 1876a
	LD NB,#02h ; 1876d
	CARL loc_0x011EB1 ; 18770
	LD HL,#0000h ; 18773
	LD IY,#354Ch ; 18776
	LD YP,#01h ; 18779
	LD NB,#02h ; 1877c
	CARL loc_0x011B84 ; 1877f
	LD HL,#0000h ; 18782
	LD IY,#3B14h ; 18785
	LD YP,#01h ; 18788
	LD NB,#02h ; 1878b
	CARL loc_0x011B84 ; 1878e
	LD HL,#0000h ; 18791
	LD IY,#401Ch ; 18794
	LD YP,#01h ; 18797
	LD NB,#02h ; 1879a
	CARL loc_0x011B84 ; 1879d
	LD HL,#0000h ; 187a0
	LD IY,#4517h ; 187a3
	LD YP,#01h ; 187a6
	LD NB,#02h ; 187a9
	CARL loc_0x011B84 ; 187ac
	LD HL,#0000h ; 187af
	LD IY,#4A12h ; 187b2
	LD YP,#01h ; 187b5
	LD NB,#02h ; 187b8
	CARL loc_0x011B84 ; 187bb
	LD HL,#1021h ; 187be
	LD IY,#0B6EEh ; 187c1
	LD YP,#00h ; 187c4
	LD NB,#02h ; 187c7
	CARL loc_0x011EB1 ; 187ca
	LD HL,#2520h ; 187cd
	LD IY,#0C8EEh ; 187d0
	LD YP,#00h ; 187d3
	LD NB,#02h ; 187d6
	CARL loc_0x011EB1 ; 187d9
	LD HL,#0000h ; 187dc
	LD IY,#0B8F2h ; 187df
	LD YP,#00h ; 187e2
	LD NB,#02h ; 187e5
	CARL loc_0x011EB1 ; 187e8
	LD A,[1AD8h] ; 187eb
	CP A,#01h ; 187ef
	JRS NZ,loc_0x0187FF ; 187f1
	LD HL,#2D4Bh ; 187f3
	LD IY,#2775h ; 187f6
	LD NB,#02h ; 187f9
	CARL loc_0x011B84 ; 187fc
loc_0x0187FF:
	LD HL,#0001h ; 187ff
	LD IY,#8D92h ; 18802
	LD NB,#07h ; 18805
	CARL loc_0x03836A ; 18808
	LD A,[1AD8h] ; 1880b
	CP A,#01h ; 1880f
	JRS NZ,loc_0x01882B ; 18811
	LD HL,#0100h ; 18813
	LD IY,#8E3Dh ; 18816
	LD NB,#07h ; 18819
	CARL loc_0x03836A ; 1881c
	LD HL,#0305h ; 1881f
	LD IY,#8DF4h ; 18822
	LD NB,#07h ; 18825
	CARL loc_0x03836A ; 18828
loc_0x01882B:
	LD A,[1AD8h] ; 1882b
	CP A,#00h ; 1882f
	JRS NZ,loc_0x01888F ; 18831
	LD HL,#0100h ; 18833
	LD IY,#8ED9h ; 18836
	LD NB,#07h ; 18839
	CARL loc_0x03836A ; 1883c
	LD A,[1AD7h] ; 1883f
	CP A,#00h ; 18843
	JRS Z,loc_0x018860 ; 18845
	CP A,#01h ; 18847
	JRS Z,loc_0x018880 ; 18849
	CP A,#02h ; 1884b
	JRS NZ,loc_0x01888F ; 1884d
	LD HL,#291Ch ; 1884f
	LD IY,#0C5E5h ; 18852
	LD YP,#00h ; 18855
	LD NB,#02h ; 18858
	CARL loc_0x011EB1 ; 1885b
	JRS loc_0x01888F
; ---------------------- ; 1885e
loc_0x018860:
	LD HL,#2C20h ; 18860
	LD IY,#0C4C6h ; 18863
	LD YP,#00h ; 18866
	LD NB,#02h ; 18869
	CARL loc_0x011EB1 ; 1886c
	LD HL,#1808h ; 1886f
	LD IY,#0C658h ; 18872
	LD YP,#00h ; 18875
	LD NB,#02h ; 18878
	CARL loc_0x011EB1 ; 1887b
	JRS loc_0x01888F
; ---------------------- ; 1887e
loc_0x018880:
	LD HL,#2520h ; 18880
	LD IY,#0CA7Fh ; 18883
	LD YP,#00h ; 18886
	LD NB,#02h ; 18889
	CARL loc_0x011EB1 ; 1888c
loc_0x01888F:
	LD IY,#13AEh ; 1888f
	LD NB,#02h ; 18892
	CARL loc_0x011B84 ; 18895
	LD A,[1B14h] ; 18898
	CARL loc_0x01898C ; 1889c
	LD A,[1B2Ah] ; 1889f
	OR A,A ; 188a3
	JRS Z,loc_0x0188B9 ; 188a4
	LD BA,#8000h ; 188a6
	LD [1634h],BA ; 188a9
	LD [1637h],BA ; 188ac
	LD A,#05h ; 188af
	LD [1636h],A ; 188b1
	LD [1639h],A ; 188b5
loc_0x0188B9:
	LD BR,#20h ; 188b9
	OR [BR:26h],#40h ; 188bb
	CARL loc_0x00233F ; 188be
	CARL loc_0x0021FB ; 188c1
	LD A,[1B22h] ; 188c4
	OR A,A ; 188c8
	JRS Z,loc_0x0188DD ; 188c9
	XOR A,A ; 188cb
	LD [1B22h],A ; 188cc
	LD A,[1AB6h] ; 188d0
	AND A,A ; 188d4
	JRS Z,loc_0x0188DD ; 188d5
	LD A,#07h ; 188d7
	LD [14FAh],A ; 188d9
loc_0x0188DD:
	RET
; ---------------------- ; 188dd
loc_0x0188DE:
	CARL loc_0x0189F1 ; 188de
	CARL loc_0x002346 ; 188e1
	CARL loc_0x018C47 ; 188e4
	LD HL,[1AE5h] ; 188e7
	CP HL,#0480h ; 188ea
	JRS C,loc_0x0188FF ; 188ed
	LD HL,#0E463h ; 188ef
	LD B,#03h ; 188f2
	CARL loc_0x00228F ; 188f4
	LD HL,#8900h ; 188f7
	LD B,#03h ; 188fa
	CARL loc_0x00227C ; 188fc
loc_0x0188FF:
	RET
; ---------------------- ; 188ff
loc_0x018900:
	CARL loc_0x002346 ; 18900
	RET
; ---------------------- ; 18903
loc_0x018904:
	LD A,[1AD8h] ; 18904
	CP A,#00h ; 18908
	JRS Z,loc_0x01890E ; 1890a
	JRS loc_0x018947
; ---------------------- ; 1890c
loc_0x01890E:
	LD A,[1AD7h] ; 1890e
	LD L,#0Bh ; 18912
	MLT ; 18914
	LD IY,#896Bh ; 18916
	LD YP,#01h ; 18919
	ADD IY,HL ; 1891c
	LD BA,[IY] ; 1891e
	LD [162Ch],BA ; 18920
	INC IY ; 18923
	INC IY ; 18924
	LD A,[IY] ; 18925
	LD [162Eh],A ; 18926
	INC IY ; 1892a
	LD BA,[IY] ; 1892b
	LD [162Fh],BA ; 1892d
	INC IY ; 18930
	INC IY ; 18931
	LD A,[IY] ; 18932
	LD [1631h],A ; 18933
	INC IY ; 18937
	LD IX,[IY] ; 18938
	INC IY ; 1893a
	INC IY ; 1893b
	LD A,[IY] ; 1893c
	LD XP,A ; 1893d
	INC IY ; 1893f
	LD B,[IY] ; 18940
	LD A,[IY+01h] ; 18941
	CARL loc_0x002C22 ; 18944
loc_0x018947:
	LD IY,#8613h ; 18947
	LD YP,#01h ; 1894a
	LD L,[IY+1Eh] ; 1894d
	LD H,[IY+1Fh] ; 18950
	CP HL,#0000h ; 18953
	JRS Z,loc_0x018967 ; 18956
	LD IX,[1654h] ; 18958
	LD A,[1656h] ; 1895b
	LD XP,A ; 1895f
	LD A,[IY+20h] ; 18961
	CARL loc_0x018968 ; 18964
loc_0x018967:
	RET
; ---------------------- ; 18967
loc_0x018968:
	LD NB,A ; 18968
	JP HL
; ---------------------- ; 1896a
	DB 00h, 5Eh, 03h, 00h ; 1896b
	ASCII "e" ; 1896f
	DB 03h, 17h, 8Fh, 03h, 08h, 0Ch, 00h ; 18970
	ASCII "W" ; 18977
	DB 06h, 00h, 5Eh, 06h ; 18978
	ASCII "w" ; 1897c
	DB 8Fh, 03h, 08h, 0Ch, 00h ; 1897d
	ASCII "e" ; 18982
	DB 06h, 00h ; 18983
	ASCII "l" ; 18985
	DB 06h, 0D7h, 8Fh, 03h, 08h, 0Ch
; ---------------------- ; 18986
loc_0x01898C:
	PUSH IP ; 1898c
	PUSH IY ; 1898d
	LD IY,#89BCh ; 1898e
	LD YP,#01h ; 18991
	CP A,#00h ; 18994
	JRS Z,loc_0x01899B ; 18996
	LD IY,#89C5h ; 18998
loc_0x01899B:
	LD A,[1AD7h] ; 1899b
	LD B,A ; 1899f
	ADD A,A ; 189a0
	ADD A,B ; 189a1
	LD B,#00h ; 189a2
	ADD IY,BA ; 189a4
	LD BA,[IY] ; 189a6
	LD [1634h],BA ; 189a8
	LD [1637h],BA ; 189ab
	LD A,[IY+02h] ; 189ae
	LD [1636h],A ; 189b1
	LD [1639h],A ; 189b5
	POP IY ; 189b9
	POP IP ; 189ba
	RET
; ---------------------- ; 189bb
	DB 00h, 00h, 04h, 00h, 40h, 04h, 00h, 80h ; 189bc
	DB 04h, 00h, 0C0h, 04h, 00h, 00h, 05h, 00h ; 189c4
	DB 40h, 05h
; ---------------------- ; 189cc
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
	DB 60h, 09h, 10h, 0Eh, 0B8h, 0Bh

loc_0x0189F1:
	DB 0C5h, 03h ; 189eb
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
loc_0x018C47:
	LD HL,#1B29h ; 18c47
	LD A,[1B28h] ; 18c4a
	CP A,#03h ; 18c4e
	JRS C,loc_0x018C5A ; 18c50
	LD A,#00h ; 18c52
	LD [1B28h],A ; 18c54
	XOR A,A ; 18c58
	LD [HL],A ; 18c59
loc_0x018C5A:
	LD A,[HL] ; 18c5a
	OR A,A ; 18c5b
	JRS Z,loc_0x018C67 ; 18c5c
	DEC [HL] ; 18c5e
	JRS NZ,loc_0x018C67 ; 18c5f
	LD A,#00h ; 18c61
	LD [1B28h],A ; 18c63
loc_0x018C67:
	LD A,[1677h] ; 18c67
	OR A,A ; 18c6b
	JRS Z,loc_0x018C86 ; 18c6c
	LD A,[1B28h] ; 18c6e
	CP A,#02h ; 18c72
	JRS Z,loc_0x018C7F ; 18c74
	LD [HL],#24h ; 18c76
	LD A,#01h ; 18c78
	LD [1B28h],A ; 18c7a
	RET
; ---------------------- ; 18c7e
loc_0x018C7F:
	LD A,#03h ; 18c7f
	LD [1B28h],A ; 18c81
	RET
; ---------------------- ; 18c85
loc_0x018C86:
	LD A,[1B28h] ; 18c86
	CP A,#01h ; 18c8a
	JRS Z,loc_0x018C8F ; 18c8c
	RET
; ---------------------- ; 18c8e
loc_0x018C8F:
	LD A,#02h ; 18c8f
	LD [1B28h],A ; 18c91
	RET
; ---------------------- ; 18c95
loc_0x018C96:
	LD B,#2Ch ; 18c96
	LD A,[1AD8h] ; 18c98
	CP A,#01h ; 18c9c
	JRS Z,loc_0x018CAA ; 18c9e
	LD A,[1AD7h] ; 18ca0
	CP A,#02h ; 18ca4
	JRS NZ,loc_0x018CAA ; 18ca6
	LD B,#30h ; 18ca8
loc_0x018CAA:
	LD [1B23h],B ; 18caa
	RET
; ---------------------- ; 18cae
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
loc_0x018D07:
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
	DB 0B9h, 0F8h
loc_0x018D96:
	DB 0B0h, 00h, 0CEh, 0D4h, 15h, 1Bh ; 18d94
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
loc_0x018DD1:
	DB 0F2h, 0C3h, 0FEh, 0CEh, 0D1h, 23h, 1Bh, 0B0h ; 18dd1
	DB 28h, 0BCh, 12h, 1Bh ; 18dd9
	ASCII "8" ; 18ddd
	DB 0CEh, 0D4h, 0E8h, 1Ah, 0F8h
loc_0x018DE3:
	DB 0A6h, 0A2h, 0A3h ; 18dde
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
loc_0x018F5C:
	LD A,[1B2Bh] ; 18f5c
	OR A,A ; 18f60
	JRS NZ,loc_0x018FA9 ; 18f61
	LD A,[1AE3h] ; 18f63
	LD L,#04h ; 18f67
	MLT ; 18f69
	LD A,[1AE4h] ; 18f6b
	LD B,#00h ; 18f6f
	ADD HL,BA ; 18f71
	LD A,#15h ; 18f73
	DIV ; 18f75
	LD B,L ; 18f77
	XOR A,A ; 18f78
loc_0x018F79:
	CP A,B ; 18f79
	JRS Z,loc_0x018FA9 ; 18f7a
	PUSH BA ; 18f7c
	LD B,[1AD7h] ; 18f7d
	CARL loc_0x018FAF ; 18f81
	POP BA ; 18f84
	JRS Z,loc_0x018F8A ; 18f85
	INC A ; 18f87
	JRS loc_0x018F79
; ---------------------- ; 18f88
loc_0x018F8A:
	LD [1B2Ch],A ; 18f8a
	CARL loc_0x018FCA ; 18f8e
	LD A,#01h ; 18f91
	LD [1B2Ah],A ; 18f93
	LD A,#01h ; 18f97
	LD [1AD8h],A ; 18f99
	LD A,#00h ; 18f9d
	LD [1B14h],A ; 18f9f
	XOR A,A ; 18fa3
	LD [1AE8h],A ; 18fa4
	RET
; ---------------------- ; 18fa8
loc_0x018FA9:
	XOR A,A ; 18fa9
	LD [1B2Ah],A ; 18faa
	RET
; ---------------------- ; 18fae
loc_0x018FAF:
	PUSH A ; 18faf
	LD A,B ; 18fb1
	ADD A,A ; 18fb2
	LD B,#00h ; 18fb3
	LD HL,#1AC3h ; 18fb5
	ADD HL,BA ; 18fb8
	POP A ; 18fba
	PUSH HL ; 18fbc
	CARL loc_0x0023D8 ; 18fbd
	POP HL ; 18fc0
	OR A,A ; 18fc1
	JRS NZ,loc_0x018FC8 ; 18fc2
	LD A,B ; 18fc4
	INC HL ; 18fc5
	AND A,[HL] ; 18fc6
	RET
; ---------------------- ; 18fc7
loc_0x018FC8:
	AND A,[HL] ; 18fc8
	RET
; ---------------------- ; 18fc9
loc_0x018FCA:
	CARL loc_0x0023D8 ; 18fca
	PUSH BA ; 18fcd
	LD A,[1AD7h] ; 18fce
	ADD A,A ; 18fd2
	LD B,#00h ; 18fd3
	LD HL,#1AC3h ; 18fd5
	ADD HL,BA ; 18fd8
	POP BA ; 18fda
	OR A,A ; 18fdb
	JRS NZ,loc_0x018FE2 ; 18fdc
	INC HL ; 18fde
	LD A,B ; 18fdf
	JRS loc_0x018FE2
; ---------------------- ; 18fe0
loc_0x018FE2:
	OR [HL],A ; 18fe2
	RET
; ---------------------- ; 18fe4
loc_0x018FE5:
	CARL loc_0x018FEC ; 18fe5
	LD [1B0Bh],BA ; 18fe8
	RET
; ---------------------- ; 18feb
loc_0x018FEC:
	LD BA,[1B0Bh] ; 18fec
	LD HL,#4005h ; 18fef
	CARL loc_0x01900C ; 18ff2
	LD HL,#0AEE1h ; 18ff5
	ADD BA,HL ; 18ff8
	LD [1B0Bh],BA ; 18ffa
	RET
; ---------------------- ; 18ffd
loc_0x018FFE:
	INC BA ; 18ffe
	JRS Z,loc_0x018FEC ; 18fff
	PUSH BA ; 19001
	CARL loc_0x018FEC ; 19002
	POP HL ; 19005
	CARL loc_0x01900C ; 19006
	LD BA,HL ; 19009
	RET
; ---------------------- ; 1900b
loc_0x01900C:
	PUSH IP ; 1900c
	PUSH IX ; 1900d
	LD XP,#00h ; 1900e
	LD IX,SP ; 19011
	PUSH HL ; 19013
	MLT ; 19014
	PUSH HL ; 19016
	LD L,[IX+-1h] ; 19017
	MLT ; 1901a
	PUSH HL ; 1901c
	LD L,[IX+-2h] ; 1901d
	LD A,B ; 19020
	MLT ; 19021
	PUSH HL ; 19023
	LD L,[IX+-1h] ; 19024
	MLT ; 19027
	PUSH HL ; 19029
	LD A,[IX+-6h] ; 1902a
	ADD A,[IX+-3h] ; 1902d
	LD [IX+-6h],A ; 19030
	LD A,[IX+-5h] ; 19033
	ADC A,#00h ; 19036
	LD [IX+-5h],A ; 19038
	LD BA,[SP+04h] ; 1903b
	LD HL,[SP+02h] ; 1903e
	ADD HL,BA ; 19041
	LD [SP+02h],HL ; 19043
	LD A,[IX+-9h] ; 19046
	ADC A,#00h ; 19049
	LD [IX+-9h],A ; 1904b
	LD A,[IX+-0Ah] ; 1904e
	ADD A,[IX+-7h] ; 19051
	LD L,A ; 19054
	LD A,[IX+-9h] ; 19055
	ADC A,#00h ; 19058
	LD H,A ; 1905a
	LD B,[IX+-8h] ; 1905b
	LD A,[IX+-4h] ; 1905e
	ADD SP,#000Ah ; 19061
	POP IX ; 19065
	POP IP ; 19066
	RET
; ---------------------- ; 19067
loc_0x019068:
	PUSH EP ; 19068
	PUSH HL ; 19069
	PUSH BA ; 1906a
	SLA A ; 1906b
	LD B,#00h ; 1906d
	LD HL,[SP+05h] ; 1906f
	ADD HL,BA ; 19072
	LD BA,[SP+07h] ; 19074
	SRL A ; 19077
	LD EP,A ; 19079
	LD A,H ; 1907b
	RL A ; 1907c
	RRC A ; 1907e
	LD H,A ; 19080
	LD HL,[HL] ; 19081
	LD [SP+05h],HL ; 19083
	POP BA ; 19086
	POP HL ; 19087
	POP EP ; 19088
	RET
; ---------------------- ; 19089
	DB 0Dh, 04h, 1Eh, 80h ; 1908a
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
	DB 03h, 0Ch, 08h
; ---------------------- ; 190ad
loc_0x0190B0:
	CARL loc_0x0021F4 ; 190b0
	CARL loc_0x002338 ; 190b3
	LD NB,#02h ; 190b6
	CARL loc_0x011ADC ; 190b9
	LD NB,#00h ; 190bc
	CARL loc_0x002BF9 ; 190bf
	LD NB,#07h ; 190c2
	CARL loc_0x0382F4 ; 190c5
	LD IY,#908Ah ; 190c8
	LD YP,#01h ; 190cb
	CARL loc_0x002D72 ; 190ce
	LD A,#01h ; 190d1
	LD [164Dh],A ; 190d3
	LD HL,#0040h ; 190d7
	LD IY,#2075h ; 190da
	LD NB,#02h ; 190dd
	CARL loc_0x011B84 ; 190e0
	LD HL,#0040h ; 190e3
	LD IY,#20A4h ; 190e6
	LD NB,#02h ; 190e9
	CARL loc_0x011B84 ; 190ec
	LD HL,#0040h ; 190ef
	LD IY,#203Bh ; 190f2
	LD NB,#02h ; 190f5
	CARL loc_0x011B84 ; 190f8
	LD HL,#0000h ; 190fb
	LD IY,#21B3h ; 190fe
	LD NB,#02h ; 19101
	CARL loc_0x011B84 ; 19104
	LD IY,#8C5Fh ; 19107
	LD NB,#07h ; 1910a
	CARL loc_0x03836A ; 1910d
	LD IY,#13AEh ; 19110
	LD NB,#02h ; 19113
	CARL loc_0x011B84 ; 19116
	CARL loc_0x00233F ; 19119
	CARL loc_0x0021FB ; 1911c
	RET
; ---------------------- ; 1911f
loc_0x019120:
	CARL loc_0x0189F1 ; 19120
	CARL loc_0x002346 ; 19123
	RET
; ---------------------- ; 19126
	DB 0Dh, 04h, 3Eh, 00h ; 19127
	ASCII "l" ; 1912b
	DB 03h, 00h ; 1912c
	ASCII "l" ; 1912e
	DB 03h, 00h, 00h, 04h, 00h, 00h, 04h ; 1912f
	ASCIZ "m/" ; 19136
	DB 0AAh, 91h, 03h ; 19139
	ASCII "M" ; 1913c
	DB 91h, 03h, 00h, 00h, 00h, 18h, 08h, 04h ; 1913d
	ASCIZ "B&" ; 19145
	DB 00h
; ---------------------- ; 19148
loc_0x019149:
	LD [BR:03h],H ; 19149
	ADC A,[BR:08h] ; 1914b
	LD A,[1AD8h] ; 1914d
	LD [1B6Dh],A ; 19151
	CARL loc_0x0021F4 ; 19155
	CARL loc_0x002338 ; 19158
	LD NB,#02h ; 1915b
	CARL loc_0x011ADC ; 1915e
	LD NB,#00h ; 19161
	CARL loc_0x002BF9 ; 19164
	LD NB,#07h ; 19167
	CARL loc_0x0382F4 ; 1916a
	LD IY,#9127h ; 1916d
	LD YP,#01h ; 19170
	CARL loc_0x002D72 ; 19173
	LD HL,#0000h ; 19176
	LD IY,#233Dh ; 19179
	LD NB,#02h ; 1917c
	CARL loc_0x011B84 ; 1917f
	LD HL,#0300h ; 19182
	LD IY,#9257h ; 19185
	LD NB,#07h ; 19188
	CARL loc_0x03836A ; 1918b
	LD HL,#0600h ; 1918e
	LD IY,#92E0h ; 19191
	LD NB,#07h ; 19194
	CARL loc_0x03836A ; 19197
	LD IY,#13AEh ; 1919a
	LD NB,#02h ; 1919d
	CARL loc_0x011B84 ; 191a0
	CARL loc_0x00233F ; 191a3
	CARL loc_0x0021FB ; 191a6
	RET
; ---------------------- ; 191a9
loc_0x0191AA:
	CARL loc_0x0189F1 ; 191aa
	CARL loc_0x002346 ; 191ad
	RET
; ---------------------- ; 191b0
	DB 0Dh, 04h, 3Eh, 00h ; 191b1
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
	DB 0CEh, 0D4h, 2Dh, 1Bh
; ---------------------- ; 191d8
loc_0x0191DC:
	CARL loc_0x0021F4 ; 191dc
	CARL loc_0x002338 ; 191df
	LD NB,#02h ; 191e2
	CARL loc_0x011ADC ; 191e5
	LD NB,#00h ; 191e8
	CARL loc_0x002BF9 ; 191eb
	LD NB,#07h ; 191ee
	CARL loc_0x0382F4 ; 191f1
	LD IY,#91B1h ; 191f4
	LD YP,#01h ; 191f7
	CARL loc_0x002D72 ; 191fa
	LD A,#00h ; 191fd
	CARL loc_0x01898C ; 191ff
	LD HL,#0C4Ch ; 19202
	LD IY,#0AA3Dh ; 19205
	LD YP,#00h ; 19208
	LD NB,#02h ; 1920b
	CARL loc_0x011EB1 ; 1920e
	CARL loc_0x019260 ; 19211
	LD HL,#0001h ; 19214
	LD IY,#8D92h ; 19217
	LD NB,#07h ; 1921a
	CARL loc_0x03836A ; 1921d
	LD HL,#0205h ; 19220
	LD IY,#95C8h ; 19223
	LD NB,#07h ; 19226
	CARL loc_0x03836A ; 19229
	LD IY,#13AEh ; 1922c
	LD NB,#02h ; 1922f
	CARL loc_0x011B84 ; 19232
	CARL loc_0x00233F ; 19235
	CARL loc_0x0021FB ; 19238
	RET
; ---------------------- ; 1923b
loc_0x01923C:
	CARL loc_0x002346 ; 1923c
	CARL loc_0x018C47 ; 1923f
	LD A,[1643h] ; 19242
	BIT A,#03h ; 19246
	JRS Z,loc_0x01925F ; 19248
	LD A,[1AB6h] ; 1924a
	AND A,A ; 1924e
	JRS Z,loc_0x019257 ; 1924f
	LD A,#02h ; 19251
	LD [14FAh],A ; 19253
loc_0x019257:
	LD HL,#914Dh ; 19257
	LD B,#03h ; 1925a
	CARL loc_0x00228F ; 1925c
loc_0x01925F:
	RET
; ---------------------- ; 1925f
loc_0x019260:
	LD A,[1AD7h] ; 19260
	ADD A,A ; 19264
	LD B,#00h ; 19265
	LD IY,#92A1h ; 19267
	LD YP,#01h ; 1926a
	ADD IY,BA ; 1926d
	LD IY,[IY] ; 1926f
	LD HL,#1391h ; 19271
	LD B,#05h ; 19274
loc_0x019276:
	LD A,[IY] ; 19276
	LD [HL],A ; 19277
	INC IY ; 19278
	INC HL ; 19279
	DJR NZ,loc_0x019276 ; 1927a
	LD B,[1ADDh] ; 1927c
	LD HL,#13C4h ; 19280
	CARS loc_0x0192B6 ; 19283
	LD B,[1ADFh] ; 19285
	LD HL,#13DCh ; 19289
	CARS loc_0x0192B6 ; 1928c
	LD B,[1AE1h] ; 1928e
	LD HL,#13F4h ; 19292
	CARS loc_0x0192B6 ; 19295
	LD B,[1AE3h] ; 19297
	LD HL,#140Ch ; 1929b
	CARS loc_0x0192B6 ; 1929e
	RET
; ---------------------- ; 192a0
	DB 0A7h, 92h, 0ACh, 92h, 0B1h, 92h, 0A2h, 0A3h ; 192a1
	DB 0A4h, 00h, 00h, 0A5h, 0A6h, 0A7h, 00h, 00h ; 192a9
	DB 0A8h, 0A9h, 0AAh, 0ABh, 0ACh
; ---------------------- ; 192b1
loc_0x0192B6:
	CP B,#40h ; 192b6
	JRS C,loc_0x0192BD ; 192b9
	LD B,#40h ; 192bb
loc_0x0192BD:
	PUSH B ; 192bd
	SRL B ; 192bf
	SRL B ; 192c1
	SRL B ; 192c3
	CP B,#00h ; 192c5
	JRS Z,loc_0x0192CF ; 192c8
loc_0x0192CA:
	LD [HL],#0Ch ; 192ca
	INC HL ; 192cc
	DJR NZ,loc_0x0192CA ; 192cd
loc_0x0192CF:
	POP A ; 192cf
	AND A,#07h ; 192d1
	OR A,A ; 192d3
	JRS Z,loc_0x0192DA ; 192d4
	ADD A,#04h ; 192d6
	LD [HL],A ; 192d8
	INC HL ; 192d9
loc_0x0192DA:
	RET
; ---------------------- ; 192da
	DB 0Dh, 04h, 3Eh, 00h, 9Ch, 05h, 00h, 9Ch ; 192db
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 192e3
	ASCIZ "m/" ; 192ea
	DB 9Bh, 93h, 03h, 0B5h, 86h, 03h, 0EAh, 9Eh ; 192ed
	DB 03h, 18h, 08h, 05h ; 192f5
	ASCIZ "B&" ; 192f9
	DB 98h, 7Ch, 03h, 0Ch, 08h
; ---------------------- ; 192fc
loc_0x019301:
	LD A,[1AE9h] ; 19301
	CP A,#07h ; 19305
	JRS C,loc_0x01930F ; 19307
	LD A,#07h ; 19309
	LD [1AE9h],A ; 1930b
loc_0x01930F:
	CARL loc_0x0021F4 ; 1930f
	CARL loc_0x002338 ; 19312
	LD NB,#02h ; 19315
	CARL loc_0x011ADC ; 19318
	LD NB,#00h ; 1931b
	CARL loc_0x002BF9 ; 1931e
	LD NB,#07h ; 19321
	CARL loc_0x0382F4 ; 19324
	LD IY,#92DBh ; 19327
	LD YP,#01h ; 1932a
	CARL loc_0x002D72 ; 1932d
	CARL loc_0x019411 ; 19330
	LD A,[1AD6h] ; 19333
	OR A,A ; 19337
	JRS Z,loc_0x019343 ; 19338
	LD HL,#166Bh ; 1933a
	OR [HL],#0F7h ; 1933d
	OR [HL],#02h ; 19340
loc_0x019343:
	LD HL,#1800h ; 19343
	LD IY,#23B5h ; 19346
	LD NB,#02h ; 19349
	CARL loc_0x011B84 ; 1934c
	LD HL,#1858h ; 1934f
	LD IY,#23A3h ; 19352
	LD NB,#02h ; 19355
	CARL loc_0x011B84 ; 19358
	LD HL,#1810h ; 1935b
	LD IY,#2470h ; 1935e
	LD NB,#02h ; 19361
	CARL loc_0x011B84 ; 19364
	LD HL,#1840h ; 19367
	LD IY,#24E5h ; 1936a
	LD NB,#02h ; 1936d
	CARL loc_0x011B84 ; 19370
	LD HL,#1828h ; 19373
	LD IY,#2526h ; 19376
	LD NB,#02h ; 19379
	CARL loc_0x011B84 ; 1937c
	LD HL,#0604h ; 1937f
	LD IY,#93F7h ; 19382
	LD NB,#07h ; 19385
	CARL loc_0x03836A ; 19388
	LD IY,#13AEh ; 1938b
	LD NB,#02h ; 1938e
	CARL loc_0x011B84 ; 19391
	CARL loc_0x00233F ; 19394
	CARL loc_0x0021FB ; 19397
	RET
; ---------------------- ; 1939a
loc_0x01939B:
	LD A,[1AD6h] ; 1939b
	OR A,A ; 1939f
	CARL Z,loc_0x0189F1 ; 193a0
	CARL loc_0x002346 ; 193a3
	LD A,[1643h] ; 193a6
	BIT A,#01h ; 193aa
	JRS NZ,loc_0x0193D9 ; 193ac
	BIT A,#02h ; 193ae
	JRS Z,loc_0x019410 ; 193b0
	LD A,[1AB6h] ; 193b2
	AND A,A ; 193b6
	JRS Z,loc_0x0193BF ; 193b7
	LD A,#02h ; 193b9
	LD [14FAh],A ; 193bb
loc_0x0193BF:
	CARL loc_0x0022EE ; 193bf
	LD A,[1AD6h] ; 193c2
	OR A,A ; 193c6
	JRS Z,loc_0x01940D ; 193c7
	LD HL,#0A42Ch ; 193c9
	LD B,#03h ; 193cc
	CP A,#0FFh ; 193ce
	JRS Z,loc_0x01940D ; 193d0
	LD HL,#0A51Ch ; 193d2
	LD B,#03h ; 193d5
	JRS loc_0x01940D
; ---------------------- ; 193d7
loc_0x0193D9:
	LD A,[1AD6h] ; 193d9
	OR A,A ; 193dd
	JRS NZ,loc_0x0193EE ; 193de
	LD A,[1AE9h] ; 193e0
	CARL loc_0x0023D8 ; 193e4
	LD B,[1AEAh] ; 193e7
	AND A,B ; 193eb
	JRS NZ,loc_0x0193FD ; 193ec
loc_0x0193EE:
	LD A,[1AB6h] ; 193ee
	AND A,A ; 193f2
	JRS Z,loc_0x0193FB ; 193f3
	LD A,#03h ; 193f5
	LD [14FAh],A ; 193f7
loc_0x0193FB:
	JRS loc_0x019410
; ---------------------- ; 193fb
loc_0x0193FD:
	LD A,[1AB6h] ; 193fd
	AND A,A ; 19401
	JRS Z,loc_0x01940A ; 19402
	LD A,#01h ; 19404
	LD [14FAh],A ; 19406
loc_0x01940A:
	CARL loc_0x0022D4 ; 1940a
loc_0x01940D:
	CARL loc_0x00228F ; 1940d
loc_0x019410:
	RET
; ---------------------- ; 19410
loc_0x019411:
	LD A,[1AD7h] ; 19411
	ADD A,A ; 19415
	ADD A,A ; 19416
	ADD A,#14h ; 19417
	LD HL,#137Ah ; 19419
	LD B,#04h ; 1941c
loc_0x01941E:
	LD [HL],A ; 1941e
	INC HL ; 1941f
	INC A ; 19420
	DJR NZ,loc_0x01941E ; 19421
	RET
; ---------------------- ; 19423
	DB 0Dh, 04h, 3Eh, 00h, 9Ch, 05h, 00h, 9Ch ; 19424
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h, 0CAh ; 1942c
	DB 2Fh, 00h, 40h, 95h, 03h ; 19434
	ASCII "M" ; 19439
	DB 91h, 03h, 00h, 00h, 00h, 18h, 08h, 06h ; 1943a
	ASCIZ "B&" ; 19442
	DB 0F8h, 7Ch, 03h, 0Ch, 08h
; ---------------------- ; 19445
loc_0x01944A:
	CARL loc_0x0021F4 ; 1944a
	CARL loc_0x002338 ; 1944d
	LD NB,#02h ; 19450
	CARL loc_0x011ADC ; 19453
	LD NB,#00h ; 19456
	CARL loc_0x002BF9 ; 19459
	LD NB,#07h ; 1945c
	CARL loc_0x0382F4 ; 1945f
	LD IY,#9424h ; 19462
	JRS loc_0x0194A8
; ---------------------- ; 19465
	DB 07h, 04h, 3Eh, 00h, 9Ch, 05h, 00h, 9Ch ; 19467
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h, 0CAh ; 1946f
	DB 2Fh, 00h ; 19477
	ASCII "G" ; 19479
	DB 95h, 03h, 15h, 9Eh, 03h, 00h, 00h, 00h ; 1947a
	DB 18h, 08h, 06h ; 19482
	ASCIZ "B&" ; 19485
	DB 0F8h, 7Ch, 03h, 0Ch, 08h
; ---------------------- ; 19488
loc_0x01948D:
	CARL loc_0x0021F4 ; 1948d
	CARL loc_0x002338 ; 19490
	LD NB,#02h ; 19493
	CARL loc_0x011ADC ; 19496
	LD NB,#00h ; 19499
	CARL loc_0x002BF9 ; 1949c
	LD NB,#07h ; 1949f
	CARL loc_0x0382F4 ; 194a2
	LD IY,#9467h ; 194a5
loc_0x0194A8:
	LD YP,#01h ; 194a8
	CARL loc_0x002D72 ; 194ab
	XOR A,A ; 194ae
	LD [1B2Ch],A ; 194af
	LD A,[1AD7h] ; 194b3
	LD [1B97h],A ; 194b7
	LD HL,#1800h ; 194bb
	LD IY,#23B5h ; 194be
	LD NB,#02h ; 194c1
	CARL loc_0x011B84 ; 194c4
	LD HL,#1858h ; 194c7
	LD IY,#23A3h ; 194ca
	LD NB,#02h ; 194cd
	CARL loc_0x011B84 ; 194d0
	LD HL,#1810h ; 194d3
	LD IY,#0CD85h ; 194d6
	LD YP,#00h ; 194d9
	LD NB,#02h ; 194dc
	CARL loc_0x011EB1 ; 194df
	LD HL,#1840h ; 194e2
	LD IY,#0CD66h ; 194e5
	LD YP,#00h ; 194e8
	LD NB,#02h ; 194eb
	CARL loc_0x011EB1 ; 194ee
	LD HL,#1828h ; 194f1
	LD IY,#0CD48h ; 194f4
	LD YP,#00h ; 194f7
	LD NB,#02h ; 194fa
	CARL loc_0x011EB1 ; 194fd
	LD HL,#0000h ; 19500
	LD IY,#2391h ; 19503
	LD NB,#02h ; 19506
	CARL loc_0x011B84 ; 19509
	LD HL,#0000h ; 1950c
	LD IY,#238Bh ; 1950f
	LD NB,#02h ; 19512
	CARL loc_0x011B84 ; 19515
	LD HL,#0604h ; 19518
	LD IY,#943Eh ; 1951b
	LD NB,#07h ; 1951e
	CARL loc_0x03836A ; 19521
	LD HL,#0102h ; 19524
	LD IY,#9489h ; 19527
	LD NB,#07h ; 1952a
	CARL loc_0x03836A ; 1952d
	LD IY,#13AEh ; 19530
	LD NB,#02h ; 19533
	CARL loc_0x011B84 ; 19536
	CARL loc_0x00233F ; 19539
	CARL loc_0x0021FB ; 1953c
	RET
; ---------------------- ; 1953f
loc_0x019540:
	CARL loc_0x0189F1 ; 19540
	CARL loc_0x002346 ; 19543
	RET
; ---------------------- ; 19546
loc_0x019547:
	CARL loc_0x002346 ; 19547
	LD HL,#1B97h ; 1954a
	LD A,[1645h] ; 1954d
	BIT A,#08h ; 19551
	JRS NZ,loc_0x019563 ; 19553
	BIT A,#10h ; 19555
	JRS Z,loc_0x019578 ; 19557
	DEC [HL] ; 19559
	LD A,[HL] ; 1955a
	CP A,#0FFh ; 1955b
	JRS NZ,loc_0x01956B ; 1955d
	LD [HL],#02h ; 1955f
	JRS loc_0x01956B
; ---------------------- ; 19561
loc_0x019563:
	INC [HL] ; 19563
	LD A,[HL] ; 19564
	CP A,#03h ; 19565
	JRS C,loc_0x01956B ; 19567
	LD [HL],#00h ; 19569
loc_0x01956B:
	LD A,[1AB6h] ; 1956b
	AND A,A ; 1956f
	JRS Z,loc_0x019578 ; 19570
	LD A,#04h ; 19572
	LD [14FAh],A ; 19574
loc_0x019578:
	RET
; ---------------------- ; 19578
	DB 0Dh, 04h, 3Eh, 00h, 0A4h, 05h, 00h, 0A4h ; 19579
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 19581
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
	DB 8Dh, 0F2h, 09h, 8Ch, 0F8h
; ---------------------- ; 195ef
loc_0x0195F4:
	CARL loc_0x0189F1 ; 195f4
	CARL loc_0x002346 ; 195f7
	LD A,[1643h] ; 195fa
	BIT A,#01h ; 195fe
	JRS NZ,loc_0x019618 ; 19600
	BIT A,#02h ; 19602
	JRS Z,loc_0x019634 ; 19604
	LD A,[1AB6h] ; 19606
	AND A,A ; 1960a
	JRS Z,loc_0x019613 ; 1960b
	LD A,#02h ; 1960d
	LD [14FAh],A ; 1960f
loc_0x019613:
	CARL loc_0x0022EE ; 19613
	JRS loc_0x019631
; ---------------------- ; 19616
loc_0x019618:
	LD A,[1AB6h] ; 19618
	AND A,A ; 1961c
	JRS Z,loc_0x019625 ; 1961d
	LD A,#01h ; 1961f
	LD [14FAh],A ; 19621
loc_0x019625:
	LD A,#04h ; 19625
	LD [1B15h],A ; 19627
	CARL loc_0x018DD1 ; 1962b
	CARL loc_0x0022D4 ; 1962e
loc_0x019631:
	CARL loc_0x00228F ; 19631
loc_0x019634:
	RET
; ---------------------- ; 19634
loc_0x019635:
	LD IY,#1ACBh ; 19635
	LD YP,#00h ; 19638
	LD HL,#1379h ; 1963b
loc_0x01963E:
	LD A,[IY] ; 1963e
	CP A,#0FFh ; 1963f
	JRS Z,loc_0x01964C ; 19641
	CARL loc_0x01964D ; 19643
	INC IY ; 19646
	ADD HL,#000Fh ; 19647
	JRS loc_0x01963E
; ---------------------- ; 1964a
loc_0x01964C:
	RET
; ---------------------- ; 1964c
loc_0x01964D:
	PUSH HL ; 1964d
loc_0x01964E:
	CP A,#1Eh ; 1964e
	JRS C,loc_0x019656 ; 19650
	SUB A,#1Eh ; 19652
	JRS loc_0x01964E
; ---------------------- ; 19654
loc_0x019656:
	LD L,A ; 19656
	LD H,#00h ; 19657
	LD A,#06h ; 19659
	DIV ; 1965b
	LD [1B72h],L ; 1965d
	LD [1B73h],H ; 19661
	LD A,L ; 19665
	POP HL ; 19666
	LD [HL],#04h ; 19667
	INC HL ; 19669
	LD A,[1B72h] ; 1966a
	LD B,A ; 1966e
	ADD A,A ; 1966f
	ADD A,B ; 19670
	ADD A,#10h ; 19671
	LD B,#03h ; 19673
loc_0x019675:
	LD [HL],A ; 19675
	INC HL ; 19676
	INC A ; 19677
	DJR NZ,loc_0x019675 ; 19678
	LD [HL],#06h ; 1967a
	INC HL ; 1967c
	LD A,#0Dh ; 1967d
	LD B,#02h ; 1967f
loc_0x019681:
	LD [HL],A ; 19681
	INC HL ; 19682
	INC A ; 19683
	DJR NZ,loc_0x019681 ; 19684
	LD [HL],#00h ; 19686
	INC HL ; 19688
	LD [HL],#05h ; 19689
	INC HL ; 1968b
	LD A,[1B73h] ; 1968c
	ADD A,#20h ; 19690
	LD [HL],A ; 19692
	RET
; ---------------------- ; 19693
	DB 0Dh, 04h, 3Eh, 00h, 9Ch, 05h, 00h, 9Ch ; 19694
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 1969c
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
	DB 0AAh, 0B1h, 03h, 0F2h, 0A1h, 8Bh, 0F8h
; ---------------------- ; 196d6
loc_0x0196DD:
	LD [1AE9h],A ; 196dd
	CARL loc_0x0023D8 ; 196e1
	LD HL,#1AEAh ; 196e4
	OR [HL],A ; 196e7
	CARL loc_0x0021F4 ; 196e9
	CARL loc_0x002338 ; 196ec
	LD NB,#02h ; 196ef
	CARL loc_0x011ADC ; 196f2
	LD NB,#00h ; 196f5
	CARL loc_0x002BF9 ; 196f8
	LD NB,#07h ; 196fb
	CARL loc_0x0382F4 ; 196fe
	LD IY,#9694h ; 19701
	LD YP,#01h ; 19704
	CARL loc_0x002D72 ; 19707
	LD HL,#0828h ; 1970a
	LD IY,#2533h ; 1970d
	LD NB,#02h ; 19710
	CARL loc_0x011B84 ; 19713
	LD HL,#0404h ; 19716
	LD IY,#93F7h ; 19719
	LD NB,#07h ; 1971c
	CARL loc_0x03836A ; 1971f
	LD IY,#13AEh ; 19722
	LD NB,#02h ; 19725
	CARL loc_0x011B84 ; 19728
	CARL loc_0x00233F ; 1972b
	CARL loc_0x0021FB ; 1972e
	LD A,[1AB6h] ; 19731
	AND A,A ; 19735
	JRS Z,loc_0x01973E ; 19736
	LD A,#22h ; 19738
	LD [14FAh],A ; 1973a
loc_0x01973E:
	RET
; ---------------------- ; 1973e
loc_0x01973F:
	CARL loc_0x0189F1 ; 1973f
	CARL loc_0x002346 ; 19742
	LD A,[1643h] ; 19745
	BIT A,#01h ; 19749
	JRS NZ,loc_0x019760 ; 1974b
	BIT A,#02h ; 1974d
	JRS Z,loc_0x019795 ; 1974f
	LD A,[1AB6h] ; 19751
	AND A,A ; 19755
	JRS Z,loc_0x01975E ; 19756
	LD A,#02h ; 19758
	LD [14FAh],A ; 1975a
loc_0x01975E:
	JRS loc_0x01976D
; ---------------------- ; 1975e
loc_0x019760:
	LD A,[1AB6h] ; 19760
	AND A,A ; 19764
	JRS Z,loc_0x01976D ; 19765
	LD A,#01h ; 19767
	LD [14FAh],A ; 19769
loc_0x01976D:
	LD NB,#01h ; 1976d
	CARL loc_0x00AC56 ; 19770
	JRS NZ,loc_0x01978F ; 19773
	LD A,[1B69h] ; 19775
	CP A,#09h ; 19779
	JRS NZ,loc_0x019784 ; 1977b
	LD HL,#0AA43h ; 1977d
	LD B,#03h ; 19780
	JRS loc_0x019792
; ---------------------- ; 19782
loc_0x019784:
	CARL loc_0x0022EE ; 19784
	LD A,#0FFh ; 19787
	LD [1B69h],A ; 19789
	JRS loc_0x019792
; ---------------------- ; 1978d
loc_0x01978F:
	CARL loc_0x0022D4 ; 1978f
loc_0x019792:
	CARL loc_0x00228F ; 19792
loc_0x019795:
	RET
; ---------------------- ; 19795
	DB 07h, 04h, 3Eh, 00h ; 19796
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
	DB 03h, 0F2h, 2Eh, 8Bh, 0F2h, 0E7h, 89h, 0F8h
; ---------------------- ; 1980e
loc_0x019816:
	CARL loc_0x002346 ; 19816
	LD A,[1643h] ; 19819
	BIT A,#02h ; 1981d
	JRS NZ,loc_0x01987D ; 1981f
	BIT A,#01h ; 19821
	JRS Z,loc_0x019890 ; 19823
	LD A,[1AB6h] ; 19825
	AND A,A ; 19829
	JRS Z,loc_0x019832 ; 1982a
	LD A,#01h ; 1982c
	LD [14FAh],A ; 1982e
loc_0x019832:
	LD A,[1B6Eh] ; 19832
	OR A,A ; 19836
	JRS Z,loc_0x019867 ; 19837
	DEC A ; 19839
	JRS Z,loc_0x019852 ; 1983a
	LD HL,#0EB89h ; 1983c
	LD B,#03h ; 1983f
	LD A,[1B7Fh] ; 19841
	CP A,#05h ; 19845
	JRS C,loc_0x01984E ; 19847
	LD HL,#9BDEh ; 19849
	LD B,#03h ; 1984c
loc_0x01984E:
	CARL loc_0x00228F ; 1984e
	RET
; ---------------------- ; 19851
loc_0x019852:
	LD HL,#9CA6h ; 19852
	LD B,#03h ; 19855
	LD A,[1B7Fh] ; 19857
	OR A,A ; 1985b
	JRS NZ,loc_0x019863 ; 1985c
	LD HL,#9D52h ; 1985e
	LD B,#03h ; 19861
loc_0x019863:
	CARL loc_0x00228F ; 19863
	RET
; ---------------------- ; 19866
loc_0x019867:
	LD A,[1B7Fh] ; 19867
	CP A,#05h ; 1986b
	JRS C,loc_0x019876 ; 1986d
	LD HL,#9BEDh ; 1986f
	LD B,#03h ; 19872
	JRS loc_0x01988D
; ---------------------- ; 19874
loc_0x019876:
	LD HL,#98B7h ; 19876
	LD B,#03h ; 19879
	JRS loc_0x01988D
; ---------------------- ; 1987b
loc_0x01987D:
	LD A,[1AB6h] ; 1987d
	AND A,A ; 19881
	JRS Z,loc_0x01988A ; 19882
	LD A,#02h ; 19884
	LD [14FAh],A ; 19886
loc_0x01988A:
	CARL loc_0x0022EE ; 1988a
loc_0x01988D:
	CARL loc_0x00228F ; 1988d
loc_0x019890:
	RET
; ---------------------- ; 19890
	DB 07h, 04h, 3Eh, 00h ; 19891
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
	DB 0F2h, 5Ch, 8Ah, 0F8h
; ---------------------- ; 198e8
loc_0x0198EC:
	CARL loc_0x002346 ; 198ec
	LD HL,#9B00h ; 198ef
	LD B,#03h ; 198f2
	LD A,[1B71h] ; 198f4
	OR A,A ; 198f8
	JRS Z,loc_0x01990D ; 198f9
	LD IX,#80B8h ; 198fb
	LD XP,#03h ; 198fe
	CARL loc_0x002642 ; 19901
	LD HL,#9AA6h ; 19904
	LD B,#03h ; 19907
	CARL loc_0x00227C ; 19909
	RET
; ---------------------- ; 1990c
loc_0x01990D:
	CARL loc_0x00228F ; 1990d
	LD HL,#98E8h ; 19910
	LD B,#03h ; 19913
	CARL loc_0x00227C ; 19915
	RET
; ---------------------- ; 19918
	DB 0F2h, 2Bh, 8Ah, 0C5h ; 19919
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
	DB 02h
; ---------------------- ; 19944
loc_0x019945:
	AND [BR:23h],#00h ; 19945
loc_0x019948:
	AND [BR:24h],#03h ; 19948
	AND [BR:25h],#00h ; 1994b
	AND [BR:26h],#0BFh ; 1994e
	AND [BR:80h],#0F1h ; 19951
	OR [BR:29h],#82h ; 19954
	OR [BR:25h],#82h ; 19957
	OR [BR:21h],#04h ; 1995a
	LD [BR:27h],#08h ; 1995d
	OR [BR:20h],#08h ; 19960
	OR [BR:23h],#08h ; 19963
	OR [BR:30h],#04h ; 19966
	PUSH ALE ; 19969
	CARL loc_0x01EEA7 ; 1996b
	CARL loc_0x01EED4 ; 1996e
	LD EP,#00h ; 19971
	LD [1B6Fh],HL ; 19974
	LD [1B71h],A ; 19977
	POP ALE ; 1997b
	AND [BR:25h],#7Dh ; 1997d
	AND [BR:21h],#0F3h ; 19980
	CARL loc_0x0021FB ; 19983
	LD A,[1B71h] ; 19986
	CARL loc_0x019A08 ; 1998a
	LD A,[1B71h] ; 1998d
	CP A,#00h ; 19991
	JRS Z,loc_0x0199CC ; 19993
	CP A,#0FFh ; 19995
	JRS Z,loc_0x0199E4 ; 19997
	XOR A,A ; 19999
	LD [1671h],A ; 1999a
loc_0x01999E:
	CARL loc_0x002346 ; 1999e
	LD A,[1642h] ; 199a1
	BIT A,#02h ; 199a5
	JRS NZ,loc_0x0199DB ; 199a7
	LD A,[1671h] ; 199a9
	CP A,#0Bh ; 199ad
	JRS C,loc_0x01999E ; 199af
	LD HL,#13FBh ; 199b1
	LD B,#07h ; 199b4
	XOR A,A ; 199b6
loc_0x0199B7:
	LD [HL],A ; 199b7
	DEC HL ; 199b8
	DJR NZ,loc_0x0199B7 ; 199b9
	LD A,[1BCAh] ; 199bb
	CP A,#0FFh ; 199bf
	JRS Z,loc_0x0199DB ; 199c1
	CARL loc_0x002346 ; 199c3
	CARL loc_0x0021F4 ; 199c6
	JRL loc_0x019945
; ---------------------- ; 199c9
loc_0x0199CC:
	LD A,[1AB6h] ; 199cc
	AND A,A ; 199d0
	JRS Z,loc_0x0199D9 ; 199d1
	LD A,#01h ; 199d3
	LD [14FAh],A ; 199d5
loc_0x0199D9:
	JRS loc_0x0199F9
; ---------------------- ; 199d9
loc_0x0199DB:
	LD A,#0FEh ; 199db
	LD [1B71h],A ; 199dd
	CARL loc_0x019A08 ; 199e1
loc_0x0199E4:
	BIT [BR:52h],#80h ; 199e4
	CARL Z,loc_0x002987 ; 199e7
	JRS loc_0x0199CC
; ---------------------- ; 199ea
loc_0x0199EC:
	LD A,[1AB6h] ; 199ec
	AND A,A ; 199f0
	JRS Z,loc_0x0199F9 ; 199f1
	LD A,#02h ; 199f3
	LD [14FAh],A ; 199f5
loc_0x0199F9:
	AND [BR:23h],#0FBh ; 199f9
	AND [BR:20h],#0F3h ; 199fc
	LD HL,#98ECh ; 199ff
	LD B,#03h ; 19a02
	CARL loc_0x00227C ; 19a04
	RET
; ---------------------- ; 19a07
loc_0x019A08:
	RET
; ---------------------- ; 19a08
loc_0x019A09:
	PUSH A ; 19a09
	LD HL,#13FBh ; 19a0b
	AND A,#0Fh ; 19a0e
	ADD A,#90h ; 19a10
	LD [HL],A ; 19a12
	POP A ; 19a13
	DEC HL ; 19a15
	SWAP A ; 19a16
	AND A,#0Fh ; 19a17
	ADD A,#90h ; 19a19
	LD [HL],A ; 19a1b
	DEC HL ; 19a1c
	DEC HL ; 19a1d
	LD A,[1B6Fh] ; 19a1e
	AND A,#0Fh ; 19a22
	ADD A,#90h ; 19a24
	LD [HL],A ; 19a26
	DEC HL ; 19a27
	LD A,[1B6Fh] ; 19a28
	SWAP A ; 19a2c
	AND A,#0Fh ; 19a2d
	ADD A,#90h ; 19a2f
	LD [HL],A ; 19a31
	DEC HL ; 19a32
	LD A,[1B70h] ; 19a33
	AND A,#0Fh ; 19a37
	ADD A,#90h ; 19a39
	LD [HL],A ; 19a3b
	DEC HL ; 19a3c
	LD A,[1B70h] ; 19a3d
	SWAP A ; 19a41
	AND A,#0Fh ; 19a42
	ADD A,#90h ; 19a44
	LD [HL],A ; 19a46
	RET
; ---------------------- ; 19a47
	DB 0B0h, 0FFh, 0CEh, 0D4h, 0CAh, 1Bh, 0F8h, 07h ; 19a48
	DB 04h, 3Eh, 00h ; 19a50
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
	DB 87h, 0F8h
; ---------------------- ; 19aa4
loc_0x019AA6:
	CARL loc_0x002346 ; 19aa6
	LD A,[1643h] ; 19aa9
	BIT A,#01h ; 19aad
	JRS NZ,loc_0x019AC4 ; 19aaf
	BIT A,#02h ; 19ab1
	JRS Z,loc_0x019AD9 ; 19ab3
	LD A,[1AB6h] ; 19ab5
	AND A,A ; 19ab9
	JRS Z,loc_0x019AC2 ; 19aba
	LD A,#02h ; 19abc
	LD [14FAh],A ; 19abe
loc_0x019AC2:
	JRS loc_0x019AD1
; ---------------------- ; 19ac2
loc_0x019AC4:
	LD A,[1AB6h] ; 19ac4
	AND A,A ; 19ac8
	JRS Z,loc_0x019AD1 ; 19ac9
	LD A,#01h ; 19acb
	LD [14FAh],A ; 19acd
loc_0x019AD1:
	LD HL,#97C1h ; 19ad1
	LD B,#03h ; 19ad4
	CARL loc_0x00228F ; 19ad6
loc_0x019AD9:
	RET
; ---------------------- ; 19ad9
	DB 07h, 04h, 3Eh, 00h, 0A4h, 05h, 00h, 0A4h ; 19ada
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 19ae2
	ASCIZ "m/" ; 19ae9
	ASCII "L" ; 19aec
	DB 9Bh, 03h, 00h, 00h, 00h, 0C1h, 97h, 03h ; 19aed
	DB 18h, 08h, 07h ; 19af5
	ASCIZ "B&" ; 19af8
	DB 18h, 81h, 03h, 0Ch, 08h
; ---------------------- ; 19afb
loc_0x019B00:
	LD A,[1B6Fh] ; 19b00
	LD B,[1B70h] ; 19b04
	ADD A,B ; 19b08
loc_0x019B09:
	CP A,#1Eh ; 19b09
	JRS C,loc_0x019B11 ; 19b0b
	SUB A,#1Eh ; 19b0d
	JRS loc_0x019B09
; ---------------------- ; 19b0f
loc_0x019B11:
	LD [1BC9h],A ; 19b11
	CARL loc_0x019BA0 ; 19b15
	CARL loc_0x0021F4 ; 19b18
	CARL loc_0x002338 ; 19b1b
	LD NB,#02h ; 19b1e
	CARL loc_0x011ADC ; 19b21
	LD NB,#00h ; 19b24
	CARL loc_0x002BF9 ; 19b27
	LD NB,#07h ; 19b2a
	CARL loc_0x0382F4 ; 19b2d
	LD IY,#9ADAh ; 19b30
	LD YP,#01h ; 19b33
	CARL loc_0x002D72 ; 19b36
	CARL loc_0x019B7E ; 19b39
	LD IY,#13AEh ; 19b3c
	LD NB,#02h ; 19b3f
	CARL loc_0x011B84 ; 19b42
	CARL loc_0x00233F ; 19b45
	CARL loc_0x0021FB ; 19b48
	RET
; ---------------------- ; 19b4b
loc_0x019B4C:
	CARL loc_0x002346 ; 19b4c
	LD A,[1643h] ; 19b4f
	BIT A,#01h ; 19b53
	JRS NZ,loc_0x019B6A ; 19b55
	BIT A,#02h ; 19b57
	JRS Z,loc_0x019B7D ; 19b59
	LD A,[1AB6h] ; 19b5b
	AND A,A ; 19b5f
	JRS Z,loc_0x019B68 ; 19b60
	LD A,#02h ; 19b62
	LD [14FAh],A ; 19b64
loc_0x019B68:
	JRS loc_0x019B77
; ---------------------- ; 19b68
loc_0x019B6A:
	LD A,[1AB6h] ; 19b6a
	AND A,A ; 19b6e
	JRS Z,loc_0x019B77 ; 19b6f
	LD A,#01h ; 19b71
	LD [14FAh],A ; 19b73
loc_0x019B77:
	CARL loc_0x0022D4 ; 19b77
	CARL loc_0x00228F ; 19b7a
loc_0x019B7D:
	RET
; ---------------------- ; 19b7d
loc_0x019B7E:
	LD A,[1BC9h] ; 19b7e
	LD HL,#13C1h ; 19b82
	CARL loc_0x01964D ; 19b85
	RET
; ---------------------- ; 19b88
loc_0x019B89:
	LD A,[1B80h] ; 19b89
	LD B,#00h ; 19b8d
	LD HL,#1ACBh ; 19b8f
	ADD HL,BA ; 19b92
loc_0x019B94:
	LD A,[HL] ; 19b94
	DEC HL ; 19b95
	LD [HL],A ; 19b96
	INC HL ; 19b97
	CP A,#0FFh ; 19b98
	JRS Z,loc_0x019B9F ; 19b9a
	INC HL ; 19b9c
	JRS loc_0x019B94
; ---------------------- ; 19b9d
loc_0x019B9F:
	RET
; ---------------------- ; 19b9f
loc_0x019BA0:
	LD A,[1B80h] ; 19ba0
	OR A,A ; 19ba4
	CARS NZ,loc_0x019B89 ; 19ba5
	LD HL,#1ACBh ; 19ba7
loc_0x019BAA:
	CP [HL],#0FFh ; 19baa
	JRS Z,loc_0x019BB2 ; 19bad
	INC HL ; 19baf
	JRS loc_0x019BAA
; ---------------------- ; 19bb0
loc_0x019BB2:
	LD A,[1BC9h] ; 19bb2
	LD [HL],A ; 19bb6
	RET
; ---------------------- ; 19bb7
	DB 07h, 04h, 3Eh, 00h, 0A4h, 05h, 00h, 0A4h ; 19bb8
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 19bc0
	ASCIZ "m/" ; 19bc7
	ASCII "U" ; 19bca
	DB 9Ch, 03h, 0C1h, 97h, 03h, 0B7h, 98h, 03h ; 19bcb
	DB 18h, 08h, 07h ; 19bd3
	ASCIZ "B&" ; 19bd6
	ASCII "X}" ; 19bd9
	DB 03h, 0Ch, 08h, 0F2h, 11h, 00h, 0C5h, 89h ; 19bdb
	DB 0EBh, 0B1h, 03h, 0CEh, 0C4h, 00h, 0F2h, 0DCh ; 19be3
	DB 86h, 0F8h, 0F2h, 02h, 00h, 0F8h
; ---------------------- ; 19beb
loc_0x019BF1:
	XOR A,A ; 19bf1
	LD [1B80h],A ; 19bf2
	LD HL,#1ACBh ; 19bf6
loc_0x019BF9:
	CP [HL],#0FFh ; 19bf9
	JRS Z,loc_0x019C02 ; 19bfc
	INC HL ; 19bfe
	INC A ; 19bff
	JRS loc_0x019BF9
; ---------------------- ; 19c00
loc_0x019C02:
	LD [1B7Fh],A ; 19c02
	CARL loc_0x0021F4 ; 19c06
	CARL loc_0x002338 ; 19c09
	LD NB,#02h ; 19c0c
	CARL loc_0x011ADC ; 19c0f
	LD NB,#00h ; 19c12
	CARL loc_0x002BF9 ; 19c15
	LD NB,#07h ; 19c18
	CARL loc_0x0382F4 ; 19c1b
	LD IY,#9BB8h ; 19c1e
	LD YP,#01h ; 19c21
	CARL loc_0x002D72 ; 19c24
	CARL loc_0x019635 ; 19c27
	CARL loc_0x019C59 ; 19c2a
	LD HL,#0000h ; 19c2d
	LD IY,#261Fh ; 19c30
	LD NB,#02h ; 19c33
	CARL loc_0x011B84 ; 19c36
	LD HL,#0600h ; 19c39
	LD IY,#94F2h ; 19c3c
	LD NB,#07h ; 19c3f
	CARL loc_0x03836A ; 19c42
	LD IY,#13AEh ; 19c45
	LD NB,#02h ; 19c48
	CARL loc_0x011B84 ; 19c4b
	CARL loc_0x00233F ; 19c4e
	CARL loc_0x0021FB ; 19c51
	RET
; ---------------------- ; 19c54
	DB 0F2h, 0EFh, 86h, 0F8h
; ---------------------- ; 19c55
loc_0x019C59:
	LD HL,#1361h ; 19c59
	LD B,#0Ah ; 19c5c
loc_0x019C5E:
	LD [HL],#00h ; 19c5e
	INC HL ; 19c60
	DJR NZ,loc_0x019C5E ; 19c61
	LD HL,#13F0h ; 19c63
	LD IY,#7DB8h ; 19c66
	LD YP,#03h ; 19c69
	LD B,#02h ; 19c6c
loc_0x019C6E:
	PUSH B ; 19c6e
	LD B,#0Ch ; 19c70
loc_0x019C72:
	LD A,[IY] ; 19c72
	LD [HL],A ; 19c73
	INC IY ; 19c74
	INC HL ; 19c75
	DJR NZ,loc_0x019C72 ; 19c76
	ADD HL,#000Ch ; 19c78
	POP B ; 19c7b
	DJR NZ,loc_0x019C6E ; 19c7d
	RET
; ---------------------- ; 19c7f
	DB 07h, 04h, 3Eh, 00h, 0A4h, 05h, 00h, 0A4h ; 19c80
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 19c88
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
	DB 85h
; ---------------------- ; 19cc0
loc_0x019CC1:
	CARL loc_0x002338 ; 19cc1
	LD NB,#02h ; 19cc4
	CARL loc_0x011ADC ; 19cc7
	LD NB,#00h ; 19cca
	CARL loc_0x002BF9 ; 19ccd
	LD NB,#07h ; 19cd0
	CARL loc_0x0382F4 ; 19cd3
	LD IY,#9C80h ; 19cd6
	LD YP,#01h ; 19cd9
	CARL loc_0x002D72 ; 19cdc
	CARL loc_0x019635 ; 19cdf
	CARL loc_0x019D05 ; 19ce2
	LD HL,#0000h ; 19ce5
	LD IY,#2625h ; 19ce8
	LD NB,#02h ; 19ceb
	CARL loc_0x011B84 ; 19cee
	LD IY,#13AEh ; 19cf1
	LD NB,#02h ; 19cf4
	CARL loc_0x011B84 ; 19cf7
	CARL loc_0x00233F ; 19cfa
	CARL loc_0x0021FB ; 19cfd
	RET
; ---------------------- ; 19d00
	DB 0F2h ; 19d01
	ASCII "C" ; 19d02
	DB 86h, 0F8h
; ---------------------- ; 19d03
loc_0x019D05:
	LD HL,#1361h ; 19d05
	LD B,#0Ah ; 19d08
loc_0x019D0A:
	LD [HL],#00h ; 19d0a
	INC HL ; 19d0c
	DJR NZ,loc_0x019D0A ; 19d0d
	LD HL,#13F0h ; 19d0f
	LD IY,#7E00h ; 19d12
	LD YP,#03h ; 19d15
	LD B,#02h ; 19d18
loc_0x019D1A:
	PUSH B ; 19d1a
	LD B,#0Ch ; 19d1c
loc_0x019D1E:
	LD A,[IY] ; 19d1e
	LD [HL],A ; 19d1f
	INC IY ; 19d20
	INC HL ; 19d21
	DJR NZ,loc_0x019D1E ; 19d22
	ADD HL,#000Ch ; 19d24
	POP B ; 19d27
	DJR NZ,loc_0x019D1A ; 19d29
	RET
; ---------------------- ; 19d2b
	DB 07h, 04h, 3Eh, 00h, 0A4h, 05h, 00h, 0A4h ; 19d2c
	DB 05h, 00h, 80h, 05h, 00h, 80h, 05h ; 19d34
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
	DB 84h, 0F8h
; ---------------------- ; 19d84
loc_0x019D86:
	CARL loc_0x002346 ; 19d86
	LD A,[1643h] ; 19d89
	BIT A,#01h ; 19d8d
	JRS NZ,loc_0x019DA9 ; 19d8f
	BIT A,#02h ; 19d91
	JRS Z,loc_0x019DBC ; 19d93
	LD A,[1AB6h] ; 19d95
	AND A,A ; 19d99
	JRS Z,loc_0x019DA2 ; 19d9a
	LD A,#02h ; 19d9c
	LD [14FAh],A ; 19d9e
loc_0x019DA2:
	CARL loc_0x0022EE ; 19da2
	JRS loc_0x019DB9
; ---------------------- ; 19da5
	DB 0F1h, 14h
; ---------------------- ; 19da7
loc_0x019DA9:
	LD A,[1AB6h] ; 19da9
	AND A,A ; 19dad
	JRS Z,loc_0x019DB6 ; 19dae
	LD A,#02h ; 19db0
	LD [14FAh],A ; 19db2
loc_0x019DB6:
	CARL loc_0x0022EE ; 19db6
loc_0x019DB9:
	CARL loc_0x00228F ; 19db9
loc_0x019DBC:
	RET
; ---------------------- ; 19dbc
	DB 0C5h ; 19dbd
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
	DB 0F8h
; ---------------------- ; 19e5d
loc_0x019E5E:
	CARL loc_0x002346 ; 19e5e
	LD A,[1643h] ; 19e61
	BIT A,#04h ; 19e65
	JRS Z,loc_0x019E78 ; 19e67
	LD A,[1ACAh] ; 19e69
	SUB A,#01h ; 19e6d
	JRS NC,loc_0x019E73 ; 19e6f
	LD A,#02h ; 19e71
loc_0x019E73:
	LD [1ACAh],A ; 19e73
	RET
; ---------------------- ; 19e77
loc_0x019E78:
	BIT A,#01h ; 19e78
	JRS Z,loc_0x019EC3 ; 19e7a
	LD A,[1AC9h] ; 19e7c
	CP A,#00h ; 19e80
	JRS Z,loc_0x019E98 ; 19e82
	DEC A ; 19e84
	JRS Z,loc_0x019EA9 ; 19e85
	DEC A ; 19e87
	JRS Z,loc_0x019E91 ; 19e88
	LD HL,#0A600h ; 19e8a
	LD B,#03h ; 19e8d
	JRS loc_0x019EB3
; ---------------------- ; 19e8f
loc_0x019E91:
	LD HL,#948Dh ; 19e91
	LD B,#03h ; 19e94
	JRS loc_0x019EB3
; ---------------------- ; 19e96
loc_0x019E98:
	CARL loc_0x0022D4 ; 19e98
	LD A,[1AD6h] ; 19e9b
	OR A,A ; 19e9f
	JRS NZ,loc_0x019EB3 ; 19ea0
	LD HL,#8639h ; 19ea2
	LD B,#03h ; 19ea5
	JRS loc_0x019EB3
; ---------------------- ; 19ea7
loc_0x019EA9:
	XOR A,A ; 19ea9
	LD [1B36h],A ; 19eaa
	LD HL,#80EFh ; 19eae
	LD B,#03h ; 19eb1
loc_0x019EB3:
	CARL loc_0x00228F ; 19eb3
	LD A,[1AB6h] ; 19eb6
	AND A,A ; 19eba
	JRS Z,loc_0x019EC3 ; 19ebb
	LD A,#01h ; 19ebd
	LD [14FAh],A ; 19ebf
loc_0x019EC3:
	RET
; ---------------------- ; 19ec3
	DB 0Dh, 04h, 3Eh, 00h ; 19ec4
	ASCII "P" ; 19ec8
	DB 03h, 00h ; 19ec9
	ASCII "W" ; 19ecb
	DB 03h, 00h, 00h, 07h, 00h, 00h, 07h, 0CAh ; 19ecc
	DB 2Fh, 00h, 0B9h, 9Fh, 03h, 0B5h, 86h, 03h ; 19ed4
	DB 00h, 00h, 00h, 18h, 08h, 01h ; 19edc
	ASCIZ "B&" ; 19ee2
	DB 0E0h ; 19ee5
	ASCII "y" ; 19ee6
	DB 03h
; ---------------------- ; 19ee7
loc_0x019EE8:
	ADC A,[BR:08h] ; 19ee8
	XOR A,A ; 19eea
	LD [1B3Fh],A ; 19eeb
	LD [1B40h],A ; 19eef
	LD [1AE8h],A ; 19ef3
	CARL loc_0x0021F4 ; 19ef7
	CARL loc_0x002338 ; 19efa
	LD NB,#02h ; 19efd
	CARL loc_0x011ADC ; 19f00
	LD NB,#00h ; 19f03
	CARL loc_0x002BF9 ; 19f06
	LD NB,#07h ; 19f09
	CARL loc_0x0382F4 ; 19f0c
	LD IY,#9EC4h ; 19f0f
	LD YP,#01h ; 19f12
	CARL loc_0x002D72 ; 19f15
	LD A,[1AE9h] ; 19f18
	LD NB,#02h ; 19f1c
	CARL loc_0x012476 ; 19f1f
	CP A,#05h ; 19f22
	JRS NZ,loc_0x019F2E ; 19f24
	LD HL,#3027h ; 19f26
	LD B,#00h ; 19f29
	CARL loc_0x002243 ; 19f2b
loc_0x019F2E:
	LD A,[1AD7h] ; 19f2e
	LD B,A ; 19f32
	ADD A,A ; 19f33
	ADD A,B ; 19f34
	LD B,#00h ; 19f35
	LD IY,#9FA9h ; 19f37
	LD YP,#01h ; 19f3a
	ADD IY,BA ; 19f3d
	LD BA,[IY] ; 19f3f
	LD [1634h],BA ; 19f41
	LD [1637h],BA ; 19f44
	LD A,[IY+02h] ; 19f47
	LD [1636h],A ; 19f4a
	LD [1639h],A ; 19f4e
	CARL loc_0x01A013 ; 19f52
	LD HL,#2D4Bh ; 19f55
	LD IY,#2775h ; 19f58
	LD NB,#02h ; 19f5b
	CARL loc_0x011B84 ; 19f5e
	LD HL,#0001h ; 19f61
	LD IY,#8D92h ; 19f64
	LD NB,#07h ; 19f67
	CARL loc_0x03836A ; 19f6a
	LD HL,#0100h ; 19f6d
	LD IY,#8E3Dh ; 19f70
	LD NB,#07h ; 19f73
	CARL loc_0x03836A ; 19f76
	LD HL,#0305h ; 19f79
	LD IY,#8DF4h ; 19f7c
	LD NB,#07h ; 19f7f
	CARL loc_0x03836A ; 19f82
	LD IY,#13AEh ; 19f85
	LD NB,#02h ; 19f88
	CARL loc_0x011B84 ; 19f8b
	CARL loc_0x00233F ; 19f8e
	CARL loc_0x0021FB ; 19f91
	LD A,[1AE9h] ; 19f94
	LD NB,#02h ; 19f98
	CARL loc_0x012476 ; 19f9b
	CP A,#01h ; 19f9e
	JRS NZ,loc_0x019FA8 ; 19fa0
	LD A,#0Ah ; 19fa2
	LD [14F4h],A ; 19fa4
loc_0x019FA8:
	RET
; ---------------------- ; 19fa8
	DB 00h, 00h, 07h, 00h, 40h, 07h, 00h, 80h ; 19fa9
	DB 07h, 0F2h, 3Dh, 0EAh, 0F2h, 8Fh, 83h, 0F8h
; ---------------------- ; 19fb1
loc_0x019FB9:
	CARL loc_0x0189F1 ; 19fb9
	CARL loc_0x002346 ; 19fbc
	LD HL,[161Fh] ; 19fbf
	CP HL,#9FB9h ; 19fc2
	JRS NZ,loc_0x01A012 ; 19fc5
	LD HL,#1B3Fh ; 19fc7
	LD A,[HL] ; 19fca
	OR A,A ; 19fcb
	JRS Z,loc_0x019FD1 ; 19fcc
	DEC [HL] ; 19fce
	JRS NZ,loc_0x019FE3 ; 19fcf
loc_0x019FD1:
	LD NB,#01h ; 19fd1
	CARL loc_0x00AA46 ; 19fd4
	JRS NZ,loc_0x019FE3 ; 19fd7
	LD HL,#9FB2h ; 19fd9
	LD B,#03h ; 19fdc
	CARL loc_0x00227C ; 19fde
	JRS loc_0x019FEB
; ---------------------- ; 19fe1
loc_0x019FE3:
	LD A,[1643h] ; 19fe3
	BIT A,#02h ; 19fe7
	JRS Z,loc_0x01A012 ; 19fe9
loc_0x019FEB:
	LD A,[1AE9h] ; 19feb
	LD NB,#02h ; 19fef
	CARL loc_0x012476 ; 19ff2
	CP A,#06h ; 19ff5
	JRS NZ,loc_0x019FFF ; 19ff7
	LD A,#2Ch ; 19ff9
	LD [1B13h],A ; 19ffb
loc_0x019FFF:
	LD A,[1AB6h] ; 19fff
	AND A,A ; 1a003
	JRS Z,loc_0x01A00C ; 1a004
	LD A,#02h ; 1a006
	LD [14FAh],A ; 1a008
loc_0x01A00C:
	CARL loc_0x0022EE ; 1a00c
	CARL loc_0x00228F ; 1a00f
loc_0x01A012:
	RET
; ---------------------- ; 1a012
loc_0x01A013:
	LD A,[1AE9h] ; 1a013
	LD NB,#02h ; 1a017
	CARL loc_0x012476 ; 1a01a
	CP A,#06h ; 1a01d
	JRL Z,loc_0x01A0BB ; 1a01f
	CP A,#01h ; 1a022
	JRS Z,loc_0x01A075 ; 1a024
	CP A,#00h ; 1a026
	JRL Z,loc_0x01A0F2 ; 1a028
	CP A,#02h ; 1a02b
	JRL Z,loc_0x01A120 ; 1a02d
	CP A,#04h ; 1a030
	JRL Z,loc_0x01A14B ; 1a032
	CP A,#05h ; 1a035
	JRL Z,loc_0x01A19A ; 1a037
	CP A,#07h ; 1a03a
	JRL Z,loc_0x01A1D6 ; 1a03c
	CP A,#03h ; 1a03f
	JRL Z,loc_0x01A044 ; 1a041
loc_0x01A044:
	LD HL,#0000h ; 1a044
	LD [1B39h],HL ; 1a047
	LD HL,#0000h ; 1a04a
	LD IY,#0C445h ; 1a04d
	LD YP,#00h ; 1a050
	LD NB,#02h ; 1a053
	CARL loc_0x011EB1 ; 1a056
	LD HL,#1B50h ; 1a059
	LD IY,#6800h ; 1a05c
	LD NB,#02h ; 1a05f
	CARL loc_0x011B84 ; 1a062
	LD HL,#2C40h ; 1a065
	LD [1B12h],HL ; 1a068
	LD IY,#6D90h ; 1a06b
	LD NB,#02h ; 1a06e
	CARL loc_0x011B84 ; 1a071
	RET
; ---------------------- ; 1a074
loc_0x01A075:
	LD HL,#0000h ; 1a075
	LD IY,#0C445h ; 1a078
	LD YP,#00h ; 1a07b
	LD NB,#02h ; 1a07e
	CARL loc_0x011EB1 ; 1a081
	LD HL,#1040h ; 1a084
	LD [1B12h],HL ; 1a087
	LD IY,#4E53h ; 1a08a
	LD NB,#02h ; 1a08d
	CARL loc_0x011B84 ; 1a090
	LD HL,#2C28h ; 1a093
	LD [1B12h],HL ; 1a096
	LD IY,#4F6Fh ; 1a099
	LD NB,#02h ; 1a09c
	CARL loc_0x011B84 ; 1a09f
	LD HL,#1907h ; 1a0a2
	LD IY,#4F89h ; 1a0a5
	LD NB,#02h ; 1a0a8
	CARL loc_0x011B84 ; 1a0ab
	LD HL,#1907h ; 1a0ae
	LD IY,#4F95h ; 1a0b1
	LD NB,#02h ; 1a0b4
	CARL loc_0x011B84 ; 1a0b7
	RET
; ---------------------- ; 1a0ba
loc_0x01A0BB:
	LD HL,#0000h ; 1a0bb
	LD IY,#0C445h ; 1a0be
	LD YP,#00h ; 1a0c1
	LD NB,#02h ; 1a0c4
	CARL loc_0x011EB1 ; 1a0c7
	LD HL,#0F20h ; 1a0ca
	LD IY,#4AF7h ; 1a0cd
	LD NB,#02h ; 1a0d0
	CARL loc_0x011B84 ; 1a0d3
	LD HL,#0F20h ; 1a0d6
	LD IY,#4A8Eh ; 1a0d9
	LD NB,#02h ; 1a0dc
	CARL loc_0x011B84 ; 1a0df
	LD HL,#3028h ; 1a0e2
	LD [1B12h],HL ; 1a0e5
	LD IY,#4D37h ; 1a0e8
	LD NB,#02h ; 1a0eb
	CARL loc_0x011B84 ; 1a0ee
	RET
; ---------------------- ; 1a0f1
loc_0x01A0F2:
	LD HL,#0000h ; 1a0f2
	LD IY,#0C445h ; 1a0f5
	LD YP,#00h ; 1a0f8
	LD NB,#02h ; 1a0fb
	CARL loc_0x011EB1 ; 1a0fe
	LD HL,#0800h ; 1a101
	LD [1B10h],HL ; 1a104
	LD IY,#4FEAh ; 1a107
	LD NB,#02h ; 1a10a
	CARL loc_0x011B84 ; 1a10d
	LD HL,#2C28h ; 1a110
	LD [1B12h],HL ; 1a113
	LD IY,#5692h ; 1a116
	LD NB,#02h ; 1a119
	CARL loc_0x011B84 ; 1a11c
	RET
; ---------------------- ; 1a11f
loc_0x01A120:
	LD HL,#0800h ; 1a120
	LD IY,#5A1Dh ; 1a123
	LD NB,#02h ; 1a126
	CARL loc_0x011B84 ; 1a129
	LD HL,#0000h ; 1a12c
	LD IY,#0C445h ; 1a12f
	LD YP,#00h ; 1a132
	LD NB,#02h ; 1a135
	CARL loc_0x011EB1 ; 1a138
	LD HL,#2C28h ; 1a13b
	LD [1B12h],HL ; 1a13e
	LD IY,#5AA7h ; 1a141
	LD NB,#02h ; 1a144
	CARL loc_0x011B84 ; 1a147
	RET
; ---------------------- ; 1a14a
loc_0x01A14B:
	XOR A,A ; 1a14b
	LD [1B3Dh],A ; 1a14c
	LD [1B3Eh],A ; 1a150
	LD HL,#2C2Dh ; 1a154
	LD IY,#5AB3h ; 1a157
	LD NB,#02h ; 1a15a
	CARL loc_0x011B84 ; 1a15d
	LD HL,#1246h ; 1a160
	LD IY,#5AE6h ; 1a163
	LD NB,#02h ; 1a166
	CARL loc_0x011B84 ; 1a169
	LD HL,#0000h ; 1a16c
	LD IY,#0C445h ; 1a16f
	LD YP,#00h ; 1a172
	LD NB,#02h ; 1a175
	CARL loc_0x011EB1 ; 1a178
	LD HL,#2C1Eh ; 1a17b
	LD [1B12h],HL ; 1a17e
	LD HL,#2C2Dh ; 1a181
	LD IY,#5BE5h ; 1a184
	LD NB,#02h ; 1a187
	CARL loc_0x011B84 ; 1a18a
	LD HL,#2C2Dh ; 1a18d
	LD IY,#5C2Fh ; 1a190
	LD NB,#02h ; 1a193
	CARL loc_0x011B84 ; 1a196
	RET
; ---------------------- ; 1a199
loc_0x01A19A:
	XOR A,A ; 1a19a
	LD [1B41h],A ; 1a19b
	LD HL,#2D4Fh ; 1a19f
	LD [1B10h],HL ; 1a1a2
	LD IY,#5DDAh ; 1a1a5
	LD NB,#02h ; 1a1a8
	CARL loc_0x011B84 ; 1a1ab
	LD HL,#0000h ; 1a1ae
	LD IY,#61A0h ; 1a1b1
	LD NB,#02h ; 1a1b4
	CARL loc_0x011B84 ; 1a1b7
	LD HL,#2C00h ; 1a1ba
	LD [1B12h],HL ; 1a1bd
	LD IY,#6118h ; 1a1c0
	LD NB,#02h ; 1a1c3
	CARL loc_0x011B84 ; 1a1c6
	LD HL,#0000h ; 1a1c9
	LD IY,#614Fh ; 1a1cc
	LD NB,#02h ; 1a1cf
	CARL loc_0x011B84 ; 1a1d2
	RET
; ---------------------- ; 1a1d5
loc_0x01A1D6:
	XOR A,A ; 1a1d6
	LD [1B42h],A ; 1a1d7
	LD HL,#0000h ; 1a1db
	LD IY,#61A0h ; 1a1de
	LD NB,#02h ; 1a1e1
	CARL loc_0x011B84 ; 1a1e4
	LD HL,#0800h ; 1a1e7
	LD IY,#6790h ; 1a1ea
	LD NB,#02h ; 1a1ed
	CARL loc_0x011B84 ; 1a1f0
	LD HL,#2C18h ; 1a1f3
	LD [1B10h],HL ; 1a1f6
	LD IY,#6625h ; 1a1f9
	LD NB,#02h ; 1a1fc
	CARL loc_0x011B84 ; 1a1ff
	LD HL,#2C38h ; 1a202
	LD [1B12h],HL ; 1a205
	LD IY,#6421h ; 1a208
	LD NB,#02h ; 1a20b
	CARL loc_0x011B84 ; 1a20e
	RET
; ---------------------- ; 1a211
	DB 07h, 04h, 0Eh, 00h ; 1a212
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
	DB 0C9h, 80h, 0F2h, 82h, 7Fh, 0F8h
; ---------------------- ; 1a275
loc_0x01A27B:
	CARL loc_0x002346 ; 1a27b
	LD HL,#1643h ; 1a27e
	BIT [HL],#01h ; 1a281
	JRS NZ,loc_0x01A28D ; 1a283
	LD HL,#1643h ; 1a285
	BIT [HL],#02h ; 1a288
	JRS NZ,loc_0x01A2AE ; 1a28a
	RET
; ---------------------- ; 1a28c
loc_0x01A28D:
	LD A,[1AB6h] ; 1a28d
	AND A,A ; 1a291
	JRS Z,loc_0x01A29A ; 1a292
	LD A,#01h ; 1a294
	LD [14FAh],A ; 1a296
loc_0x01A29A:
	LD A,[168Eh] ; 1a29a
	AND A,A ; 1a29e
	JRS NZ,loc_0x01A2BB ; 1a29f
	LD A,#0FFh ; 1a2a1
	LD [1AD6h],A ; 1a2a3
	CARL loc_0x0022D4 ; 1a2a7
	CARL loc_0x00228F ; 1a2aa
	RET
; ---------------------- ; 1a2ad
loc_0x01A2AE:
	LD A,[1AB6h] ; 1a2ae
	AND A,A ; 1a2b2
	JRS Z,loc_0x01A2BB ; 1a2b3
	LD A,#02h ; 1a2b5
	LD [14FAh],A ; 1a2b7
loc_0x01A2BB:
	CARL loc_0x0022EE ; 1a2bb
	CARL loc_0x00228F ; 1a2be
	RET
; ---------------------- ; 1a2c1
	DB 07h, 04h, 0Eh, 00h ; 1a2c2
	ASCII "A" ; 1a2c6
	DB 02h, 00h ; 1a2c7
	ASCII "A" ; 1a2c9
	DB 02h, 00h, 00h, 02h, 00h, 00h, 02h ; 1a2ca
	ASCIZ "m/" ; 1a2d1
	DB 2Bh, 0A3h, 03h ; 1a2d4
	ASCII "M" ; 1a2d7
	DB 91h, 03h, 0Ah, 9Eh, 03h, 18h, 08h, 09h ; 1a2d8
	DB 1Ah, 26h, 00h, 0D8h, 81h, 03h, 0Ch, 08h
; ---------------------- ; 1a2e0
loc_0x01A2E8:
	CARL loc_0x0021F4 ; 1a2e8
	CARL loc_0x002338 ; 1a2eb
	LD NB,#02h ; 1a2ee
	CARL loc_0x011ADC ; 1a2f1
	LD NB,#00h ; 1a2f4
	CARL loc_0x002BF9 ; 1a2f7
	LD NB,#07h ; 1a2fa
	CARL loc_0x0382F4 ; 1a2fd
	LD IY,#0A2C2h ; 1a300
	LD YP,#01h ; 1a303
	CARL loc_0x002D72 ; 1a306
	LD A,#01h ; 1a309
	LD [168Eh],A ; 1a30b
	LD HL,#0000h ; 1a30f
	LD IY,#0697h ; 1a312
	LD NB,#02h ; 1a315
	CARL loc_0x011B84 ; 1a318
	LD IY,#13AEh ; 1a31b
	LD NB,#02h ; 1a31e
	CARL loc_0x011B84 ; 1a321
	CARL loc_0x00233F ; 1a324
	CARL loc_0x0021FB ; 1a327
	RET
; ---------------------- ; 1a32a
loc_0x01A32B:
	CARL loc_0x002346 ; 1a32b
	LD HL,#1643h ; 1a32e
	BIT [HL],#01h ; 1a331
	JRS NZ,loc_0x01A33D ; 1a333
	LD HL,#1643h ; 1a335
	BIT [HL],#02h ; 1a338
	JRS NZ,loc_0x01A358 ; 1a33a
	RET
; ---------------------- ; 1a33c
loc_0x01A33D:
	LD A,[1AB6h] ; 1a33d
	AND A,A ; 1a341
	JRS Z,loc_0x01A34A ; 1a342
	LD A,#01h ; 1a344
	LD [14FAh],A ; 1a346
loc_0x01A34A:
	LD A,[168Eh] ; 1a34a
	AND A,A ; 1a34e
	JRS NZ,loc_0x01A365 ; 1a34f
	CARL loc_0x0022D4 ; 1a351
	CARL loc_0x00228F ; 1a354
	RET
; ---------------------- ; 1a357
loc_0x01A358:
	LD A,[1AB6h] ; 1a358
	AND A,A ; 1a35c
	JRS Z,loc_0x01A365 ; 1a35d
	LD A,#02h ; 1a35f
	LD [14FAh],A ; 1a361
loc_0x01A365:
	CARL loc_0x0022EE ; 1a365
	CARL loc_0x00228F ; 1a368
	RET
; ---------------------- ; 1a36b
	DB 07h, 04h, 3Eh, 00h, 0CCh, 07h, 00h, 0CCh ; 1a36c
	DB 07h, 00h, 0C0h, 07h, 00h, 0C0h, 07h ; 1a374
	ASCIZ "m/" ; 1a37b
	DB 0CFh, 0A3h, 03h, 00h, 00h, 00h, 7Eh, 0E3h ; 1a37e
	DB 03h, 18h, 08h, 00h ; 1a386
	ASCIZ "B&" ; 1a38a
	DB 08h, 0CCh, 07h, 0Ch, 08h
; ---------------------- ; 1a38d
loc_0x01A392:
	CARL loc_0x0021F4 ; 1a392
	CARL loc_0x002338 ; 1a395
	LD NB,#02h ; 1a398
	CARL loc_0x011ADC ; 1a39b
	LD NB,#00h ; 1a39e
	CARL loc_0x002BF9 ; 1a3a1
	LD NB,#07h ; 1a3a4
	CARL loc_0x0382F4 ; 1a3a7
	LD IY,#0A36Ch ; 1a3aa
	LD YP,#01h ; 1a3ad
	CARL loc_0x002D72 ; 1a3b0
	LD HL,#0000h ; 1a3b3
	LD IY,#70B3h ; 1a3b6
	LD NB,#02h ; 1a3b9
	CARL loc_0x011B84 ; 1a3bc
	LD IY,#13AEh ; 1a3bf
	LD NB,#02h ; 1a3c2
	CARL loc_0x011B84 ; 1a3c5
	CARL loc_0x00233F ; 1a3c8
	CARL loc_0x0021FB ; 1a3cb
	RET
; ---------------------- ; 1a3ce
loc_0x01A3CF:
	CARL loc_0x002346 ; 1a3cf
	RET
; ---------------------- ; 1a3d2
	DB 07h, 04h, 3Eh, 00h ; 1a3d3
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
	DB 16h, 0B0h, 01h, 0CEh, 0D4h, 0D8h, 1Ah
; ---------------------- ; 1a3fe
loc_0x01A405:
	CARL loc_0x018D07 ; 1a405
	CARL loc_0x018C96 ; 1a408
	LD A,#00h ; 1a40b
	LD [1ADBh],A ; 1a40d
	LD A,#28h ; 1a411
	LD [1ADAh],A ; 1a413
	LD A,#00h ; 1a417
	LD [1B14h],A ; 1a419
	LD H,[1B23h] ; 1a41d
	LD L,#28h ; 1a421
	LD [1B12h],HL ; 1a423
	LD HL,#0800h ; 1a426
	LD [1B10h],HL ; 1a429
	LD A,#0FFh ; 1a42c
	LD [1AD6h],A ; 1a42e
	CARL loc_0x0021F4 ; 1a432
	CARL loc_0x002338 ; 1a435
	LD NB,#02h ; 1a438
	CARL loc_0x011ADC ; 1a43b
	LD NB,#00h ; 1a43e
	CARL loc_0x002BF9 ; 1a441
	LD NB,#07h ; 1a444
	CARL loc_0x0382F4 ; 1a447
	LD IY,#0A3D3h ; 1a44a
	LD YP,#01h ; 1a44d
	CARL loc_0x002D72 ; 1a450
	LD A,#13h ; 1a453
	LD [1360h],A ; 1a455
	LD HL,[1B10h] ; 1a459
	LD IY,#0BCD3h ; 1a45c
	LD YP,#00h ; 1a45f
	LD NB,#02h ; 1a462
	CARL loc_0x011EB1 ; 1a465
	LD HL,#2D4Bh ; 1a468
	LD IY,#276Fh ; 1a46b
	LD NB,#02h ; 1a46e
	CARL loc_0x011B84 ; 1a471
	LD HL,[1B12h] ; 1a474
	LD IY,#0CE4Dh ; 1a477
	LD YP,#00h ; 1a47a
	LD NB,#02h ; 1a47d
	CARL loc_0x011EB1 ; 1a480
	LD HL,#0000h ; 1a483
	LD IY,#0B8F2h ; 1a486
	LD YP,#00h ; 1a489
	LD NB,#02h ; 1a48c
	CARL loc_0x011EB1 ; 1a48f
	LD HL,#2D4Bh ; 1a492
	LD IY,#2775h ; 1a495
	LD NB,#02h ; 1a498
	CARL loc_0x011B84 ; 1a49b
	LD HL,#0001h ; 1a49e
	LD IY,#8D92h ; 1a4a1
	LD NB,#07h ; 1a4a4
	CARL loc_0x03836A ; 1a4a7
	LD HL,#0100h ; 1a4aa
	LD IY,#8E3Dh ; 1a4ad
	LD NB,#07h ; 1a4b0
	CARL loc_0x03836A ; 1a4b3
	LD HL,#0305h ; 1a4b6
	LD IY,#8DF4h ; 1a4b9
	LD NB,#07h ; 1a4bc
	CARL loc_0x03836A ; 1a4bf
	LD A,#00h ; 1a4c2
	CARL loc_0x01898C ; 1a4c4
	LD IY,#13AEh ; 1a4c7
	LD NB,#02h ; 1a4ca
	CARL loc_0x011B84 ; 1a4cd
	CARL loc_0x00233F ; 1a4d0
	CARL loc_0x0021FB ; 1a4d3
	RET
; ---------------------- ; 1a4d6
loc_0x01A4D7:
	CARL loc_0x002346 ; 1a4d7
	RET
; ---------------------- ; 1a4da
	DB 07h, 04h, 3Eh, 00h ; 1a4db
	ASCII "P" ; 1a4df
	DB 03h, 00h ; 1a4e0
	ASCII "W" ; 1a4e2
	DB 03h, 00h, 00h, 07h, 00h, 00h, 07h, 0CAh ; 1a4e3
	DB 2Fh, 00h, 0D6h, 0A5h, 03h, 00h, 00h, 00h ; 1a4eb
	DB 92h, 0A3h, 03h, 18h, 08h, 01h ; 1a4f3
	ASCIZ "B&" ; 1a4f9
	DB 0E0h ; 1a4fc
	ASCII "y" ; 1a4fd
	DB 03h, 0Ch, 08h
; ---------------------- ; 1a4fe
loc_0x01A501:
	CARL loc_0x018C96 ; 1a501
	LD A,#01h ; 1a504
	LD [1ADBh],A ; 1a506
	LD A,#28h ; 1a50a
	LD [1ADAh],A ; 1a50c
	LD A,#00h ; 1a510
	LD [1B14h],A ; 1a512
	LD A,#01h ; 1a516
	LD [1AEAh],A ; 1a518
	LD A,#0FEh ; 1a51c
	LD [1AD6h],A ; 1a51e
	CARL loc_0x0021F4 ; 1a522
	CARL loc_0x002338 ; 1a525
	LD NB,#02h ; 1a528
	CARL loc_0x011ADC ; 1a52b
	LD NB,#00h ; 1a52e
	CARL loc_0x002BF9 ; 1a531
	LD NB,#07h ; 1a534
	CARL loc_0x0382F4 ; 1a537
	LD IY,#0A4DBh ; 1a53a
	LD YP,#01h ; 1a53d
	CARL loc_0x002D72 ; 1a540
	LD A,#13h ; 1a543
	LD [1360h],A ; 1a545
	LD HL,#0000h ; 1a549
	LD IY,#0C445h ; 1a54c
	LD YP,#00h ; 1a54f
	LD NB,#02h ; 1a552
	CARL loc_0x011EB1 ; 1a555
	LD HL,[1B10h] ; 1a558
	LD IY,#0BCD3h ; 1a55b
	LD YP,#00h ; 1a55e
	LD NB,#02h ; 1a561
	CARL loc_0x011EB1 ; 1a564
	LD HL,#2D4Bh ; 1a567
	LD IY,#276Fh ; 1a56a
	LD NB,#02h ; 1a56d
	CARL loc_0x011B84 ; 1a570
	LD HL,[1B12h] ; 1a573
	LD IY,#0CF44h ; 1a576
	LD YP,#00h ; 1a579
	LD NB,#02h ; 1a57c
	CARL loc_0x011EB1 ; 1a57f
	LD HL,#0000h ; 1a582
	LD IY,#0B8F2h ; 1a585
	LD YP,#00h ; 1a588
	LD NB,#02h ; 1a58b
	CARL loc_0x011EB1 ; 1a58e
	LD HL,#2D4Bh ; 1a591
	LD IY,#2775h ; 1a594
	LD NB,#02h ; 1a597
	CARL loc_0x011B84 ; 1a59a
	LD HL,#0001h ; 1a59d
	LD IY,#8D92h ; 1a5a0
	LD NB,#07h ; 1a5a3
	CARL loc_0x03836A ; 1a5a6
	LD HL,#0100h ; 1a5a9
	LD IY,#8E3Dh ; 1a5ac
	LD NB,#07h ; 1a5af
	CARL loc_0x03836A ; 1a5b2
	LD HL,#0305h ; 1a5b5
	LD IY,#8DF4h ; 1a5b8
	LD NB,#07h ; 1a5bb
	CARL loc_0x03836A ; 1a5be
	LD A,#00h ; 1a5c1
	CARL loc_0x01898C ; 1a5c3
	LD IY,#13AEh ; 1a5c6
	LD NB,#02h ; 1a5c9
	CARL loc_0x011B84 ; 1a5cc
	CARL loc_0x00233F ; 1a5cf
	CARL loc_0x0021FB ; 1a5d2
	RET
; ---------------------- ; 1a5d5
loc_0x01A5D6:
	CARL loc_0x002346 ; 1a5d6
	RET
; ---------------------- ; 1a5d9
	DB 07h, 04h, 3Eh, 00h ; 1a5da
	ASCII "s" ; 1a5de
	DB 06h, 00h ; 1a5df
	ASCII "s" ; 1a5e1
	DB 06h, 00h, 08h, 06h, 00h, 0Ch, 06h ; 1a5e2
	ASCIZ "m/" ; 1a5e9
	ASCII "a" ; 1a5ec
	DB 0A6h, 03h, 00h, 00h, 00h, 10h, 9Eh, 03h ; 1a5ed
	DB 18h, 08h, 09h ; 1a5f5
	ASCIZ "B&" ; 1a5f8
	DB 80h, 0B0h, 06h, 0Ch, 08h
; ---------------------- ; 1a5fb
loc_0x01A600:
	CARL loc_0x0021F4 ; 1a600
	CARL loc_0x002338 ; 1a603
	LD NB,#02h ; 1a606
	CARL loc_0x011ADC ; 1a609
	LD NB,#00h ; 1a60c
	CARL loc_0x002BF9 ; 1a60f
	LD NB,#07h ; 1a612
	CARL loc_0x0382F4 ; 1a615
	LD IY,#0A5DAh ; 1a618
	LD YP,#01h ; 1a61b
	CARL loc_0x002D72 ; 1a61e
	LD HL,#0000h ; 1a621
	LD IY,#72E8h ; 1a624
	LD NB,#02h ; 1a627
	CARL loc_0x011B84 ; 1a62a
	LD HL,#0000h ; 1a62d
	LD IY,#731Ch ; 1a630
	LD NB,#02h ; 1a633
	CARL loc_0x011B84 ; 1a636
	LD HL,#0000h ; 1a639
	LD IY,#7336h ; 1a63c
	LD NB,#02h ; 1a63f
loc_0x01A642:
	CARL loc_0x011B84 ; 1a642
loc_0x01A645:
	LD HL,#060Ah ; 1a645
	LD IY,#951Bh ; 1a648
	LD NB,#07h ; 1a64b
	CARL loc_0x03836A ; 1a64e
	LD IY,#13AEh ; 1a651
	LD NB,#02h ; 1a654
	CARL loc_0x011B84 ; 1a657
	CARL loc_0x00233F ; 1a65a
	CARL loc_0x0021FB ; 1a65d
	RET
; ---------------------- ; 1a660
loc_0x01A661:
	CARL loc_0x002346 ; 1a661
	LD A,[1643h] ; 1a664
	BIT A,#01h ; 1a668
	JRS NZ,loc_0x01A67F ; 1a66a
	BIT A,#02h ; 1a66c
	JRS Z,loc_0x01A692 ; 1a66e
	LD A,[1AB6h] ; 1a670
	AND A,A ; 1a674
	JRS Z,loc_0x01A67D ; 1a675
	LD A,#02h ; 1a677
	LD [14FAh],A ; 1a679
loc_0x01A67D:
	JRS loc_0x01A68C
; ---------------------- ; 1a67d
loc_0x01A67F:
	LD A,[1AB6h] ; 1a67f
	AND A,A ; 1a683
	JRS Z,loc_0x01A68C ; 1a684
	LD A,#01h ; 1a686
	LD [14FAh],A ; 1a688
loc_0x01A68C:
	CARL loc_0x0022D4 ; 1a68c
	CARL loc_0x00228F ; 1a68f
loc_0x01A692:
	RET
; ---------------------- ; 1a692
	DB 07h, 04h, 3Eh, 00h ; 1a693
	ASCII "P" ; 1a697
	DB 03h, 00h ; 1a698
	ASCII "W" ; 1a69a
	DB 03h, 00h, 00h, 07h, 00h, 00h, 07h, 0CAh ; 1a69b
	DB 2Fh, 00h, 8Bh, 0A7h, 03h, 00h, 00h, 00h ; 1a6a3
	DB 0D2h, 0E4h, 03h, 18h, 08h, 01h ; 1a6ab
	ASCIZ "B&" ; 1a6b1
	DB 0E0h ; 1a6b4
	ASCII "y" ; 1a6b5
	DB 03h, 0Ch, 08h, 0F2h, 0DBh, 0E5h
; ---------------------- ; 1a6b6
loc_0x01A6BC:
	XOR A,A ; 1a6bc
	LD [1B15h],A ; 1a6bd
	LD [1B2Ah],A ; 1a6c1
	LD A,#01h ; 1a6c5
	LD [1B14h],A ; 1a6c7
	CARL loc_0x0021F4 ; 1a6cb
	CARL loc_0x002338 ; 1a6ce
	LD NB,#02h ; 1a6d1
	CARL loc_0x011ADC ; 1a6d4
	LD NB,#00h ; 1a6d7
	CARL loc_0x002BF9 ; 1a6da
	LD NB,#07h ; 1a6dd
	CARL loc_0x0382F4 ; 1a6e0
	LD IY,#0A693h ; 1a6e3
	LD YP,#01h ; 1a6e6
	CARL loc_0x002D72 ; 1a6e9
	LD HL,#0800h ; 1a6ec
	LD [1B10h],HL ; 1a6ef
	LD IY,#0BCD3h ; 1a6f2
	LD YP,#00h ; 1a6f5
	LD NB,#02h ; 1a6f8
	CARL loc_0x011EB1 ; 1a6fb
	LD HL,#0000h ; 1a6fe
	LD IY,#7524h ; 1a701
	LD NB,#02h ; 1a704
	CARL loc_0x011B84 ; 1a707
	LD HL,#0000h ; 1a70a
	LD IY,#752Ah ; 1a70d
	LD NB,#02h ; 1a710
	CARL loc_0x011B84 ; 1a713
	LD HL,#2D4Bh ; 1a716
	LD IY,#276Fh ; 1a719
	LD NB,#02h ; 1a71c
	CARL loc_0x011B84 ; 1a71f
	LD H,[1B23h] ; 1a722
	LD L,#28h ; 1a726
	LD [1B12h],HL ; 1a728
	LD IY,#0B813h ; 1a72b
	LD YP,#00h ; 1a72e
	LD NB,#02h ; 1a731
	CARL loc_0x011EB1 ; 1a734
	LD HL,#0000h ; 1a737
	LD IY,#0B8F2h ; 1a73a
	LD YP,#00h ; 1a73d
	LD NB,#02h ; 1a740
	CARL loc_0x011EB1 ; 1a743
	LD HL,#2D4Bh ; 1a746
	LD IY,#2775h ; 1a749
	LD NB,#02h ; 1a74c
	CARL loc_0x011B84 ; 1a74f
	LD HL,#0001h ; 1a752
	LD IY,#8D92h ; 1a755
	LD NB,#07h ; 1a758
	CARL loc_0x03836A ; 1a75b
	LD HL,#0100h ; 1a75e
	LD IY,#8E3Dh ; 1a761
	LD NB,#07h ; 1a764
	CARL loc_0x03836A ; 1a767
	LD HL,#0305h ; 1a76a
	LD IY,#8DF4h ; 1a76d
	LD NB,#07h ; 1a770
	CARL loc_0x03836A ; 1a773
	LD A,#01h ; 1a776
	CARL loc_0x01898C ; 1a778
	LD IY,#13AEh ; 1a77b
	LD NB,#02h ; 1a77e
	CARL loc_0x011B84 ; 1a781
	CARL loc_0x00233F ; 1a784
	CARL loc_0x0021FB ; 1a787
	RET
; ---------------------- ; 1a78a
loc_0x01A78B:
	CARL loc_0x002346 ; 1a78b
	LD A,[1643h] ; 1a78e
	BIT A,#02h ; 1a792
	JRS Z,loc_0x01A7A9 ; 1a794
	LD A,[1AB6h] ; 1a796
	AND A,A ; 1a79a
	JRS Z,loc_0x01A7A3 ; 1a79b
	LD A,#02h ; 1a79d
	LD [14FAh],A ; 1a79f
loc_0x01A7A3:
	CARL loc_0x0022D4 ; 1a7a3
	CARL loc_0x00228F ; 1a7a6
loc_0x01A7A9:
	RET
; ---------------------- ; 1a7a9
	DB 0Dh, 04h, 3Eh, 00h, 8Fh, 06h, 00h, 8Fh ; 1a7aa
	DB 06h, 00h, 80h, 05h, 00h, 80h, 05h ; 1a7b2
	ASCIZ "m/" ; 1a7b9
	ASCII "I" ; 1a7bc
	DB 0A8h, 03h ; 1a7bd
	ASCII "M" ; 1a7bf
	DB 91h, 03h, 0C4h, 0E8h, 03h, 18h, 08h, 06h ; 1a7c0
	ASCIZ "B&" ; 1a7c8
	DB 0E0h, 0B0h, 06h, 0Ch, 08h
; ---------------------- ; 1a7cb
loc_0x01A7D0:
	CARL loc_0x0021F4 ; 1a7d0
	CARL loc_0x002338 ; 1a7d3
	LD NB,#02h ; 1a7d6
	CARL loc_0x011ADC ; 1a7d9
	LD NB,#00h ; 1a7dc
	CARL loc_0x002BF9 ; 1a7df
	LD NB,#07h ; 1a7e2
	CARL loc_0x0382F4 ; 1a7e5
	LD IY,#0A7AAh ; 1a7e8
	LD YP,#01h ; 1a7eb
	CARL loc_0x002D72 ; 1a7ee
	LD HL,#1800h ; 1a7f1
	LD IY,#23B5h ; 1a7f4
	LD NB,#02h ; 1a7f7
	CARL loc_0x011B84 ; 1a7fa
	LD HL,#1858h ; 1a7fd
	LD IY,#23A3h ; 1a800
	LD NB,#02h ; 1a803
	CARL loc_0x011B84 ; 1a806
	LD HL,#1810h ; 1a809
	LD IY,#76B2h ; 1a80c
	LD NB,#02h ; 1a80f
	CARL loc_0x011B84 ; 1a812
	LD HL,#1840h ; 1a815
	LD IY,#769Ah ; 1a818
	LD NB,#02h ; 1a81b
	CARL loc_0x011B84 ; 1a81e
	LD HL,#1828h ; 1a821
	LD IY,#7683h ; 1a824
	LD NB,#02h ; 1a827
	CARL loc_0x011B84 ; 1a82a
	LD HL,#0602h ; 1a82d
	LD IY,#94B4h ; 1a830
	LD NB,#07h ; 1a833
	CARL loc_0x03836A ; 1a836
	LD IY,#13AEh ; 1a839
	LD NB,#02h ; 1a83c
	CARL loc_0x011B84 ; 1a83f
	CARL loc_0x00233F ; 1a842
	CARL loc_0x0021FB ; 1a845
	RET
; ---------------------- ; 1a848
loc_0x01A849:
	CARL loc_0x0189F1 ; 1a849
	CARL loc_0x002346 ; 1a84c
	LD A,[1643h] ; 1a84f
	BIT A,#01h ; 1a853
	JRS NZ,loc_0x01A86F ; 1a855
	BIT A,#02h ; 1a857
	JRS Z,loc_0x01A882 ; 1a859
	LD A,[1AB6h] ; 1a85b
	AND A,A ; 1a85f
	JRS Z,loc_0x01A868 ; 1a860
	LD A,#02h ; 1a862
	LD [14FAh],A ; 1a864
loc_0x01A868:
	CARL loc_0x0022EE ; 1a868
	CARL loc_0x00228F ; 1a86b
	RET
; ---------------------- ; 1a86e
loc_0x01A86F:
	LD A,[1AB6h] ; 1a86f
	AND A,A ; 1a873
	JRS Z,loc_0x01A87C ; 1a874
	LD A,#01h ; 1a876
	LD [14FAh],A ; 1a878
loc_0x01A87C:
	CARL loc_0x0022D4 ; 1a87c
	CARL loc_0x00228F ; 1a87f
loc_0x01A882:
	RET
; ---------------------- ; 1a882
	DB 07h, 04h, 0Eh, 00h ; 1a883
	ASCII "s" ; 1a887
	DB 06h, 00h ; 1a888
	ASCII "s" ; 1a88a
	DB 06h, 00h, 08h, 06h, 00h, 0Ch, 06h ; 1a88b
	ASCIZ "m/" ; 1a892
	DB 0Bh, 0A9h, 03h, 00h, 00h, 00h, 0Ah, 9Eh ; 1a895
	DB 03h, 18h, 08h, 09h, 1Ah, 26h, 00h, 80h ; 1a89d
	DB 0B0h, 06h, 0Ch, 08h
; ---------------------- ; 1a8a5
loc_0x01A8A9:
	CARL loc_0x0021F4 ; 1a8a9
	CARL loc_0x002338 ; 1a8ac
	CARL loc_0x01A946 ; 1a8af
	LD NB,#02h ; 1a8b2
	CARL loc_0x011ADC ; 1a8b5
	LD NB,#00h ; 1a8b8
	CARL loc_0x002BF9 ; 1a8bb
	LD NB,#07h ; 1a8be
	CARL loc_0x0382F4 ; 1a8c1
	LD IY,#0A883h ; 1a8c4
	LD YP,#01h ; 1a8c7
	CARL loc_0x002D72 ; 1a8ca
	LD A,[1AD4h] ; 1a8cd
	LD NB,#02h ; 1a8d1
	CARL loc_0x01724C ; 1a8d4
	LD HL,#0000h ; 1a8d7
	LD IY,#72EEh ; 1a8da
	LD NB,#02h ; 1a8dd
	CARL loc_0x011B84 ; 1a8e0
	LD HL,#0000h ; 1a8e3
	LD IY,#7302h ; 1a8e6
	LD NB,#02h ; 1a8e9
	CARL loc_0x011B84 ; 1a8ec
	LD HL,#0000h ; 1a8ef
	LD IY,#7342h ; 1a8f2
	LD NB,#02h ; 1a8f5
	CARL loc_0x011B84 ; 1a8f8
	LD IY,#13AEh ; 1a8fb
	LD NB,#02h ; 1a8fe
	CARL loc_0x011B84 ; 1a901
	CARL loc_0x00233F ; 1a904
	CARL loc_0x0021FB ; 1a907
	RET
; ---------------------- ; 1a90a
loc_0x01A90B:
	CARL loc_0x002346 ; 1a90b
	LD A,[1643h] ; 1a90e
	BIT A,#01h ; 1a912
	JRS NZ,loc_0x01A929 ; 1a914
	BIT A,#02h ; 1a916
	JRS Z,loc_0x01A945 ; 1a918
	LD A,[1AB6h] ; 1a91a
	AND A,A ; 1a91e
	JRS Z,loc_0x01A927 ; 1a91f
	LD A,#02h ; 1a921
	LD [14FAh],A ; 1a923
loc_0x01A927:
	JRS loc_0x01A936
; ---------------------- ; 1a927
loc_0x01A929:
	LD A,[1AB6h] ; 1a929
	AND A,A ; 1a92d
	JRS Z,loc_0x01A936 ; 1a92e
	LD A,#01h ; 1a930
	LD [14FAh],A ; 1a932
loc_0x01A936:
	CARL loc_0x01A98A ; 1a936
	LD A,#0FFh ; 1a939
	LD [1AD6h],A ; 1a93b
	CARL loc_0x0022D4 ; 1a93f
	CARL loc_0x00228F ; 1a942
loc_0x01A945:
	RET
; ---------------------- ; 1a945
loc_0x01A946:
	LD A,[1ADDh] ; 1a946
	CP A,#40h ; 1a94a
	JRS C,loc_0x01A973 ; 1a94c
	LD A,[1ADFh] ; 1a94e
	CP A,#40h ; 1a952
	JRS C,loc_0x01A973 ; 1a954
	LD A,[1AE1h] ; 1a956
	CP A,#40h ; 1a95a
	JRS C,loc_0x01A973 ; 1a95c
	LD A,[1AE3h] ; 1a95e
	CP A,#40h ; 1a962
	JRS C,loc_0x01A973 ; 1a964
	XOR A,A ; 1a966
	LD B,[1AC2h] ; 1a967
	CP B,#02h ; 1a96b
	JRS NZ,loc_0x01A978 ; 1a96e
	INC A ; 1a970
	JRS loc_0x01A978
; ---------------------- ; 1a971
loc_0x01A973:
	CARL loc_0x01A9AB ; 1a973
	ADD A,#02h ; 1a976
loc_0x01A978:
	PUSH A ; 1a978
	LD A,[1AD7h] ; 1a97a
	LD B,A ; 1a97e
	ADD A,A ; 1a97f
	ADD A,B ; 1a980
	ADD A,A ; 1a981
	POP B ; 1a982
	ADD A,B ; 1a984
	LD [1AD4h],A ; 1a985
	RET
; ---------------------- ; 1a989
loc_0x01A98A:
	LD A,[1AD4h] ; 1a98a
	CP A,#10h ; 1a98e
	JRS C,loc_0x01A99E ; 1a990
	SUB A,#10h ; 1a992
	CARL loc_0x0023D8 ; 1a994
	LD HL,#1AD3h ; 1a997
	OR [HL],A ; 1a99a
	JRS loc_0x01A9AA
; ---------------------- ; 1a99c
loc_0x01A99E:
	CARL loc_0x0023D8 ; 1a99e
	LD HL,#1AD1h ; 1a9a1
	OR [HL],A ; 1a9a4
	INC HL ; 1a9a6
	LD A,B ; 1a9a7
	OR [HL],A ; 1a9a8
loc_0x01A9AA:
	RET
; ---------------------- ; 1a9aa
loc_0x01A9AB:
	LD A,[1ADDh] ; 1a9ab
	LD B,[1ADFh] ; 1a9af
	CP A,B ; 1a9b3
	JRS C,loc_0x01A9C8 ; 1a9b4
	LD B,[1AE1h] ; 1a9b6
	CP A,B ; 1a9ba
	JRS C,loc_0x01A9DB ; 1a9bb
	LD B,[1AE3h] ; 1a9bd
	CP A,B ; 1a9c1
	JRS C,loc_0x01A9E7 ; 1a9c2
	LD A,#00h ; 1a9c4
	JRS loc_0x01A9E9
; ---------------------- ; 1a9c6
loc_0x01A9C8:
	LD A,B ; 1a9c8
	LD B,[1AE1h] ; 1a9c9
	CP A,B ; 1a9cd
	JRS C,loc_0x01A9DB ; 1a9ce
	LD B,[1AE3h] ; 1a9d0
	CP A,B ; 1a9d4
	JRS C,loc_0x01A9E7 ; 1a9d5
	LD A,#01h ; 1a9d7
	JRS loc_0x01A9E9
; ---------------------- ; 1a9d9
loc_0x01A9DB:
	LD A,B ; 1a9db
	LD B,[1AE3h] ; 1a9dc
	CP A,B ; 1a9e0
	JRS C,loc_0x01A9E7 ; 1a9e1
	LD A,#02h ; 1a9e3
	JRS loc_0x01A9E9
; ---------------------- ; 1a9e5
loc_0x01A9E7:
	LD A,#03h ; 1a9e7
loc_0x01A9E9:
	RET
; ---------------------- ; 1a9e9
loc_0x01A9EA:
	LD A,[1AEBh] ; 1a9ea
	XOR A,#0FFh ; 1a9ee
	LD B,[1AEAh] ; 1a9f0
	AND A,B ; 1a9f4
	LD B,#08h ; 1a9f5
loc_0x01A9F7:
	SRL A ; 1a9f7
	JRS C,loc_0x01AA00 ; 1a9f9
	DJR NZ,loc_0x01A9F7 ; 1a9fb
	LD A,#0FFh ; 1a9fd
	RET
; ---------------------- ; 1a9ff
loc_0x01AA00:
	LD A,#08h ; 1aa00
	SUB A,B ; 1aa02
	LD NB,#02h ; 1aa03
	CARL loc_0x012476 ; 1aa06
	RET
; ---------------------- ; 1aa09
loc_0x01AA0A:
	CP A,#08h ; 1aa0a
	JRS NC,loc_0x01AA1C ; 1aa0c
	LD NB,#02h ; 1aa0e
	CARL loc_0x012495 ; 1aa11
	CARL loc_0x0023D8 ; 1aa14
	LD HL,#1AEBh ; 1aa17
	OR [HL],A ; 1aa1a
loc_0x01AA1C:
	RET
; ---------------------- ; 1aa1c
	DB 0Dh, 04h, 3Eh, 00h, 97h, 06h, 00h, 97h ; 1aa1d
	DB 06h, 00h, 08h, 06h, 00h, 0Ch, 06h ; 1aa25
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
	DB 9Ah, 0D8h, 0C7h, 1Dh, 0AAh, 0CEh, 0C7h, 01h
; ---------------------- ; 1aa59
loc_0x01AA61:
	CARL loc_0x002D72 ; 1aa61
	CARL loc_0x01AABF ; 1aa64
	LD IY,#13AEh ; 1aa67
	LD NB,#02h ; 1aa6a
	CARL loc_0x011B84 ; 1aa6d
	CARL loc_0x00233F ; 1aa70
	CARL loc_0x0021FB ; 1aa73
	LD A,[1AB6h] ; 1aa76
	AND A,A ; 1aa7a
	JRS Z,loc_0x01AA83 ; 1aa7b
	LD A,#22h ; 1aa7d
	LD [14FAh],A ; 1aa7f
loc_0x01AA83:
	RET
; ---------------------- ; 1aa83
loc_0x01AA84:
	CARL loc_0x0189F1 ; 1aa84
	CARL loc_0x002346 ; 1aa87
	LD A,[1643h] ; 1aa8a
	BIT A,#01h ; 1aa8e
	JRS NZ,loc_0x01AAA5 ; 1aa90
	BIT A,#02h ; 1aa92
	JRS Z,loc_0x01AABE ; 1aa94
	LD A,[1AB6h] ; 1aa96
	AND A,A ; 1aa9a
	JRS Z,loc_0x01AAA3 ; 1aa9b
	LD A,#02h ; 1aa9d
	LD [14FAh],A ; 1aa9f
loc_0x01AAA3:
	JRS loc_0x01AAB2
; ---------------------- ; 1aaa3
loc_0x01AAA5:
	LD A,[1AB6h] ; 1aaa5
	AND A,A ; 1aaa9
	JRS Z,loc_0x01AAB2 ; 1aaaa
	LD A,#01h ; 1aaac
	LD [14FAh],A ; 1aaae
loc_0x01AAB2:
	CARL loc_0x0022D4 ; 1aab2
	CARL loc_0x00228F ; 1aab5
	LD A,#0FFh ; 1aab8
	LD [1B69h],A ; 1aaba
loc_0x01AABE:
	RET
; ---------------------- ; 1aabe
loc_0x01AABF:
	LD A,[1AD7h] ; 1aabf
	CP A,#00h ; 1aac3
	JRS Z,loc_0x01AB2B ; 1aac5
	CP A,#01h ; 1aac7
	JRS Z,loc_0x01AAE4 ; 1aac9
	LD BA,#0A900h ; 1aacb
	LD [162Ch],BA ; 1aace
	LD A,#06h ; 1aad1
	LD [162Eh],A ; 1aad3
	LD BA,#0AC00h ; 1aad7
	LD [162Fh],BA ; 1aada
	LD A,#06h ; 1aadd
	LD [1631h],A ; 1aadf
	RET
; ---------------------- ; 1aae3
loc_0x01AAE4:
	LD IX,#15AAh ; 1aae4
	LD XP,#00h ; 1aae7
	CARL loc_0x004706 ; 1aaea
	LD A,[15ADh] ; 1aaed
	CP A,#06h ; 1aaf1
	JRS C,loc_0x01AAF9 ; 1aaf3
	CP A,#12h ; 1aaf5
	JRS C,loc_0x01AB12 ; 1aaf7
loc_0x01AAF9:
	LD BA,#0A300h ; 1aaf9
	LD [162Ch],BA ; 1aafc
	LD A,#06h ; 1aaff
	LD [162Eh],A ; 1ab01
	LD BA,#0A600h ; 1ab05
	LD [162Fh],BA ; 1ab08
	LD A,#06h ; 1ab0b
	LD [1631h],A ; 1ab0d
	RET
; ---------------------- ; 1ab11
loc_0x01AB12:
	LD BA,#9D00h ; 1ab12
	LD [162Ch],BA ; 1ab15
	LD A,#06h ; 1ab18
	LD [162Eh],A ; 1ab1a
	LD BA,#0A000h ; 1ab1e
	LD [162Fh],BA ; 1ab21
	LD A,#06h ; 1ab24
	LD [1631h],A ; 1ab26
	RET
; ---------------------- ; 1ab2a
loc_0x01AB2B:
	LD BA,#9700h ; 1ab2b
	LD [162Ch],BA ; 1ab2e
	LD A,#06h ; 1ab31
	LD [162Eh],A ; 1ab33
	LD BA,#9A00h ; 1ab37
	LD [162Fh],BA ; 1ab3a
	LD A,#06h ; 1ab3d
	LD [1631h],A ; 1ab3f
	RET
; ---------------------- ; 1ab43
	DB 06h, 04h, 0Eh, 00h, 0AFh, 06h, 00h, 0AFh ; 1ab44
	DB 06h, 00h, 00h, 00h, 00h, 00h, 00h, 16h ; 1ab4c
	DB 2Fh, 00h, 0C4h, 0ABh, 03h, 00h, 00h, 00h ; 1ab54
	DB 10h, 9Eh, 03h, 18h, 08h, 01h, 12h, 26h ; 1ab5c
	DB 00h, 0C0h, 0B2h, 06h, 0Ch, 08h
; ---------------------- ; 1ab64
loc_0x01AB6A:
	CARL loc_0x0021F4 ; 1ab6a
	CARL loc_0x002338 ; 1ab6d
	LD NB,#02h ; 1ab70
	CARL loc_0x011ADC ; 1ab73
	LD NB,#00h ; 1ab76
	CARL loc_0x002BF9 ; 1ab79
	LD NB,#07h ; 1ab7c
	CARL loc_0x0382F4 ; 1ab7f
	LD NB,#00h ; 1ab82
	CARL loc_0x00287D ; 1ab85
	JRS loc_0x01ABA2
; ---------------------- ; 1ab88
loc_0x01AB8A:
	CARL loc_0x0021F4 ; 1ab8a
	CARL loc_0x002338 ; 1ab8d
	LD NB,#02h ; 1ab90
	CARL loc_0x011ADC ; 1ab93
	LD NB,#00h ; 1ab96
loc_0x01AB99:
	CARL loc_0x002BF9 ; 1ab99
	LD NB,#07h ; 1ab9c
	CARL loc_0x0382F4 ; 1ab9f
loc_0x01ABA2:
	LD IY,#0AB44h ; 1aba2
	LD YP,#01h ; 1aba5
	CARL loc_0x002D72 ; 1aba8
	LD IY,#76E7h ; 1abab
	LD NB,#02h ; 1abae
	CARL loc_0x011B84 ; 1abb1
	LD IY,#13AEh ; 1abb4
	LD NB,#02h ; 1abb7
	CARL loc_0x011B84 ; 1abba
	CARL loc_0x00233F ; 1abbd
	CARL loc_0x0021FB ; 1abc0
	RET
; ---------------------- ; 1abc3
loc_0x01ABC4:
	CARL loc_0x002346 ; 1abc4
	RET
; ---------------------- ; 1abc7
	DB 00h, 00h, 01h, 08h, 10h, 00h, 02h ; 1abc7
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
	DB 0A0h, 0B1h, 06h, 0Ch, 08h

; ---------------------- ; 1e659
loc_0x01E65E:
	LD HL,#1BACh ; 1e65e
	XOR A,A ; 1e661
	LD B,#05h ; 1e662
loc_0x01E664:
	CP [HL],#0F4h ; 1e664
	JRS Z,loc_0x01E66A ; 1e667
	INC A ; 1e669
loc_0x01E66A:
	INC HL ; 1e66a
	DJR NZ,loc_0x01E664 ; 1e66b
	RET
; ---------------------- ; 1e66d
loc_0x01E66E:
	CARL loc_0x0021F4 ; 1e66e
	CARL loc_0x002338 ; 1e671
	LD NB,#02h ; 1e674
	CARL loc_0x011ADC ; 1e677
	LD NB,#00h ; 1e67a
	CARL loc_0x002BF9 ; 1e67d
	LD NB,#07h ; 1e680
	CARL loc_0x0382F4 ; 1e683
	CARL loc_0x00287D ; 1e686
	JRS loc_0x01E6A3
; ---------------------- ; 1e689
loc_0x01E68B:
	CARL loc_0x0021F4 ; 1e68b
	CARL loc_0x002338 ; 1e68e
	LD NB,#02h ; 1e691
	CARL loc_0x011ADC ; 1e694
	LD NB,#00h ; 1e697
	CARL loc_0x002BF9 ; 1e69a
	LD NB,#07h ; 1e69d
	CARL loc_0x0382F4 ; 1e6a0
loc_0x01E6A3:
	LD A,[1ABCh] ; 1e6a3
	AND A,A ; 1e6a7
	JRL NZ,loc_0x01AB8A ; 1e6a8
	CARL loc_0x01E791 ; 1e6ab
	XOR A,A ; 1e6ae
	JRS loc_0x01E6CB
; ---------------------- ; 1e6af
	DB 0F2h ; 1e6b1
	ASCII "A;" ; 1e6b2
	DB 0F2h, 82h, 3Ch, 0CEh, 0C4h, 02h, 0F2h, 20h ; 1e6b4
	DB 0B4h, 0CEh, 0C4h, 00h, 0F2h ; 1e6bc
	ASCII "7E" ; 1e6c1
	DB 0CEh, 0C4h, 07h, 0F2h, 2Ch, 9Ch, 0B0h, 01h
; ---------------------- ; 1e6c3
loc_0x01E6CB:
	LD [1BABh],A ; 1e6cb
	LD IY,#0E638h ; 1e6cf
	LD YP,#01h ; 1e6d2
	CARL loc_0x002D72 ; 1e6d5
	LD A,#00h ; 1e6d8
	LD [164Dh],A ; 1e6da
	CARL loc_0x01E7B4 ; 1e6de
	XOR A,A ; 1e6e1
	LD [1BB3h],A ; 1e6e2
	LD [1BB4h],A ; 1e6e6
	LD NB,#03h ; 1e6ea
	CARL loc_0x01E65E ; 1e6ed
	CP A,#00h ; 1e6f0
	JRS Z,loc_0x01E6F6 ; 1e6f2
	LD A,#3Bh ; 1e6f4
loc_0x01E6F6:
	LD [1BB6h],A ; 1e6f6
	LD NB,#03h ; 1e6fa
	CARL loc_0x01E65E ; 1e6fd
	CP A,#05h ; 1e700
	JRS NZ,loc_0x01E705 ; 1e702
	DEC A ; 1e704
loc_0x01E705:
	LD [1BB5h],A ; 1e705
	LD HL,#0000h ; 1e709
	LD IY,#0D74h ; 1e70c
	LD NB,#02h ; 1e70f
	CARL loc_0x011B84 ; 1e712
	LD HL,#0018h ; 1e715
	LD IY,#07B6h ; 1e718
	LD NB,#02h ; 1e71b
	CARL loc_0x011B84 ; 1e71e
	LD HL,#0060h ; 1e721
	LD IY,#0E7Fh ; 1e724
	LD NB,#02h ; 1e727
	CARL loc_0x011B84 ; 1e72a
	LD HL,#0040h ; 1e72d
	LD IY,#0DA5h ; 1e730
	LD NB,#02h ; 1e733
	CARL loc_0x011B84 ; 1e736
	LD IY,#95EEh ; 1e739
	LD NB,#07h ; 1e73c
	CARL loc_0x03836A ; 1e73f
	LD IY,#9643h ; 1e742
	LD NB,#07h ; 1e745
	CARL loc_0x03836A ; 1e748
	LD IY,#13AEh ; 1e74b
	LD NB,#02h ; 1e74e
	CARL loc_0x011B84 ; 1e751
	CARL loc_0x00233F ; 1e754
	CARL loc_0x0021FB ; 1e757
	RET
; ---------------------- ; 1e75a
loc_0x01E75B:
	CARL loc_0x002346 ; 1e75b
	LD HL,#1643h ; 1e75e
	BIT [HL],#01h ; 1e761
	JRS NZ,loc_0x01E766 ; 1e763
	RET
; ---------------------- ; 1e765
loc_0x01E766:
	LD A,[1BB3h] ; 1e766
	CP A,#02h ; 1e76a
	JRS NZ,loc_0x01E790 ; 1e76c
	CARL loc_0x01E7D7 ; 1e76e
	LD A,[1BABh] ; 1e771
	AND A,A ; 1e775
	JRS NZ,loc_0x01E787 ; 1e776
	LD A,#01h ; 1e778
	LD [1ABCh],A ; 1e77a
	LD HL,#0AB6Ah ; 1e77e
	LD B,#03h ; 1e781
	CARL loc_0x00228F ; 1e783
	RET
; ---------------------- ; 1e786
loc_0x01E787:
	LD HL,#80CFh ; 1e787
	LD B,#03h ; 1e78a
	CARL loc_0x00228F ; 1e78c
	RET
; ---------------------- ; 1e78f
loc_0x01E790:
	RET
; ---------------------- ; 1e790
loc_0x01E791:
	LD BA,#0F4F4h ; 1e791
	LD [1ABDh],BA ; 1e794
	LD [1ABFh],BA ; 1e797
	LD [1AC1h],A ; 1e79a
	LD [1BACh],BA ; 1e79e
	LD [1BAEh],BA ; 1e7a1
	LD [1BB0h],A ; 1e7a4
	LD A,#0FDh ; 1e7a8
	LD [1BB1h],A ; 1e7aa
	XOR A,A ; 1e7ae
	LD [1BB2h],A ; 1e7af
	RET
; ---------------------- ; 1e7b3
loc_0x01E7B4:
	LD BA,[1ABDh] ; 1e7b4
	LD [1BACh],BA ; 1e7b7
	LD BA,[1ABFh] ; 1e7ba
	LD [1BAEh],BA ; 1e7bd
	LD A,[1AC1h] ; 1e7c0
	LD [1BB0h],A ; 1e7c4
	LD A,#0FDh ; 1e7c8
	LD [1BB1h],A ; 1e7ca
	LD A,[1AC2h] ; 1e7ce
	LD [1BB2h],A ; 1e7d2
	RET
; ---------------------- ; 1e7d6
loc_0x01E7D7:
	LD BA,[1BACh] ; 1e7d7
	LD [1ABDh],BA ; 1e7da
	LD BA,[1BAEh] ; 1e7dd
	LD [1ABFh],BA ; 1e7e0
	LD A,[1BB0h] ; 1e7e3
	LD [1AC1h],A ; 1e7e7
	LD A,[1BB2h] ; 1e7eb
	LD [1AC2h],A ; 1e7ef
	RET
; ---------------------- ; 1e7f3
	DB 0C6h, 0ACh, 1Bh, 0B0h, 0F4h, 0B1h, 05h ; 1e7f4
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
	DB 03h, 0Ch, 08h
; ---------------------- ; 1e8c1
loc_0x01E8C4:
	CARL loc_0x0021F4 ; 1e8c4
	CARL loc_0x002338 ; 1e8c7
	LD NB,#02h ; 1e8ca
	CARL loc_0x011ADC ; 1e8cd
	LD NB,#00h ; 1e8d0
	CARL loc_0x002BF9 ; 1e8d3
	LD NB,#07h ; 1e8d6
	CARL loc_0x0382F4 ; 1e8d9
	LD IY,#0E89Eh ; 1e8dc
	LD YP,#01h ; 1e8df
	CARL loc_0x002D72 ; 1e8e2
	LD A,#00h ; 1e8e5
	LD [164Dh],A ; 1e8e7
	LD A,#00h ; 1e8eb
	LD [1BA4h],A ; 1e8ed
	XOR A,A ; 1e8f1
	LD [1BA5h],A ; 1e8f2
	LD A,[1AD5h] ; 1e8f6
	LD [1BA8h],A ; 1e8fa
	XOR A,A ; 1e8fe
	LD [1BAAh],A ; 1e8ff
	LD IY,#0A35Fh ; 1e903
	LD NB,#07h ; 1e906
	CARL loc_0x03836A ; 1e909
	LD IY,#13AEh ; 1e90c
	LD NB,#02h ; 1e90f
	CARL loc_0x011B84 ; 1e912
	CARL loc_0x00233F ; 1e915
	CARL loc_0x0021FB ; 1e918
	RET
; ---------------------- ; 1e91b
	DB 0F2h, 0D3h, 0A0h, 0F2h, 25h, 3Ah, 0F8h, 07h ; 1e91c
	DB 04h, 3Eh, 00h ; 1e924
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
	DB 0F8h
; ---------------------- ; 1e979
loc_0x01E97A:
	LD IX,#7ED8h ; 1e97a
	LD XP,#03h ; 1e97d
	CARL loc_0x002642 ; 1e980
	LD HL,#0E98Ch ; 1e983
	LD B,#03h ; 1e986
	CARL loc_0x00227C ; 1e988
	RET
; ---------------------- ; 1e98b
loc_0x01E98C:
	CARL loc_0x002346 ; 1e98c
	LD A,[1643h] ; 1e98f
	BIT A,#01h ; 1e993
	JRS NZ,loc_0x01E99C ; 1e995
	BIT A,#02h ; 1e997
	JRS NZ,loc_0x01E9AD ; 1e999
	RET
; ---------------------- ; 1e99b
loc_0x01E99C:
	LD A,[1AB6h] ; 1e99c
	AND A,A ; 1e9a0
	JRS Z,loc_0x01E9A9 ; 1e9a1
	LD A,#01h ; 1e9a3
	LD [14FAh],A ; 1e9a5
loc_0x01E9A9:
	CARL loc_0x01E9C3 ; 1e9a9
	RET
; ---------------------- ; 1e9ac
loc_0x01E9AD:
	LD A,[1AB6h] ; 1e9ad
	AND A,A ; 1e9b1
	JRS Z,loc_0x01E9BA ; 1e9b2
	LD A,#02h ; 1e9b4
	LD [14FAh],A ; 1e9b6
loc_0x01E9BA:
	LD HL,#9CACh ; 1e9ba
	LD B,#03h ; 1e9bd
	CARL loc_0x00228F ; 1e9bf
	RET
; ---------------------- ; 1e9c2
loc_0x01E9C3:
	LD IX,#7F38h ; 1e9c3
	LD XP,#03h ; 1e9c6
	CARL loc_0x002642 ; 1e9c9
	LD HL,#0E9D5h ; 1e9cc
	LD B,#03h ; 1e9cf
	CARL loc_0x00227C ; 1e9d1
	RET
; ---------------------- ; 1e9d4
loc_0x01E9D5:
	LD B,#18h ; 1e9d5
loc_0x01E9D7:
	PUSH B ; 1e9d7
	CARL loc_0x002346 ; 1e9d9
	POP B ; 1e9dc
	LD A,[1643h] ; 1e9de
	BIT A,#02h ; 1e9e2
	JRS NZ,loc_0x01EA56 ; 1e9e4
	DJR NZ,loc_0x01E9D7 ; 1e9e6
	CARL loc_0x005686 ; 1e9e8
	LD B,#4Bh ; 1e9eb
loc_0x01E9ED:
	PUSH B ; 1e9ed
	LD A,#01h ; 1e9ef
	LD B,#00h ; 1e9f1
	CARL loc_0x005786 ; 1e9f3
	POP B ; 1e9f6
	CP A,#00h ; 1e9f8
	JRS Z,loc_0x01EA05 ; 1e9fa
	CARL loc_0x01ED73 ; 1e9fc
	JRS NZ,loc_0x01EA56 ; 1e9ff
	DJR NZ,loc_0x01E9ED ; 1ea01
	JRS loc_0x01EA67
; ---------------------- ; 1ea03
loc_0x01EA05:
	LD B,#32h ; 1ea05
loc_0x01EA07:
	PUSH B ; 1ea07
	LD A,#01h ; 1ea09
	LD B,#10h ; 1ea0b
	LD IX,#0ED9Ah ; 1ea0d
	LD XP,#01h ; 1ea10
	CARL loc_0x005786 ; 1ea13
	POP B ; 1ea16
	CP A,#00h ; 1ea18
	JRS Z,loc_0x01EA25 ; 1ea1a
	CARL loc_0x01ED73 ; 1ea1c
	JRS NZ,loc_0x01EA56 ; 1ea1f
	DJR NZ,loc_0x01EA07 ; 1ea21
	JRS loc_0x01EA67
; ---------------------- ; 1ea23
loc_0x01EA25:
	LD B,#32h ; 1ea25
loc_0x01EA27:
	PUSH B ; 1ea27
	LD A,#01h ; 1ea29
	LD B,#01h ; 1ea2b
	LD IX,#1BC9h ; 1ea2d
	LD XP,#00h ; 1ea30
	CARL loc_0x005786 ; 1ea33
	POP B ; 1ea36
	CP A,#00h ; 1ea38
	JRS Z,loc_0x01EA45 ; 1ea3a
	CARL loc_0x01ED73 ; 1ea3c
	JRS NZ,loc_0x01EA56 ; 1ea3f
	DJR NZ,loc_0x01EA27 ; 1ea41
	JRS loc_0x01EA67
; ---------------------- ; 1ea43
loc_0x01EA45:
	LD A,[1AB6h] ; 1ea45
	AND A,A ; 1ea49
	JRS Z,loc_0x01EA52 ; 1ea4a
	LD A,#01h ; 1ea4c
	LD [14FAh],A ; 1ea4e
loc_0x01EA52:
	CARL loc_0x01EA78 ; 1ea52
	RET
; ---------------------- ; 1ea55
loc_0x01EA56:
	LD A,[1AB6h] ; 1ea56
	AND A,A ; 1ea5a
	JRS Z,loc_0x01EA63 ; 1ea5b
	LD A,#02h ; 1ea5d
	LD [14FAh],A ; 1ea5f
loc_0x01EA63:
	CARL loc_0x01EACC ; 1ea63
	RET
; ---------------------- ; 1ea66
loc_0x01EA67:
	LD A,[1AB6h] ; 1ea67
	AND A,A ; 1ea6b
	JRS Z,loc_0x01EA74 ; 1ea6c
	LD A,#03h ; 1ea6e
	LD [14FAh],A ; 1ea70
loc_0x01EA74:
	CARL loc_0x01EB1A ; 1ea74
	RET
; ---------------------- ; 1ea77
loc_0x01EA78:
	LD IX,#7FF8h ; 1ea78
	LD XP,#03h ; 1ea7b
	CARL loc_0x002642 ; 1ea7e
	LD HL,#0EA90h ; 1ea81
	LD B,#03h ; 1ea84
	CARL loc_0x00227C ; 1ea86
	LD NB,#03h ; 1ea89
	CARL loc_0x019B89 ; 1ea8c
	RET
; ---------------------- ; 1ea8f
loc_0x01EA90:
	CARL loc_0x002346 ; 1ea90
	LD A,[1643h] ; 1ea93
	BIT A,#01h ; 1ea97
	JRS NZ,loc_0x01EAA0 ; 1ea99
	BIT A,#02h ; 1ea9b
	JRS NZ,loc_0x01EAB6 ; 1ea9d
	RET
; ---------------------- ; 1ea9f
loc_0x01EAA0:
	LD A,[1AB6h] ; 1eaa0
	AND A,A ; 1eaa4
	JRS Z,loc_0x01EAAD ; 1eaa5
	LD A,#01h ; 1eaa7
	LD [14FAh],A ; 1eaa9
loc_0x01EAAD:
	LD HL,#97C1h ; 1eaad
	LD B,#03h ; 1eab0
	CARL loc_0x00228F ; 1eab2
	RET
; ---------------------- ; 1eab5
loc_0x01EAB6:
	LD A,[1AB6h] ; 1eab6
	AND A,A ; 1eaba
	JRS Z,loc_0x01EAC3 ; 1eabb
	LD A,#02h ; 1eabd
	LD [14FAh],A ; 1eabf
loc_0x01EAC3:
	LD HL,#97C1h ; 1eac3
	LD B,#03h ; 1eac6
	CARL loc_0x00228F ; 1eac8
	RET
; ---------------------- ; 1eacb
loc_0x01EACC:
	LD IX,#80B8h ; 1eacc
	LD XP,#03h ; 1eacf
	CARL loc_0x002642 ; 1ead2
	LD HL,#0EADEh ; 1ead5
	LD B,#03h ; 1ead8
	CARL loc_0x00227C ; 1eada
	RET
; ---------------------- ; 1eadd
loc_0x01EADE:
	CARL loc_0x002346 ; 1eade
	LD A,[1643h] ; 1eae1
	BIT A,#01h ; 1eae5
	JRS NZ,loc_0x01EAEE ; 1eae7
	BIT A,#02h ; 1eae9
	JRS NZ,loc_0x01EB04 ; 1eaeb
	RET
; ---------------------- ; 1eaed
loc_0x01EAEE:
	LD A,[1AB6h] ; 1eaee
	AND A,A ; 1eaf2
	JRS Z,loc_0x01EAFB ; 1eaf3
	LD A,#01h ; 1eaf5
	LD [14FAh],A ; 1eaf7
loc_0x01EAFB:
	LD HL,#97C1h ; 1eafb
	LD B,#03h ; 1eafe
	CARL loc_0x00228F ; 1eb00
	RET
; ---------------------- ; 1eb03
loc_0x01EB04:
	LD A,[1AB6h] ; 1eb04
	AND A,A ; 1eb08
	JRS Z,loc_0x01EB11 ; 1eb09
	LD A,#02h ; 1eb0b
	LD [14FAh],A ; 1eb0d
loc_0x01EB11:
	LD HL,#97C1h ; 1eb11
	LD B,#03h ; 1eb14
	CARL loc_0x00228F ; 1eb16
	RET
; ---------------------- ; 1eb19
loc_0x01EB1A:
	LD IX,#8058h ; 1eb1a
	LD XP,#03h ; 1eb1d
	CARL loc_0x002642 ; 1eb20
	LD HL,#0EB2Ch ; 1eb23
	LD B,#03h ; 1eb26
	CARL loc_0x00227C ; 1eb28
	RET
; ---------------------- ; 1eb2b
loc_0x01EB2C:
	CARL loc_0x002346 ; 1eb2c
	LD A,[1643h] ; 1eb2f
	BIT A,#01h ; 1eb33
	JRS NZ,loc_0x01EB3C ; 1eb35
	BIT A,#02h ; 1eb37
	JRS NZ,loc_0x01EB4D ; 1eb39
	RET
; ---------------------- ; 1eb3b
loc_0x01EB3C:
	LD A,[1AB6h] ; 1eb3c
	AND A,A ; 1eb40
	JRS Z,loc_0x01EB49 ; 1eb41
	LD A,#01h ; 1eb43
	LD [14FAh],A ; 1eb45
loc_0x01EB49:
	CARL loc_0x01E97A ; 1eb49
	RET
; ---------------------- ; 1eb4c
loc_0x01EB4D:
	LD A,[1AB6h] ; 1eb4d
	AND A,A ; 1eb51
	JRS Z,loc_0x01EB5A ; 1eb52
	LD A,#02h ; 1eb54
	LD [14FAh],A ; 1eb56
loc_0x01EB5A:
	LD HL,#97C1h ; 1eb5a
	LD B,#03h ; 1eb5d
	CARL loc_0x00228F ; 1eb5f
	RET
; ---------------------- ; 1eb62
	DB 07h, 04h, 3Eh, 00h ; 1eb63
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
	DB 16h, 95h, 04h, 0E7h, 02h, 0F8h
; ---------------------- ; 1ebbf
loc_0x01EBC5:
	LD IX,#7F98h ; 1ebc5
	LD XP,#03h ; 1ebc8
	CARL loc_0x002642 ; 1ebcb
	LD HL,#0EBD7h ; 1ebce
	LD B,#03h ; 1ebd1
	CARL loc_0x00227C ; 1ebd3
	RET
; ---------------------- ; 1ebd6
loc_0x01EBD7:
	LD B,#18h ; 1ebd7
loc_0x01EBD9:
	PUSH B ; 1ebd9
	CARL loc_0x002346 ; 1ebdb
	POP B ; 1ebde
	LD A,[1643h] ; 1ebe0
	BIT A,#02h ; 1ebe4
	JRS NZ,loc_0x01EC66 ; 1ebe6
	DJR NZ,loc_0x01EBD9 ; 1ebe8
	CARL loc_0x005686 ; 1ebea
	LD B,#0B5h ; 1ebed
loc_0x01EBEF:
	PUSH B ; 1ebef
	LD A,#00h ; 1ebf1
	LD IY,#0FFFh ; 1ebf3
	CARL loc_0x005842 ; 1ebf6
	POP B ; 1ebf9
	CP A,#00h ; 1ebfb
	JRS Z,loc_0x01EC08 ; 1ebfd
	CARL loc_0x01ED73 ; 1ebff
	JRS NZ,loc_0x01EC66 ; 1ec02
	DJR NZ,loc_0x01EBEF ; 1ec04
	JRS loc_0x01EC77
; ---------------------- ; 1ec06
loc_0x01EC08:
	LD B,#32h ; 1ec08
loc_0x01EC0A:
	PUSH B ; 1ec0a
	LD A,#10h ; 1ec0c
	LD IX,#1BB9h ; 1ec0e
	LD XP,#00h ; 1ec11
	LD IY,#0FFFh ; 1ec14
	CARL loc_0x005842 ; 1ec17
	POP B ; 1ec1a
	CP A,#00h ; 1ec1c
	JRS Z,loc_0x01EC29 ; 1ec1e
	CARL loc_0x01ED73 ; 1ec20
	JRS NZ,loc_0x01EC66 ; 1ec23
	DJR NZ,loc_0x01EC0A ; 1ec25
	JRS loc_0x01EC77
; ---------------------- ; 1ec27
loc_0x01EC29:
	LD IX,#0ED9Ah ; 1ec29
	LD XP,#01h ; 1ec2c
	CARL loc_0x01ED87 ; 1ec2f
	JRS NZ,loc_0x01EC77 ; 1ec32
	LD B,#32h ; 1ec34
loc_0x01EC36:
	PUSH B ; 1ec36
	LD A,#01h ; 1ec38
	LD IX,#1BC9h ; 1ec3a
	LD XP,#00h ; 1ec3d
	LD IY,#0FFFh ; 1ec40
	CARL loc_0x005842 ; 1ec43
	POP B ; 1ec46
	CP A,#00h ; 1ec48
	JRS Z,loc_0x01EC55 ; 1ec4a
	CARL loc_0x01ED73 ; 1ec4c
	JRS NZ,loc_0x01EC66 ; 1ec4f
	DJR NZ,loc_0x01EC36 ; 1ec51
	JRS loc_0x01EC77
; ---------------------- ; 1ec53
loc_0x01EC55:
	LD A,[1AB6h] ; 1ec55
	AND A,A ; 1ec59
	JRS Z,loc_0x01EC62 ; 1ec5a
	LD A,#01h ; 1ec5c
	LD [14FAh],A ; 1ec5e
loc_0x01EC62:
	CARL loc_0x01EC88 ; 1ec62
	RET
; ---------------------- ; 1ec65
loc_0x01EC66:
	LD A,[1AB6h] ; 1ec66
	AND A,A ; 1ec6a
	JRS Z,loc_0x01EC73 ; 1ec6b
	LD A,#02h ; 1ec6d
	LD [14FAh],A ; 1ec6f
loc_0x01EC73:
	CARL loc_0x01ECDC ; 1ec73
	RET
; ---------------------- ; 1ec76
loc_0x01EC77:
	LD A,[1AB6h] ; 1ec77
	AND A,A ; 1ec7b
	JRS Z,loc_0x01EC84 ; 1ec7c
	LD A,#03h ; 1ec7e
	LD [14FAh],A ; 1ec80
loc_0x01EC84:
	CARL loc_0x01ED2A ; 1ec84
	RET
; ---------------------- ; 1ec87
loc_0x01EC88:
	LD IX,#7FF8h ; 1ec88
	LD XP,#03h ; 1ec8b
	CARL loc_0x002642 ; 1ec8e
	LD HL,#0ECA0h ; 1ec91
	LD B,#03h ; 1ec94
	CARL loc_0x00227C ; 1ec96
	LD NB,#03h ; 1ec99
	CARL loc_0x019BA0 ; 1ec9c
	RET
; ---------------------- ; 1ec9f
loc_0x01ECA0:
	CARL loc_0x002346 ; 1eca0
	LD A,[1643h] ; 1eca3
	BIT A,#01h ; 1eca7
	JRS NZ,loc_0x01ECB0 ; 1eca9
	BIT A,#02h ; 1ecab
	JRS NZ,loc_0x01ECC6 ; 1ecad
	RET
; ---------------------- ; 1ecaf
loc_0x01ECB0:
	LD A,[1AB6h] ; 1ecb0
	AND A,A ; 1ecb4
	JRS Z,loc_0x01ECBD ; 1ecb5
	LD A,#01h ; 1ecb7
	LD [14FAh],A ; 1ecb9
loc_0x01ECBD:
	LD HL,#9B18h ; 1ecbd
	LD B,#03h ; 1ecc0
	CARL loc_0x00228F ; 1ecc2
	RET
; ---------------------- ; 1ecc5
loc_0x01ECC6:
	LD A,[1AB6h] ; 1ecc6
	AND A,A ; 1ecca
	JRS Z,loc_0x01ECD3 ; 1eccb
	LD A,#02h ; 1eccd
	LD [14FAh],A ; 1eccf
loc_0x01ECD3:
	LD HL,#9B18h ; 1ecd3
	LD B,#03h ; 1ecd6
	CARL loc_0x00228F ; 1ecd8
	RET
; ---------------------- ; 1ecdb
loc_0x01ECDC:
	LD IX,#80B8h ; 1ecdc
	LD XP,#03h ; 1ecdf
	CARL loc_0x002642 ; 1ece2
	LD HL,#0ECEEh ; 1ece5
	LD B,#03h ; 1ece8
	CARL loc_0x00227C ; 1ecea
	RET
; ---------------------- ; 1eced
loc_0x01ECEE:
	CARL loc_0x002346 ; 1ecee
	LD A,[1643h] ; 1ecf1
	BIT A,#01h ; 1ecf5
	JRS NZ,loc_0x01ECFE ; 1ecf7
	BIT A,#02h ; 1ecf9
	JRS NZ,loc_0x01ED14 ; 1ecfb
	RET
; ---------------------- ; 1ecfd
loc_0x01ECFE:
	LD A,[1AB6h] ; 1ecfe
	AND A,A ; 1ed02
	JRS Z,loc_0x01ED0B ; 1ed03
	LD A,#01h ; 1ed05
	LD [14FAh],A ; 1ed07
loc_0x01ED0B:
	LD HL,#97C1h ; 1ed0b
	LD B,#03h ; 1ed0e
	CARL loc_0x00228F ; 1ed10
	RET
; ---------------------- ; 1ed13
loc_0x01ED14:
	LD A,[1AB6h] ; 1ed14
	AND A,A ; 1ed18
	JRS Z,loc_0x01ED21 ; 1ed19
	LD A,#02h ; 1ed1b
	LD [14FAh],A ; 1ed1d
loc_0x01ED21:
	LD HL,#97C1h ; 1ed21
	LD B,#03h ; 1ed24
	CARL loc_0x00228F ; 1ed26
	RET
; ---------------------- ; 1ed29
loc_0x01ED2A:
	LD IX,#8058h ; 1ed2a
	LD XP,#03h ; 1ed2d
	CARL loc_0x002642 ; 1ed30
	LD HL,#0ED3Ch ; 1ed33
	LD B,#03h ; 1ed36
	CARL loc_0x00227C ; 1ed38
	RET
; ---------------------- ; 1ed3b
loc_0x01ED3C:
	CARL loc_0x002346 ; 1ed3c
	LD A,[1643h] ; 1ed3f
	BIT A,#01h ; 1ed43
	JRS NZ,loc_0x01ED4C ; 1ed45
	BIT A,#02h ; 1ed47
	JRS NZ,loc_0x01ED5D ; 1ed49
	RET
; ---------------------- ; 1ed4b
loc_0x01ED4C:
	LD A,[1AB6h] ; 1ed4c
	AND A,A ; 1ed50
	JRS Z,loc_0x01ED59 ; 1ed51
	LD A,#01h ; 1ed53
	LD [14FAh],A ; 1ed55
loc_0x01ED59:
	CARL loc_0x01EBC5 ; 1ed59
	RET
; ---------------------- ; 1ed5c
loc_0x01ED5D:
	LD A,[1AB6h] ; 1ed5d
	AND A,A ; 1ed61
	JRS Z,loc_0x01ED6A ; 1ed62
	LD A,#02h ; 1ed64
	LD [14FAh],A ; 1ed66
loc_0x01ED6A:
	LD HL,#97C1h ; 1ed6a
	LD B,#03h ; 1ed6d
	CARL loc_0x00228F ; 1ed6f
	RET
; ---------------------- ; 1ed72
loc_0x01ED73:
	PUSH ALE ; 1ed73
	CARL loc_0x002987 ; 1ed75
	LD NB,#00h ; 1ed78
	CARL loc_0x00235D ; 1ed7b
	LD A,[163Dh] ; 1ed7e
	BIT A,#02h ; 1ed82
	POP ALE ; 1ed84
	RET
; ---------------------- ; 1ed86
loc_0x01ED87:
	LD HL,#1BB9h ; 1ed87
	LD B,#10h ; 1ed8a
loc_0x01ED8C:
	CP [HL],[IX] ; 1ed8c
	JRS NZ,loc_0x01ED96 ; 1ed8e
	INC HL ; 1ed90
	INC IX ; 1ed91
	DJR NZ,loc_0x01ED8C ; 1ed92
	XOR A,A ; 1ed94
	RET
; ---------------------- ; 1ed95
loc_0x01ED96:
	LD A,#0FFh ; 1ed96
	AND A,A ; 1ed98
	RET
; ---------------------- ; 1ed99
	DB 0BFh, 0C0h, 0DEh, 0C3h, 0D4h, 0BBh, 0DDh, 20h ; 1ed9a
	DB 0B1h, 0B2h, 0C3h, 0D1h, 0BAh, 0B3h, 0B6h, 0DDh
; ---------------------- ; 1eda2
loc_0x01EDAA:
	PUSH ALE ; 1edaa
	LD A,[IX] ; 1edac
	BIT A,#80h ; 1edad
	JRS NZ,loc_0x01EDB5 ; 1edaf
	LD A,#00h ; 1edb1
	JRS loc_0x01EDB7
; ---------------------- ; 1edb3
loc_0x01EDB5:
	LD A,#01h ; 1edb5
loc_0x01EDB7:
	LD [1D89h],A ; 1edb7
	PUSH IX ; 1edbb
	PUSH HL ; 1edbc
	LD HL,IX ; 1edbd
	LD IX,#1D8Bh ; 1edbf
	LD [IX],H ; 1edc2
	INC IX ; 1edc3
	LD [IX],L ; 1edc4
	POP HL ; 1edc5
	LD IX,#1D8Dh ; 1edc6
	LD [IX],H ; 1edc9
	INC IX ; 1edca
	LD [IX],L ; 1edcb
	POP IX ; 1edcc
	LD HL,#1D8Fh ; 1edcd
	LD [HL],#08h ; 1edd0
	INC HL ; 1edd2
	LD A,#00h ; 1edd3
	LD [HL],A ; 1edd5
	INC HL ; 1edd6
	LD [HL],A ; 1edd7
	INC HL ; 1edd8
	LD [HL],A ; 1edd9
loc_0x01EDDA:
	LD B,#08h ; 1edda
loc_0x01EDDC:
	LD A,[IX] ; 1eddc
	SLA A ; 1eddd
	LD [IX],A ; 1eddf
	JRS C,loc_0x01EDE6 ; 1ede0
	LD A,#00h ; 1ede2
	JRS loc_0x01EDE8
; ---------------------- ; 1ede4
loc_0x01EDE6:
	LD A,#01h ; 1ede6
loc_0x01EDE8:
	PUSH B ; 1ede8
	CARS loc_0x01EE44 ; 1edea
	POP B ; 1edec
	LD HL,#1D90h ; 1edee
	INC [HL] ; 1edf1
	JRS NZ,loc_0x01EDF7 ; 1edf2
	LD A,#0FFh ; 1edf4
	LD [HL],A ; 1edf6
loc_0x01EDF7:
	DJR NZ,loc_0x01EDDC ; 1edf7
	INC IX ; 1edf9
	LD HL,#1D8Eh ; 1edfa
	DEC [HL] ; 1edfd
	JRS NZ,loc_0x01EDDA ; 1edfe
	DEC HL ; 1ee00
	LD A,[HL] ; 1ee01
	AND A,A ; 1ee02
	JRS Z,loc_0x01EE08 ; 1ee03
	DEC [HL] ; 1ee05
	JRS loc_0x01EDDA
; ---------------------- ; 1ee06
loc_0x01EE08:
	LD A,[1D90h] ; 1ee08
	CARS loc_0x01EE8C ; 1ee0c
	LD HL,#1D8Ah ; 1ee0e
	LD B,[HL] ; 1ee11
	SLA B ; 1ee12
	OR A,B ; 1ee14
	LD [HL],A ; 1ee15
	LD HL,#1D8Fh ; 1ee16
	DEC [HL] ; 1ee19
	JRS Z,loc_0x01EE26 ; 1ee1a
	LD B,[HL] ; 1ee1c
	LD HL,#1D8Ah ; 1ee1d
	LD A,[HL] ; 1ee20
loc_0x01EE21:
	SLA A ; 1ee21
	DJR NZ,loc_0x01EE21 ; 1ee23
	LD [HL],A ; 1ee25
loc_0x01EE26:
	LD HL,#1D8Bh ; 1ee26
	LD A,[HL] ; 1ee29
	INC HL ; 1ee2a
	LD L,[HL] ; 1ee2b
	LD H,A ; 1ee2c
	LD A,[1D8Ah] ; 1ee2d
	LD [HL],A ; 1ee31
	LD HL,#1D92h ; 1ee32
	INC [HL] ; 1ee35
	JRS NZ,loc_0x01EE3A ; 1ee36
	DEC HL ; 1ee38
	INC [HL] ; 1ee39
loc_0x01EE3A:
	POP ALE ; 1ee3a
	LD HL,#1D91h ; 1ee3c
	LD A,[HL] ; 1ee3f
	INC HL ; 1ee40
	LD L,[HL] ; 1ee41
	LD H,A ; 1ee42
	RET
; ---------------------- ; 1ee43
loc_0x01EE44:
	LD HL,#1D89h ; 1ee44
	LD B,[HL] ; 1ee47
	CP A,B ; 1ee48
	JRS NZ,loc_0x01EE4C ; 1ee49
	RET
; ---------------------- ; 1ee4b
loc_0x01EE4C:
	LD A,B ; 1ee4c
	XOR A,#01h ; 1ee4d
	LD [HL],A ; 1ee4f
	LD A,[1D90h] ; 1ee50
	CARS loc_0x01EE8C ; 1ee54
	LD B,A ; 1ee56
	LD A,#00h ; 1ee57
	LD [1D90h],A ; 1ee59
	LD HL,#1D8Ah ; 1ee5d
	LD A,[HL] ; 1ee60
	SLA A ; 1ee61
	OR A,B ; 1ee63
	LD [HL],A ; 1ee64
	LD HL,#1D8Fh ; 1ee65
	DEC [HL] ; 1ee68
	JRS NZ,loc_0x01EE8B ; 1ee69
	LD A,#08h ; 1ee6b
	LD [HL],A ; 1ee6d
	LD HL,#1D8Bh ; 1ee6e
	LD A,[HL] ; 1ee71
	INC HL ; 1ee72
	LD L,[HL] ; 1ee73
	LD H,A ; 1ee74
	LD A,[1D8Ah] ; 1ee75
	LD [HL],A ; 1ee79
	INC HL ; 1ee7a
	LD A,H ; 1ee7b
	LD B,L ; 1ee7c
	LD HL,#1D8Bh ; 1ee7d
	LD [HL],A ; 1ee80
	INC HL ; 1ee81
	LD [HL],B ; 1ee82
	LD HL,#1D92h ; 1ee83
	INC [HL] ; 1ee86
	JRS NZ,loc_0x01EE8B ; 1ee87
	DEC HL ; 1ee89
	INC [HL] ; 1ee8a
loc_0x01EE8B:
	RET
; ---------------------- ; 1ee8b
loc_0x01EE8C:
	PUSH H ; 1ee8c
	PUSH IY ; 1ee8e
	LD B,#05h ; 1ee8f
loc_0x01EE91:
	LD H,[IY] ; 1ee91
	CP H,#00h ; 1ee92
	JRS Z,loc_0x01EE9D ; 1ee95
	CP A,[IY] ; 1ee97
	JRS Z,loc_0x01EEA1 ; 1ee98
	INC IY ; 1ee9a
	DJR NZ,loc_0x01EE91 ; 1ee9b
loc_0x01EE9D:
	LD A,#00h ; 1ee9d
	JRS loc_0x01EEA3
; ---------------------- ; 1ee9f
loc_0x01EEA1:
	LD A,#01h ; 1eea1
loc_0x01EEA3:
	POP IY ; 1eea3
	POP H ; 1eea4
	RET
; ---------------------- ; 1eea6
loc_0x01EEA7:
	LD BR,#20h ; 1eea7
	LD EP,#00h ; 1eea9
	LD [BR:60h],#32h ; 1eeac
	LD [BR:61h],#00h ; 1eeaf
	AND [BR:26h],#7Fh ; 1eeb2
	LD B,#0C8h ; 1eeb5
loc_0x01EEB7:
	NOP ; 1eeb7
	NOP ; 1eeb8
	NOP ; 1eeb9
	DEC B ; 1eeba
	JRS NZ,loc_0x01EEB7 ; 1eebb
	LD A,#00h ; 1eebd
	LD [1BCAh],A ; 1eebf
	LD [1D88h],A ; 1eec3
	RET
; ---------------------- ; 1eec7
loc_0x01EEC8:
	LD A,A ; 1eec8
	DEC A ; 1eec9
	DEC A ; 1eeca
loc_0x01EECB:
	NOP ; 1eecb
	NOP ; 1eecc
	NOP ; 1eecd
	DEC A ; 1eece
	JRS NZ,loc_0x01EECB ; 1eecf
	NOP ; 1eed1
	LD A,A ; 1eed2
	RET
; ---------------------- ; 1eed3
loc_0x01EED4:
	LD EP,#00h ; 1eed4
	LD A,#01h ; 1eed7
	LD [1BCAh],A ; 1eed9
	LD BR,#20h ; 1eedd
	LD XP,#00h ; 1eedf
	LD YP,#00h ; 1eee2
	LD IX,#1BCBh ; 1eee5
	LD HL,#01C8h ; 1eee8
	LD A,#00h ; 1eeeb
loc_0x01EEED:
	LD [IX],A ; 1eeed
	INC IX ; 1eeee
	DEC HL ; 1eeef
	JRS NZ,loc_0x01EEED ; 1eef0
	LD IY,#0000h ; 1eef2
	CARL loc_0x01F0DE ; 1eef5
	CP A,#0FFh ; 1eef8
	JRL Z,loc_0x01F0D5 ; 1eefa
	CARL loc_0x01F10C ; 1eefd
	CP A,#01h ; 1ef00
	JRL Z,loc_0x01F0A8 ; 1ef02
	CP A,#02h ; 1ef05
	JRL Z,loc_0x01F0B1 ; 1ef07
	CP A,#10h ; 1ef0a
	JRL Z,loc_0x01F0CC ; 1ef0c
	CP A,#0FFh ; 1ef0f
	JRL Z,loc_0x01F0D5 ; 1ef11
	LD XP,#00h ; 1ef14
	LD IX,#1BCBh ; 1ef17
	LD IY,#00C8h ; 1ef1a
	CARL loc_0x01F165 ; 1ef1d
	LD [1D5Bh],IY ; 1ef20
	CP IY,#00C8h ; 1ef23
	JRL Z,loc_0x01EF50 ; 1ef26
	LD IY,#1A0Ah ; 1ef29
	CARL loc_0x01F0DE ; 1ef2c
	CP A,#10h ; 1ef2f
	JRL Z,loc_0x01EF61 ; 1ef31
	CP A,#0FFh ; 1ef34
	JRL Z,loc_0x01F0D5 ; 1ef36
	CARL loc_0x01F10C ; 1ef39
	CP A,#01h ; 1ef3c
	JRL Z,loc_0x01F0A8 ; 1ef3e
	CP A,#02h ; 1ef41
	JRL Z,loc_0x01F0B1 ; 1ef43
	CP A,#10h ; 1ef46
	JRL Z,loc_0x01EF61 ; 1ef48
	CP A,#0FFh ; 1ef4b
	JRL Z,loc_0x01F0D5 ; 1ef4d
loc_0x01EF50:
	LD XP,#00h ; 1ef50
	LD IX,#1C93h ; 1ef53
	LD IY,#00C8h ; 1ef56
	CARL loc_0x01F165 ; 1ef59
	LD [1D5Dh],IY ; 1ef5c
	JRS loc_0x01EF67
; ---------------------- ; 1ef5f
loc_0x01EF61:
	LD A,#81h ; 1ef61
	LD [1D88h],A ; 1ef63
loc_0x01EF67:
	LD IY,[1D5Bh] ; 1ef67
	LD XP,#00h ; 1ef6a
	LD IX,#1BCBh ; 1ef6d
	CARL loc_0x01F1C1 ; 1ef70
	LD XP,#00h ; 1ef73
	LD IX,#1BCBh ; 1ef76
	LD IY,[1D5Bh] ; 1ef79
	LD HL,#1D5Fh ; 1ef7c
	CARL loc_0x01F224 ; 1ef7f
	LD L,#1Dh ; 1ef82
	LD XP,#00h ; 1ef84
	LD IX,#1D5Fh ; 1ef87
	LD YP,#00h ; 1ef8a
	LD IY,#1D7Dh ; 1ef8d
	CARL loc_0x01F286 ; 1ef90
	CP A,#01h ; 1ef93
	JRL Z,loc_0x01F0C3 ; 1ef95
	LD IX,#1BCBh ; 1ef98
	LD IY,#1D7Dh ; 1ef9b
	LD HL,[1D5Bh] ; 1ef9e
	CARL loc_0x01EDAA ; 1efa1
	LD [1D5Bh],HL ; 1efa4
	LD XP,#00h ; 1efa7
	LD IX,#1BCBh ; 1efaa
	LD IY,[1D5Bh] ; 1efad
	CARL loc_0x01F2C3 ; 1efb0
	LD [1D84h],HL ; 1efb3
	LD IX,#1BCBh ; 1efb6
	LD B,[1D5Bh] ; 1efb9
	CARL loc_0x01F32B ; 1efbd
	LD BA,[1D84h] ; 1efc0
	ADD HL,BA ; 1efc3
	LD [1D84h],HL ; 1efc5
	LD A,[1D88h] ; 1efc8
	CP A,#80h ; 1efcc
	JRL NC,loc_0x01F06A ; 1efce
	LD IY,[1D5Dh] ; 1efd1
	LD XP,#00h ; 1efd4
	LD IX,#1C93h ; 1efd7
	CARL loc_0x01F1C1 ; 1efda
	LD IX,#1D5Fh ; 1efdd
	LD A,#00h ; 1efe0
	LD L,#00h ; 1efe2
loc_0x01EFE4:
	LD [IX+L],A ; 1efe4
	INC L ; 1efe6
	CP L,#1Eh ; 1efe7
	JRS NZ,loc_0x01EFE4 ; 1efea
	LD IX,#1C93h ; 1efec
	LD IY,[1D5Dh] ; 1efef
	LD HL,#1D5Fh ; 1eff2
	CARL loc_0x01F224 ; 1eff5
	LD IX,#1D5Fh ; 1eff8
	LD L,#00h ; 1effb
	LD A,#00h ; 1effd
loc_0x01EFFF:
	LD B,[IX+L] ; 1efff
	ADD A,B ; 1f001
	INC L ; 1f002
	CP L,#1Eh ; 1f003
	JRS NZ,loc_0x01EFFF ; 1f006
	CP A,#04h ; 1f008
	JRS NC,loc_0x01F015 ; 1f00a
	LD A,#81h ; 1f00c
	LD [1D88h],A ; 1f00e
	JRL loc_0x01F06A
; ---------------------- ; 1f012
loc_0x01F015:
	LD IX,#1D7Dh ; 1f015
	LD A,#00h ; 1f018
	LD L,#00h ; 1f01a
loc_0x01F01C:
	LD [IX+L],A ; 1f01c
	INC L ; 1f01e
	CP L,#05h ; 1f01f
	JRS NZ,loc_0x01F01C ; 1f022
	LD L,#1Dh ; 1f024
	LD XP,#00h ; 1f026
	LD IX,#1D5Fh ; 1f029
	LD YP,#00h ; 1f02c
	LD IY,#1D7Dh ; 1f02f
	CARL loc_0x01F286 ; 1f032
	CP A,#01h ; 1f035
	JRL Z,loc_0x01F0C3 ; 1f037
	LD IX,#1C93h ; 1f03a
	LD IY,#1D7Dh ; 1f03d
	LD HL,[1D5Dh] ; 1f040
	CARL loc_0x01EDAA ; 1f043
	LD [1D5Dh],HL ; 1f046
	LD XP,#00h ; 1f049
	LD IX,#1C93h ; 1f04c
	LD IY,[1D5Dh] ; 1f04f
	CARL loc_0x01F2C3 ; 1f052
	LD [1D86h],HL ; 1f055
	LD IX,#1C93h ; 1f058
	LD B,[1D5Dh] ; 1f05b
	CARL loc_0x01F32B ; 1f05f
	LD BA,[1D86h] ; 1f062
	ADD HL,BA ; 1f065
	LD [1D86h],HL ; 1f067
loc_0x01F06A:
	LD XP,#00h ; 1f06a
	LD IX,#1BCBh ; 1f06d
	LD IY,[1D5Bh] ; 1f070
	LD HL,#0FFFFh ; 1f073
	CARL loc_0x01F2E1 ; 1f076
	LD A,[1D88h] ; 1f079
	CP A,#80h ; 1f07d
	JRS NC,loc_0x01F09C ; 1f07f
	LD BA,[1D84h] ; 1f081
	LD IX,[1D86h] ; 1f084
	CP BA,IX ; 1f087
	JRS Z,loc_0x01F09C ; 1f089
	LD XP,#00h ; 1f08b
	LD IX,#1C93h ; 1f08e
	LD IY,[1D5Dh] ; 1f091
	CARL loc_0x01F2E1 ; 1f094
	LD BA,[1D86h] ; 1f097
	ADD HL,BA ; 1f09a
loc_0x01F09C:
	LD BA,[1D84h] ; 1f09c
	ADD HL,BA ; 1f09f
	LD A,#00h ; 1f0a1
	LD [1BCAh],A ; 1f0a3
	RET
; ---------------------- ; 1f0a7
loc_0x01F0A8:
	LD A,#00h ; 1f0a8
	LD [1BCAh],A ; 1f0aa
	LD A,#01h ; 1f0ae
	RET
; ---------------------- ; 1f0b0
loc_0x01F0B1:
	LD A,#00h ; 1f0b1
	LD [1BCAh],A ; 1f0b3
	LD A,#02h ; 1f0b7
	RET
; ---------------------- ; 1f0b9
	DB 0B0h, 00h, 0CEh, 0D4h, 0CAh, 1Bh, 0B0h, 03h ; 1f0ba
	DB 0F8h
; ---------------------- ; 1f0c2
loc_0x01F0C3:
	LD A,#00h ; 1f0c3
	LD [1BCAh],A ; 1f0c5
	LD A,#10h ; 1f0c9
	RET
; ---------------------- ; 1f0cb
loc_0x01F0CC:
	LD A,#00h ; 1f0cc
	LD [1BCAh],A ; 1f0ce
	LD A,#20h ; 1f0d2
	RET
; ---------------------- ; 1f0d4
loc_0x01F0D5:
	LD A,#00h ; 1f0d5
	LD [1BCAh],A ; 1f0d7
	LD A,#0FFh ; 1f0db
	RET
; ---------------------- ; 1f0dd
loc_0x01F0DE:
	LD [BR:2Ah],#80h ; 1f0de
	LD A,#0FFh ; 1f0e1
	LD HL,#1BCAh ; 1f0e3
	CP IY,#0000h ; 1f0e6
	JRS Z,loc_0x01F0FA ; 1f0e9
loc_0x01F0EB:
	CP [HL],A ; 1f0eb
	JRS Z,loc_0x01F109 ; 1f0ed
	DEC IY ; 1f0ef
	JRS Z,loc_0x01F106 ; 1f0f0
	BIT [BR:2Ah],#80h ; 1f0f2
	JRS Z,loc_0x01F0EB ; 1f0f5
	LD A,#00h ; 1f0f7
	RET
; ---------------------- ; 1f0f9
loc_0x01F0FA:
	CP [HL],A ; 1f0fa
	JRS Z,loc_0x01F109 ; 1f0fc
	BIT [BR:2Ah],#80h ; 1f0fe
	JRS Z,loc_0x01F0FA ; 1f101
	LD A,#00h ; 1f103
	RET
; ---------------------- ; 1f105
loc_0x01F106:
	LD A,#10h ; 1f106
	RET
; ---------------------- ; 1f108
loc_0x01F109:
	LD A,#0FFh ; 1f109
	RET
; ---------------------- ; 1f10b
loc_0x01F10C:
	LD B,#00h ; 1f10c
loc_0x01F10E:
	LD [BR:2Ah],#80h ; 1f10e
	LD A,#03h ; 1f111
	CARL loc_0x01EEC8 ; 1f113
	NOP ; 1f116
	INC B ; 1f117
	CP B,#0FAh ; 1f118
	JRL NC,loc_0x01F159 ; 1f11b
	BIT [BR:2Ah],#80h ; 1f11e
	JRS NZ,loc_0x01F10E ; 1f121
	CP B,#03h ; 1f123
	JRL NC,loc_0x01F136 ; 1f126
	LD A,#06h ; 1f129
	CARL loc_0x01EEC8 ; 1f12b
	BIT [BR:2Ah],#80h ; 1f12e
	JRL Z,loc_0x01F15C ; 1f131
	JRS loc_0x01F10E
; ---------------------- ; 1f134
loc_0x01F136:
	LD A,#06h ; 1f136
	CARL loc_0x01EEC8 ; 1f138
	BIT [BR:2Ah],#80h ; 1f13b
	JRS NZ,loc_0x01F10E ; 1f13e
	LD B,#00h ; 1f140
	LD A,#0FFh ; 1f142
	LD HL,#1BCAh ; 1f144
	LD IY,#029Ah ; 1f147
loc_0x01F14A:
	CP [HL],A ; 1f14a
	JRS Z,loc_0x01F162 ; 1f14c
	DEC IY ; 1f14e
	JRS Z,loc_0x01F15F ; 1f14f
	BIT [BR:2Ah],#80h ; 1f151
	JRS Z,loc_0x01F14A ; 1f154
	LD A,#00h ; 1f156
	RET
; ---------------------- ; 1f158
loc_0x01F159:
	LD A,#01h ; 1f159
	RET
; ---------------------- ; 1f15b
loc_0x01F15C:
	LD A,#02h ; 1f15c
	RET
; ---------------------- ; 1f15e
loc_0x01F15F:
	LD A,#10h ; 1f15f
	RET
; ---------------------- ; 1f161
loc_0x01F162:
	LD A,#0FFh ; 1f162
	RET
; ---------------------- ; 1f164
loc_0x01F165:
	PUSH IY ; 1f165
	LD A,#00h ; 1f166
	LD B,#08h ; 1f168
	LD H,#05h ; 1f16a
loc_0x01F16C:
	BIT [BR:2Ah],#80h ; 1f16c
	JRS NZ,loc_0x01F175 ; 1f16f
	SLA A ; 1f171
	JRS loc_0x01F179
; ---------------------- ; 1f173
loc_0x01F175:
	SLA A ; 1f175
	OR A,#01h ; 1f177
loc_0x01F179:
	DEC B ; 1f179
	JRS Z,loc_0x01F191 ; 1f17a
	NOP ; 1f17c
	NOP ; 1f17d
	LD [BR:2Ah],#80h ; 1f17e
	NOP ; 1f181
	NOP ; 1f182
	NOP ; 1f183
	PUSH A ; 1f184
	LD A,#06h ; 1f186
	CARL loc_0x01EEC8 ; 1f188
	POP A ; 1f18b
	NOP ; 1f18d
	LD A,A ; 1f18e
	JRS loc_0x01F16C
; ---------------------- ; 1f18f
loc_0x01F191:
	NOP ; 1f191
	NOP ; 1f192
	LD [BR:2Ah],#80h ; 1f193
	LD [IX],A ; 1f196
	CP A,#00h ; 1f197
	JRS NZ,loc_0x01F1A0 ; 1f199
	DEC H ; 1f19b
	JRS Z,loc_0x01F1B9 ; 1f19c
	JRS loc_0x01F1A2
; ---------------------- ; 1f19e
loc_0x01F1A0:
	LD H,#05h ; 1f1a0
loc_0x01F1A2:
	INC IX ; 1f1a2
	LD B,#08h ; 1f1a3
	LD A,#00h ; 1f1a5
	DEC IY ; 1f1a7
	JRS Z,loc_0x01F1B9 ; 1f1a8
	PUSH A ; 1f1aa
	LD A,#05h ; 1f1ac
	CARL loc_0x01EEC8 ; 1f1ae
	POP A ; 1f1b1
	NOP ; 1f1b3
	NOP ; 1f1b4
	NOP ; 1f1b5
	LD A,A ; 1f1b6
	JRS loc_0x01F16C
; ---------------------- ; 1f1b7
loc_0x01F1B9:
	POP BA ; 1f1b9
	SUB BA,IY ; 1f1ba
	LD IY,BA ; 1f1bc
	LD A,#00h ; 1f1be
	RET
; ---------------------- ; 1f1c0
loc_0x01F1C1:
	LD L,#00h ; 1f1c1
	LD B,#80h ; 1f1c3
loc_0x01F1C5:
	LD A,[IX] ; 1f1c5
loc_0x01F1C6:
	SLA A ; 1f1c6
	JRS C,loc_0x01F1D8 ; 1f1c8
	CP L,#00h ; 1f1ca
	JRS Z,loc_0x01F219 ; 1f1cd
	CP L,#02h ; 1f1cf
	JRS C,loc_0x01F1DB ; 1f1d2
	LD L,#00h ; 1f1d4
	JRS loc_0x01F219
; ---------------------- ; 1f1d6
loc_0x01F1D8:
	INC L ; 1f1d8
	JRS loc_0x01F219
; ---------------------- ; 1f1d9
loc_0x01F1DB:
	PUSH A ; 1f1db
	PUSH B ; 1f1dd
	PUSH IX ; 1f1df
	CP B,#80h ; 1f1e0
	JRS NZ,loc_0x01F1EC ; 1f1e3
	DEC IX ; 1f1e5
	LD A,[IX] ; 1f1e6
	AND A,#0FCh ; 1f1e7
	LD [IX],A ; 1f1e9
	JRS loc_0x01F212
; ---------------------- ; 1f1ea
loc_0x01F1EC:
	CP B,#40h ; 1f1ec
	JRS NZ,loc_0x01F1FD ; 1f1ef
	DEC IX ; 1f1f1
	LD A,[IX] ; 1f1f2
	AND A,#0FEh ; 1f1f3
	LD [IX],A ; 1f1f5
	INC IX ; 1f1f6
	LD A,[IX] ; 1f1f7
	AND A,#7Fh ; 1f1f8
	LD [IX],A ; 1f1fa
	JRS loc_0x01F212
; ---------------------- ; 1f1fb
loc_0x01F1FD:
	PUSH B ; 1f1fd
	SLA B ; 1f1ff
	LD A,[IX] ; 1f201
	XOR A,B ; 1f202
	LD [IX],A ; 1f203
	POP B ; 1f204
	CP L,#02h ; 1f206
	JRS NZ,loc_0x01F212 ; 1f209
	SLA B ; 1f20b
	SLA B ; 1f20d
	LD A,[IX] ; 1f20f
	XOR A,B ; 1f210
	LD [IX],A ; 1f211
loc_0x01F212:
	LD L,#00h ; 1f212
	POP IX ; 1f214
	POP B ; 1f215
	POP A ; 1f217
loc_0x01F219:
	SRL B ; 1f219
	JRS NC,loc_0x01F1C6 ; 1f21b
	INC IX ; 1f21d
	LD B,#80h ; 1f21e
	DEC IY ; 1f220
	JRS NZ,loc_0x01F1C5 ; 1f221
	RET
; ---------------------- ; 1f223
loc_0x01F224:
	LD [1D82h],IY ; 1f224
	LD IY,HL ; 1f227
	LD H,#00h ; 1f229
	LD B,#80h ; 1f22b
	LD L,#00h ; 1f22d
loc_0x01F22F:
	LD A,[IX] ; 1f22f
loc_0x01F230:
	SLA A ; 1f230
	JRS C,loc_0x01F252 ; 1f232
	CP H,#00h ; 1f234
	JRS NZ,loc_0x01F240 ; 1f237
	INC L ; 1f239
	JRS NZ,loc_0x01F270 ; 1f23a
	LD L,#0FFh ; 1f23c
	JRS loc_0x01F270
; ---------------------- ; 1f23e
loc_0x01F240:
	CP L,#1Dh ; 1f240
	JRS C,loc_0x01F247 ; 1f243
	LD L,#00h ; 1f245
loc_0x01F247:
	LD H,[IY+L] ; 1f247
	INC H ; 1f249
	LD [IY+L],H ; 1f24a
	LD H,#00h ; 1f24c
	LD L,#01h ; 1f24e
	JRS loc_0x01F270
; ---------------------- ; 1f250
loc_0x01F252:
	CP H,#01h ; 1f252
	JRS Z,loc_0x01F269 ; 1f255
	CP L,#1Dh ; 1f257
	JRS C,loc_0x01F25E ; 1f25a
	LD L,#00h ; 1f25c
loc_0x01F25E:
	LD H,[IY+L] ; 1f25e
	INC H ; 1f260
	LD [IY+L],H ; 1f261
	LD H,#01h ; 1f263
	LD L,#01h ; 1f265
	JRS loc_0x01F270
; ---------------------- ; 1f267
loc_0x01F269:
	INC L ; 1f269
	JRS NZ,loc_0x01F270 ; 1f26a
	LD L,#0FFh ; 1f26c
	JRS loc_0x01F270
; ---------------------- ; 1f26e
loc_0x01F270:
	SRL B ; 1f270
	JRS NC,loc_0x01F230 ; 1f272
	LD B,#80h ; 1f274
	INC IX ; 1f276
	PUSH IY ; 1f277
	LD IY,[1D82h] ; 1f278
	DEC IY ; 1f27b
	JRS Z,loc_0x01F284 ; 1f27c
	LD [1D82h],IY ; 1f27e
	POP IY ; 1f281
	JRS loc_0x01F22F
; ---------------------- ; 1f282
loc_0x01F284:
	POP IY ; 1f284
	RET
; ---------------------- ; 1f285
loc_0x01F286:
	DEC L ; 1f286
	LD H,#02h ; 1f287
	LD B,#00h ; 1f289
loc_0x01F28B:
	LD A,[IX+L] ; 1f28b
	CP A,#00h ; 1f28d
	JRS NZ,loc_0x01F297 ; 1f28f
	DEC L ; 1f291
	JRL Z,loc_0x01F2B0 ; 1f292
	JRS loc_0x01F28B
; ---------------------- ; 1f295
loc_0x01F297:
	LD [IY],L ; 1f297
	INC IY ; 1f298
	INC B ; 1f299
	CP B,#05h ; 1f29a
	JRL Z,loc_0x01F2B3 ; 1f29d
	DEC L ; 1f2a0
	JRL Z,loc_0x01F2B0 ; 1f2a1
	LD A,[IX+L] ; 1f2a4
	CP A,#00h ; 1f2a6
	JRS NZ,loc_0x01F297 ; 1f2a8
	DEC H ; 1f2aa
	JRS NZ,loc_0x01F297 ; 1f2ab
	LD A,#00h ; 1f2ad
	RET
; ---------------------- ; 1f2af
loc_0x01F2B0:
	LD A,#01h ; 1f2b0
	RET
; ---------------------- ; 1f2b2
loc_0x01F2B3:
	LD A,#01h ; 1f2b3
	RET
; ---------------------- ; 1f2b5
	DB 0B1h, 00h, 0C5h, 00h, 00h ; 1f2b6
	ASCII "F" ; 1f2bb
	DB 0CFh, 20h, 92h, 9Bh, 0E7h, 0FAh, 0F8h
; ---------------------- ; 1f2bc
loc_0x01F2C3:
	LD HL,#0000h ; 1f2c3
	CP IY,#0002h ; 1f2c6
	JRS C,loc_0x01F2E0 ; 1f2c9
	LD BA,IY ; 1f2cb
	SRL A ; 1f2cd
	SRL B ; 1f2cf
	JRS NC,loc_0x01F2D5 ; 1f2d1
	OR A,#80h ; 1f2d3
loc_0x01F2D5:
	LD IY,BA ; 1f2d5
loc_0x01F2D7:
	LD BA,[IX] ; 1f2d7
	ADD HL,BA ; 1f2d9
	INC IX ; 1f2db
	INC IX ; 1f2dc
	DEC IY ; 1f2dd
	JRS NZ,loc_0x01F2D7 ; 1f2de
loc_0x01F2E0:
	RET
; ---------------------- ; 1f2e0
loc_0x01F2E1:
	LD [1D82h],IY ; 1f2e1
	LD IY,HL ; 1f2e4
	LD H,#08h ; 1f2e6
loc_0x01F2E8:
	LD BA,IY ; 1f2e8
	SLA A ; 1f2ea
	JRS C,loc_0x01F2F4 ; 1f2ec
	SLA B ; 1f2ee
	JRS C,loc_0x01F300 ; 1f2f0
	JRS loc_0x01F305
; ---------------------- ; 1f2f2
loc_0x01F2F4:
	SLA B ; 1f2f4
	JRS C,loc_0x01F2FD ; 1f2f6
	OR B,#01h ; 1f2f8
	JRS loc_0x01F305
; ---------------------- ; 1f2fb
loc_0x01F2FD:
	OR B,#01h ; 1f2fd
loc_0x01F300:
	XOR B,#10h ; 1f300
	XOR A,#21h ; 1f303
loc_0x01F305:
	LD IY,BA ; 1f305
	LD A,[IX] ; 1f307
	SLA A ; 1f308
	JRS NC,loc_0x01F313 ; 1f30a
	LD [IX],A ; 1f30c
	LD BA,IY ; 1f30d
	XOR A,#01h ; 1f30f
	LD IY,BA ; 1f311
loc_0x01F313:
	LD [IX],A ; 1f313
	DEC H ; 1f314
	JRS NZ,loc_0x01F2E8 ; 1f315
	LD H,#08h ; 1f317
	INC IX ; 1f319
	PUSH IY ; 1f31a
	LD IY,[1D82h] ; 1f31b
	DEC IY ; 1f31e
	JRS Z,loc_0x01F327 ; 1f31f
	LD [1D82h],IY ; 1f321
	POP IY ; 1f324
	JRS loc_0x01F2E8
; ---------------------- ; 1f325
loc_0x01F327:
	POP IY ; 1f327
	LD HL,IY ; 1f328
	RET
; ---------------------- ; 1f32a
loc_0x01F32B:
	LD HL,#0001h ; 1f32b
loc_0x01F32E:
	LD A,[IX] ; 1f32e
	CP A,#00h ; 1f32f
	JRS Z,loc_0x01F33A ; 1f331
	LD IY,HL ; 1f333
loc_0x01F335:
	ADD HL,IY ; 1f335
	DEC A ; 1f337
	JRS NZ,loc_0x01F335 ; 1f338
loc_0x01F33A:
	INC IX ; 1f33a
	DEC B ; 1f33b
	JRS NZ,loc_0x01F32E ; 1f33c
	RET
; ---------------------- ; 1f33e
	DB 0FFh, 0FFh ; 1f339
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
