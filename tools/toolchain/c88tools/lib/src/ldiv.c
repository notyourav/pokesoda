/*
 *	Version : @(#)ldiv.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  ldiv.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file for ldiv() routine                         *
**                 Returns a structure with the quotient an remainder of  *
**                 num divided by denom.                                  *
**	NOTE	   Cannot be shared code, using static data for           *
**		   structure result.                                      *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <stdlib.h>

ldiv_t
ldiv( long num, long denom )
{
	ldiv_t result;

	result.quot = num / denom;
	result.rem  = num % denom;
	return( result );
}
