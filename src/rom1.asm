INCLUDE "global.inc"

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
global loc_0x009A10
loc_0x009A10:
	DB 0A6h, 0A3h, 0CEh ; 9a0b
	DB 0D2h, 0DFh, 1Ah, 0C7h, 1Fh, 9Ah, 0CEh, 0C7h ; 9a13
	DB 00h, 0F3h, 0C2h, 00h ; 9a1b
	ASCII "F<2" ; 9a1f
global loc_0x009A22
loc_0x009A22:
	DB 0A6h, 0A3h, 0CEh, 0D2h, 0E1h, 1Ah, 0C7h ; 9a22
	ASCII "1" ; 9a29
	DB 9Ah, 0CEh, 0C7h, 00h, 0F3h, 0B0h, 00h ; 9a2a
	ASCII "F<2" ; 9a31

; ---------------------- ; 9a31
global loc_0x009A34
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
global loc_0x009A46
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
global loc_0x009A58
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
global loc_0x009A69
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
global loc_0x009A7A
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
global loc_0x009A8B
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
global loc_0x009ACF
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
global loc_0x009B56
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
global loc_0x009B8D
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
global loc_0x009C80
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
global loc_0x00AA46
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
global loc_0x00AA55
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
global loc_0x00AC56
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
global loc_0x00C0E9
loc_0x00C0E9:
	LD A,#02h ; 0c0e9
	LD [1B1Dh],A ; 0c0eb
	RET
; ---------------------- ; 0c0ef
global loc_0x00C0F0
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