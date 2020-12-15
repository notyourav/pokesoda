INCLUDE "global.inc"

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
global pool_01027B
pool_01027B:
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
	DB 0FFh, 0F8h
global pool_01030A
pool_01030A:
	DB 81h, 82h, 0C5h, 82h, 0A1h, 02h ; 10308
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
	DB 06h, 0B5h, 00h, 0F2h, 8Dh, 0FFh, 0F8h
global pool_010385
pool_010385:
	DB 10h ; 1037e
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
	DB 0Fh, 1Bh, 0F2h, 0DFh, 0D6h, 0F8h
global pool_0103EC
pool_0103EC:
	DB 8Bh, 83h ; 103e6
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
global pool_0104E3
pool_0104E3:
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
	DB 18h, 0EBh, 0CEh, 0FFh, 0F8h

global pool_010547
pool_010547:
	DB 13h, 85h, 3Ch
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

global pool_0113AE
pool_0113AE:

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
global loc_0x01168D
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
global loc_0x0116D0
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
global loc_0x01172F
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
global loc_0x011875
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
global loc_0x011909
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
global loc_0x011ADC
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
global loc_0x011B84
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
global loc_0x011BA5
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

	; do not draw if past the right edge of the screen
	CP A,#70h ; 11c40
	JRS NC,loc_0x011C64 ; 11c42

	LD [HL],A ; 11c44
	INC IY ; 11c45
	INC HL ; 11c46

	LD A,[IY] ; 11c47
	ADD A,[1914h] ; 11c48
	JRS Z,loc_0x011C6C ; 11c4b

	; do not draw if past the bottom edge of the screen
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

global loc_0x011C7B
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
global loc_0x011CF5
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
global loc_0x011D05
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
global loc_0x011EB1
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
global loc_0x011ECF
loc_0x011ECF:

	; ?
	LD IX,#168Fh ; 11ecf
	LD XP,#00h ; 11ed2

	LD EP,#00h ; 11ed5

	; sprite index?
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

	; jmp to function
	LD HL, BA
	CARS loc_0x011F3B

	JRS loc_0x011EFD

; ---------------------- ; 11f0f
loc_0x011F11:

	LD BA,IY ; 11f11

	LD [IX+02h],A ; 11f13
	LD [IX+03h],B ; 11f16

	JRS loc_0x011F31

; ---------------------- ; 11f19
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
global pool_01203B
pool_01203B:
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
	ASCII "A "
global pool_012075
pool_012075:
	ASCII "q"
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
global pool_0120A4
pool_0120A4:
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

global pool_0121B3
pool_0121B3:
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
global loc_0x012476
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
global loc_0x012495
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
global loc_0x012718
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
global loc_0x012940
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
global loc_0x01298A
loc_0x01298A:
	LD A,#0Eh ; 1298a
	JRS loc_0x0129B4
; ---------------------- ; 1298c
	DB 0B0h, 09h, 0F1h, 23h, 0B0h, 0Dh, 0F1h, 1Fh ; 1298e
	DB 0B0h, 04h, 0F1h, 1Bh, 0B0h, 08h, 0F1h, 17h
; ---------------------- ; 12996
global loc_0x01299E
loc_0x01299E:
	LD A,#06h ; 1299e
	JRS loc_0x0129B4
; ---------------------- ; 129a0
	DB 0B0h, 07h, 0F1h, 0Fh
; ---------------------- ; 129a2
global loc_0x0129A6
loc_0x0129A6:
	LD A,#05h ; 129a6
	JRS loc_0x0129B4
; ---------------------- ; 129a8
	DB 0B0h, 01h, 0F1h, 07h, 0B0h, 16h, 0F1h, 03h
; ---------------------- ; 129aa
global loc_0x0129B2
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
global loc_0x012F7C
loc_0x012F7C:
	LD HL,#1ADAh ; 12f7c
	JRS loc_0x012F84
; ---------------------- ; 12f7f
global loc_0x012F81
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
global loc_0x012F8A
loc_0x012F8A:
	LD HL,#1ADCh ; 12f8a
	JRS loc_0x012F84
; ---------------------- ; 12f8d
global loc_0x012F8F
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
global loc_0x012F9E
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
global loc_0x012FB6
loc_0x012FB6:
	LD A,[1ADAh] ; 12fb6
	CP A,#28h ; 12fba
	JRS NC,loc_0x012FC3 ; 12fbc
	INC A ; 12fbe
	LD [1ADAh],A ; 12fbf
loc_0x012FC3:
	RET
; ---------------------- ; 12fc3
global loc_0x012FC4
loc_0x012FC4:
	DB 0C4h, 00h, 00h, 0BCh, 01h, 1Bh, 0CEh, 0D4h ; 12fc4
	DB 03h, 1Bh, 0CEh, 0D0h, 0DBh, 1Ah ; 12fcc
	ASCII "2" ; 12fd2
	DB 08h, 0E5h, 07h, 80h, 0CEh, 0D4h, 0DBh, 1Ah ; 12fd3
	DB 0F8h, 0B1h, 04h, 0CFh, 0B1h, 0F2h, 0BCh, 0FFh ; 12fdb
	DB 0CFh, 0B5h, 0F5h, 0F8h, 0F8h
; ---------------------- ; 12fe3
global loc_0x012FE8
loc_0x012FE8:

	LD A,[1ADCh] ; 12fe8
	CP A,#02h ; 12fec
	JRS NC,loc_0x012FF5 ; 12fee

	INC A ; 12ff0
	LD [1ADCh],A ; 12ff1

loc_0x012FF5:

	RET

; ---------------------- ; 12ff5
global loc_0x012FF6
loc_0x012FF6:
	DB 0C5h, 0DDh, 1Ah, 0F1h, 0Eh

global loc_0x012FFB
loc_0x012FFB:
	DB 0C5h, 0DFh, 1Ah ; 12ff6
	DB 0F1h, 09h
loc_0x013000:
	DB 0C5h, 0E1h, 1Ah, 0F1h, 04h

global loc_0x013005
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
global loc_0x013612
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
	DB 0F1h, 03h
; ---------------------- ; 14c0e
loc_0x014C10:
	LD A,#03h ; 14c10
	LD B,[IX+1Bh] ; 14c12
	CP A,B ; 14c15
	JRS Z,loc_0x014C45 ; 14c16
	LD [IX+1Bh],A ; 14c18
	LD A,[1B3Fh] ; 14c1b
	OR A,A ; 14c1f
	JRS NZ,loc_0x014C45 ; 14c20
	LD HL,#1B40h ; 14c22
	LD A,[HL] ; 14c25
	OR A,A ; 14c26
	JRS Z,loc_0x014C2C ; 14c27
	DEC [HL] ; 14c29
	JRS loc_0x014C45
loc_0x014C2C:
	LD [HL],#03h ; 14c2c
	CARL loc_0x014D3D ; 14c2e
	CARL loc_0x012F7C ; 14c31
	LD NB,#01h ; 14c34
	CARL loc_0x009ABE ; 14c37
	JRS NZ,loc_0x014C45 ; 14c3a
	CARL loc_0x012FF6 ; 14c3c
	LD NB,#01h ; 14c3f
	CARL loc_0x00C0E9 ; 14c42
loc_0x014C45:
	RET

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Toy car update
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x014C46:
	LD A,[IX+19h] ; 14c46
	OR A,A ; 14c49

	; bob
	JRS NZ,loc_0x014C65 ; 14c4a

	; load sprite offset
	LD L,[IX+02h] ; 14c4c
	LD H,[IX+03h] ; 14c4f

	CP HL,#4B1Dh ; 14c52
	JRS C,loc_0x014C81 ; 14c55

	LD HL,#4AFDh ; 14c57

	LD A,[IX+1Ah] ; 14c5a
	OR A,A ; 14c5d
	JRS Z,loc_0x014C7C ; 14c5e

	LD HL,#4B0Dh ; 14c60
	JRS loc_0x014C7C

loc_0x014C65:
	LD L,[IX+02h] ; 14c65
	LD H,[IX+03h] ; 14c68

	CP HL,#4B1Dh ; 14c6b
	JRS NC,loc_0x014C81 ; 14c6e

	LD HL,#4B1Eh ; 14c70
	LD A,[IX+1Ah] ; 14c73
	OR A,A ; 14c76
	JRS Z,loc_0x014C7C ; 14c77

	LD HL,#4B2Eh ; 14c79

loc_0x014C7C:

	LD BA,HL ; 14c7c
	CARL loc_0x00794F ; 14c7e

loc_0x014C81:

	RET

