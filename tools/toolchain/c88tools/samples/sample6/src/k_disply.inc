$LIST OFF
;=============================================================================
; k_disply.inc			<kernel> display
;	-----------------------------------------------------------------
;	development		takeda		Nov. 16th, 1998
;	modification
;	-----------------------------------------------------------------
;	Copyright(C) 1998,1999 Seiko Epson Co.,Ltd
;============================================================================= 
;=============================================================================
; MCU internal VRAM
;=============================================================================
McuVramSttAd	EQU	0f800h				; start address
McuVramXmax		EQU	32h					; x axis size
McuVramYstep	EQU	100h				; y axis address step per 8 dots

;=============================================================================
; display size
; LCD size : 128 * 32 dots
; MCU VRAM memory size : 51 * 32 dots
;=============================================================================
LCDXmax			EQU	128-1
LCDYmax			EQU	32-1

;=============================================================================
; display position of Y8dot(1byte) character
;=============================================================================
CY8MaxY			EQU	4-1				; y8 character y axis maximum position
;=============================================================================
; display position of Y16dot(1byte) character
;=============================================================================
CY16MaxY		EQU	2-1				; y16 character y axis maximum position

;=============================================================================
; character displaying format
;=============================================================================
;<standard>
CStdAscXSize	EQU	6				; standard ascii & special character x size (y:1byte)	6x8
CStdKanaXSize	EQU	10				; standard kana character x size (y:1byte)				10x8
;deb CStdAsc16XSize	EQU	9				; standard ascii & special character x size (y:2byte)	8x16
CStdAsc16XSize	EQU	6				; standard ascii & special character x size (y:2byte)	8x16

;<special>
CSmalNumXsize	EQU	4				; small numeral character x size						4x6
CSmalNumYsize	EQU	6				; small numeral character y size


;=============================================================================
; Charactre pattern
;=============================================================================
Cchrsizemax		EQU	9-1
Crollcnt		EQU	13

$LIST ON


