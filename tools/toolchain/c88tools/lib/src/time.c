/*
 *	Version : @(#)time.c	1.1	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  time.c                                                 *
**                                                                        *
**  DESCRIPTION :  The time function determines the current calendar      *
**		   time in seconds, and stores that value in the location *
**		   pointed to by timer. It also returns this value.       *
**		   The _stime function sets the current calendar time.    *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/
#include <time.h>

static time_t _initial;

time_t
time( time_t *timer )
{
	/* seconds elapsed since 1 January 1970 */
	time_t _elapsed = _initial + (clock() / TICKS_PER_SEC);

	if ( timer )
	{
		*timer = _elapsed;
	}
	return _elapsed;
}

void
_stime( time_t *s )
{
	_initial = *s - (clock() / TICKS_PER_SEC);
	/* initial is current time s - cpu time elapsed. */
}