; ---------------------- ; 14c81
loc_0x014C82:
	LD A,[1671h] ; 14c82
	AND A,#0Fh ; 14c86
	JRS NZ,loc_0x014C95 ; 14c88
	LD A,[1642h] ; 14c8a
	AND A,#09h ; 14c8e
	JRS Z,loc_0x014C95 ; 14c90
	CARL loc_0x014C10 ; 14c92
loc_0x014C95:
	LD A,[1642h] ; 14c95
	BIT A,#09h ; 14c99
	JRS Z,loc_0x014CB2 ; 14c9b
	LD A,[1AB6h] ; 14c9d
	AND A,A ; 14ca1
	JRS Z,loc_0x014CAA ; 14ca2
	LD A,#18h ; 14ca4
	LD [14FAh],A ; 14ca6
loc_0x014CAA:
	LD A,[IX+19h] ; 14caa
	INC A ; 14cad
	CP A,#04h ; 14cae
	JRS C,loc_0x014CC6 ; 14cb0
loc_0x014CB2:
	LD A,[1AB6h] ; 14cb2
	AND A,A ; 14cb6
	JRS Z,loc_0x014CBF ; 14cb7
	LD A,#00h ; 14cb9
	LD [14FAh],A ; 14cbb
loc_0x014CBF:
	LD A,[IX+19h] ; 14cbf
	OR A,A ; 14cc2
	JRS Z,loc_0x014CC6 ; 14cc3
	DEC A ; 14cc5
loc_0x014CC6:
	LD [IX+19h],A ; 14cc6
	RET
; ------------
loc_0x014CCA:

	LD A,[1642h] ; 14cca

	BIT A,#20h ; 14cce
	JRS NZ,loc_0x014CE4 ; 14cd0

	BIT A,#40h ; 14cd2
	JRS Z,loc_0x014CF6 ; 14cd4

	LD HL,#4B3Eh ; 14cd6

	LD A,[IX+1Ah] ; 14cd9
	OR A,A ; 14cdc
	JRS Z,loc_0x014CF0 ; 14cdd

	LD HL,#4B5Bh ; 14cdf
	JRS loc_0x014CF0

loc_0x014CE4:

	LD HL,#4B7Ch ; 14ce4

	LD A,[IX+1Ah] ; 14ce7
	OR A,A ; 14cea
	JRS Z,loc_0x014CF0 ; 14ceb

	LD HL,#4B99h ; 14ced

loc_0x014CF0:

	LD BA,HL ; 14cf0
	CARL loc_0x00794F ; 14cf2

	RET

loc_0x014CF6:

	CARL loc_0x014C82 ; 14cf6
	CARL loc_0x014C46 ; 14cf9

	LD A,[IX+19h] ; 14cfc
	OR A,A ; 14cff
	JRS Z,loc_0x014D28 ; 14d00

	LD A,[IX+1Ah] ; 14d02
	OR A,A ; 14d05
	JRS Z,loc_0x014D16 ; 14d06

	LD A,[IX+0Ah] ; 14d08
	ADD A,[IX+19h] ; 14d0b

	CP A,#50h ; 14d0e
	JRS C,loc_0x014D1F ; 14d10

	LD A,#50h ; 14d12
	JRS loc_0x014D1F

loc_0x014D16:

	LD A,[IX+0Ah] ; 14d16
	SUB A,[IX+19h] ; 14d19
	JRS NC,loc_0x014D1F ; 14d1c

	XOR A,A ; 14d1e

loc_0x014D1F:

	; set x pos and y bob
	LD B,[IX+0Eh]
	LD [pet_x], BA

	CARL loc_0x007982 ; 14d25

loc_0x014D28:

	RET

; ---------------------- ; 14d28
loc_0x014D29:
	XOR A,A ; 14d29
	LD [IX+18h],A ; 14d2a
	LD [IX+19h],A ; 14d2d
	LD [IX+1Ah],A ; 14d30
	LD [IX+1Bh],A ; 14d33
	RET
; ---------------------- ; 14d36
	DB 29h, 0CDh ; 14d37
	ASCII "q" ; 14d39
	DB 9Ah, 0FDh ; 14d3a
	ASCII "J" ; 14d3c
loc_0x014D3D:
	LD A,#09h ; 14d3d
	LD [1B3Fh],A ; 14d3f
	RET
; ---------------------- ; 14d43
	DB 9Dh ; 14d3d
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
	ASCII "O"

; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
; Handle pet walking
;   Args:
;     IX: pet
;     IY: movement tbl offset
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
loc_0x014FF0:

	; delta
	LD B,[IY] ; 14ff0ß

	BIT B,#80h ; 14ff1
	JRS Z,loc_0x015000 ; 14ff3

	LD A,[IX+0Ah] ; 14ff5
	ADD A,B ; 14ff8
	BIT A,#80h ; 14ff9
	JRS C,loc_0x01500A ; 14ffb

	XOR A,A ; 14ffd
	JRS loc_0x01500A

loc_0x015000:

	LD A,[IX+0Ah] ; 15000
	ADD A,B ; 15003
	CP A,#50h ; 15004
	JRS C,loc_0x01500A ; 15006
	
	LD A,#50h ; 15008

loc_0x01500A:

	LD [1B12h],A ; 1500a
	LD [IX+0Ah],A ; 1500e

	INC IY ; 15011

	RET

; ---------------------- ; 15012
loc_0x015013:
	LD A,[1AE9h] ; 15013
	LD NB,#02h ; 15017
	CARL loc_0x012476 ; 1501a
	CP A,#02h ; 1501d
	JRL Z,loc_0x015A33 ; 1501f
	CP A,#07h ; 15022
	JRL Z,loc_0x01636E ; 15024
	LD BA,#0003h ; 15027
	LD NB,#03h ; 1502a
	CARL loc_0x018FFE ; 1502d
	ADD A,A ; 15030
	LD B,#00h ; 15031
	PUSH IP ; 15033
	PUSH IX ; 15034
	LD IX,#5042h ; 15035
	LD XP,#01h ; 15038
	ADD IX,BA ; 1503b
	LD IY,[IX] ; 1503d
	POP IX ; 1503f
	POP IP ; 15040
	RET
; ---------------------- ; 15041
	DB 7Ah ; 15042
	DB 50h ; 15043
	DB 7Ah ; 15044
	DB 50h, 88h ; 15045
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
	ASCII "zP"
; ---------------------- ; 15696
loc_0x015698:
	LD HL,[1B37h] ; 15698
	ADD HL,#0002h ; 1569b
	LD HL,[HL] ; 1569e
	CP HL,#54A6h ; 156a0
	JRS C,loc_0x0156AA ; 156a3
	CP HL,#5637h ; 156a5
	JRS C,loc_0x0156AD ; 156a8
loc_0x0156AA:
	AND SC,#0FEh ; 156aa
	RET
; ---------------------- ; 156ac
loc_0x0156AD:
	OR SC,#01h ; 156ad
	RET
; ---------------------- ; 156af
loc_0x0156B0:
	LD A,[1643h] ; 156b0
	BIT A,#01h ; 156b4
	JRS Z,loc_0x0156D5 ; 156b6
	CARL loc_0x0157BC ; 156b8
	LD A,[1AB6h] ; 156bb
	AND A,A ; 156bf
	JRS Z,loc_0x0156C8 ; 156c0
	LD A,#01h ; 156c2
	LD [14FAh],A ; 156c4
loc_0x0156C8:
	LD BA,[1B10h] ; 156c8
	LD [1B1Eh],BA ; 156cb
	LD BA,#4FA5h ; 156ce
	CARL loc_0x00794F ; 156d1
	RET
; ---------------------- ; 156d4
loc_0x0156D5:
	CARL loc_0x015698 ; 156d5
	JRS Z,loc_0x0156E0 ; 156d8
	LD NB,#01h ; 156da
	CARL loc_0x00BF32 ; 156dd
loc_0x0156E0:
	RET
; ---------------------- ; 156e0
loc_0x0156E1:
	LD A,[1643h] ; 156e1
	BIT A,#01h ; 156e5
	JRS Z,loc_0x015705 ; 156e7
	CARL loc_0x0157BC ; 156e9
	LD A,[1AB6h] ; 156ec
	AND A,A ; 156f0
	JRS Z,loc_0x0156F9 ; 156f1
	LD A,#01h ; 156f3
	LD [14FAh],A ; 156f5
loc_0x0156F9:
	LD BA,[1B10h] ; 156f9
	LD [1B1Eh],BA ; 156fc
	LD A,#01h ; 156ff
	LD [IX+18h],A ; 15701
	RET
; ---------------------- ; 15704
loc_0x015705:
	XOR A,A ; 15705
	LD [IX+18h],A ; 15706
	CARL loc_0x015698 ; 15709
	JRS Z,loc_0x015714 ; 1570c
	LD NB,#01h ; 1570e
	CARL loc_0x00BF32 ; 15711
