/*
 *	Version : @(#)_itoa.c	1.2	
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _itoa.c                                                *
**                                                                        *
**  DESCRIPTION :  Source file for _itoa() routine                        *
**                 This routine converts the given integer to an ascii    *
**                 string (buffer must be given as an argument).          *
**                 Used by _doprint() routines.                           *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

char *
_itoa( char *p, unsigned int num, unsigned char radix )
{
	register unsigned int i;
	register char *q;
	register char *hold;

	hold = p;
	q = p + 12;

	*--q = '\0';		/* be sure to terminate the string with a NULL character	*/

	do
	{
		i = (num % radix) + '0';
		if( i > '9' )
			i+='A'-'0'-10;
		*--q = i;
	} while( num /= radix );

	for( ; (*p++ = *q++); )	/* move the string to the left, including the NULL character	*/
		;

	return( hold );
}
