INCLUDE "global.inc"
INCLUDE "engine_constants.inc"

; ---------------------- ; 17ffd
DEFSECT ".rom3", CODE AT 018000H
SECT ".rom3"
; ---------------------- ; 17fff
global loc_0x018000
loc_0x018000:

	LD EP, #00h

	LD A, #00h
	LD [mn_sfx_page], A

	LD A,#00h
	LD [mn_bgm_table_page], A

	LD A, #00h
	LD [mn_sfx_table_page], A

	LD A, #00h
	LD [u8_1506], A

	RET

; ---------------------- ; 1801b
global loc_0x01801C
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
global loc_0x018035
loc_0x018035:

	XOR A,A ; 18035
	LD [1AB5h],A ; 18036

	LD A,#01h ; 1803a
	LD [sfx_vol],A ; 1803c

	LD A,#02h ; 18040
	LD [bgm_vol],A ; 18042

	LD A,#01h ; 18046
	LD [rumble_on],A ; 18048

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
	LD [filler1AB9],A ; 1806c
	LD [filler1AB9 + 1],A ; 18070
	LD [filler1AB9 + 2],A ; 18074

	CARL loc_0x018CAF ; 18078
	CARL loc_0x0026B7 ; 1807b
	CARL loc_0x0026C6 ; 1807e

	RET

; ---------------------- ; 18081
loc_0x018081:
	RET
; ---------------------- ; 18082

bgstruct_018083:
    bgstruct 07h, 04h, 0Eh, unk_tiles_dialogues,                \
    unk_tiles_dialogues, sprites_settings, sprites_settings,    \
	loc_0x002F6D, loc_0x018181, loc_0x019E15, NULL,             \
    18h, 08h, 03h, loc_0x00261A, unk_graphics_025143, 0Ch, 10h

bgstruct_0180A9:
    bgstruct 0Dh, 04h, 0Eh, unk_tiles_dialogues,                \
    unk_tiles_dialogues, sprites_settings, sprites_settings,    \
	loc_0x002F6D, loc_0x01817E, loc_0x01914D, NULL,             \
    18h, 08h, 03h, loc_0x00261A, unk_graphics_025143, 0Ch, 10h


loc_0x0180CF:
	CARL loc_0x0021F4 ; 180cf
	CARL loc_0x002338 ; 180d2
    
	farcall loc_0x011ADC
	farcall loc_0x002BF9
	farcall loc_0x0382F4
	farcall loc_0x00287D
    
	JRS loc_0x018107
; ---------------------- ; 180ed
loc_0x0180EF:
	CARL loc_0x0021F4 ; 180ef
	CARL loc_0x002338 ; 180f2
    
	farcall loc_0x011ADC
	farcall loc_0x002BF9
	farcall loc_0x0382F4

loc_0x018107:
	farload y, bgstruct_018083
loc_0x01810D:

	LD A,[1B36h] ; 1810d
	OR A,A ; 18111
	JRS Z,loc_0x018117 ; 18112

	LD IY,#@DOFF(bgstruct_0180A9)

loc_0x018117:

	CARL load_bgstruct ; 18117

	LD HL,#0000h ; 1811a
	LD IY,#@DOFF(pool_0104E3)
	farcall loc_0x011B84

	LD HL,#0000h ; 18126
	LD IY,#@DOFF(pool_010547)
	farcall loc_0x011B84

	LD HL,#0000h ; 18132
	LD IY,#@DOFF(pool_01027B)
	farcall loc_0x011B84

	LD HL,#0000h ; 1813e
	LD IY,#@DOFF(pool_01030A)
	farcall loc_0x011B84

	LD HL,#0000h ; 1814a
	LD IY,#@DOFF(pool_010385)
	farcall loc_0x011B84

	LD HL,#0000h ; 18156
	LD IY,#@DOFF(pool_0103EC)
	farcall loc_0x011B84

	LD IY,#@DOFF(pool_0113AE)
	farcall loc_0x011B84
    
	CARL loc_0x00233F ; 1816b
	CARL loc_0x0021FB ; 1816e

	OR [BR:IRQ_ENA2],#IRQ2_32HZ
	OR [BR:TMR256_CTRL],#TMR_RESET ; 18174

	LD A,#01h ; 18177
	LD [filler163A],A ; 18179

	RET
	
; ---------------------- ; 1817d
loc_0x01817E:

	CARL loc_0x0189F1 ; 1817e

loc_0x018181:
	CARL loc_0x002346 ; 18181

	LD HL, #keys_new_unpressed ; 18184
	BIT [HL], #KEY_B ; 18187
	JRS NZ, loc_0x018193 ; 18189

	LD HL, #keys_new_unpressed ; 1818b
	BIT [HL], #KEY_A ; 1818e
	JRS NZ, loc_0x0181B7 ; 18190

	RET

loc_0x018193:

	LD A,[sfx_vol] ; 18193
	AND A,A ; 18197
	JRS Z,loc_0x0181A0 ; 18198

	LD A,#02h ; 1819a
	LD [mn_pending_sfx],A ; 1819c

loc_0x0181A0:

	LD BA,#1AD6h ; 181a0
	SUB BA,#1AB5h ; 181a3
	CARL loc_0x0028BF ; 181a6

	LD A,[1B0Fh] ; 181a9
	CARL loc_0x00268D ; 181ad
	CARL loc_0x0022EE ; 181b0
	CARL loc_0x00228F ; 181b3

	RET

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

loc_0x0181CC:

	LD A,[sfx_vol] ; 181cc
	AND A,A ; 181d0
	JRS Z,loc_0x0181D9 ; 181d1

	LD A,#01h ; 181d3
	LD [mn_pending_sfx],A ; 181d5

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

loc_0x0181F2:

	LD A,[sfx_vol] ; 181f2
	AND A,A ; 181f6
	JRS Z,loc_0x0181FF ; 181f7

	LD A,#01h ; 181f9
	LD [mn_pending_sfx],A ; 181fb

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

loc_0x018218:

	LD A,[sfx_vol] ; 18218
	AND A,A ; 1821c
	JRS Z,loc_0x018225 ; 1821d

	LD A,#01h ; 1821f
	LD [mn_pending_sfx],A ; 18221

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

loc_0x01823E:

	LD A,[sfx_vol] ; 1823e
	AND A,A ; 18242
	JRS Z,loc_0x01824B ; 18243

	LD A,#01h ; 18245
	LD [mn_pending_sfx],A ; 18247

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

	LD HL,#keys_new_unpressed ; 182f9
	BIT [HL],#KEY_B ; 182fc
	JRS NZ,loc_0x018310 ; 182fe

loc_0x018300:

	LD A,[1ABAh] ; 18300
	CP A,#06h ; 18304
	JRS NZ,loc_0x01830F ; 18306

	LD HL,#keys_new_unpressed ; 18308
	BIT [HL],#KEY_A ; 1830b
	JRS NZ,loc_0x01832C ; 1830d

loc_0x01830F:

	RET

loc_0x018310:

	LD A,[sfx_vol] ; 18310
	AND A,A ; 18314
	JRS Z,loc_0x01831D ; 18315

	LD A,#02h ; 18317
	LD [mn_pending_sfx],A ; 18319

loc_0x01831D:

	LD A,[1915h] ; 1831d
	CP A,#0FCh ; 18321
	JRS NZ,loc_0x01832B ; 18323

	CARL loc_0x0022EE ; 18325
	CARL loc_0x00228F ; 18328

loc_0x01832B:

	RET

loc_0x01832C:

	LD IX,#15AAh ; 1832c
	LD XP,#00h ; 1832f

	CARL loc_0x004A54 ; 18332
	CARL loc_0x0022D4 ; 18335
	CARL loc_0x00228F ; 18338

	RET

; ---------------------- ; 1833b
pool_01833C:
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

loc_0x018368:

	CARL loc_0x0021F4 ; 18368
	CARL loc_0x002338 ; 1836b

	farcall loc_0x011ADC ; 18371

	farcall loc_0x002BF9 ; 18377

	farcall loc_0x0382F4 ; 1837d

	farcall loc_0x0035C6 ; 18383

	JRS loc_0x0183A0

global loc_0x018388 ; alternate entry point
loc_0x018388:

	CARL loc_0x0021F4 ; 18388
	CARL loc_0x002338 ; 1838b

	farcall loc_0x011ADC ; 18391

	farcall loc_0x002BF9 ; 18397

	farcall loc_0x0382F4 ; 1839d

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

	farload y, pool_01833C
	CARL load_bgstruct ; 183d9

	XOR A,A ; 183dc
	LD [1ABAh],A ; 183dd

	LD IY,#064Ch ; 183e1
	farcall loc_0x011B84 ; 183e7

	LD IY,#13AEh ; 183ea
	farcall loc_0x011B84 ; 183f0

	LD HL,#0303h ; 183f3
	LD IY,#@DOFF(pool_03897e)
	farcall loc_0x03836A ; 183fc

	LD HL,#0503h ; 183ff
	LD IY,#@DOFF(pool_038912)
	farcall loc_0x03836A ; 18408

	CARL loc_0x00233F ; 1840b
	CARL loc_0x0021FB ; 1840e

	RET

; ---------------------- ; 18411
loc_0x018412:

	CARL loc_0x002346 ; 18412

	LD A,[1ABAh] ; 18415
	AND A,A ; 18419
	JRS NZ,loc_0x018423 ; 1841a

	LD HL,#keys_new_unpressed ; 1841c
	BIT [HL],#KEY_B ; 1841f
	JRS NZ,loc_0x018433 ; 18421

loc_0x018423:

	LD A,[1ABAh] ; 18423
	CP A,#06h ; 18427
	JRS NZ,loc_0x018432 ; 18429

	LD HL,#keys_new_unpressed ; 1842b
	BIT [HL],#KEY_A ; 1842e
	JRS NZ,loc_0x018434 ; 18430

loc_0x018432:

	RET

loc_0x018433:

	RET

loc_0x018434:

	farload x, 15AAh
	CARL loc_0x004A54 ; 1843a

	CARL loc_0x004B13 ; 1843d
	CARL loc_0x0022D4 ; 18440
	CARL loc_0x00228F ; 18443

	RET

; ---------------------- ; 18446
pool_018447:
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

	farcall loc_0x011ADC ; 18476

	farcall loc_0x002BF9 ; 1847c

	farcall loc_0x0382F4 ; 18482

	farload y, pool_018447
	CARL load_bgstruct ; 1848b

	LD A,#01h ; 1848e
	LD [168Eh],A ; 18490

	LD HL,#0000h ; 18494
	LD IY,#0697h ; 18497
	farcall loc_0x011B84

	LD IY,#13AEh ; 184a0
	farcall loc_0x011B84

	CARL loc_0x00233F ; 184a9
	CARL loc_0x0021FB ; 184ac

	RET

; ---------------------- ; 184af
loc_0x0184B0:

	CARL loc_0x002346 ; 184b0

	LD HL,#keys_new_unpressed ; 184b3
	BIT [HL],#KEY_A ; 184b6
	JRS NZ,loc_0x0184C2 ; 184b8

loc_0x0184BA:

	LD HL,#keys_new_unpressed ; 184ba
	BIT [HL],#KEY_B ; 184bd
	JRS NZ,loc_0x0184E3 ; 184bf

	RET

loc_0x0184C2:

	LD A,[sfx_vol] ; 184c2
	AND A,A ; 184c6
	JRS Z,loc_0x0184CF ; 184c7

	LD A,#01h ; 184c9
	LD [mn_pending_sfx],A ; 184cb

loc_0x0184CF:

	LD A,[168Eh] ; 184cf
	AND A,A ; 184d3
	JRS NZ,loc_0x0184F0 ; 184d4

	LD NB,#@CPAG(loc_0x01804C)
	CARL loc_0x01804C ; 184d9

	CARL loc_0x0022D4 ; 184dc
	CARL loc_0x00228F ; 184df

	RET

loc_0x0184E3:

	LD A,[sfx_vol] ; 184e3
	AND A,A ; 184e7
	JRS Z,loc_0x0184F0 ; 184e8

	LD A,#02h ; 184ea
	LD [mn_pending_sfx],A ; 184ec

loc_0x0184F0:

	CARL loc_0x0022EE ; 184f0
	CARL loc_0x00228F ; 184f3

	RET

; ---------------------- ; 184f6
pool_0184f7:
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

	farcall loc_0x011ADC

	farcall loc_0x002BF9

	farcall loc_0x0382F4

	farload y, pool_0184f7
	CARL load_bgstruct ; 18541

	LD HL,#0000h ; 18544
	LD IY,#1FA8h ; 18547
	farcall loc_0x011B84

	LD HL,#0000h ; 18550
	LD IY,#1FAEh ; 18553
	farcall loc_0x011B84

	LD HL,#1B2Fh ; 1855c
	LD IY,#2014h ; 1855f
	farcall loc_0x011B84

	LD HL,#1B2Bh ; 18568
	LD IY,#2029h ; 1856b
	farcall loc_0x011B84

	LD IY,#13AEh ; 18574
	farcall loc_0x011B84

	CARL loc_0x00233F ; 1857d
	CARL loc_0x0021FB ; 18580

	RET

; ---------------------- ; 18583
loc_0x018584:

	CARL loc_0x002346 ; 18584

	LD A,[keys_new_unpressed] ; 18587
	BIT A,#KEY_C ; 1858b
	JRS NZ,loc_0x018603 ; 1858d

	BIT A,#KEY_B ; 1858f
	JRS NZ,loc_0x0185E1 ; 18591

	BIT A,#KEY_A ; 18593
	JRS Z,loc_0x0185CA ; 18595

	LD A,[sfx_vol] ; 18597
	AND A,A ; 1859b
	JRS Z,loc_0x0185A4 ; 1859c

	LD A,#01h ; 1859e
	LD [mn_pending_sfx],A ; 185a0

