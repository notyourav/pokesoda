/*
 *	@(#)freopen.c	1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  freopen.c                                              *
**                                                                        *
**  DESCRIPTION :  Source file for freopen() routine                      *
**                 Flushes the given stream, closes it and opens it again *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include	<stdio.h>

FILE *
freopen( const char * file, const char * mode, FILE * iop )
{
	short	mybuf = iop->_flag & _IOMYBUF;

	iop->_flag &= ~_IOMYBUF;	/* So fclose will not 'free' an allocated buffer */
	fclose( iop );
	iop->_flag |= mybuf;
	return( _open( (char *)file, (char *)mode, iop ) );
}
