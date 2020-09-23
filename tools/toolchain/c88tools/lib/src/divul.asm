;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)divul.asm	1.8	99/01/22
;;;
;;; AUTHOR:		Gerard Boersema		(gebo)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_DIVUL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__DIVUL
;;;****************************************************************************
;;; 
;;; ROUTINE:            __DIVUL
;;; 
;;; AT ENTRY:           HLBA    long dividend a
;;;                     IYIX    long divisor b
;;; 
;;; AT EXIT:            HLBA    result a/b
;;;                     IYIX    remainder
;;;                     V=0
;;;                or:
;;;                     V=1     at divide by 0
;;; 
;;; DESTROYS:           XP
;;; 
;;; PRESERVES:          
;;;
;;; STACK USAGE:        10 (in maximum mode 11)
;;; 
;;; DESCRIPTION:        This routine provides a 32 bit divide operation
;;;                     
;;; 
;;; Procedure:
;;;             1. Immediate exit at division by zero (div_by_zero)
;;;             2. Efficiently shift at leading '0's in dividend (fast_zero_loop)
;;;             3. Bitwise perform divide operation (slow_loop)
;;;             4. Get remainder and result and return.


	EXTERN (DATA) __lc_es

__DIVUL: 	ADD     IY, #0          ; First check for DIVISOR==0?
                JRS     NZ, non_zero
                ADD     IX, #0
                JRS     NZ, non_zero
div_by_zero:    OR      SC, #4          ; Set V=1: division by zero
                RET

non_zero:	PUSH	EP			; save old EP
		LD	EP, #@dpag(__lc_es-1) 	; load stack-page

		PUSH    HL			; Move DIVIDEND to stack
                PUSH    BA
                
                LD      BA, #0          	; Initialize RESULT space at stack
                PUSH    BA
                PUSH    BA

                ;; At this point on stack (from top to bottom):
                ;; REMAINDER lsb (==0)  <--SP
                ;; REMAINDER     (==0)  <--SP+1
                ;; REMAINDER     (==0)  <--SP+2
                ;; REMAINDER hsb (==0)  <--SP+3
                ;; DIVIDEND  lsb        <--SP+4 (QUOTIENT)
                ;; DIVIDEND                     (QUOTIENT)
                ;; DIVIDEND                     (QUOTIENT)
                ;; DIVIDEND  hsb                (QUOTIENT)
                ;; saved EP
                ;; Return Address

                LD      XP, #32         ; nr_bits=32
                LD      B, #4          ; nr_bytes=4
                LD      HL, SP
                ADD     HL, #7          ; high byte of DIVIDEND
                LD      A, [HL]

fast_zero_loop: OR      A, #0
                JRS     NZ, slow_loop   ; is '0' ?
                LD      A, XP
                SUB     A, #8           ; 8 bits of DIVIDEND can be discarded
                LD      XP, A
                
                SUB     HL,#3           ; shift DIVIDEND 8 bits, REMAINDER='0', QUOTIENT='0'
                LD      A, #0   
                EX      A, [HL]         ; low byte of QUOTIENT = 0
                INC     HL
                EX      A, [HL]
                INC     HL
                EX      A, [HL]
                INC     HL
                LD      [HL], A         ; HL points to high byte of DIVIDEND again + still in A!
                DEC     B
                JRS     NZ, fast_zero_loop
                JRS     ready           ; All four bytes were '0' -- 0/x = 0!

slow_loop:      ; Shift QUOTIENT and DIVIDEND
                LD      B, #4          ; 4 bytes to shift
                LD      HL, SP
                ADD     HL, #4          ; add 4 to point to the first byte to shift
                AND     SC, #0FDH       ; Clear carry
shift1:         RL      [HL]
                INC     HL
                DEC     B
                JRS     NZ, shift1      ; shift 4 bytes of DIVIDEND

                LD      B, #4          ; overflow of shifted DIVIDEND in carry
                LD      HL, SP
shift2:         RL      [HL]
                INC     HL
                DEC     B
                JRS     NZ, shift2      ; and shift 4 bytes of REMAINDER
                
                ; Test if REMAINDER minus DIVISOR >= 0
                LD      HL, SP
                LD      BA, [HL]        ; Get LS word of REMAINDER
                SUB     BA, IX
                INC     HL
                INC     HL
                LD      BA, [HL]        ; Get HS word of REMAINDER
                SBC     BA, IY          ; If DIVISOR <= operand then the carry is '0'
                JRS     C, EndOfSubtract; If carry then skip subtraction
                
Subtract:       LD      HL, SP
                ADD     HL, #4          ; HL points to the QUOTIENT
                INC     [HL]            ; We are sure, the last bit was a '0', because we
                                        ; shifted it in! No carry can occur

                LD      HL, SP          ; Now subtract DIVISOR from REMAINDER
                LD      BA, [HL]
                SUB     BA, IX          ; Subtract LS word of DIVISOR (no carry!)
                LD      [HL], BA
                INC     HL
                INC     HL
                LD      BA, [HL]
                SBC     BA, IY          ; Subtract HS word of DIVISOR (- carry!)
                LD      [HL], BA

EndOfSubtract:  
                LD      A, XP
                DEC     A               ; Loop until all 32 bits shifted
                LD      XP, A
                JRS     NZ, slow_loop

                ;; Now on stack (from top to bottom):
                ;; REMAINDER, 4 bytes
                ;; QUOTIENT, 4 bytes
                ;; saved EP, 1 byte
                ;; RETURN ADDRESS

ready:          
                POP     IX              ; get REMAINDER Low-part
                POP     IY              ; get   ,,      High-part
                POP     BA              ; get QUOTIENT  Low-part
                POP     HL              ; get   ,,      High-part
                
EXIT:           POP	EP		; restore EP-register
		RET
                END
