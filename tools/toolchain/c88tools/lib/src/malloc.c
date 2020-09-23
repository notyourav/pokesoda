/*
 *	Version : @(#)malloc.c	1.2
 */

/**************************************************************************
**                                                                        *
**  FILE        :  malloc.c                                               *
**                                                                        *
**  DESCRIPTION :  Source file for malloc()                               *
**                                 calloc()                               *
**                                 free()                                 *
**                                 realloc()                              *
**                                                                        *
**  COPYRIGHT   :  1996 Tasking Software B.V.                             *
**                                                                        *
**************************************************************************/

#include <stdlib.h>
#include <string.h>

/* -------------------- external definitions ------------------ */

extern	char*	sbrk ( int );

/* -------------------- types / macros ------------------------ */

typedef struct s_block	blk;
typedef	char*		addr;

struct	s_block		/* sizeof( blk ) must be multiple of ALIGN ! */
{
	blk*	next;	/* next block on list */
	blk*	prev;	/* previous block or 0 if block is free */
};

struct	s_align
{
	char	c;
	double	d;
};

#define	ALIGN		(sizeof(struct s_align)-sizeof(double))
#define	NOMEM		((char*) -1)	/* sbrk() return value */
#define	SIZE(p)		((addr) p->next - (addr) p)
#define	FPREV(b)	((b+1)->next)	/* 'prev' ptr for free blocks */
#define	glob
#define	loc		static

/* -------------------- prototypes ---------------------------- */

#ifdef	DEBUG
glob	void	malloc_dump ( void );
loc	void	malloc_write ( char* );
#endif

/* -------------------- variables ----------------------------- */

loc	blk	head;		/* head of memory block list */
loc	blk*	last;		/* last memory block */
loc	blk*	start;		/* starting point for block search */

/* -------------------- global functions ---------------------- */

glob	void*	malloc ( size_t size )
{
	blk*	p;
	blk*	new;
	char*	mem;
	int	align;

	if	( size == 0 )
	{
		return (char*) 0;	/* must return 0 according to ANSI */
	}
	if	( size < sizeof( blk* ) )
	{	/* need space for 'prev' pointer if block is free()d */
		size = sizeof( blk* );
	}
	size = (sizeof( blk ) + size + (ALIGN-1)) & ~ (ALIGN-1);
	/* header + requested size + alignment */
	if	( ! start )
	{	/* initialize on first call */
		/* the break may be unaligned; calculate alignment */
		align = (- (int) (long) sbrk( 0 )) & (ALIGN-1);
		mem = sbrk( align + sizeof( blk ) );
		if	( mem == NOMEM )
		{
			return (void*) 0;
		}
		head.prev = head.next = start = last = (blk*) (mem + align);
		last->prev = & head;
	}
	while	( start != last && start->prev )
	{
		start = start->next;
	}
	p = start;
	while	( p != last && (p->prev || size > SIZE( p )) )
	{
		p = p->next;
	}
	if	( p == last )
	{	/* nothing found, so allocate more memory */
		mem = sbrk( size );
		if	( mem == NOMEM )
		{
			return (void*) 0;
		}
		if	( (blk*) mem == last + 1 )
		{	/* new memory is consecutive */
			last = (blk*) ((addr) last + size);
		}
		else if	( (blk*) mem > last + 1 )
		{	/* sbrk() was called, encapsulate the memory */
			/* the break may be unaligned; calculate alignment */
			align = (- (int) (long) mem) & (ALIGN-1);
			p = (blk*) (mem + align);
			mem = sbrk( align + sizeof( blk ) ); /* new header */
			if	( mem == NOMEM )
			{
				return (void*) 0;
			}
			last->next = p;
			p->prev = last;
			last = (blk*) (mem + align);
		}
		else
		{	/* someone called sbrk() with a negative value ! */
			return (void*) 0;
		}
		p->next = last;
		last->prev = p;
	}
	else
	{	/* use free block */
		if	( SIZE( p ) >= size + sizeof( blk ) + sizeof( blk* ) )
		{	/* the free block is big enough to split */
			new = (blk*) ((addr) p + size);
			new->next = p->next;
			new->prev = (blk*) 0;	/* mark as "free" */
			FPREV( new ) = p;	/* use alternative 'prev' */
			p->next = new;
			new->next->prev = new;	/* new->next cannot be free */
		}
		p->prev = FPREV( p );		/* mark as "allocated" */
	}
	return (void*) (p + 1);
}

