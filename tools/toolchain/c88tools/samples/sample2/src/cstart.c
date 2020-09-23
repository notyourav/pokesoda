 /*
  *	@(#)cstart.c	1.20
  *	SMC88 Startup code
  *	Default, exit code will loop forever.
  *
  *	DEFINES to tune this startup code:
  *
  *		COPY (default)	-> produce code to clear 'CLEAR' sections AND initialize 'INIT' sections,
  *				   'CLEAR' and 'INIT' segments do not have to be consecutive
  *
  *	On exit the program will fall into an endless loop.
  */

void			_exit	( int );
void			_start	( void );
extern int		main	( void );
extern void		_copytable( void );

_interrupt( 0x0000 )	/* Startup vector */
void _start_cpt( void )
{
	#pragma asm

	GLOBAL	__START
	__START:

	;==========================================================================
	;===================  system initialization  ==============================
	;==========================================================================

	LD	SP,#@DOFF(__lc_es)			; stack pointer initialize
	LD	BR,#0FFh					; BR register initialize to I/O area
	;---------------  bus mode setting  ---------------------------------------
						; MCU & MPU mode
	LD	[BR:00h],#0
									; Single Chip mode
									; /CE0,/CE2,/CE3,/CE1:disenabled

	;--------------  bus and clock control  -----------------------------------
	LD	[BR:02h],#00h
    								; clock = OSC1
									; OSC1 on
									; normal power mode

	;---------------  stack pointer page address  -----------------------------
	LD	[BR:01h],#@DPAG(__lc_es-1)	; set stack pointer page
									; __lc_es is NOT within stack area


	EXTERN  (DATA,TINY)__lc_b_.tbss		;BR is used for tiny data
	LD	BR,#(@DOFF(__lc_b_.tbss) >> 8)

	#pragma endasm

	/* Use copy table to clear memory and intialize data */
	_copytable();		/* routine is found in library */

	_exit( main() );	/* Stops program in an endless loop */
}


void
_exit( int i )	/* 'i' is parameter in BA */
{
        i;
        do 
        {
			_slp();
        }
        while( 1 );	/* Program never stops */
}

void
_interrupt( 4 ) watchdog( void )
{
	/* Accept a watchdog interrupt */
}

#pragma asm
	DEFSECT	".tbss", DATA, TINY, CLEAR
	SECT	".tbss"
#pragma endasm
