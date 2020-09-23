;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)divsi.asm	1.7	99/04/02
;;;
;;; AUTHORS:		Gerard Boersema		(gebo)
;;;			Peter van den Os	(petero)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_DIVSI"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__DIVSI
                EXTERN  (CODE, SHORT) __DIVUI
;;;****************************************************************************
;;; 
;;; ROUTINE:            __DIVSI
;;; 
;;; AT ENTRY:           IX      integer dividend a
;;;                     IY      integer divisor b
;;; 
;;; AT EXIT:            HL      quotient a/b
;;;                     BA      remainder
;;;                     V=0
;;;                or:
;;;                     V=1     at divide by 0
;;; 
;;; DESTROYS:
;;; 
;;; PRESERVES:          
;;;
;;; STACK USAGE:        10 (in maximum mode 12)
;;; 
;;; DESCRIPTION:        This routine provides a divide operation for two signed 16 bits operands
;;;         
                
                            
;;; DIVIDEND -> +          |    -
;;;           +------------|--------------
;;; DIVISOR   |            |
;;;    +      | +Q  +R  (0)|    -Q  -R (3)
;;;           +------------+--------------
;;;    -      | -Q  +R  (2)|    +Q  -R (1)
;;;           |            |

__DIVSI:	PUSH	IP		; save XP, YP
		LD      L, #0           ; Default: flag=(0)			
check_divisor:  ADD     IY, #0          ; DIVISOR >= 0 ?
                JRS     P, check_dividend
                LD      L, #2           ; DIVISOR < 0 -> flag=(2)		
invert_divisor: LD      BA, #0
                SUB     BA, IY
                LD      IY, BA
check_dividend: ADD     IX, #0          ; DIVIDEND >=0 ?
                JRS     P, divide
                DEC     L               ; DIVIDEND < 0 -> flag=flag-1		
invert_dividend:LD      BA, #0
                SUB     BA, IX
                LD      IX, BA

                
divide:         LD	A, L
		LD	YP, A
		CARL    __DIVUI         ; Perform unsigned devide

check_remainder:        
                PUSH    A
                LD      A, YP		;					
                BIT     A, #1           ; if (flag & 1)==0 ?
                POP     A
                JRS     Z, check_quotient ; then do not invert_remainder
invert_remainder:
                LD      IX, #0
                SUB     IX, BA
                LD      BA, IX
                
check_quotient: PUSH    A
                LD      A, YP		;					   
                BIT     A, #2           ; if (flag & 2)==0 ?
                POP     A
                JRS     Z, ready        ; then do not invert_quotient
invert_quotient:
                LD      IX, #0
                SUB     IX, HL
                LD      HL, IX
                
ready:          POP	IP		; restore XP, YP
		RET
                END
