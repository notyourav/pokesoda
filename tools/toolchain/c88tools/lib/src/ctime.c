/*
 *	Version : @(#)ctime.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  ctime.c                                                *
**                                                                        *
**  DESCRIPTION :  The ctime function converts the calendar time pointed  *
**		   to by t to local time in the form of a string.         *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <time.h>

char * ctime( const time_t *t )
{
	return( asctime( localtime( t ) ) );
}
