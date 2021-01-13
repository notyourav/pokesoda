
ENT_0 equ 0h
ENT_1 equ 1h

ENT_NEXT_STATE_LO equ 2h
ENT_NEXT_STATE_HI equ 3h

ENT_4 equ 4h ; offset
ENT_5 equ 5h
ENT_6 equ 6h ; page

ENT_7 equ 7h
ENT_8 equ 8h
ENT_9 equ 9h

ENT_X equ 0Ah

ENT_B equ 0Bh
ENT_C equ 0Ch
ENT_D equ 0Dh

ENT_Y equ 0Eh

ENT_F equ 0Fh
ENT_10 equ 10h
ENT_11 equ 11h
ENT_12 equ 12h
ENT_13 equ 13h

ENT_CUR_STATE_LO equ 14h
ENT_CUR_STATE_HI equ 15h

ENT_16 equ 16h
ENT_17 equ 17h
ENT_18 equ 18h
ENT_19 equ 19h
ENT_1A equ 1Ah
ENT_1B equ 1Bh
ENT_1C equ 1Ch
ENT_1D equ 1Dh

ENT_STATE_PAGE equ 1Eh

ENT_1F equ 1Fh

;;;;; 168F 
; sprite state: sizeof(20h)
;   IX+2h: next state
;   IX+3h: next state
;   IX+Ah: X
;   IX+Eh: Y
;   IX+14h: cur state
;   IX+15h: cur state
;   IX+1Eh: state page