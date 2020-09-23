;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)mulxi.asm	1.4	99/03/02
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_MULXI"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__MULXI
;;;****************************************************************************
;;; 
;;; ROUTINE:            __MULXI
;;; 
;;; AT ENTRY:           IX      integer operand a
;;;                     IY      integer operand b
;;; 
;;; AT EXIT:            BA      result a*b
;;; 
;;; DESTROYS:           HL
;;; 
;;; PRESERVES:          -
;;;
;;; STACK USAGE:        3 (in maximum mode 4)
;;; 
;;; DESCRIPTION:        This routine provides a 16 bit multiplication
;;;                     
;;; 

;;;             a       b
;;;             1       2       x
;;;             =========
;;;             m       n
;;; Step1.      2a  <-- 2b
;;; Step2.      +1b 
;;;
;;;             Mapping:        ab->IX
;;;                             12->IY
;;;                             mn->XP YP


__MULXI:	PUSH	IP		; save XP, YP        
Step1:          LD      BA, IY          ; load '2' in A
                PUSH    B               ; save '1' on stack
                LD      HL, IX          ; load 'b' in L
                MLT
                EX      BA, HL                          
                LD      YP, A           ; store result in 'n', overflow stays in B

                LD      A, L            ; recall multiplier
                LD      HL, IX          ; load 'a'
                LD      L, H
                MLT
                LD      A, L
                ADD     A, B            ; add overflow
                LD      XP, A           ; store result in 'm'
                LD      B, H            ; recall overflow
                JRS     NC, Step2
                INC     B               ; correct overflow in B
                
Step2:          LD      HL, IX          ; load 'b' in L
                POP     A               ; load '1' in A
                MLT
                LD      A, XP           ; recall previous result
                LD      B, L            ; get current result
                ADD     A, B            ; add result
                
ReturnAdmin:    LD      B, A            ; store 'm'
                LD      A, YP           ; store 'n'
                
EXIT:           POP	IP		; restore XP, YP
		RET
                END
