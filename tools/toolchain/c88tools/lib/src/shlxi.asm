;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)shlxi.asm	1.6	96/10/16
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_SHLXI"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__SHLXI
;;;****************************************************************************
;;; 
;;; ROUTINE:            __SHLXI
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
;;; DESCRIPTION:        This routine provides a shift-left for signed/unsigned
;;;                     integers (a<<3)
;;; 

__SHLXI:	CP	L, #0                               ; Check for zero-shift
		JRS	Z, EXIT
	
SHIFT_LOOP:	SLA	A                                   ; Shift low-byte 
		RL	B                                   ; Shift high-byte
		DEC	L
		JRS	NZ, SHIFT_LOOP

EXIT:		RET
