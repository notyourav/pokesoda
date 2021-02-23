; GLOBAL DEFINITIONS

NULL equ 0

REG_BASE        equ 2000h

SYS_CTRL1       equ 00h
SYS_CTRL2       equ 01h
SYS_CTRL3       equ 02h

SEC_CTRL        equ 08h
SEC_CNT_LO      equ 09h
SEC_CNT_MID     equ 0Ah
SEC_CNT_HI      equ 0Bh

SYS_BATT        equ 10h

TMR1_SCALE      equ 18h
TMR1_OSC        equ 19h
TMR2_SCALE      equ 1Ah
TMR2_OSC        equ 1Bh
TMR3_SCALE      equ 1Ch
TMR3_OSC        equ 1Dh

IRQ_PRI1        equ 20h
IRQ_PRI2        equ 21h
IRQ_PRI3        equ 22h

IRQ_ENA1        equ 23h
IRQ_ENA2        equ 24h
IRQ_ENA3        equ 25h
IRQ_ENA4        equ 26h

IRQ_ACT1        equ 27h
IRQ_ACT2        equ 28h
IRQ_ACT3        equ 29h
IRQ_ACT4        equ 2Ah

TMR1_CTRL_L     equ 30h
TMR1_CTRL_H     equ 31h
TMR1_PRE_L      equ 32h
TMR1_PRE_H      equ 33h
TMR1_PVT_L      equ 34h
TMR1_PVT_H      equ 35h
TMR1_CNT_L      equ 36h
TMR1_CNT_H      equ 37h

TMR2_CTRL_L     equ 38h
TMR2_CTRL_H     equ 39h
TMR2_PRE_L      equ 3Ah
TMR2_PRE_H      equ 3Bh
TMR2_PVT_L      equ 3Ch
TMR2_PVT_H      equ 3Dh
TMR2_CNT_L      equ 3Eh
TMR2_CNT_H      equ 3Fh

TMR256_CTRL     equ 40h
TMR256_CNT      equ 41h

TMR3_CTRL_L     equ 48h
TMR3_CTRL_H     equ 49h
TMR3_PRE_L      equ 4Ah
TMR3_PRE_H      equ 4Bh
TMR3_PVT_L      equ 4Ch
TMR3_PVT_H      equ 4Dh
TMR3_CNT_L      equ 4Eh
TMR3_CNT_H      equ 4Fh

KEY_PAD         equ 52h
CART_BUS        equ 53h

IO_DIR          equ 60h
IO_DATA         equ 61h

AUD_CTRL        equ 70h
AUD_VOL         equ 71h

PRC_MODE        equ 80h
PRC_RATE        equ 81h

PRC_MAP_LO      equ 82h
PRC_MAP_MID     equ 83h
PRC_MAP_HI      equ 84h

PRC_SCROLL_Y    equ 85h
PRC_SCROLL_X    equ 86h

PRC_SPR_LO      equ 87h
PRC_SPR_MID     equ 88h
PRC_SPR_HI      equ 89h

PRC_CNT         equ 8Ah

LCD_CTRL        equ 0FEh
LCD_DATA        equ 0FFh

; SYS_CTRL flags

LCD_IO_ENA      equ 01h
CART_IO_ENA     equ 02h

PWR_ON_RESET    equ 10h
ENA_CART_INT    equ 20h
INT_ABORT       equ 40h
RAM_VECT        equ 80h

RTC_VALID       equ 02h
SUSPEND_MODE    equ 20h
CART_PWR_REQD   equ 40h
CART_PWR_STATE  equ 80h

; Interrupt flags

IRQ1_PRC_COMPLETE   equ 80h
IRQ1_DIV_OVF        equ 40h
IRQ1_TIM2_HI_UF     equ 20h
IRQ1_TIM2_LO_UF     equ 10h
IRQ1_TIM1_HI_UF     equ 08h
IRQ1_TIM1_LO_UF     equ 04h
IRQ1_TIM3_HI_UF     equ 02h
IRQ1_TIM3_PIVOT     equ 01h

