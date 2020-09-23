;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)cmpul.asm	1.5	96/11/05
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_CMPUL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__CMPUL	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __CMPUL
;;; 
;;; AT ENTRY:           HLBA    long operand a
;;;                     IYIX    long operand b
;;; 
;;; AT EXIT:            a==b    SC.Z == 1; SC.N=0
;;;                     a>b     SC.Z == 0; SC.N^SC.V=0
;;;                     a<b     SC.Z == 0; SC.N^SC.V=1
;;;                     
;;; DESTROYS:           H, B, IY, IX
;;; 
;;; PRESERVES:          L, A
;;;
;;; STACK USAGE:        2 (in maximum mode 3)
;;; 
;;; DESCRIPTION:        This routine provides a 32 bit unsigned compare operation
;;; 
	
__CMPUL:	EX      BA, HL
                XOR     B, #128         ; translate operand a
                EX      BA, HL
                EX      BA, IY
                XOR     B, #128         ; translate operand b
                EX      BA, IY
                CP      HL, IY          ; perform signed compare
                JRS     NZ, EXIT
                XOR     B, #128         ; translate operand a
                EX      BA, IX
                XOR     B, #128         ; translate operand b
                EX      BA, IX
                CP      BA, IX

EXIT:           RET
                END