glob	void*	calloc ( size_t nel, size_t size )
{
	void*	 result;

	size *= nel;
	if	( result = malloc( size ) )
	{
		memset( result, '\0', size );
	}
	return result;
}

glob	void	free ( void* mem )
{
	blk*	curr;
	blk*	prev;
	blk*	next;

	if	( ! mem )
	{
		return;		/* null pointer is allowed by ANSI */
	}
	curr = (blk*) mem - 1;
#ifdef SAFE
	if	(  ! start
		|| ((int) (long) mem & (ALIGN-1))
		|| ! curr->prev
		|| ! curr->next
		|| curr->prev->next != curr
		)
	{
#ifdef DEBUG
		malloc_write( "bad call to free()\n" );
#endif
		/* insert your favorite core dump code here */
		return;
	}
#endif
	prev = curr->prev;	
	FPREV( curr ) = prev;			/* save original prev ptr */
	curr->prev = (blk*) 0;			/* mark block as free */
	/*
	 * join block with predecessor if possible
	 */
	if	( ! prev->prev )
	{	/* previous block is free ==> merge */
		prev->next = curr->next;
		curr = prev;
	}
	/*
	 * join block with successor if possible
	 */
	next = curr->next;
	if	( next == last )
	{	/* this is the last block, try to reduce core */
		prev = FPREV( curr );
		if	(  (blk*) sbrk( 0 ) == last + 1
			&& (addr) sbrk( - SIZE( curr ) ) != NOMEM
			)
		{
			last = curr;
			last->prev = prev;
		}
		else
		{	/* keep the free block at the end */
			last->prev = curr;
		}
	}
	else
	{
		if	( ! next->prev )
		{	/* next block is free ==> merge */
			curr->next = next->next;
		}
		curr->next->prev = curr;
	}
	/*
	 * update 'start'
	 */
	if	( curr < start )
	{
		start = curr;
	}
}

glob	void*	realloc ( void* mem, size_t newsize )
{
	void*	newmem;
	blk*	old;
	size_t	size;

	newmem = malloc( newsize );
	if	( ! mem )
	{	/* ANSI requirement: behave like malloc() */
		return newmem;
	}
	if	( newmem )	/* implies (newsize != 0) */
	{
		old = (blk*) ((addr) mem - sizeof( blk ));
		size = SIZE( old );
		if	( newsize < size )
		{
			size = newsize;
		}
		(void) memcpy( newmem, mem, size );
	}
	if	( newmem || newsize == 0 )
	{
		free( mem );
	}
	return newmem;
}

/* ------------------------------------------------------------ */

#ifdef	DEBUG

#define	PREV(b)	(b->prev ? b->prev : FPREV(b))

loc	void	malloc_write ( char* line )
{
	write( 2, line, strlen( line ) );
}

glob	void	malloc_dump ( void )
{
	blk*	p;
	blk*	top;
	addr	data;
	char	line[80];
	char*	descr;

	if	( ! start )		/* initialize on first call */
	{
		return;
	}
	top = (blk*) sbrk( 0 );
	malloc_write( "--------------- malloc dump --------------\n" );
	for	( p = & head; ; p = p->next )
	{
		data = (addr) p + sizeof( blk );
		descr = "";
		if	( p == & head )
		{
			descr = "(head)";
		}
		else if	( p == last )
		{
			descr = "(last)";
		}
		else if	( ! p->prev )
		{
			descr = "(free)";
		}
		sprintf( line, "%08lx: p=%08lx n=%08lx %c %08lx  %s\n",
			(long) p, (long) p->prev, (long) p->next,
			(p == start ? '*' : ' '),
			(long) data, descr
			);
		malloc_write( line );
		if	( p != & head && PREV(p)->next != p )
		{
			malloc_write( "bad prev pointer\n" );
		}
		if	( p == last )
		{
			break;
		}
		if	( PREV(p->next) != p )
		{
			malloc_write( "bad next pointer\n" );
		}
	}
	malloc_write( "------------------------------------------\n" );
}

#endif