IRQ2_32HZ           equ 20h
IRQ2_8HZ            equ 10h
IRQ2_2HZ            equ 08h
IRQ2_1HZ            equ 04h
IRQ2_CART_EJECT     equ 02h
IRQ2_CART           equ 01h

IRQ3_KEYPOWER       equ 80h
IRQ3_KEYRIGHT       equ 40h
IRQ3_KEYLEFT        equ 20h
IRQ3_KEYDOWN        equ 10h
IRQ3_KEYUP          equ 08h
IRQ3_KEYC           equ 04h
IRQ3_KEYB           equ 02h
IRQ3_KEYA           equ 01h

IRQ4_IR_RECV        equ 80h
IRQ4_SHOCK          equ 40h

; System status flags

SC_Z    EQU 1
SC_C    EQU 2
SC_V    EQU 4
SC_N    EQU 8
SC_D    EQU 16
SC_U    EQU 32
SC_I0   EQU 64
SC_I1   EQU 128

OFF_Z   EQU 0FFh^1
OFF_C   EQU 0FFh^2
OFF_V   EQU 0FFh^4
OFF_N   EQU 0FFh^8
OFF_D   EQU 0FFh^16
OFF_U   EQU 0FFh^32
OFF_I0  EQU 0FFh^64
OFF_I1  EQU 0FFh^128

; Hardware Register Flags

PRC_MODE_INVERT equ 0h
PRC_MODE_COPY equ 8h

; Key flags

KEY_A       EQU 1
KEY_B       EQU 2
KEY_C       EQU 4
KEY_UP      EQU 8
KEY_DOWN    EQU 16
KEY_LEFT    EQU 32
KEY_RIGHT   EQU 64
KEY_POWER   EQU 128

; IO flags

IR_RX       EQU 1
IR_TX       EQU 2
EEPROM_DATA EQU 4
EEPROM_CLK  EQU 8
RUMBLE      EQU 16
IR_DIS      EQU 32
PULLUP      EQU 64
IR_TX_2     EQU 128

; Timer flags

TMR_RESET   equ 02h
TMR_ENABLE  equ 04h
TMR_16BIT   equ 80h

; Macros

assert MACRO condition
    IF condition == 0
        FAIL 'ASSERTION FAILED'
    ENDIF
ENDM

farcall MACRO function
    LD NB, #@CPAG(function)
    CARL function
ENDM

farjump MACRO line
    LD NB, #@CPAG(line)
    JRL line
ENDM

farload MACRO reg, address
    IF @SCP("reg", 'CODE') || @SCP("reg", 'code')
        LD HL, #@COFF(address)
        LD B, #@CPAG(address)
    ELSE
        IF @SCP("reg",'HL') || @SCP("reg",'hl')
            LD HL, #@DOFF(address)
            LD EP, #@DPAG(address)
        ELSE
            LD I\reg, #@DOFF(address)
            LD reg\P, #@DPAG(address)
        ENDIF
    ENDIF
ENDM

bgstruct MACRO _166b, prc_rate, _162b,          \
               tilemap0, tilemap1, pet0, pet1,  \
               _proc0, _proc1, _proc2, _proc3,  \
               _1647, _1648, bgm, _func, _addr, \
               _2cc2, _unk
    DB _166b, prc_rate, _162b
    DW @DOFF(tilemap0)
    DB @DPAG(tilemap0)
    DW @DOFF(tilemap1)
    DB @DPAG(tilemap1)
    DW @DOFF(pet0)
    DB @DPAG(pet0)
    DW @DOFF(pet1)
    DB @DPAG(pet1)
    DW @COFF(_proc0)
    DB @CPAG(_proc0)
    DW @COFF(_proc1)
    DB @CPAG(_proc1)
    DW @COFF(_proc2)
    DB @CPAG(_proc2)
    DW @COFF(_proc3)
    DB @CPAG(_proc3)
    DB _1647, _1648, bgm
    DW @COFF(_func)
    DB @CPAG(_func)
    DW @DOFF(_addr)
    DB @DPAG(_addr)
    DB _2cc2
    DB _unk
ENDM
