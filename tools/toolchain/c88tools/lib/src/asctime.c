/*
 *	Version : @(#)asctime.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  asctime.c                                              *
**                                                                        *
**  DESCRIPTION :  The asctime function converts the broken-down time int *
**		   structure pointed to by t into a string int the form   *
**		   "Day Mon dd hh:mm:ss: yyyy\n\0"                        *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <time.h>

char * asctime( const struct tm *t )
{
	static char buf[26];

	strftime( buf, sizeof( buf ), "%c\n", t);

	return( buf );
}