loc_0x015714:
	RET
; ---------------------- ; 15714
loc_0x015715:
	CARL loc_0x0158F2 ; 15715
	JRS loc_0x01573B
; ---------------------- ; 15718
	LD HL,[1B39h] ; 1571a
	ADD HL,#0002h ; 1571d
	LD BA,[HL] ; 15720
	CP BA,#4FDDh ; 15722
	JRS C,loc_0x01573B ; 15725
	CP BA,#4FE0h ; 15727
	JRS C,loc_0x015750 ; 1572a
	PUSH IY ; 1572c
	LD NB,#02h ; 1572d
	CARL loc_0x015013 ; 15730
	LD BA,IY ; 15733
	POP IY ; 15735
	CARL loc_0x00794F ; 15736
	JRS loc_0x015750
; ---------------------- ; 15739
loc_0x01573B:
	CARL loc_0x01583B ; 1573b
	CP HL,#0000h ; 1573e
	JRS NZ,loc_0x01574B ; 15741
	CARL loc_0x0157FE ; 15743
	CP HL,#0000h ; 15746
	JRS Z,loc_0x015750 ; 15749
loc_0x01574B:
	LD BA,HL ; 1574b
	CARL loc_0x00794F ; 1574d
loc_0x015750:
	RET
; ---------------------- ; 15750
loc_0x015751:
	CARL loc_0x0158F2 ; 15751
	JRS loc_0x015777
; ---------------------- ; 15754
loc_0x015756:
	LD HL,[1B39h] ; 15756
	ADD HL,#0002h ; 15759
	LD BA,[HL] ; 1575c
	CP BA,#4FDDh ; 1575e
	JRS C,loc_0x015777 ; 15761
	CP BA,#4FE0h ; 15763
	JRS C,loc_0x01578C ; 15766
	PUSH IY ; 15768
	LD NB,#02h ; 15769
	CARL loc_0x015013 ; 1576c
	LD BA,IY ; 1576f
	POP IY ; 15771
	CARL loc_0x00794F ; 15772
	JRS loc_0x01578C
; ---------------------- ; 15775
loc_0x015777:
	CARL loc_0x01583B ; 15777
	CP HL,#0000h ; 1577a
	JRS NZ,loc_0x015787 ; 1577d
	CARL loc_0x01581E ; 1577f
	CP HL,#0000h ; 15782
	JRS Z,loc_0x01578C ; 15785
loc_0x015787:
	LD BA,HL ; 15787
	CARL loc_0x00794F ; 15789
loc_0x01578C:
	RET
; ---------------------- ; 1578c
loc_0x01578D:
	LD A,[1643h] ; 1578d
	BIT A,#01h ; 15791
	JRS Z,loc_0x01579B ; 15793
	LD BA,#5384h ; 15795
	CARL loc_0x00794F ; 15798
loc_0x01579B:
	RET
; ---------------------- ; 1579b
loc_0x01579C:
	LD A,[1B11h] ; 1579c
	ADD A,#04h ; 157a0
	CP A,[IX+0Eh] ; 157a2
	JRS C,loc_0x0157AD ; 157a5
	LD BA,#5656h ; 157a7
	CARL loc_0x00794F ; 157aa
loc_0x0157AD:
	RET
; ---------------------- ; 157ad
loc_0x0157AE:
	LD A,[IX+0Eh] ; 157ae
	CP A,#2Ch ; 157b1
	JRS C,loc_0x0157BB ; 157b3
	LD BA,#5671h ; 157b5
	CARL loc_0x00794F ; 157b8
loc_0x0157BB:
	RET
; ---------------------- ; 157bb
loc_0x0157BC:
	LD A,[1B3Fh] ; 157bc
	OR A,A ; 157c0
	JRS NZ,loc_0x0157E6 ; 157c1
	LD HL,#1B40h ; 157c3
	LD A,[HL] ; 157c6
	OR A,A ; 157c7
	JRS Z,loc_0x0157CD ; 157c8
	DEC [HL] ; 157ca
	JRS loc_0x0157E6
; ---------------------- ; 157cb
loc_0x0157CD:
	LD [HL],#03h ; 157cd
	CARL loc_0x014D3D ; 157cf
	CARL loc_0x012F7C ; 157d2
	LD NB,#01h ; 157d5
	CARL loc_0x009ABE ; 157d8
	JRS NZ,loc_0x0157E6 ; 157db
	CARL loc_0x012FFB ; 157dd
	LD NB,#01h ; 157e0
	CARL loc_0x00C0E9 ; 157e3
loc_0x0157E6:
	RET
; ---------------------- ; 157e6
loc_0x0157E7:
	LD A,[1AD7h] ; 157e7
	LD B,#00h ; 157eb
	PUSH IP ; 157ed
	PUSH IY ; 157ee
	LD IY,#57FBh ; 157ef
	LD YP,#01h ; 157f2
	ADD IY,BA ; 157f5
	LD A,[IY] ; 157f7
	POP IY ; 157f8
	POP IP ; 157f9
	RET
; ---------------------- ; 157fa
	DB 0Ch, 0Fh, 0Dh
; ---------------------- ; 157fb
loc_0x0157FE:
	LD A,[1B11h] ; 157fe
	CP A,#24h ; 15802
	JRS C,loc_0x01581A ; 15804
	CARL loc_0x0157E7 ; 15806
	LD B,[1B12h] ; 15809
	ADD A,B ; 1580d
	LD B,A ; 1580e
	LD A,[1B10h] ; 1580f
	CP A,B ; 15813
	JRS C,loc_0x01581A ; 15814
	CARL loc_0x0158DC ; 15816
	RET
; ---------------------- ; 15819
loc_0x01581A:
	LD HL,#0000h ; 1581a
	RET
; ---------------------- ; 1581d
loc_0x01581E:
	LD A,[1B11h] ; 1581e
	CP A,#24h ; 15822
	JRS C,loc_0x015837 ; 15824
	LD A,[1B10h] ; 15826
	ADD A,#09h ; 1582a
	LD B,[1B12h] ; 1582c
	CP A,B ; 15830
	JRS NC,loc_0x015837 ; 15831
	CARL loc_0x0158C6 ; 15833
	RET
; ---------------------- ; 15836
loc_0x015837:
	LD HL,#0000h ; 15837
	RET
; ---------------------- ; 1583a
loc_0x01583B:
	LD A,[1B10h] ; 1583b
	ADD A,#09h ; 1583f
	LD B,A ; 15841
	LD A,[1B12h] ; 15842
	CP A,B ; 15846
	JRS C,loc_0x01586E ; 15847
	SUB A,#02h ; 15849
	JRS NC,loc_0x01584E ; 1584b
	XOR A,A ; 1584d
loc_0x01584E:
	CP A,B ; 1584e
	JRS NC,loc_0x0158C2 ; 1584f
	LD A,[1B11h] ; 15851
	ADD A,#04h ; 15855
	CP A,#24h ; 15857
	JRS C,loc_0x0158C2 ; 15859
	LD HL,#54FFh ; 1585b
	CP A,#2Ch ; 1585e
	JRS C,loc_0x0158B6 ; 15860
	LD HL,#54A7h ; 15862
	CP A,#34h ; 15865
	JRS C,loc_0x0158B6 ; 15867
	LD HL,#5513h ; 15869
	JRS loc_0x0158B6
; ---------------------- ; 1586c
loc_0x01586E:
	CARL loc_0x0157E7 ; 1586e
	LD B,[1B12h] ; 15871
	ADD A,B ; 15875
	LD B,[1B10h] ; 15876
	CP A,B ; 1587a
	JRS NC,loc_0x01589F ; 1587b
	ADD A,#03h ; 1587d
	CP A,B ; 1587f
	JRS C,loc_0x0158C2 ; 15880
	LD A,[1B11h] ; 15882
	ADD A,#04h ; 15886
	CP A,#24h ; 15888
	JRS C,loc_0x0158C2 ; 1588a
	LD HL,#5527h ; 1588c
	CP A,#2Ch ; 1588f
	JRS C,loc_0x0158B6 ; 15891
	LD HL,#54BBh ; 15893
	CP A,#34h ; 15896
	JRS C,loc_0x0158B6 ; 15898
	LD HL,#556Bh ; 1589a
	JRS loc_0x0158B6
; ---------------------- ; 1589d
loc_0x01589F:
	LD A,[1B11h] ; 1589f
	ADD A,#04h ; 158a3
	LD HL,#5638h ; 158a5
	CP A,#24h ; 158a8
	JRS C,loc_0x0158B6 ; 158aa
	LD HL,#55AFh ; 158ac
	CP A,#34h ; 158af
	JRS C,loc_0x0158B6 ; 158b1
	LD HL,#55F3h ; 158b3
