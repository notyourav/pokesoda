/*
 *	Version : @(#)tolower.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  tolower.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for tolower() routine                      *
**                 Converts given string to lower case.                   *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <ctype.h>


int
tolower( int c )
{
	return( isupper( c ) ? _tolower( c ) : c );
}
