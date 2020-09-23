/*
 *	Version : @(#)memmove.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  memmove.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for memmove() routine                      *
**                 Moves data from default memory to default memory.      *
**                 Overlapping spaces are treated correct.                *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <string.h>


void *
memmove( void *s, register const void *ct, register size_t n )
{
	register char *so = s;

	if( so > (char *)ct )	/* copy from right to left */
	{
		for(	so+=n, ct = (char *)ct + n;
			n--;
			ct = (char *)ct - 1, *--so = *(char *)ct
		   )
			;
	}
	else		/* copy from left to right */
	{
		for( ; n--; *so++=*(char *)ct, ct = (char *)ct + 1 )
			;
	}
	return( (void *)s );
}
