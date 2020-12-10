; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;   data.asm - stuff

	DEFSECT ".rom7", CODE AT 038000H
	SECT ".rom7"
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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
	DB 83h, 84h, 85h, 00h, 00h, 00h, 00h, 00h ; 380b5
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
	DB 06h, 93h, 0FAh

; code?
	DB 0CFh, 0D8h, 0CEh ; 3824a
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
	DB 0Bh, 0C3h, 02h, 00h, 0F8h, 0CEh, 40h, 08h ; 38281
	DB 07h, 0CEh ; 38289
	ASCII "D" ; 3828b
	DB 08h, 93h, 0CEh, 40h, 09h, 07h, 0CEh ; 3828c
	ASCII "D" ; 38293
	DB 09h, 93h, 0F8h, 0CEh, 0D0h ; 38294
	ASCII "M" ; 38299
	DB 16h, 20h, 0E6h, 03h, 93h, 0F8h, 0CEh, 0D0h ; 3829a
	DB 0B6h, 1Ah, 20h, 0E6h, 06h ; 382a2
	ASCII "G" ; 382a7
	DB 0CEh, 0D4h, 0FAh, 14h, 93h, 0F8h ; 382a8
	ASCII "G" ; 382ae
	DB 0CEh, 0D4h, 0F4h, 14h, 93h, 0F8h, 0CEh ; 382af
	ASCII "D" ; 382b6
	DB 04h, 0CEh ; 382b7
	ASCII "L" ; 382b9
	DB 05h, 0F8h, 0CEh ; 382ba
	ASCII "D" ; 382bd
	DB 02h, 0CEh ; 382be
	ASCII "L" ; 382c0
	DB 03h, 0B0h, 01h, 0CEh ; 382c1
	ASCII "D" ; 382c5
	DB 06h, 0F8h, 0CEh ; 382c6
	ASCII "D" ; 382c9
	DB 02h, 0CEh ; 382ca
	ASCII "L" ; 382cc
	DB 03h, 0B0h, 01h, 0CEh ; 382cd
	ASCII "D" ; 382d1
	DB 06h, 0C4h, 0EFh, 82h, 0CEh ; 382d2
	ASCII "D" ; 382d7
	DB 04h, 0CEh ; 382d8
	ASCII "L" ; 382da
	DB 05h, 0F8h, 0CEh ; 382db
	ASCII "T" ; 382de
	DB 04h, 0CEh, 5Ch, 05h, 0CEh ; 382df
	ASCII "D" ; 382e4
	DB 02h, 0CEh ; 382e5
	ASCII "L" ; 382e7
	DB 03h, 0B0h, 01h, 0CEh ; 382e8
	ASCII "D" ; 382ec
	DB 06h, 0F8h, 0F8h, 3Eh, 82h ; 382ed
	ASCII "8" ; 382f2
	DB 82h, 0C7h, 00h, 00h, 0C5h, 16h, 19h, 0CEh ; 382f3
	DB 0C5h, 00h, 0B1h, 10h, 0C6h, 18h, 00h, 0CFh ; 382fb
	DB 0C7h, 0CFh, 22h, 0F5h, 0FBh, 0F8h, 0CFh, 0D7h ; 38303
	DB 0CEh ; 3830b
	ASCII "T" ; 3830c
	DB 08h, 0CEh, 5Ch, 09h, 0CEh ; 3830d
	ASCII "A" ; 38312
	DB 02h, 0CEh ; 38313
	ASCII "I" ; 38315
	DB 03h, 0CEh ; 38316
	ASCII "D" ; 38318
	DB 04h, 0CEh ; 38319
	ASCII "L" ; 3831b
	DB 05h, 0CEh ; 3831c
	ASCII "A" ; 3831e
	DB 04h, 0CEh ; 3831f
	ASCII "I" ; 38321
	DB 05h, 0CEh ; 38322
	ASCII "D" ; 38324
	DB 02h, 0CEh ; 38325
	ASCII "L" ; 38327
	DB 03h ; 38328
	ASCII "8" ; 38329
	DB 0CEh ; 3832a
	ASCII "D" ; 3832b
	DB 07h, 0CEh ; 3832c
	ASCII "D" ; 3832e
	DB 0Ch, 0CEh ; 3832f
	ASCII "D" ; 38331
	DB 0Dh, 0CEh ; 38332
	ASCII "D" ; 38334
	DB 0Ah, 0CEh ; 38335
	ASCII "D" ; 38337
	DB 0Bh, 0CEh ; 38338
	ASCII "D" ; 3833a
	DB 0Fh, 0CEh ; 3833b
	ASCII "D" ; 3833d
	DB 10h, 0CEh ; 3833e
	ASCII "D" ; 38340
	DB 11h, 0CEh ; 38341
	ASCII "D" ; 38343
	DB 12h, 0CEh ; 38344
	ASCII "D" ; 38346
	DB 13h, 0CEh ; 38347
	ASCII "D" ; 38349
	DB 14h, 0CEh ; 3834a
	ASCII "D" ; 3834c
	DB 15h, 0A8h, 0CEh ; 3834d
	ASCII "D" ; 38350
	DB 16h, 0CEh ; 38351
	ASCII "L" ; 38353
	DB 17h, 0B0h, 01h, 0CEh ; 38354
	ASCII "D" ; 38358
	DB 06h, 0B0h, 03h, 0CEh ; 38359
	ASCII "D" ; 3835d
	DB 0Eh, 0CFh, 0D9h, 0C3h, 06h, 00h, 0F0h, 04h ; 3835e
	DB 0AAh, 0AEh, 0F8h, 0F4h, 0A6h, 0A2h, 0A0h, 0CEh ; 38366
	DB 0C7h, 03h, 0C6h, 16h, 19h, 0CEh, 0C6h, 00h ; 3836e
	DB 0CEh, 0C5h, 00h, 0B1h, 10h ; 38376
	ASCII "F" ; 3837b
	DB 0CEh, 28h, 01h, 0E6h, 89h, 0C2h, 18h, 00h ; 3837c
	DB 0F5h, 0F6h, 0A8h, 0AAh, 0AEh, 0F8h, 0A6h, 0A2h ; 38384
	DB 0A0h, 0CEh, 0C7h, 03h, 0C6h, 16h, 19h, 0CEh ; 3838c
	DB 0C6h, 00h, 0CEh, 0C5h, 00h, 0B1h, 10h ; 38394
	ASCII "F" ; 3839b
	DB 0CEh, 28h, 01h, 0E6h, 0Ch, 0CEh, 40h, 08h ; 3839c
	DB 0CEh ; 383a4
	ASCII "H" ; 383a5
	DB 09h, 0CFh, 19h, 0EEh, 17h, 00h, 0C2h, 18h ; 383a6
	DB 00h, 0F5h, 0EBh, 0C6h, 16h, 19h, 0B1h, 10h ; 383ae
	ASCII "F" ; 383b6
	DB 0CEh, 28h, 01h, 0EEh ; 383b7
	ASCII "M" ; 383bb
	DB 0FFh, 0C2h, 18h, 00h, 0F5h, 0F5h, 0A8h, 0AAh ; 383bc
	DB 0AEh, 0F8h, 0CEh, 0C7h, 03h, 0C6h, 16h, 19h ; 383c4
	DB 0CEh, 0C6h, 00h, 0CEh, 0C5h, 00h, 0B1h, 10h ; 383cc
	DB 0CFh, 0B1h ; 383d4
	ASCII "F" ; 383d6
	DB 0CEh, 28h, 01h, 0E6h ; 383d7
	ASCII "K" ; 383db
	DB 0CEh ; 383dc
	ASCII "P" ; 383dd
	DB 04h, 0CEh ; 383de
	ASCII "X" ; 383e0
	DB 05h, 0F0h ; 383e1
	ASCII "K" ; 383e3
	DB 0CFh, 0E6h, 0C1h, 06h, 00h, 8Eh, 0E7h, 3Bh ; 383e4
	DB 0CEh ; 383ec
	ASCII "P" ; 383ed
	DB 02h, 0CEh ; 383ee
	ASCII "X" ; 383f0
	DB 03h, 0CFh, 0EDh, 0CEh, 0C7h, 03h, 0CFh, 0D8h ; 383f1
	DB 0C3h, 02h, 00h, 97h, 80h, 0E6h, 11h, 0CFh ; 383f9
	DB 0E4h, 0F0h, 2Bh, 0F1h, 0EFh, 0CFh, 0E3h, 0CEh ; 38401
	ASCII "D" ; 38409
	DB 02h, 0CEh ; 3840a
	ASCII "L" ; 3840c
	DB 03h, 0F1h, 17h, 0CEh ; 3840d
	ASCII "D" ; 38411
	DB 06h, 0CFh, 0D8h, 0CEh ; 38412
	ASCII "D" ; 38416
	DB 0Ch, 0CEh ; 38417
	ASCII "L" ; 38419
	DB 0Dh, 0C3h, 02h, 00h, 0CFh, 0E3h, 0CEh ; 3841a
	ASCII "D" ; 38421
	DB 02h, 0CEh ; 38422
	ASCII "L" ; 38424
	DB 03h, 0C2h, 18h, 00h, 0CFh, 0B5h, 0F5h, 0A8h ; 38425
	DB 0F8h, 0F4h, 0C5h ; 3842d
	ASCII "M" ; 38430
	DB 16h, 95h, 01h, 0EEh, 0F7h, 00h, 0F3h, 01h ; 38431
	DB 00h, 0C6h, 16h, 19h, 0CEh, 0C6h, 00h, 0CEh ; 38439
	DB 0C5h, 00h, 0B1h, 10h, 0CFh, 0B1h ; 38441
	ASCII "F" ; 38447
	DB 0CEh, 28h, 01h, 0EEh, 0D6h, 00h ; 38448
	ASCII "8" ; 3844e
	DB 0CEh ; 3844f
	ASCII "D" ; 38450
	DB 12h, 0B9h ; 38451
	ASCII "a" ; 38453
	DB 16h, 0CEh, 40h, 08h, 0CEh, 00h, 0Ah, 0B1h ; 38454
	DB 00h, 0CFh ; 3845c
	ASCII "8" ; 3845e
	DB 0EDh, 0C2h, 00h, 0C1h, 0Dh, 00h, 0CEh, 40h ; 3845f
	DB 08h, 0B1h, 00h, 0CFh, 19h, 0EDh, 0B5h, 00h ; 38467
	DB 0CEh, 40h, 0Ah, 0CEh ; 3846f
	ASCII "D" ; 38473
	DB 11h, 0CEh, 40h, 08h, 0CEh ; 38474
	ASCII "D" ; 38479
	DB 0Fh ; 3847a
	ASCII "8" ; 3847b
	DB 0CEh ; 3847c
	ASCII "D" ; 3847d
	DB 13h, 0CEh, 40h, 08h, 0B1h, 00h, 0B9h ; 3847e
	ASCII "a" ; 38485
	DB 16h, 0CFh, 28h, 0E4h, 13h, 0CEh ; 38486
	ASCII "T" ; 3848c
	DB 13h ; 3848d
	ASCII "J" ; 3848e
	DB 0CEh, 40h, 11h, 11h, 0CEh ; 3848f
	ASCII "D" ; 38494
	DB 11h, 0CEh, 40h, 0Fh, 01h, 0CEh ; 38495
	ASCII "D" ; 3849b
	DB 0Fh, 0B9h ; 3849c
	ASCII "a" ; 3849e
	DB 16h, 0C1h, 0Eh, 00h, 0CEh, 40h, 08h, 0CEh ; 3849f
	DB 00h, 0Ah, 0B1h, 00h, 0CFh, 09h, 0E4h, 09h ; 384a7
	ASCII "H" ; 384af
	DB 0CEh, 40h, 11h, 11h, 0CEh ; 384b0
	ASCII "D" ; 384b5
	DB 11h, 0CEh, 40h, 0Ah, 0CEh, 10h, 11h, 0CEh ; 384b6
	ASCII "D" ; 384be
	DB 15h, 0B9h ; 384bf
	ASCII "c" ; 384c1
	DB 16h, 0CEh, 40h, 09h, 0CEh, 00h, 0Bh, 0B1h ; 384c2
	DB 00h, 0CFh ; 384ca
	ASCII "8" ; 384cc
	DB 0E5h ; 384cd
	ASCII "U" ; 384ce
	DB 0C1h, 09h, 00h, 0CEh, 40h, 09h, 0B1h, 00h ; 384cf
	DB 0CFh, 19h, 0E5h ; 384d7
	ASCII "I" ; 384da
	DB 0CEh, 40h, 0Bh, 0CEh ; 384db
	ASCII "D" ; 384df
	DB 12h, 0CEh, 40h, 09h, 0CEh ; 384e0
	ASCII "D" ; 384e5
	DB 10h ; 384e6
	ASCII "8" ; 384e7
	DB 0CEh ; 384e8
	ASCII "D" ; 384e9
	DB 14h, 0CEh, 40h, 09h, 0B1h, 00h, 0B9h ; 384ea
	ASCII "c" ; 384f1
	DB 16h, 0CFh, 28h, 0E4h, 13h, 0CEh ; 384f2
	ASCII "T" ; 384f8
	DB 14h ; 384f9
	ASCII "J" ; 384fa
	DB 0CEh, 40h, 12h, 11h, 0CEh ; 384fb
	ASCII "D" ; 38500
	DB 12h, 0CEh, 40h, 10h, 01h, 0CEh ; 38501
	ASCII "D" ; 38507
	DB 10h, 0B9h ; 38508
	ASCII "c" ; 3850a
	DB 16h, 0C1h, 0Ah, 00h, 0CEh, 40h, 09h, 0CEh ; 3850b
	DB 00h, 0Bh, 0B1h, 00h, 0CFh, 09h, 0E4h, 09h ; 38513
	ASCII "H" ; 3851b
	DB 0CEh, 40h, 12h, 11h, 0CEh ; 3851c
	ASCII "D" ; 38521
	DB 12h, 0C2h, 18h, 00h, 0CFh, 0B5h, 89h, 0EFh ; 38522
	DB 1Ah, 0FFh, 0F8h, 0F8h

