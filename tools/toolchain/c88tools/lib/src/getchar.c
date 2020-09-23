/*
 *	Version : @(#)getchar.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  getchar.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for getchar() routine                      *
**                 Reads one character from standard input.               *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <stdio.h>

#undef getchar

int
getchar( void )
{
	if( --stdin->_cnt >= 0 )
	{
		return( (int)(*(stdin)->_ptr++ & 0xFF ) );
	}
	else
	{
		return( _filbuf( stdin ) );
	}
}
