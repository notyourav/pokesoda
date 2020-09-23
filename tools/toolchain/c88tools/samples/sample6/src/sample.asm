INCLUDE 'k_348ior.inc'
INCLUDE 'k_disply.inc'
INCLUDE 's_system.inc'

;=============================================================================
;character data pitch
;=============================================================================
ChrDPthStdAsc   EQU 10               ; standard ascii & special character data pitch = 5 byte
EXTERN __lc_es

DEFSECT ".vecter",CODE  AT 0000h
SECT    ".vecter"

;------------------  GENERAL INTERRUPT  ---------------------------------------
    DW  __START           ; 0000h reset
    DW  int_dummy       ; 0002h divided by zero
    DW  int_dummy       ; 0004h watch dog timer(nmi)

;------------------  timer interrupt  -----------------------------------------
    DW  int_dummy       ; 0006h timer 1
    DW  int_dummy       ; 0008h timer 0

;------------------  input port interrupt  ------------------------------------
    DW  int_dummy       ; 000ah k10,11 port input
    DW  int_dummy       ; 000ch k04 - 07 port input
    DW  int_dummy       ; 000eh k00 - 03 port input

;------------------  serial interfaces  ---------------------------------------
    DW  int_dummy       ; 0010h serial i/f - receive error
    DW  int_dummy       ; 0012h serial i/f - receive completion
    DW  int_dummy       ; 0014h serial i/f - send completion

;------------------  stop watch  ----------------------------------------------
    DW  int_dummy       ; 0016h stop watch 100hz
    DW  int_dummy       ; 0018h stop watch  10hz
    DW  int_dummy       ; 001ah stop watch   1hz

;------------------  watch  ---------------------------------------------------
    DW  int_dummy       ; 001ch watch 32hz
    DW  int_dummy       ; 001eh watch  8hz
    DW  int_dummy       ; 0020h watch  2hz
    DW  int_clock       ; 0022h watch  1hz



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
    LD  BR,#0FFh                    ; BR register initialize to I/O area
                ;###### BR register should be fixed at '0FFh' ##########

    ;---------------  bus mode setting  ---------------------------------------
                        ; MCU & MPU mode
    LD  [BR:BSMDn_IOR],#00H
                                    ; single chip mode
                                    ; /CE0,/CE1,/CE2,/CE3:disabled

    ;---------------  stack pointer page address  -----------------------------
    LD  [BR:SPPn_IOR],#@DPAG(__lc_es-1)       ; set stack pointer page

    ;----------------------  set I/O register  --------------------------------
    ;<display>
    M_IO_BCLR   DTFNT_IOR,DTFNT_BIT     ; 5 x 8 dot font
    M_IO_BCLR   LDUTY_IOR,LDUTY_BIT     ; 1/32 duty

    M_IO_BCLR   DSPAR_IOR,DSPAR_BIT     ; area 0
    M_IO_BCLR   LCDCn_IOR,LCDC1_BIT     ; normal display
    M_IO_BSET   LCDCn_IOR,LCDC0_BIT
    M_IO_BCLR   LCn_IOR,LC3_BIT         ; initial contrast = 7
    M_IO_BSET   LCn_IOR,LC2_BIT|LC1_BIT|LC0_BIT

    ;<clock>
    M_IO_BCLR   PTMn_IOR,PTM1_BIT|PTM0_BIT
    M_IO_BSET   PTMn_IOR,00000011b      ; set interrupt priority 3

    M_IO_BSET   TMRST_IOR,TMRST_BIT     ; reset clock timer
    M_IO_BSET   ETM1_IOR,ETM1_BIT       ; 1Hz interrupt enable
    M_IO_BSET   TMRUN_IOR,TMRUN_BIT     ; run clock timer

    ;-------------------  clear MCU Vram  -------------------------------------
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

    ;-------------------  initialze data  -------------------------------------
    LD  HL,#_clockdata
    INITDATA100:
        LD  [HL],#0
        INC HL
        CP  HL,#_clockdata+12
    JRS C,INITDATA100

    M_SED                           ; decimal operation

    LD  HL,#_clockdata
    LD  [HL],#9h
    LD  HL,#_clockdata+1
    LD  [HL],#59h
    LD  HL,#_clockdata+2
    LD  [HL],#00h

    M_CLD                           ; normal operation

    LD  HL,#_dispdata+2
    LD  [HL],#":"
    LD  HL,#_dispdata+5
    LD  [HL],#":"

    LD  HL,#_chrsizeptr
    LD  [HL],#Cchrsizemax           ;_chrsizeptr=chrsizemax

    LD  HL,#_chrptrincflag
    LD  [HL],#0                     ;_chrptrincflag=0

    LD  HL,#_key_sts
    LD  [HL],#0                     ;_chrptrincflag=0

    LD  IX,#_clockunpk              ; sec address
    LD  IY,#_clockunpkold           ; des address
    LD  BA,#0
    LD  [IX],BA
    LD  [IY],BA
    ADD IX,#2
    ADD IY,#2
    LD  [IX],BA
    LD  [IY],BA
    ADD IX,#2
    ADD IY,#2
    LD  [IX],BA
    LD  [IY],BA


    ;<all interrupt enable>
    AND SC,#00111111b               ; all interrupt enable

    SUB SP,#4                       ; SP-=4
    LD  IX,SP

    LD  BA,#initdispdata
    LD  [IX],BA                     ; pointer for string
    LD  A,#0
    LD  [IX+2],A                    ; x position
    LD  A,#0
    LD  [IX+3],A                    ; y position
    LD  A,#0
    CARL    _disp_stringY8          ; display message

    ADD SP,#4
;******************************************************************************
;***********************  Main Loop  ******************************************
;******************************************************************************

    CARL    _k_osc_1to3

MainLoop:
    ;<reset WDT>
    OR  [BR:WDRST_IOR],#WDRST_BIT


    ;<Halt>
    HALT

    ;<make display data>
    LD  IX,#_clockdata                  ; source address
    LD  IY,#_dispdata                   ; destination address
    LD  IX,#0
