;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)shlxl.asm	1.5	98/01/07
;;;
;;; AUTHORS:		Gerard Boersema		(gebo)
;;;			Peter van den Os	(petero)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_SHLXL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__SHLXL	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __SHLXL
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
;;; STACK USAGE:        8 (in maximum mode 9)
;;; 
;;; DESCRIPTION:        This routine provides a shift-left for signed/unsigned
;;;                     longs (a<<3)
;;; 
	
__SHLXL:	PUSH	IY
		PUSH	HL
		PUSH    IP
                POP     L               ; Dummy POP
                POP     L               ; Cheap counter register
                CP	L, #0           ; Check for zero-shift
		JRS	Z, EXIT
                                        	
SHIFT_LOOP:	SLA	A		; Shift lowest-byte
                RL      B
		LD	IY, BA
                POP     BA
                RL      A		; Shift highest-byte
		RL	B		
		PUSH	BA
                LD	BA, IY
		DEC	L
		JRS	NZ, SHIFT_LOOP

EXIT:		POP     HL              ; Get result in HL
		POP	IY
                RET
                END
