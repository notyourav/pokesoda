/*
 *      Version : @(#)mktime.c  1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  mktime.c                                               *
**                                                                        *
**  DESCRIPTION :  The mktime function converts the broken-down time,     *
**		   expressed as local time, in the structure pointed to   *
**		   by t into a calendar time value with the same encoding *
**		   as that of values returned by the time function, which *
**		   is in seconds.                                         *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <limits.h>
#include <time.h>
#include <stdlib.h>

extern char * _tzget( int );
extern const short int _cumdpm[];

time_t mktime( struct tm *t )
{
	time_t	secs;
	long	days;
	int	mon, 
		year, 
		ymon;
	long	tzoff;
	char	*endptr;

	ymon = t->tm_mon / 12;
	mon = t->tm_mon - ymon * 12;
	if ( mon < 0 )
	{
		mon += 12;
		ymon--;
	}
	if ( ymon < 0 && t->tm_year < INT_MIN - ymon ||
	     ymon > 0 && t->tm_year > INT_MAX - ymon )
	{
		return (time_t) -1;
	}
	year = t->tm_year + ymon;
	/*
	 * Check if the specified time is in the range of time_t,
	 * assuming time_t is a 32 bit unsigned int.
	 */
	if ( year < 70 || (sizeof(time_t) == 4 && year >= 206) )
	{
		return (time_t) -1;
	}
	if ( 0 < year)	/* correct for leap year: 1801-2099 */
	{
		days = (year - 1) / 4;
	}
	else if ( year <= -4)
	{
		days = 1 + (4 - year) / 4;
	}
	else
	{
		days = 0;
	}
	mon = _cumdpm[mon];
	if ( year != 0 && (year & 3) == 0 && mon > 31 )
	{
		mon++;
	}
	days += mon + t->tm_mday - 1;
	secs = 3600UL * t->tm_hour + 60UL * t->tm_min + t->tm_sec;
	secs += 86400UL * days + 31536000UL * year;
	days = secs / 86400;
	t->tm_wday  = (days + 1) % 7;	/* days since Sunday        */
	year = days / 365;
	secs -= _BIAS_TIME;
	if ( year )			/* correct for leap year    */
	{
		days -= ((year - 1) / 4) + 365L * year;
	}
	t->tm_yday  = days;		/* day of the year          */
	/*
	 * correct total seconds with time zone offset
	 */
	tzoff = strtol( _tzget( 2 ), &endptr, 10 );
	if ( tzoff <= -(60*13) || tzoff >= (60*13) )
	{
		tzoff = 0;
	}
	secs -= (tzoff * 60);
	return secs;
}
