/*
 *	Version : @(#)div.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  div.c                                                  *
**                                                                        *
**  DESCRIPTION :  Source file for div() routine                          *
**                 Returns a structure containing the quotient and        *
**                 remainder of num divided by denom                      *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <stdlib.h>

div_t
div( int numer, int denom )
{
	div_t result;

	result.quot = numer / denom;
	result.rem  = numer % denom;
	return( result );
}
