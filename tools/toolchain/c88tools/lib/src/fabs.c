/**************************************************************************
**                                                                        *
**  FILE        :  fabs.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file for fabs() routine                         *
**                 Returns the absolute value of the given 'double'       *
**                                                                        *
**  COPYRIGHT   :  (c) 1999 TASKING, Inc.                                 *
**                                                                        *
**************************************************************************/

#include	<math.h>
#include	<float.h>

double	fabs( double arg )
{
#if _SINGLE_FP
	return copysignf( arg, 1.0 );
#else
	return copysign( arg, 1.0 );
#endif
}


#if 0
	/* here a C implementation */
double
fabs( double arg )
{

	if( arg < 0.0 )
		return( -arg );

	return( arg );
}
#endif
