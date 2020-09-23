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
;assembler macro
;==============================================================================


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

	;< set zero flag macro >
M_SEZ	MACRO
		OR	SC,#00000001b
		ENDM

	;< clear zero flag macro >
M_CLZ	MACRO
		AND	SC,#11111110b
		ENDM

	;< set carry flag macro >
M_SEC	MACRO
		OR	SC,#00000010b
		ENDM

	;< clear carry flag macro >
M_CLC	MACRO
		AND	SC,#11111101b
		ENDM

	;< set decimal flag macro >
M_SED	MACRO
		OR	SC,#00010000b
		ENDM

	;< clear decimal flag macro >
M_CLD	MACRO
		AND	SC,#11101111b
		ENDM




;==============================================================================
;assembler control
;==============================================================================
;;$CASE ON
$DEBUG ON
$MODEL S
$IDENT LOCAL									; default local label

$LIST ON



