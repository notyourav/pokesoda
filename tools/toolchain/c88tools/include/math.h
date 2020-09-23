/*
 *	@(#)math.h	1.1
 */

/**************************************************************************
**                                                                        *
**  FILE        :  math.h                                                 *
**                                                                        *
**  DESCRIPTION :  Include file with prototypes for mathematical          *
**                 functions                                              *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#ifndef	_MATH_H
#define	_MATH_H

#define	HUGE_VAL	(3.402823E+38F)	  /* FLT_MAX in 'float.h' */

double	sin	( double );
double	cos	( double );
double	tan	( double );
double	asin	( double );
double	acos	( double );
double	atan	( double );
double	atan2	( double, double );
double	sinh	( double );
double	cosh	( double );
double	tanh	( double );
double	exp	( double );
double	log	( double );
double	log10	( double );
double	pow	( double, double );
double	sqrt	( double );
double	ceil	( double );
double	floor	( double );
double	fabs	( double );
double	ldexp	( double, int );
double	frexp	( double, int * );
double	modf	( double, double * );
double	fmod	( double, double );

#endif  /* _MATH_H */
