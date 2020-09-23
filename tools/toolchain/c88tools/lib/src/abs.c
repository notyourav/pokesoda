/*
 *	Version : @(#)abs.c	1.3
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _abs.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file for abs() routine                          *
**                 returns absolute value of signed integer argument      *
**                                                                        *
**  COPYRIGHT   : 1996 Tasking B.V.                                       *
**                                                                        *
**************************************************************************/
#include <stdlib.h>

int
abs( int arg )
{
	if ( arg < 0 )
		arg = -arg;

	return( arg );
}
