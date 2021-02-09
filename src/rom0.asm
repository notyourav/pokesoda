INCLUDE "global.inc"

DEFSECT ".rom0", CODE AT 2100H
SECT ".rom0"
; ----------------------

	ASCII "MN"

; ---------------------- ; 2100
reset_vector:

	farjump __START

; ---------------------- ; 2105
prc_frame_copy_irq:

	farjump IRQ_FrameCopy

; ---------------------- ; 210b
prc_render_irq:

	farjump IRQ_Render

; ---------------------- ; 2111
timer_2h_underflow_irq:

	farjump IRQ_Timer2HI_Underflow

; ---------------------- ; 2117
timer_2l_underflow_irq:

	farjump IRQ_Timer2LO_Underflow

; ---------------------- ; 211d
timer_1h_underflow_irq:

	farjump IRQ_Timer1HI_Underflow

; ---------------------- ; 2123
timer_1l_underflow_irq:

	farjump IRQ_Timer1LO_Underflow

; ---------------------- ; 2129
timer_3h_underflow_irq:

	farjump IRQ_Timer3HI_Underflow

; ---------------------- ; 212f
timer_3_cmp_irq:

	farjump IRQ_Timer3Cmp

; ---------------------- ; 2135
timer_32hz_irq:

	farjump IRQ_Timer_32hz

; ---------------------- ; 213b
timer_8hz_irq:

	farjump IRQ_Timer_8hz

; ---------------------- ; 2141
timer_2hz_irq:

	farjump IRQ_Timer_2hz

; ---------------------- ; 2147
timer_1hz_irq:

	farjump IRQ_Timer_1hz

; ---------------------- ; 214d
ir_rx_irq:

	farjump IRQ_IR

; ---------------------- ; 2153
shake_irq:

	farjump IRQ_Shake

; ---------------------- ; 2159
key_power_irq:

	farjump loc_0x003571

; ---------------------- ; 215f
key_right_irq:

	farjump IRQ_KeyRight

; ---------------------- ; 2165
key_left_irq:

	farjump IRQ_KeyLeft

; ---------------------- ; 216b
key_down_irq:

	farjump IRQ_KeyDown

; ---------------------- ; 2171
key_up_irq:

	farjump IRQ_KeyUp

; ---------------------- ; 2177
key_c_irq:

	farjump IRQ_KeyC

; ---------------------- ; 217d
key_b_irq:

	farjump IRQ_KeyB

; ---------------------- ; 2183
key_a_irq:

	farjump IRQ_KeyA

; ---------------------- ; 2189

    DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
    DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

	ASCII "NINTENDO" ; 21a4
game_id:
	ASCII "MSDJ"

	; SJIS name
	DB 0BFh, 0C0h, 0DEh, 0C3h, 0D4h, 0BBh, 0DDh, 00h

	DB 00h, 00h, 00h, 00h

	ASCII "2P" ; 21bc

	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	DB 00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	DB 00h, 00h

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
global loc_0x0021F4
loc_0x0021F4:

	; something to do with sleep mode?
	LD EP, #00h
	AND [BR:IRQ_ENA1], #0BFh

	RET

; ---------------------- ; 21fa
global loc_0x0021FB
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
global loc_0x002243
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
global loc_0x00227C
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
global loc_0x00228F
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
	farcall loc_0x011B84

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
	farcall loc_0x011B84

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
global loc_0x0022D4
loc_0x0022D4:

	PUSH EP ; 22d4

	LD EP,#00h ; 22d5

	LD HL,[1625h] ; 22d8
	LD B,[1627h] ; 22db

	POP EP ; 22df

	RET

; ---------------------- ; 22e0
loc_0x0022E1:

	PUSH EP

	LD EP, #00h

	LD [1628h], HL
	LD [162Ah], B

	POP EP

	RET

; ---------------------- ; 22ed
global loc_0x0022EE
loc_0x0022EE:

	PUSH EP

	LD EP, #00h

	LD HL, [1628h]
	LD B, [162Ah]

	POP EP

	RET

