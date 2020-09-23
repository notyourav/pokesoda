/**************************************************************************
**                                                                        *
**  FILE        :  sqrt.c                                                 *
**                                                                        *
**  DESCRIPTION :  Source file for sqrt() routine                         *
**                 Computes the 'square' root for the given value         *
**                                                                        *
**  COPYRIGHT   :  (c) 1999 TASKING, Inc.                                 *
**                                                                        *
**  Based on Cephes Math Library Release 2.2:  June, 1992 ( Copyright     *
**  1984, 1987, 1988, 1992 by Stephen L. Moshier )                        *
**                                                                        *
**************************************************************************/

#include <math.h>
#include <errno.h>
#include <stdlib.h>
#include <float.h>

#ifndef SQRT2
/* sqrt(2) */
#if _SINGLE_FP
#define SQRT2 1.41421356237
#else
#define SQRT2 1.41421356237309504880
#endif
#endif

double
sqrt( double arg )
{
	int	e;
	double	z, w;

	if ( arg <= 0.0 )
	{
		if ( arg < 0.0 )
#if _IEEE_754_FORMAT
		{
			errno = EDOM;
			{
#if _SINGLE_FP
			float2long_t	u;

			u.l = 0xffffffff;

			return u.f;
#else
			double2longs_t	u;

			u.s.lo = 0xffffffff;
			u.s.hi = 0xffffffff;

			return u.d;
#endif
			}
		}
		else
		{
			return( 0.0 );
		}
#else
		{
			errno = EDOM;
		}
		return( 0.0 );
#endif
	}

	/* separate exponent and significand */
	z = frexp( arg, &e );

#if _SINGLE_FP
	if ( e & 1 )
	{
		z += z;
		e--;
	}

	e >>= 1;

	if ( z > SQRT2 )
	{
		/* z is between sqrt(2) and 2. */
		z -= 2.0;
		w =
		((((( -9.8843065718E-4 * z
		  + 7.9479950957E-4) * z
		  - 3.5890535377E-3) * z
		  + 1.1028809744E-2) * z
		  - 4.4195203560E-2) * z
		  + 3.5355338194E-1) * z
		  + SQRT2;
		goto sqdon;
	}

	if( z > 0.707106781187 )
	{
		/* z is between sqrt(2)/2 and sqrt(2). */
		z -= 1.0;
		w =
		((((( 1.35199291026E-2 * z
		  - 2.26657767832E-2) * z
		  + 2.78720776889E-2) * z
		  - 3.89582788321E-2) * z
		  + 6.24811144548E-2) * z
		  - 1.25001503933E-1) * z * z
		  + 0.5 * z
		  + 1.0;
		goto sqdon;
	}

	/* z is between 0.5 and sqrt(2)/2. */
	z -= 0.5;
	w =
	((((( -3.9495006054E-1 * z
	  + 5.1743034569E-1) * z
	  - 4.3214437330E-1) * z
	  + 3.5310730460E-1) * z
	  - 3.5354581892E-1) * z
	  + 7.0710676017E-1) * z
	  + 7.07106781187E-1;

sqdon:
	arg = ldexp( w, e );

#else
	w = arg;

	/* approximate square root of number between 0.5 and 1
	 * relative error of approximation = 7.47e-3
	 */
	arg = 4.173075996388649989089E-1 + 5.9016206709064458299663E-1 * z;

	/* adjust for odd powers of 2 */
	if( (e & 1) != 0 )
		arg *= SQRT2;

	/* re-insert exponent */
	arg = ldexp( arg, (e >> 1) );

	/* Newton iterations: */
	arg = 0.5*(arg + w/arg);
	arg = 0.5*(arg + w/arg);
	arg = 0.5*(arg + w/arg);
#endif
	return(arg);

}
