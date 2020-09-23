/*
 *	Version : @(#)putchar.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  putchar.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for putchar() routine                      *
**                 Writes one character to standard output.               *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <stdio.h>

#undef putchar

int
putchar( int c )
{
	if( --(stdout)->_cnt >= 0 )
	{
		*stdout->_ptr++ = (char)c;
		return( c & 0xFF );
	}
	else
	{
		return( _flsbuf( (unsigned char)c, stdout ) );
	}
}