DispLoop40:
    CP  IX,#Crollcnt
    JR  Z,DispLoopExit                  ;for (j=0;j<Crollcnt;j++) {

    LD  A,#0
DispLoop42:                             ; do {
    LD  [BR:FTM32_IOR],#FTM32_BIT           ; reset interrupt flag
    M_IO_BSET   ETM32_IOR,ETM32_BIT         ; enable 32Hz timer interrupt
DispLoop45:                             ; do {  
    HALT
    M_IO_BIT    FTM32_IOR,FTM32_BIT
    JRS Z,DispLoop45                    ; }while(not passed 1/32 sec)
    M_IO_BCLR   ETM32_IOR,ETM32_BIT         ; disenable 32Hz timer interrupt
    LD  [BR:FTM32_IOR],#FTM32_BIT           ; reset interrupt flag
    INC A
    CP  A,#2
    JRS NZ,DispLoop42                   ;} while (A<2)

    LD  IY,#0
DispLoop50:
    CP  IY,#6
    JR  Z,DispLoop110               ;for (i=0;i<6;i++) {
    LD  HL,#_clockunpk
    ADD HL,IY
    LD  A,[HL]                      ;A=_clockunpk[i]
    LD  HL,#_clockunpkold
    ADD HL,IY
    LD  B,[HL]                      ;B=_clockunpkold[i]
    LD  HL,#_work
    LD  [HL],B                      ;work[0]=_clockunpkold[i]

    CP  A,B
    JR  Z,DispLoop100               ;if (_clockunpk[i]!=_clockunpkold[i]) {

    LD  HL,#clockdisppos
    ADD HL,IY
    LD  A,[HL]
    LD  HL,#_work
    LD  [HL],A                      ;work[0]= _clockdisppos[i]

    LD  HL,#_clockunpkold
    ADD HL,IY
    LD  L,[HL]                      ;L=_clockunpkold[i];
    LD  A,#Crollcnt
    SLL A                           ;A=Crollcnt*2
    MLT                             ;HL=L*A //_clockunpkold[i]*Crollcnt
    LD  BA,IX
    SLL A                           ;A=j*2
    ADD HL,BA                           ;HL=HL+BA //HL=_clockunpkold[i]*Crollcnt)+(j*2)
    ADD HL,#_dispdata1
    LD  BA,[HL]

    PUSH    IX
    SUB SP,#5                       ; SP-=4
    LD  IX,SP

    LD  [IX],BA                     ; pointer for string

    LD  HL,#_work
    LD  A,[HL]
    LD  [IX+2],A                    ; x position
    LD  A,#0
    LD  [IX+3],A                    ; y position
    LD  A,#0
    LD  [IX+4],A                    ; drwa and
    CARL    _disp_dotY16            ; display message

    ADD SP,#5
    POP IX

    LD  HL,#_clockunpk
    ADD HL,IY
    LD  L,[HL]                      ;L=_clockunpk[i];
    LD  A,#Crollcnt
    SLL A                           ;A=Crollcnt*2
    MLT                             ;HL=L*A //_clockunpk[i]*Crollcnt
    LD  BA,IX
    SLL A                           ;A=j*2
    ADD HL,BA                           ;HL=HL+BA //HL=_clockunpkold[i]*Crollcnt)+(j*2)
    ADD HL,#_dispdata2
    LD  BA,[HL]

    PUSH    IX
    SUB SP,#5                       ; SP-=4
    LD  IX,SP
    LD  [IX],BA                     ; pointer for string

    LD  HL,#_work
    LD  A,[HL]
    LD  [IX+2],A                    ; x position
    LD  A,#0
    LD  [IX+3],A                    ; y position
    LD  A,#1
    LD  [IX+4],A                    ; drwa or
    CARL    _disp_dotY16            ; display message

    ADD SP,#5
    POP IX                      ;}
DispLoop100:
    INC IY
    JR  DispLoop50              ;}
DispLoop110:
    INC IX
    JR  DispLoop40          ;}
DispLoopExit:

    LD  IX,#_clockunpk              ; sec address
    LD  IY,#_clockunpkold           ; des address

    LD  BA,[IX]
    LD  [IY],BA
    ADD IX,#2
    ADD IY,#2
    LD  BA,[IX]
    LD  [IY],BA
    ADD IX,#2
    ADD IY,#2
    LD  BA,[IX]
    LD  [IY],BA

    JR  MainLoop

;#############################################################################
;<interrupt> realtime clock
;   input     : none
;   output    : none
;   destroyed : none
;#############################################################################
GLOBAL int_clock
int_clock:
    ;----------------------  keep register data  ------------------------------
    PUSH    HL
    PUSH    EP
    PUSH    BA
    PUSH    IX

    LD  EP,#0                       ; standard page

    ;----------------------  reset interrupt flag  ----------------------------
    LD  [BR:FTM1_IOR],#FTM1_BIT

    ;----------------------  calc date&time  ----------------------------------
    M_SED                           ; decimal operation

    ;------------------------  second increment  ------------------------------
    LD  HL,#_clockdata+2
    ADD [HL],#1                     ; increment second                          ; decimal calculation
    CP  [HL],#60h                                                               ; BCD code
    JRL C,INTCLKEND                 ; if (second>=60){
        LD  [HL],#0                     ; second = 0
        ;------------------------  minute increment  --------------------------
        DEC HL
        ADD [HL],#1                 ; increment minute                      ; decimal calculation
        CP  [HL],#60h                                                       ; BCD code
        JRL C,INTCLKEND             ; if (minute>=60){
            LD  [HL],#0                 ; minute = 0
            ;------------------------  hour increment  ------------------------
            DEC HL
            ADD [HL],#1             ; increment hour                    ; decimal calculation
            CP  [HL],#24h                                                   ; BCD code
            JRL C,INTCLKEND             ; if (hour>=24){
                LD  [HL],#0                 ; hour = 0
                                        ; }
                                    ; }
                                    ; }

    ;----------------------  end procedure  -----------------------------------
;#############################################################################
;<interrupt> realtime clock
;   input     : none
;   output    : none
;   destroyed : none
;#############################################################################

INTCLKEND:
    M_CLD                               ; normal operation

    LD  IX,#_clockunpk
    LD  HL,#_clockdata
    LD  A,[HL]
    UPCK
    LD  [IX],B
    LD  [IX+1],A
    INC HL
    LD  A,[HL]
    UPCK
    LD  [IX+2],B
    LD  [IX+3],A
    INC HL
    LD  A,[HL]
    UPCK
    LD  [IX+4],B
    LD  [IX+5],A

    ;----------------------  return register data  ----------------------------
    POP IX
    POP BA
    POP EP
    POP HL

    RETE

