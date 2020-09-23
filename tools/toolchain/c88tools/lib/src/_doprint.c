/*
 *	@(#)_doprint.c	1.4
 */

/**************************************************************************
**                                                                        *
**  FILE        :  _doprint.c                                             *
**                                                                        *
**  DESCRIPTION :  Source file for _doprint() routine                     *
**                 This routine is used to create all different           *
**                 formatting routines for _printf().                     *
**                 when SMALL is defined, a version without floating      *
**                 point is created, and no length specifiers, etc. are   *
**                 supported.                                             *
**                 when MEDIUM is defined, a version without floating     *
**                 point is created.                                      *
**                 Default, an ANSI version is created.                   *
**                                                                        *
**  NOTE	:  One thing in this formatter (specially designed for	  *
**		   CXA) is the printing of pointer values		  *
**		   '%p' will print a 'default' pointer (ANSI)		  *
**		   '%hp' will always print a '_near' pointer		  *
**		   '%lp' will always print the default pointer		  *
**		   '%Lp' will always print the default pointer		  *
**                                                                        *
**		   Define :                                               *
**		   SMALL  - No floats, no length specifiers               *
**                 MEDIUM - No floats           (default)                 *
**                 LARGE  - Full ANSI formatter				  *
**                                                                        *
**  COPYRIGHT   :  1997 TASKING, Inc.                                     *
**                                                                        *
**************************************************************************/

#include <stdarg.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <string.h>
#include <limits.h>

#if !defined SMALL && !defined MEDIUM && !defined LARGE
#define	MEDIUM  		/* Default formatter */
#endif

/* Print a string (without newline) */
static void _fputs( char *str, FILE *fout, unsigned int *characters );

/* convert an unsigned int to a string			*/
extern char * _ltoa( char *p, unsigned long num, unsigned char radix );

/* Print a character in hexadecimal format */
static void _printhex( unsigned char c, FILE *fout, unsigned int *characters );

#ifndef SMALL
static void _putstring( unsigned char format, int min, int max,
			char *str, FILE *fout, unsigned int *characters );
static void _putnumber( int min, int max, unsigned char ch, unsigned char format,
			void *pvalue, FILE *fout, unsigned int *characters );
#else
#define	_putstring( x, y, z )	_fputs( x, y, z )
static void _putnumber( unsigned char ch, unsigned char format,
			void *pvalue, FILE *fout, unsigned int *characters );
#endif

/* Print one character in hexadecimal format */
static void
_printhex( unsigned char c, FILE *fout, unsigned int *characters )
{
	unsigned char cha;

	*characters += 2;
	cha = (c >> 4) & 0x0F;
	cha += cha > 9 ? 'A'-10 : '0';
	fputc( cha, fout );
	cha = c & 0x0F;
	cha += cha > 9 ? 'A'-10 : '0';
	fputc( cha, fout );
}

/* Floating point formatter */
#ifdef	LARGE
extern void	_doflt( int min, int max, unsigned char ch, unsigned char format,
			double *pvalue, FILE *fout, unsigned int *characters );
#endif