; ---------------------- ; 22f5
DoCurrentProc:

	LD EP, #00h
	LD HL, [1611h]
	
	LD A, [1613h]
	LD NB, A
	
	JP HL

; ---------------------- ; 2307
loc_0x002308:

	LD EP, #00h
	LD HL, [1617h]

	LD A, [1619h]
	LD NB, A

	JP HL

; ---------------------- ; 2314
loc_0x002315:

	LD EP, #00h
	LD HL, [161Ah]
	
	LD A,[161Ch]
	LD NB, A
	
	JP HL

; ---------------------- ; 2321
Main:

	LD EP, #00h
	LD HL, [161Fh]

	LD A, [1621h]
	LD NB, A
	
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
global loc_0x002338
loc_0x002338:

	CARL WaitNextFrame ; 2338

	LD [BR:PRC_MODE], #PRC_MODE_INVERT

	RET

; ---------------------- ; 233e
global loc_0x00233F
loc_0x00233F:

	CARL WaitNextFrame

	LD [BR:PRC_MODE], #PRC_MODE_COPY

	RET

; ---------------------- ; 2345
global loc_0x002346
loc_0x002346:

	LD HL, #1672h
	LD [HL], #01h

vblank_loop:

	BIT [HL], #0FFh
	JRS NZ, vblank_loop

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   Args:
;     IY: start addr
;     BA: length
;      L: fill byte
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
memset:

	LD [IY], L
	INC IY

	DEC BA
	JRS NZ, memset

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Move bytes from one location to another
;   Args:
;     IX: src
;     IY: dest
;     BA: # bytes
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x002356:

	LD [IY], [IX]

	INC IX
	INC IY

	DEC BA

	JRS NZ, loc_0x002356

	RET

; ---------------------- ; 235c
global loc_0x00235D
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
	LD [keys_old2], BA

	LD BA, [163Dh]
	LD [keys_new_unpressed], BA

	LD BA, [163Fh]
	LD [unk1645], BA

	RET

loc_0x0023CB:

	LD BA, #0000h

	LD [keys_old2], BA
	LD [keys_new_unpressed], BA
	LD [unk1645], BA

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
;   Args:
;     A: index
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
global loc_0x0023D8
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

	LD EP,#@DPAG(unk_graphics_024a80) ; 240a
	LD H,#00h ; 240d

	ADD HL,HL ; 240f
	ADD HL,#@DOFF(unk_graphics_024a80) ; 2411

	LD BA,[HL] ; 2414

	POP EP ; 2416

	RET

; ---------------------- ; 2417
loc_0x002418:

	PUSH EP ; 2418

	LD EP,#@DPAG(unk_graphics_024a00) ; 2419
	LD H,#00h ; 241c

	ADD HL,HL ; 241e
	ADD HL,#@DOFF(unk_graphics_024a00) ; 2420

	LD BA,[HL] ; 2423

	POP EP ; 2425

	RET

; ---------------------- ; 2426
loc_0x002427:

	PUSH EP ; 2427

	LD EP,#@DPAG(unk_graphics_024e43) ; 2428
	LD H,#00h ; 242b

	LD BA,HL ; 242d
	ADD HL,BA ; 242f
	ADD HL,BA ; 2431
	ADD HL,#@DOFF(unk_graphics_024e43) ; 2433

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

	LD EP,#@DPAG(unk_graphics_024d83) ; 2440
	LD H,#00h ; 2443

	LD BA,HL ; 2445
	ADD HL,BA ; 2447
	ADD HL,BA ; 2449
	ADD HL,#@DOFF(unk_graphics_024d83) ; 244b

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

	LD EP,#@DPAG(unk_graphics_024c80) ; 2458
	LD H,#00h ; 245b
	ADD HL,#@DOFF(unk_graphics_024c80) ; 245d

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
global loc_0x002575
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
global loc_0x00258F
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
	CARL memset

	RET

