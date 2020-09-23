/*
 *	Version : @(#)memcmp.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  memcmp.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for memcmp() routine                       *
**                 Compares memory contents.                              *
**                 Returns : < 0  -- s1<s2                                *
**                           = 0  -- s1=s2                                *
**                           > 0  -- s1>s2                                *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <string.h>

int
memcmp( register const void * cs,  register const void * ct, size_t n )
{
	while( 1 )
	{
		if( !n-- )
			return( 0 );

		if( *(char *)cs != *(char *)ct )
			return(*(char *)cs - *(char *)ct);

		cs = (char *)cs + 1;
		ct = (char *)ct + 1;
	}
}
