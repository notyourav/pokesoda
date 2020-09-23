/*
 *	Version : @(#)clock.c	1.1	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  clock.c                                                *
**                                                                        *
**  DESCRIPTION :  The clock function returns the current processor time. *
**		   To determine the time in seconds, the value returned   *
**		   by the clock function should be divided by the value   *
**		   of the macro CLOCKS_PER_SEC, defined in <time.h>.      * 
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <time.h>

static volatile unsigned long ticks;
static	int	running;

static  void timer_handler ( void )
{
	ticks++;
}

void	_timer_start ( void )
{
	ticks = 0;
	running = 1;
}

clock_t	_timer_stop ( void )
{
	running = 0;
	return ticks;		// return # ticks since _timer_start()
}

clock_t	clock ( void )
{
	if	( ! running )
	{
		_timer_start();
	}
	return ticks;
}
