;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)blcph.asm	1.5	96/11/07
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_BLCPH"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"
                
                GLOBAL	__BLCPH	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __BLCPH
;;; 
;;; AT ENTRY:           XP, IX  Source address
;;;                     YP, IY  Destination address
;;;                     BA      Length in bytes
;;;                     (Note: BA should be >0)
;;;                     
;;; AT EXIT:            Block copied
;;;                     
;;; DESTROYS:           BA, HL, XP, IX, YP, IY
;;; 
;;; PRESERVES:          -
;;;
;;; STACK USAGE:        2 (in maximum mode 3)
;;; 
;;; DESCRIPTION:        This routine provides a Block Copy operation for LARGE model usage
;;;                     (block length <64KB)
	
__BLCPH:        BIT     A, #1           ; Check for odd length
                LD      HL, BA
                JRS     Z, LOOP
CP_ODD_BYTE:    LD      [IY], [IX]
                INC     IX
                JRS     NZ, _o1
                LD      A, XP
                INC     A
                LD      XP, A
_o1:            INC     IY
                JRS     NZ, _o2
                LD      A, YP
                INC     A
                LD      YP, A
_o2:            DEC     HL
                JRS     Z, EXIT
                
LOOP:           LD      BA, [IX]
                LD      [IY], BA
                ADD     IX, #2
                JRS     NC, _1
                LD      A, XP
                INC     A
                LD      XP, A
_1:             ADD     IY, #2
                JRS     NC, _2
                LD      A, YP
                INC     A
                LD      YP, A
_2:             SUB     HL, #2
                JRS     NZ, LOOP
                
EXIT:           RET
                END
