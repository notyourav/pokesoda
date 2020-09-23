INCLUDE 'k_348ior.inc'
INCLUDE 's_system.inc'

otrflag_keyprss EQU 1
key_shift       EQU 2
otrflag_roll    EQU 2
otrflag_rollup  EQU 4
INTP_K0007  EQU 0c0h
INTP_CLOCK  EQU 02h
INTP_K1011  EQU 03h

key_a   EQU     030h
chr_a   EQU     000h
key_b   EQU     034h
chr_b   EQU     001h
key_c   EQU     042h
chr_c   EQU     002h
key_d   EQU     032h
chr_d   EQU     003h
key_e   EQU     022h
chr_e   EQU     004h
key_f   EQU     023h
chr_f   EQU     005h
key_g   EQU     024h
chr_g   EQU     006h
key_h   EQU     025h
chr_h   EQU     010h
key_i   EQU     027h
chr_i   EQU     011h
key_j   EQU     026h
chr_j   EQU     012h
key_k   EQU     037h
chr_k   EQU     013h
key_l   EQU     028h
chr_l   EQU     014h
key_m   EQU     036h
chr_m   EQU     015h
key_n   EQU     035h
chr_n   EQU     016h
key_o   EQU     018h
chr_o   EQU     020h
key_p   EQU     029h
chr_p   EQU     021h
key_q   EQU     020h
chr_q   EQU     022h
key_r   EQU     013h
chr_r   EQU     023h
key_s   EQU     031h
chr_s   EQU     024h
key_t   EQU     014h
chr_t   EQU     025h
key_u   EQU     016h
chr_u   EQU     026h
key_v   EQU     033h
chr_v   EQU     030h
key_w   EQU     021h
chr_w   EQU     031h
key_x   EQU     041h
chr_x   EQU     032h
key_y   EQU     015h
chr_y   EQU     033h
key_z   EQU     040h
chr_z   EQU     034h
;--------------  OSC waiting time to stable -------------------------------
OSCWAIT_CRY EQU 15                  ; crystal 15msec
OSCWAIT_CER EQU 5                   ; ceramic  5msec

;=============================================================================
; MCU internal VRAM
;=============================================================================
McuVramSttAd    EQU 0f800h              ; start address
McuVramXmax     EQU 32h                 ; x axis size
McuVramYstep    EQU 100h                ; y axis address step per 8 dots
EXTERN __lc_es

DEFSECT ".vecter",CODE AT 0000h
SECT    ".vecter"
 
;------------------  GENERAL INTERRUPT  ---------------------------------------
    DW  __START         ; 0000h reset
    DW  int_dummy       ; 0002h divided by zero
    DW  int_dummy       ; 0004h watch dog timer(nmi)

;------------------  timer interrupt  -----------------------------------------
    DW  int_roll        ; 0006h timer 1
    DW  int_dummy       ; 0008h timer 0

;------------------  input port interrupt  ------------------------------------
    DW  int_kscn_frst   ; 000ah k10,11 port input
    DW  int_kscn_frst   ; 000ch k04 - 07 port input
    DW  int_kscn_frst   ; 000eh k00 - 03 port input

;------------------  serial interfaces  ---------------------------------------
    DW  int_dummy       ; 0010h serial i/f - receive error
    DW  int_dummy       ; 0012h serial i/f - receive completion
    DW  int_dummy       ; 0014h serial i/f - send completion

;------------------  stop watch  ----------------------------------------------
    DW  int_dummy       ; 0016h stop watch 100hz
    DW  int_dummy       ; 0018h stop watch  10hz
    DW  int_dummy       ; 001ah stop watch   1hz

;------------------  watch  ---------------------------------------------------
    DW  int_keyscan     ; 001ch watch 32hz
    DW  int_dummy       ; 001eh watch  8hz
    DW  int_dummy       ; 0020h watch  2hz
    DW  int_dummy       ; 0022h watch  1hz


DEFSECT ".program",CODE AT 0100h
SECT    ".program"

