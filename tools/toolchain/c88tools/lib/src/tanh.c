/**************************************************************************
**                                                                        *
**  FILE        :  tanh.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file for tanh() routine                         *
**                 Computes the 'hyperbolic tangent' for the given angle  *
**                 (in radians)                                           *
**                                                                        *
**  COPYRIGHT   :  (c) 1999 TASKING, Inc.                                 *
**                                                                        *
**************************************************************************/

#include <math.h>

double
tanh( double arg )
{
	double sign;

	sign = 1.0;
	if( arg < 0.0 )
	{
		arg = -arg;
		sign = -1.0;
	}

	if( arg > 37.0 )
		return( sign );

	return( sign * sinh( arg ) / cosh( arg ) );
}