/* does the actual printing	*/
int
_doprint( register const char *fmt, va_list ap, FILE *fout )
{

#ifndef SMALL
	register int min;		/* minimum length of output field */
	register int max;		/* maximum length of output field */
#endif

	register unsigned char ch;	/* character in format string	  */
	register unsigned char format;	/* b6 - left alignment		  */
					/* b5 - zero fill		  */
					/* b4 - alternate print		  */
					/* b3,b2 - 0x04 --> always sign	  */
					/*       - 0x08 --> sign or space */
					/* b1,b0 - 0x01 --> short	  */
					/*       - 0x02 --> long	  */
					/*       - 0x03 --> double	  */
	unsigned char mxflg = 0;	/* Flag if a maximum length */
					/* specifier is found */

	unsigned int characters = 0;	/* no characters written yet	  */

	for( ;; )
	{
		ch = *fmt++;
		if( !ch )
		{
			return( characters );
		}
		else if( ch == '%' )
		{
			if( *fmt != '%' )
				goto nxt;
			fmt++;
		}
		characters++;
		fputc( ch, fout );
		continue;

		nxt:

#ifndef SMALL
		format = min = max = 0;
#else
		format = 0;
#endif

#ifndef SMALL
		while( 1 )
		{
			ch = *fmt++;
			if( ch == '-' )
				format |= 0x40;	/* left alignment */
			else if( ch == '+' )
				format = (format & 0xF3) | 0x04;
			else if( ch == ' ' )
			{
				/* do not overrule '+'	*/
				if( !(format & 0x0C) )
					format |= 0x08;	/* sign or space */
			}
			else if( ch == '0' )
				format |= 0x20;	/* zero fill */
			else if( ch == '#' )
				format |= 0x10;	/* alternate print */
			else
				break;
		}

		if( ch == '*' )
		{	/* next argument is minimum field width specifier */
			min = va_arg( ap, int );
			if( min < 0 )
			{
				format |= 0x40;
				min = -min;
			}
			ch = *fmt++;
		}
		else
		{
			while( ch >= '0' && ch <= '9' )
			{	/* get minimum field width */
				min = min * 10 + ch - '0';
				ch = *fmt++;
			}
		}
		if( ch == '.' )
		{	/* next argument is maximum field width specifier */
			format &= ~0x20;	/* zero fill must be disabled */
			mxflg = 1;		/* read a value for 'max' */
			if( (ch = *fmt++) == '*' )
			{
				max = va_arg( ap, int );
				if( max < 0 )
				{
					format |= 0x40;
					max = -max;
				}
				ch = *fmt++;
			}
			else
			{
				while( ch >= '0' && ch <= '9' )
				{	/* get maximum field width */
					max = max * 10 + ch - '0';
					ch = *fmt++;
				}
			}
		}
#else
		ch = *fmt++;
#endif

		do
		{
			if( ch == 'l' )
			{
				format |= 0x02;
			}
			else if( ch == 'h' )
			{
				format |= 0x01;
			}
			else if( ch == 'L' )
			{
				format |= 0x03;
			}
			else
				continue;

			ch = *fmt++;
		} while( 0 );

		if( ch == 'c' || ch == 'd' || ch == 'i' || ch == 'o' ||
		    ch == 'x' || ch == 'X' || ch == 'u' )
		{
			/* character			*/
			/* signed decimal integer	*/
			/* unsigned octal int		*/
			/* unsigned hexadecimal int	*/
			/* unsigned decimal int		*/
			/* int, single character	*/
#ifndef SMALL
			_putnumber( min, max, ch, format,
				    (format & 0x03) == 0x02 ?
					(void *)&va_arg( ap, long ) :
					(void *)&va_arg( ap, int ),
				    fout, &characters );
#else
			_putnumber( ch, format,
				    (format & 0x03) == 0x02 ?
					(void *)&va_arg( ap, long ) :
					(void *)&va_arg( ap, int ),
				    fout, &characters );
#endif
		}
		else if( ch == 's' )
		{
			/* string */
#ifndef SMALL
			_putstring( format, min, max, va_arg( ap, char * ),
				    fout, &characters );
#else
			_putstring( va_arg( ap, char * ), fout, &characters );
#endif
		}

		else if( ch == 'f' || ch == 'e' || ch == 'E' ||
			 ch == 'g' || ch == 'G' )
		{
			/* floating point	*/
#ifdef LARGE		/* Only supported on 'LARGE' formatter */
			if( !mxflg )
				max = 6;
			_doflt(	min, max, ch, format, (double *)&va_arg( ap, double ), 
				fout, &characters );
#else
			/* Just print we do not support floating point values */
			_fputs( "<no floats>", fout, &characters );
			/* select next argument	*/
			va_arg( ap, double );	
#endif
		}

		else if( ch == 'p' )
		{
			/* At this point, (format & 0x03) represents : 	*/
			/*	0x01 -> _near pointer (%p or %hp)	*/
			/*	0x02 -> default pointer  (%p or %lp)	*/
			/*	0x03 -> not used (%Lp)    		*/

#ifndef	SMALL
                    /* misuse 'max' */
#if _MODEL == 's' || _MODEL == 'd'
                    max = 6;
#else
                    max = 8;
#endif
                    if ( (format & 0x03) == 0x01 )
                        max = 13;
                    else if ( (format & 0x03) == 0x02 )
                        max = 14;

                    if( !(format & 0x40) )
                    {	/* right alignment ?	*/
                        for( ; min>max; --min )
                        {
                            characters++;
                            fputc( ' ', fout );
                        }
                    }
#endif
                        if ( (format & 0x03) == 0x01 )
                            _fputs( "<_near>", fout, &characters );
                        else if ( (format & 0x03) == 0x02)
                            _fputs( "<_far>", fout, &characters );
			_fputs( "0x", fout, &characters );

			{
                            register unsigned long value;
#if _MODEL == 's' || _MODEL == 'd'
                            value = ( (format & 0x03) != 0x02 )
                                ? (unsigned long)va_arg( ap, _near void * )
                                : (unsigned long)va_arg( ap, _far void * );
#else
                            value = ( (format & 0x03) != 0x01 )
                                ? (unsigned long)va_arg( ap, _far void * )
                                : (unsigned long)va_arg( ap, _near void * );
#endif

#if _MODEL == 's' || _MODEL == 'd'
                            if( (format & 0x03) == 0x02 )
                            {
                                _printhex( (value >> 16), fout, &characters);
                            }
#else
                            if( (format & 0x03) != 0x01 )
                            {
                                _printhex( (value >> 16), fout, &characters);
                            }
#endif                              
                            _printhex( (value >> 8), fout, &characters );
                            _printhex( value, fout, &characters );
			}
#ifndef	SMALL
			for( ; min>max; --min )
			{
				characters++;
				fputc( ' ', fout );
			}
#endif

		}

		else if( ch == 'n' )
		{
			*(va_arg( ap, int * )) = characters;
		}
		else
		{
			errno = ERR_FORMAT;	/* illegal format string */
			return( characters );
		}
	}
}

