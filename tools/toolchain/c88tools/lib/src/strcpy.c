/*
 *	Version : @(#)strcpy.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  strcpy.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for strcpy() routine                       *
**                 Copies one string to another.                          *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <string.h>

char *
strcpy( register char * s1, register const char * s2)
{
	register char *os1;

	os1 = s1;
	while (*s1++ = *s2++)
		;
	return(os1);
}
