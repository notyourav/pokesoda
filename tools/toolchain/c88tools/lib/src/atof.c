/*
 *	Version : @(#)atof.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  atof.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file for atof() routine                         *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <stdlib.h>

double
atof( register const char *p )
{
	return( strtod( p, NULL ) );
}
