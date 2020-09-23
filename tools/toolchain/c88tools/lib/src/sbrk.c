/*
 *	Version : @(#)sbrk.c	1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _sbrk.c                                                *
**                                                                        *
**  DESCRIPTION :  Source file for sbrk()                                 *
**                                 brk()                                  *
**                                                                        *
**  COPYRIGHT   :  1997 TASKING, Inc.                                     *
**                                                                        *
**************************************************************************/

extern	char	_lc_bh[];
extern	char	_lc_eh[];

static	char*	breakaddr = & _lc_bh;

char*	brk ( char* newbreak )
{
	if	( newbreak < & _lc_bh )
	{
		return (char*) 0;
	}
	if	( newbreak > & _lc_eh )
	{
		return (char*) -1;
	}
	return (breakaddr = newbreak);
}

char*	sbrk ( int incr )
{
	char*	old;
	char*	new;
	
	if ( incr > 0 )			/* malloc */
	{
		if ( (unsigned long)(& _lc_eh - breakaddr) < incr )
		{
			return (char*) -1;			
		}
	}
	else if ( incr < 0 )		/* free */
	{
		if ( (unsigned long)(breakaddr - & _lc_bh) < -incr )
		{
			return (char*) -1;			
		}		     
	}
	
	old = breakaddr;
	
	new = brk( breakaddr + incr );
	
	if	( new == (char*) 0 || new == (char*) -1 )
	{
		return (char*) -1;
	}
	
	return old;
}
