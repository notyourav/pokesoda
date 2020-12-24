INCLUDE "global.inc"
INCLUDE "engine_constants.inc"

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

global mn_bgm_index
mn_bgm_index: DS 2

global mn_notelen
mn_notelen: DS 1

global mn_effect
mn_effect: DS 1

global u8_14e4
u8_14e4: DS 1

global mn_multiplier
mn_multiplier: DS 1

global mn_waveform
mn_waveform: DS 1

global u8_14e7
u8_14e7: DS 1

global mn_notelen_counter
mn_notelen_counter: DS 1

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

global mn_pending_bgm ; 14f4
mn_pending_bgm: DS 1

global mn_current_bgm ; 14f5
mn_current_bgm: DS 1

global mn_loop_begin ; 14f6
mn_loop_begin: DS 2

global u16_14f8
u16_14f8: DS 2

global mn_pending_sfx ; 14fa
mn_pending_sfx: DS 1

global mn_current_sfx ; 14fb
mn_current_sfx: DS 1

global u8_14fc
u8_14fc: DS 1

global mn_sfx_index
mn_sfx_index: DS 2

global u16_14ff
u16_14ff: DS 2

global u16_1501
u16_1501: DS 2

global mn_sfx_page
mn_sfx_page: DS 1

global mn_bgm_table_page
mn_bgm_table_page: DS 1

global mn_sfx_table_page
mn_sfx_table_page: DS 1

global u8_1506
u8_1506: DS 1

global mn_bgm_vol
mn_bgm_vol: DS 1

global mn_sfx_vol
mn_sfx_vol: DS 1

global mn_bgm_tmp
mn_bgm_tmp: DS 1

global u8_150a
u8_150a: DS 1

global u8_150b
u8_150b: DS 1

global u8_150c
u8_150c: DS 1

global eeprom_buffer ; 150D
eeprom_buffer: DS 12h

global filler151F ; 151F
filler151F: DS 122h

; 162C: tilemap frame 1 offset
; 162E: tilemap frame 1 page
; 162F: tilemap frame 2 offset
; 1631: tilemap frame 2 page

; two frames ago
global keys_old2 ; 1641
keys_old2: DS 1

global keys_old ; 1642
keys_old: DS 1

global keys_new_unpressed ; 1643
keys_new_unpressed: DS 1

global keys_new_pressed ; 1644
keys_new_pressed: DS 1

; dup of keys_new_unpressed?
global unk1645 ; 1645
unk1645: DS 1

global filler1646 ; 1646
filler1646: DS 49h

global entities ; 168F
entities: DS 20 * MAX_SPRITES

global filler181F ; 181F
filler1A8F: DS 297h

global sfx_vol ; 1AB6
sfx_vol: DS 1

global bgm_vol ; 1AB7
bgm_vol: DS 1

global rumble_on ; 1AB8
rumble_on: DS 1

global filler1AB9 ; 1AB9
filler1AB9: DS 1Eh

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