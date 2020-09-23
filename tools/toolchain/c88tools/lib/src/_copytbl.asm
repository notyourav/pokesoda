$CASE ON
$WARNING OFF 109
;
;	@(#)_copytbl.asm	1.12
;
;	Data initialization routine, only called by startup code
;	Uses the locator generated copy-table to cleanup/copy memory.
;
IF !@DEF(_AS88)
	FAIL	'Routine is useful with as88 assembler only'
ENDIF

	$IDENT LOCAL	; Also the default of the assembler

	DEFSECT	".startup", CODE, SHORT
	SECT	".startup"

	GLOBAL	__copytable
__copytable:			; Case sensitive !!

	LD	YP,#0

IF _MODEL != 's' && _MODEL != 'd'	; small data space, maximum 64K
;	SUB	SP,#4		; space to store the length counter
	PUSH	BA		; shorter
	PUSH	BA
ELSE
;	SUB	SP,#2		; space to store the length counter
	PUSH	BA		; shorter
ENDIF

	LD	EP,#@DPAG(__lc_cp)

	LD	HL,#@DOFF(__lc_cp)
	JRS	_start

_loop:
	LD	XP,#@DPAG(__lc_cp)

	LD	IX,HL

	LD	A,[IX+7]	; length to stack
	LD	B,[IX+8]
	LD	[SP],BA
IF _MODEL != 's' && _MODEL != 'd'	; small data space, maximum 64K
	LD	A,[IX+9]
	LD	B,[IX+10]
	INC	BA		; upper two bytes + 1, simplifying test code
	LD	[SP+2],BA
ENDIF

	LD	A,[IX+1]	; destination pointer to IY/YP
	LD	B,[IX+2]
	LD	IY,BA
IF _MODEL != 's'
	LD	A,[IX+3]
	LD	YP,A
ENDIF

	LD	A,[IX+4]	; source pointer to IX/XP
	LD	B,[IX+5]
IF _MODEL != 's'
	PUSH	BA
	LD	A,[IX+6]
	LD	XP,A
	POP	IX
ELSE
	LD	IX,BA
ENDIF

_copy_clean:
	CP	[HL],#1		; action == CP_COPY ???
	JRS	NZ,_clean

_copy:
	LD	A,[IX]		; *IY = *IX
	LD	[IY],A
	INC	IX		; IX++
IF _MODEL != 's'
	JRS	NZ,_copy2
	LD	A,XP
	INC	A
	LD	XP,A		; overflow of IX, increment page too
_copy2:
ENDIF
	JRS	_inc

_clean:				; action == CP_BSS
	LD	[IY],#0		; *IY = 0

_inc:
	INC	IY		; IY++
IF _MODEL != 's'
	JRS	NZ,_inc2
	LD	A,YP
	INC	A
	LD	YP,A		; overflow of IY, increment page too
_inc2:
ENDIF
	LD	BA,[SP]	; lower two bytes of the length
	DEC	BA
	LD	[SP],BA
	JRS	NZ,_copy_clean
IF _MODEL != 's' && _MODEL != 'd'	; small data space, maximum 64K
	LD	BA,[SP+2]	; upper two bytes of the length
	DEC	BA
	LD	[SP+2],BA
	JRS	NZ,_copy_clean	; also 0, ready
ENDIF

_next:
	ADD	HL,#11		; next member of the copy table
_start:
	CP	[HL],#0		; end of table found ?
	JRS	NZ,_loop	; no, do some initialization

IF _MODEL != 's' && _MODEL != 'd'	; small data space, maximum 64K
;	ADD	SP,#4		; free the length counter space
	POP	BA		; shorter
	POP	BA
ELSE
;	ADD	SP,#2		; free the length counter space
	POP	BA		; shorter
ENDIF
	RET

	EXTERN	(CODE) __lc_cp
	END
