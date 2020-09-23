$CASE ON
;	@(#)startup.asm	1.17
;	Startup code
;	Default, exit code will loop forever.
;
;	DEFINES to tune this startup code:
;
;	COPY (default)	-> produce code to clear 'CLEAR' sections AND initialize 'INIT' sections,
;	'CLEAR' and 'INIT' segments do not have to be consecutive
;	NOCOPY		-> No initialization of RAM
;	_MODEL value is set via the command line (-Mx selection)
;
;	On exit the program will fall into an endless loop.
;

IF !@DEF(_AS88)
	FAIL	'This startup code is useful with as88 assembler only'
ENDIF

	$IDENT LOCAL	; Also the default of the assembler

IF	!@DEF('COPY') && !@DEF('NOCOPY')
	DEFINE	COPY	""
ENDIF

IF	@DEF('COPY')
	DEFINE	_NAME	"__start_cpt"
ELSE
	DEFINE	_NAME	"__start_no"
ENDIF

	MPU	EQU	0FF00H		; MPU/MCU bus mode selection
	SPP	EQU	0FF01H		; Stack pointer page register

	DEFSECT	".startup_vector",CODE AT 0000H
	SECT	".startup_vector"
	DW	_NAME			; Fill the startup vector

	DEFSECT	".startup", CODE, SHORT
	SECT	".startup"

_NAME:
__START:
	LD	EP,#0
	LD	BR,#0ffH	; I/O page

	; First write MPU/SPP registers, to enable interrupts, etc.
IF	_MODEL == 's'
	LD	[BR:(MPU & 0FFH)],#00110000b
ELSE 
IF	_MODEL == 'c'
        LD      [BR:(MPU & 0FFH)],#10110001b
ELSE
	LD	[BR:(MPU & 0FFH)],#11110001b
ENDIF
ENDIF
	LD	SP,#@DOFF(__lc_es)		; First set stackpointer,
						; before enabling NMI in the next instruction
	LD	[BR:(SPP & 0FFH)],#@DPAG(__lc_es-1) ; Correct page ! __lc_es is NOT within stack area

IF	_MODEL == 's'
	LD	A,#0
	LD	EP,A		; _copytable and main routine may assume these registers to be filled correctly
	LD	XP,A
	LD	YP,A
ENDIF

        EXTERN  (DATA,TINY)__lc_b_.tbss
	LD	BR,#(@DOFF(__lc_b_.tbss) >> 8)	; page of BR addressable data, disabled for now

IF	@DEF('COPY')
	EXTERN (CODE, SHORT) __copytable

	CAR	__copytable	; zeroing of data memory + copying of initialized data memory
ENDIF

	CAR	_main		; Call user main program
				; return value of main (exit code)
				; is in register BA, that's where
				; exit expects it, so just call exit
	CAR	__exit		; call program exit

	DEFSECT	".text",CODE 
	SECT	".text"
__exit:
loop:
	SLP			; when we get here, embedded program halts?
	JR	loop

	GLOBAL	__exit		; will be used by C-library


; When NO_WATCHDOG is defined, then do not insert watchdog handling code
IF !@DEF('NO_WATCHDOG')
	DEFSECT	".watchdog_vector",CODE AT 0004H
	SECT	".watchdog_vector"
	DW	_watchdog		; Fill the watchdog vector

	DEFSECT	".watchdog",CODE
	SECT	".watchdog"
_watchdog:
	RETE
ENDIF

	
	; Produce a GLOBAL label to enable C88 to select the correct startup code
	GLOBAL	_NAME
	GLOBAL	__START

	EXTERN (CODE) _main
	EXTERN (DATA) __lc_es

        DEFSECT ".tbss", DATA, TINY
	SECT ".tbss"

	END
