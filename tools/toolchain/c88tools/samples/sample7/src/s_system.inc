$LIST OFF

;==============================================================================
; s_system.inc			<system> system setting
;	-----------------------------------------------------------------
;	development		takeda		Oct. 29th, 1998
;	modification
;	-----------------------------------------------------------------
;	Copyright(C) 1998,1999 Seiko Epson Co.,Ltd
;============================================================================== 

;==============================================================================
;conditional assemble setting
;==============================================================================
	;--------------  supply voltage and resonator type  -----------------------
	CA_SUPVOL	EQU	1				; 0 supply voltage < 3.5V  (low power mode & normal mode)
									; 1 supply voltage > 3.5V  (normal mode & high speed mode)
	CA_OSCSEL	EQU	0				; 0 OSC3 is crystal resonator
									; 1 OSC3 is ceramic resonator


;==============================================================================
;assembler macro
;==============================================================================

	;< bit set macro >							; REG is fixed to HL
M_BSET	MACRO	DATA,DBIT,REG
		LD	REG,#DATA
		OR	[REG],#DBIT
	ENDM

	;< bit clear macro >						; REG is fixed to HL
M_BCLR	MACRO	DATA,DBIT,REG
		LD	REG,#DATA
		AND	[REG],#(DBIT)^0FFH
	ENDM

	;< bit reverse macro >						; REG is fixed to HL
M_BREV	MACRO	DATA,DBIT,REG
		LD	REG,#DATA
		XOR	[REG],#DBIT
	ENDM

	;< bit check macro >						; REG is fixed to HL
M_BIT	MACRO	DATA,DBIT,REG
		LD	REG,#DATA
		BIT	[REG],#DBIT
	ENDM

	;< I/O register bit set macro >
M_IO_BSET	MACRO	DATA,DBIT
		OR	[BR:DATA],#DBIT
		ENDM

	;< I/O register bit clear macro >
M_IO_BCLR	MACRO	DATA,DBIT
		AND	[BR:DATA],#(DBIT)^0FFH
		ENDM

	;< I/O register bit check macro >
M_IO_BIT	MACRO	DATA,DBIT
		BIT	[BR:DATA],#DBIT
		ENDM


;==============================================================================
;assembler control
;==============================================================================
;;$CASE ON
$DEBUG ON
$MODEL S
$IDENT LOCAL									; default local label

$LIST ON