/* prints a string to the output					  */
/* when 'min' > 'max', the result is undefined				  */
/* when 'left' != 0, left alignment is done				  */
/* when min=0, and max=0, strings are printed normal			  */
/* length of the strings are supposed to be SMALLer than 30000 characters */
#ifndef SMALL	/* For 'SMALL', _fputs() is called instead of _putstring  */
static void
_putstring(	unsigned char format, register int min, register int max,
		register char *str, FILE *fout, unsigned int *characters )
{
	register int length = 0;

	if( !max )
		max = 30000;

	length = strlen( str );
	if ( format & 0x80 )	/* Printing a character, make sure to output the character (e.g. NULL byte) */
	{
		length = 1;
	}

	if( !(format & 0x40) )		/* right alignment ? */
	{
		for( ; min>length || min>max; --min )
		{
			(*characters)++;
			fputc( ' ', fout );
		}
	}

	while( max-- && (*str || (format & 0x80)) )		/* print string	*/
	{
		(*characters)++;
		fputc( *str++, fout );
		if( min )
			min--;	/* min will contain the minimum number	*/
				/* of characters to print afterwards	*/
		format &= ~0x80;
	}

	while( min-- )
	{
		(*characters)++;
		fputc( ' ', fout );		/* padding spaces */
	};
}
#endif	/* SMALL */

static void
#ifndef SMALL
_putnumber(	int min, int max, unsigned char ch, unsigned char format,
		void *pvalue, FILE *fout, unsigned int *characters )
#else
_putnumber(	unsigned char ch, unsigned char format, void *pvalue,
		FILE *fout, unsigned int *characters )
