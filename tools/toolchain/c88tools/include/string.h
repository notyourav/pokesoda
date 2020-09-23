/*
 *	@(#)string.h	1.1
 */

/**************************************************************************
**                                                                        *
**  FILE        :  string.h                                               *
**                                                                        *
**  DESCRIPTION :  Include file with prototypes of functions for          *
**                 string handling and memory checking/movement           *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V., Amersfoort                 *
**                                                                        *
**************************************************************************/

#ifndef _STRING_H
#define _STRING_H

#ifndef _SIZE_T_DEF
typedef unsigned int	size_t;
#define _SIZE_T_DEF
#endif

#define NULL	0

char *	strcpy	( char *, const char * );
char *	strncpy	( char *, const char *, size_t );
char *	strcat	( char *, const char * );
char *	strncat	( char *, const char *, size_t );
char *	strchr	( const char *, int );
char *	strrchr	( const char *, int );
size_t	strspn	( const char *, const char * );
size_t	strcspn	( const char *, const char * );
char *	strpbrk	( const char *, const char * );
char *	strstr	( const char *, const char * );
char *	strtok	( char *, const char * );
int	strcmp	( const char *, const char * );
int	strncmp	( const char *, const char *, size_t );
size_t	strlen	( const char * );
void *	memcpy	( void *, const void *, size_t );
void *	memmove	( void *, const void *, size_t );
void *	memchr	( const void *, int, size_t );
void *	memset	( void *, int, size_t );
int	memcmp	( const void *, const void *, size_t );
char *	strerror( int );
int	strcoll	( const char *, const char * );
size_t	strxfrm	( char *, const char *, size_t );

#endif	/* _STRING_H */