; ---------------------- ; 25ad
loc_0x0025AE:

	LD IY, #tilemap
	LD YP, #00h
	LD L, #00h
	LD BA, #0180h
	CARL memset

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Set incrementing memory values until end address
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

global loc_0x002642
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
global loc_0x00268D
loc_0x00268D:

	PUSH ALE ; 268d
    
	CARL loc_0x005A87 ; 268f
    
	LD [164Ah],BA ; 2692
    
	POP ALE ; 2695
    
	LD BA,[164Ah] ; 2697
    
	RET
; ---------------------- ; 2699
loc_0x00269B:

	PUSH ALE ; 269b

	CARL loc_0x005AC9 ; 269d

	LD [164Ah],BA ; 26a0

	POP ALE ; 26a3

	LD BA,[164Ah] ; 26a5

	RET

; ---------------------- ; 26a8
global loc_0x0026A9
loc_0x0026A9:

	PUSH ALE ; 26a9

	CARL loc_0x00424F ; 26ab

	LD [164Ah],BA ; 26ae

	POP ALE ; 26b1

	LD BA,[164Ah] ; 26b3

	RET

; ---------------------- ; 26b6
global loc_0x0026B7
loc_0x0026B7:

	LD A,[1665h] ; 26b7
	BIT A,#04h ; 26bb
	JRS Z,loc_0x0026C5 ; 26bd

	LD A,#0FFh ; 26bf
	LD [1AB5h],A ; 26c1

loc_0x0026C5:

	RET

; ---------------------- ; 26c5
global loc_0x0026C6
loc_0x0026C6:

	LD EP,#00h ; 26c6
	LD A,[1AB5h] ; 26c9
	AND A,A ; 26cd
	JRS NZ,loc_0x0026FB ; 26ce

	PUSH IP ; 26d0
	PUSH IY ; 26d1

	LD A,[1AB6h] ; 26d2
	LD B,#00h ; 26d6

	LD IY,#lookup_2705 ; 26d8
	LD YP,#00h ; 26db
	ADD IY,BA ; 26de
	LD A,[IY] ; 26e0
	LD [mn_sfx_vol],A ; 26e1

	LD A,[bgm_vol] ; 26e5
	LD B,#00h ; 26e9

	LD IY,#lookup_2708 ; 26eb
	LD YP,#00h ; 26ee
	ADD IY,BA ; 26f1
	LD A,[IY] ; 26f3
	LD [mn_bgm_vol],A ; 26f4

	POP IY ; 26f8
	POP IP ; 26f9

	RET

; ---------------------- ; 26fa
loc_0x0026FB:

	XOR A,A ; 26fb
	LD [mn_sfx_vol],A ; 26fc
	LD [mn_bgm_vol],A ; 2700

	RET

; ---------------------- ; 2704
lookup_2705:
	DB 00h, 01h, 03h

lookup_2708:
    DB 00h, 81h, 83h, 01h, 03h
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

	LD IX,#game_id ; 279b
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

	LD IX,#game_id ; 2808
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
global loc_0x00287D
loc_0x00287D:

	CARL loc_0x002847 ; 287d

	LD IX,#game_id ; 2880
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

loc_0x0028BD:

	XOR A,A ; 28bd

	RET

; ---------------------- ; 28be
global loc_0x0028BF
loc_0x0028BF:

	PUSH BA ; 28bf

	CARL loc_0x002847 ; 28c0

	LD IX,#game_id ; 28c3

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

	LD IX,#game_id ; 28fd

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
global loc_0x002987
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

	farjump loc_0x002BE3

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

	LD A,[BR:KEY_PAD] ; 2a8c
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

loc_0x002ABB:

	LD HL, #166Ch
	BIT [HL], #08h
	JRL NZ, loc_0x002BDB
	
	OR [HL], #08h
	LD BA, #0000h
	LD [1669h], A
	LD [1667h], BA

	LD A, [1AB6h]
	AND A, A
	JRS Z, loc_0x002ADD
	
	LD A, #21h
	LD [14FAh], A