loc_0x0158B6:
	LD BA,#9A71h ; 158b6
	CARL loc_0x007948 ; 158b9
	LD A,#02h ; 158bc
	LD [IX+1Fh],A ; 158be
	RET
; ---------------------- ; 158c1
loc_0x0158C2:
	LD HL,#0000h ; 158c2
	RET
; ---------------------- ; 158c5
loc_0x0158C6:
	LD HL,#514Ah ; 158c6
	LD A,[1B1Fh] ; 158c9
	CP A,#2Ch ; 158cd
	JRS C,loc_0x0158DB ; 158cf
	LD HL,#50D8h ; 158d1
	CP A,#34h ; 158d4
	JRS C,loc_0x0158DB ; 158d6
	LD HL,#51BCh ; 158d8
loc_0x0158DB:
	RET
; ---------------------- ; 158db
loc_0x0158DC:
	LD HL,#52A0h ; 158dc
	LD A,[1B1Fh] ; 158df
	CP A,#2Ch ; 158e3
	JRS C,loc_0x0158F1 ; 158e5
	LD HL,#522Eh ; 158e7
	CP A,#34h ; 158ea
	JRS C,loc_0x0158F1 ; 158ec
	LD HL,#5312h ; 158ee
loc_0x0158F1:
	RET
; ---------------------- ; 158f1
loc_0x0158F2:
	LD A,[1643h] ; 158f2
	BIT A,#01h ; 158f6
	JRS NZ,loc_0x0158FB ; 158f8
	RETS
; ---------------------- ; 158fa
loc_0x0158FB:
	LD B,[1B1Eh] ; 158fb
	LD A,[1B12h] ; 158ff
	CP A,B ; 15903
	JRS C,loc_0x01590B ; 15904
	CARL loc_0x0158C6 ; 15906
	JRS loc_0x01590E
; ---------------------- ; 15909
loc_0x01590B:
	CARL loc_0x0158DC ; 1590b
loc_0x01590E:
	LD BA,HL ; 1590e
	CARL loc_0x00794F ; 15910
	RET
; ---------------------- ; 15913
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
	ASCII "jY"
; ---------------------- ; 15974
loc_0x015976:
	LD A,[1B3Fh] ; 15976
	OR A,A ; 1597a
	JRS NZ,loc_0x01598D ; 1597b
	CARL loc_0x014D3D ; 1597d
	CARS loc_0x01598E ; 15980
	JRS NZ,loc_0x01598D ; 15982
	CARL loc_0x013005 ; 15984
	LD NB,#01h ; 15987
	CARL loc_0x00C0E9 ; 1598a
loc_0x01598D:
	RET
; ---------------------- ; 1598d
loc_0x01598E:
	LD A,[IX+0Eh] ; 1598e
	ADD A,#02h ; 15991
	LD B,[1B13h] ; 15993
	CP A,B ; 15997
	JRS NC,loc_0x0159B3 ; 15998
	ADD A,#05h ; 1599a
	CP A,B ; 1599c
	JRS C,loc_0x0159B3 ; 1599d
	LD A,[IX+0Ah] ; 1599f
	ADD A,#02h ; 159a2
	LD B,[1B12h] ; 159a4
	CP A,B ; 159a8
	JRS NC,loc_0x0159B3 ; 159a9
	ADD A,#0Bh ; 159ab
	CP A,B ; 159ad
	JRS C,loc_0x0159B3 ; 159ae
	OR SC,#01h ; 159b0
	RET
; ---------------------- ; 159b2
loc_0x0159B3:
	AND SC,#0FEh ; 159b3
	RET
; ---------------------- ; 159b5
loc_0x0159B6:
	LD A,[1643h] ; 159b6
	BIT A,#01h ; 159ba
	JRS Z,loc_0x0159D8 ; 159bc
	LD A,[1AB6h] ; 159be
	AND A,A ; 159c2
	JRS Z,loc_0x0159CB ; 159c3
	LD A,#1Bh ; 159c5
	LD [14FAh],A ; 159c7
loc_0x0159CB:
	CARL loc_0x012F7C ; 159cb
	CARL loc_0x012940 ; 159ce
	LD BA,#5914h ; 159d1
	CARL loc_0x00794F ; 159d4
	RET
; ---------------------- ; 159d7
loc_0x0159D8:
	LD A,[1642h] ; 159d8
	BIT A,#10h ; 159dc
	JRS NZ,loc_0x0159ED ; 159de
	BIT A,#08h ; 159e0
	JRS Z,loc_0x0159F8 ; 159e2
	LD A,[IX+0Eh] ; 159e4
	OR A,A ; 159e7
	JRS Z,loc_0x0159F8 ; 159e8
	DEC A ; 159ea
	JRS loc_0x0159F5
; ---------------------- ; 159eb
loc_0x0159ED:
	LD A,[IX+0Eh] ; 159ed
	CP A,#29h ; 159f0
	JRS NC,loc_0x0159F8 ; 159f2
	INC A ; 159f4
loc_0x0159F5:
	LD [IX+0Eh],A ; 159f5
loc_0x0159F8:
	LD A,[1642h] ; 159f8
	BIT A,#40h ; 159fc
	JRS NZ,loc_0x015A0D ; 159fe
	BIT A,#20h ; 15a00
	JRS Z,loc_0x015A18 ; 15a02
	LD A,[IX+0Ah] ; 15a04
	OR A,A ; 15a07
	JRS Z,loc_0x015A18 ; 15a08
	DEC A ; 15a0a
	JRS loc_0x015A15
; ---------------------- ; 15a0b
loc_0x015A0D:
	LD A,[IX+0Ah] ; 15a0d
	CP A,#41h ; 15a10
	JRS NC,loc_0x015A18 ; 15a12
	INC A ; 15a14
loc_0x015A15:
	LD [IX+0Ah],A ; 15a15
loc_0x015A18:
	RET
; ---------------------- ; 15a18
	DB 0BEh ; 15a19
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
	ASCII "2R"
; ---------------------- ; 15a31
loc_0x015A33:
	LD A,#0Ch ; 15a33
	LD [IX+18h],A ; 15a35
	LD BA,#0007h ; 15a38
	LD NB,#03h ; 15a3b
	CARL loc_0x018FFE ; 15a3e
	ADD A,A ; 15a41
	LD B,#00h ; 15a42
	PUSH IP ; 15a44
	PUSH IX ; 15a45
	LD IX,#5A53h ; 15a46
	LD XP,#01h ; 15a49
	ADD IX,BA ; 15a4c
	LD IY,[IX] ; 15a4e
	POP IX ; 15a50
	POP IP ; 15a51
	RET
; ---------------------- ; 15a52
loc_0x015A53:
	LD [BR:50h],[IX] ; 15a53
	LD [BR:50h],[IX] ; 15a55
	DEC A ; 15a57
	LD L,H ; 15a58
	DEC A ; 15a59
	LD L,H ; 15a5a
	DEC BR ; 15a5b
	LD L,A ; 15a5c
	LD BR,#50h ; 15a5d
	AND A,[HL] ; 15a5f
	LD H,L ; 15a60
	OR A,[HL] ; 15a61
	LD H,L ; 15a62
	LD A,[IX+06h] ; 15a63
	PUSH A ; 15a66
	CARL loc_0x015A8D ; 15a68
	LD A,[IX+06h] ; 15a6b
	POP B ; 15a6e
	CP A,B ; 15a70
	JRS NZ,loc_0x015A8C ; 15a71
	LD A,[IX+18h] ; 15a73
	OR A,A ; 15a76
	JRS Z,loc_0x015A7F ; 15a77
	DEC A ; 15a79
	LD [IX+18h],A ; 15a7a
	JRS loc_0x015A8C
; ---------------------- ; 15a7d
loc_0x015A7F:
	PUSH IY ; 15a7f
	CARL loc_0x015A33 ; 15a80
	LD BA,IY ; 15a83
	POP IY ; 15a85
	LD HL,#0DA8Dh ; 15a86
	CARL loc_0x007970 ; 15a89
loc_0x015A8C:
	RET
; ---------------------- ; 15a8c
loc_0x015A8D:
	LD HL,[1B39h] ; 15a8d
	ADD HL,#0002h ; 15a90
	LD BA,[HL] ; 15a93
	CP BA,#5914h ; 15a95
	JRS C,loc_0x015AA6 ; 15a98
	CP BA,#5942h ; 15a9a
	JRS NC,loc_0x015AA6 ; 15a9d
	LD A,[IX+06h] ; 15a9f
	INC A ; 15aa2
	LD [IX+06h],A ; 15aa3
