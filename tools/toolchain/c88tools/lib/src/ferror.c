/*
 *	Version : @(#)ferror.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  ferror.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for ferror() routine                       *
**                 Checks if the stream has an error                      *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <stdio.h>

#undef ferror

int
ferror( FILE * stream )
{
	return( (stream->_flag & _IOERR) ? 1 : 0 );
}