;##############################################################################
; Main routine
;   input     : none
;   output    : none
;   destroyed : none
;##############################################################################
GLOBAL __START
__START:
    ;==========================================================================
    ;===================  system initialization  ==============================
    ;==========================================================================

    LD  SP,#@DOFF(__lc_es)      ; stack pointer initialize
    LD  BR,#0FFh                ; BR register initialize to I/O area
    ;###### BR register should be fixed at '0FFh' ##########

    ;---------------  bus mode setting  ---------------------------------------
    ; MCU & MPU mode
    LD  [BR:BSMDn_IOR],#0       ; single chip mode

    ;---------------  stack pointer page address  -----------------------------
    LD  [BR:SPPn_IOR],#@DPAG(__lc_es-1)       ; set stack pointer page

    ;----------------------  set I/O register  --------------------------------
    ;<display>
    M_IO_BCLR   DTFNT_IOR,DTFNT_BIT     ; 5 x 8 dot font
    M_IO_BCLR   LDUTY_IOR,LDUTY_BIT     ; 1/32 duty
    M_IO_BCLR   LCDCn_IOR,LCDC1_BIT     ; drive on
    M_IO_BSET   LCDCn_IOR,LCDC0_BIT
    M_IO_BSET   LCn_IOR,LC3_BIT|LC2_BIT|LC1_BIT|LC0_BIT ; initial contrast = 15

    ;<keyboard>
    CARL    _k_kscn_init

    ;<clock timer>
    M_IO_BSET   TMRUN_IOR,TMRUN_BIT 
    ld  [br:30h],#00010001b
    or  [br:21h],#00001100b ;timer:irq3
    ld  [br:33h],#00h
    ld  [br:34h],#8h
    ld      [br:31h],#00011110b 

    ;-------------------  clear MCU Vram  -------------------------------------
    CARL    _clear_vram

    ;------------------- initialize data --------------------------------------
    LD  HL,#_data_begin             ; start address

    RAMCLR:                     ; do {
        LD  [HL],#0                 ; clear data
        INC HL                  ; address++
        CP  HL,#_data_end
        JRS C,RAMCLR            ; }

    ;<all interrupt enable>
    AND SC,#00111111b               ; all interrupt enable

    CARL    _disp_all

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%         Main Loop      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MainLoop:
    ;<reset WDT>
    OR  [BR:WDRST_IOR],#WDRST_BIT

    M_BIT   _otrflag,otrflag_keyprss,HL
    JRS NZ,MAINLP10

    ;<Halt>
    HALT

    ;------------------ check int ----------------------------------------------
MAINLP10:
    M_BIT   _otrflag,otrflag_keyprss,HL
    JRS Z,MainLoop

    M_BCLR  _otrflag,otrflag_keyprss,HL
    LD  HL,#_key_position
    CP  [HL],#key_shift
    JRS NZ,MAINLP20         ; if (key_shift){
        M_BIT   _otrflag,otrflag_roll,HL    ; if (!otrflag_roll)
        JRS NZ,MainLoop
            M_BREV  _otrflag,otrflag_rollup,HL  ; reverse otrflag_rollup
    JRS MainLoop            ; }