loc_0x015AA6:
	RET
; ---------------------- ; 15aa6
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
	DB 0A6h, 0A3h
; ---------------------- ; 15aec
loc_0x015AEE:
	LD A,[1AD7h] ; 15aee
	ADD A,A ; 15af2
	LD B,#00h ; 15af3
	LD IY,#5B83h ; 15af5
	LD YP,#01h ; 15af8
	ADD IY,BA ; 15afb
	LD IY,[IY] ; 15afd
	LD A,[1B3Eh] ; 15aff
	LD B,#00h ; 15b03
	ADD IY,BA ; 15b05
	LD A,[IY] ; 15b07
loc_0x015B08:
	CP A,#0FFh ; 15b08
	JRS NZ,loc_0x015B13 ; 15b0a
	XOR A,A ; 15b0c
	LD [1B3Eh],A ; 15b0d
	JRS loc_0x015AEE
; ---------------------- ; 15b11
loc_0x015B13:
	PUSH A ; 15b13
	LD A,[1B3Fh] ; 15b15
	OR A,A ; 15b19
	POP A ; 15b1a
	JRS NZ,loc_0x015B77 ; 15b1c
	PUSH A ; 15b1e
	LD HL,#1B40h ; 15b20
	LD A,[HL] ; 15b23
	OR A,A ; 15b24
	POP A ; 15b25
	JRS Z,loc_0x015B38 ; 15b27
	DEC [HL] ; 15b29
	PUSH A ; 15b2a
	LD A,#01h ; 15b2c
	LD [1B3Dh],A ; 15b2e
	POP A ; 15b32
	ADD A,#24h ; 15b34
	JRS loc_0x015B6B
; ---------------------- ; 15b36
loc_0x015B38:
	LD [HL],#03h ; 15b38
	PUSH A ; 15b3a
	CARL loc_0x014D3D ; 15b3c
	CARL loc_0x012F7C ; 15b3f
	LD NB,#01h ; 15b42
	CARL loc_0x009ABE ; 15b45
	POP A ; 15b48
	JRS NZ,loc_0x015B63 ; 15b4a
	PUSH A ; 15b4c
	CARL loc_0x013000 ; 15b4e
	LD NB,#01h ; 15b51
	CARL loc_0x00C0F7 ; 15b54
	LD A,#01h ; 15b57
	LD [1B3Dh],A ; 15b59
	POP A ; 15b5d
	ADD A,#24h ; 15b5f
	JRS loc_0x015B6B
; ---------------------- ; 15b61
loc_0x015B63:
	LD A,#02h ; 15b63
	LD [1B3Dh],A ; 15b65
	LD A,#3Fh ; 15b69
loc_0x015B6B:
	LD B,A ; 15b6b
	LD A,[1AB6h] ; 15b6c
	AND A,A ; 15b70
	JRS Z,loc_0x015B77 ; 15b71
	LD [14FAh],B ; 15b73
loc_0x015B77:
	LD A,[1B3Eh] ; 15b77
	INC A ; 15b7b
	LD [1B3Eh],A ; 15b7c
	POP IY ; 15b80
	POP IP ; 15b81
	RET
; ---------------------- ; 15b82
	DB 89h, 5Bh, 89h, 5Bh, 89h, 5Bh, 00h, 02h ; 15b83
	DB 04h, 05h, 07h, 09h, 0Bh, 0Ch, 0FFh, 9Dh ; 15b8b
	DB 99h ; 15b93
	ASCII "q" ; 15b94
	DB 9Ah, 0ECh, 0DAh, 7Bh, 0A7h, 0A0h, 5Bh, 0A8h ; 15b95
	DB 5Bh, 0B0h, 5Bh, 02h, 00h, 2Ch, 0CDh, 0C1h ; 15b9d
	DB 99h, 0B8h, 5Bh, 02h, 00h, 5Ch, 0D9h, 0C1h ; 15ba5
	DB 99h, 0B8h, 5Bh, 02h, 00h, 84h, 0DDh, 0C1h ; 15bad
	DB 99h, 0B8h, 5Bh, 9Dh, 99h, 0D6h, 0DBh, 7Bh ; 15bb5
	DB 0A7h, 0C4h, 5Bh, 0CAh, 5Bh, 0D0h, 5Bh, 01h ; 15bbd
	DB 00h, 28h, 0CDh, 8Eh, 99h, 01h, 00h ; 15bc5
	ASCII "X" ; 15bcc
	DB 0D9h, 8Eh, 99h, 01h, 00h, 80h
; ---------------------- ; 15bcd
loc_0x015BD3:
	LD [BR:8Eh],#99h ; 15bd3
	LD A,[1643h] ; 15bd6
	BIT A,#01h ; 15bda
	JRS Z,loc_0x015BE4 ; 15bdc
	LD BA,#5B92h ; 15bde
	CARL loc_0x00794F ; 15be1
loc_0x015BE4:
	RET
; ---------------------- ; 15be4
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
	DB 5Ch, 0F2h, 0A5h, 00h
; ---------------------- ; 15ce1
loc_0x015CE5:
	LD A,[1643h] ; 15ce5
	BIT A,#01h ; 15ce9
	JRS Z,loc_0x015CF5 ; 15ceb
	CARL loc_0x015DE0 ; 15ced
	LD BA,#5C4Ch ; 15cf0
	JRS loc_0x015D33
; ---------------------- ; 15cf3
loc_0x015CF5:
	LD A,[1642h] ; 15cf5
	BIT A,#38h ; 15cf9
	JRS NZ,loc_0x015D06 ; 15cfb
	BIT A,#40h ; 15cfd
	JRS Z,loc_0x015D20 ; 15cff
	LD BA,#5C91h ; 15d01
	JRS loc_0x015D33
; ---------------------- ; 15d04
loc_0x015D06:
	LD A,[IX+02h] ; 15d06
	LD B,[IX+03h] ; 15d09
	CP BA,#5C6Dh ; 15d0c
	JRS C,loc_0x015D37 ; 15d0f
	CP BA,#5C7Dh ; 15d11
	JRS NC,loc_0x015D37 ; 15d14
	LD BA,#5C7Dh ; 15d16
	JRS loc_0x015D33
; ---------------------- ; 15d19
	DB 0C4h, 81h, 5Ch, 0F1h, 14h
; ---------------------- ; 15d1b
loc_0x015D20:
	LD A,[IX+02h] ; 15d20
	LD B,[IX+03h] ; 15d23
	CP BA,#5C6Dh ; 15d26
	JRS C,loc_0x015D30 ; 15d29
	CP BA,#5C7Dh ; 15d2b
	JRS C,loc_0x015D37 ; 15d2e
loc_0x015D30:
	LD BA,#5C6Dh ; 15d30
loc_0x015D33:
	CARL loc_0x00794F ; 15d33
	RET
; ---------------------- ; 15d36
loc_0x015D37:
	RET
; ---------------------- ; 15d37
loc_0x015D38:
	CARL loc_0x015D89 ; 15d38
	LD A,[1643h] ; 15d3b
	BIT A,#01h ; 15d3f
	JRS Z,loc_0x015D4B ; 15d41
	CARL loc_0x015E1E ; 15d43
	LD BA,#5C9Dh ; 15d46
	JRS loc_0x015D84
; ---------------------- ; 15d49
loc_0x015D4B:
	LD A,[1642h] ; 15d4b
	BIT A,#58h ; 15d4f
	JRS NZ,loc_0x015D5C ; 15d51
	BIT A,#20h ; 15d53
	JRS Z,loc_0x015D71 ; 15d55
	LD BA,#5C40h ; 15d57
	JRS loc_0x015D84
; ---------------------- ; 15d5a
loc_0x015D5C:
	LD A,[IX+02h] ; 15d5c
	LD B,[IX+03h] ; 15d5f
	CP BA,#5CBEh ; 15d62
	JRS C,loc_0x015D88 ; 15d65
	CP BA,#5CCEh ; 15d67
	JRS NC,loc_0x015D88 ; 15d6a
	LD BA,#5CCEh ; 15d6c
	JRS loc_0x015D84
; ---------------------- ; 15d6f
loc_0x015D71:
	LD A,[IX+02h] ; 15d71
	LD B,[IX+03h] ; 15d74
	CP BA,#5CBEh ; 15d77
	JRS C,loc_0x015D81 ; 15d7a
	CP BA,#5CCEh ; 15d7c
	JRS C,loc_0x015D88 ; 15d7f
loc_0x015D81:
	LD BA,#5CBEh ; 15d81
loc_0x015D84:
	CARL loc_0x00794F ; 15d84
	RET
; ---------------------- ; 15d87
loc_0x015D88:
	RET