global lbl_0x03852E
lbl_0x03852E:
	
	LD HL, #164Dh
	BIT [HL], #01h
	JRL Z, lbl_0x0385AE

	JRL lbl_0x038539

lbl_0x038539:

	LD IX, #1916h
	LD XP, #00h

	LD EP, #00h
	
	LD B, #10h
	PUSH B
	
	LD A, [IX]
	OR A, [IX+1h]
	JRS Z, lbl_0x0385A6

	LD A, [IX+12h]
	AND A, A
	JRS Z, lbl_0x0385A6

	LD A, [IX+0Ch]
	LD B, [IX+0Dh]
	LD IY, BA
	LD A, [IX+0Eh]
	LD YP, A

	LD A, [IX+0Ah]
	LD L, [IX+14h]
	MLT
	
	LD A, [IX+13h]
	LD B, #00h

	ADD HL, BA
	ADD IY, HL
	DB 0CEh, 40h, 10h, 15h ; 38570
	ASCII "c" ; 38574
	DB 16h, 0B2h, 10h, 0CEh, 0D8h, 0CEh, 40h, 0Fh ; 38575
	DB 15h ; 3857d
	ASCII "a" ; 3857e
	DB 16h, 0B1h, 00h, 0CFh, 20h, 0C1h, 60h, 13h ; 3857f
	DB 0CEh, 40h, 12h, 22h, 0Fh, 0A1h, 0CEh ; 38587
	ASCII "H" ; 3858e
	DB 11h, 0CEh, 0B0h, 0Fh ; 3858f
	ASCII "o" ; 38593
	DB 93h, 91h, 0F5h, 0FCh, 0CEh ; 38594
	ASCII "P" ; 38599
	DB 15h, 0B3h, 00h, 0CFh ; 3859a
	ASCII "C" ; 3859e
	DB 0A9h, 0C1h, 10h, 00h, 88h, 0E7h, 0E7h