;##############################################################################
; display string (Y in byte) in one line
;   input       [IX]   :pointer for string (word)
;               [IX+2] :x position
;               [IX+3] :y position
;   output      [IX]   :pointer for next character (word)
;               [IX+2] :next x position
;               [IX+3] :next y position
;               C flag :1 error is occurd in character data transfer
;               Z flag :1 display area overflow
;   destroyed   register : none
;   subroutine test     takeda          Nov.30th,'98
;##############################################################################
GLOBAL  _disp_stringY8
_disp_stringY8:
    ;--------------------  store the registers  -------------------------------
    PUSH    BA
    PUSH    HL
    PUSH    IY
                                    ; IX pointer to work buffer

    ;--------------------  check min,max parameter  ---------------------------
    LD  A,[IX+2]
    CP  A,#LCDXmax+1
    JRL NC,DSPSTRERR1               ; if (xp > LCDXmax) -> display error
    LD  A,[IX+3]
    CP  A,#CY8MaxY+1
    JRL NC,DSPSTRERR1               ; if (yp > CY8maxY) -> display error

    ;--------------------  transfer parameter  --------------------------------
    LD  IY,[IX]                     ; IY = pointer for string

    ;--------------------  main loop  -----------------------------------------
    DSPSTRLOOP:
    LD  A,[IY]
    CP  A,#0
    JRL Z,DSPSTROK                  ; while (*str != \0) {
        ;--------------------  display ascii or special character  ------------
                                        ; *(ptr+2) = x
                                        ; *(ptr+3) = y
        LD  [IX+1],A                    ; *(ptr+1) = *str
        SUB A,A
        LD  [IX],A                      ; *ptr = \0

        LD  A,[IX+2]                    ; x
        CP  A,#LCDXmax-CStdAscXSize+2
        JRS NC,DSPSTRERR2               ; if (x > LCDxmax-(AscXsize-1) -> error2

        CARL    _disp_charY8            ; display one character
        JRL C,DSPSTRERR1                ; c = 1 -> error1

        INC IY
        LD  A,[IX+2]
        ADD A,#CStdAscXSize
        LD  [IX+2],A                    ; x+=AscXsize
    JRS DSPSTRLOOP                  ; }

    ;-------------------  OK  -------------------------------------------------
DSPSTROK:
    LD  [IX],IY                     ; str++
    M_CLC                           ; C = 0 (ret character transfer OK)
    M_CLZ                           ; Z = 0 (ret no area overflow)
    JRS DSPSTREND

    ;-------------------  NG  -------------------------------------------------
DSPSTRERR1:                     ; character translation error
    LD  [IX],IY                     ; str++
    M_SEC                           ; C = 1 (ret NG)
    M_CLZ                           ; Z = 0
    JRS DSPSTREND

DSPSTRERR2:                     ; area overflow error
    LD  [IX],IY                     ; str++
    M_CLC                           ; C = 0
    M_SEZ                           ; Z = 1 (ret NG)

    ;-------------------  end procedure  ------------------------------------
DSPSTREND:
        ;--------------------  return the registers  --------------------------
    POP IY
    POP HL
    POP BA

    RET


;##############################################################################
; display one character (y in byte)
;   input       [IX]   :character code upper byte
;               [IX+1] :character code lower byte
;               [IX+2] :x position (in dot) 
;               [IX+3] :y position (in byte)
;   output      C flag :0 OK
;                       1 NG
;   destroyed   none (including buffer contents)
;   subroutine test     takeda          Nov.30th,'98
;##############################################################################
_disp_charY8:
    ;--------------------  store the registers  -------------------------------
    PUSH    BA
    PUSH    HL
    PUSH    IY
                        ; IX pointer to work buffer

    ;--------------------  check y position  ----------------------------------
    LD  A,[IX+3]
    CP  A,#CY8MaxY+1
    JRL NC,DPCHRERR             ; if (y>=0 && y<=ymax){

        ;--------------------  check character code  --------------------------

        LD  A,[IX+1]                ; charL
        SUB A,#30h
        CP  A,#3Bh-30h
        JRL NC,DPCHRERR             ; if (chrcode is available area){

            ;--------------------  translation source address  ------------
            LD  L,#ChrDPthStdAsc        ; data pitch of standard ascii code table
            MLT
            LD  IY,#CHR0_12h
            ADD IY,HL                   ; IY = Source address

            ;--------------------  check x position  ----------------------
            LD  B,#CStdAsc16XSize-1     ; B = counter number
            LD  A,[IX+2]                ; A = x position                                    ; }
                                ; }

    ;====================  translate char data to vram  =======================
    ;--------------------  translate data to MCU Vram  ------------------------
                                ; IY = Source address
                                ; A = x
                                ; B = i (counter)
    CARL    DPCHR16SUB_MCU

    LD  [HL],#0                 ; sepalation

    ;--------------------  translation is succeed  ----------------------------
    DPCHROK:
    M_CLC                       ; C = 0 (ret OK)
    JRS DPCHREND

    ;--------------------  translation error  ---------------------------------
    DPCHRERR:
    M_SEC                       ; C = 1 (ret NG)

    ;--------------------  translation end  -----------------------------------
    DPCHREND:
        ;--------------------  return the registers  --------------------------
    POP IY
    POP HL
    POP BA

    RET
;=======================< subroutine for DPCHAR16 routine >======================
    ;-------------------  translation data to MCU vram  -----------------------
    ;*  input       IY = Source address
    ;*               A = x
    ;*               B = i (counter)
    ;*  destroyed   BA,HL,IY register
    ;--------------------------------------------------------------------------
GLOBAL DPCHR16SUB_MCU
    DPCHR16SUB_MCU:
    PUSH    B                                                       ; PUSH i
    LD  L,A                     ; L = x
    LD  BA,#McuVramSttAd        ; MCU Vram start address
    EX  A,B
    ADD A,[IX+3]
    EX  A,B                     ; BA = SttAd + y*100h
    LD  H,#0
    ADD HL,BA                   ; HL = SttAd+y*100h+x (Destination address)
    POP B                                                           ; POP i

    CP  B,#0
    JRS Z,DPCHR16SBMCU200           ; if (counter!=0){

        DPCHR16SBMCU100:                ; for (i=n;i>0;i--){
            LD  A,[IX+4]                ;draw mode
            CP  A,#0
            JRS Z,DPCHR16SBMCU150
            LD  A,[IY]
            OR  A,[HL]
            LD  [HL],A                  ; *Dst = *Src //print chr16 hi
            INC IY                      ; Src++
            LD  A,[IY]
            ADD HL,#0100h
            OR  A,[HL]
            LD  [HL],A                  ;print chr16 low
            JRS DPCHR16SBMCU155
        DPCHR16SBMCU150:
            LD  A,[IY]
            LD  [HL],A                  ; *Dst = *Src //print chr16 hi
            INC IY                      ; Src++
            LD  A,[IY]
            ADD HL,#0100h
            LD  [HL],A                  ;print chr16 low
        DPCHR16SBMCU155:
            SUB HL,#0100h
            INC IY                      ; Src++
            INC HL                      ; Dst++
            DEC B
            JRS NZ,DPCHR16SBMCU100  ; }

    DPCHR16SBMCU200:                ; }
    RET

;##############################################################################
; display Y16Dot Pattren (y in byte)
;   input           [IX]   :pointer for dot pattern (word)
;               [IX+2] :x position (in dot) 
;               [IX+3] :y position (in byte)
;               [IX+4] :draw mode 0:and 1:or
;   output      C flag :0 OK
;                       1 NG
;   destroyed   none (including buffer contents)
;   subroutine test     takeda          Nov.30th,'98
;##############################################################################
GLOBAL _disp_dotY16
_disp_dotY16:
    ;--------------------  store the registers  -------------------------------
    PUSH    BA
    PUSH    HL
    PUSH    IY
                        ; IX pointer to work buffer

    ;--------------------  check y position  ----------------------------------
    LD  A,[IX+3]
    CP  A,#CY16MaxY+1
    JRL NC,DPDOT16ERR               ; if (y>=0 && y<=ymax){

        ;--------------------  check character code  --------------------------

        LD  HL,[IX]

        LD  IY,HL               ;IY = Source address

        ;--------------------  check x position  ----------------------
        LD  B,#CStdAsc16XSize-1     ; B = counter number
        LD  A,[IX+2]                ; A = x position


    ;====================  translate char data to vram  =======================
    ;--------------------  translate data to MCU Vram  ------------------------
    CARL    DPCHR16SUB_MCU

    LD  [HL],#0                 ; sepalation



    ;--------------------  translation is succeed  ----------------------------
    DPDOT16OK:
    M_CLC                       ; C = 0 (ret OK)
    JRS DPDOT16END

    ;--------------------  translation error  ---------------------------------
    DPDOT16ERR:
    M_SEC                       ; C = 1 (ret NG)

    ;--------------------  translation end  -----------------------------------
    DPDOT16END:
        ;--------------------  return the registers  --------------------------
    POP IY
    POP HL
    POP BA

    RET

;#############################################################################
; change clock 1 to 3
;   input     : none
;   output    : none
;   destroyed : none
;#############################################################################
GLOBAL  _k_osc_1to3
_k_osc_1to3:

    ;----------------------  check OSC setting  -------------------------------
    M_IO_BIT    CLKCHG_IOR,CLKCHG_BIT   ; OSC setting check
    JRS Z,KOscLh100
        RET                             ; if (OSC is OSC3) -> end
    KOscLh100:

    ;----------------------  save register  -----------------------------------
    PUSH    SC
    PUSH    A
    OR  SC,#11000000B                   ; forbit all interrupt
    M_IO_BSET   VDCn_IOR,VDC1_BIT       ; change to high mode
    KOscLh300:                          ; }

    ;----------------------  wait 5 msec  -------------------------------------
    LD  A,#5*4-7                        ; 5 msec
    CARS    CLKWAIT                     ; software wait

    ;----------------------  OSC3 on  -----------------------------------------
    M_IO_BSET   OSCC_IOR,OSCC_BIT       ; OSC3 osclation on

    ;----------------------  wait 5 or 20 msec  -------------------------------
    LD  A,#15*4-7                       ; crystal

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

CLKWAIT:
    DEC A                       ; 2 cycle
    JRS NZ,CLKWAIT              ; 2 cycle
    RET


;#############################################################################
; unused interrupt
;   input     : none
;   output    : none
;   destroyed : none
;#############################################################################
GLOBAL  int_dummy
int_dummy:

    RETE

DEFSECT ".table",CODE
SECT    ".table"

;-------------------
initdispdata:   ASCIZ   '00:00:00'

clockdisppos:   DB  0,6,18,24,36,42
_dispdata1: DW  CHR0_12u,CHR0_11u,CHR0_10u,CHR0_9u,CHR0_8u,CHR0_7u,CHR0_6u,CHR0_5u,CHR0_4u,CHR0_3u,CHR0_2u,CHR0_1u,CHR_CLS
        DW  CHR1_12u,CHR1_11u,CHR1_10u,CHR1_9u,CHR1_8u,CHR1_7u,CHR1_6u,CHR1_5u,CHR1_4u,CHR1_3u,CHR1_2u,CHR1_1u,CHR_CLS
        DW  CHR2_12u,CHR2_11u,CHR2_10u,CHR2_9u,CHR2_8u,CHR2_7u,CHR2_6u,CHR2_5u,CHR2_4u,CHR2_3u,CHR2_2u,CHR2_1u,CHR_CLS
        DW  CHR3_12u,CHR3_11u,CHR3_10u,CHR3_9u,CHR3_8u,CHR3_7u,CHR3_6u,CHR3_5u,CHR3_4u,CHR3_3u,CHR3_2u,CHR3_1u,CHR_CLS
        DW  CHR4_12u,CHR4_11u,CHR4_10u,CHR4_9u,CHR4_8u,CHR4_7u,CHR4_6u,CHR4_5u,CHR4_4u,CHR4_3u,CHR4_2u,CHR4_1u,CHR_CLS
        DW  CHR5_12u,CHR5_11u,CHR5_10u,CHR5_9u,CHR5_8u,CHR5_7u,CHR5_6u,CHR5_5u,CHR5_4u,CHR5_3u,CHR5_2u,CHR5_1u,CHR_CLS
        DW  CHR6_12u,CHR6_11u,CHR6_10u,CHR6_9u,CHR6_8u,CHR6_7u,CHR6_6u,CHR6_5u,CHR6_4u,CHR6_3u,CHR6_2u,CHR6_1u,CHR_CLS
        DW  CHR7_12u,CHR7_11u,CHR7_10u,CHR7_9u,CHR7_8u,CHR7_7u,CHR7_6u,CHR7_5u,CHR7_4u,CHR7_3u,CHR7_2u,CHR7_1u,CHR_CLS
        DW  CHR8_12u,CHR8_11u,CHR8_10u,CHR8_9u,CHR8_8u,CHR8_7u,CHR8_6u,CHR8_5u,CHR8_4u,CHR8_3u,CHR8_2u,CHR8_1u,CHR_CLS
        DW  CHR9_12u,CHR9_11u,CHR9_10u,CHR9_9u,CHR9_8u,CHR9_7u,CHR9_6u,CHR9_5u,CHR9_4u,CHR9_3u,CHR9_2u,CHR9_1u,CHR_CLS
_dispdata2: DW  CHR_CLS,CHR0_1h,CHR0_2h,CHR0_3h,CHR0_4h,CHR0_5h,CHR0_6h,CHR0_7h,CHR0_8h,CHR0_9h,CHR0_10h,CHR0_11h,CHR0_12h
        DW  CHR_CLS,CHR1_1h,CHR1_2h,CHR1_3h,CHR1_4h,CHR1_5h,CHR1_6h,CHR1_7h,CHR1_8h,CHR1_9h,CHR1_10h,CHR1_11h,CHR1_12h
        DW  CHR_CLS,CHR2_1h,CHR2_2h,CHR2_3h,CHR2_4h,CHR2_5h,CHR2_6h,CHR2_7h,CHR2_8h,CHR2_9h,CHR2_10h,CHR2_11h,CHR2_12h
        DW  CHR_CLS,CHR3_1h,CHR3_2h,CHR3_3h,CHR3_4h,CHR3_5h,CHR3_6h,CHR3_7h,CHR3_8h,CHR3_9h,CHR3_10h,CHR3_11h,CHR3_12h
        DW  CHR_CLS,CHR4_1h,CHR4_2h,CHR4_3h,CHR4_4h,CHR4_5h,CHR4_6h,CHR4_7h,CHR4_8h,CHR4_9h,CHR4_10h,CHR4_11h,CHR4_12h
        DW  CHR_CLS,CHR5_1h,CHR5_2h,CHR5_3h,CHR5_4h,CHR5_5h,CHR5_6h,CHR5_7h,CHR5_8h,CHR5_9h,CHR5_10h,CHR5_11h,CHR5_12h
        DW  CHR_CLS,CHR6_1h,CHR6_2h,CHR6_3h,CHR6_4h,CHR6_5h,CHR6_6h,CHR6_7h,CHR6_8h,CHR6_9h,CHR6_10h,CHR6_11h,CHR6_12h
        DW  CHR_CLS,CHR7_1h,CHR7_2h,CHR7_3h,CHR7_4h,CHR7_5h,CHR7_6h,CHR7_7h,CHR7_8h,CHR7_9h,CHR7_10h,CHR7_11h,CHR7_12h
        DW  CHR_CLS,CHR8_1h,CHR8_2h,CHR8_3h,CHR8_4h,CHR8_5h,CHR8_6h,CHR8_7h,CHR8_8h,CHR8_9h,CHR8_10h,CHR8_11h,CHR8_12h
        DW  CHR_CLS,CHR9_1h,CHR9_2h,CHR9_3h,CHR9_4h,CHR9_5h,CHR9_6h,CHR9_7h,CHR9_8h,CHR9_9h,CHR9_10h,CHR9_11h,CHR9_12h

CHR0_12u:   DB  0f0h,03fh,008h,058h,088h,047h,068h,040h,0f0h,03fh   ; 0(u12)
CHR1_12u:   DB  000h,000h,010h,040h,0f8h,07fh,000h,040h,000h,000h   ; 1(u12)
CHR2_12u:   DB  0f0h,070h,008h,048h,008h,044h,008h,042h,0f0h,041h   ; 2
CHR3_12u:   DB  030h,030h,008h,040h,008h,041h,008h,041h,0f0h,03eh   ; 3
CHR4_12u:   DB  000h,01ch,080h,013h,070h,010h,0f8h,07fh,000h,010h   ; 4
CHR5_12u:   DB  0f8h,031h,008h,041h,008h,041h,008h,041h,008h,03eh   ; 5
CHR6_12u:   DB  0f0h,03fh,008h,041h,008h,041h,008h,041h,030h,03eh   ; 6
CHR7_12u:   DB  008h,000h,008h,000h,008h,07ch,088h,003h,078h,000h   ; 7
CHR8_12u:   DB  0f0h,03eh,008h,041h,008h,041h,008h,041h,0f0h,03eh   ; 8
CHR9_12u:   DB  0f0h,030h,008h,041h,008h,041h,008h,041h,0f0h,03fh   ; 9
CHR0_11u:   DB  0e0h,07fh,010h,030h,010h,00fh,0d0h,000h,0e0h,07fh   ; 0(u11)
CHR1_11u:   DB  000h,000h,020h,000h,0f0h,07fh,000h,000h,000h,000h   ; 1(u11)
CHR2_11u:   DB  0e0h,061h,010h,010h,010h,008h,010h,004h,0e0h,003h   ; 2
CHR3_11u:   DB  060h,060h,010h,000h,010h,002h,010h,002h,0e0h,07dh   ; 3
CHR4_11u:   DB  000h,038h,000h,027h,0e0h,020h,0f0h,07fh,000h,020h   ; 4
CHR5_11u:   DB  0f0h,063h,010h,002h,010h,002h,010h,002h,010h,07ch
CHR6_11u:   DB  0e0h,07fh,010h,002h,010h,002h,010h,002h,060h,07ch
CHR7_11u:   DB  010h,000h,010h,000h,010h,078h,010h,007h,0f0h,000h   ; 7
CHR8_11u:   DB  0e0h,07dh,010h,002h,010h,002h,010h,002h,0e0h,07dh   ; 8
CHR9_11u:   DB  0e0h,061h,010h,002h,010h,002h,010h,002h,0e0h,07fh   ; 9
CHR0_10u:   DB  0c0h,07fh,020h,060h,020h,01eh,0a0h,001h,0c0h,07fh   ; 0(u10)
CHR1_10u:   DB  000h,000h,040h,000h,0e0h,07fh,000h,000h,000h,000h   ; 1(u10)
CHR2_10u:   DB  0c0h,043h,020h,020h,020h,010h,020h,008h,0c0h,007h
CHR3_10u:   DB  0c0h,040h,020h,000h,020h,004h,020h,004h,0c0h,07bh
CHR4_10u:   DB  000h,070h,000h,04eh,0c0h,041h,0e0h,07fh,000h,040h
CHR5_10u:   DB  0e0h,047h,020h,004h,020h,004h,020h,004h,020h,078h
CHR6_10u:   DB  0c0h,07fh,020h,004h,020h,004h,020h,004h,0c0h,078h
CHR7_10u:   DB  020h,000h,020h,000h,020h,070h,020h,00eh,0e0h,001h
CHR8_10u:   DB  0c0h,07bh,020h,004h,020h,004h,020h,004h,0c0h,07bh
CHR9_10u:   DB  0c0h,043h,020h,004h,020h,004h,020h,004h,0c0h,07fh
CHR0_9u:    DB  080h,07fh,040h,040h,040h,03ch,040h,003h,080h,07fh   ; 0(u9)
CHR1_9u:    DB  000h,000h,080h,000h,0c0h,07fh,000h,000h,000h,000h   ; 1(u9)
CHR2_9u:    DB  080h,007h,040h,040h,040h,020h,040h,010h,080h,00fh
CHR3_9u:    DB  080h,001h,040h,000h,040h,008h,040h,008h,080h,077h
CHR4_9u:    DB  000h,060h,000h,01ch,080h,003h,0c0h,07fh,000h,000h
CHR5_9u:    DB  0c0h,00fh,040h,008h,040h,008h,040h,008h,040h,070h
CHR6_9u:    DB  080h,07fh,040h,008h,040h,008h,040h,008h,080h,071h
CHR7_9u:    DB  040h,000h,040h,000h,040h,060h,040h,01ch,0c0h,003h
CHR8_9u:    DB  080h,077h,040h,008h,040h,008h,040h,008h,080h,077h
CHR9_9u:    DB  080h,007h,040h,008h,040h,008h,040h,008h,080h,07fh
CHR0_8u:    DB  000h,07fh,080h,000h,080h,078h,080h,006h,000h,07fh   ; 0(u8)
CHR1_8u:    DB  000h,000h,000h,001h,080h,07fh,000h,000h,000h,000h   ; 1(u8)
CHR2_8u:    DB  000h,00fh,080h,000h,080h,040h,080h,020h,000h,01fh
CHR3_8u:    DB  000h,003h,080h,000h,080h,010h,080h,010h,000h,06fh
CHR4_8u:    DB  000h,040h,000h,038h,000h,007h,080h,07fh,000h,000h
CHR5_8u:    DB  080h,01fh,080h,010h,080h,010h,080h,010h,080h,060h
CHR6_8u:    DB  000h,07fh,080h,010h,080h,010h,080h,010h,000h,063h
CHR7_8u:    DB  080h,000h,080h,000h,080h,040h,080h,038h,080h,007h
CHR8_8u:    DB  000h,06fh,080h,010h,080h,010h,080h,010h,000h,06fh
CHR9_8u:    DB  000h,00fh,080h,010h,080h,010h,080h,010h,000h,07fh
CHR0_7u:    DB  000h,07eh,000h,001h,000h,071h,000h,00dh,000h,07eh   ; 0(u7)
CHR1_7u:    DB  000h,000h,000h,002h,000h,07fh,000h,000h,000h,000h   ; 1(u7)
CHR2_7u:    DB  000h,01eh,000h,001h,000h,001h,000h,041h,000h,03eh
CHR3_7u:    DB  000h,006h,000h,001h,000h,021h,000h,021h,000h,05eh
CHR4_7u:    DB  000h,000h,000h,070h,000h,00eh,000h,07fh,000h,000h
CHR5_7u:    DB  000h,03fh,000h,021h,000h,021h,000h,021h,000h,041h
CHR6_7u:    DB  000h,07eh,000h,021h,000h,021h,000h,021h,000h,046h
CHR7_7u:    DB  000h,001h,000h,001h,000h,001h,000h,071h,000h,00fh
CHR8_7u:    DB  000h,05eh,000h,021h,000h,021h,000h,021h,000h,05eh
CHR9_7u:    DB  000h,01eh,000h,021h,000h,021h,000h,021h,000h,07eh
CHR0_6u:    DB  000h,07ch,000h,002h,000h,062h,000h,01ah,000h,07ch   ; 0(u6)
CHR1_6u:    DB  000h,000h,000h,004h,000h,07eh,000h,000h,000h,000h   ; 1(u6)
CHR2_6u:    DB  000h,03ch,000h,002h,000h,002h,000h,002h,000h,07ch
CHR3_6u:    DB  000h,00ch,000h,002h,000h,042h,000h,042h,000h,03ch
CHR4_6u:    DB  000h,000h,000h,060h,000h,01ch,000h,07eh,000h,000h
CHR5_6u:    DB  000h,07eh,000h,042h,000h,042h,000h,042h,000h,002h
CHR6_6u:    DB  000h,07ch,000h,042h,000h,042h,000h,042h,000h,00ch
CHR7_6u:    DB  000h,002h,000h,002h,000h,002h,000h,062h,000h,01eh
CHR8_6u:    DB  000h,03ch,000h,042h,000h,042h,000h,042h,000h,03ch
CHR9_6u:    DB  000h,03ch,000h,042h,000h,042h,000h,042h,000h,07ch
CHR0_5u:    DB  000h,078h,000h,004h,000h,044h,000h,034h,000h,078h   ; 0(u5)
CHR1_5u:    DB  000h,000h,000h,008h,000h,07ch,000h,000h,000h,000h   ; 1(u5)
CHR2_5u:    DB  000h,078h,000h,004h,000h,004h,000h,004h,000h,078h
CHR3_5u:    DB  000h,018h,000h,004h,000h,004h,000h,004h,000h,078h
CHR4_5u:    DB  000h,000h,000h,040h,000h,038h,000h,07ch,000h,000h
CHR5_5u:    DB  000h,07ch,000h,004h,000h,004h,000h,004h,000h,004h
CHR6_5u:    DB  000h,078h,000h,004h,000h,004h,000h,004h,000h,018h
CHR7_5u:    DB  000h,004h,000h,004h,000h,004h,000h,044h,000h,03ch
CHR8_5u:    DB  000h,078h,000h,004h,000h,004h,000h,004h,000h,078h
CHR9_5u:    DB  000h,078h,000h,004h,000h,004h,000h,004h,000h,078h
CHR0_4u:    DB  000h,070h,000h,008h,000h,008h,000h,068h,000h,070h   ; 0(u4)
CHR1_4u:    DB  000h,000h,000h,010h,000h,078h,000h,000h,000h,000h   ; 1(u4)
CHR2_4u:    DB  000h,070h,000h,008h,000h,008h,000h,008h,000h,070h
CHR3_4u:    DB  000h,030h,000h,008h,000h,008h,000h,008h,000h,070h
CHR4_4u:    DB  000h,000h,000h,000h,000h,070h,000h,078h,000h,000h
CHR5_4u:    DB  000h,078h,000h,008h,000h,008h,000h,008h,000h,008h
CHR6_4u:    DB  000h,070h,000h,008h,000h,008h,000h,008h,000h,030h
CHR7_4u:    DB  000h,008h,000h,008h,000h,008h,000h,008h,000h,078h
CHR8_4u:    DB  000h,070h,000h,008h,000h,008h,000h,008h,000h,070h
CHR9_4u:    DB  000h,070h,000h,008h,000h,008h,000h,008h,000h,070h
CHR0_3u:    DB  000h,060h,000h,010h,000h,010h,000h,050h,000h,060h   ; 0(u3)
CHR1_3u:    DB  000h,000h,000h,020h,000h,070h,000h,000h,000h,000h   ; 1(u3)
CHR2_3u:    DB  000h,060h,000h,010h,000h,010h,000h,010h,000h,060h
CHR3_3u:    DB  000h,060h,000h,010h,000h,010h,000h,010h,000h,060h
CHR4_3u:    DB  000h,000h,000h,000h,000h,060h,000h,070h,000h,000h
CHR5_3u:    DB  000h,070h,000h,010h,000h,010h,000h,010h,000h,010h
CHR6_3u:    DB  000h,060h,000h,010h,000h,010h,000h,010h,000h,060h
CHR7_3u:    DB  000h,010h,000h,010h,000h,010h,000h,010h,000h,070h
CHR8_3u:    DB  000h,060h,000h,010h,000h,010h,000h,010h,000h,060h
CHR9_3u:    DB  000h,060h,000h,010h,000h,010h,000h,010h,000h,060h
CHR0_2u:    DB  000h,040h,000h,020h,000h,020h,000h,020h,000h,040h   ; 0(u2)
CHR1_2u:    DB  000h,000h,000h,040h,000h,060h,000h,000h,000h,000h   ; 1(u2)
CHR2_2u:    DB  000h,040h,000h,020h,000h,020h,000h,020h,000h,040h
CHR3_2u:    DB  000h,040h,000h,020h,000h,020h,000h,020h,000h,040h
CHR4_2u:    DB  000h,000h,000h,000h,000h,040h,000h,060h,000h,000h
CHR5_2u:    DB  000h,060h,000h,020h,000h,020h,000h,020h,000h,020h
CHR6_2u:    DB  000h,040h,000h,020h,000h,020h,000h,020h,000h,040h
CHR7_2u:    DB  000h,020h,000h,020h,000h,020h,000h,020h,000h,060h
CHR8_2u:    DB  000h,040h,000h,020h,000h,020h,000h,020h,000h,040h
CHR9_2u:    DB  000h,040h,000h,020h,000h,020h,000h,020h,000h,040h
CHR0_1u:    DB  000h,000h,000h,040h,000h,040h,000h,040h,000h,000h   ; 0(u1)
CHR1_1u:    DB  000h,000h,000h,000h,000h,040h,000h,000h,000h,000h   ; 1(u1)
CHR2_1u:    DB  000h,000h,000h,040h,000h,040h,000h,040h,000h,000h
CHR3_1u:    DB  000h,000h,000h,040h,000h,040h,000h,040h,000h,000h
CHR4_1u:    DB  000h,000h,000h,000h,000h,000h,000h,040h,000h,000h
CHR5_1u:    DB  000h,040h,000h,040h,000h,040h,000h,040h,000h,040h
CHR6_1u:    DB  000h,000h,000h,040h,000h,040h,000h,040h,000h,000h
CHR7_1u:    DB  000h,040h,000h,040h,000h,040h,000h,040h,000h,040h
CHR8_1u:    DB  000h,000h,000h,040h,000h,040h,000h,040h,000h,000h
CHR9_1u:    DB  000h,000h,000h,040h,000h,040h,000h,040h,000h,000h
CHR0_1h:    DB  000h,000h,004h,000h,004h,000h,004h,000h,000h,000h   ; 0(h1)
CHR1_1h:    DB  000h,000h,004h,000h,004h,000h,004h,000h,000h,000h   ; 1(h1)
CHR2_1h:    DB  004h,000h,004h,000h,004h,000h,004h,000h,004h,000h   ; 2
CHR3_1h:    DB  000h,000h,004h,000h,004h,000h,004h,000h,000h,000h   ; 3
CHR4_1h:    DB  000h,000h,000h,000h,000h,000h,004h,000h,000h,000h   ; 4
CHR5_1h:    DB  000h,000h,004h,000h,004h,000h,004h,000h,000h,000h
CHR6_1h:    DB  000h,000h,004h,000h,004h,000h,004h,000h,000h,000h
CHR7_1h:    DB  000h,000h,000h,000h,004h,000h,000h,000h,000h,000h   ; 7
CHR8_1h:    DB  000h,000h,004h,000h,004h,000h,004h,000h,000h,000h   ; 8
CHR9_1h:    DB  000h,000h,004h,000h,004h,000h,004h,000h,000h,000h   ; 9
CHR0_2h:    DB  004h,000h,008h,000h,008h,000h,008h,000h,004h,000h   ; 0(h2)
CHR1_2h:    DB  000h,000h,008h,000h,00ch,000h,008h,000h,000h,000h   ; 1(h2)
CHR2_2h:    DB  00ch,000h,008h,000h,008h,000h,008h,000h,008h,000h
CHR3_2h:    DB  004h,000h,008h,000h,008h,000h,008h,000h,004h,000h
CHR4_2h:    DB  000h,000h,000h,000h,000h,000h,00ch,000h,000h,000h
CHR5_2h:    DB  004h,000h,008h,000h,008h,000h,008h,000h,004h,000h
CHR6_2h:    DB  004h,000h,008h,000h,008h,000h,008h,000h,004h,000h
CHR7_2h:    DB  000h,000h,000h,000h,00ch,000h,000h,000h,000h,000h
CHR8_2h:    DB  004h,000h,008h,000h,008h,000h,008h,000h,004h,000h
CHR9_2h:    DB  004h,000h,008h,000h,008h,000h,008h,000h,004h,000h
CHR0_3h:    DB  00ch,000h,014h,000h,010h,000h,010h,000h,00ch,000h   ; 0(h3)
CHR1_3h:    DB  000h,000h,010h,000h,01ch,000h,010h,000h,000h,000h   ; 1(h3)
CHR2_3h:    DB  01ch,000h,010h,000h,010h,000h,010h,000h,010h,000h
CHR3_3h:    DB  00ch,000h,010h,000h,010h,000h,010h,000h,00ch,000h
CHR4_3h:    DB  004h,000h,004h,000h,004h,000h,01ch,000h,004h,000h
CHR5_3h:    DB  00ch,000h,010h,000h,010h,000h,010h,000h,00ch,000h
CHR6_3h:    DB  00ch,000h,010h,000h,010h,000h,010h,000h,00ch,000h
CHR7_3h:    DB  000h,000h,000h,000h,01ch,000h,000h,000h,000h,000h
CHR8_3h:    DB  00ch,000h,010h,000h,010h,000h,010h,000h,00ch,000h
CHR9_3h:    DB  00ch,000h,010h,000h,010h,000h,010h,000h,00ch,000h
CHR0_4h:    DB  01ch,000h,02ch,000h,020h,000h,020h,000h,01ch,000h   ; 0(h4)
CHR1_4h:    DB  000h,000h,020h,000h,03ch,000h,020h,000h,000h,000h   ; 1(h4)
CHR2_4h:    DB  038h,000h,024h,000h,020h,000h,020h,000h,020h,000h
CHR3_4h:    DB  018h,000h,020h,000h,020h,000h,020h,000h,01ch,000h
CHR4_4h:    DB  00ch,000h,008h,000h,008h,000h,03ch,000h,008h,000h
CHR5_4h:    DB  018h,000h,020h,000h,020h,000h,020h,000h,01ch,000h
CHR6_4h:    DB  01ch,000h,020h,000h,020h,000h,020h,000h,01ch,000h
CHR7_4h:    DB  000h,000h,000h,000h,03ch,000h,000h,000h,000h,000h
CHR8_4h:    DB  01ch,000h,020h,000h,020h,000h,020h,000h,01ch,000h
CHR9_4h:    DB  018h,000h,020h,000h,020h,000h,020h,000h,01ch,000h
CHR0_5h:    DB  03ch,000h,058h,000h,044h,000h,040h,000h,03ch,000h   ; 0(h5)
CHR1_5h:    DB  000h,000h,040h,000h,07ch,000h,040h,000h,000h,000h   ; 1(h5)
CHR2_5h:    DB  070h,000h,048h,000h,044h,000h,040h,000h,040h,000h
CHR3_5h:    DB  030h,000h,040h,000h,040h,000h,040h,000h,03ch,000h
CHR4_5h:    DB  01ch,000h,010h,000h,010h,000h,07ch,000h,010h,000h
CHR5_5h:    DB  030h,000h,040h,000h,040h,000h,040h,000h,03ch,000h
CHR6_5h:    DB  03ch,000h,040h,000h,040h,000h,040h,000h,03ch,000h
CHR7_5h:    DB  000h,000h,000h,000h,07ch,000h,000h,000h,000h,000h
CHR8_5h:    DB  03ch,000h,040h,000h,040h,000h,040h,000h,03ch,000h
CHR9_5h:    DB  030h,000h,040h,000h,040h,000h,040h,000h,03ch,000h
CHR0_6h:    DB  07ch,000h,0b0h,000h,08ch,000h,080h,000h,07ch,000h   ; 0(h6)
CHR1_6h:    DB  000h,000h,080h,000h,0fch,000h,080h,000h,000h,000h   ; 1(h6)
CHR2_6h:    DB  0e0h,000h,090h,000h,088h,000h,084h,000h,080h,000h
CHR3_6h:    DB  060h,000h,080h,000h,080h,000h,080h,000h,07ch,000h
CHR4_6h:    DB  038h,000h,024h,000h,020h,000h,0fch,000h,020h,000h
CHR5_6h:    DB  060h,000h,080h,000h,080h,000h,080h,000h,07ch,000h
CHR6_6h:    DB  07ch,000h,080h,000h,080h,000h,080h,000h,07ch,000h
CHR7_6h:    DB  000h,000h,000h,000h,0f8h,000h,004h,000h,000h,000h
CHR8_6h:    DB  07ch,000h,080h,000h,080h,000h,080h,000h,07ch,000h
CHR9_6h:    DB  060h,000h,080h,000h,080h,000h,080h,000h,07ch,000h
CHR0_7h:    DB  0fch,000h,060h,001h,01ch,001h,000h,001h,0fch,000h   ; 0(h7)
CHR1_7h:    DB  000h,000h,000h,001h,0fch,001h,000h,001h,000h,000h   ; 1(h7)
CHR2_7h:    DB  0c0h,001h,020h,001h,010h,001h,008h,001h,004h,001h
CHR3_7h:    DB  0c0h,000h,000h,001h,004h,001h,004h,001h,0f8h,000h
CHR4_7h:    DB  070h,000h,04ch,000h,040h,000h,0fch,001h,040h,000h
CHR5_7h:    DB  0c4h,000h,004h,001h,004h,001h,004h,001h,0f8h,000h
CHR6_7h:    DB  0fch,000h,004h,001h,004h,001h,004h,001h,0f8h,000h
CHR7_7h:    DB  000h,000h,000h,000h,0f0h,001h,00ch,000h,000h,000h
CHR8_7h:    DB  0f8h,000h,004h,001h,004h,001h,004h,001h,0f8h,000h
CHR9_7h:    DB  0c0h,000h,004h,001h,004h,001h,004h,001h,0fch,000h
CHR0_8h:    DB  0fch,001h,0c0h,002h,03ch,002h,000h,002h,0fch,001h   ; 0(h8)
CHR1_8h:    DB  000h,000h,000h,002h,0fch,003h,000h,002h,000h,000h   ; 1(h8)
CHR2_8h:    DB  084h,003h,040h,002h,020h,002h,010h,002h,00ch,002h
CHR3_8h:    DB  080h,001h,000h,002h,008h,002h,008h,002h,0f4h,001h
CHR4_8h:    DB  0e0h,000h,09ch,000h,080h,000h,0fch,003h,080h,000h
CHR5_8h:    DB  08ch,001h,008h,002h,008h,002h,008h,002h,0f0h,001h
CHR6_8h:    DB  0fch,001h,008h,002h,008h,002h,008h,002h,0f0h,001h
CHR7_8h:    DB  000h,000h,000h,000h,0e0h,003h,01ch,000h,000h,000h
CHR8_8h:    DB  0f4h,001h,008h,002h,008h,002h,008h,002h,0f4h,001h
CHR9_8h:    DB  084h,001h,008h,002h,008h,002h,008h,002h,0fch,001h
CHR0_9h:    DB  0fch,003h,080h,005h,078h,004h,004h,004h,0fch,003h   ; 0(h9)
CHR1_9h:    DB  000h,000h,000h,004h,0fch,007h,000h,004h,000h,000h   ; 1(h9)
CHR2_9h:    DB  00ch,007h,080h,004h,040h,004h,020h,004h,01ch,004h
CHR3_9h:    DB  000h,003h,000h,004h,010h,004h,010h,004h,0ech,003h
CHR4_9h:    DB  0c0h,001h,03ch,001h,000h,001h,0fch,007h,000h,001h
CHR5_9h:    DB  01ch,003h,010h,004h,010h,004h,010h,004h,0e0h,003h
CHR6_9h:    DB  0fch,003h,010h,004h,010h,004h,010h,004h,0e0h,003h
CHR7_9h:    DB  000h,000h,000h,000h,0c0h,007h,03ch,000h,000h,000h
CHR8_9h:    DB  0ech,003h,010h,004h,010h,004h,010h,004h,0ech,003h
CHR9_9h:    DB  00ch,003h,010h,004h,010h,004h,010h,004h,0fch,003h
CHR0_10h:   DB  0fch,007h,000h,00bh,0f0h,008h,00ch,008h,0fch,007h   ; 0(h10)
CHR1_10h:   DB  000h,000h,000h,008h,0fch,00fh,000h,008h,000h,000h   ; 1(h10)
CHR2_10h:   DB  01ch,00eh,000h,009h,080h,008h,040h,008h,03ch,008h
CHR3_10h:   DB  004h,006h,000h,008h,020h,008h,020h,008h,0dch,007h
CHR4_10h:   DB  080h,003h,078h,002h,004h,002h,0fch,00fh,000h,002h
CHR5_10h:   DB  03ch,006h,020h,008h,020h,008h,020h,008h,0c0h,007h
CHR6_10h:   DB  0fch,007h,020h,008h,020h,008h,020h,008h,0c4h,007h
CHR7_10h:   DB  000h,000h,000h,000h,080h,00fh,078h,000h,004h,000h
CHR8_10h:   DB  0dch,007h,020h,008h,020h,008h,020h,008h,0dch,007h
CHR9_10h:   DB  01ch,006h,020h,008h,020h,008h,020h,008h,0fch,007h
CHR0_11h:   DB  0fch,00fh,000h,016h,0f0h,011h,00ch,010h,0fch,00fh   ; 0(h11)
CHR1_11h:   DB  000h,000h,004h,010h,0fch,01fh,000h,010h,000h,000h   ; 1(h11)
CHR2_11h:   DB  03ch,01ch,000h,012h,000h,011h,080h,010h,07ch,010h
CHR3_11h:   DB  00ch,00ch,000h,010h,040h,010h,040h,010h,0bch,00fh
CHR4_11h:   DB  000h,007h,0f0h,004h,00ch,004h,0fch,01fh,000h,004h
CHR5_11h:   DB  07ch,00ch,040h,010h,040h,010h,040h,010h,080h,00fh
CHR6_11h:   DB  0fch,00fh,040h,010h,040h,010h,040h,010h,08ch,00fh
CHR7_11h:   DB  000h,000h,000h,000h,000h,01fh,0f0h,000h,00ch,000h
CHR8_11h:   DB  0bch,00fh,040h,010h,040h,010h,040h,010h,0bch,00fh
CHR9_11h:   DB  03ch,00ch,040h,010h,040h,010h,040h,010h,0fch,00fh
CHR0_12h:   DB  0f8h,01fh,004h,02ch,0c4h,023h,034h,020h,0f8h,01fh   ; 0(h12)
CHR1_12h:   DB  000h,000h,008h,020h,0fch,03fh,000h,020h,000h,000h   ; 1(h12)
CHR2_12h:   DB  078h,038h,004h,024h,004h,022h,004h,021h,0f8h,020h   ; 2
CHR3_12h:   DB  018h,018h,004h,020h,084h,020h,084h,020h,078h,01fh   ; 3
CHR4_12h:   DB  000h,00eh,0c0h,009h,038h,008h,0fch,03fh,000h,008h   ; 4
CHR5_12h:   DB  0fch,018h,084h,020h,084h,020h,084h,020h,004h,01fh   ; 5
CHR6_12h:   DB  0f8h,01fh,084h,020h,084h,020h,084h,020h,018h,01fh   ; 6
CHR7_12h:   DB  004h,000h,004h,000h,004h,03eh,0c4h,001h,03ch,000h   ; 7
CHR8_12h:   DB  078h,01fh,084h,020h,084h,020h,084h,020h,078h,01fh   ; 8
CHR9_12h:   DB  078h,018h,084h,020h,084h,020h,084h,020h,0f8h,01fh   ; 9
CHRCRN_12:  DB  000h,000h,000h,000h,000h,033h,000h,000h,000h,000h   ; coron
CHR_CLS:    DB  000h,000h,000h,000h,000h,000h,000h,000h,000h,000h   ; CLS



;==================  valiable definition  =====================================
DEFSECT ".dataram",DATA     ;(at 0f000h)
SECT    ".dataram"

_clockdata: DS  3
_clockunpk: DS  6
_clockunpkold:  DS  6
_dispdata:  DS  9
_chrsizeptr:    DS  1
_chrptrincflag: DS  1
_work:      DS  5

;==================  Key scan =================================================
_key_sts:   DS  1


    END