; ---------------------- ; 15d88
loc_0x015D89:
	LD A,[1642h] ; 15d89
	BIT A,#10h ; 15d8d
	JRS NZ,loc_0x015D9F ; 15d8f
	BIT A,#08h ; 15d91
	JRS Z,loc_0x015DAC ; 15d93
	LD A,[1B11h] ; 15d95
	OR A,A ; 15d99
	JRS Z,loc_0x015DAC ; 15d9a
	DEC A ; 15d9c
	JRS loc_0x015DA8
; ---------------------- ; 15d9d
loc_0x015D9F:
	LD A,[1B11h] ; 15d9f
	CP A,#2Dh ; 15da3
	JRS Z,loc_0x015DAC ; 15da5
	INC A ; 15da7
loc_0x015DA8:
	LD [1B11h],A ; 15da8
loc_0x015DAC:
	LD A,[1642h] ; 15dac
	BIT A,#40h ; 15db0
	JRS NZ,loc_0x015DC2 ; 15db2
	BIT A,#20h ; 15db4
	JRS Z,loc_0x015DCF ; 15db6
	LD A,[1B10h] ; 15db8
	OR A,A ; 15dbc
	JRS Z,loc_0x015DCF ; 15dbd
	DEC A ; 15dbf
	JRS loc_0x015DCB
; ---------------------- ; 15dc0
loc_0x015DC2:
	LD A,[1B10h] ; 15dc2
	CP A,#4Fh ; 15dc6
	JRS Z,loc_0x015DCF ; 15dc8
	INC A ; 15dca
loc_0x015DCB:
	LD [1B10h],A ; 15dcb
loc_0x015DCF:
	LD BA,[1B10h] ; 15dcf
	CARL loc_0x007982 ; 15dd2
	RET
; ---------------------- ; 15dd5
	DB 0BEh ; 15dd6
	ASCII "9" ; 15dd7
	DB 1Bh, 0F8h, 0D6h, 0DDh, 89h, 0DDh ; 15dd8
	ASCII "m\"
; ---------------------- ; 15dde
loc_0x015DE0:
	LD A,[1B3Fh] ; 15de0
	OR A,A ; 15de4
	JRS NZ,loc_0x015E1D ; 15de5
	CARL loc_0x014D3D ; 15de7
	CARL loc_0x012F7C ; 15dea
	LD A,#01h ; 15ded
	LD [1B41h],A ; 15def
	LD A,[1B10h] ; 15df3
	SUB A,#27h ; 15df7
	JRS NC,loc_0x015DFC ; 15df9
	XOR A,A ; 15dfb
loc_0x015DFC:
	LD B,[1B12h] ; 15dfc
	CP A,B ; 15e00
	JRS Z,loc_0x015E0E ; 15e01
	JRS NC,loc_0x015E1D ; 15e03
	LD A,[1B10h] ; 15e05
	ADD A,#08h ; 15e09
	CP A,B ; 15e0b
	JRS C,loc_0x015E1D ; 15e0c
loc_0x015E0E:
	LD A,#02h ; 15e0e
	LD [1B41h],A ; 15e10
	CARL loc_0x012FFB ; 15e14
	LD NB,#01h ; 15e17
	CARL loc_0x00C0E9 ; 15e1a
loc_0x015E1D:
	RET
; ---------------------- ; 15e1d
loc_0x015E1E:
	LD A,[1B3Fh] ; 15e1e
	OR A,A ; 15e22
	JRS NZ,loc_0x015E5B ; 15e23
	CARL loc_0x014D3D ; 15e25
	CARL loc_0x012F7C ; 15e28
	LD A,#01h ; 15e2b
	LD [1B41h],A ; 15e2d
	LD A,[1B10h] ; 15e31
	SUB A,#08h ; 15e35
	JRS NC,loc_0x015E3A ; 15e37
	XOR A,A ; 15e39
loc_0x015E3A:
	LD B,[1B12h] ; 15e3a
	CP A,B ; 15e3e
	JRS Z,loc_0x015E4C ; 15e3f
	JRS NC,loc_0x015E5B ; 15e41
	LD A,[1B10h] ; 15e43
	ADD A,#27h ; 15e47
	CP A,B ; 15e49
	JRS C,loc_0x015E5B ; 15e4a
loc_0x015E4C:
	LD A,#02h ; 15e4c
	LD [1B41h],A ; 15e4e
	CARL loc_0x012FFB ; 15e52
	LD NB,#01h ; 15e55
	CARL loc_0x00C0E9 ; 15e58
loc_0x015E5B:
	RET
; ---------------------- ; 15e5b
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
	DB 0E4h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh, 0F8h
; ---------------------- ; 16009
loc_0x016011:
	LD B,#1Fh ; 16011
	LD A,[1B41h] ; 16013
	CP A,#02h ; 16017
	JRS NZ,loc_0x01601D ; 16019
	LD B,#27h ; 1601b
loc_0x01601D:
	LD A,[1B10h] ; 1601d
	SUB A,B ; 16021
	JRS NC,loc_0x016025 ; 16022
	XOR A,A ; 16024
loc_0x016025:
	LD B,[1B12h] ; 16025
	CP A,B ; 16029
	JRS Z,loc_0x016033 ; 1602a
	JRS C,loc_0x016033 ; 1602c
	LD BA,#5EA6h ; 1602e
	JRS loc_0x016060
; ---------------------- ; 16031
loc_0x016033:
	CP B,#00h ; 16033
	JRS Z,loc_0x01605D ; 16036
	LD NB,#01h ; 16038
	CARL loc_0x00ABDA ; 1603b
	LD B,A ; 1603e
	LD A,[1B41h] ; 1603f
	CP A,#02h ; 16043
	JRS NZ,loc_0x016049 ; 16045
	LD B,#02h ; 16047
loc_0x016049:
	LD A,[1B12h] ; 16049
	SUB A,B ; 1604d
	JRS NC,loc_0x016051 ; 1604e
	XOR A,A ; 16050
loc_0x016051:
	LD [1B12h],A ; 16051
	LD B,[1B13h] ; 16055
	CARL loc_0x007982 ; 16059
	RET
; ---------------------- ; 1605c
loc_0x01605D:
	LD BA,#5FACh ; 1605d
loc_0x016060:
	CARL loc_0x00794F ; 16060
	RET
; ---------------------- ; 16063
loc_0x016064:
	LD B,#1Fh ; 16064
	LD A,[1B41h] ; 16066
	CP A,#02h ; 1606a
	JRS NZ,loc_0x016070 ; 1606c
	LD B,#27h ; 1606e
loc_0x016070:
	LD A,[1B10h] ; 16070
	ADD A,B ; 16074
	LD B,[1B12h] ; 16075
	CP A,B ; 16079
	JRS NC,loc_0x016081 ; 1607a
	LD BA,#5E6Eh ; 1607c
	JRS loc_0x0160B1
; ---------------------- ; 1607f
loc_0x016081:
	CP B,#4Fh ; 16081
	JRS NC,loc_0x0160AE ; 16084
	LD NB,#01h ; 16086
	CARL loc_0x00ABDA ; 16089
	LD B,A ; 1608c
	LD A,[1B41h] ; 1608d
	CP A,#02h ; 16091
	JRS NZ,loc_0x016097 ; 16093
	LD B,#02h ; 16095
loc_0x016097:
	LD A,[1B12h] ; 16097
	ADD A,B ; 1609b
	CP A,#4Fh ; 1609c
	JRS C,loc_0x0160A2 ; 1609e
	LD A,#4Fh ; 160a0
loc_0x0160A2:
	LD [1B12h],A ; 160a2
	LD B,[1B13h] ; 160a6
	CARL loc_0x007982 ; 160aa
	RET
; ---------------------- ; 160ad
loc_0x0160AE:
	LD BA,#5F51h ; 160ae
loc_0x0160B1:
	CARL loc_0x00794F ; 160b1
	RET
; ---------------------- ; 160b4
loc_0x0160B5:
	LD A,[1B41h] ; 160b5
	OR A,A ; 160b9
	JRS Z,loc_0x0160CC ; 160ba
	CP A,#02h ; 160bc
	JRS Z,loc_0x0160C5 ; 160be
	LD BA,#5E62h ; 160c0
	JRS loc_0x0160C8
; ---------------------- ; 160c3
loc_0x0160C5:
	LD BA,#5F0Ah ; 160c5
loc_0x0160C8:
	CARL loc_0x00794F ; 160c8
	RET
; ---------------------- ; 160cb
loc_0x0160CC:
	LD A,[1B10h] ; 160cc
	ADD A,#1Fh ; 160d0
	LD B,[1B12h] ; 160d2
	CP A,B ; 160d6
	JRS C,loc_0x0160DF ; 160d7
	LD BA,#5F44h ; 160d9
	CARL loc_0x00794F ; 160dc
