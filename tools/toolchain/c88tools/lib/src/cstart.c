 /*
  *	@(#)cstart.c	1.22
  *	Startup code
  *	Default, exit code will loop forever.
  *
  *	DEFINES to tune this startup code:
  *
  *		COPY (default)	-> produce code to clear 'CLEAR' sections AND initialize 'INIT' sections,
  *				   'CLEAR' and 'INIT' segments do not have to be consecutive
  *		NOCOPY		-> No initialization of RAM
  *
  *	On exit the program will fall into an endless loop.
  */

#if	!defined(COPY) && !defined(NOCOPY)
#define	COPY
#endif

void			_exit	( int );
void			_start	( void );
extern int		main	( void );		/* This may not match the users prototype, never mind */
extern void _common	_copytable( void );
_sfrbyte		MPU _at( 0xFF00 );		/* MPU/MCU bus mode selection */
_sfrbyte		SPP _at( 0xFF01 );		/* Stack pointer page register */

/* Produce some dummy GLOBAL to enable C88 to select the correct startup code */
#if defined	COPY
#define	NAME	_start_cpt
#else
#define	NAME	_start_no
#endif

_interrupt( 0x0000 )	/* Startup vector */
void NAME( void )
{
#pragma asm
MPU	EQU	0FF00H
SPP	EQU	0FF01H
    
	
	GLOBAL	__START
__START:

	LD	A,#0
	LD	XP,A
	LD	YP,A
	LD	EP,A
	LD	BR,#0ffH	; I/O page
	; First write MPU/SPP registers, to enable interrupts, etc.
#if	_MODEL == 's'
	LD	[BR:MPU&0FFH],#00110000b
#elif   _MODEL == 'c'
        LD      [BR:MPU&0FFH],#10110001b
#else
	LD	[BR:MPU&0FFH],#11110001b
#endif
	LD	SP,#@DOFF(__lc_es)		; First set stackpointer,
						; before enabling NMI in the next instruction
	LD	[BR:SPP&0FFH],#@DPAG(__lc_es-1)	; Correct page ! __lc_es is NOT within stack area
        EXTERN  (DATA,TINY)__lc_b_.tbss
	LD	BR,#(@DOFF(__lc_b_.tbss) >> 8)
#pragma endasm


	/* Use copy table to clear memory and intialize data */
#if defined COPY
	_copytable();		/* routine is found in library */
#endif

	_exit( main() );	/* Stops program in an endless loop */
}

void
_exit( int i )	/* 'i' is parameter in BA */
{
        i;
        do 
        {
#pragma asm
            SLP
#pragma endasm
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
