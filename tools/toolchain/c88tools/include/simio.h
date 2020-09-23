/*
 *	@(#)simio.h	1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  simio.h                                                *
**                                                                        *
**  DESCRIPTION :  Include file with prototypes and macros for            *
**                 simulated input and output for CrossView               *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#ifndef	_SIMIO_H
#define	_SIMIO_H

int	_simi	( unsigned stream, char * port, unsigned len );
int	_simo	( unsigned stream, char * port, unsigned len );

#endif	/* _SIMIO_H */
