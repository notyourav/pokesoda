/*
 *	Version : @(#)memset.c	1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  memset.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for memset() routine                       *
**                 Fills a part of memory with given value.               *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <string.h>

typedef size_t loop_t;

void *
memset( void *s, int v, size_t n )
{
	loop_t i;  char *so;

	so = (char *)s;
	for(i = 0;  i < (loop_t)n;  i++)
		*so++ = v;
	return(s);
}

