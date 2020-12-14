DEFSECT ".vram", DATA AT 1000H
SECT ".vram"

global screenbuf
screenbuf: DS 300h

global sprite_oam
sprite_oam: DS 60h

global tilemap
tilemap: DS 0C0h

DEFSECT ".wram", DATA AT 14E0H
SECT ".wram"

global bgm_index
bgm_index: DS 2

global notelen
notelen: DS 1

global effect
effect: DS 1

global u8_14e4
u8_14e4: DS 1

global multiplier
multiplier: DS 1

global waveform
waveform: DS 1

global u8_14e7
u8_14e7: DS 1

global notelen_counter
notelen_counter: DS 1

global u8_14e9
u8_14e9: DS 1

global u8_14ea
u8_14ea: DS 1

global u8_14eb
u8_14eb: DS 1

global u8_14ec
u8_14ec: DS 1

global u8_14ed
u8_14ed: DS 1

global u8_14ee
u8_14ee: DS 1

global u8_14ef
u8_14ef: DS 1

global u8_14f0
u8_14f0: DS 1

global u8_14f1
u8_14f1: DS 1

global u8_14f2
u8_14f2: DS 1

global u8_14f3
u8_14f3: DS 1

global pending_bgm
pending_bgm: DS 1

global current_bgm
current_bgm: DS 1

global loop_begin
loop_begin: DS 2

global u16_14f8
u16_14f8: DS 2

global pending_sfx
pending_sfx: DS 1

global current_sfx
current_sfx: DS 1

global u8_14fc
u8_14fc: DS 1

global sfx_index
sfx_index: DS 2

global u16_14ff
u16_14ff: DS 2

global u16_1501
u16_1501: DS 2

global sfx_page
sfx_page: DS 1

global bgm_table_page
bgm_table_page: DS 1

global sfx_table_page
sfx_table_page: DS 1

global u8_1506
u8_1506: DS 1

global bgm_vol
bgm_vol: DS 1

global sfx_vol
sfx_vol: DS 1

global bgm_tmp
bgm_tmp: DS 1

global u8_150a
u8_150a: DS 1

global u8_150b
u8_150b: DS 1

global u8_150c
u8_150c: DS 1

global eeprom_buffer
eeprom_buffer: DS 12h