#endif
{
	char buf[15+3];			/* room to print long value in	*/
	register char *buffer;		/* help variable	*/

	register long value = 0;

#ifndef SMALL
	register char length = 0;	/* length needed to print value	*/
#endif

	register unsigned char vsign;	/* sign of the value	*/

	if( !(format & 0x02) )		/* 'h' or default, same as -->	*/
					/* (!(format & 0x03) ||		*/
					/* (format & 0x03) == 0x01)	*/
	{	/* short value is the same as int	*/
		value = *(int *)pvalue;
		if( ch != 'd' && ch != 'i' )	/* not a signed integer ? */
			value &= UINT_MAX;	/* truncate to positive   */
						/* integer */
	}
	else if( (format & 0x03) == 0x02 )	/* 'l'	*/
	{
		value = *(long *)pvalue;
	}
	;

	vsign = 0;	/* 0 - positive value, otherwise negative value */

	if( ch == 'c' )
	{
		buf[0] = value;
		buf[1] = '\0';
		format |= 0x80;	/* Make sure one character is printed */
	}
	else if( ch == 'd' || ch == 'i' )
	{
		if( value < 0 )
		{
			vsign = '-';
			value = -value;
		}
		goto unsignedint;
	}
	else if( ch == 'u' )
	{
		unsignedint:

		_ltoa( buf, value, 10 );	/* convert to ascii	*/

#ifndef SMALL
		length = strlen( buf );

		if( !vsign )
		{
			if( (format & 0x0C) == 0x04 )	/* sign always	*/
				vsign = '+';
			else if( (format & 0x0C) == 0x08 ) /* sign or space */
				vsign = ' ';
		}

		if( vsign )
		{
			if( min )
				--min;
		}

		if( vsign && (format & 0x60) )	/* ( (format & 0x20) || */
		{				/* (format & 0x40) )	*/
			(*characters)++;
			fputc( vsign, fout );
			vsign = 0;
		}

		if( !(format & 0x40) )	/* right alignment ? */
		{
			while( (min > max) && (min > length) )
			{
				(*characters)++;
				fputc( (format & 0x20) ? '0' : ' ', fout );
				min--;
			}
		}

#endif

		if( vsign )
		{
			(*characters)++;
			fputc( vsign, fout );
		}

#ifndef	SMALL
		while( max-- > length )
		{
			(*characters)++;
			fputc( '0', fout );
			if( min )
				min--;
		}
#endif
	}
	else if( ch == 'o' || ch == 'x' || ch == 'X' )
	{

		_ltoa( buf, value, ch == 'o' ? 8 : 16 );

		if( ch == 'x' )
		{
			/* convert string to lowercase	*/
			for( buffer = buf; *buffer; ++buffer )
			{	/* do not use 'tolower' */
				if( *buffer >= 'A' && *buffer <= 'Z' )
					*buffer += 'a' - 'A';
			}
		}

#ifndef SMALL
		length = strlen( buf );

		if( ! value )
			format &= 0xEF;	/* clear alternate when value is '0' */

		if( (format & 0x10) )	/* alternate */
		{
			if( format & 0x20 )	/* alternate and filling from */
			{			/* the left with zeros	*/
				if( ch != 'o' )
				{
					*characters += 2;
					fputc( '0', fout );	/* leading 0 */
					fputc( ch, fout );
				}
				format &= 0xEF;	/* clear alternate */
			}

			if( ch == 'o' )
			{
				if( max )
					max++;
				if( max <= length )
					max = length+1;
			}
		}

		if( !(format & 0x40) )		/* right alignment	*/
		{
			while( (min > max) && (min > length) )
			{
				(*characters)++;
				fputc( (format & 0x20) ? '0' : ' ', fout );
				min--;
			}
		}

		if( (format & 0x10) && (ch != 'o') )
		{
			*characters += 2;
			fputc( '0', fout );	/* leading 0 */
			fputc( ch, fout );	/* and 'x' */
		}

		while( max-- > length )
		{
			(*characters)++;
			fputc( '0', fout );
			if( min )
				min--;
		}
#endif
	}

#ifndef SMALL
	/* now print the ascii value, padded with spaces */
	_putstring( format, min, 0, buf, fout, characters );
#else
	/* now print the ascii value	*/
	_putstring( buf, fout, characters );
#endif
}

/* print only a string to the output					*/
/* When the 'SMALL' formatter is requested, _fputs() is called for	*/
/* _printstring()							*/
static void
_fputs( char * str, FILE * fout, unsigned int *characters )
{
	while( *str )
	{
		(*characters)++;
		fputc( *str, fout );
		str++;
	}
}