loc_0x002ADD:

	CARL WaitNextFrame

	LD A, #00h
	LD B, #00h
	CARL loc_0x0026A9
	CARL loc_0x0021F4
	CARL loc_0x003B77

	XOR A, A
	CARL loc_0x00269B

	LD A, [1B2Bh]
	CP A, #00h
	JRS Z, loc_0x002B0F

	CP A, #04h
	JRS NZ, loc_0x002B09

	farcall loc_0x012F7C

	farcall loc_0x013612

loc_0x002B09:

	farcall loc_0x012FE8

loc_0x002B0F:

	XOR A, A
	LD [1B2Bh],A

	farcall loc_0x018BC5
	CARL loc_0x00287D

	LD EP, #00h
	LD BR, #20h

loc_0x002B22:

	BIT [BR:52h], #80h
	JRS Z, loc_0x002B22

	AND [BR:IRQ_ENA1], #00h
	AND [BR:IRQ_ENA2], #03h
	AND [BR:IRQ_ENA3], #00h
	AND [BR:IRQ_ENA4], #0BFh

	OR [BR:IRQ_ACT3], #80h
	OR [BR:IRQ_ENA3], #80h
	OR [BR:IRQ_PRI2], #3Bh
	
	XOR A, A
	LD [161Dh], A

	LD HL, #2BF2h
	LD B, #00h
	CARL loc_0x002269

	LD [BR:TMR1_CTRL_L], #80h

	LD BA, #0FFFFh
	LD [2032h], BA

	LD [BR:TMR1_SCALE], #0Fh
	OR [BR:TMR1_OSC], #11h
	LD [BR:IRQ_ACT1], #08h
	OR [BR:IRQ_PRI1], #08h
	OR [BR:IRQ_ENA1], #08h
	OR [BR:TMR1_CTRL_L], #04h
	OR [BR:TMR1_CTRL_L], #02h
	AND [BR:PRC_MODE], #0F7h

	INT [44h]
	INT [56h]

	AND [BR:IRQ_ENA3], #7Fh
	AND [BR:IRQ_PRI2], #0F3h

	AND [BR:IRQ_ENA1], #0FBh
	AND [BR:IRQ_PRI1], #0F3h

	LD A,[161Dh] ; 2b7a
	OR A, A ; 2b7e
	JRS Z,loc_0x002BA1 ; 2b7f

	farcall loc_0x018A86

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

loc_0x002BA1:

	LD HL,#@COFF(loc_0x018639) ; 2ba1
	JRS loc_0x002BB5

loc_0x002BA6:
	; load new stage

	farcall loc_0x018DBB

	LD BA,#5190h ; 2bac
	LD [1667h],BA ; 2baf
	LD HL,#@COFF(loc_0x0186B8)  ; for a jump: NB = 3, PC = 86b8, jump target = 186b8 (rom3.asm)

loc_0x002BB5:

	LD B,#@CPAG(loc_0x0186B8) ; 2bb5
	CARL loc_0x00227C ; 2bb7

	LD EP,#00h ; 2bba
	LD A,[BR:KEY_PAD] ; 2bbd
	XOR A,#0FFh ; 2bbf
	LD [1665h],A ; 2bc1

	CARL loc_0x0026B7
	CARL loc_0x0026C6
	CARL loc_0x003B86

	XOR A, A
	LD [1642h], A
	LD [1645h], A
	LD [1643h], A

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
	LD HL,#@COFF(loc_0x019E15) ; 2be7
	LD B,#@CPAG(loc_0x019E15) ; 2bea
	CARL loc_0x00228F ; 2bec

	AND SC,#3Fh ; 2bef

	RET

; ---------------------- ; 2bf1
loc_0x002BF2:

	LD A,#01h ; 2bf2
	LD [161Dh],A ; 2bf4

	RET
