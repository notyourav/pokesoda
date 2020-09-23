/*
 *	Version : %w% 97/01/06      
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _abort.c                                               *
**                                                                        *
**  DESCRIPTION :  The abort function causes abnormal program termination *
**		   to occur. All open streams with unwritten buffered     *
**		   data are flushed, all open streams are closed and all  *
**		   files created by the function tmpfile function are     *
**		   removed by the routine __cleanup. The unsuccesful	  *
**		   termination code is passed via the _exit() function.   *
**		   And control is returned to the "host environment", by  *
**		   calling _exit() which is in the startup module.	  *
**                                                                        *
**  COPYRIGHT   :  1991 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#include <stdlib.h>

#if !defined SMALL && !defined LARGE
#define	SMALL	/* Default for E88 to save code and data space */
#endif

#ifndef SMALL
void	_cleanup( void );
#endif
void	_exit( int status );

void
abort( void )
{

#ifndef SMALL
	/* Flushes all streams, and closes all streams. */
	_cleanup();
#endif

	/* call _exit() function in startup module. */
	_exit( EXIT_FAILURE );
}