lbl_0x0385A6:
	DB 0C2h ; 3859f
	DB 18h, 00h, 0CFh, 0B5h, 0F5h, 98h, 0F8h
; ---------------------- ; 385AE
lbl_0x0385AE:

	LD IX, #1916h
	LD XP, #00h

	LD EP, #00h
	LD B, #10h

lbl_0x0385B9:

	PUSH B

	LD A, [IX]
	OR A, [IX+01h]
	JRS Z, lbl_0x0385FF

	LD A, [IX+0Ah]
	OR A, [IX+0Bh]
	JRS Z, lbl_0x0385FF
	
	DB 0CEh, 40h, 0Ch, 0CEh ; 385c9
	ASCII "H" ; 385cd
	DB 0Dh, 0CFh, 0ECh, 0CEh, 40h, 0Eh, 0CEh, 0CFh ; 385ce
	DB 0CEh, 40h, 09h, 0B2h, 18h, 0CEh, 0D8h, 0CEh ; 385d6
	DB 40h, 08h, 0B1h, 00h, 0CFh, 20h, 0C1h, 60h ; 385de
	DB 13h, 0CEh, 40h, 0Bh, 22h, 0Fh, 0A1h, 0CEh ; 385e6
	ASCII "H" ; 385ee
	DB 0Ah, 0CEh, 0B0h, 0Fh ; 385ef
	ASCII "o" ; 385f3
	DB 93h, 91h, 0F5h, 0FCh, 0A9h, 0C1h, 18h, 00h ; 385f4
	DB 88h, 0E7h, 0EEh
lbl_0x0385FF:

	ADD IX, #0018h
	POP B

	DJR NZ, lbl_0x0385B9 
	RET