loc_0x0160DF:
	RET
; ---------------------- ; 160df
loc_0x0160E0:
	LD A,[1B41h] ; 160e0
	OR A,A ; 160e4
	JRS Z,loc_0x0160F7 ; 160e5
	CP A,#02h ; 160e7
	JRS Z,loc_0x0160F0 ; 160e9
	LD BA,#5E7Ah ; 160eb
	JRS loc_0x0160F3
; ---------------------- ; 160ee
loc_0x0160F0:
	LD BA,#5ECCh ; 160f0
loc_0x0160F3:
	CARL loc_0x00794F ; 160f3
	RET
; ---------------------- ; 160f6
loc_0x0160F7:
	LD A,[1B10h] ; 160f7
	SUB A,#1Fh ; 160fb
	JRS NC,loc_0x016100 ; 160fd
	XOR A,A ; 160ff
loc_0x016100:
	LD B,[1B12h] ; 16100
	CP A,B ; 16104
	JRS Z,loc_0x016109 ; 16105
	JRS NC,loc_0x01610F ; 16107
loc_0x016109:
	LD BA,#5F44h ; 16109
	CARL loc_0x00794F ; 1610c
loc_0x01610F:
	RET
; ---------------------- ; 1610f
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
loc_0x01636E:
	LD BA,#0004h ; 1636e
	LD NB,#03h ; 16371
	CARL loc_0x018FFE ; 16374
	OR A,A ; 16377
	JRS Z,loc_0x016398 ; 16378
	CP A,#01h ; 1637a
	JRS Z,loc_0x01638E ; 1637c
	CP A,#03h ; 1637e
	JRS Z,loc_0x01638E ; 16380
	LD B,[1B12h] ; 16382
	CP B,#50h ; 16386
	JRS NZ,loc_0x016398 ; 16389
	INC A ; 1638b
	JRS loc_0x016398
; ---------------------- ; 1638c
loc_0x01638E:
	LD B,[1B12h] ; 1638e
	CP B,#00h ; 16392
	JRS NZ,loc_0x016398 ; 16395
	DEC A ; 16397
loc_0x016398:
	ADD A,A ; 16398
	LD B,#00h ; 16399
	PUSH IP ; 1639b
	PUSH IX ; 1639c
	LD IX,#63AAh ; 1639d
	LD XP,#01h ; 163a0
	ADD IX,BA ; 163a3
	LD IY,[IX] ; 163a5
	POP IX ; 163a7
	POP IP ; 163a8
	RET
; ---------------------- ; 163a9
	DB 7Eh ; 163aa
	DB 50h, 8Ch ; 163ab
	ASCII "P" ; 163ad
	DB 0B4h ; 163ae
	ASCII "P" ; 163af
	DB 8Ch ; 163b0
	ASCII "P" ; 163b1
	DB 0B4h ; 163b2
	ASCII "P~P"
; ---------------------- ; 163b3
loc_0x0163B6:
	LD A,[1B12h] ; 163b6
	OR A,A ; 163ba
	JRS NZ,loc_0x0163C4 ; 163bb
	LD BA,#6260h ; 163bd
	CARL loc_0x00794F ; 163c0
	RET
; ---------------------- ; 163c3
loc_0x0163C4:
	DEC A ; 163c4
	LD [1B12h],A ; 163c5
	LD B,[1B13h] ; 163c9
	CARL loc_0x007982 ; 163cd
	RET
; ---------------------- ; 163d0
loc_0x0163D1:
	LD A,[1B12h] ; 163d1
	CP A,#50h ; 163d5
	JRS C,loc_0x0163E0 ; 163d7
	LD BA,#6320h ; 163d9
	CARL loc_0x00794F ; 163dc
	RET
; ---------------------- ; 163df
loc_0x0163E0:
	INC A ; 163e0
	LD [1B12h],A ; 163e1
	LD B,[1B13h] ; 163e5
	CARL loc_0x007982 ; 163e9
	RET
; ---------------------- ; 163ec
loc_0x0163ED:
	LD A,[1B11h] ; 163ed
	CP A,#2Ah ; 163f1
	JRS C,loc_0x0163FB ; 163f3
	LD BA,#61DDh ; 163f5
	CARL loc_0x00794F ; 163f8
loc_0x0163FB:
	RET
; ---------------------- ; 163fb
loc_0x0163FC:
	LD HL,[1B39h] ; 163fc
	ADD HL,#0004h ; 163ff
	LD HL,[HL] ; 16402
	CP HL,#0E590h ; 16404
	JRS NZ,loc_0x01641C ; 16407
	LD A,[1B11h] ; 16409
	CP A,#1Ch ; 1640d
	JRS NZ,loc_0x01641C ; 1640f
	CARL loc_0x0164B7 ; 16411
	JRS NZ,loc_0x01641C ; 16414
	LD BA,#61D3h ; 16416
	CARL loc_0x00794F ; 16419
loc_0x01641C:
	RET
; ---------------------- ; 1641c
	DB 0BEh ; 1641d
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
	DB 0DBh, 0E5h, 01h, 00h, 0D4h, 0CFh, 8Eh, 99h
; ---------------------- ; 164af
loc_0x0164B7:
	LD A,[1B10h] ; 164b7
	SUB A,#04h ; 164bb
	JRS NC,loc_0x0164C0 ; 164bd
	XOR A,A ; 164bf
loc_0x0164C0:
	LD B,A ; 164c0
	LD A,[1B12h] ; 164c1
	CP A,B ; 164c5
	JRS C,loc_0x0164D9 ; 164c6
	LD A,[1B10h] ; 164c8
	ADD A,#05h ; 164cc
	LD B,A ; 164ce
	LD A,[1B12h] ; 164cf
	CP A,B ; 164d3
	JRS NC,loc_0x0164D9 ; 164d4
	OR SC,#01h ; 164d6
	RET
; ---------------------- ; 164d8
loc_0x0164D9:
	AND SC,#0FEh ; 164d9
	RET
; ---------------------- ; 164db
loc_0x0164DC:
	LD A,[1B10h] ; 164dc
	OR A,A ; 164e0
	JRS Z,loc_0x0164F2 ; 164e1
	LD A,[1B11h] ; 164e3
	CP A,#2Ch ; 164e7
	JRS NZ,loc_0x0164F2 ; 164e9
	LD BA,#6492h ; 164eb
	CARL loc_0x00794F ; 164ee
	RET
; ---------------------- ; 164f1
loc_0x0164F2:
	LD A,[1B10h] ; 164f2
	INC A ; 164f6
	INC A ; 164f7
	LD [1B10h],A ; 164f8
	CP A,#28h ; 164fc
	JRS C,loc_0x016512 ; 164fe
	LD A,[1B11h] ; 16500
	INC A ; 16504
	INC A ; 16505
	CP A,#2Ch ; 16506
	JRS C,loc_0x01650C ; 16508
	LD A,#2Ch ; 1650a
loc_0x01650C:
	LD [1B11h],A ; 1650c
	JRS loc_0x01651B
; ---------------------- ; 16510
loc_0x016512:
	LD A,[1B11h] ; 16512
	DEC A ; 16516
	LD [1B11h],A ; 16517
loc_0x01651B:
	LD BA,[1B10h] ; 1651b
	CARL loc_0x007982 ; 1651e
	RET
; ---------------------- ; 16521
loc_0x016522:
	LD A,[1B10h] ; 16522
	CP A,#50h ; 16526
	JRS Z,loc_0x016539 ; 16528
	LD A,[1B11h] ; 1652a
	CP A,#2Ch ; 1652e
	JRS NZ,loc_0x016539 ; 16530
	LD BA,#6492h ; 16532
	CARL loc_0x00794F ; 16535
	RET
; ---------------------- ; 16538
loc_0x016539:
	LD A,[1B10h] ; 16539
	DEC A ; 1653d
	DEC A ; 1653e
	LD [1B10h],A ; 1653f
	CP A,#28h ; 16543
	JRS NC,loc_0x016559 ; 16545
	LD A,[1B11h] ; 16547
	INC A ; 1654b
	INC A ; 1654c
	CP A,#2Ch ; 1654d
	JRS C,loc_0x016553 ; 1654f
	LD A,#2Ch ; 16551
loc_0x016553:
	LD [1B11h],A ; 16553
	JRS loc_0x016562
; ---------------------- ; 16557
loc_0x016559:
	LD A,[1B11h] ; 16559
	DEC A ; 1655d
	LD [1B11h],A ; 1655e
