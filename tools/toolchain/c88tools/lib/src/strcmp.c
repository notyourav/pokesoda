/*
 *	Version : @(#)strcmp.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  strcmp.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for strcmp() routine                       *
**                 Compares two strings.                                  *
**                 Returns : < 0  -- s1<s2                                *
**                           = 0  -- s1=s2                                *
**                           > 0  -- s1>s2                                *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <string.h>

int
strcmp( const char * s1, const char * s2 )
{
	char c;  int result;

	while( !(result = (c = *s1++) - *s2++) && c )
		;
	return(result);
}