loc_0x0185A4:

	LD HL,#0A3F9h ; 185a4
	LD B,#03h ; 185a7

	LD A,[keys_old] ; 185a9
	BIT A,#(KEY_LEFT | KEY_RIGHT) ; 185ad
	JRS Z,loc_0x0185B9 ; 185af

	XOR A,A ; 185b1
	LD [1AD6h],A ; 185b2

	CARL loc_0x0022D4 ; 185b6

loc_0x0185B9:

	CARL loc_0x00228F ; 185b9

	LD A,[pet_breed] ; 185bc
	CP A,#03h ; 185c0
	JRS C,loc_0x0185CA ; 185c2

	LD A,#BREED_MUDKIP ; 185c4
	LD [pet_breed],A ; 185c6

loc_0x0185CA:

	RET

; ---------------------- ; 185ca
loc_0x0185CB:

	LD A,[sfx_vol] ; 185cb
	AND A,A ; 185cf
	JRS Z,loc_0x0185D8 ; 185d0

	LD A,#02h ; 185d2
	LD [mn_pending_sfx],A ; 185d4

loc_0x0185D8:

    farload code, loc_0x0180EF
	CARL loc_0x00228F ; 185dd

	RET

; ---------------------- ; 185e0
loc_0x0185E1:

	LD A,[sfx_vol] ; 185e1
	AND A,A ; 185e5
	JRS Z,loc_0x0185EE ; 185e6

	LD A,#21h ; 185e8
	LD [mn_pending_sfx],A ; 185ea

loc_0x0185EE:

	RET

; ---------------------- ; 185ee
loc_0x0185EF:

	LD A,[sfx_vol] ; 185ef
	AND A,A ; 185f3
	JRS Z,loc_0x0185FC ; 185f4

	LD A,#02h ; 185f6
	LD [mn_pending_sfx],A ; 185f8

loc_0x0185FC:

	CARL loc_0x0022EE ; 185fc
	CARL loc_0x00228F ; 185ff

	RET

; ---------------------- ; 18602
loc_0x018603:

	LD A,[sfx_vol] ; 18603
	AND A,A ; 18607
	JRS Z,loc_0x018612 ; 18608

	LD A,[1AD7h] ; 1860a
	LD [mn_pending_sfx],A ; 1860e

loc_0x018612:

	RET

; ---------------------- ; 18612
pool_018613:
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
global loc_0x018639
loc_0x018639:

	CARL loc_0x018DE3 ; 18639

	LD HL,[1AE5h] ; 1863c
	CP HL,#0480h ; 1863f
	JRS C,loc_0x01864D ; 18642

	LD HL,#0E463h ; 18644
	LD B,#03h ; 18647
	CARL loc_0x00227C ; 18649

	RET

loc_0x01864D:

	LD A,[1ADBh] ; 1864d
	LD HL,#1ADAh ; 18651
	OR A,[HL] ; 18654
	JRS NZ,loc_0x01867A ; 18655

	LD NB,#@CPAG(loc_0x012FC4)
	CARL loc_0x012FC4 ; 1865a

	LD B,#28h ; 1865d

loc_0x01865F:

	PUSH B ; 1865f

	LD NB,#@CPAG(loc_0x012F8F)
	CARL loc_0x012F8F ; 18664

	POP B ; 18667

	DJR NZ,loc_0x01865F ; 18669

	LD A,#02h ; 1866b
	LD [1ADCh],A ; 1866d

	LD HL,#0E5C2h ; 18671
	LD B,#03h ; 18674
	CARL loc_0x00227C ; 18676

	RET

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
	LD [pet_close],A ; 1869a

	LD A,#00h ; 1869e
	LD [pet_close_act],A ; 186a0

	LD A,#0FFh ; 186a4
	LD [1AE8h],A ; 186a6

	LD A,#01h ; 186aa
	LD [stage_inside],A ; 186ac

	JRS loc_0x0186B5

loc_0x0186B2:

	CARL loc_0x018F5C ; 186b2

loc_0x0186B5:

	CARL loc_0x018D96

; ---------------------- ; 186B5
global loc_0x0186B8
loc_0x0186B8:

	; brushing
	LD A,[pet_close_act] ; 186b8
	CP A,#03h ; 186bc
	JRS Z,loc_0x0186CA ; 186be

	; feeding
	CP A,#04h ; 186c0
	JRS Z,loc_0x0186CA ; 186c2

	; discard invalid modes
	LD A,#00h ; 186c4
	LD [pet_close_act],A ; 186c6

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

	farcall loc_0x011ADC ; 186ef

	farcall loc_0x002BF9 ; 186f5

	farcall loc_0x0382F4 ; 186fb

	farload y, pool_018613
	CARL load_bgstruct ; 18704

	CARL loc_0x018904 ; 18707

	LD HL,#0000h ; 1870a
	LD IY,#0C445h ; 1870d
	LD YP,#00h ; 18710

	farcall loc_0x011EB1 ; 18716

	LD HL,#0000h ; 18719
	LD IY,#0C3DEh ; 1871c
	LD YP,#00h ; 1871f

	farcall loc_0x011EB1 ; 18725

	LD HL,[1B10h] ; 18728
	LD IY,#0BCD3h ; 1872b
	LD YP,#00h ; 1872e

	farcall loc_0x011EB1 ; 18734

	LD A,[1AD8h] ; 18737
	CP A,#01h ; 1873b
	JRS NZ,loc_0x01874D ; 1873d

	LD HL,#2D4Bh ; 1873f
	LD IY,#276Fh ; 18742

	farcall loc_0x011B84

	JRS loc_0x018764

loc_0x01874D:

	LD A,[1AD7h] ; 1874d
	CP A,#02h ; 18751
	JRS NZ,loc_0x018764 ; 18753

	LD HL,#0000h ; 18755
	LD IY,#0C759h ; 18758
	LD YP,#00h ; 1875b

	farcall loc_0x011EB1 ; 18761

loc_0x018764:

	LD HL,[pet_x] ; 18764
	LD IY,#0AA34h ; 18767
	LD YP,#00h ; 1876a

	farcall loc_0x011EB1 ; 18770

	LD HL,#0000h ; 18773
	LD IY,#354Ch ; 18776
	LD YP,#01h ; 18779

	farcall loc_0x011B84 ; 1877f

	LD HL,#0000h ; 18782
	LD IY,#3B14h ; 18785
	LD YP,#01h ; 18788

	farcall loc_0x011B84 ; 1878e

	LD HL,#0000h ; 18791
	LD IY,#401Ch ; 18794
	LD YP,#01h ; 18797

	farcall loc_0x011B84 ; 1879d

	LD HL,#0000h ; 187a0
	LD IY,#4517h ; 187a3
	LD YP,#01h ; 187a6

	farcall loc_0x011B84 ; 187ac

	LD HL,#0000h ; 187af
	LD IY,#4A12h ; 187b2
	LD YP,#01h ; 187b5

	farcall loc_0x011B84 ; 187bb

	LD HL,#1021h ; 187be
	LD IY,#0B6EEh ; 187c1
	LD YP,#00h ; 187c4

	farcall loc_0x011EB1 ; 187ca

	LD HL,#2520h ; 187cd
	LD IY,#0C8EEh ; 187d0
	LD YP,#00h ; 187d3

	farcall loc_0x011EB1 ; 187d9

	LD HL,#0000h ; 187dc
	LD IY,#0B8F2h ; 187df
	LD YP,#00h ; 187e2

	farcall loc_0x011EB1 ; 187e8

	LD A,[1AD8h] ; 187eb

	CP A,#01h ; 187ef
	JRS NZ,loc_0x0187FF ; 187f1

	LD HL,#2D4Bh ; 187f3
	LD IY,#2775h ; 187f6

	farcall loc_0x011B84 ; 187fc

loc_0x0187FF:

	LD HL,#0001h ; 187ff
	LD IY,#8D92h ; 18802

	farcall loc_0x03836A ; 18808

	LD A,[1AD8h] ; 1880b

	CP A,#01h ; 1880f
	JRS NZ,loc_0x01882B ; 18811

	LD HL,#0100h ; 18813
	LD IY,#8E3Dh ; 18816

	farcall loc_0x03836A ; 1881c

	LD HL,#0305h ; 1881f
	LD IY,#8DF4h ; 18822

	farcall loc_0x03836A ; 18828

loc_0x01882B:

	LD A,[1AD8h] ; 1882b
	CP A,#00h ; 1882f
	JRS NZ,loc_0x01888F ; 18831

	LD HL,#0100h ; 18833
	LD IY,#8ED9h ; 18836

	farcall loc_0x03836A ; 1883c

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

	farcall loc_0x011EB1 ; 1885b

	JRS loc_0x01888F

loc_0x018860:

	LD HL,#2C20h ; 18860
	LD IY,#0C4C6h ; 18863
	LD YP,#00h ; 18866

	farcall loc_0x011EB1 ; 1886c

	LD HL,#1808h ; 1886f
	LD IY,#0C658h ; 18872
	LD YP,#00h ; 18875

	farcall loc_0x011EB1 ; 1887b

	JRS loc_0x01888F

loc_0x018880:

	LD HL,#2520h ; 18880
	LD IY,#0CA7Fh ; 18883
	LD YP,#00h ; 18886

	farcall loc_0x011EB1 ; 1888c

loc_0x01888F:

	LD IY,#13AEh ; 1888f

	farcall loc_0x011B84 ; 18895

	LD A,[pet_close] ; 18898
	CARL loc_0x01898C ; 1889c

	LD A,[pet_visitation] ; 1889f
	OR A,A ; 188a3
	JRS Z,loc_0x0188B9 ; 188a4

	LD BA,#8000h ; 188a6
	LD [pet_gfx_frame0_offset],BA ; 188a9
	LD [pet_gfx_frame1_offset],BA ; 188ac

	LD A,#05h ; 188af
	LD [pet_gfx_frame0_page],A ; 188b1
	LD [pet_gfx_frame1_page],A ; 188b5

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

	LD A,[sfx_vol] ; 188d0
	AND A,A ; 188d4
	JRS Z,loc_0x0188DD ; 188d5

	LD A,#07h ; 188d7
	LD [mn_pending_sfx],A ; 188d9

loc_0x0188DD:

	RET

; ---------------------- ; 188dd
loc_0x0188DE:

	CARL loc_0x0189F1 ; 188de
	CARL loc_0x002346 ; 188e1
	CARL loc_0x018C47 ; 188e4

	LD HL,[filler1AE5] ; 188e7
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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Load stage tile offsets
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x018904:

	LD A,[stage_inside]
	CP A, #00h
	JRS Z,loc_0x01890E

	JRS loc_0x018947

; outside
loc_0x01890E:

	LD A, [pet_breed]
	LD L, #11
	MLT

	farload y, pool_01896B
	ADD IY, HL

	; frame 1 offset
	LD BA, [IY]
	LD [tilemap_frame0_offset], BA

	INC IY
	INC IY

	; frame 1 page
	LD A,[IY]
	LD [tilemap_frame0_page], A

	INC IY

	; frame 2 offset
	LD BA, [IY]
	LD [tilemap_frame1_offset], BA

	INC IY
	INC IY

	; frame 2 page
	LD A, [IY]
	LD [tilemap_frame1_page], A

	INC IY

	LD IX, [IY]

	INC IY
	INC IY

	LD A,[IY]
	LD XP, A

	INC IY

	LD B, [IY]
	LD A, [IY+01h]
	CARL loc_0x002C22

; inside
loc_0x018947:

	farload y, pool_018613

	LD L, [IY+1Eh]
	LD H, [IY+1Fh]

	CP HL, #0000h
	JRS Z, loc_0x018967

	LD IX, [1654h]

	LD A, [1656h]
	LD XP, A
	LD A, [IY+20h]
	CARL loc_0x018968

loc_0x018967:

	RET

loc_0x018968:

	LD NB, A

	JP HL

pool_01896B:
	; torchick
	DW @DOFF(tiles_outside_torchick)
	DB @DPAG(tiles_outside_torchick)
	DB 00h, 65h ; todo: fix
	DB 03h
	DW @DOFF(pool_038F17)
	DB @DPAG(pool_038F17)
	DB 08h, 0Ch

	; treecko
	DW @DOFF(tiles_outside_treecko)
	DB @DPAG(tiles_outside_treecko)
	DW @DOFF(tiles_outside2_treecko)
	DB @DPAG(tiles_outside2_treecko)
	DW @DOFF(pool_038F77)
	DB @DPAG(pool_038F77)
	DB 08h, 0Ch

	; mudkip
	DW @DOFF(tiles_outside_mudkip)
	DB @DPAG(tiles_outside_mudkip)
	DW @DOFF(tiles_outside2_mudkip)
	DB @DPAG(tiles_outside2_mudkip)
	DW @DOFF(pool_038FD7)
	DB @DPAG(pool_038FD7)
	DB 08h, 0Ch

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; 0x01898C - Get pet graphics
;   Args:
;     A: 0 = TINY, 1 = CLOSE UP
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
global loc_0x01898C
loc_0x01898C:

	PUSH IP
	PUSH IY

	farload y, pool_0189BC

	CP A, #00h
	JRS Z, loc_0x01899B

	LD IY, #pool_0189C5

loc_0x01899B:

	LD A, [pet_breed]
	LD B, A ; mul by 3 for indexing
	ADD A, A
	ADD A, B

	LD B, #0

	ADD IY, BA
	LD BA, [IY]
	LD [pet_gfx_frame0_offset], BA
	LD [pet_gfx_frame1_offset], BA

	LD A, [IY+02h]
	LD [pet_gfx_frame0_page], A
	LD [pet_gfx_frame1_page], A

	POP IY
	POP IP

	RET

pool_0189BC:
	; tiny pet gfx
	DW @DOFF(gfx_torchick)
	DB @DPAG(gfx_torchick)
	DW @DOFF(gfx_treecko)
	DB @DPAG(gfx_treecko)
	DW @DOFF(gfx_mudkip)
	DB @DPAG(gfx_mudkip)

