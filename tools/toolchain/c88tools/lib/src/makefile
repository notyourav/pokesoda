#----------------------------------------------------------------------
# @(#)makefile	1.4	98/08/18
# Makefile for building libraries.
# 
# Usage: mk88 LIB=libname
#        mk88 LIB=libname clean
# 
# 	Build library specified by:
#         libname  name of the library file
# 
# 	Second form:
# 	Remove created files for specified library.
# 
# Examples:
# 	mk88 LIB=libcs
# 	mk88 LIB=libcs clean
#
# Currently defined libraries:
#	libcs	librts
#	libcc	librtc
#	libcd	librtd
#	libcl	librtl
#----------------------------------------------------------------------

ifndef 	LIB
ALL		: error
else
ALL		: build
endif

CC		= $(PRODDIR)\bin\cc88 -c
AS		= $(PRODDIR)\bin\as88
AR		= $(PRODDIR)\bin\ar88
MODULEDEFS	= $(LIB).mak
OBJDIR		= $(LIB)
OBJDIRSEP	= $(OBJDIR)\\
LIBFILE		= $(LIB).a
SRCDIR		= $(PRODDIR)\lib\src
SRCDIRSEP	= $(SRCDIR)\\

MKDIR		= mkdir
DELTREE		= rm -rf
DELFILE		= rm -f

include		$(MODULEDEFS)


build		: $(OBJDIR) $(SEPOBJ) $(LIBFILE)

$(LIBFILE)	: $(TARGOBJ)
	$(AR)  -rv $@ -f <<EOF
		$(separate "\n" $(match .obj $!))
	EOF

.PRECIOUS	: $(OBJDIR)

$(OBJDIR)	:
	$(nexist $(OBJDIR) $(MKDIR) $(OBJDIR))

clean		:
	-$(DELTREE) $(OBJDIR)
	-$(DELFILE) $(LIBFILE)

error		:


