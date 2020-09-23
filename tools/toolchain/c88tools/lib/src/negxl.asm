;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)negxl.asm	1.2	96/10/16
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_NEGXL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__NEGXL	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __NEGXL
;;; 
;;; AT ENTRY:           HLBA    long operand
;;; 
;;; AT EXIT:            HLBA    2 complement result
;;; 
;;; DESTROYS:           -
;;; 
;;; PRESERVES:          -
;;;
;;; STACK USAGE:        2 (in maximum mode 3)
;;; 
;;; DESCRIPTION:        This routine provides a two complement operation for a
;;;                     long (-a)
;;; 
	
__NEGXL:	EX      BA, HL
                CPL     A
                CPL     B
                EX      BA, HL
                CPL     A
                CPL     B
                INC     BA
                JRS     NZ, EXIT
                INC     HL

EXIT:           RET
                END
