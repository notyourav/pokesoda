/*
 *	@(#)perror.c	1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  perror.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for perror() routine.                      *
**                 Maps the error number in the integer errno to an       *
**                 error message. It writes the message to standard error *
**                 stream. The message can be preceded by a user          *
**                 supplied message.                                      *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

void
perror( const char * s )
{
	printf( "%s: %d\n", s, errno );	
}
