;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)divsl.asm	1.8	99/03/02
;;;
;;; AUTHORS:		Gerard Boersema		(gebo)
;;;			Peter van den Os	(petero)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_DIVSL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__DIVSL
                EXTERN  (CODE, SHORT) __DIVUL
                EXTERN  (CODE, SHORT) __NEGXL
;;;****************************************************************************
;;; 
;;; ROUTINE:            __DIVSL
;;; 
;;; AT ENTRY:           HLBA    long dividend a
;;;                     IYIX    long divisor b
;;; 
;;; AT EXIT:            HLBA    result a/b
;;;                     IYIX    remainder
;;;                     V=0
;;;                or:
;;;                     V=1     at divide by 0
;;; 
;;; DESTROYS:           
;;; 
;;; PRESERVES:          XP, YP
;;;
;;; STACK USAGE:        15 (in maximum mode 17)
;;; 
;;; DESCRIPTION:        This routine provides a divide operation for two signed 32 bits operands
;;;         
                
                            
;;; DIVIDEND -> +          |    -
;;;           +------------|--------------
;;; DIVISOR   |            |
;;;    +      | +Q  +R  (0)|    -Q  -R (3)
;;;           +------------+--------------
;;;    -      | -Q  +R  (2)|    +Q  -R (1)
;;;           |            |


_EX_HLBA_IYIX:  EX      BA, HL          ; Exchange HLBA <--> IYIX
                EX      BA, IY
                EX      BA, HL
                EX      BA, IX
                RET
                
                
__DIVSL:        PUSH    IP              ; Save XP, YP
                LD      YP, #0          ; Default: flag=(0)
check_divisor:  ADD     IY, #0          ; DIVISOR >= 0 ?
                JRS     P, check_dividend
                LD      YP, #2          ; DIVISOR < 0 -> flag=(2)
invert_divisor: CARS    _EX_HLBA_IYIX
                CARL    __NEGXL
                CARS    _EX_HLBA_IYIX
check_dividend: ADD     HL, #0          ; DIVIDEND >=0 ?
                JRS     P, divide
		PUSH	A
		LD	A, YP
                DEC     A               ; DIVIDEND < 0 -> flag=flag-1
		LD	YP, A
		POP	A
invert_dividend:CARL    __NEGXL

                
divide:         CARL    __DIVUL         ; Perform unsigned devide

check_remainder:        
                PUSH    A
                LD      A, YP
                BIT     A, #1           ; if (flag & 1)==0 ?
                POP     A
                JRS     Z, check_quotient ; then do not invert_remainder
invert_remainder:
                CARS    _EX_HLBA_IYIX
                CARL    __NEGXL
                CARS    _EX_HLBA_IYIX
                
check_quotient: PUSH    A
                LD      A, YP   
                BIT     A, #2           ; if (flag & 2)==0 ?
                POP     A
                JRS     Z, ready        ; then do not invert_quotient
invert_quotient:
                CARL    __NEGXL

ready:          POP     IP              ; restore XP, YP
                RET
                END