MAINLP20:                       ; else if (char key){
    LD  A,[HL]
    LD  HL,#ChrPosTbl
    LD  B,#26
MAINLP30:
    CP  [HL],A
    JRS Z,MAINLP40
        ADD HL,#2 
        DJR NZ,MAINLP30
    JRS MainLoop
MAINLP40:
    INC HL
    LD  A,[HL]  
    M_BIT   _otrflag,otrflag_roll,HL
    JRS NZ,MAINLP50
        M_BSET  _otrflag,otrflag_roll,HL
        CARL    _k_osc_1to3
        LD  HL,#_chr_buf
        LD  [HL],A
        INC HL
        LD  [HL],#0
        LD  HL,#_end_buf
        LD  [HL],#1
        M_IO_BSET   EPT1_IOR,EPT1_BIT
            or      [br:31h],#00000001b
    JRS MainLoop
MAINLP50:   
    LD  HL,#_end_buf
    LD  B,[HL]
    LD  HL,#_chr_buf
    MAINLP51:
        CP  [HL],A
        JRS Z,MAINLP60
        ADD HL,#2
        DJR NZ,MAINLP51
    LD  [HL],A
    INC HL
    LD  [HL],#0
    LD  HL,#_end_buf 
    INC [HL]
    JRL MainLoop
MAINLP60:               ; if re-press
    INC HL
    LD  [HL],#0

    PUSH    A
    UPCK
    LD  L,#6
    MLT
    LD  A,L
    LD  IX,#0F800h
    ADD IX,BA           ; char pos
    ADD IX,#4
    
    POP A
    SWAP    A 
    UPCK
    LD  L,#7
    MLT
    LD  A,L
    ADD A,B
    LD  L,#6
    MLT
    LD  A,L
    LD  B,#0
    LD  HL,#ChrTbl
    ADD HL,BA           ; char dot

    LD  B,#6
MAINLP70:
    LD  [IX],[HL]
    INC IX
    INC HL
    DJR NZ,MAINLP70
    JRL MainLoop    

;##############################################################################
;<interrupt> k port,    first key scan
;##############################################################################
int_kscn_frst:

;-------------------  save register data  -------------------------------------
    PUSH    BA
    PUSH    HL

;------------------  reset interrupt flag  ------------------------------------
    M_IO_BCLR   EK1_IOR,EK1_BIT|EK0H_BIT|EK0L_BIT   ; disenable k port int

;------------------  all off  -------------------------------------------------
    M_IO_BSET   P1nD_IOR,P17D_BIT|P16D_BIT|P15D_BIT     ; P15,16,17 output -> H
    M_IO_BSET   R2nD_IOR,R27D_BIT       ; R27 output -> H
    M_IO_BSET   R3nD_IOR,R34D_BIT       ; R34 output -> H

;-------------------  out0 setting  -------------------------------------------
    M_IO_BCLR   P1nD_IOR,P15D_BIT           ; R0 P15 output -> L (active)

;-------------------  read out0 input  ----------------------------------------
    NOP
    NOP
    LD  A,[BR:K0nD_IOR]                 ; K00-K07 input
    LD  B,[BR:K1nD_IOR]                 ; K10,K11 input

;-------------------  out1 setting  -------------------------------------------
    M_IO_BSET   P1nD_IOR,P15D_BIT       ; R0 P15 output -> H
    M_IO_BCLR   P1nD_IOR,P16D_BIT       ; R1 P16 output -> L (active)

;-------------------  out0 input check  ---------------------------------------
    CP  BA,#03FFh
    JRS Z,FSTKSCN010                    ; if (anyone is L){
        CARL    _fst_kscn_inp               ; column check sub routine
        LD  B,#0                            ; row position
        JRS FSTKSCN_OK                      ; goto valid scan procedure
                                        ; }
FSTKSCN010:
;-------------------  read out1 input  ----------------------------------------
    LD  A,[BR:K0nD_IOR]                 ; K00-K07 input
    LD  B,[BR:K1nD_IOR]                 ; K10,K11 input

;-------------------  out2 setting  -------------------------------------------
    M_IO_BSET   P1nD_IOR,P16D_BIT       ; R1 P16 output -> H
    M_IO_BCLR   P1nD_IOR,P17D_BIT       ; R2 P17 output -> L (active)

;-------------------  out1 input check  ---------------------------------------
    CP  BA,#03FFh
    JRS Z,FSTKSCN020                    ; if (anyone is L){
        CARL    _fst_kscn_inp               ; column check sub routine
        LD  B,#1                            ; row position
        JRS FSTKSCN_OK                      ; goto valid scan procedure
                                        ; }
FSTKSCN020:
;-------------------  read out2 input  ----------------------------------------
    LD  A,[BR:K0nD_IOR]                 ; K00-K07 input
    LD  B,[BR:K1nD_IOR]                 ; K10,K11 input

;-------------------  out3 setting  -------------------------------------------
    M_IO_BSET   P1nD_IOR,P17D_BIT       ; R2 P17 output -> H
    M_IO_BCLR   R2nD_IOR,R27D_BIT       ; R3 R27 output -> L (active)

;-------------------  out2 input check  ---------------------------------------
    CP  BA,#03FFh
    JRS Z,FSTKSCN030                    ; if (anyone is L){
        CARL    _fst_kscn_inp               ; column check sub routine
        LD  B,#2                            ; row position
        JRS FSTKSCN_OK                      ; goto valid scan procedure
                                        ; }

FSTKSCN030:
;-------------------  read out3 input  ----------------------------------------
    LD  A,[BR:K0nD_IOR]                 ; K00-K07 input
    LD  B,[BR:K1nD_IOR]                 ; K10,K11 input

;-------------------  out4 setting  -------------------------------------------
    M_IO_BSET   R2nD_IOR,R27D_BIT       ; R3 R27 output -> H
    M_IO_BCLR   R3nD_IOR,R34D_BIT       ; R4 R34 output -> L (active)

;-------------------  out3 input check  ---------------------------------------
    CP  BA,#03FFh
    JRS Z,FSTKSCN040                    ; if (anyone is L){
        CARL    _fst_kscn_inp               ; column check sub routine
        LD  B,#3                            ; row position
        JRS FSTKSCN_OK                      ; goto valid scan procedure
                                        ; }

FSTKSCN040:
;-------------------  read out4 input  ----------------------------------------
    LD  A,[BR:K0nD_IOR]                 ; K00-K07 input
    LD  B,[BR:K1nD_IOR]                 ; K10,K11 input

;-------------------  out4 input check  ---------------------------------------
    CP  BA,#03FFh
    JRS Z,FSTKSCN_ERR                   ; if (anyone is L){
        CARL    _fst_kscn_inp               ; column check sub routine
        LD  B,#4                            ; row position
                                        ; }

;-------------------  valid key scan  -----------------------------------------
FSTKSCN_OK:
    PACK                                ; A upper nibble :row position
                                        ;   lower nibble :column position
    LD  [_key_position],A               ; save key position
    LD  A,#0
    LD  [_key_count],A                  ; key count = 0

    M_IO_BSET   P1nD_IOR,P17D_BIT|P16D_BIT|P15D_BIT     ; P15,16,17 output -> H
    M_IO_BSET   R2nD_IOR,R27D_BIT           ; R27 output -> H
    M_IO_BSET   R3nD_IOR,R34D_BIT           ; R34 output -> H

    LD  [BR:FTM32_IOR],#FTM32_BIT           ; reset interrupt flag
    M_IO_BSET   ETM32_IOR,ETM32_BIT         ; enable 32Hz interrupt

    JRS FSTKSCN_END
;-------------------  invalid key scan  ---------------------------------------
FSTKSCN_ERR:
    M_IO_BCLR   P1nD_IOR,P17D_BIT|P16D_BIT|P15D_BIT     ; P15,16,17 output -> L (active)
    M_IO_BCLR   R2nD_IOR,R27D_BIT           ; R27 output -> L (active)
    M_IO_BCLR   R3nD_IOR,R34D_BIT           ; R34 output -> L (active)

FSTKSCN_ERR2:
    LD  [BR:FK1_IOR],#FK1_BIT|FK0H_BIT|FK0L_BIT         ; reset interrupt flag
    M_IO_BSET   EK1_IOR,EK1_BIT|EK0H_BIT|EK0L_BIT       ; enable k port interrupt

;-------------------  end of first key scan  ----------------------------------
FSTKSCN_END:
    POP HL
    POP BA

    RETE

;==============================================================================
;   colmun check sub routine
;   input       none
;   output      A : column position
;   destroyed   L
;==============================================================================
_fst_kscn_inp: 
    LD  L,#9                            ; colmncounter
    BIT B,#00000010b                    ; colmn #9
    JRS Z,FSTKSCNSB020
    DEC L
    BIT B,#00000001b                    ; colmn #8
    JRS Z,FSTKSCNSB020
    DEC L
    BIT A,#10000000b                    ; colmn #7
    JRS Z,FSTKSCNSB020
    DEC L
    BIT A,#01000000b                    ; colmn #6
    JRS Z,FSTKSCNSB020
    DEC L
    BIT A,#00100000b                    ; colmn #5
    JRS Z,FSTKSCNSB020
    DEC L
    BIT A,#00010000b                    ; colmn #4
    JRS Z,FSTKSCNSB020
    DEC L
    BIT A,#00001000b                    ; colmn #3
    JRS Z,FSTKSCNSB020
    DEC L
    BIT A,#00000100b                    ; colmn #2
    JRS Z,FSTKSCNSB020
    DEC L
    BIT A,#00000010b                    ; colmn #1
    JRS Z,FSTKSCNSB020
    DEC L

FSTKSCNSB020:
    LD  A,L

    RET

;###############################################################################
;<interrupt> 32hz clock timer, key scan
;###############################################################################
int_keyscan:

;------------------  save register data  --------------------------------------
    PUSH    BA
    PUSH    HL

;------------------  reset interrupt flag  ------------------------------------
    LD  [BR:FTM32_IOR],#FTM32_BIT   ; reset interrupt flag

;------------------  sub key scan  --------------------------------------------
    LD  A,[_key_position]               ; key position
    UPCK                                ; B:row position
                                        ; A:column position

;------------------  set selected row out to active  --------------------------
    CP  B,#0
    JRS NZ,KSCN010                      ; if (row == 0){
        M_IO_BCLR   P1nD_IOR,P15D_BIT       ; P15 output -> L (active)
    JRS KSCN050                         ; }
    KSCN010:
    DEC B
    JRS NZ,KSCN020                      ; else if (row == 1){
        M_IO_BCLR   P1nD_IOR,P16D_BIT       ; P16 output -> L (active)
    JRS KSCN050                         ; }
    KSCN020:
    DEC B
    JRS NZ,KSCN030                      ; else if (row == 2){
        M_IO_BCLR   P1nD_IOR,P17D_BIT       ; P17 output -> L (active)
    JRS KSCN050                         ; }
    KSCN030:
    DEC B
    JRS NZ,KSCN040                      ; else if (row == 3){
        M_IO_BCLR   R2nD_IOR,R27D_BIT       ; R27 output -> L (active)
    JRS KSCN050                         ; }
    KSCN040:
    DEC B
    JRS NZ,KSCN050                      ; else if (row == 4){
        M_IO_BCLR   R3nD_IOR,R34D_BIT       ; R34 output -> L (active)
    KSCN050:                            ; }

;------------------  check selected column input out --------------------------
    CP  A,#10
    JRS NC,KEYSCAN_NG                   ; if (column position <= 9){

    SLL A                                   ; column position *2
    LD  B,#0
    LD  HL,#KYSC_JMPTBL
    ADD HL,BA                               ; HL = KYSC_JMPTBL + column position*2
    LD  HL,[HL]
    JP  HL

KYSC_JMPTBL:
    DW  KYSCINP0
    DW  KYSCINP1
    DW  KYSCINP2
    DW  KYSCINP3
    DW  KYSCINP4
    DW  KYSCINP5
    DW  KYSCINP6
    DW  KYSCINP7
    DW  KYSCINP8
    DW  KYSCINP9
                                            ; switch (column position){
    KYSCINP0:                                   ; case 0:
        M_IO_BIT    K0nD_IOR,K00D_BIT
            JRL Z,KEYSCAN_OK                        ; if column0 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP1:                                   ; case 1:
        M_IO_BIT    K0nD_IOR,K01D_BIT
            JRS Z,KEYSCAN_OK                        ; if column1 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP2:                                   ; case 2:
        M_IO_BIT    K0nD_IOR,K02D_BIT
            JRS Z,KEYSCAN_OK                        ; if column2 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP3:                                   ; case 3:
        M_IO_BIT    K0nD_IOR,K03D_BIT
            JRS Z,KEYSCAN_OK                        ; if column3 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP4:                                   ; case 4:
        M_IO_BIT    K0nD_IOR,K04D_BIT
            JRS Z,KEYSCAN_OK                        ; if column4 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP5:                                   ; case 5:
        M_IO_BIT    K0nD_IOR,K05D_BIT
            JRS Z,KEYSCAN_OK                        ; if column5 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP6:                                   ; case 6:
        M_IO_BIT    K0nD_IOR,K06D_BIT
            JRS Z,KEYSCAN_OK                        ; if column6 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP7:                                   ; case 7:
        M_IO_BIT    K0nD_IOR,K07D_BIT
            JRS Z,KEYSCAN_OK                        ; if column7 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP8:                                   ; case 8:
        M_IO_BIT    K1nD_IOR,K10D_BIT
            JRS Z,KEYSCAN_OK                        ; if column8 = 0 then keyscan OK
            JRS KEYSCAN_NG                          ; else keyscan NG
    KYSCINP9:                                   ; case 9:
        M_IO_BIT    K1nD_IOR,K11D_BIT
            JRS Z,KEYSCAN_OK                        ; if column9 = 0 then keyscan OK
                                                    ; else keyscan NG
                                            ; }
                                        ; }

;------------------  key scan NG  ---------------------------------------------
KEYSCAN_NG:
                                            ; all off
    M_IO_BSET   P1nD_IOR,P17D_BIT|P16D_BIT|P15D_BIT     ; P15,16,17 output -> H
    M_IO_BSET   R2nD_IOR,R27D_BIT           ; R27 output -> H
    M_IO_BSET   R3nD_IOR,R34D_BIT           ; R34 output -> H

    LD  A,[_key_count]
    CP  A,#0
    JRS Z,KYSCNNG100                        ; if (key count != 0){
        LD  A,#0
        LD  [_key_count],A                      ; key count = 0
        JRL KEYSCAN_END                     ; }

    KYSCNNG100:                             ; else (key count == 0){
        M_IO_BCLR   ETM32_IOR,ETM32_BIT         ; disenable 32Hz interrupt
        LD  [BR:FK1_IOR],#FK1_BIT|FK0H_BIT|FK0L_BIT     ; reset interrupt flag
        M_IO_BSET   EK1_IOR,EK1_BIT|EK0H_BIT|EK0L_BIT   ; enable k port interrupt

        M_IO_BCLR   P1nD_IOR,P17D_BIT|P16D_BIT|P15D_BIT     ; P15,16,17 output -> L (active)
        M_IO_BCLR   R2nD_IOR,R27D_BIT           ; R27 output -> L (active)
        M_IO_BCLR   R3nD_IOR,R34D_BIT           ; R34 output -> L (active)

        JRS KEYSCAN_END                         ; goto end
                                            ; }

;------------------  key scan OK  ---------------------------------------------
KEYSCAN_OK:
                                            ; all off
    M_IO_BSET   P1nD_IOR,P17D_BIT|P16D_BIT|P15D_BIT     ; P15,16,17 output -> H
    M_IO_BSET   R2nD_IOR,R27D_BIT           ; R27 output -> H
    M_IO_BSET   R3nD_IOR,R34D_BIT           ; R34 output -> H

    LD  A,[_key_count]
    CP  A,#0
    JRS NZ,KEYSCAN_END                      ; if (key count == 0){
        LD  A,#1
        LD  [_key_count],A                      ; key count = 1
        M_BSET  _otrflag,otrflag_keyprss,HL                 ; valid key press

    ;------------------  end procedure  ---------------------------------------
    KEYSCAN_END:                            ; carry flag should not be changed 

    POP HL
    POP BA

    RETE

;###############################################################################
;<interrupt> 8hz clock timer, roll char
;###############################################################################
int_roll:
    PUSH    BA
    PUSH    HL
    PUSH    IX
    PUSH    IY

;------------------  reset interrupt flag  ------------------------------------
    LD  [BR:FPT1_IOR],#FPT1_BIT

    LD  HL,#_end_buf
    LD  B,[HL]
    LD  IX,#_chr_buf
ROLL00:
    PUSH    B
    LD  A,[IX]
    UPCK
    LD  L,#6
    MLT
    LD  A,L
    LD  HL,#0F800h
    ADD HL,BA           ; char pos
    ADD HL,#4
    PUSH    HL

    LD  B,#5
    M_BIT   _otrflag,otrflag_rollup,HL
    JRS Z,ROLL02
        POP HL
    ROLL01:
        RRC [HL]
        INC HL
        DJR NZ,ROLL01
    JRS ROLL10
    ROLL02:
        POP HL
    ROLL03:
        RLC [HL]
        INC HL
        DJR NZ,ROLL03
ROLL10:
    INC IX
    LD  A,[IX]
    INC A
    CP  A,#8
    JRS Z,ROLL11
        LD  [IX],A
        INC IX
    JRS ROLL20
    ROLL11:
        POP B
        PUSH    B
        DEC IX
        PUSH    IX
        LD  IY,IX
        ADD IY,#2
        ROLL111:
            LD  HL,[IY]
            LD  [IX],HL
            ADD IX,#2
            ADD IY,#2
        DJR NZ,ROLL111
        POP IX
        LD  HL,#_end_buf
        DEC [HL]
ROLL20:
    POP B
    DJR NZ,ROLL00
    
    LD  HL,#_end_buf
    CP  [HL],#0
    JRS NZ,ROLLEND          
        M_IO_BCLR   EPT1_IOR,EPT1_BIT
            and      [br:31h],#11111110b
        CARL    _k_osc_3to1
        M_BCLR  _otrflag,otrflag_roll,HL
ROLLEND:
    POP IY
    POP IX
    POP HL
    POP BA

    RETE

;#############################################################################
; <interrupt> dummy
;#############################################################################
int_dummy:

    RETE

;#############################################################################
; initialize key scan
;#############################################################################
_k_kscn_init:

    ;-------------------  save register data  ---------------------------------
    PUSH    HL

    ;-------------------  output port setting  ---------------------------
    M_IO_BSET   IOC1n_IOR,IOC17_BIT|IOC16_BIT|IOC15_BIT     ; P15 - P17 to output
    M_IO_BCLR   HZR2n_IOR,HZR27_BIT                         ; R27 to complementary
    M_IO_BCLR   HZR3n_IOR,HZR34_BIT                         ; R34 to complementary

    M_IO_BCLR   P1nD_IOR,P17D_BIT|P16D_BIT|P15D_BIT         ; P15 - P17 to L (active)
    M_IO_BCLR   R2nD_IOR,R27D_BIT                           ; R27 to L (active)
    M_IO_BCLR   R3nD_IOR,R34D_BIT                           ; R34 to L (active)

    ;-------------------  input port setting  ---------------------------
    M_IO_BCLR   PK0n_IOR,PK01_BIT|PK00_BIT
    M_IO_BSET   PK0n_IOR,INTP_K0007                         ; set interrupt priority
    M_IO_BSET   PK0n_IOR,INTP_CLOCK
    M_IO_BCLR   PK1n_IOR,PK11_BIT|PK10_BIT
    M_IO_BSET   PK1n_IOR,INTP_K1011                         ; set interrupt priority

    LD  [BR:KCP0n_IOR],#KCP07_BIT|KCP06_BIT|KCP05_BIT|KCP04_BIT|KCP03_BIT|KCP02_BIT|KCP01_BIT|KCP00_BIT
                                                        ; K00 - K07 interrupt is occured by H to L edge
    LD  [BR:KCP1n_IOR],#KCP11_BIT|KCP10_BIT             ; K10,K11 interrupt is occured by H to L edge

    LD  [BR:SIK0n_IOR],#SIK07_BIT|SIK06_BIT|SIK05_BIT|SIK04_BIT|SIK03_BIT|SIK02_BIT|SIK01_BIT|SIK00_BIT
                                                        ; select K00 - K07 interrupt
    LD  [BR:SIK1n_IOR],#SIK11_BIT|SIK10_BIT             ; select K10,K11 interrupt

    LD  [BR:EK1_IOR],#EK1_BIT|EK0H_BIT|EK0L_BIT         ; K00-K11 interrupt is enable

    ;-------------------  return register data  -------------------------------
    POP HL

    RET


;#############################################################################
; change clock 1 to 3
;   input     : none
;   output    : none
;   destroyed : none
;#############################################################################
_k_osc_1to3:

    ;----------------------  check OSC setting  -------------------------------
    M_IO_BIT    CLKCHG_IOR,CLKCHG_BIT   ; OSC setting check
    JRS Z,CLKLH00
        RET                             ; if (OSC is OSC3) -> end
    CLKLH00:

    ;----------------------  save register  -----------------------------------
    PUSH    SC
    PUSH    A
    OR  SC,#11000000B                   ; forbit all interrupt

    ;----------------------  change supply voltage  ----------------------------
;*******  <<conditional assemble>>  supply voltage >3.5V  *********************
IF  CA_SUPVOL                           ; (normal and high speed mode)
    M_IO_BSET   VDCn_IOR,VDC1_BIT       ; change to high mode
;*******  <<conditional assemble>>  supply voltage <3.5V  *********************
ELSE                                    ; (low power and normal mode)
    M_IO_BCLR   VDCn_IOR,VDC0_BIT|VDC1_BIT  ; change to normal mode
ENDIF
;*******  <<conditional assemble>>  *******************************************

    ;----------------------  wait 5 msec  -------------------------------------
    LD  A,#5*4-7                        ; 5 msec
    CARS    CLKWAIT                     ; software wait

    ;----------------------  OSC3 on  -----------------------------------------
    M_IO_BSET   OSCC_IOR,OSCC_BIT       ; OSC3 osclation on

    ;----------------------  wait 5 or 20 msec  -------------------------------
;*******  <<conditional assemble>>  OSC3 is ceramic resonator  ****************
IF  CA_OSCSEL
    LD  A,#OSCWAIT_CER*4-7              ; ceramic
;*******  <<conditional assemble>>  OSC3 is crystal resonator  ****************
ELSE
    LD  A,#OSCWAIT_CRY*4-7              ; crystal
ENDIF
;*******  <<conditional assemble>>  *******************************************

    CARS    CLKWAIT                     ; software wait

    ;----------------------  change clock to OSC3  ----------------------------
    M_IO_BSET   CLKCHG_IOR,CLKCHG_BIT

    ;----------------------  return register  ---------------------------------
    POP A
    POP SC                              ; interrupt prohibition is lift

    RET

;=======================  software wait  ======================================
;   input     : A reg = wait time 4 for 1 msec
;               1msec /(1/(32/2)msec *4cycles) = 4
;               CARS 4 cycles +RET 3 cycles =7 cycles
;               A reg = n*4-7  n:wait time (msec)
;   output    : none
;   destroyed : A reg
;==============================================================================
CLKWAIT:
    DEC A                       ; 2 cycle
    JRS NZ,CLKWAIT              ; 2 cycle
    RET

;#############################################################################
; change clock 3 to 1
;   input     : none
;   output    : none
;   destroyed : none
;#############################################################################
_k_osc_3to1:

    ;----------------------  check OSC setting  -------------------------------
    M_IO_BIT    CLKCHG_IOR,CLKCHG_BIT   ; OSC setting check
    JRS NZ,CLKHL00
        RET                             ; if (OSC is OSC1) -> end
    CLKHL00:

    ;----------------------  save register  -----------------------------------
    PUSH    SC
    PUSH    A
    OR  SC,#11000000B                   ; forbit all interrupt

    ;----------------------  change clock to OSC1  ----------------------------
    M_IO_BCLR   CLKCHG_IOR,CLKCHG_BIT

    ;----------------------  OSC3 off  ----------------------------------------
    M_IO_BCLR   OSCC_IOR,OSCC_BIT

    ;----------------------  change supply voltage  ---------------------------
;*******  <<conditional assemble>>  supply voltage >3.5V  *********************
IF  CA_SUPVOL                           ; (normal and high speed mode)
    M_IO_BCLR   VDCn_IOR,VDC1_BIT|VDC0_BIT      ; change to normal mode
;*******  <<conditional assemble>>  supply voltage <3.5V  *********************
ELSE                                    ; (low power and normal mode)
    M_IO_BCLR   VDCn_IOR,VDC1_BIT       ; change to low power mode
    M_IO_BSET   VDCn_IOR,VDC0_BIT
ENDIF
;*******  <<conditional assemble>>  *******************************************

    ;----------------------  return register  ---------------------------------
    POP A
    POP SC                              ; interrupt prohibition is lift
    RET

;################################################################################
; Clear display memory
; 
;   Input: none.
;   Output: none.
;   Model Name: clear_vram
;################################################################################
_clear_vram:

    LD  IX,#McuVramSttAd                ; start address
    LD  L,#0                            ; x axis counter
    LD  B,#4                            ; y axis counter
    LD  A,#0

    DPCLR100:                           ; do {
                                            ; do {
        LD  [IX+L],A                            ; data clear
        INC L                                   ; x++
        CP  L,#McuVramXmax+1
        JRS C,DPCLR100                      ; } while (x < xmax)

    ADD IX,#McuVramYstep                    ; y axis memory step
    LD  L,#0                                ; x =0
    DEC B
    JRS NZ,DPCLR100                     ; } while (y < ymax)

    RET

;///////////////////////////////////
; display all the character
;//////////////////////////////////
_disp_all:
    LD  HL,#ChrTbl
    LD  IX,#0F804h
    LD  B,#42
DSP1:
    LD  [IX],[HL]
    INC IX
    INC HL
    DJR NZ,DSP1

    LD  IX,#0F904h
    LD  B,#42
DSP2:
    LD  [IX],[HL]
    INC IX
    INC HL
    DJR NZ,DSP2

    LD  IX,#0FA04h
    LD  B,#42
DSP3:
    LD  [IX],[HL]
    INC IX
    INC HL
    DJR NZ,DSP3

    LD  IX,#0FB04h
    LD  B,#30
DSP4:
    LD  [IX],[HL]
    INC IX
    INC HL
    DJR NZ,DSP4

    RET

DEFSECT ".table",CODE
SECT    ".table"

;================================= table =============================================
ChrTbl:
    DB  7eh,11h,11h,11h,7eh,00h     ; A 41
    DB  7fh,49h,49h,49h,36h,00h     ; B 42
    DB  3eh,41h,41h,41h,22h,00h     ; C 43
    DB  7fh,41h,41h,22h,1ch,00h     ; D 44
    DB  7fh,49h,49h,49h,41h,00h     ; E 45
    DB  7fh,09h,09h,09h,01h,00h     ; F 46
    DB  3eh,41h,49h,49h,7ah,00h     ; G 47
    DB  7fh,08h,08h,08h,7fh,00h     ; H 48
    DB  00h,41h,7fh,41h,00h,00h     ; I 49
    DB  20h,40h,41h,3fh,01h,00h     ; J 4A
    DB  7fh,08h,14h,22h,41h,00h     ; K 4B
    DB  7fh,40h,40h,40h,40h,00h     ; L 4C
    DB  7fh,02h,0ch,02h,7fh,00h     ; M 4D
    DB  7fh,04h,08h,10h,7fh,00h     ; N 4E
    DB  3eh,41h,41h,41h,3eh,00h     ; O 4F
    DB  7fh,09h,09h,09h,06h,00h     ; P 50
    DB  3eh,41h,51h,21h,5eh,00h     ; Q 51
    DB  7fh,09h,19h,29h,46h,00h     ; R 52
    DB  46h,49h,49h,49h,31h,00h     ; S 53
    DB  01h,01h,7fh,01h,01h,00h     ; T 54
    DB  3fh,40h,40h,40h,3fh,00h     ; U 55
    DB  1fh,20h,40h,20h,1fh,00h     ; V 56
    DB  3fh,40h,38h,40h,3fh,00h     ; W 57
    DB  63h,14h,08h,14h,63h,00h     ; X 58
    DB  07h,08h,70h,08h,07h,00h     ; Y 59
    DB  61h,51h,49h,45h,43h,00h     ; Z 5A

ChrPosTbl:
    DB  key_a,chr_a
    DB  key_b,chr_b
    DB  key_c,chr_c
    DB  key_d,chr_d
    DB  key_e,chr_e
    DB  key_f,chr_f
    DB  key_g,chr_g
    DB  key_h,chr_h
    DB  key_i,chr_i
    DB  key_j,chr_j
    DB  key_k,chr_k
    DB  key_l,chr_l
    DB  key_m,chr_m
    DB  key_n,chr_n
    DB  key_o,chr_o
    DB  key_p,chr_p
    DB  key_q,chr_q
    DB  key_r,chr_r
    DB  key_s,chr_s
    DB  key_t,chr_t
    DB  key_u,chr_u
    DB  key_v,chr_v
    DB  key_w,chr_w
    DB  key_x,chr_x 
    DB  key_y,chr_y
    DB  key_z,chr_z
    
;==================  valiable definition  =====================================
DEFSECT ".dataram",DATA at 0f000h
SECT    ".dataram"

_data_begin:
    ;------------------------- key --------------------------------
_key_position:  DS  1               ; row position|column position
_key_count: DS  1               ; key scan counter

    ;------------------------- flag -----------------------------------------
_otrflag:   DS  1               ; other flags

    ;----------------------- buffer ----------------------------------------
_chr_buf:   DS  26*2
_end_buf:   DS  1

_data_end:

    END

