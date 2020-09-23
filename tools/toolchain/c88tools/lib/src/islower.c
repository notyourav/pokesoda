/*
 *	Version : @(#)islower.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  islower.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for islower() routine                      *
**                 Returns non zero if given character is a lowercase     *
**                 character.                                             *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <ctype.h>

#undef	islower

int
islower( int c )
{
	return( (_ctype_+1)[c] & (__L) );
}
