/*
 *	Version : @(#)clearerr.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  clearerr.c                                             *
**                                                                        *
**  DESCRIPTION :  Source file for clearerr() routine                     *
**                 Clears any error on the stream                         *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <stdio.h>

#undef clearerr

void
clearerr( FILE * stream )
{
	stream->_flag &= ~(_IOEOF|_IOERR);
}
