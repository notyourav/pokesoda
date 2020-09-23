/*
 *	Version : @(#)setjmp.c	1.7
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _setjmp.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for setjmp function                        *
**		   The setjmp function saves its calling environment in   *
**		   its jmp_buf for later use by the longjmp function.     *
**		   If the return is from a direct invocation, the setjmp  *
**		   function returns zero. If the return is from a call to *
**		   the longjmp, the setjmp function returns a nonzero	  *
**		   value.						  *
**	all models                                                        *
**                 yp, iy -- env                                          *
**		   env[0] -- SP                                           *
**		   env[1] -- return address PC (16-bits)	       	  *
**		   env[2] -- return address PC                            *
**            compact data/large:                                         *
**                 env[3] -- return address PC (code bank)                *
**									  *
**  COPYRIGHT   :  1997 TASKING, Inc.                                     *
**                                                                        *
**************************************************************************/
#include	<setjmp.h>

int setjmp( jmp_buf env )
{
 	env;	/* to prevent warning W068: parameter "env" not used	*/

#pragma	asm
	; &env in 'iy/yp'
        LD      ba, sp
        LD      [iy], ba                                    ;  save sp
        ADD     iy, #2 
        LD      ba, [sp] 
        LD      [iy], ba                                    ;  save return address
#if _MODEL == 'd' || _MODEL == 'l'
        ADD     iy, #2 
        LD      ba, [sp+2] 
        LD      [iy], a                                     ;  save code bank 
#endif
#pragma	endasm

	return( 0 );
}
