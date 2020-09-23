/*
 *      Version : @(#)gmtime.c  1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  gmtime.c                                               *
**                                                                        *
**  DESCRIPTION :  The gmtime function converts the calendar time pointed *
**		   to by t into a broken-down time, expressed as          *
**		   Coordinated Universal Time (UTC).                      *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <time.h>

const short int _cumdpm[] =
{
	/* jan  feb  mar  apr  may  jun  jul  aug  sep  oct  nov  dec */
	     0,  31,  59,  90, 120, 151, 181, 212, 243, 273, 304, 334
};

struct tm *gmtime( const time_t *t )
{
	static struct tm ts;
	unsigned long	day;
	short int	i;

	day = (*t / 86400UL) + 365;
	ts.tm_wday = (day + 3) % 7;
	ts.tm_year = 68 + (int) (((day + 366L) << 2) / 1461);
	day %= 1461;
	ts.tm_yday = (day == 1460) ? 365 : day % 365;
	ts.tm_mday = 1;
	if (day > 1153) 
	{
		day--;
		if (day == 1153)
		{
			ts.tm_mday = 2;
		}
	}
	day %= 365;
	for ( i = 11; i; i--)
	{
		if (day >= _cumdpm[i])
		{
			break;
		}
	}
	ts.tm_mday += day - _cumdpm[i];
	ts.tm_mon = i;
	ts.tm_hour = (*t % 86400) / 3600;
	i = *t % 3600L;
	ts.tm_min = i / 60;
	ts.tm_sec = i % 60;
	ts.tm_isdst = -1;
	return &ts;
}