; ---------------------- ;
	DB 92h, 90h, 90h, 94h, 90h ; 38604
	DB 90h, 90h, 90h, 90h, 90h, 90h, 90h, 93h ; 3860c
	DB 90h, 90h, 91h, 92h, 90h, 90h, 94h, 90h ; 38614
	DB 95h, 95h, 90h, 90h, 95h, 95h, 90h, 93h ; 3861c
	DB 90h, 90h, 91h ; 38624
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
	DB 05h, 0F8h, 0A6h, 0B0h, 00h, 0CEh ; 386a0
	ASCII "D" ; 386a6
	DB 0Eh, 0CEh, 0C7h, 00h, 0C7h, 0A0h, 1Ah, 0CEh ; 386a7
	DB 0D0h, 7Eh, 16h, 0DFh, 2Ah ; 386af
	ASCII "0" ; 386b4
	DB 0CEh ; 386b5
	ASCII "E" ; 386b6
	DB 01h, 0CEh, 0B4h ; 386b7
	ASCII "0q" ; 386ba
	DB 0CEh, 0D0h, 7Dh, 16h, 0DFh, 2Ah ; 386bc
	ASCII "0" ; 386c2
	DB 0CEh ; 386c3
	ASCII "E" ; 386c4
	DB 04h, 0CEh, 0B4h ; 386c5
	ASCII "0" ; 386c8
	DB 0CEh ; 386c9
	ASCII "M" ; 386ca
	DB 03h, 0CEh, 0D0h, 7Ch, 16h, 0DFh, 2Ah ; 386cb
	ASCII "0" ; 386d2
	DB 0CEh ; 386d3
	ASCII "E" ; 386d4
	DB 07h, 0CEh, 0B4h ; 386d5
	ASCII "0" ; 386d8
	DB 0CEh ; 386d9
	ASCII "M" ; 386da
	DB 06h, 0AEh, 0F8h, 91h, 86h, 0A2h, 86h, 85h ; 386db
	DB 86h ; 386e3
	ASCII "n" ; 386e4
	DB 82h, 00h, 06h ; 386e5
	ASCII "z" ; 386e8
	DB 82h, 09h, 01h, 3Eh, 82h, 0C4h, 0A8h, 1Ah ; 386e9
	DB 0CEh ; 386f1
	ASCII "D" ; 386f2
	DB 0Ch, 0CEh ; 386f3
	ASCII "L" ; 386f5
	DB 0Dh, 0B0h, 00h, 0CEh ; 386f6
	ASCII "D" ; 386fa
	DB 0Eh, 0A6h, 0A2h, 0CEh, 0D0h, 8Dh, 16h, 0B2h ; 386fb
	DB 11h, 0CEh, 0D8h, 0C1h, 3Ah, 15h, 0CFh, 0E9h ; 38703
	DB 0C7h, 0A8h, 1Ah, 0CEh, 0C7h, 00h, 0CEh, 40h ; 3870b
	DB 03h, 0DFh, 0C0h ; 38713
	ASCII "00" ; 38716
	DB 0CEh ; 38718
	ASCIZ "M" ; 38719
	DB 0CEh ; 3871b
	ASCII "E" ; 3871c
	DB 01h, 0CEh, 40h, 02h, 0DFh, 0C0h ; 3871d
	ASCII "00" ; 38723
	DB 0CEh ; 38725
	ASCII "M" ; 38726
	DB 02h, 0CEh ; 38727
	ASCII "E" ; 38729
	DB 03h, 0CEh, 40h, 01h, 0DFh, 0C0h ; 3872a
	ASCII "00" ; 38730
	DB 0CEh ; 38732
	ASCII "M" ; 38733
	DB 04h, 0CEh ; 38734
	ASCII "E" ; 38736
	DB 05h, 0CEh, 40h, 00h, 0DFh, 0C0h ; 38737
	ASCII "00" ; 3873d
	DB 0CEh ; 3873f
	ASCII "M" ; 38740
	DB 06h, 0CEh ; 38741
	ASCII "E" ; 38743
	DB 07h, 0CEh, 40h, 0FFh, 22h, 0Fh, 2Ah, 10h ; 38744
	DB 0CEh ; 3874c
	ASCII "E" ; 3874d
	DB 08h, 0AAh, 0B0h, 01h, 0CEh ; 3874e
	ASCII "D" ; 38753
	DB 06h, 0AEh, 0F8h, 0EEh, 86h, 0FCh, 86h, 0E4h ; 38754
	DB 86h ; 3875c
	ASCII "M" ; 3875d
	DB 82h ; 3875e
	ASCII "k" ; 3875f
	DB 87h ; 38760
	ASCII "n" ; 38761
	DB 82h, 00h, 07h ; 38762
	ASCII "z" ; 38765
	DB 82h, 0Ch, 01h, 3Eh, 82h, 0B0h, 01h, 0CEh ; 38766
	ASCII "D" ; 3876e
	DB 06h, 0CEh, 0D0h, 8Dh, 16h, 0B2h, 11h, 0CEh ; 3876f
	DB 0D8h, 0C1h ; 38777
	ASCII "9" ; 38779
	DB 15h ; 3877a
	ASCII "E " ; 3877b
	DB 0E6h, 27h ; 3877d
	ASCII "2" ; 3877f
	DB 01h, 0E6h, 05h ; 38780
	ASCII "2" ; 38783
	DB 05h, 0E6h, 10h, 0B0h, 03h, 0CEh ; 38784
	ASCII "D" ; 3878a
	DB 0Eh, 0C5h, 0C8h, 87h, 0CEh ; 3878b
	ASCII "T" ; 38790
	DB 0Ch, 0CEh, 5Ch, 0Dh, 0F8h, 0B0h, 03h, 0CEh ; 38791
	ASCII "D" ; 38799
	DB 0Eh, 0C5h, 0BCh, 87h, 0CEh ; 3879a
	ASCII "T" ; 3879f
	DB 0Ch, 0CEh, 5Ch, 0Dh, 0F8h, 0B0h, 00h, 0CEh ; 387a0
	ASCII "D" ; 387a8
	DB 0Eh, 0CEh, 0D0h, 8Dh, 16h, 0B2h, 11h, 0CEh ; 387a9
	DB 0D8h, 0C1h, 3Eh, 15h, 0CEh ; 387b1
	ASCII "T" ; 387b6
	DB 0Ch, 0CEh, 5Ch, 0Dh, 0F8h, 0F0h, 0F1h, 0F2h ; 387b7
	DB 0F3h, 0F4h, 0F5h, 0F6h, 0F7h, 20h, 20h, 20h ; 387bf
	DB 20h, 0F8h, 0F9h, 0FAh, 0FBh, 0FCh, 0FDh, 0FEh ; 387c7
	DB 0FFh, 20h, 20h, 20h, 20h ; 387cf
	ASCII "k" ; 387d4
	DB 87h ; 387d5
	ASCII "k" ; 387d6
	DB 87h, 5Dh, 87h, 0CEh, 0D0h, 0AAh, 15h, 0CEh ; 387d7
	DB 0D1h, 0ABh, 15h, 22h, 03h, 0E7h, 08h, 0CEh ; 387df
	DB 0BCh, 02h, 0E7h, 03h, 0B1h, 0Dh ; 387e7
	ASCII "A" ; 387ed
	DB 0C7h, 0FAh, 87h, 0CEh, 0C7h, 03h, 0B1h, 00h ; 387ee
	DB 0CFh ; 387f6
	ASCII "BG" ; 387f7
	DB 0F8h, 00h, 1Fh, 1Ch, 1Fh, 1Eh, 1Fh, 1Eh ; 387f9
	DB 1Fh, 1Fh, 1Eh, 1Fh, 1Eh, 1Fh, 1Dh, 0A6h ; 38801
	DB 0A2h, 0CEh, 0D0h, 0BAh, 1Ah, 0B1h, 00h, 0C6h ; 38809
	ASCII "I" ; 38811
	DB 88h, 0CEh, 0C6h, 03h, 0CFh, 40h ; 38812
	ASCII "G" ; 38818
	DB 80h ; 38819
	ASCII "6" ; 3881a
	DB 0E7h, 05h, 0C2h, 06h, 00h ; 3881b
	ASCII "Fp" ; 38820
	DB 0CEh, 0D0h, 0BAh, 1Ah ; 38822
	ASCII "2" ; 38826
	DB 02h, 0E7h, 11h, 0F2h, 0AEh, 0FFh ; 38827
	ASCII "5" ; 3882d
	DB 0ACh, 15h, 0E5h, 15h, 0B0h, 01h, 0CEh, 0D4h ; 3882e
	DB 0ACh, 15h, 0F1h, 0Dh, 0F2h, 9Eh, 0FFh ; 38836
	ASCII "5" ; 3883d
	DB 0ACh, 15h, 0E5h, 05h, 0CEh, 0D4h, 0ACh, 15h ; 3883e
	DB 0AAh, 0AEh, 0F8h ; 38846
	ASCII "d" ; 38849
	DB 0Dh, 20h, 18h, 3Ch, 3Ch, 01h, 01h, 01h ; 3884a
	DB 00h, 00h, 00h, 0A6h, 0A2h, 0CEh, 0D0h, 0BAh ; 38852
	DB 1Ah, 0B1h, 00h, 0C6h, 7Eh, 88h, 0CEh, 0C6h ; 3885a
	DB 03h, 0CFh, 40h ; 38862
	ASCII "G" ; 38865
	DB 88h ; 38866
	ASCII "6" ; 38867
	DB 0E7h, 05h, 0C2h, 06h, 00h ; 38868
	ASCII "Fp" ; 3886d
	DB 0F2h ; 3886f
	ASCII "i" ; 38870
	DB 0FFh ; 38871
	ASCII "5" ; 38872
	DB 0ACh, 15h, 0E5h, 05h, 0CEh, 0D4h, 0ACh, 15h ; 38873
	DB 0AAh, 0AEh, 0F8h, 00h, 00h, 00h, 0FFh, 0FFh ; 3887b
	DB 0FFh ; 38883
	ASCII "c" ; 38884
	DB 0Ch, 1Fh, 17h, 3Bh, 3Bh, 0A2h, 0CEh, 0D0h ; 38885
	DB 0BAh, 1Ah ; 3888d
	ASCII "2" ; 3888f
	DB 06h, 0E6h, 1Bh, 0B1h, 00h, 0C7h, 0AAh, 15h ; 38890
	DB 0CEh, 0C7h, 00h, 0CFh ; 38898
	ASCII "B" ; 3889c
	DB 0C5h ; 3889d
	ASCII "E" ; 3889e
	DB 16h, 95h, 08h, 0EBh ; 3889f
	ASCII "d" ; 388a3
	DB 0FFh, 0C5h ; 388a4
	ASCII "E" ; 388a6
	DB 16h, 95h, 10h, 0EBh, 0A9h, 0FFh, 0AAh, 0F8h ; 388a7
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
	DB 0CEh, 0D0h, 0AEh, 15h, 0F2h, 83h, 9Ch, 02h ; 388ec
	DB 60h, 0CEh ; 388f4
	ASCII "E" ; 388f6
	DB 04h ; 388f7
	ASCII "A" ; 388f8
	DB 02h, 60h, 0CEh ; 388f9
	ASCII "E" ; 388fc
	DB 03h, 0CEh, 0D0h, 0AFh, 15h, 0F2h ; 388fd
	ASCII "q" ; 38903
	DB 9Ch, 02h, 60h, 0CEh ; 38904
	ASCII "E" ; 38908
	DB 07h ; 38909
	ASCII "A" ; 3890a
	DB 02h, 60h, 0CEh ; 3890b
	ASCII "E" ; 3890e
	DB 06h, 0AEh, 0F8h, 0BFh, 88h, 0D0h, 88h, 0AFh ; 3890f
	DB 88h ; 38917
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
	DB 0CEh, 0D0h, 0ABh, 15h, 0F2h, 17h, 9Ch, 02h ; 38958
	DB 60h, 0CEh ; 38960
	ASCII "E" ; 38962
	DB 04h ; 38963
	ASCII "A" ; 38964
	DB 02h, 60h, 0CEh ; 38965
	ASCII "E" ; 38968
	DB 03h, 0CEh, 0D0h, 0ACh, 15h, 0F2h, 05h, 9Ch ; 38969
	DB 02h, 60h, 0CEh ; 38971
	ASCII "E" ; 38974
	DB 07h ; 38975
	ASCII "A" ; 38976
	DB 02h, 60h, 0CEh ; 38977
	ASCII "E" ; 3897a
	DB 06h, 0AEh, 0F8h, 28h, 89h ; 3897b
	ASCII "9" ; 38980
	DB 89h, 18h, 89h, 0CEh, 40h, 16h, 0CEh, 0D4h ; 38981
	DB 0B2h, 1Ah, 0CEh, 40h, 17h, 0CEh, 0D4h, 0B1h ; 38989
	DB 1Ah, 0F8h, 0CEh, 0C5h, 00h, 0C5h ; 38991
	ASCII "E" ; 38997
	DB 16h, 0CEh, 0D0h, 0B1h, 1Ah, 95h, 20h, 0E6h ; 38998
	DB 02h, 88h, 95h, 40h, 0E6h, 02h, 80h, 22h ; 389a0
	DB 0Fh, 2Ah ; 389a8
	ASCII "0" ; 389aa
	DB 0CEh, 0D4h, 0B1h, 1Ah, 0CEh, 0D0h, 0B2h, 1Ah ; 389ab
	DB 95h, 10h, 0E6h, 02h, 88h, 95h, 08h, 0E6h ; 389b3
	DB 02h, 80h, 22h, 0Fh, 2Ah ; 389bb
	ASCII "0" ; 389c0
	DB 0CEh, 0D4h, 0B2h, 1Ah, 0B0h, 01h, 0CEh ; 389c1
	ASCII "D" ; 389c8
	DB 06h, 0F8h, 0C4h, 0B1h, 1Ah, 0CEh ; 389c9
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
	DB 0BCh, 0B3h, 1Ah, 0F8h, 0CEh, 0C5h, 00h, 0C5h ; 38a18
	ASCII "E" ; 38a20
	DB 16h, 0CEh, 0D0h, 0B1h, 1Ah, 95h, 20h, 0E6h ; 38a21
	DB 02h, 88h, 95h, 40h, 0E6h, 02h, 80h, 22h ; 38a29
	DB 0Fh, 2Ah ; 38a31
	ASCII "0" ; 38a33
	DB 0CEh, 0D4h, 0B1h, 1Ah, 0CEh, 0D0h, 0B2h, 1Ah ; 38a34
	DB 95h, 10h, 0E6h, 02h, 88h, 95h, 08h, 0E6h ; 38a3c
	DB 02h, 80h, 22h, 0Fh, 2Ah ; 38a44
	ASCII "0" ; 38a49
	DB 0CEh, 0D4h, 0B2h, 1Ah, 0B0h, 01h, 0CEh ; 38a4a
	ASCII "D" ; 38a51
	DB 06h, 95h, 01h, 0E6h, 10h, 0C4h, 0EFh, 82h ; 38a52
	DB 0CEh ; 38a5a
	ASCII "D" ; 38a5b
	DB 04h, 0CEh ; 38a5c
	ASCII "L" ; 38a5e
	DB 05h, 0F2h ; 38a5f
	ASCII "r" ; 38a61
	DB 98h, 0F2h, 2Ah, 98h, 0F8h, 0F8h ; 38a62
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
	DB 8Ch, 0BCh, 7Bh, 1Bh, 0F8h, 0CEh, 0D0h ; 38a8d
	ASCII "C" ; 38a94
	DB 16h, 96h, 01h, 0E7h, 15h, 96h, 40h, 0E7h ; 38a95
	DB 09h, 96h, 20h, 0E6h, 3Fh, 0B0h, 00h, 0F1h ; 38a9d
	DB 03h, 0B0h, 01h, 0CEh, 0D4h ; 38aa5
	ASCII "z" ; 38aaa
	DB 1Bh, 0F1h ; 38aab
	ASCII "3" ; 38aad
	DB 0CEh, 0D0h, 0B6h, 1Ah, 20h, 0E6h, 07h, 0B0h ; 38aae
	DB 01h, 0CEh, 0D4h, 0FAh, 14h, 0A6h, 0A3h, 0BBh ; 38ab6
	DB 7Bh, 1Bh, 0CEh, 0C7h, 03h, 93h, 0CEh, 0D0h ; 38abe
	ASCII "z" ; 38ac6
	DB 1Bh ; 38ac7
	ASCIZ "2" ; 38ac8
	DB 0E6h, 05h, 0CFh, 0DBh, 0F1h, 03h, 93h, 93h ; 38aca
	DB 0BFh, 7Bh, 1Bh, 0ABh, 0AEh, 0F2h, 08h, 00h ; 38ad2
	DB 0B0h, 02h, 0CEh, 0D4h ; 38ada
	ASCII "z" ; 38ade
	DB 1Bh, 0F8h, 0B0h, 05h, 0CEh, 0D4h, 7Dh, 1Bh ; 38adf
	DB 0C4h ; 38ae7
	ASCII "G" ; 38ae8
	DB 8Ch, 0F2h, 0D0h, 0F7h ; 38ae9
	ASCII "8" ; 38aed
	DB 0CEh, 0D4h ; 38aee
	ASCII "w" ; 38af0
	DB 1Bh, 0CEh, 0D4h ; 38af1
	ASCII "v" ; 38af4
	DB 1Bh, 0CEh, 0D4h, 7Eh, 1Bh, 0F8h, 0CEh, 0D0h ; 38af5
	ASCII "w" ; 38afd
	DB 1Bh, 28h, 0E6h, 10h ; 38afe
	ASCII "2" ; 38b02
	DB 82h, 0E7h, 0Bh, 0B8h, 7Bh, 1Bh, 90h, 0BCh ; 38b03
	DB 7Bh, 1Bh, 0F2h, 0D2h, 0FFh, 0F8h, 0C5h ; 38b0b
	ASCII "v" ; 38b12
	DB 1Bh ; 38b13
	ASCII "E(" ; 38b14
	DB 0E6h, 0Dh, 8Eh, 0E6h, 0Ah, 0CEh, 0D0h ; 38b16
	ASCII "B" ; 38b1d
	DB 16h, 96h, 02h, 0E7h, 02h, 0F8h, 0A6h, 0A3h ; 38b1e
	DB 0BBh, 7Bh, 1Bh, 0CEh, 0C7h, 03h, 0BFh, 7Bh ; 38b26
	DB 1Bh ; 38b2e
	ASCII "G(" ; 38b2f
	DB 0E6h, 24h ; 38b31
	ASCII "2" ; 38b33
	DB 0FAh, 0E6h, 2Ah ; 38b34
	ASCII "2" ; 38b37
	DB 0FBh, 0E6h, 2Bh ; 38b38
	ASCII "2" ; 38b3b
	DB 0FDh, 0E6h ; 38b3c
	ASCII "A2" ; 38b3e
	DB 0FCh, 0E6h ; 38b40
	ASCII "A2" ; 38b42
	DB 0FEh, 0E7h ; 38b44
	ASCII "S" ; 38b46
	DB 0B0h, 00h, 0CEh ; 38b47
	ASCII "D" ; 38b4a
	DB 08h, 0CEh, 40h, 09h, 80h, 0CEh ; 38b4b
	ASCII "D" ; 38b51
	DB 09h, 93h, 0F1h, 0D7h, 0CEh, 40h, 08h, 80h ; 38b52
	DB 0CEh ; 38b5a
	ASCII "D" ; 38b5b
	DB 08h, 93h, 0F1h, 0CDh, 93h, 0CFh, 0DBh, 0F1h ; 38b5c
	DB 0C8h, 0B0h, 02h, 0CEh ; 38b64
	ASCII "D" ; 38b68
	DB 08h, 0B0h, 00h, 0CEh, 0D4h ; 38b69
	ASCII "z" ; 38b6e
	DB 1Bh, 0B0h, 03h, 0CEh ; 38b6f
	ASCII "D" ; 38b73
	DB 0Eh, 0C4h, 0Bh, 8Ch, 0F2h ; 38b74
	ASCII "B" ; 38b79
	DB 0F7h, 0B0h, 03h, 0F1h, 07h, 0B0h, 01h, 0F1h ; 38b7a
	DB 03h, 0B0h, 02h, 0CEh, 0D4h ; 38b82
	ASCII "w" ; 38b87
	DB 1Bh, 0CEh, 40h, 09h, 0CEh, 0D4h ; 38b88
	ASCII "t" ; 38b8e
	DB 1Bh, 0CEh, 40h, 08h, 0CEh, 0D4h ; 38b8f
	ASCII "u" ; 38b95
	DB 1Bh, 0F1h, 27h, 0CEh, 0D4h ; 38b96
	ASCII "y" ; 38b9b
	DB 1Bh, 0CEh, 40h, 08h, 80h, 0CEh ; 38b9c
	ASCII "D" ; 38ba2
	DB 08h, 0B0h, 00h, 0CEh ; 38ba3
	ASCII "D" ; 38ba7
	DB 0Eh, 0C4h, 23h, 8Ch, 0F2h, 0Eh, 0F7h, 93h ; 38ba8
	DB 0BFh, 7Bh, 1Bh, 0B0h, 09h, 0CEh, 0D4h ; 38bb0
	ASCII "v" ; 38bb7
	DB 1Bh, 0B0h, 01h, 0CEh, 0D4h ; 38bb8
	ASCII "x" ; 38bbd
	DB 1Bh, 0ABh, 0AEh, 0F8h, 0C5h, 7Eh, 1Bh ; 38bbe
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
	DB 00h, 0E6h, 06h, 0B5h, 0Eh, 91h, 0F5h, 0FCh ; 38d04
	DB 0CEh, 0D0h, 0DBh, 1Ah ; 38d0c
	ASCII "2" ; 38d10
	DB 08h, 0E4h, 03h, 0B0h, 08h, 96h, 01h, 0E6h ; 38d11
	DB 04h, 0B5h, 0Dh, 91h, 0B0h, 01h, 0D5h ; 38d19
	ASCII "O" ; 38d20
	DB 1Bh, 0E5h, 05h ; 38d21
	ASCII "h" ; 38d24
	DB 91h, 0F1h, 0F8h, 0B0h, 0Fh, 0CEh, 0D4h ; 38d25
	ASCII "O" ; 38d2c
	DB 1Bh, 0CEh, 0D0h, 0B5h, 1Ah, 28h, 0E6h, 07h ; 38d2d
	DB 0B0h, 10h, 0CEh, 0D4h ; 38d35
	ASCII "O" ; 38d39
	DB 1Bh, 0F8h, 0A6h, 0A2h, 0C6h, 0AAh, 15h, 0CEh ; 38d3a
	DB 0C6h, 00h, 0F2h, 0C0h, 0B9h, 0CEh, 0D0h, 0ADh ; 38d42
	DB 15h, 0F2h, 28h, 98h, 02h, 14h, 0CEh, 0D4h ; 38d4a
	ASCII "K" ; 38d52
	DB 1Bh ; 38d53
	ASCII "A" ; 38d54
	DB 02h, 14h, 0CEh, 0D4h ; 38d55
	ASCII "J" ; 38d59
	DB 1Bh, 0CEh, 0D0h, 0AEh, 15h, 0F2h, 14h, 98h ; 38d5a
	DB 02h, 14h, 0CEh, 0D4h ; 38d62
	ASCII "N" ; 38d66
	DB 1Bh ; 38d67
	ASCII "A" ; 38d68
	DB 02h, 14h, 0CEh, 0D4h ; 38d69
	ASCII "M" ; 38d6d
	DB 1Bh, 0B0h, 01h, 0CEh, 0D4h ; 38d6e
	ASCII "L" ; 38d73
	DB 1Bh, 0CEh, 0D0h ; 38d74
	ASCII "q" ; 38d77
	DB 16h, 22h, 10h, 0E6h, 07h, 0B0h, 1Eh, 0CEh ; 38d78
	DB 0D4h ; 38d80
	ASCII "L" ; 38d81
	DB 1Bh, 0AAh, 0AEh, 0F8h, 0B0h, 00h, 0CEh ; 38d82
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
	DB 06h, 0FAh, 0A6h, 0A3h, 0A2h, 0C6h, 0AAh, 15h ; 38dd1
	DB 0CEh, 0C6h, 00h, 0F2h, 28h, 0B9h, 0AAh, 0ABh ; 38dd9
	DB 0AEh, 0CEh, 0D0h, 0ADh, 15h ; 38de1
	ASCII "2" ; 38de6
	DB 06h, 0E4h, 05h ; 38de7
	ASCII "2" ; 38dea
	DB 12h, 0E4h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh ; 38deb
	DB 0F8h, 0EFh, 82h, 0EFh, 82h, 98h, 8Dh ; 38df3
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
	DB 8Eh, 0A6h, 0A3h, 0A2h, 0C6h, 0AAh, 15h, 0CEh ; 38e98
	DB 0C6h, 00h, 0F2h ; 38ea0
	ASCII "b" ; 38ea3
	DB 0B8h, 0AAh, 0ABh, 0AEh, 0CEh, 0D0h, 0ADh, 15h ; 38ea4
	ASCII "2" ; 38eac
	DB 06h, 0E4h, 05h ; 38ead
	ASCII "2" ; 38eb0
	DB 12h, 0E4h, 04h, 0C3h, 02h, 00h, 0CFh, 0DBh ; 38eb1
	DB 0F8h, 0A6h, 0A3h, 0CEh, 0D0h, 0D7h, 1Ah, 00h ; 38eb9
	DB 0B1h, 00h, 0C7h, 0D3h, 8Eh, 0CEh, 0C7h, 03h ; 38ec1
	DB 0CFh ; 38ec9
	ASCII "B" ; 38eca
	DB 0CFh, 0D8h, 0ABh, 0AEh, 0F2h, 0EBh, 0F3h, 0F8h ; 38ecb
	ASCII "C" ; 38ed3
	DB 8Eh, 5Dh, 8Eh ; 38ed4
	ASCII "w" ; 38ed7
	DB 8Eh, 0BAh, 8Eh, 0EFh, 82h, 0F0h, 82h, 0C5h ; 38ed8
	DB 81h, 1Bh, 0CEh, 0D0h ; 38ee0
	ASCII "B" ; 38ee4
	DB 16h, 96h, 04h, 0E6h, 1Eh, 86h ; 38ee5
	ASCII "E2H" ; 38eeb
	DB 0E4h, 27h, 0B5h, 00h, 0B0h, 01h, 0CEh, 0D4h ; 38eee
	DB 82h, 1Bh, 0CEh, 0D0h, 0B5h, 1Ah, 3Ah, 0FFh ; 38ef6
	DB 0CEh, 0D4h, 0B5h, 1Ah, 0F2h, 0C2h, 97h, 0F1h ; 38efe
	DB 10h, 0B5h, 00h, 0CEh, 0D0h ; 38f06
	ASCII "D" ; 38f0b
	DB 16h, 96h, 04h, 0E7h, 06h ; 38f0c
	ASCII "8" ; 38f11
	DB 0CEh, 0D4h, 82h, 1Bh, 0F8h, 02h, 04h, 04h ; 38f12
	DB 04h, 04h, 04h, 03h, 01h, 01h, 01h, 01h ; 38f1a
	DB 01h, 20h, 21h, 22h, 23h, 24h, 25h, 26h ; 38f22
	DB 27h, 28h, 29h, 2Ah, 2Bh ; 38f2a
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
	DB 1Bh, 5Fh, 82h, 0B4h, 93h, 0B0h, 00h, 0CEh ; 393b7
	ASCII "D" ; 393bf
	DB 0Eh, 0CEh, 0D0h, 0E9h, 1Ah, 0F2h, 11h, 90h ; 393c0
	DB 0CEh, 0D1h, 0EAh, 1Ah, 21h, 0E7h, 10h, 0C5h ; 393c8
	ASCII "E" ; 393d0
	DB 1Bh, 0B5h, 18h, 91h, 0B5h, 0B0h, 91h, 0B5h ; 393d1
	DB 0B1h, 91h, 0B5h, 18h, 0F8h, 0CEh, 0D0h, 0E9h ; 393d9
	DB 1Ah, 0CEh, 0C4h, 02h, 0F2h, 8Fh, 10h, 00h ; 393e1
	DB 00h, 02h, 0C0h, 0C5h ; 393e9
	ASCII "E" ; 393ed
	DB 1Bh, 0B1h, 04h ; 393ee
	ASCII "h" ; 393f1
	DB 91h, 80h, 0F5h, 0FCh, 0F8h, 0BCh, 93h, 0C1h ; 393f2
	DB 93h, 0B0h, 93h, 0B0h, 00h, 0CEh ; 393fa
	ASCII "D" ; 39400
	DB 0Eh, 0CEh, 0D0h, 2Ch, 1Bh, 0CEh, 0D1h, 97h ; 39401
	DB 1Bh, 0CEh, 0C4h, 03h, 0F2h, 0A0h, 0FBh, 0E7h ; 39409
	DB 10h, 0C5h ; 39411
	ASCII "E" ; 39413
	DB 1Bh, 0B5h, 18h, 91h, 0B5h, 0B0h, 91h, 0B5h ; 39414
	DB 0B1h, 91h, 0B5h, 18h, 0F8h, 0CEh, 0D0h, 97h ; 3941c
	DB 1Bh ; 39424
	ASCIZ "H" ; 39425
	DB 01h, 0F6h, 02h, 20h ; 39427
	ASCII "H" ; 3942b
	DB 0CEh, 0D0h, 2Ch, 1Bh, 00h, 00h, 01h, 0C5h ; 3942c
	ASCII "E" ; 39434
	DB 1Bh, 0B1h, 04h ; 39435
	ASCII "h" ; 39438
	DB 91h, 80h, 0F5h, 0FCh, 0F8h, 0FDh, 93h, 02h ; 39439
	DB 94h, 0B0h, 93h ; 39441
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
	DB 82h, 0CEh, 0D0h, 80h, 1Bh, 28h, 0E7h, 27h ; 394c3
	DB 0CEh, 0D0h ; 394cb
	ASCII "C" ; 394cd
	DB 16h, 96h, 7Bh, 0E6h, 1Fh, 0CEh, 0D0h, 0B6h ; 394ce
	DB 1Ah, 20h, 0E6h, 07h, 0B0h, 01h, 0CEh, 0D4h ; 394d6
	DB 0FAh, 14h, 0B0h, 01h, 0CEh, 0D4h, 80h, 1Bh ; 394de
	DB 0B0h, 03h, 0CEh ; 394e6
	ASCII "D" ; 394e9
	DB 0Eh, 0C4h, 0BAh, 94h, 0F2h, 0D8h, 0EDh, 0F8h ; 394ea
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
	DB 0Bh, 0F8h, 0F2h, 0D8h, 0FFh, 0A6h, 0BBh, 9Eh ; 3981c
	DB 1Bh, 0CEh, 40h, 0Eh, 0CEh, 0CFh ; 39824
	ASCII "G" ; 3982a
	DB 0AEh ; 3982b
	ASCII "2" ; 3982c
	DB 0F0h, 0E4h, 18h, 22h, 0Fh, 0CEh, 80h, 0B1h ; 3982d
	DB 00h, 0C7h ; 39835
	ASCII "2" ; 39837
	DB 99h, 0CFh ; 39838
	ASCII "B" ; 3983a
	DB 0CFh, 0D9h, 0F4h, 0B8h, 9Eh, 1Bh, 90h, 0BCh ; 3983b
	DB 9Eh, 1Bh, 0F1h, 0DBh, 0B8h, 9Eh, 1Bh, 0CEh ; 39843
	ASCII "D" ; 3984b
	DB 0Ch, 0CEh ; 3984c
	ASCII "L" ; 3984e
	DB 0Dh, 90h, 0BCh, 9Eh, 1Bh, 0B0h, 01h, 0CEh ; 3984f
	ASCII "D" ; 39857
	DB 0Ah, 0CEh ; 39858
	ASCII "D" ; 3985a
	DB 0Bh, 0B8h, 9Ch, 1Bh, 0CEh ; 3985b
	ASCII "D" ; 39860
	DB 08h, 0CEh ; 39861
	ASCII "L" ; 39863
	DB 09h, 80h, 0BCh, 9Ch, 1Bh, 0F8h, 0F3h, 0D2h ; 39864
	DB 0FFh, 0B8h, 9Eh, 1Bh, 0BCh, 0A1h, 1Bh, 0CEh ; 3986c
	DB 40h, 0Eh, 0CEh, 0D4h, 0A3h, 1Bh, 0C4h, 0ACh ; 39874
	DB 1Bh, 0BCh, 9Eh, 1Bh, 0B0h, 00h, 0CEh ; 3987c
	ASCII "D" ; 39883
	DB 0Eh, 0CEh, 0C4h, 03h, 0F2h, 2Ah ; 39884
	ASCII "O" ; 3988a
	DB 0F3h, 0BAh, 0FFh, 0B8h, 9Eh, 1Bh, 0BCh, 0A1h ; 3988b
	DB 1Bh, 0CEh, 40h, 0Eh, 0CEh, 0D4h, 0A3h, 1Bh ; 39893
	DB 0CEh, 0D0h, 0B2h, 1Bh ; 3989b
	ASCII "2" ; 3989f
	DB 01h, 0E6h, 08h ; 398a0
	ASCII "2" ; 398a3
	DB 02h, 0E6h, 0Dh, 0F3h, 9Eh, 0FFh, 0C4h, 3Fh ; 398a4
	DB 0A5h, 0BCh, 9Eh, 1Bh, 0F3h, 95h, 0FFh, 0C4h ; 398ac
	ASCII "B" ; 398b4
	DB 0A5h, 0BCh, 9Eh, 1Bh, 0F3h, 8Ch, 0FFh, 0B8h ; 398b5
	DB 9Eh, 1Bh, 0BCh, 0A1h, 1Bh, 0CEh, 40h, 0Eh ; 398bd
	DB 0CEh, 0D4h, 0A3h, 1Bh, 0CEh, 0D0h, 0D7h, 1Ah ; 398c5
	DB 0B1h, 00h, 0CEh, 80h, 0C7h, 0DEh, 98h, 0CFh ; 398cd
	ASCII "B" ; 398d5
	DB 0CFh, 0D8h, 0BCh, 9Eh, 1Bh, 0F3h ; 398d6
	ASCII "j" ; 398dc
	DB 0FFh ; 398dd
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
	DB 0FFh, 0CEh, 0D0h, 9Ah, 1Bh, 0CEh, 0D4h, 9Ch ; 398f6
	DB 1Bh, 0CEh, 0D0h, 9Dh, 1Bh, 80h ; 398fe
	ASCII "5" ; 39904
	DB 99h, 1Bh, 0E7h, 05h, 0CEh, 0D0h, 9Bh, 1Bh ; 39905
	DB 0CEh, 0D4h, 9Dh, 1Bh, 0F3h, 2Bh, 0FFh, 0C4h ; 3990d
	DB 0EFh, 82h, 0CEh ; 39915
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
