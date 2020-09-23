;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)cmpsl.asm	1.6	96/11/05
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_CMPSL"

                EXTERN (CODE, SHORT) __CMPUL

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"

                GLOBAL	__CMPSL
;;;****************************************************************************
;;; 
;;; ROUTINE:            __CMPSL
;;; 
;;; AT ENTRY:           HLBA    long operand a
;;;                     IYIX    long operand b
;;; 
;;; AT EXIT:            a==b    SC.Z == 1; SC.N=0
;;;                     a>b     SC.Z == 0; SC.N^SC.V=0
;;;                     a<b     SC.Z == 0; SC.N^SC.V=1
;;;                     
;;; DESTROYS:           B, IX
;;; 
;;; PRESERVES:          HL, A, IY
;;;
;;; STACK USAGE:        2 (in maximum mode 3)
;;; 
;;; DESCRIPTION:        This routine provides a 32 bit signed compare operation
;;; 
	
__CMPSL:	CP      HL, IY          ; perform signed compare
                JRS     NZ, EXIT
                XOR     B, #128         ; translate operand a
                EX      BA, IX
                XOR     B, #128         ; translate operand b
                EX      BA, IX
                CP      BA, IX          ; perform signed compare

EXIT:           RET
                END

