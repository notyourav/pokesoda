/*
 *	@(#)c88.h	1.3
 */

/**************************************************************************
**                                                                        *
**  FILE        :  c88.h                                                  *
**                                                                        *
**  DESCRIPTION :  Include file with macros to enable or disable the      *
**                 usage of TASKING S1C88 language extensions.            *
**                 c88 has the following predefined preprocessor          *
**                 symbols:                                               *
**                           _C88      value = version of compiler        *
**                                     (e.g. value 10 for v1.0)           *
**                           _MODEL    memory model (-M option):          *
**                                     small:        value is 's'         *
**                                     compact code: value is 'c'         *
**                                     compact data: value is 'd'         *
**                                     large:        value is 'l'         *
**                           _CPU      CPU type                           *
**                                     value as defined to the -C option  *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#ifndef _C88_H
#define	_C88_H

/*
 * When using TASKING S1C88 compiler, recognize language extensions
 */

#ifndef _C88
/* 
 * When not using the TASKING S1C88 compiler, define the extension
 * keywords away. There is no need to remove const.
 */

#define	_small
#define	_large
#define	_short
#define	_inline
#define	_rom
#define	_tiny
#define	_near
#define	_far
#define	_huge
#define	_sfrbyte	volatile unsigned char
#define	_sfrword	volatile unsigned int
#define	_asmfunc
#define	_at( X )
#define	_interrupt( X )
#define	_bank( X )

/*
 * The following functions are built-in functions of the C compiler.
 * A prototype is given here, so other compilers can recognize
 * the function names and types. The user should make alternatives
 * for these functions to prototype the application on another host.
 */
void	_bcd	( );
void	_halt	( void );
void	_int	( int );
char	_jrsf	( int );
void	_nop	( void );
char	_pack	( int );
char	_rlc	( char );
char	_rrc	( char );
void	_slp	( void );
char	_swap	( char );
void	_ubcd	( );
void	_unpack	( );
int	_upck	( char );
#endif

#endif	/* _C88_H */
