/*
 *	Version : @(#)strcat.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  strcat.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for strcat() routine                       *
**                 Catenates two strings to eachother.                    *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <string.h>

char *
strcat( register char * s1, register const char * s2 )
{
	register char *os1;

	os1 = s1;
	while (*s1++)
		;
	--s1;
	while (*s1++ = *s2++)
		;
	return(os1);
}