; ---------------------- ; 2bf8
global loc_0x002BF9
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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; A: ???
; B: ???
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
global loc_0x002C22
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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Copy tilemap from temp location
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x002D17:

	LD EP, #00h

	LD BA, [1654h]
	OR A, B

	OR A, [1656h]
	JRS Z, loc_0x002D6B

	LD IX, [1657h]
	LD A, [1656h]
	LD XP, A

	LD IY, #1360h
	LD YP, #00h

	LD L, [164Eh]
	LD H, #00h
	SUB HL, #000Ch

	LD A, #09h

loc_0x002D3D:

	DUP 12
	LD [IY], [IX]
	INC IX
	INC IY
	ENDM

	LD [IY], [IX]
	INC IY
	INC IY

	INC IY
	INC IY

	ADD IX, HL

	DEC A
	JRS NZ, loc_0x002D3D

loc_0x002D6B:

	RET

; ---------------------- ; 2d6b
MainLoop:

	CARL Main

	JRS MainLoop

dummy_func:

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Set background and sprite gfx sources
;   Args:
;     IY: offset
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
global loc_0x002D72
loc_0x002D72:

	LD EP, #00h

	LD A, [IY+00h]
	LD [166Bh], A

	; set PRC rate
	LD A, [IY+01h]
	INT [7Eh]

	; BG settings?
	LD A, [IY+02h]
	LD [162Bh], A
	
	; set BG gfx1 address
	LD A, [IY+03h]
	LD B, [IY+04h]
	LD [162Ch], BA
	
	; set BG gfx1 page
	LD A, [IY+05h]
	LD [162Eh], A

	; set BG gfx2 address
	LD A, [IY+06h]
	LD B, [IY+07h]
	LD [162Fh], BA

	; set BG gfx2 page
	LD A, [IY+05h]
	LD [1631h], A

	XOR A, A
	LD [1632h], A
	LD [1633h], A

	; set mon gfx1 address
	LD A, [IY+09h]
	LD B, [IY+0Ah]
	LD [1634h], BA

	; set mon gfx1 page
	LD A, [IY+0Bh]
	LD [1636h], A

	; set mon gfx2 address
	LD A, [IY+0Ch]
	LD B, [IY+0Dh]
	LD [1637h], BA

	; set mon gfx2 page
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

loc_0x002E62:

	LD NB, A

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
	LD HL, #@COFF(dummy_func)
	LD B, #@CPAG(dummy_func)
	CARL loc_0x002243
	
	CARL loc_0x00265C
	CARL loc_0x0042CB
	CARL loc_0x00422C
	CARL minlib_reset_audio_registers
	CARL loc_0x00267F

	LD [1B0Fh], A
	farcall loc_0x018000

	farcall loc_0x01801C

	farcall loc_0x018035

	AND SC, #3Fh

	LD HL, #@COFF(loc_0x003608)
	LD B, #@CPAG(loc_0x003608)
	LD [161Fh], HL
	LD [1621h], B

	farjump MainLoop

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
	farcall loc_0x03852E

	farcall loc_0x011D05
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

	farcall loc_0x00235D

	farcall loc_0x011BA5

	farcall loc_0x011C7B

	farcall loc_0x011CF5

	farcall loc_0x0383C6

	farcall loc_0x03842F

	RET

; ---------------------- ; 2f6c
loc_0x002F6D:

	LD HL,#1672h ; 2f6d
	BIT [HL],#0FFh ; 2f70
	JRL Z,loc_0x002F11 ; 2f72

	LD [HL],#00h ; 2f75

	farcall loc_0x03852E

	farcall loc_0x011D05
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

	farcall loc_0x00235D

	farcall loc_0x038EDF

	farcall loc_0x011BA5

	farcall loc_0x011C7B

	farcall loc_0x011CF5

	farcall loc_0x0383C6

	farcall loc_0x03842F

	RET

; ---------------------- ; 2fc9
Module_Gameplay:

	LD HL, #1672h
	BIT [HL], #0FFh
	JRL Z, loc_0x002F11

	; 3852E
	LD [HL], #00h
	farcall loc_0x03852E

	farcall loc_0x011D05
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

	farcall loc_0x00235D

	farcall loc_0x038EDF

	farcall loc_0x011ECF

	farcall loc_0x011C7B

	farcall loc_0x011CF5

	farcall loc_0x0383C6

	farcall loc_0x03842F

	RET

