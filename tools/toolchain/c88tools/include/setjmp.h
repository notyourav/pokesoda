/*
 *	@(#)setjmp.h	1.1
 */

/**************************************************************************
**                                                                        *
**  FILE        :  setjmp.h                                               *
**                                                                        *
**  DESCRIPTION :  Include file with prototypes for non-local jump        *
**                 functions                                              *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#ifndef _SETJMP_H
#define _SETJMP_H

#if _MODEL != 's' && _MODEL != 'c'
#define BUF_SIZ 3
#else
#define BUF_SIZ 2
#endif

typedef int jmp_buf[BUF_SIZ];

int setjmp	( jmp_buf );
void longjmp	( jmp_buf, int );

#endif	/* _SETJMP_H */
