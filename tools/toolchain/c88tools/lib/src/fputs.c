/*
 *	Version : @(#)fputs.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  fputs.c                                                *
**                                                                        *
**  DESCRIPTION :  Source file for fputs() routine                        *
**                 Writes a complete string to the given stream           *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include	<stdio.h>

int
fputs( const char * s, FILE *stream )
{
	register int c;

	while ( c = *s++ )			/* write until NULL character */
		if( fputc( c, stream ) != c )
			return( EOF );		/* error */
	return( 0 );
}
