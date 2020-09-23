;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)icr.asm	1.3	96/10/22
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_icr"

                DEFSECT ".rtdata", DATA, SHORT
                SECT    ".rtdata"


                GLOBAL	__icr	
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
;;; DESCRIPTION:        This module provides for a dataword used for indirect calls
;;; 
	
__icr:          DW      0               ; Dataword reservation for 'indirect call'
                
                END
