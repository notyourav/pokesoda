;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)shrsl.asm	1.4	98/01/07
;;;
;;; AUTHORS:		Gerard Boersema		(gebo)
;;;			Peter van den Os	(petero)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_SHRSL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__SHRSL	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __SHRSL
;;; 
;;; AT ENTRY:           XP      shift count
;;;                     HLBA    long operand
;;; 
;;; AT EXIT:            HLBA    shift result
;;; 
;;; DESTROYS:           -
;;; 
;;; PRESERVES:          IY, XP
;;;
;;; STACK USAGE:        5 (in maximum mode 6)
;;; 
;;; DESCRIPTION:        This routine provides a shift-right for signed
;;;                     long (a>>-3)
;;; 
	
__SHRSL:        PUSH    IY              
                PUSH    HL
		PUSH	IP
                POP     L               ; Dummy POP
                POP     L               ; Cheap counter register
                CP	L, #0           ; Check for zero-shift
		JRS	Z, EXIT

SHIFT_LOOP:	LD	IY, BA
		POP	BA
                SRA	B		; Shift highest-byte
                RR      A
		PUSH	BA
		LD	BA, IY
                RR      B
		RR	A		; Shift lowest-byte
		DEC     L
		JRS	NZ, SHIFT_LOOP

EXIT:		POP     HL              ; Get result in HL
		POP	IY
                RET
                END
