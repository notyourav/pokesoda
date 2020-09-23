;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)blcps.asm	1.5	96/11/07
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_BLCPS"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"
                
                GLOBAL	__BLCPS	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __BLCPS
;;; 
;;; AT ENTRY:           IX      Source address
;;;                     IY      Destination address
;;;                     BA      Length in bytes
;;;                     (Note: BA should be >0)
;;; 
;;; AT EXIT:            Block copied
;;;                     
;;; DESTROYS:           BA, HL, IX, IY
;;; 
;;; PRESERVES:          -
;;;
;;; STACK USAGE:        2 (in maximum mode 3)
;;; 
;;; DESCRIPTION:        This routine provides a Block Copy operation for Small model usage
;;; 
	
__BLCPS:        BIT     A, #1           ; Check for odd length
                LD      HL, BA
                JRS     Z, LOOP
CP_ODD_BYTE:    LD      [IY], [IX]
                INC     IX
                INC     IY
                DEC     HL
                JRS     Z, EXIT
                
LOOP:           LD      BA, [IX]
                LD      [IY], BA
                ADD     IX, #2
                ADD     IY, #2
                SUB     HL, #2
                JRS     NZ, LOOP
                
EXIT:           RET
                END
