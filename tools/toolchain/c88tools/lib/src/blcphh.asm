;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)blcphh.asm	1.5	96/11/07
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_BLCPHH"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"

                GLOBAL	__BLCPHH	
;;;****************************************************************************
;;; 
;;; ROUTINE:            __BLCPHH
;;; 
;;; AT ENTRY:           XP, IX  Source address
;;;                     YP, IY  Destination address
;;;                     EP, BA  Length in bytes
;;; 
;;; AT EXIT:            Block copied
;;;                     
;;; DESTROYS:           BA, EP, HL, XP, IX, YP, IY
;;; 
;;; PRESERVES:          -
;;;
;;; STACK USAGE:        2 (in maximum mode 3)
;;; 
;;; DESCRIPTION:        This routine provides a Huge Block Copy operation for HUGE model
;;;                     (block length <16MB)
	
__BLCPHH:       BIT     A, #1           ; Check for odd length
                LD      HL, BA
                JRS     Z, _0
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
                
_0:             CP      HL, #0          ; Bodytrap at EP=0 && HL=0 !
                JRS     Z, _3
                
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
                
_3:             LD      A, EP
                CP      A, #0         
                JRS     Z, EXIT
                DEC     A
                LD      EP, A
                JRS     LOOP
                
EXIT:           RET
                END
