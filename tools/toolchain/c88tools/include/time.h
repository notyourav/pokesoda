/*
 *	@(#)time.h	1.1
 */

/**************************************************************************
**                                                                        *
**  FILE        :  time.h                                                 *
**                                                                        *
**  DESCRIPTION :  Include file with prototypes and macros for            *
**                 manipulating time.                                     *
**                 The low level time routine clock() strongly depends on *
**                 the hardware (e.g. RTC-hardware), so this routine may  *
**		   have to be customised. To determine the time in        *
**		   seconds, the value returned by clock() should be       *
**		   divided by the value of the macro TICKS_PER_SEC.       *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#ifndef _TIME_H
#define _TIME_H

#include <stddef.h>

typedef unsigned long	time_t;
typedef unsigned long	clock_t;

#define TIME_MAX (time_t)(-1)
#define TIME_MIN (time_t)(0)

/* starting point for calendar times
 * time is measured in seconds since 
 * 1 January 1970 
 */
#define _BIAS_TIME ((70 * 365LU + 17) * 86400)

#define TICKS_PER_SEC   1000	/* clock() result is in ms */
                                
#define CLOCKS_PER_SEC  TICKS_PER_SEC

struct tm
{
	int	tm_sec;		/* seconds after the minute - [0, 59]   */
	int	tm_min;		/* minutes after the hour - [0, 59]     */
	int	tm_hour;	/* hours since midnight - [0, 23]       */
	int	tm_mday;	/* day of the month - [1, 31]           */
	int	tm_mon;		/* months since January - [0, 11]       */
	int	tm_year;	/* year since 1900                      */
	int	tm_wday;	/* days since Sunday - [0, 6]           */
	int	tm_yday;	/* days since January 1 - [0, 365]      */
	int	tm_isdst;	/* Daylight Saving Time flag            */
};

char *		asctime		( const struct tm * );
char *		ctime		( const time_t * );
double		difftime	( time_t, time_t );
struct tm *	gmtime		( const time_t * );
struct tm *	localtime	( const time_t * );
time_t		time		( time_t * );
time_t		mktime		( struct tm * );
clock_t		clock		( void );		/* low level function */
void		_timer_start	( void );		/* start timer */
clock_t		_timer_stop	( void );		/* stop timer, return elapsed time */
size_t		strftime	( char *, size_t, const char *, const struct tm * );

void		_stime		( time_t * );		/* sets system time */
int		_tzset		( const char * );	/* sets time zone */

#endif	/* _TIME_H */