pool_0189C5:
	; close up pet gfx
	DW @DOFF(gfx_torchick_close)
	DB @DPAG(gfx_torchick_close)
	DW @DOFF(gfx_treecko_close)
	DB @DPAG(gfx_treecko_close)
	DW @DOFF(gfx_mudkip_close)
	DB @DPAG(gfx_mudkip_close)
	
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; 0x0189CE - Set pet animation
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x0189CE:

	LD A, [pet_hunger]
	OR A, A
	JRS Z, loc_0x0189E7

	LD A, [pet_breed]
	ADD A, A
	LD B, #00h

	farload y, pool_0189EA
	ADD IY, BA
	LD BA, [IY]

	RET

loc_0x0189E7:

	LD BA, #0E10h

	RET

pool_0189EA:

	DB 60h, 09h
	DB 10h, 0Eh
	DB 0B8h, 0Bh

; ---------------------- ; 189eb
loc_0x0189F1:

	LD HL,#1B03h ; 189f1
	INC [HL] ; 189f4

	LD A,[HL] ; 189f5
	CP A,#24h ; 189f6
	JRS C,loc_0x018A12 ; 189f8

	LD [HL],#00h ; 189fa

	LD HL,[1B01h] ; 189fc
	INC HL ; 189ff
	LD [1B01h],HL ; 18a00

	CARL loc_0x0189CE ; 18a03

	CP HL,BA
	JRS C, loc_0x018A12 ; checking time delta?

	SUB HL, BA
	LD [1B01h], HL

	CARL loc_0x018C22

loc_0x018A12:

	LD A,[1AE7h]
	AND A,#1Ch
	JRS NZ,loc_0x018A26

	LD BA,#0000h
	LD [1B06h],A
	LD [1B04h],BA

	JRS loc_0x018A46

loc_0x018A26:
	LD HL,#1B06h ; 18a26
	INC [HL] ; 18a29
	
	LD A,[HL] ; 18a2a
	CP A,#24h ; 18a2b
	JRS C,loc_0x018A46 ; 18a2d

	LD [HL],#00h ; 18a2f
	LD HL,[1B04h] ; 18a31

	INC HL ; 18a34
	LD [1B04h],HL ; 18a35

	CP HL,#0E10h ; 18a38
	JRS C,loc_0x018A46 ; 18a3b
	
	SUB HL,#0E10h ; 18a3d
	LD [1B04h],HL ; 18a40

	CARL loc_0x018C38 ; 18a43

loc_0x018A46:

	LD A,[1AE8h] ; 18a46
	CP A,#0FFh ; 18a4a
	JRS NZ,loc_0x018A82 ; 18a4c

	LD A,[pet_hunger] ; 18a4e
	OR A,A ; 18a52
	JRS Z,loc_0x018A82 ; 18a53

	LD HL,#1B09h ; 18a55
	INC [HL] ; 18a58

	LD A,[HL] ; 18a59
	CP A,#24h ; 18a5a
	JRS C,loc_0x018A67 ; 18a5c

	LD [HL],#00h ; 18a5e

	LD HL,[1B07h] ; 18a60
	INC HL ; 18a63
	LD [1B07h],HL ; 18a64

loc_0x018A67:

	CARL loc_0x018C0A ; 18a67

	LD HL,[1B07h] ; 18a6a
	LD B,#00h ; 18a6d

loc_0x018A6F:

	SUB HL,BA ; 18a6f
	JRS C,loc_0x018A82 ; 18a71

	LD [1B07h],HL ; 18a73

	PUSH HL ; 18a76
	PUSH BA ; 18a77

	farcall loc_0x012FB6 ; 18a7b

	POP BA ; 18a7e
	POP HL ; 18a7f

	JRS loc_0x018A6F


loc_0x018A82:

	CARL loc_0x018F4E ; 18a82

	RET

; ---------------------- ; 18a85
global loc_0x018A86
loc_0x018A86:

	LD B,#00h ; 18a86
	LD [1B6Ch],B ; 18a88

	LD A,[pet_hunger] ; 18a8c
	OR A,A ; 18a90
	JRS Z,loc_0x018A96 ; 18a91

	OR B,#01h ; 18a93

loc_0x018A96:

	LD A,[pet_energy] ; 18a96
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

	LD A,[pet_energy] ; 18ab8
	CP A,#28h ; 18abc
	JRS NZ,loc_0x018AC8 ; 18abe

	LD HL,[1B6Ah] ; 18ac0
	CP HL,#0FFFFh ; 18ac3
	JRS NZ,loc_0x018ACD ; 18ac6

loc_0x018AC8:

	CARL loc_0x018BC5 ; 18ac8

	JRS loc_0x018AD1

loc_0x018ACD:

	DEC HL ; 18acd
	LD [1B6Ah],HL ; 18ace

loc_0x018AD1:

	CARL loc_0x018F4E ; 18ad1

	POP B ; 18ad4
	BIT B,#01h ; 18ad6
	JRS Z,loc_0x018AE3 ; 18ad8

	LD A,[pet_hunger] ; 18ada
	OR A,A ; 18ade
	JRS Z,loc_0x018B09 ; 18adf

	JRS loc_0x018AF2

loc_0x018AE3:

	LD A,[1B6Ch] ; 18ae3
	CP A,#01h ; 18ae7
	JRS NZ,loc_0x018AF2 ; 18ae9

	LD A,[pet_energy] ; 18aeb
	OR A,A ; 18aef
	JRS NZ,loc_0x018B12 ; 18af0

loc_0x018AF2:

	BIT B,#02h ; 18af2
	JRS Z,loc_0x018AFE ; 18af4

	LD A,[pet_energy] ; 18af6
	CP A,#28h ; 18afa
	JRS NC,loc_0x018B0C ; 18afc

loc_0x018AFE:

	LD HL,[1B6Ah] ; 18afe
	CP HL,#0000h ; 18b01
	JRS Z,loc_0x018B0F ; 18b04

	LD A,#00h ; 18b06

	RET

loc_0x018B09:

	LD A,#01h ; 18b09

	RET

loc_0x018B0C:

	LD A,#02h ; 18b0c

	RET

loc_0x018B0F:

	LD A,#03h ; 18b0f

	RET

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

	farcall loc_0x012F81

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

	farcall loc_0x012FB6 ; 18bbd

	POP BA ; 18bc0
	POP HL ; 18bc1

	JRS loc_0x018BB1

loc_0x018BC4:

	RET

; ---------------------- ; 18bc4
global loc_0x018BC5
loc_0x018BC5:

	LD A,[1ADAh] ; 18bc5
	CP A,#28h ; 18bc9
	JRS C,loc_0x018BF7 ; 18bcb

	farcall loc_0x00AA55 ; 18bd0

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

	farload y, pool_018BFE

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
pool_018BFE:
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
loc_0x018C22:

	LD A,[1ADBh] ; 18c22
	OR A,A ; 18c26
	JRS Z,loc_0x018C31 ; 18c27
    
	farcall loc_0x012F81
    
	JRS loc_0x018C37
    
; ---------------------- ; 18c2f
loc_0x018C31:

	farcall loc_0x012F7C
    
loc_0x018C37:

	RET
    
; ---------------------- ; 18c37
loc_0x018C38:

	LD B,#04h ; 18c38

loc_0x018C3A:

	PUSH B ; 18c3a

	farcall loc_0x012F9E ; 18c3f

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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Set stage ground height
	HGT_INSIDE equ 44
	HGT_OUTSIDE equ 48
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
global loc_0x018C96
loc_0x018C96:

	LD B, #HGT_INSIDE

	LD A, [stage_inside]
	CP A, #1
	JRS Z, loc_0x018CAA

	; mudkip's stage outside needs a different height
	LD A, [pet_breed]
	CP A, #BREED_MUDKIP
	JRS NZ, loc_0x018CAA

	LD B, #HGT_OUTSIDE

loc_0x018CAA:

	LD [stage_height], B

	RET

