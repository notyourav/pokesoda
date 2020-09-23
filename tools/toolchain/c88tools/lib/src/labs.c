/*
 *	Version : @(#)labs.c	1.3
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _labs.c                                                *
**                                                                        *
**  DESCRIPTION :  Source file for labs() routine                         *
**                 Returns the abs value of the signed long argument.     *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <stdlib.h>

long
labs( long arg ) 
{
	if ( arg < 0 )
		arg = -arg;

	return( arg );
}
