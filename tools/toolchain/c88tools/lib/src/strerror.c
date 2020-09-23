/*
 *	@(#)strerror.c	1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  strerror.c                                             *
**                                                                        *
**  DESCRIPTION :  Source file for strerror() routine                     *
**		   Maps the error number in 'errnum' to an error message  *
**                 string.                                                *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <errno.h>
#include <string.h>

char	*
strerror( int errcode )
{
	errcode;
	return( 0 );
}
