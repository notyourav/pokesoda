minlib_notelen_lookup:
	DB 01h, 02h, 04h, 06h, 08h, 0Ch, 10h, 18h ; 61c2
	DB 20h, 01h, 03h, 06h, 09h, 0Ch, 12h, 18h ; 61ca
	DB 24h ; 61d2
	ASCII "0" ; 61d3
	DB 02h, 04h, 08h, 0Ch, 10h, 18h, 20h ; 61d4
	ASCII "0@" ; 61db
	DB 03h, 06h, 0Ch, 12h, 18h, 24h ; 61dd
	ASCII "0H`" ; 61e3
	DB 04h, 08h, 10h, 18h, 20h ; 61e6
	ASCII "0@`" ; 61eb
	DB 80h, 05h, 0Ah, 14h, 1Eh, 28h, 3Ch ; 61ee
	ASCII "Px" ; 61f5
	DB 0A0h
    
minlib_waveform_lookup:
    DB 02h, 04h, 08h, 10h

minlib_unknown_lookup_3:
    DB 01h, 02h, 03h, 04h, 05h, 06h, 07h, 08h
	DB 09h, 0Ah, 0Bh, 0Ch, 0Dh, 0Eh, 0Fh
	
VIBRATO_TABLE:
	DB 08h, 04h, 01h, 03h ; 620b
	DB 04h, 01h, 03h, 04h, 03h, 03h, 01h, 03h ; 620f
	DB 08h, 04h, 01h, 00h, 00h, 40h, 00h, 0FFh ; 6217
	DB 60h, 00h, 0FFh, 10h, 00h, 00h, 00h, 04h ; 621f
	DB 0FFh, 07h, 20h, 00h, 18h
minlib_frequency_table:
    DB 00h
	ASCII "x`q" ; 622d
	DB 0E0h ; 6230
	ASCIZ "j" ; 6231
	ASCIZ "e@_" ; 6233
	ASCII "Z" ; 6237
	DB 0E0h ; 6238
	ASCIZ "T" ; 6239
	ASCII "P" ; 623b
	DB 0C0h ; 623c
	ASCIZ "K`G" ; 623d
	ASCII "C" ; 6241
	DB 0C0h, 3Eh, 00h, 3Ch, 0B0h ; 6242
	ASCII "8p5" ; 6247
	DB 80h ; 624a
	ASCII "2" ; 624b
	DB 0A0h, 2Fh, 00h, 2Dh ; 624c
	ASCIZ "p*" ; 6250
	DB 28h, 0E0h, 25h, 0B0h, 23h, 80h, 21h, 60h ; 6253
	DB 1Fh, 00h, 1Eh ; 625b
	ASCII "X" ; 625e
	DB 1Ch, 0B8h, 1Ah, 40h, 19h, 0D0h, 17h, 80h ; 625f
	DB 16h ; 6267
	ASCII "8" ; 6268
	DB 15h, 00h, 14h, 0F0h, 12h, 0D8h, 11h, 0C0h ; 6269
	DB 10h, 0B0h, 0Fh, 00h, 0Fh, 2Ch, 0Eh, 5Ch ; 6271
	DB 0Dh, 0A0h, 0Ch, 0E8h, 0Bh, 40h, 0Bh, 9Ch ; 6279
	DB 0Ah, 00h, 0Ah ; 6281
	ASCII "x" ; 6284
	DB 09h, 0ECh, 08h, 60h, 08h, 0D8h, 07h, 80h ; 6285
	DB 07h, 16h, 07h, 0AEh, 06h ; 628d
	ASCII "P" ; 6292
	DB 06h, 0F4h, 05h, 0A0h, 05h ; 6293
	ASCII "N" ; 6298
	DB 05h, 00h, 05h, 0BCh, 04h ; 6299
	ASCII "v" ; 629e
	DB 04h ; 629f
	ASCII "0" ; 62a0
	DB 04h, 0ECh, 03h, 0C0h, 03h, 8Bh, 03h ; 62a1
	ASCII "W" ; 62a8
	DB 03h, 28h, 03h, 0FAh, 02h, 0D0h, 02h, 0A7h ; 62a9
	DB 02h, 80h, 02h, 5Eh, 02h, 3Bh, 02h, 18h ; 62b1
	DB 02h, 0F6h, 01h, 0E0h, 01h, 00h, 00h ; 62b9
    
    include "src/audio/bgmtable.asm"
    
    include "src/audio/bgm.asm"