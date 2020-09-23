/*
 *	Version : @(#)isprint.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  isprint.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for isprint() routine                      *
**                 Returns non zero if given character is a printable     *
**                 character.                                             *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <ctype.h>

#undef	isprint

int
isprint( int c )
{
	return( (_ctype_+1)[c] & (__P|__U|__L|__N|__S) );
}
