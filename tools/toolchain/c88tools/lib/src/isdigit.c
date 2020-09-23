/*
 *	Version : @(#)isdigit.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  isdigit.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for isdigit() routine                      *
**                 Returns non zero if given character is a numeric       *
**                 character.                                             *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <ctype.h>

#undef	isdigit

int
isdigit( int c )
{
	return( (_ctype_+1)[c] & (__N) );
}