; ---------------------- ; 3026
loc_0x003027:
	LD HL,#1672h ; 3027
	BIT [HL],#0FFh ; 302a
	JRL Z,loc_0x002F11 ; 302c
	LD [HL],#00h ; 302f
	farcall loc_0x03852E
	farcall loc_0x011D05
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
	farcall loc_0x00235D
	farcall loc_0x038EDF
	farcall loc_0x011ECF
	farcall loc_0x011909
	farcall loc_0x011CF5
	farcall loc_0x0383C6
	farcall loc_0x03842F
	LD HL,#1672h ; 3083
	BIT [HL],#0FFh ; 3086
	JRL Z,loc_0x002F11 ; 3088
	LD [HL],#00h ; 308b
	farcall loc_0x03852E
	farcall loc_0x011D05
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
	farcall loc_0x00235D
	farcall loc_0x038EDF
	farcall loc_0x011ECF
	farcall loc_0x011875
	farcall loc_0x011CF5
	farcall loc_0x0383C6
	farcall loc_0x03842F
	RET
; ---------------------- ; 30df
loc_0x0030E0:
	LD HL,#1672h ; 30e0
	BIT [HL],#0FFh ; 30e3
	JRL Z,loc_0x002F11 ; 30e5
	LD [HL],#00h ; 30e8
	farcall loc_0x002D17
	farcall loc_0x03852E
	farcall loc_0x011D05
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
	farcall loc_0x00235D
	farcall loc_0x011BA5
	farcall loc_0x011C7B
	farcall loc_0x011CF5
	farcall loc_0x002CC6
	farcall loc_0x0383C6
	farcall loc_0x03842F
	RET
; ---------------------- ; 3142
loc_0x003143:
	LD HL,#1672h ; 3143
	BIT [HL],#0FFh ; 3146
	JRL Z,loc_0x002F11 ; 3148
	LD [HL],#00h ; 314b
	farcall loc_0x03852E
	farcall loc_0x011D05
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
	farcall loc_0x00235D
	farcall loc_0x011BA5
	farcall loc_0x01168D
	farcall loc_0x0116D0
	farcall loc_0x01172F
	farcall loc_0x011CF5
	farcall loc_0x0383C6
	farcall loc_0x03842F
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
	LD IY,#@DOFF(titlescreen_clock_lookup) ; 3394
	LD YP,#@DPAG(titlescreen_clock_lookup) ; 3397
	CARL loc_0x002586 ; 339a
	RET
; ---------------------- ; 339d
titlescreen_clock_lookup:
    DW titlescreen_display_nothing, titlescreen_display_date, titlescreen_display_time
; accessing this table from index 8 leads to ACE from the save file

titlescreen_display_nothing:
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
titlescreen_display_time:
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
titlescreen_display_date:
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
	LD [BR:IRQ_ACT1], #40h

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
	LD [BR:IRQ_ACT1], #20h

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
	LD BR, #20h ; 351a
	LD [BR:IRQ_ACT1], #08h

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
	LD [BR:IRQ_ACT1], #04h

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
	LD [BR:IRQ_ACT2], #20h

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
	OR [BR:IRQ_ACT3], #80h

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
	OR [BR:IRQ_ACT3], #02h

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
	LD [BR:IRQ_ACT4], #40h

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
global loc_0x0035C6
loc_0x0035C6:

	PUSH ALE ; 35c6

	LD A,[168Ch] ; 35c8
	CARL loc_0x00293F ; 35cc

	POP ALE ; 35cf

loc_0x0035D1:

	PUSH ALE ; 35d1

	LD IX,#game_id ; 35d3
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

	LD HL,#@COFF(loc_0x018388) ; 363e
	LD B,#@CPAG(loc_0x018388) ; 3641
	CARL loc_0x00227C ; 3643

	RET