; ---------------------- ; 18cae
loc_0x018CAF:

	XOR A, A

	; these were handwritten :(
	LD [1AC3h], A
	LD [1AC4h], A
	LD [1AC5h], A
	LD [1AC6h], A
	LD [1AC7h], A
	LD [1AC8h], A
	LD [1AC9h], A
	LD [1ACAh], A
	LD [1AD1h], A
	LD [1AD2h], A
	LD [1AD3h], A
	LD [pet_breed], A
	LD [1AD5h], A
	LD [1AD4h], A

	LD A, #0FFh

	LD [1ACBh], A
	LD [1ACCh], A
	LD [1ACDh], A
	LD [1ACEh], A
	LD [1ACFh], A
	LD [1AD0h], A
	LD [1AD6h], A

	RET

; ---------------------- ; 18d06
loc_0x018D07:

	LD BA,#0000h ; 18d07
    
	LD [1AD9h],A ; 18d0a
	LD [1B0Ah],A ; 18d0e
	LD [1AE7h],A ; 18d12
	LD [pet_love],A ; 18d16
	LD [1ADFh],A ; 18d1a
	LD [pet_intellect_frac],A ; 18d1e
	LD [pet_beauty],A ; 18d22
	LD [pet_love_frac],A ; 18d26
	LD [pet_intellect],A ; 18d2a
	LD [1AE2h],A ; 18d2e
	LD [pet_beauty_frac],A ; 18d32
	LD [1AE8h],A ; 18d36
	LD [1B01h],BA ; 18d3a
	LD [1B03h],A ; 18d3d
	LD [1B04h],BA ; 18d41
	LD [1B06h],A ; 18d44
	LD [1B07h],BA ; 18d48
	LD [1B09h],A ; 18d4b
	LD [1AEAh],A ; 18d4f
	LD [1AEBh],A ; 18d53
	LD [1AE9h],A ; 18d57
	LD [filler1AE5],BA ; 18d5b
	LD [pet_visitation],A ; 18d5e
    
	LD B,#07h ; 18d62
	LD HL,#1AECh ; 18d64
    
loc_0x018D67:

	LD [HL],A ; 18d67
	INC HL ; 18d68
    
	DJR NZ,loc_0x018D67 ; 18d69
    
	LD A,#28h ; 18d6b
	LD [pet_energy],A ; 18d6d
    
	LD A,#08h ; 18d71
	LD [pet_hunger],A ; 18d73
    
	LD A,#00h ; 18d77
	LD [pet_mood],A ; 18d79
    
	LD A,#00h ; 18d7d
	LD [pet_close],A ; 18d7f
    
	LD A,#00h ; 18d83
	LD [pet_close_act],A ; 18d85
    
	CARL loc_0x0046B6 ; 18d89
    
	LD IX,#1AF3h ; 18d8c
	LD XP,#00h ; 18d8f
    
	CARL loc_0x004706 ; 18d92
    
	RET
    
; ---------------------- ; 18d95
loc_0x018D96:
	LD A,#00h ; 18d96
	LD [pet_close_act],A ; 18d98
	XOR A,A ; 18d9c
	LD [pet_close],A ; 18d9d
	CARL loc_0x018C96 ; 18da1
	LD B,[stage_height] ; 18da4
	LD A,#28h ; 18da8
	LD [pet_x],BA ; 18daa
	LD A,[stage_inside] ; 18dad
	CP A,#00h ; 18db1
	JRS NZ,loc_0x018DBA ; 18db3
	XOR A,A ; 18db5
	LD [1AE8h],A ; 18db6
loc_0x018DBA:
	RET
; ---------------------- ; 18dba
global loc_0x018DBB
loc_0x018DBB:

	LD A,#01h ; 18dbb
	LD [pet_close],A ; 18dbd

	LD A,#00h ; 18dc1
	LD [pet_close_act],A ; 18dc3

	XOR A,A ; 18dc7

	LD [1AE8h],A ; 18dc8
	LD [pet_visitation],A ; 18dcc

	RET

; ---------------------- ; 18dd0
global loc_0x018DD1
loc_0x018DD1:
	CARL loc_0x018C96 ; 18dd1
	LD B,[1B23h] ; 18dd4
	LD A,#28h ; 18dd8
	LD [1B12h],BA ; 18dda
	XOR A,A ; 18ddd
	LD [1AE8h],A ; 18dde
	RET
; ---------------------- ; 18de2
loc_0x018DE3:
	PUSH IP ; 18de3
	PUSH IX ; 18de4
	PUSH IY ; 18de5
	CARL loc_0x018EBE ; 18de6
	JRL Z,loc_0x018E61 ; 18de9
loc_0x018DEC:
	LD A,[1ADBh] ; 18dec
	OR A,A ; 18df0
	JRS NZ,loc_0x018E0B ; 18df1
	LD A,[1ADAh] ; 18df3
	OR A,A ; 18df7
	JRS NZ,loc_0x018E0B ; 18df8
	LD A,[1AE7h] ; 18dfa
	AND A,#1Ch ; 18dfe
	JRL Z,loc_0x018E83 ; 18e00
	LD A,[1AE3h] ; 18e03
	OR A,A ; 18e07
	JRL Z,loc_0x018E83 ; 18e08
loc_0x018E0B:
	LD BA,[1B91h] ; 18e0b
	SUB BA,#0E10h ; 18e0e
	LD [1B91h],BA ; 18e11
	JRS NC,loc_0x018E23 ; 18e14
	LD BA,[1B93h] ; 18e16
	CP BA,#0000h ; 18e19
	JRL Z,loc_0x018E47 ; 18e1c
	DEC BA ; 18e1f
	LD [1B93h],BA ; 18e20
loc_0x018E23:
	CARL loc_0x018E93 ; 18e23
	LD HL,#0E10h ; 18e26
	LD [1B95h],HL ; 18e29
	LD IX,#1AFAh ; 18e2c
	LD XP,#00h ; 18e2f
	CARL loc_0x018B15 ; 18e32
	CARL loc_0x018EA2 ; 18e35
	LD A,[1AFDh] ; 18e38
	INC A ; 18e3c
	CP A,#18h ; 18e3d
	JRS C,loc_0x018E42 ; 18e3f
	XOR A,A ; 18e41
loc_0x018E42:
	LD [IX+03h],A ; 18e42
	JRS loc_0x018DEC
; ---------------------- ; 18e45
loc_0x018E47:
	CARL loc_0x018E93 ; 18e47
	LD BA,[1B91h] ; 18e4a
	ADD BA,#0E10h ; 18e4d
	LD [1B95h],BA ; 18e50
	LD IX,#1AFAh ; 18e53
	LD XP,#00h ; 18e56
	CARL loc_0x018B15 ; 18e59
	CARL loc_0x018EA2 ; 18e5c
	JRS loc_0x018E8F
; ---------------------- ; 18e5f
loc_0x018E61:
	LD A,[1B83h] ; 18e61
	CP A,#0FFh ; 18e65
	JRS Z,loc_0x018E8F ; 18e67
	XOR A,A ; 18e69
	LD [1ADAh],A ; 18e6a
	LD [1ADBh],A ; 18e6e
	LD A,[1AE7h] ; 18e72
	AND A,#1Ch ; 18e76
	JRS Z,loc_0x018E83 ; 18e78
	XOR A,A ; 18e7a
	LD [1AE3h],A ; 18e7b
	LD [1AE4h],A ; 18e7f
loc_0x018E83:
	LD BA,#0000h ; 18e83
	LD [1B01h],BA ; 18e86
	LD [1B04h],BA ; 18e89
	LD [1B07h],BA ; 18e8c
loc_0x018E8F:
	POP IY ; 18e8f
	POP IX ; 18e90
	POP IP ; 18e91
	RET
; ---------------------- ; 18e92
loc_0x018E93:
	LD B,#00h ; 18e93
	LD A,[1ADBh] ; 18e95
	OR A,A ; 18e99
	JRS NZ,loc_0x018E9D ; 18e9a
	INC B ; 18e9c
loc_0x018E9D:
	LD [1B6Ch],B ; 18e9d
	RET
; ---------------------- ; 18ea1
loc_0x018EA2:
	LD A,[1B6Ch] ; 18ea2
	CP A,#02h ; 18ea6
	JRS NZ,loc_0x018EBD ; 18ea8
	LD A,[1ADBh] ; 18eaa
	OR A,A ; 18eae
	JRS NZ,loc_0x018EBD ; 18eaf
	LD A,[1ADAh] ; 18eb1
	OR A,A ; 18eb5
	JRS Z,loc_0x018EBD ; 18eb6
	DEC A ; 18eb8
	LD [1ADAh],A ; 18eb9
loc_0x018EBD:
	RET
; ---------------------- ; 18ebd
loc_0x018EBE:
	LD IX,#1AFAh ; 18ebe
	LD XP,#00h ; 18ec1
	LD HL,#1B8Ah ; 18ec4
	LD B,#07h ; 18ec7
loc_0x018EC9:
	LD [HL],[IX] ; 18ec9
	INC IX ; 18eca
	INC HL ; 18ecb
	DJR NZ,loc_0x018EC9 ; 18ecc
	LD IX,#15AAh ; 18ece
	LD XP,#00h ; 18ed1
	CARL loc_0x004706 ; 18ed4
	LD IX,#15AFh ; 18ed7
	LD XP,#00h ; 18eda
	LD NB,#01h ; 18edd
	CARL loc_0x00B2F0 ; 18ee0
	LD IX,#1B83h ; 18ee3
	LD A,[IX+00h] ; 18ee6
	CP A,#0FFh ; 18ee9
	JRS Z,loc_0x018F4B ; 18eeb
	OR A,A ; 18eed
	JRS NZ,loc_0x018F4B ; 18eee
	LD A,[IX+01h] ; 18ef0
	OR A,A ; 18ef3
	JRS NZ,loc_0x018F4B ; 18ef4
	LD A,[IX+02h] ; 18ef6
	CP A,#05h ; 18ef9
	JRS NC,loc_0x018F4B ; 18efb
	LD L,#18h ; 18efd
	MLT ; 18eff
	LD A,[IX+03h] ; 18f01
	LD B,#00h ; 18f04
	ADD HL,BA ; 18f06
	LD BA,#003Ch ; 18f08
	CARL loc_0x01900C ; 18f0b
	LD [1B93h],HL ; 18f0e
	LD L,[IX+04h] ; 18f11
	LD H,#00h ; 18f14
	ADD BA,HL ; 18f16
	JRS NC,loc_0x018F21 ; 18f18
	LD HL,[1B93h] ; 18f1a
	INC HL ; 18f1d
	LD [1B93h],HL ; 18f1e
loc_0x018F21:
	LD HL,#003Ch ; 18f21
	CARL loc_0x01900C ; 18f24
	LD [1B91h],BA ; 18f27
	LD BA,[1B93h] ; 18f2a
	ADD HL,BA ; 18f2d
	LD [1B93h],HL ; 18f2f
	LD BA,[1B91h] ; 18f32
	LD L,[IX+05h] ; 18f35
	LD H,#00h ; 18f38
	ADD BA,HL ; 18f3a
	LD [1B91h],BA ; 18f3c
	JRS NC,loc_0x018F48 ; 18f3f
	LD HL,[1B93h] ; 18f41
	INC HL ; 18f44
	LD [1B93h],HL ; 18f45
loc_0x018F48:
	AND SC,#0FEh ; 18f48
	RET
; ---------------------- ; 18f4a
loc_0x018F4B:
	OR SC,#01h ; 18f4b
	RET
; ---------------------- ; 18f4d
global loc_0x018F4E
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
	LD A, [pet_threaten]
	OR A, A
	JRS NZ, loc_0x018FA9

	LD A, [pet_beauty]
	LD L, #04h
	MLT

	LD A, [pet_beauty_frac]
	LD B, #00h
	ADD HL, BA
	LD A, #15h
	DIV

	LD B, L
	XOR A, A

loc_0x018F79:

	CP A, B
	JRS Z, loc_0x018FA9

	PUSH BA

	LD B, [pet_breed]
	CARL loc_0x018FAF

	POP BA

	JRS Z, loc_0x018F8A

	INC A

	JRS loc_0x018F79

loc_0x018F8A:

	LD [1B2Ch], A

	CARL loc_0x018FCA

	LD A, #01h
	LD [pet_visitation], A

	LD A,#01h
	LD [stage_inside], A

	LD A, #00h
	LD [pet_close], A

	XOR A, A
	LD [1AE8h], A

	RET

loc_0x018FA9:

	XOR A,A ; 18fa9
	LD [pet_visitation],A ; 18faa

	RET

; ---------------------- ; 18fae
global loc_0x018FAF ; visitation check?
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

loc_0x018FC8:

	AND A,[HL] ; 18fc8

	RET

; ---------------------- ; 18fc9
loc_0x018FCA:

	CARL loc_0x0023D8

	PUSH BA

	LD A, [pet_breed]
	ADD A, A
	LD B, #00h

	LD HL, #1AC3h
	ADD HL, BA

	POP BA

	OR A, A
	JRS NZ, loc_0x018FE2

	INC HL
	LD A, B

	JRS loc_0x018FE2

loc_0x018FE2:

	OR [HL], A

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
global loc_0x018FFE
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
pool_01908A:
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

	farcall loc_0x011ADC

	farcall loc_0x002BF9

	farcall loc_0x0382F4

	farload y, pool_01908A
	CARL load_bgstruct ; 190ce

	LD A,#01h ; 190d1
	LD [164Dh],A ; 190d3

	LD HL,#0040h ; 190d7
	LD IY,#@DOFF(pool_012075)
	farcall loc_0x011B84

	LD HL,#0040h ; 190e3
	LD IY,#@DOFF(pool_0120A4)
	farcall loc_0x011B84

	LD HL,#0040h ; 190ef
	LD IY,#@DOFF(pool_01203B)
	farcall loc_0x011B84

	LD HL,#0000h ; 190fb
	LD IY,#@DOFF(pool_0121B3)
	farcall loc_0x011B84

	LD IY,#@DOFF(pool_038C5F)
	farcall loc_0x03836A

	LD IY,#@DOFF(pool_0113AE)
	farcall loc_0x011B84

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
	DB 00h, 7Bh, 03h, 0Ch, 08h

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Transition to menu screen
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
global loc_0x01914D
loc_0x01914D:

	LD A,[stage_inside] ; 1914d
	LD [1B6Dh],A ; 19151

	CARL loc_0x0021F4 ; 19155
	CARL loc_0x002338 ; 19158

	farcall loc_0x011ADC

	farcall loc_0x002BF9

	farcall loc_0x0382F4

	LD IY,#9127h ; 1916d
	LD YP,#01h ; 19170
	CARL load_bgstruct ; 19173

	LD HL,#0000h ; 19176
	LD IY,#233Dh ; 19179
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1917f

	LD HL,#0300h ; 19182
	LD IY,#9257h ; 19185
	LD NB,#@CPAG(loc_0x03836A)
	CARL loc_0x03836A ; 1918b

	LD HL,#0600h ; 1918e
	LD IY,#92E0h ; 19191
	LD NB,#@CPAG(loc_0x03836A)
	CARL loc_0x03836A ; 19197

	LD IY,#13AEh ; 1919a
	LD NB,#@CPAG(loc_0x011B84)
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
pool_0191B1:
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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Transition to pet stat screen
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x0191DC:

	CARL loc_0x0021F4
	CARL loc_0x002338

	LD NB, #@CPAG(loc_0x011ADC)
	CARL loc_0x011ADC

	LD NB, #@CPAG(loc_0x002BF9)
	CARL loc_0x002BF9

	LD NB, #@CPAG(loc_0x0382F4)
	CARL loc_0x0382F4

	LD IY,#91B1h
	LD YP,#01h
	CARL load_bgstruct
	
	; get graphics
	LD A, #00h
	CARL loc_0x01898C

	LD HL,#0C4Ch
	LD IY,#0AA3Dh
	LD YP,#00h

	LD NB, #@CPAG(loc_0x011EB1)
	CARL loc_0x011EB1

	CARL loc_0x019260

	LD HL,#0001h
	LD IY,#8D92h

	LD NB, #@CPAG(loc_0x03836A)
	CARL loc_0x03836A

	LD HL,#0205h
	LD IY,#95C8h

	LD NB, #@CPAG(loc_0x03836A)
	CARL loc_0x03836A

	LD IY, #13AEh

	LD NB, #@CPAG(loc_0x011B84)
	CARL loc_0x011B84

	CARL loc_0x00233F
	CARL loc_0x0021FB

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Update pet stat screen
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x01923C:

	CARL loc_0x002346
	CARL loc_0x018C47

	LD A, [1643h]
	BIT A, #03h
	JRS Z, loc_0x01925F ; close screen if button pressed
	
	; check if sfx vol 0
	LD A, [sfx_vol]
	AND A, A
	JRS Z, loc_0x019257

	LD A, #02h
	LD [mn_pending_sfx], A

loc_0x019257:

	LD HL, #@COFF(loc_0x01914D)
	LD B, #@CPAG(loc_0x01914D)
	CARL loc_0x00228F

loc_0x01925F:

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Draw breed specific tiles on stat screen
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x019260:

	LD A, [pet_breed]
	ADD A, A
	LD B, #00h

	farload y, pool_0192A1

	ADD IY, BA
	LD IY, [IY]

	LD HL, #tilemap + 31h
	
	; 5 tiles for name
	LD B, #05h

loc_0x019276:

	LD A, [IY]
	LD [HL], A

	INC IY
	INC HL

	DJR NZ, loc_0x019276

	LD B, [1ADDh]
	LD HL, #13C4h
	CARS loc_0x0192B6

	LD B, [1ADFh]
	LD HL, #13DCh
	CARS loc_0x0192B6

	LD B, [1AE1h]
	LD HL, #13F4h
	CARS loc_0x0192B6

	LD B, [1AE3h]
	LD HL, #140Ch
	CARS loc_0x0192B6

	RET

pool_0192A1:
	DW pool_192A7, pool_192AC, pool_192B1

; torchick name tiles
pool_192A7:
	DB 0A2h, 0A3h, 0A4h, 00h, 00h

; treecko name tiles
pool_192AC:
	DB 0A5h, 0A6h, 0A7h, 00h, 00h

; mudkip name tiles
pool_192B1:
	DB 0A8h, 0A9h, 0AAh, 0ABh, 0ACh

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Draw bars on stat screen
;   Args:
;     HL: tilemap address
;      B: amount
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x0192B6:

	CP B, #40h
	JRS C, loc_0x0192BD

	; clamp
	LD B, #40h

loc_0x0192BD:

	PUSH B

	SRL B
	SRL B
	SRL B

	CP B, #00h
	JRS Z, loc_0x0192CF

loc_0x0192CA:

	; draw tile
	LD [HL], #0Ch

	INC HL

	DJR NZ, loc_0x0192CA

; done drawing bar
loc_0x0192CF:

	POP A

	AND A, #07h
	OR A, A
	JRS Z, loc_0x0192DA

	ADD A, #04h
	LD [HL], A

	INC HL

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

	LD NB,#@CPAG(loc_0x011ADC)
	CARL loc_0x011ADC ; 19318

	LD NB,#@CPAG(loc_0x002BF9)
	CARL loc_0x002BF9 ; 1931e

	farcall loc_0x0382F4

	LD IY,#92DBh ; 19327
	LD YP,#01h ; 1932a
	CARL load_bgstruct ; 1932d

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
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1934c

	LD HL,#1858h ; 1934f
	LD IY,#23A3h ; 19352
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 19358

	LD HL,#1810h ; 1935b
	LD IY,#2470h ; 1935e
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 19364

	LD HL,#1840h ; 19367
	LD IY,#24E5h ; 1936a
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 19370

	LD HL,#1828h ; 19373
	LD IY,#2526h ; 19376
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1937c

	LD HL,#0604h ; 1937f
	LD IY,#93F7h ; 19382
	LD NB,#@CPAG(loc_0x03836A)
	CARL loc_0x03836A ; 19388

	LD IY,#13AEh ; 1938b
	LD NB,#@CPAG(loc_0x011B84)
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

	LD A,[sfx_vol] ; 193b2
	AND A,A ; 193b6
	JRS Z,loc_0x0193BF ; 193b7

	LD A,#02h ; 193b9
	LD [mn_pending_sfx],A ; 193bb

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

	LD A,[sfx_vol] ; 193ee
	AND A,A ; 193f2
	JRS Z,loc_0x0193FB ; 193f3

	LD A,#03h ; 193f5
	LD [mn_pending_sfx],A ; 193f7

loc_0x0193FB:

	JRS loc_0x019410

loc_0x0193FD:

	LD A,[sfx_vol] ; 193fd
	AND A,A ; 19401
	JRS Z,loc_0x01940A ; 19402

	LD A,#01h ; 19404
	LD [mn_pending_sfx],A ; 19406

loc_0x01940A:

	CARL loc_0x0022D4 ; 1940a

loc_0x01940D:

	CARL loc_0x00228F ; 1940d

loc_0x019410:

	RET

; ---------------------- ; 19410
loc_0x019411:

	LD A, [pet_breed]

	; 4 * A + 0x14
	ADD A, A
	ADD A, A
	ADD A, #14h

	LD HL, #tilemap + 26
	LD B, #04h

loc_0x01941E:

	LD [HL], A

	INC HL
	INC A

	DJR NZ, loc_0x01941E

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
	farcall loc_0x011ADC ; 19453
	farcall loc_0x002BF9 ; 19459
	farcall loc_0x0382F4 ; 1945f
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

	farcall loc_0x011ADC ; 19496

	farcall loc_0x002BF9 ; 1949c

	farcall loc_0x0382F4 ; 194a2

	LD IY,#9467h ; 194a5

loc_0x0194A8:

	LD YP,#01h ; 194a8
	CARL load_bgstruct ; 194ab

	XOR A,A ; 194ae
	LD [1B2Ch],A ; 194af

	LD A,[pet_breed] ; 194b3
	LD [1B97h],A ; 194b7

	LD HL,#1800h ; 194bb
	LD IY,#23B5h ; 194be
	farcall loc_0x011B84 ; 194c4

	LD HL,#1858h ; 194c7
	LD IY,#23A3h ; 194ca
	farcall loc_0x011B84 ; 194d0

	LD HL,#1810h ; 194d3
	LD IY,#0CD85h ; 194d6
	LD YP,#00h ; 194d9
	farcall loc_0x011EB1 ; 194df

	LD HL,#1840h ; 194e2
	LD IY,#0CD66h ; 194e5
	LD YP,#00h ; 194e8
	farcall loc_0x011EB1 ; 194ee

	LD HL,#1828h ; 194f1
	LD IY,#0CD48h ; 194f4
	LD YP,#00h ; 194f7
	farcall loc_0x011EB1 ; 194fd

	LD HL,#0000h ; 19500
	LD IY,#2391h ; 19503
	farcall loc_0x011B84 ; 19509

	LD HL,#0000h ; 1950c
	LD IY,#238Bh ; 1950f
	farcall loc_0x011B84 ; 19515

	LD HL,#0604h ; 19518
	LD IY,#943Eh ; 1951b
	farcall loc_0x03836A ; 19521

	LD HL,#0102h ; 19524
	LD IY,#9489h ; 19527
	farcall loc_0x03836A ; 1952d

	LD IY,#13AEh ; 19530
	farcall loc_0x011B84 ; 19536

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

loc_0x019563:

	INC [HL] ; 19563
	LD A,[HL] ; 19564
	CP A,#03h ; 19565
	JRS C,loc_0x01956B ; 19567

	LD [HL],#00h ; 19569

loc_0x01956B:

	LD A,[sfx_vol] ; 1956b
	AND A,A ; 1956f
	JRS Z,loc_0x019578 ; 19570

	LD A,#04h ; 19572
	LD [mn_pending_sfx],A ; 19574

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

	LD A,[sfx_vol] ; 19606
	AND A,A ; 1960a
	JRS Z,loc_0x019613 ; 1960b

	LD A,#02h ; 1960d
	LD [mn_pending_sfx],A ; 1960f

loc_0x019613:

	CARL loc_0x0022EE ; 19613

	JRS loc_0x019631

loc_0x019618:

	LD A,[sfx_vol] ; 19618
	AND A,A ; 1961c
	JRS Z,loc_0x019625 ; 1961d

	LD A,#01h ; 1961f
	LD [mn_pending_sfx],A ; 19621

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

loc_0x01964C:

	RET

loc_0x01964D:

	PUSH HL ; 1964d

loc_0x01964E:

	CP A,#1Eh ; 1964e

	JRS C,loc_0x019656 ; 19650

	SUB A,#1Eh ; 19652

	JRS loc_0x01964E

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
pool_019694:
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

	LD NB,#@CPAG(loc_0x011ADC)
	CARL loc_0x011ADC ; 196f2

	LD NB,#@CPAG(loc_0x002BF9)
	CARL loc_0x002BF9 ; 196f8

	LD NB,#@CPAG(loc_0x0382F4)
	CARL loc_0x0382F4 ; 196fe

	LD IY,#@DOFF(pool_019694)
	LD YP,#@DPAG(pool_019694)
	CARL load_bgstruct ; 19707

	LD HL,#0828h ; 1970a
	LD IY,#2533h ; 1970d
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 19713

	LD HL,#0404h ; 19716
	LD IY,#@DOFF(pool_0393F7) ; yes
	LD NB,#@CPAG(loc_0x03836A)
	CARL loc_0x03836A ; 1971f

	LD IY,#@DOFF(pool_0113AE) ; yes
	LD NB, #@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 19728

	CARL loc_0x00233F ; 1972b
	CARL loc_0x0021FB ; 1972e

	LD A,[sfx_vol] ; 19731
	AND A,A ; 19735
	JRS Z,loc_0x01973E ; 19736

	LD A,#22h ; 19738
	LD [mn_pending_sfx],A ; 1973a

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

	LD A,[sfx_vol] ; 19751
	AND A,A ; 19755
	JRS Z,loc_0x01975E ; 19756

	LD A,#02h ; 19758
	LD [mn_pending_sfx],A ; 1975a

loc_0x01975E:

	JRS loc_0x01976D

loc_0x019760:

	LD A,[sfx_vol] ; 19760
	AND A,A ; 19764
	JRS Z,loc_0x01976D ; 19765

	LD A,#01h ; 19767
	LD [mn_pending_sfx],A ; 19769

loc_0x01976D:

	LD NB,#@CPAG(loc_0x00AC56)
	CARL loc_0x00AC56 ; 19770

	JRS NZ,loc_0x01978F ; 19773

	LD A,[1B69h] ; 19775
	CP A,#09h ; 19779
	JRS NZ,loc_0x019784 ; 1977b

	LD HL,#0AA43h ; 1977d
	LD B,#03h ; 19780
	JRS loc_0x019792

loc_0x019784:

	CARL loc_0x0022EE ; 19784

	LD A,#0FFh ; 19787
	LD [1B69h],A ; 19789
	JRS loc_0x019792

loc_0x01978F:

	CARL loc_0x0022D4 ; 1978f

loc_0x019792:

	CARL loc_0x00228F ; 19792

loc_0x019795:

	RET

; ---------------------- ; 19795
bg_struct_019796:
    bgstruct 07h, 04h, 3Eh, tiles_comms, tiles_comms,   \
	sprites_other_mons, sprites_other_mons,             \
	loc_0x002F6D, loc_0x019816, loc_0x01914D, NULL,     \
    18h, 08h, 07h, loc_0x002642, unk_037e78, 0Ch, 08h
; ---------------------- ; 197b9
loc_0x0197BC:

	XOR A,A ; 197bc
	LD [1B6Eh],A ; 197bd
    
	CARL loc_0x0046B6 ; 197c1
    
	XOR A,A ; 197c4
	LD [1B80h],A ; 197c5
    
	LD HL,#1ACBh ; 197c9
loc_0x0197CC:

	CP [HL],#0FFh ; 197cc
	JRS Z,loc_0x0197D5 ; 197cf
    
	INC HL ; 197d1
	INC A ; 197d2
    
	JRS loc_0x0197CC
    
; ---------------------- ; 197d3
loc_0x0197D5:
	LD [1B7Fh],A ; 197d5
    
	CARL loc_0x0021F4 ; 197d9
	CARL loc_0x002338 ; 197dc
    
	farcall loc_0x011ADC
	farcall loc_0x002BF9
	farcall loc_0x0382F4
    
	farload y, bg_struct_019796
	CARL load_bgstruct ; 197f7
    
	LD HL,#0000h ; 197fa
	LD IY,#2660h ; 197fd
	farcall loc_0x011B84
    
	LD IY,#13AEh ; 19806
	farcall loc_0x011B84
    
	CARL loc_0x00233F ; 1980f
	CARL loc_0x0021FB ; 19812
    
	RET
; ---------------------- ; 19815
loc_0x019816:

	CARL loc_0x002346 ; 19816

	LD A,[1643h] ; 19819
	BIT A,#02h ; 1981d
	JRS NZ,loc_0x01987D ; 1981f

	BIT A,#01h ; 19821
	JRS Z,loc_0x019890 ; 19823

	LD A,[sfx_vol] ; 19825
	AND A,A ; 19829
	JRS Z,loc_0x019832 ; 1982a

	LD A,#01h ; 1982c
	LD [mn_pending_sfx],A ; 1982e

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

loc_0x019867:

	LD A,[1B7Fh] ; 19867
	CP A,#05h ; 1986b
	JRS C,loc_0x019876 ; 1986d

	LD HL,#9BEDh ; 1986f
	LD B,#03h ; 19872

	JRS loc_0x01988D

loc_0x019876:

	LD HL,#98B7h ; 19876
	LD B,#03h ; 19879

	JRS loc_0x01988D

loc_0x01987D:

	LD A,[sfx_vol] ; 1987d
	AND A,A ; 19881
	JRS Z,loc_0x01988A ; 19882

	LD A,#02h ; 19884
	LD [mn_pending_sfx],A ; 19886

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

	farload x, pool_0380B8
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
	LD A,[sfx_vol] ; 199cc
	AND A,A ; 199d0
	JRS Z,loc_0x0199D9 ; 199d1
	LD A,#01h ; 199d3
	LD [mn_pending_sfx],A ; 199d5
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
	LD A,[sfx_vol] ; 199ec
	AND A,A ; 199f0
	JRS Z,loc_0x0199F9 ; 199f1
	LD A,#02h ; 199f3
	LD [mn_pending_sfx],A ; 199f5
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
	LD A,[sfx_vol] ; 19ab5
	AND A,A ; 19ab9
	JRS Z,loc_0x019AC2 ; 19aba
	LD A,#02h ; 19abc
	LD [mn_pending_sfx],A ; 19abe
loc_0x019AC2:
	JRS loc_0x019AD1
; ---------------------- ; 19ac2
loc_0x019AC4:
	LD A,[sfx_vol] ; 19ac4
	AND A,A ; 19ac8
	JRS Z,loc_0x019AD1 ; 19ac9
	LD A,#01h ; 19acb
	LD [mn_pending_sfx],A ; 19acd
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
	farcall loc_0x011ADC ; 19b21
	farcall loc_0x002BF9 ; 19b27
	farcall loc_0x0382F4 ; 19b2d
	LD IY,#9ADAh ; 19b30
	LD YP,#01h ; 19b33
	CARL load_bgstruct ; 19b36
	CARL loc_0x019B7E ; 19b39
	LD IY,#13AEh ; 19b3c
	farcall loc_0x011B84 ; 19b42
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
	LD A,[sfx_vol] ; 19b5b
	AND A,A ; 19b5f
	JRS Z,loc_0x019B68 ; 19b60
	LD A,#02h ; 19b62
	LD [mn_pending_sfx],A ; 19b64
loc_0x019B68:
	JRS loc_0x019B77
; ---------------------- ; 19b68
loc_0x019B6A:
	LD A,[sfx_vol] ; 19b6a
	AND A,A ; 19b6e
	JRS Z,loc_0x019B77 ; 19b6f
	LD A,#01h ; 19b71
	LD [mn_pending_sfx],A ; 19b73
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
	farcall loc_0x011ADC ; 19c0f
	farcall loc_0x002BF9 ; 19c15
	farcall loc_0x0382F4 ; 19c1b
	LD IY,#9BB8h ; 19c1e
	LD YP,#01h ; 19c21
	CARL load_bgstruct ; 19c24
	CARL loc_0x019635 ; 19c27
	CARL loc_0x019C59 ; 19c2a
	LD HL,#0000h ; 19c2d
	LD IY,#261Fh ; 19c30
	farcall loc_0x011B84 ; 19c36
	LD HL,#0600h ; 19c39
	LD IY,#94F2h ; 19c3c
	farcall loc_0x03836A ; 19c42
	LD IY,#13AEh ; 19c45
	farcall loc_0x011B84 ; 19c4b
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
	farcall loc_0x011ADC ; 19cc7
	farcall loc_0x002BF9 ; 19ccd
	farcall loc_0x0382F4 ; 19cd3
	LD IY,#9C80h ; 19cd6
	LD YP,#01h ; 19cd9
	CARL load_bgstruct ; 19cdc
	CARL loc_0x019635 ; 19cdf
	CARL loc_0x019D05 ; 19ce2
	LD HL,#0000h ; 19ce5
	LD IY,#2625h ; 19ce8
	farcall loc_0x011B84 ; 19cee
	LD IY,#13AEh ; 19cf1
	farcall loc_0x011B84 ; 19cf7
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
	LD A,[sfx_vol] ; 19d95
	AND A,A ; 19d99
	JRS Z,loc_0x019DA2 ; 19d9a
	LD A,#02h ; 19d9c
	LD [mn_pending_sfx],A ; 19d9e
loc_0x019DA2:
	CARL loc_0x0022EE ; 19da2
	JRS loc_0x019DB9
; ---------------------- ; 19da5
	DB 0F1h, 14h
; ---------------------- ; 19da7
loc_0x019DA9:
	LD A,[sfx_vol] ; 19da9
	AND A,A ; 19dad
	JRS Z,loc_0x019DB6 ; 19dae
	LD A,#02h ; 19db0
	LD [mn_pending_sfx],A ; 19db2
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
	DB 1Bh ; 19e14

global loc_0x019E15
loc_0x019E15:
	CARL loc_0x004B13 ; 19e15
	CARL loc_0x0046B6 ; 19e18
	CARL loc_0x0021F4 ; 19e1b
	CARL loc_0x002338 ; 19e1e
	farcall loc_0x011ADC ; 19e24
	farcall loc_0x002BF9 ; 19e2a
	farcall loc_0x0382F4 ; 19e30
	LD IY,#9DE4h ; 19e33
	LD YP,#01h ; 19e36
	CARL load_bgstruct ; 19e39
	LD HL,#15D1h ; 19e3c
	LD [166Dh],HL ; 19e3f
	LD HL,#3000h ; 19e42
	LD IY,#26EBh ; 19e45
	farcall loc_0x011B84 ; 19e4b
	LD IY,#13AEh ; 19e4e
	farcall loc_0x011B84 ; 19e54
	CARL loc_0x00233F ; 19e57
	CARL loc_0x0021FB ; 19e5a
	RET
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
	LD A,[sfx_vol] ; 19eb6
	AND A,A ; 19eba
	JRS Z,loc_0x019EC3 ; 19ebb
	LD A,#01h ; 19ebd
	LD [mn_pending_sfx],A ; 19ebf
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
	farcall loc_0x011ADC ; 19f00
	farcall loc_0x002BF9 ; 19f06
	farcall loc_0x0382F4 ; 19f0c
	LD IY,#9EC4h ; 19f0f
	LD YP,#01h ; 19f12
	CARL load_bgstruct ; 19f15
	LD A,[1AE9h] ; 19f18
	farcall loc_0x012476 ; 19f1f
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
	farcall loc_0x011B84 ; 19f5e
	LD HL,#0001h ; 19f61
	LD IY,#8D92h ; 19f64
	farcall loc_0x03836A ; 19f6a
	LD HL,#0100h ; 19f6d
	LD IY,#8E3Dh ; 19f70
	farcall loc_0x03836A ; 19f76
	LD HL,#0305h ; 19f79
	LD IY,#8DF4h ; 19f7c
	farcall loc_0x03836A ; 19f82
	LD IY,#13AEh ; 19f85
	farcall loc_0x011B84 ; 19f8b
	CARL loc_0x00233F ; 19f8e
	CARL loc_0x0021FB ; 19f91
	LD A,[1AE9h] ; 19f94
	farcall loc_0x012476 ; 19f9b
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
	farcall loc_0x00AA46 ; 19fd4
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
	farcall loc_0x012476 ; 19ff2
	CP A,#06h ; 19ff5
	JRS NZ,loc_0x019FFF ; 19ff7
	LD A,#2Ch ; 19ff9
	LD [pet_y],A ; 19ffb
loc_0x019FFF:
	LD A,[sfx_vol] ; 19fff
	AND A,A ; 1a003
	JRS Z,loc_0x01A00C ; 1a004
	LD A,#02h ; 1a006
	LD [mn_pending_sfx],A ; 1a008
loc_0x01A00C:
	CARL loc_0x0022EE ; 1a00c
	CARL loc_0x00228F ; 1a00f
loc_0x01A012:
	RET
; ---------------------- ; 1a012
loc_0x01A013:
	LD A,[1AE9h] ; 1a013
	farcall loc_0x012476 ; 1a01a
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
	farcall loc_0x011EB1 ; 1a056
	LD HL,#1B50h ; 1a059
	LD IY,#6800h ; 1a05c
	farcall loc_0x011B84 ; 1a062
	LD HL,#2C40h ; 1a065
	LD [pet_x],HL ; 1a068
	LD IY,#6D90h ; 1a06b
	farcall loc_0x011B84 ; 1a071
	RET
; ---------------------- ; 1a074
loc_0x01A075:
	LD HL,#0000h ; 1a075
	LD IY,#0C445h ; 1a078
	LD YP,#00h ; 1a07b
	farcall loc_0x011EB1 ; 1a081
	LD HL,#1040h ; 1a084
	LD [pet_x],HL ; 1a087
	LD IY,#4E53h ; 1a08a
	farcall loc_0x011B84 ; 1a090
	LD HL,#2C28h ; 1a093
	LD [pet_x],HL ; 1a096
	LD IY,#4F6Fh ; 1a099
	farcall loc_0x011B84 ; 1a09f
	LD HL,#1907h ; 1a0a2
	LD IY,#4F89h ; 1a0a5
	farcall loc_0x011B84 ; 1a0ab
	LD HL,#1907h ; 1a0ae
	LD IY,#4F95h ; 1a0b1
	farcall loc_0x011B84 ; 1a0b7
	RET
; ---------------------- ; 1a0ba
loc_0x01A0BB:
	LD HL,#0000h ; 1a0bb
	LD IY,#0C445h ; 1a0be
	LD YP,#00h ; 1a0c1
	farcall loc_0x011EB1 ; 1a0c7
	LD HL,#0F20h ; 1a0ca
	LD IY,#4AF7h ; 1a0cd
	farcall loc_0x011B84 ; 1a0d3
	LD HL,#0F20h ; 1a0d6
	LD IY,#4A8Eh ; 1a0d9
	farcall loc_0x011B84 ; 1a0df
	LD HL,#3028h ; 1a0e2
	LD [pet_x],HL ; 1a0e5
	LD IY,#4D37h ; 1a0e8
	farcall loc_0x011B84 ; 1a0ee
	RET
; ---------------------- ; 1a0f1
loc_0x01A0F2:
	LD HL,#0000h ; 1a0f2
	LD IY,#0C445h ; 1a0f5
	LD YP,#00h ; 1a0f8
	farcall loc_0x011EB1 ; 1a0fe
	LD HL,#0800h ; 1a101
	LD [1B10h],HL ; 1a104
	LD IY,#4FEAh ; 1a107
	farcall loc_0x011B84 ; 1a10d
	LD HL,#2C28h ; 1a110
	LD [pet_x],HL ; 1a113
	LD IY,#5692h ; 1a116
	farcall loc_0x011B84 ; 1a11c
	RET
; ---------------------- ; 1a11f
loc_0x01A120:
	LD HL,#0800h ; 1a120
	LD IY,#5A1Dh ; 1a123
	farcall loc_0x011B84 ; 1a129
	LD HL,#0000h ; 1a12c
	LD IY,#0C445h ; 1a12f
	LD YP,#00h ; 1a132
	farcall loc_0x011EB1 ; 1a138
	LD HL,#2C28h ; 1a13b
	LD [pet_x],HL ; 1a13e
	LD IY,#5AA7h ; 1a141
	farcall loc_0x011B84 ; 1a147
	RET
; ---------------------- ; 1a14a
loc_0x01A14B:
	XOR A,A ; 1a14b
	LD [1B3Dh],A ; 1a14c
	LD [1B3Eh],A ; 1a150
	LD HL,#2C2Dh ; 1a154
	LD IY,#5AB3h ; 1a157
	farcall loc_0x011B84 ; 1a15d
	LD HL,#1246h ; 1a160
	LD IY,#5AE6h ; 1a163
	farcall loc_0x011B84 ; 1a169
	LD HL,#0000h ; 1a16c
	LD IY,#0C445h ; 1a16f
	LD YP,#00h ; 1a172
	farcall loc_0x011EB1 ; 1a178
	LD HL,#2C1Eh ; 1a17b
	LD [pet_x],HL ; 1a17e
	LD HL,#2C2Dh ; 1a181
	LD IY,#5BE5h ; 1a184
	farcall loc_0x011B84 ; 1a18a
	LD HL,#2C2Dh ; 1a18d
	LD IY,#5C2Fh ; 1a190
	farcall loc_0x011B84 ; 1a196
	RET
; ---------------------- ; 1a199
loc_0x01A19A:
	XOR A,A ; 1a19a
	LD [1B41h],A ; 1a19b
	LD HL,#2D4Fh ; 1a19f
	LD [1B10h],HL ; 1a1a2
	LD IY,#5DDAh ; 1a1a5
	farcall loc_0x011B84 ; 1a1ab
	LD HL,#0000h ; 1a1ae
	LD IY,#61A0h ; 1a1b1
	farcall loc_0x011B84 ; 1a1b7
	LD HL,#2C00h ; 1a1ba
	LD [pet_x],HL ; 1a1bd
	LD IY,#6118h ; 1a1c0
	farcall loc_0x011B84 ; 1a1c6
	LD HL,#0000h ; 1a1c9
	LD IY,#614Fh ; 1a1cc
	farcall loc_0x011B84 ; 1a1d2
	RET
; ---------------------- ; 1a1d5
loc_0x01A1D6:
	XOR A,A ; 1a1d6
	LD [1B42h],A ; 1a1d7
	LD HL,#0000h ; 1a1db
	LD IY,#61A0h ; 1a1de
	farcall loc_0x011B84 ; 1a1e4
	LD HL,#0800h ; 1a1e7
	LD IY,#6790h ; 1a1ea
	farcall loc_0x011B84 ; 1a1f0
	LD HL,#2C18h ; 1a1f3
	LD [1B10h],HL ; 1a1f6
	LD IY,#6625h ; 1a1f9
	farcall loc_0x011B84 ; 1a1ff
	LD HL,#2C38h ; 1a202
	LD [pet_x],HL ; 1a205
	LD IY,#6421h ; 1a208
	farcall loc_0x011B84 ; 1a20e
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
	LD A,[sfx_vol] ; 1a28d
	AND A,A ; 1a291
	JRS Z,loc_0x01A29A ; 1a292
	LD A,#01h ; 1a294
	LD [mn_pending_sfx],A ; 1a296
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
	LD A,[sfx_vol] ; 1a2ae
	AND A,A ; 1a2b2
	JRS Z,loc_0x01A2BB ; 1a2b3
	LD A,#02h ; 1a2b5
	LD [mn_pending_sfx],A ; 1a2b7
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
	farcall loc_0x011ADC ; 1a2f1
	farcall loc_0x002BF9 ; 1a2f7
	farcall loc_0x0382F4 ; 1a2fd
	LD IY,#0A2C2h ; 1a300
	LD YP,#01h ; 1a303
	CARL load_bgstruct ; 1a306
	LD A,#01h ; 1a309
	LD [168Eh],A ; 1a30b
	LD HL,#0000h ; 1a30f
	LD IY,#0697h ; 1a312
	farcall loc_0x011B84 ; 1a318
	LD IY,#13AEh ; 1a31b
	farcall loc_0x011B84 ; 1a321
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
	LD A,[sfx_vol] ; 1a33d
	AND A,A ; 1a341
	JRS Z,loc_0x01A34A ; 1a342
	LD A,#01h ; 1a344
	LD [mn_pending_sfx],A ; 1a346
loc_0x01A34A:
	LD A,[168Eh] ; 1a34a
	AND A,A ; 1a34e
	JRS NZ,loc_0x01A365 ; 1a34f
	CARL loc_0x0022D4 ; 1a351
	CARL loc_0x00228F ; 1a354
	RET
; ---------------------- ; 1a357
loc_0x01A358:
	LD A,[sfx_vol] ; 1a358
	AND A,A ; 1a35c
	JRS Z,loc_0x01A365 ; 1a35d
	LD A,#02h ; 1a35f
	LD [mn_pending_sfx],A ; 1a361
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
	farcall loc_0x011ADC ; 1a39b
	farcall loc_0x002BF9 ; 1a3a1
	farcall loc_0x0382F4 ; 1a3a7
	LD IY,#0A36Ch ; 1a3aa
	LD YP,#01h ; 1a3ad
	CARL load_bgstruct ; 1a3b0
	LD HL,#0000h ; 1a3b3
	LD IY,#70B3h ; 1a3b6
	farcall loc_0x011B84 ; 1a3bc
	LD IY,#13AEh ; 1a3bf
	farcall loc_0x011B84 ; 1a3c5
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
	LD [pet_x],HL ; 1a423
	LD HL,#0800h ; 1a426
	LD [1B10h],HL ; 1a429
	LD A,#0FFh ; 1a42c
	LD [1AD6h],A ; 1a42e
	CARL loc_0x0021F4 ; 1a432
	CARL loc_0x002338 ; 1a435
	farcall loc_0x011ADC ; 1a43b
	farcall loc_0x002BF9 ; 1a441
	farcall loc_0x0382F4 ; 1a447
	LD IY,#0A3D3h ; 1a44a
	LD YP,#01h ; 1a44d
	CARL load_bgstruct ; 1a450
	LD A,#13h ; 1a453
	LD [1360h],A ; 1a455
	LD HL,[1B10h] ; 1a459
	LD IY,#0BCD3h ; 1a45c
	LD YP,#00h ; 1a45f
	farcall loc_0x011EB1 ; 1a465
	LD HL,#2D4Bh ; 1a468
	LD IY,#276Fh ; 1a46b
	farcall loc_0x011B84 ; 1a471
	LD HL,[pet_x] ; 1a474
	LD IY,#0CE4Dh ; 1a477
	LD YP,#00h ; 1a47a
	farcall loc_0x011EB1 ; 1a480
	LD HL,#0000h ; 1a483
	LD IY,#0B8F2h ; 1a486
	LD YP,#00h ; 1a489
	farcall loc_0x011EB1 ; 1a48f
	LD HL,#2D4Bh ; 1a492
	LD IY,#2775h ; 1a495
	farcall loc_0x011B84 ; 1a49b
	LD HL,#0001h ; 1a49e
	LD IY,#8D92h ; 1a4a1
	farcall loc_0x03836A ; 1a4a7
	LD HL,#0100h ; 1a4aa
	LD IY,#8E3Dh ; 1a4ad
	farcall loc_0x03836A ; 1a4b3
	LD HL,#0305h ; 1a4b6
	LD IY,#8DF4h ; 1a4b9
	farcall loc_0x03836A ; 1a4bf
	LD A,#00h ; 1a4c2
	CARL loc_0x01898C ; 1a4c4
	LD IY,#13AEh ; 1a4c7
	farcall loc_0x011B84 ; 1a4cd
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
	farcall loc_0x011ADC ; 1a52b
	farcall loc_0x002BF9 ; 1a531
	farcall loc_0x0382F4 ; 1a537
	LD IY,#0A4DBh ; 1a53a
	LD YP,#01h ; 1a53d
	CARL load_bgstruct ; 1a540
	LD A,#13h ; 1a543
	LD [1360h],A ; 1a545
	LD HL,#0000h ; 1a549
	LD IY,#0C445h ; 1a54c
	LD YP,#00h ; 1a54f
	farcall loc_0x011EB1 ; 1a555
	LD HL,[1B10h] ; 1a558
	LD IY,#0BCD3h ; 1a55b
	LD YP,#00h ; 1a55e
	farcall loc_0x011EB1 ; 1a564
	LD HL,#2D4Bh ; 1a567
	LD IY,#276Fh ; 1a56a
	farcall loc_0x011B84 ; 1a570
	LD HL,[pet_x] ; 1a573
	LD IY,#0CF44h ; 1a576
	LD YP,#00h ; 1a579
	farcall loc_0x011EB1 ; 1a57f
	LD HL,#0000h ; 1a582
	LD IY,#0B8F2h ; 1a585
	LD YP,#00h ; 1a588
	farcall loc_0x011EB1 ; 1a58e
	LD HL,#2D4Bh ; 1a591
	LD IY,#2775h ; 1a594
	farcall loc_0x011B84 ; 1a59a
	LD HL,#0001h ; 1a59d
	LD IY,#8D92h ; 1a5a0
	farcall loc_0x03836A ; 1a5a6
	LD HL,#0100h ; 1a5a9
	LD IY,#8E3Dh ; 1a5ac
	farcall loc_0x03836A ; 1a5b2
	LD HL,#0305h ; 1a5b5
	LD IY,#8DF4h ; 1a5b8
	farcall loc_0x03836A ; 1a5be
	LD A,#00h ; 1a5c1
	CARL loc_0x01898C ; 1a5c3
	LD IY,#13AEh ; 1a5c6
	farcall loc_0x011B84 ; 1a5cc
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

	farcall loc_0x011ADC ; 1a609

	farcall loc_0x002BF9 ; 1a60f

	farcall loc_0x0382F4 ; 1a615

	LD IY,#0A5DAh ; 1a618
	LD YP,#01h ; 1a61b
	CARL load_bgstruct ; 1a61e

	LD HL,#0000h ; 1a621
	LD IY,#72E8h ; 1a624
	farcall loc_0x011B84 ; 1a62a

	LD HL,#0000h ; 1a62d
	LD IY,#731Ch ; 1a630
	farcall loc_0x011B84 ; 1a636

	LD HL,#0000h ; 1a639
	LD IY,#7336h ; 1a63c
	farcall loc_0x011B84 ; 1a642

loc_0x01A645:

	LD HL,#060Ah ; 1a645
	LD IY,#951Bh ; 1a648
	farcall loc_0x03836A ; 1a64e

	LD IY,#13AEh ; 1a651
	farcall loc_0x011B84 ; 1a657

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

	LD A,[sfx_vol] ; 1a670
	AND A,A ; 1a674
	JRS Z,loc_0x01A67D ; 1a675

	LD A,#02h ; 1a677
	LD [mn_pending_sfx],A ; 1a679

loc_0x01A67D:

	JRS loc_0x01A68C

loc_0x01A67F:

	LD A,[sfx_vol] ; 1a67f
	AND A,A ; 1a683

	JRS Z,loc_0x01A68C ; 1a684

	LD A,#01h ; 1a686
	LD [mn_pending_sfx],A ; 1a688

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

	farcall loc_0x011ADC ; 1a6d4

	farcall loc_0x002BF9 ; 1a6da

	farcall loc_0x0382F4 ; 1a6e0

	LD IY,#0A693h ; 1a6e3
	LD YP,#01h ; 1a6e6
	CARL load_bgstruct ; 1a6e9

	LD HL,#0800h ; 1a6ec
	LD [1B10h],HL ; 1a6ef

	LD IY,#0BCD3h ; 1a6f2
	LD YP,#00h ; 1a6f5
	farcall loc_0x011EB1 ; 1a6fb

	LD HL,#0000h ; 1a6fe
	LD IY,#7524h ; 1a701
	farcall loc_0x011B84 ; 1a707

	LD HL,#0000h ; 1a70a
	LD IY,#752Ah ; 1a70d
	farcall loc_0x011B84 ; 1a713

	LD HL,#2D4Bh ; 1a716
	LD IY,#276Fh ; 1a719
	farcall loc_0x011B84 ; 1a71f

	LD H,[1B23h] ; 1a722
	LD L,#28h ; 1a726
	LD [pet_x],HL ; 1a728

	LD IY,#0B813h ; 1a72b
	LD YP,#00h ; 1a72e
	farcall loc_0x011EB1 ; 1a734

	LD HL,#0000h ; 1a737
	LD IY,#0B8F2h ; 1a73a
	LD YP,#00h ; 1a73d
	farcall loc_0x011EB1 ; 1a743

	LD HL,#2D4Bh ; 1a746
	LD IY,#2775h ; 1a749
	farcall loc_0x011B84 ; 1a74f

	LD HL,#0001h ; 1a752
	LD IY,#8D92h ; 1a755
	farcall loc_0x03836A ; 1a75b

	LD HL,#0100h ; 1a75e
	LD IY,#8E3Dh ; 1a761
	farcall loc_0x03836A ; 1a767

	LD HL,#0305h ; 1a76a
	LD IY,#8DF4h ; 1a76d
	farcall loc_0x03836A ; 1a773

	LD A,#01h ; 1a776
	CARL loc_0x01898C ; 1a778

	LD IY,#13AEh ; 1a77b
	farcall loc_0x011B84 ; 1a781

	CARL loc_0x00233F ; 1a784
	CARL loc_0x0021FB ; 1a787

	RET
; ---------------------- ; 1a78a
loc_0x01A78B:

	CARL loc_0x002346 ; 1a78b

	LD A,[1643h] ; 1a78e
	BIT A,#02h ; 1a792

	JRS Z,loc_0x01A7A9 ; 1a794

	LD A,[sfx_vol] ; 1a796
	AND A,A ; 1a79a

	JRS Z,loc_0x01A7A3 ; 1a79b

	LD A,#02h ; 1a79d
	LD [mn_pending_sfx],A ; 1a79f

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

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Transition to help menu
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x01A7D0:

	CARL loc_0x0021F4 ; 1a7d0
	CARL loc_0x002338 ; 1a7d3

	LD NB,#@CPAG(loc_0x011ADC)
	CARL loc_0x011ADC ; 1a7d9

	LD NB,#@CPAG(loc_0x002BF9)
	CARL loc_0x002BF9 ; 1a7df

	LD NB,#@CPAG(loc_0x0382F4)
	CARL loc_0x0382F4 ; 1a7e5

	LD IY,#0A7AAh ; 1a7e8
	LD YP,#01h ; 1a7eb
	CARL load_bgstruct ; 1a7ee

	LD HL,#1800h ; 1a7f1
	LD IY,#23B5h ; 1a7f4
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1a7fa

	LD HL,#1858h ; 1a7fd
	LD IY,#23A3h ; 1a800
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1a806

	LD HL,#1810h ; 1a809
	LD IY,#76B2h ; 1a80c
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1a812

	LD HL,#1840h ; 1a815
	LD IY,#769Ah ; 1a818
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1a81e

	LD HL,#1828h ; 1a821
	LD IY,#7683h ; 1a824
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1a82a

	LD HL,#0602h ; 1a82d
	LD IY,#94B4h ; 1a830
	LD NB,#@CPAG(loc_0x03836A)
	CARL loc_0x03836A ; 1a836

	LD IY,#13AEh ; 1a839
	LD NB,#@CPAG(loc_0x011B84)
	CARL loc_0x011B84 ; 1a83f

	CARL loc_0x00233F ; 1a842
	CARL loc_0x0021FB ; 1a845

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Help menu update
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x01A849:

	CARL loc_0x0189F1 ; 1a849
	CARL loc_0x002346 ; 1a84c

	LD A,[1643h] ; 1a84f
	BIT A,#01h ; 1a853
	JRS NZ,loc_0x01A86F ; 1a855

	BIT A,#02h ; 1a857
	JRS Z,loc_0x01A882 ; 1a859

	LD A,[sfx_vol] ; 1a85b
	AND A,A ; 1a85f
	JRS Z,loc_0x01A868 ; 1a860

	LD A,#02h ; 1a862
	LD [mn_pending_sfx],A ; 1a864

loc_0x01A868:

	CARL loc_0x0022EE ; 1a868
	CARL loc_0x00228F ; 1a86b

	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Transition to help menu section
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x01A86F:

	LD A,[sfx_vol] ; 1a86f
	AND A,A ; 1a873
	JRS Z,loc_0x01A87C ; 1a874

	LD A,#01h ; 1a876
	LD [mn_pending_sfx],A ; 1a878

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
	farcall loc_0x011ADC ; 1a8b5
	farcall loc_0x002BF9 ; 1a8bb
	farcall loc_0x0382F4 ; 1a8c1
	LD IY,#0A883h ; 1a8c4
	LD YP,#01h ; 1a8c7
	CARL load_bgstruct ; 1a8ca
	LD A,[1AD4h] ; 1a8cd
	farcall loc_0x01724C ; 1a8d4
	LD HL,#0000h ; 1a8d7
	LD IY,#72EEh ; 1a8da
	farcall loc_0x011B84 ; 1a8e0
	LD HL,#0000h ; 1a8e3
	LD IY,#7302h ; 1a8e6
	farcall loc_0x011B84 ; 1a8ec
	LD HL,#0000h ; 1a8ef
	LD IY,#7342h ; 1a8f2
	farcall loc_0x011B84 ; 1a8f8
	LD IY,#13AEh ; 1a8fb
	farcall loc_0x011B84 ; 1a901
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
	LD A,[sfx_vol] ; 1a91a
	AND A,A ; 1a91e
	JRS Z,loc_0x01A927 ; 1a91f
	LD A,#02h ; 1a921
	LD [mn_pending_sfx],A ; 1a923
loc_0x01A927:
	JRS loc_0x01A936
; ---------------------- ; 1a927
loc_0x01A929:
	LD A,[sfx_vol] ; 1a929
	AND A,A ; 1a92d
	JRS Z,loc_0x01A936 ; 1a92e
	LD A,#01h ; 1a930
	LD [mn_pending_sfx],A ; 1a932
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
	farcall loc_0x012476 ; 1aa06
	RET
; ---------------------- ; 1aa09
loc_0x01AA0A:
	CP A,#08h ; 1aa0a
	JRS NC,loc_0x01AA1C ; 1aa0c
	farcall loc_0x012495 ; 1aa11
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
	CARL load_bgstruct ; 1aa61
	CARL loc_0x01AABF ; 1aa64
	LD IY,#13AEh ; 1aa67
	farcall loc_0x011B84 ; 1aa6d
	CARL loc_0x00233F ; 1aa70
	CARL loc_0x0021FB ; 1aa73
	LD A,[sfx_vol] ; 1aa76
	AND A,A ; 1aa7a
	JRS Z,loc_0x01AA83 ; 1aa7b
	LD A,#22h ; 1aa7d
	LD [mn_pending_sfx],A ; 1aa7f
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
	LD A,[sfx_vol] ; 1aa96
	AND A,A ; 1aa9a
	JRS Z,loc_0x01AAA3 ; 1aa9b
	LD A,#02h ; 1aa9d
	LD [mn_pending_sfx],A ; 1aa9f
loc_0x01AAA3:
	JRS loc_0x01AAB2
; ---------------------- ; 1aaa3
loc_0x01AAA5:
	LD A,[sfx_vol] ; 1aaa5
	AND A,A ; 1aaa9
	JRS Z,loc_0x01AAB2 ; 1aaaa
	LD A,#01h ; 1aaac
	LD [mn_pending_sfx],A ; 1aaae
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
	farcall loc_0x011ADC ; 1ab73
	farcall loc_0x002BF9 ; 1ab79
	farcall loc_0x0382F4 ; 1ab7f
	farcall loc_0x00287D ; 1ab85
	JRS loc_0x01ABA2
; ---------------------- ; 1ab88
loc_0x01AB8A:
	CARL loc_0x0021F4 ; 1ab8a
	CARL loc_0x002338 ; 1ab8d
	farcall loc_0x011ADC ; 1ab93
	LD NB,#00h ; 1ab96
loc_0x01AB99:
	CARL loc_0x002BF9 ; 1ab99
	farcall loc_0x0382F4 ; 1ab9f
loc_0x01ABA2:
	LD IY,#0AB44h ; 1aba2
	LD YP,#01h ; 1aba5
	CARL load_bgstruct ; 1aba8
	LD IY,#76E7h ; 1abab
	farcall loc_0x011B84 ; 1abb1
	LD IY,#13AEh ; 1abb4
	farcall loc_0x011B84 ; 1abba
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
	farcall loc_0x011ADC ; 1e677
	farcall loc_0x002BF9 ; 1e67d
	farcall loc_0x0382F4 ; 1e683
	CARL loc_0x00287D ; 1e686
	JRS loc_0x01E6A3
; ---------------------- ; 1e689
loc_0x01E68B:
	CARL loc_0x0021F4 ; 1e68b
	CARL loc_0x002338 ; 1e68e
	farcall loc_0x011ADC ; 1e694
	farcall loc_0x002BF9 ; 1e69a
	farcall loc_0x0382F4 ; 1e6a0
loc_0x01E6A3:
	LD A,[1ABCh] ; 1e6a3
	AND A,A ; 1e6a7
	JRL NZ,loc_0x01AB8A ; 1e6a8
	CARL loc_0x01E791 ; 1e6ab
	XOR A,A ; 1e6ae
	JRS loc_0x01E6CB
; ---------------------- ; 1e6af
loc_0x01E6B1:
	CARL loc_0x0021F4 ; 1e6b1
	CARL loc_0x002338 ; 1e6b4
	farcall loc_0x011ADC
	farcall loc_0x002BF9
	farcall loc_0x0382F4
	LD A,#01h ; 1e6c9
loc_0x01E6CB:
	LD [1BABh],A ; 1e6cb
	LD IY,#0E638h ; 1e6cf
	LD YP,#01h ; 1e6d2
	CARL load_bgstruct ; 1e6d5
	LD A,#00h ; 1e6d8
	LD [164Dh],A ; 1e6da
	CARL loc_0x01E7B4 ; 1e6de
	XOR A,A ; 1e6e1
	LD [1BB3h],A ; 1e6e2
	LD [1BB4h],A ; 1e6e6
	farcall loc_0x01E65E ; 1e6ed
	CP A,#00h ; 1e6f0
	JRS Z,loc_0x01E6F6 ; 1e6f2
	LD A,#3Bh ; 1e6f4
loc_0x01E6F6:
	LD [1BB6h],A ; 1e6f6
	farcall loc_0x01E65E ; 1e6fd
	CP A,#05h ; 1e700
	JRS NZ,loc_0x01E705 ; 1e702
	DEC A ; 1e704
loc_0x01E705:
	LD [1BB5h],A ; 1e705
	LD HL,#0000h ; 1e709
	LD IY,#0D74h ; 1e70c
	farcall loc_0x011B84 ; 1e712
	LD HL,#0018h ; 1e715
	LD IY,#07B6h ; 1e718
	farcall loc_0x011B84 ; 1e71e
	LD HL,#0060h ; 1e721
	LD IY,#0E7Fh ; 1e724
	farcall loc_0x011B84 ; 1e72a
	LD HL,#0040h ; 1e72d
	LD IY,#0DA5h ; 1e730
	farcall loc_0x011B84 ; 1e736
    
	LD IY,#@DOFF(pool_0395ee)
	farcall loc_0x03836A ; 1e73f
    
	LD IY,#@DOFF(pool_039643)
	farcall loc_0x03836A ; 1e748
    
	LD IY,#@DOFF(pool_0113AE)
	farcall loc_0x011B84 ; 1e751
    
	CARL loc_0x00233F ; 1e754
	CARL loc_0x0021FB ; 1e757
	RET
; ---------------------- ; 1e75a
loc_0x01E75B:
	CARL loc_0x002346 ; 1e75b
	LD HL,#keys_new_unpressed
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
    
	farload code, loc_0x01AB6A
	CARL loc_0x00228F ; 1e783
	RET
; ---------------------- ; 1e786
loc_0x01E787:
	farload code, loc_0x0180CF
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
	DB 0A1h, 0F2h, 0AAh, 3Ah, 0F8h ; 1e899

bgstruct_01e89e:
    bgstruct 0Dh, 04h, 3Eh, tiles_dialogue_font,                \
    tiles_dialogue_font, sprites_dialogue, sprites_dialogue,    \
	loc_0x002F6D, loc_0x01E91C, loc_0x01A7D0, loc_0x01A7D0,     \
    18h, 08h, 02h, NULL, unk_graphics_037AA0, 0Ch, 08h
; ---------------------- ; 1e8c1
loc_0x01E8C4:
	CARL loc_0x0021F4 ; 1e8c4
	CARL loc_0x002338 ; 1e8c7
	farcall loc_0x011ADC ; 1e8cd
	farcall loc_0x002BF9 ; 1e8d3
	farcall loc_0x0382F4 ; 1e8d9
    
	farload y, bgstruct_01e89e
	CARL load_bgstruct ; 1e8e2
    
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
	farcall loc_0x03836A ; 1e909
	LD IY,#13AEh ; 1e90c
	farcall loc_0x011B84 ; 1e912
	CARL loc_0x00233F ; 1e915
	CARL loc_0x0021FB ; 1e918
	RET
; ---------------------- ; 1e91b
loc_0x01E91C:
	CARL loc_0x0189F1 ; 1e91c
	CARL loc_0x002346 ; 1e91f
	RET
; ---------------------- ; 1e922
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
	LD A,[sfx_vol] ; 1e99c
	AND A,A ; 1e9a0
	JRS Z,loc_0x01E9A9 ; 1e9a1
	LD A,#01h ; 1e9a3
	LD [mn_pending_sfx],A ; 1e9a5
loc_0x01E9A9:
	CARL loc_0x01E9C3 ; 1e9a9
	RET
; ---------------------- ; 1e9ac
loc_0x01E9AD:
	LD A,[sfx_vol] ; 1e9ad
	AND A,A ; 1e9b1
	JRS Z,loc_0x01E9BA ; 1e9b2
	LD A,#02h ; 1e9b4
	LD [mn_pending_sfx],A ; 1e9b6
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
	LD A,[sfx_vol] ; 1ea45
	AND A,A ; 1ea49
	JRS Z,loc_0x01EA52 ; 1ea4a
	LD A,#01h ; 1ea4c
	LD [mn_pending_sfx],A ; 1ea4e
loc_0x01EA52:
	CARL loc_0x01EA78 ; 1ea52
	RET
; ---------------------- ; 1ea55
loc_0x01EA56:
	LD A,[sfx_vol] ; 1ea56
	AND A,A ; 1ea5a
	JRS Z,loc_0x01EA63 ; 1ea5b
	LD A,#02h ; 1ea5d
	LD [mn_pending_sfx],A ; 1ea5f
loc_0x01EA63:
	CARL loc_0x01EACC ; 1ea63
	RET
; ---------------------- ; 1ea66
loc_0x01EA67:
	LD A,[sfx_vol] ; 1ea67
	AND A,A ; 1ea6b
	JRS Z,loc_0x01EA74 ; 1ea6c
	LD A,#03h ; 1ea6e
	LD [mn_pending_sfx],A ; 1ea70
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
	farcall loc_0x019B89 ; 1ea8c
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
	LD A,[sfx_vol] ; 1eaa0
	AND A,A ; 1eaa4
	JRS Z,loc_0x01EAAD ; 1eaa5
	LD A,#01h ; 1eaa7
	LD [mn_pending_sfx],A ; 1eaa9
loc_0x01EAAD:
	LD HL,#97C1h ; 1eaad
	LD B,#03h ; 1eab0
	CARL loc_0x00228F ; 1eab2
	RET
; ---------------------- ; 1eab5
loc_0x01EAB6:
	LD A,[sfx_vol] ; 1eab6
	AND A,A ; 1eaba
	JRS Z,loc_0x01EAC3 ; 1eabb
	LD A,#02h ; 1eabd
	LD [mn_pending_sfx],A ; 1eabf
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
	LD A,[sfx_vol] ; 1eaee
	AND A,A ; 1eaf2
	JRS Z,loc_0x01EAFB ; 1eaf3
	LD A,#01h ; 1eaf5
	LD [mn_pending_sfx],A ; 1eaf7
loc_0x01EAFB:
	LD HL,#97C1h ; 1eafb
	LD B,#03h ; 1eafe
	CARL loc_0x00228F ; 1eb00
	RET
; ---------------------- ; 1eb03
loc_0x01EB04:
	LD A,[sfx_vol] ; 1eb04
	AND A,A ; 1eb08
	JRS Z,loc_0x01EB11 ; 1eb09
	LD A,#02h ; 1eb0b
	LD [mn_pending_sfx],A ; 1eb0d
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
	LD A,[sfx_vol] ; 1eb3c
	AND A,A ; 1eb40
	JRS Z,loc_0x01EB49 ; 1eb41
	LD A,#01h ; 1eb43
	LD [mn_pending_sfx],A ; 1eb45
loc_0x01EB49:
	CARL loc_0x01E97A ; 1eb49
	RET
; ---------------------- ; 1eb4c
loc_0x01EB4D:
	LD A,[sfx_vol] ; 1eb4d
	AND A,A ; 1eb51
	JRS Z,loc_0x01EB5A ; 1eb52
	LD A,#02h ; 1eb54
	LD [mn_pending_sfx],A ; 1eb56
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
	LD A,[sfx_vol] ; 1ec55
	AND A,A ; 1ec59
	JRS Z,loc_0x01EC62 ; 1ec5a
	LD A,#01h ; 1ec5c
	LD [mn_pending_sfx],A ; 1ec5e
loc_0x01EC62:
	CARL loc_0x01EC88 ; 1ec62
	RET
; ---------------------- ; 1ec65
loc_0x01EC66:
	LD A,[sfx_vol] ; 1ec66
	AND A,A ; 1ec6a
	JRS Z,loc_0x01EC73 ; 1ec6b
	LD A,#02h ; 1ec6d
	LD [mn_pending_sfx],A ; 1ec6f
loc_0x01EC73:
	CARL loc_0x01ECDC ; 1ec73
	RET
; ---------------------- ; 1ec76
loc_0x01EC77:
	LD A,[sfx_vol] ; 1ec77
	AND A,A ; 1ec7b
	JRS Z,loc_0x01EC84 ; 1ec7c
	LD A,#03h ; 1ec7e
	LD [mn_pending_sfx],A ; 1ec80
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
	farcall loc_0x019BA0 ; 1ec9c
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
	LD A,[sfx_vol] ; 1ecb0
	AND A,A ; 1ecb4
	JRS Z,loc_0x01ECBD ; 1ecb5
	LD A,#01h ; 1ecb7
	LD [mn_pending_sfx],A ; 1ecb9
loc_0x01ECBD:
	LD HL,#9B18h ; 1ecbd
	LD B,#03h ; 1ecc0
	CARL loc_0x00228F ; 1ecc2
	RET
; ---------------------- ; 1ecc5
loc_0x01ECC6:
	LD A,[sfx_vol] ; 1ecc6
	AND A,A ; 1ecca
	JRS Z,loc_0x01ECD3 ; 1eccb
	LD A,#02h ; 1eccd
	LD [mn_pending_sfx],A ; 1eccf
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
	LD A,[sfx_vol] ; 1ecfe
	AND A,A ; 1ed02
	JRS Z,loc_0x01ED0B ; 1ed03
	LD A,#01h ; 1ed05
	LD [mn_pending_sfx],A ; 1ed07
loc_0x01ED0B:
	LD HL,#97C1h ; 1ed0b
	LD B,#03h ; 1ed0e
	CARL loc_0x00228F ; 1ed10
	RET
; ---------------------- ; 1ed13
loc_0x01ED14:
	LD A,[sfx_vol] ; 1ed14
	AND A,A ; 1ed18
	JRS Z,loc_0x01ED21 ; 1ed19
	LD A,#02h ; 1ed1b
	LD [mn_pending_sfx],A ; 1ed1d
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
	LD A,[sfx_vol] ; 1ed4c
	AND A,A ; 1ed50
	JRS Z,loc_0x01ED59 ; 1ed51
	LD A,#01h ; 1ed53
	LD [mn_pending_sfx],A ; 1ed55
loc_0x01ED59:
	CARL loc_0x01EBC5 ; 1ed59
	RET
; ---------------------- ; 1ed5c
loc_0x01ED5D:
	LD A,[sfx_vol] ; 1ed5d
	AND A,A ; 1ed61
	JRS Z,loc_0x01ED6A ; 1ed62
	LD A,#02h ; 1ed64
	LD [mn_pending_sfx],A ; 1ed66
loc_0x01ED6A:
	LD HL,#97C1h ; 1ed6a
	LD B,#03h ; 1ed6d
	CARL loc_0x00228F ; 1ed6f
	RET
; ---------------------- ; 1ed72
loc_0x01ED73:
	PUSH ALE ; 1ed73
	CARL loc_0x002987 ; 1ed75
	farcall keypad_fetch ; 1ed7b
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
	LD [BR:IO_DIR],#(IR_TX | RUMBLE | IR_DIS) ; 1eeac
	LD [BR:IO_DATA],#00h ; 1eeaf
	AND [BR:IRQ_ENA4],#7Fh ; 1eeb2
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
	LD [BR:IRQ_ACT4],#80h ; 1f0de
	LD A,#0FFh ; 1f0e1
	LD HL,#1BCAh ; 1f0e3
	CP IY,#0000h ; 1f0e6
	JRS Z,loc_0x01F0FA ; 1f0e9
loc_0x01F0EB:
	CP [HL],A ; 1f0eb
	JRS Z,loc_0x01F109 ; 1f0ed
	DEC IY ; 1f0ef
	JRS Z,loc_0x01F106 ; 1f0f0
	BIT [BR:IRQ_ACT4],#80h ; 1f0f2
	JRS Z,loc_0x01F0EB ; 1f0f5
	LD A,#00h ; 1f0f7
	RET
; ---------------------- ; 1f0f9
loc_0x01F0FA:
	CP [HL],A ; 1f0fa
	JRS Z,loc_0x01F109 ; 1f0fc
	BIT [BR:IRQ_ACT4],#80h ; 1f0fe
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
	LD [BR:IRQ_ACT4],#80h ; 1f10e
	LD A,#03h ; 1f111
	CARL loc_0x01EEC8 ; 1f113
	NOP ; 1f116
	INC B ; 1f117
	CP B,#0FAh ; 1f118
	JRL NC,loc_0x01F159 ; 1f11b
	BIT [BR:IRQ_ACT4],#80h ; 1f11e
	JRS NZ,loc_0x01F10E ; 1f121
	CP B,#03h ; 1f123
	JRL NC,loc_0x01F136 ; 1f126
	LD A,#06h ; 1f129
	CARL loc_0x01EEC8 ; 1f12b
	BIT [BR:IRQ_ACT4],#80h ; 1f12e
	JRL Z,loc_0x01F15C ; 1f131
	JRS loc_0x01F10E
; ---------------------- ; 1f134
loc_0x01F136:
	LD A,#06h ; 1f136
	CARL loc_0x01EEC8 ; 1f138
	BIT [BR:IRQ_ACT4],#80h ; 1f13b
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
	BIT [BR:IRQ_ACT4],#80h ; 1f151
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
	BIT [BR:IRQ_ACT4],#80h ; 1f16c
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
	LD [BR:IRQ_ACT4],#80h ; 1f17e
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
	LD [BR:IRQ_ACT4],#80h ; 1f193
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
