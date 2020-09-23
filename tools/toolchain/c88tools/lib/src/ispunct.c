/*
 *	Version : @(#)ispunct.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  ispunct.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for ispunct() routine                      *
**                 Returns non zero if given character is a punctuation   *
**                 character.                                             *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <ctype.h>

#undef	ispunct

int
ispunct( int c )
{
	return( (_ctype_+1)[c] & (__P) );
}
