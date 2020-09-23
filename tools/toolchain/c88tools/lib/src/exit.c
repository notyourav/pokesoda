/*
 *	Version : %w%  97/01/06
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _exit.c                                                *
**                                                                        *
**  DESCRIPTION :  The exit routine causes normal program termination to  *
**		   occur. First, all functions registered by the atexit	  *
**		   function are called in the reverse order of their      *
**		   registration by the routine _doexit. Next, all open    *
**		   streams with unwritten buffered data are flushed, all  *
**		   open streams are closed and all files created by the   *
**		   tmpfile runction are removed by the routine _cleanup.  *
**		   Control is returned to the "host environment", by      *
**		   calling _exit() which is in the startup module.	  *
**		   The exit status is returned via _exit() function to    *
**		   the "host environment". Passing exit status as return  *
**		   is allowed, because return value status succesful      *
**		   termination and status unsuccesful termination is      *
**		   implementation defined in ANSI-C.			  *
**		   							  *
**  COPYRIGHT   :  1994 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#include <stdlib.h>

#if !defined SMALL && !defined LARGE
#define	SMALL	/* Default for E88 to save code and data space */
#endif

#ifndef SMALL
void	_doexit( void );
void	_cleanup( void );
#endif
void	_exit( int status );

void
exit( int status )
{

#ifndef	SMALL
	/* Execute all stored functions. */
	_doexit();

	/* Flushes all streams, and closes all streams. */
	_cleanup();
#endif
	
	/* Call _exit() function in startup module. */
	_exit( status );
}
