INCLUDE 'k_348ior.inc'
INCLUDE 'k_disply.inc'
INCLUDE 's_system.inc'

EXTERN  __lc_es
DEFSECT ".vecter",CODE  AT 0000h
SECT    ".vecter"

;------------------  GENERAL INTERRUPT  ---------------------------------------
    DW  __START         ; 0000h reset
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
    LD  [BR:00h],#0                 ; single chip mode
                                    ; /CE0,/CE1,/CE2,/CE3:disenabled

    ;---------------  stack pointer page address  -----------------------------
    LD  [BR:01h],#@DPAG(__lc_es-1)        ; set stack pointer page

    ;--------------  bus and clock control  -----------------------------------
    LD  [BR:02h],#0                     ; clock = OSC1
                                        ; OSC3off
                                        ; normal power mode

    ;----------------------  set I/O register  --------------------------------
    ;<display>
    M_IO_BCLR   DTFNT_IOR,DTFNT_BIT     ; 5 x 8 dot font
    M_IO_BCLR   LDUTY_IOR,LDUTY_BIT     ; 1/32 duty

    M_IO_BCLR   DSPAR_IOR,DSPAR_BIT     ; area 0
    M_IO_BCLR   LCDCn_IOR,LCDC1_BIT     ; normal display
    M_IO_BSET   LCDCn_IOR,LCDC0_BIT

;#######################  conditional assemble  ###############################
IF CA_ICE                                               ; ICE
    M_IO_BSET   LCn_IOR,LC3_BIT|LC2_BIT|LC1_BIT|LC0_BIT ;initial contrast = F

    ;##########################################################################
ELSE                                                    ; not ICE
    M_IO_BCLR   LCn_IOR,LC3_BIT                         ; initial contrast = 7
    M_IO_BSET   LCn_IOR,LC2_BIT|LC1_BIT|LC0_BIT

ENDIF
;##############################################################################

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

    LD  HL,#_dispdata+2
    LD  [HL],#":"
    LD  HL,#_dispdata+5
    LD  [HL],#":"

    ;<all interrupt enable>
    AND SC,#00111111b               ; all interrupt enable


;******************************************************************************
;***********************  Main Loop  ******************************************
;******************************************************************************
MainLoop:
    ;<reset WDT>
    OR  [BR:WDRST_IOR],#WDRST_BIT

    ;<Halt>
    HALT

    ;<make display data>
    LD  IX,#_clockdata                  ; source address
    LD  IY,#_dispdata                   ; destination address

    LD  A,[IX]                          ; hour
    UPCK                                ; B=h10, A=h1
    ADD BA,#3030h                       ; change to ASCII code
    LD  [IY],B                          ; h10
    LD  [IY+1],A                        ; h1

    LD  A,[IX+1]                        ; minute
    UPCK                                ; B=m10, A=m1
    ADD BA,#3030h                       ; change to ASCII code
    LD  [IY+3],B                        ; m10
    LD  [IY+4],A                        ; m1

    LD  A,[IX+2]                        ; second
    UPCK                                ; B=s10, A=s1
    ADD BA,#3030h                       ; change to ASCII code
    LD  [IY+6],B                        ; s10
    LD  [IY+7],A                        ; s1

    ;<display clock data>
    SUB SP,#4                           ; SP-=4
    LD  IX,SP

    LD  BA,#_dispdata
    LD  [IX],BA                         ; pointer for string
    LD  A,#0
    LD  [IX+2],A                        ; x position
    LD  A,#0
    LD  [IX+3],A                        ; y position
    CARL    _disp_stringY8              ; display message

    ADD SP,#4                           ; SP+=4

    JRS MainLoop



;#############################################################################
;<interrupt> realtime clock
;   input     : none
;   output    : none
;   destroyed : none
;#############################################################################
int_clock:
    ;----------------------  keep register data  ------------------------------
    PUSH    HL

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
        ADD [HL],#1                     ; increment minute                      ; decimal calculation
        CP  [HL],#60h                                                           ; BCD code
        JRL C,INTCLKEND                 ; if (minute>=60){
            LD  [HL],#0                     ; minute = 0
            ;------------------------  hour increment  ------------------------
            DEC HL
            ADD [HL],#1                     ; increment hour                    ; decimal calculation
            CP  [HL],#24h                                                       ; BCD code
            JRL C,INTCLKEND                 ; if (hour>=24){
                LD  [HL],#0                     ; hour = 0
                                            ; }
                                        ; }
                                    ; }

    ;----------------------  end procedure  -----------------------------------
INTCLKEND:
    M_CLD                               ; normal operation

    ;----------------------  return register data  ----------------------------
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
            LD  L,#5                ; data pitch of standard ascii code table
            MLT
            LD  IY,#ChrFontAscii
            ADD IY,HL                   ; IY = Source address

            ;--------------------  check x position  ----------------------
            LD  B,#CStdAscXSize-1       ; B = counter number
            LD  A,[IX+2]                ; A = x position
                                    ; }
                                ; }

    ;====================  translate char data to vram  =======================
    ;--------------------  translate data to MCU Vram  ------------------------
                                ; IY = Source address
                                ; A = x
                                ; B = i (counter)
    CARL    DPCHRSUB_MCU

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

;=======================< subroutine for DPCHAR routine >======================
    ;-------------------  translation data to MCU vram  -----------------------
    ;*  input       IY = Source address
    ;*               A = x
    ;*               B = i (counter)
    ;*  destroyed   BA,HL,IY register
    ;--------------------------------------------------------------------------
    DPCHRSUB_MCU:
    PUSH    B                   ; PUSH i
    LD  L,A                     ; L = x
    LD  BA,#McuVramSttAd        ; MCU Vram start address
    EX  A,B
    ADD A,[IX+3]
    EX  A,B                     ; BA = SttAd + y*100h
    LD  H,#0
    ADD HL,BA                   ; HL = SttAd+y*100h+x (Destination address)
    POP B                       ; POP i

    CP  B,#0
    JRS Z,DPCHRSBMCU200         ; if (counter!=0){

        DPCHRSBMCU100:              ; for (i=n;i>0;i--){
            LD  A,[IY]
            LD  [HL],A                  ; *Dst = *Src
            INC IY                      ; Src++
            INC HL                      ; Dst++
            DEC B
            JRS NZ,DPCHRSBMCU100    ; }

    DPCHRSBMCU200:              ; }
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
;------------------  1byte character bitmap table (8x6 type) ------------------
    ;------------------  ascii code  ------------------------------------------
ChrFontAscii:   DB  3eh,51h,49h,45h,3eh     ; 0 30
                DB  00h,42h,7fh,40h,00h     ; 1 31
                DB  42h,61h,51h,49h,46h     ; 2 32
                DB  21h,41h,45h,4bh,31h     ; 3 33
                DB  18h,14h,12h,7fh,10h     ; 4 34
                DB  27h,45h,45h,45h,39h     ; 5 35
                DB  3ch,4ah,49h,49h,30h     ; 6 36
                DB  01h,71h,09h,05h,03h     ; 7 37
                DB  36h,49h,49h,49h,36h     ; 8 38
                DB  06h,49h,49h,29h,1eh     ; 9 39
                DB  00h,36h,36h,00h,00h     ; : 3A


;==================  valiable definition  =====================================
DEFSECT ".dataram",DATA     ;(at 0f000h)
SECT    ".dataram"

_clockdata: DS  3
_dispdata:  DS  9


    END
