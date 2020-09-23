/*
 *	Version : @(#)isascii.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  isascii.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for isascii() routine                      *
**                 Returns non zero if given character is an ascii        *
**                 character.                                             *
**                 (Non ANSI function)
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <ctype.h>

#undef	isascii

int
isascii( int c )
{
	return( (unsigned)c <= 0177 );
}
