;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)andxl.asm	1.6	99/01/08
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_ANDXL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__ANDXL	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __ANDXL
;;; 
;;; AT ENTRY:           HLBA    long operand a
;;;                     IYIX    long operand b
;;; 
;;; AT EXIT:            HLBA    a&b
;;;                     
;;; DESTROYS:           -
;;; 
;;; PRESERVES:          IYIX
;;;
;;; STACK USAGE:        8 (in maximum mode 9)
;;; 
;;; DESCRIPTION:        This routine provides a 32 bit bitwise and operation
;;; 

	EXTERN (DATA) __lc_es
	
__ANDXL:	PUSH	EP
		PUSH    HL              ; Move operand a to stack
                PUSH    BA
		LD	EP, #@dpag(__lc_es-1) ; Stack is in page zero
                LD      HL, SP          ; Set SP-->lowest byte
                
                LD      BA, IX
                AND     A, [HL]         ; &IX.low_byte
                INC     HL
                EX      A, B    
                AND     A, [HL]         ; &IX.high_byte
                INC     HL
                EX      A, B
                PUSH    BA              ; Save result
                
                LD      BA, IY
                AND     A, [HL]         ; &IY.low_byte
                INC     HL
                EX      A, B    
                AND     A, [HL]         ; &IY.high_byte
                EX      A, B
                LD      HL, BA
               
                POP     BA              ; Get result low part
                ADD     SP, #4          ; Free stack space
		POP	EP
                
EXIT:           RET
                END
