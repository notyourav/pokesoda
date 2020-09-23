/*
 *	Version : @(#)longjmp.c	1.6
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _longjmp.c                                             *
**                                                                        *
**  DESCRIPTION :  Source file for longjmp function                       *
**		   The longjmp function restores the environment saved by *
**		   the most recent invocation of the program, with the    *
**		   corresponding jmp_buf argument. The longjmp function   *
**		   causes setjmp to return "val". The		 	  *
**		   longjmp function cannot cause setjmp to return the	  *
**		   value 0. If "val" is 0, then setjmp returns 1.	  *
**									  *
**	all models                                                        *
**                 iy/yp  -- env                                          *
**                 ba     -- val                                          *
**		   env[0] -- SP                                           *
**		   env[1] -- return address PC (16-bits)	       	  *
**		   env[2] -- return address PC          	       	  *
**            compact data/large:                                         *
**                 env[3] -- return address PC (code bank)                *
**									  *
**  COPYRIGHT   :  1997 TASKING, Inc.                                     *
**                                                                        *
**************************************************************************/
#include	<setjmp.h>

void longjmp( jmp_buf env, int val )
{
 	env;	/* to prevent warning W068: parameter "env" not used	*/
	val;    /* to prevent warning W068: parameter "val" not used	*/

#pragma	asm
	; ba contains result value
        LD      hl, [iy]
        LD      sp, hl			; restore sp
        ADD     iy, #2
        LD      hl, [iy]
        LD      [sp], hl		; restore pc
#if _MODEL == 'd' || _MODEL == 'l'
        LD      hl,[sp+2]
        ADD     iy, #2
        LD      l, [iy]
        LD      [sp+2],hl		; restore code bank
#endif

        CP      ba, #0
        JRS     NZ, _exit		; val already in ba
        LD      ba, #1
 _exit:
#pragma	endasm
}
