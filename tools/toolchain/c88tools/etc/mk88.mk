# @(#)mk88_mk	1.3
# default rules for C-E0C88
#
SHELLCMD=	break call cd chcp chdir cls copy ctty date del dir echo\
		erase exit for goto if md mkdir path pause prompt rd rem\
		ren rename rmdir set shift time type ver verify vol
CP=copy
RM=del

.SUFFIXES:	.c .asm .obj .abs

MAKE	=	mk88
CC	= 	cc88
CCFLAGS =	
CPPFLAGS=
AS	=	cc88
ASFLAGS	=	
LD	=	cc88
LDFLAGS=

.c.obj:
 	$(CC) -c -o $@ $(CCFLAGS) $(CCFLAGS_$*) $(CPPFLAGS) $(CPPFLAGS_$*) $<

.asm.obj:
 	$(AS) -c -o $@ $(ASFLAGS) $(ASFLAGS_$*) $<

.obj.abs:
	$(LD) -o $@ -f <<EOF
		$(separate "\n" $(match .obj $!))
		$(separate "\n" $(match .a $!))
		$(LDFLAGS)
		$(LDFLAGS_$*)
	EOF