; ---------------------- ; 3646
loc_0x003647:

	LD A,#0FFh ; 3647
	LD [168Ch],A ; 3649

	farcall loc_0x018035

	LD HL,#@COFF(loc_0x0036AC) ; 3653
	LD B,#@CPAG(loc_0x0036AC) ; 3656
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

	LD HL,#@COFF(loc_0x018388) ; 3670
	LD B,#@CPAG(loc_0x018388) ; 3673
	CARL loc_0x00227C ; 3675

	RET

; ---------------------- ; 3678
loc_0x003679:

	LD [168Ch],A ; 3679

	LD HL,#@COFF(loc_0x00379F) ; 367d
	LD B,#@CPAG(loc_0x00379F) ; 3680
	CARL loc_0x00227C ; 3682

	RET

; ---------------------- ; 3685
data_3686:
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

	farcall loc_0x011ADC

	farcall loc_0x002BF9

	farcall loc_0x0382F4

	LD IY,#@DOFF(data_3686) ; 36c4
	LD YP,#@DPAG(data_3686) ; 36c7
	CARL loc_0x002D72 ; 36ca

	LD IY,#0012h ; 36cd
	farcall loc_0x011B84
	LD IY,#13AEh ; 36d6
	farcall loc_0x011B84

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
data_36f2:
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

	farcall loc_0x011ADC

	farcall loc_0x002BF9

	farcall loc_0x0382F4

	LD IY,#@DOFF(data_36f2) ; 3730
	LD YP,#@DPAG(data_36f2) ; 3733
	CARL loc_0x002D72 ; 3736

	LD IY,#0012h ; 3739
	farcall loc_0x011B84

	LD IY,#13AEh ; 3742
	farcall loc_0x011B84

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
data_3779:
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

	LD IY,#@DOFF(data_3779) ; 37b7
	LD YP,#@DPAG(data_3779) ; 37ba
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
data_37e5:
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

	LD IY,#@DOFF(data_37e5) ; 3823
	LD YP,#@DPAG(data_37e5) ; 3826
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
data_388c:
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
	LD IY,#@DOFF(data_388c) ; 38ca
	LD YP,#@DPAG(data_388c) ; 38cd
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
data_38f8:
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
	LD IY,#@DOFF(data_38f8) ; 3936
	LD YP,#@DPAG(data_38f8) ; 3939
	CARL loc_0x002D72 ; 393c
	LD IY,#@DOFF(data_387d4) ; 393f
	LD NB,#@CPAG(loc_0x03836A) ; 3942
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
data_399b:
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
	LD IY,#@DOFF(data_399b) ; 39d9
	LD YP,#@DPAG(data_399b) ; 39dc
	CARL loc_0x002D72 ; 39df
	LD IY,#@DOFF(data_387d4) ; 39e2
	LD NB,#@CPAG(loc_0x03836A) ; 39e5
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
data_3a53:
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
	LD IY,#@DOFF(data_3a53) ; 3a91
	LD YP,#@DPAG(data_3a53) ; 3a94
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
data_3abf:
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
	LD IY,#@DOFF(data_3abf) ; 3afd
	LD YP,#@DPAG(data_3abf) ; 3b00
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


	DB 0F7h
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
global loc_0x007948
loc_0x007948:
	LD [IX+04h],A ; 7948
	LD [IX+05h],B ; 794b
	RET
; ---------------------- ; 794e
global loc_0x00794F
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
global loc_0x007970
loc_0x007970:
	LD [IX+04h],L ; 7970
	LD [IX+05h],H ; 7973
	LD [IX+02h],A ; 7976
	LD [IX+03h],B ; 7979
	LD A,#01h ; 797c
	LD [IX+06h],A ; 797e
	RET
; ---------------------- ; 7981
global loc_0x007982
loc_0x007982:

	LD [IX+0Ah], A ; X
	LD [IX+0Eh], B ; Y

	XOR A, A
	LD [IX+09h], A
	LD [IX+0Bh], A
	LD [IX+0Dh], A
	LD [IX+0Fh], A

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
