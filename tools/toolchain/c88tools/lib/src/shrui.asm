;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)shrui.asm	1.6	96/10/16
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_SHRUI"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__SHRUI	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __SHRUI
;;; 
;;; AT ENTRY:           L       shift parameter
;;;                     BA      integer operand
;;; 
;;; AT EXIT:            BA      shift result
;;; 
;;; DESTROYS:           L
;;; 
;;; PRESERVES:          -
;;;
;;; STACK USAGE:        2 (in maximum mode 3)
;;; 
;;; DESCRIPTION:        This routine provides a shift-right for unsigned
;;;                     integers (a>>3)
;;; 
	
__SHRUI:	CP	L, #0		; Check for zero-shift
		JRS	Z, EXIT
	
SHIFT_LOOP:	SRL	B		; Shift high-byte
		RR	A		; Shift low-byte
		DEC	L
		JRS	NZ, SHIFT_LOOP

EXIT:		RET
