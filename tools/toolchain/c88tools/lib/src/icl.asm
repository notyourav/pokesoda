;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)icl.asm	1.1	97/01/13
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_icl"

                DEFSECT ".rtdata", DATA, SHORT
                SECT    ".rtdata"


                GLOBAL	__icl	
;;;****************************************************************************
;;; 
;;; ROUTINE:            -
;;; 
;;; AT ENTRY:           -
;;; 
;;; AT EXIT:            -
;;; 
;;; DESTROYS:           -
;;; 
;;; PRESERVES:          -
;;;
;;; STACK USAGE:        -
;;; 
;;; DESCRIPTION:        This module provides for a 24 bit space reservation for
;;;                     indirect calls
;;; 
	
__icl:          DW      0               ; Dataword reservation for 'indirect call'
                DB      0                
                END
