;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)divui.asm	1.6	99/01/22
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_DIVUI"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__DIVUI
;;;****************************************************************************
;;; 
;;; ROUTINE:            __DIVUI
;;; 
;;; AT ENTRY:           IX      integer dividend a
;;;                     IY      integer divisor b
;;; 
;;; AT EXIT:            HL      integer quotient a/b
;;;                     BA      integer remainder
;;;                     V=0
;;;                or:
;;;                     V=1     at divide by 0
;;; 
;;; DESTROYS:           XP
;;; 
;;; PRESERVES:          
;;;
;;; STACK USAGE:        6 (in maximum mode 7)
;;; 
;;; DESCRIPTION:        This routine provides a 16 bit divide operation
;;;                     
;;; 
;;; Procedure:
;;;             1. Immediate exit at division by zero (div_by_zero)
;;;             2. Efficiently shift at leading '0's in dividend (fast_zero_loop)
;;;             3. Bitwise perform divide operation (slow_loop)
;;;             4. Get remainder and result and return.

	EXTERN (DATA) __lc_es

__DIVUI:        ADD     IY, #0          ; First check for DIVISOR==0?
                JRS     NZ, non_zero
div_by_zero:    OR      SC, #4          ; Set V=1: division by zero
                RET

non_zero:       PUSH	EP			; save EP
		LD	EP,#@dpag(__lc_es-1) 	; stack-page in EP
		PUSH    IX              	; Move DIVIDEND to stack
                
                LD      BA, #0          	; Initialize RESULT space at stack
                PUSH    BA

                ;; At this point on stack (from top to bottom):
                ;; REMAINDER lsb (==0)  <--SP
                ;; REMAINDER hsb (==0)  <--SP+1
                ;; DIVIDEND  lsb        <--SP+2 (QUOTIENT)
                ;; DIVIDEND  hsb                (QUOTIENT)
                ;; saved EP
                ;; Return Address

                LD      XP, #16         ; nr_bits=16
                LD      B, #2           ; nr_bytes=2
                LD      HL, SP
                ADD     HL, #3          ; high byte of DIVIDEND
                LD      A, [HL]

fast_zero_loop: OR      A, #0
                JRS     NZ, slow_loop   ; is '0' ?
                LD      A, XP
                SUB     A, #8           ; 8 bits of DIVIDEND can be discarded
                LD      XP, A

                DEC     HL              ; shift DIVIDEND 8 bits, REMAINDER='0', QUOTIENT='0'
                LD      A, #0   
                EX      A, [HL]         ; low byte of QUOTIENT = 0
                INC     HL
                LD      [HL], A         ; HL points to high byte of DIVIDEND again + still in A!
                DEC     B
                JRS     NZ, fast_zero_loop
                JRS     ready           ; Both bytes were '0' -- 0/x = 0!

slow_loop:      ; Shift QUOTIENT and DIVIDEND
                LD      B, #2           ; 2 bytes to shift
                LD      HL, SP
                ADD     HL, #2          ; add 2 to point to the first byte to shift
                AND     SC, #0FDH       ; Clear carry
shift1:         RL      [HL]
                INC     HL
                DEC     B
                JRS     NZ, shift1      ; shift 2 bytes of DIVIDEND

                LD      B, #2           ; overflow of shifted DIVIDEND in carry
                LD      HL, SP
shift2:         RL      [HL]
                INC     HL
                DEC     B
                JRS     NZ, shift2      ; and shift 2 bytes of REMAINDER
                
                ; Test if REMAINDER minus DIVISOR >= 0
                LD      HL, SP
                LD      BA, [HL]        ; Get REMAINDER
                SUB     BA, IY          ; If DIVISOR <= operand then the carry is '0'
                JRS     C, EndOfSubtract; If carry then skip subtraction
                
Subtract:       LD      HL, SP
                ADD     HL, #2          ; HL points to the QUOTIENT
                INC     [HL]            ; We are sure, the last bit was a '0', because we
                                        ; shifted it in! No carry can occur

                LD      HL, SP          ; Now subtract DIVISOR from REMAINDER
                LD      BA, [HL]
                SUB     BA, IY          ; Subtract DIVISOR (no carry!)
                LD      [HL], BA

EndOfSubtract:  
                LD      A, XP
                DEC     A               ; Loop until all 16 bits shifted
                LD      XP, A
                JRS     NZ, slow_loop

                ;; Now on stack (from top to bottom):
                ;; REMAINDER
                ;; QUOTIENT
                ;; saved EP
                ;; RETURN ADDRESS

ready:          POP     BA              ; get REMAINDER
                POP     HL              ; get QUOTIENT
		POP	EP		; Restore EP-register
                RET

                END
