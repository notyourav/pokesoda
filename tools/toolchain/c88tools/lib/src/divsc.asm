;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)divsc.asm	1.3	98/01/21
;;;
;;; AUTHORS:		Gerard Boersema		(gebo)
;;;			Peter van den Os	(petero)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_DIVSC"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__DIVSC
                EXTERN  (CODE, SHORT) __DIVUI
;;;****************************************************************************
;;; 
;;; ROUTINE:            __DIVSC
;;; 
;;; AT ENTRY:           B       character dividend a
;;;                     A       character divisor b
;;;                     H       #0
;;; 
;;; AT EXIT:            A       quotient a/b
;;;                     B       remainder
;;;                             At divide by 0 the zero division exception processing
;;;                             is generated
;;;                             
;;; DESTROYS:           HL
;;; 
;;; PRESERVES:          
;;;
;;; STACK USAGE:        2 ( in maximum mode 3 )
;;; 
;;; DESCRIPTION:        This routine provides a divide operation for two signed 8 bits operands
;;;         
                
                            
;;; DIVIDEND -> +          |    -
;;;           +------------|--------------
;;; DIVISOR   |            |
;;;    +      | +Q  +R  (0)|    -Q  -R (3)
;;;           +------------+--------------
;;;    -      | -Q  +R  (2)|    +Q  -R (1)
;;;           |            |

__DIVSC:      	PUSH 	H
		OR	B, #0			; Check divisor
		JRS	P,  store_dividend	; DIVIDEND >=0 ?
		NEG	B			; Invert dividend
		DEC	H			; DIVIDEND < 0 -> flag=flag-1
store_dividend:	LD	L,  B			; Store dividend
		ADD     A,  #0          	; Check divisor
                JRS     P, divide		; DIVISOR >= 0 ?
                INC     H          		; DIVISOR < 0 -> flag=flag+2
		INC	H			;
		NEG     A			; Invert divisor
divide:         LD	B, H
		POP	H
		DIV                     	; Perform unsigned divide
                
                BIT     B, #1           	; if (flag & 1)==0 ?
                LD      B, H			; 
                JRS     Z, check_quotient 	; then do nothing
                NEG     B			; else invert remainder
check_quotient: BIT     A, #2           	; if (flag & 2)==0 ?
                LD      A, L			; 
                JRS     Z, ready        	; then do nothing
                NEG     A			; else invert quotient
                                
ready:       	RET
                END
