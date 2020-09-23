/*
 *	Version : @(#)scanf.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  scanf.c                                                *
**                                                                        *
**  DESCRIPTION :  Source file for scanf() routine                        *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <stdarg.h>
#include <stdio.h>

extern int _doscan( const char *fmt, va_list ap, FILE *fin );

int
scanf( const char *format, ... )
{
	va_list ap;
	register int items;

	va_start( ap, format );
	items = _doscan( format, ap, stdin );
	va_end( ap );
	return( ferror( stdin ) ? EOF : items );	/* return number of characters read */
}
