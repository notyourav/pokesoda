/*
 *	@(#)stdarg.h	1.4
 */

/**************************************************************************
**                                                                        *
**  FILE        :  stdarg.h                                               *
**                                                                        *
**  DESCRIPTION :  Include file with prototypes and macros for usage with *
**                 variable argument lists                                *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#ifndef _STDARG_H
#define _STDARG_H

#define NULL	0
typedef void * va_list[1];

#define va_start( _ap, _lastarg )	( _ap[0] = ( ((char *) (&_lastarg)) + sizeof(_lastarg) ) )
#define va_arg( _ap, _type )		( * (*(_type **)_ap)++ )
#define va_end( _ap )			( _ap[0] = NULL )

#endif	/* _STDARG_H */ 
