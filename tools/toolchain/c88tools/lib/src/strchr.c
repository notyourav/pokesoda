/*
 *	Version : @(#)strchr.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  strchr.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for strchr() routine                       *
**                 Search for the first occurrence of a character         *
**                 in a string.                                           *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <string.h>

char *
strchr( register const char *cs, int c )
{
	do
	{
		if( *cs == (char)c )	/* found character ?		*/
			return( (char *)cs );
	} while( *cs++ );
	return( NULL );			/* character not found		*/
}
