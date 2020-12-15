INCLUDE "global.inc"

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

global eeprom_buffer ; 150D
eeprom_buffer: DS 12h

global filler151F ; 151F
filler151F: DS 5B8h

; 1641: keys 2 frames ago
; 1642: keys 1 frame ago
; 1643: new unpressed last frame
; 1644: new pressed last frame
; 1645: dup of 1643?

; 1AB6: SFX volume
; 1AB7: BGM volume
; 1AB8: rumble motor on

global pet_breed ; 1AD7
pet_breed: DS 1

global stage_inside ; 1AD8
stage_inside: DS 1

global stage_lightoff ; 1AD9
filler1AD9: DS 1

global pet_energy ; 1ADA
pet_energy: DS 1

global pet_hunger ; 1ADB
pet_hunger: DS 1

global pet_mood ; 1ADC
pet_mood: DS 1

global pet_love ; 1ADD
pet_love: DS 1

global pet_love_frac ; 1ADE
pet_love_frac: DS 1

global pet_strength ; 1ADF
unk1ADF: DS 1

global pet_strength_frac ; 1AE0
pet_intellect: DS 1

global pet_intellect ; 1AE1
pet_intellect_frac: DS 1

global pet_intellect_frac ; 1AE2
unk1AE2: DS 1

global pet_beauty ; 1AE3
pet_beauty: DS 1

global pet_beauty_frac ; 1AE4
pet_beauty_frac: DS 1

global filler1AE5 ; 1AE5
filler1AE5: DS 2Dh

; 1B0F: brightness level

global pet_x ; 1B12
pet_x: DS 1

global pet_y ; 1B13
pet_y: DS 1

global pet_close ; 1B14
pet_close: DS 1

global pet_close_act ; 1B15
pet_close_act: DS 1

global filler1B14 ; 1B16
filler1B14: DS 13

global stage_height ; 1B23
stage_height: DS 1

global filler1B24 ; 1B24
filler1B24: DS 6

global pet_visitation ; 1B2A
pet_visitation: DS 1

global pet_threaten ; 1B2B
pet_threaten: DS 1