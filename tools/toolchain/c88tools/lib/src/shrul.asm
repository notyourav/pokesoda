;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)shrul.asm	1.3	98/01/07
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_SHRUL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__SHRUL	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __SHRUL
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
;;; DESCRIPTION:        This routine provides a shift-right for unsigned
;;;                     long (a>>3)
;;; 
	
__SHRUL:	PUSH    IY	
		PUSH	HL
                PUSH    IP
                POP     L               ; Dummy POP
                POP     L               ; Cheap counter register
                CP	L, #0           ; Check for zero-shift
		JRS	Z, EXIT
                                        	
SHIFT_LOOP:	LD	IY, BA
		POP	BA
                SRL	B		; Shift highest-byte
                RR      A
                PUSH	BA
		LD	BA, IY
                RR      B
		RR	A		; Shift lowest-byte
		DEC	L
		JRS	NZ, SHIFT_LOOP

EXIT:		POP     HL              ; Get result in HL
		POP	IY
                RET
                END
