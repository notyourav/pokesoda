;;;****************************************************************************
;;;
;;; VERSION CONTROL:	@(#)mulxl.asm	1.10	99/03/02
;;;
;;; AUTHOR:		Peter van den Os	(petero)
;;;
;;; COPYRIGHT:		Copyright (c) 1996 Tasking Software B.V.
;;;
;;;****************************************************************************

$CASE ON

                NAME    "_MULXL"

                DEFSECT ".rtcode", CODE, SHORT, FIT 8000H
                SECT    ".rtcode"


                GLOBAL	__MULXL
;;;****************************************************************************
;;; 
;;; ROUTINE:            __MULXL
;;; 
;;; AT ENTRY:           HLBA    long operand a
;;;                     IYIX    long operand b
;;; 
;;; AT EXIT:            HLBA    result a*b
;;; 
;;; DESTROYS:
;;; 
;;; PRESERVES:          
;;;
;;; STACK USAGE:        14 (in maximum mode 15)
;;; 
;;; DESCRIPTION:        This routine provides a 32 bit multiplication
;;;                     
;;; 


;;;             H	L	B	A
;;;             Z	Y	X	W       x
;;;             =========================
;;;             M	N	O	P
;;; step1       WH  <-- WL  <-- WB  <-- WA
;;; step2	+XL <-- +XB <-- +XA
;;; step3	+YB <-- +YA
;;; step4	+ZA
;;;

	EXTERN (DATA) __lc_es

__MULXL:	PUSH	IP		; save XP, YP	
		PUSH	IY		; Z and Y stack position 11 and 10
		PUSH	IX		; X and W stack position 9 and 8
		PUSH	HL		; stack position 7 and 6
		PUSH	BA 		; stack position 5 and 4

		LD	BA, #0
		PUSH	BA		; M and N stack position 3 and 2
		PUSH	BA		; O and P stack position 1 and 0
		
		LD	YP, #@dpag(__lc_es-1) ; store stack page pointer

;;;	step 1

		LD	IY, SP
		LD	A, [IY+4]	; A
		LD	L, [IY+8]	; W
		MLT			; W * A
		LD	[IY], L		; store result in P
		LD	B, H		; store overflow

		LD	A, [IY+5]	; B
		LD	L, [IY+8]	; W
		MLT			; W * B
		LD	A, L		
		ADD	A, B		; Add overflow to result
		LD 	[IY+1], A	; store result in O
		LD	B, H		; store overflow
		JRS	NC, CarryS1_1	
		INC	B		; Add carry to overflow
		
CarryS1_1:	LD	A, [IY+6]	; L
		LD	L, [IY+8]	; W
		MLT			; W * L
		LD	A, L		
		ADD	A, B		; Add overflow to result
		LD 	[IY+2], A	; store result in N
		LD	B, H		; store overflow
		JRS	NC, CarryS1_2	
		INC	B		; Add carry to overflow
		
CarryS1_2:	LD	A, [IY+7]	; H
		LD	L, [IY+8]	; W
		MLT			; W * H
		LD	A, L		
		ADD	A, B		; Add overflow to result
		LD 	[IY+3], A	; store result in M

;;;	step 2

		LD	A, [IY+4]	; A
		LD	L, [IY+9]	; X
		MLT			; X * A
		LD	A, L		 
		ADD	A, [IY+1]	; add current result to previous result 
		LD	[IY+1], A	; store result in O
		LD	B, H		; store overflow
		JRS	NC, CarryS2_1
		INC	B		; Add carry to overflow

CarryS2_1:	LD	A, [IY+5]	; B
		LD	L, [IY+9]	; X
		MLT			; X * B
		LD	A, L
		ADD	A, [IY+2]	; add current result to previous result 	
		JRS	NC, CarryS2_2
		INC	H		; add carry to overflow
CarryS2_2:	ADD	A, B		; Add overflow to result
		LD 	[IY+2], A	; store result in N
		LD	B, H		; store overflow
		JRS	NC, CarryS2_3	
		INC	B		; Add carry to overflow
		
CarryS2_3:	LD	A, [IY+6]	; L
		LD	L, [IY+9]	; X
		MLT			; X * L
		LD	A, L		
		ADD	A, [IY+3]	; add current result to previous result 
		ADD	A, B		; add overflow to result
		LD	[IY+3], A	; store result in M

;;;	step 3

		LD	A, [IY+4]	; A
		LD	L, [IY+10]	; Y
		MLT			; Y * A
		LD	A, L		; 
		ADD	A, [IY+2]	; add current result to previous result 
		LD	[IY+2], A	; store result in N
		LD	B, H		; store overflow
		JRS	NC, CarryS3_1
		INC	B		; Add carry to overflow

CarryS3_1:	LD	A, [IY+5]	; B
		LD	L, [IY+10]	; Y
		MLT			; Y * B
		LD	A, L		
		ADD	A, [IY+3]	; add current result to previous result 
		ADD	A, B		; add overflow to result
		LD	[IY+3], A	; store result in M
		
;;;	step 4

		LD	A, [IY+4]	; A
		LD	L, [IY+11]	; Z
		MLT			; Z * A
		LD	A, L		; 
		ADD	A, [IY+3]	; add current result to previous result 
		LD	[IY+3], A	; store result in M

		POP	BA		; POP answer O and P in register BA		
		POP	HL		; POP answer M and N in register HL

		POP	IX		; Clean stack and restore register IX and IY
		POP	IX		
		POP	IX		
		POP	IY		
		
EXIT:           POP	IP		; restore XP, YP	
		RET
                END