loc_0x016562:
	LD BA,[1B10h] ; 16562
	CARL loc_0x007982 ; 16565
	RET
; ---------------------- ; 16568
loc_0x016569:
	LD HL,[1B37h] ; 16569
	ADD HL,#0002h ; 1656c
	LD HL,[HL] ; 1656f
	CP HL,#6346h ; 16571
	JRS Z,loc_0x016580 ; 16574
	CP HL,#6286h ; 16576
	JRS NZ,loc_0x01658F ; 16579
	LD BA,#6442h ; 1657b
	JRS loc_0x016583
; ---------------------- ; 1657e
loc_0x016580:
	LD BA,#646Ah ; 16580
loc_0x016583:
	CARL loc_0x00794F ; 16583
	LD BA,[1B12h] ; 16586
	LD [1B10h],BA ; 16589
	CARL loc_0x007982 ; 1658c
loc_0x01658F:
	RET
; ---------------------- ; 1658f
loc_0x016590:
	LD A,[1B42h] ; 16590
	OR A,A ; 16594
	JRS Z,loc_0x01659D ; 16595
	LD BA,#0E5E9h ; 16597
	CARL loc_0x007948 ; 1659a
loc_0x01659D:
	LD A,[1B11h] ; 1659d
	CP A,#2Ch ; 165a1
	JRS C,loc_0x0165AC ; 165a3
	LD BA,#6427h ; 165a5
	CARL loc_0x00794F ; 165a8
	RET
; ---------------------- ; 165ab
loc_0x0165AC:
	INC A ; 165ac
	LD [1B11h],A ; 165ad
	LD BA,[1B10h] ; 165b1
	CARL loc_0x007982 ; 165b4
	LD A,[1B11h] ; 165b7
	CP A,#2Ah ; 165bb
	JRS NZ,loc_0x0165DA ; 165bd
	LD HL,[1B37h] ; 165bf
	ADD HL,#0002h ; 165c2
	LD HL,[HL] ; 165c5
	CP HL,#61D3h ; 165c7
	JRS C,loc_0x0165DA ; 165ca
	CP HL,#61DDh ; 165cc
	JRS NC,loc_0x0165DA ; 165cf
	LD HL,#0E569h ; 165d1
	LD BA,#1A72h ; 165d4
	CARL loc_0x007970 ; 165d7
loc_0x0165DA:
	RET
; ---------------------- ; 165da
loc_0x0165DB:
	LD A,[1B42h] ; 165db
	OR A,A ; 165df
	JRS Z,loc_0x0165E8 ; 165e0
	LD BA,#0E5E9h ; 165e2
	CARL loc_0x007948 ; 165e5
loc_0x0165E8:
	RET
; ---------------------- ; 165e8
loc_0x0165E9:
	LD A,[1B42h] ; 165e9
	OR A,A ; 165ed
	JRS NZ,loc_0x01661A ; 165ee
	LD A,[1B11h] ; 165f0
	CP A,#2Ch ; 165f4
	JRS NC,loc_0x016613 ; 165f6
	LD A,[1B11h] ; 165f8
	LD [IX+18h],A ; 165fc
	LD A,[1AB6h] ; 165ff
	AND A,A ; 16603
	JRS Z,loc_0x01660C ; 16604
	LD A,#11h ; 16606
	LD [14FAh],A ; 16608
loc_0x01660C:
	LD BA,#0E590h ; 1660c
	CARL loc_0x007948 ; 1660f
	RET
; ---------------------- ; 16612
loc_0x016613:
	LD BA,#0E5DBh ; 16613
	CARL loc_0x007948 ; 16616
	RET
; ---------------------- ; 16619
loc_0x01661A:
	LD BA,[1B10h] ; 1661a
	CARL loc_0x007982 ; 1661d
	RET
; ---------------------- ; 16620
	DB 0BEh ; 16621
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
	DB 91h
; ---------------------- ; 167d8
loc_0x0167D9:
	LD A,[1642h] ; 167d9
	BIT A,#08h ; 167dd
	JRS NZ,loc_0x0167EF ; 167df
	BIT A,#10h ; 167e1
	JRS Z,loc_0x0167F9 ; 167e3
	LD A,[IX+0Eh] ; 167e5
	CP A,#1Ah ; 167e8
	JRS NC,loc_0x0167F9 ; 167ea
	INC A ; 167ec
	JRS loc_0x0167F6
; ---------------------- ; 167ed
loc_0x0167EF:
	LD A,[IX+0Eh] ; 167ef
	OR A,A ; 167f2
	JRS Z,loc_0x0167F9 ; 167f3
	DEC A ; 167f5
loc_0x0167F6:
	LD [IX+0Eh],A ; 167f6
loc_0x0167F9:
	RET
; ---------------------- ; 167f9
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
loc_0x016B47:
	LD A,[1642h] ; 16b47
	BIT A,#01h ; 16b4b
	JRS NZ,loc_0x016BB3 ; 16b4d
	CARL loc_0x014D3D ; 16b4f
	CARL loc_0x012F7C ; 16b52
	LD A,[IX+18h] ; 16b55
	OR A,A ; 16b58
	JRS Z,loc_0x016B80 ; 16b59
	LD A,[1AB6h] ; 16b5b
	AND A,A ; 16b5f
	JRS Z,loc_0x016B68 ; 16b60
	LD A,#1Dh ; 16b62
	LD [14FAh],A ; 16b64
loc_0x016B68:
	LD [1B39h],IX ; 16b68
	LD HL,#1B43h ; 16b6b
	INC [HL] ; 16b6e
	LD NB,#01h ; 16b6f
	CARL loc_0x009ABE ; 16b72
	JRS NZ,loc_0x016B80 ; 16b75
	CARL loc_0x012FF6 ; 16b77
	LD NB,#01h ; 16b7a
	CARL loc_0x00C0E9 ; 16b7d
loc_0x016B80:
	PUSH IP ; 16b80
	PUSH IY ; 16b81
	LD A,[IX+18h] ; 16b82
	ADD A,A ; 16b85
	LD B,#00h ; 16b86
	LD IY,#6BC4h ; 16b88
	LD YP,#01h ; 16b8b
	ADD IY,BA ; 16b8e
	LD BA,[IY] ; 16b90
	POP IY ; 16b92
	POP IP ; 16b93
	LD HL,#0EB05h ; 16b94
	CARL loc_0x007970 ; 16b97
	LD A,[IX+18h] ; 16b9a
	CARL loc_0x016BD0 ; 16b9d
	LD [IX+19h],A ; 16ba0
	LD B,A ; 16ba3
	LD A,[IX+18h] ; 16ba4
	CARL loc_0x016BE6 ; 16ba7
	LD B,A ; 16baa
	LD A,[IX+0Ah] ; 16bab
	SUB A,B ; 16bae
	LD [IX+0Ah],A ; 16baf
	RET
; ---------------------- ; 16bb2
loc_0x016BB3:
	LD A,[1AB6h] ; 16bb3
	AND A,A ; 16bb7
	JRS Z,loc_0x016BC0 ; 16bb8
	LD A,#1Ch ; 16bba
	LD [14FAh],A ; 16bbc
loc_0x016BC0:
	CARL loc_0x0167D9 ; 16bc0
	RET
; ---------------------- ; 16bc3
	DB 0DEh ; 16bc4
	ASCII "j" ; 16bc5
	DB 06h ; 16bc6
	ASCII "h" ; 16bc7
	DB 82h ; 16bc8
	ASCII "h" ; 16bc9
	DB 0FEh ; 16bca
	ASCII "hzi" ; 16bcb
	DB 0F6h ; 16bce
	ASCII "i" ; 16bcf
loc_0x016BD0:
	PUSH IP ; 16bd0
	PUSH IY ; 16bd1
	LD B,#00h ; 16bd2
	LD IY,#6BE0h ; 16bd4
	LD YP,#01h ; 16bd7
	ADD IY,BA ; 16bda
	LD A,[IY] ; 16bdc
	POP IY ; 16bdd
	POP IP ; 16bde
	RET
; ---------------------- ; 16bdf
	DB 00h, 05h, 07h, 09h, 0Bh, 0Dh
; ---------------------- ; 16be0
loc_0x016BE6:
	PUSH IP ; 16be6
	PUSH IY ; 16be7
	LD B,#00h ; 16be8
	LD IY,#6BF6h ; 16bea
	LD YP,#01h ; 16bed
	ADD IY,BA ; 16bf0
	LD A,[IY] ; 16bf2
	POP IY ; 16bf3
	POP IP ; 16bf4
	RET
; ---------------------- ; 16bf5
	DB 00h, 07h, 09h, 0Bh, 0Dh, 0Fh ; 16bf6
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
global loc_0x01724C
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