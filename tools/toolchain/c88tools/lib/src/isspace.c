/*
 *	Version : @(#)isspace.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  isspace.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for isspace() routine                      *
**                 Returns non zero if given character is a whitespace    *
**                 character.                                             *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <ctype.h>

#undef	isspace

int
isspace( int c )
{
	return( (_ctype_+1)[c] & (__S|__W) );
}
