#
# libcs.mak
# module definitions for lib\libcs.a
#
ASFLAGS = -I$(SRCDIRSEP) -O -Ms
CFLAGS  = -I$(SRCDIRSEP) -D_SINGLE_FP -Ms

TARGOBJ += $(OBJDIRSEP)locale.obj
$(OBJDIRSEP)locale.obj: $(SRCDIRSEP)locale.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)locale.obj $(SRCDIRSEP)locale.c

TARGOBJ += $(OBJDIRSEP)signal.obj
$(OBJDIRSEP)signal.obj: $(SRCDIRSEP)signal.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)signal.obj $(SRCDIRSEP)signal.c

TARGOBJ += $(OBJDIRSEP)raise.obj
$(OBJDIRSEP)raise.obj: $(SRCDIRSEP)raise.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)raise.obj $(SRCDIRSEP)raise.c

TARGOBJ += $(OBJDIRSEP)toupper.obj
$(OBJDIRSEP)toupper.obj: $(SRCDIRSEP)toupper.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)toupper.obj $(SRCDIRSEP)toupper.c

TARGOBJ += $(OBJDIRSEP)tolower.obj
$(OBJDIRSEP)tolower.obj: $(SRCDIRSEP)tolower.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)tolower.obj $(SRCDIRSEP)tolower.c

TARGOBJ += $(OBJDIRSEP)isalpha.obj
$(OBJDIRSEP)isalpha.obj: $(SRCDIRSEP)isalpha.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isalpha.obj $(SRCDIRSEP)isalpha.c

TARGOBJ += $(OBJDIRSEP)isupper.obj
$(OBJDIRSEP)isupper.obj: $(SRCDIRSEP)isupper.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isupper.obj $(SRCDIRSEP)isupper.c

TARGOBJ += $(OBJDIRSEP)islower.obj
$(OBJDIRSEP)islower.obj: $(SRCDIRSEP)islower.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)islower.obj $(SRCDIRSEP)islower.c

TARGOBJ += $(OBJDIRSEP)isdigit.obj
$(OBJDIRSEP)isdigit.obj: $(SRCDIRSEP)isdigit.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isdigit.obj $(SRCDIRSEP)isdigit.c

TARGOBJ += $(OBJDIRSEP)isxdigit.obj
$(OBJDIRSEP)isxdigit.obj: $(SRCDIRSEP)isxdigit.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isxdigit.obj $(SRCDIRSEP)isxdigit.c

TARGOBJ += $(OBJDIRSEP)isspace.obj
$(OBJDIRSEP)isspace.obj: $(SRCDIRSEP)isspace.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isspace.obj $(SRCDIRSEP)isspace.c

TARGOBJ += $(OBJDIRSEP)ispunct.obj
$(OBJDIRSEP)ispunct.obj: $(SRCDIRSEP)ispunct.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ispunct.obj $(SRCDIRSEP)ispunct.c

TARGOBJ += $(OBJDIRSEP)isalnum.obj
$(OBJDIRSEP)isalnum.obj: $(SRCDIRSEP)isalnum.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isalnum.obj $(SRCDIRSEP)isalnum.c

TARGOBJ += $(OBJDIRSEP)isprint.obj
$(OBJDIRSEP)isprint.obj: $(SRCDIRSEP)isprint.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isprint.obj $(SRCDIRSEP)isprint.c

TARGOBJ += $(OBJDIRSEP)isgraph.obj
$(OBJDIRSEP)isgraph.obj: $(SRCDIRSEP)isgraph.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isgraph.obj $(SRCDIRSEP)isgraph.c

TARGOBJ += $(OBJDIRSEP)iscntrl.obj
$(OBJDIRSEP)iscntrl.obj: $(SRCDIRSEP)iscntrl.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)iscntrl.obj $(SRCDIRSEP)iscntrl.c

TARGOBJ += $(OBJDIRSEP)isascii.obj
$(OBJDIRSEP)isascii.obj: $(SRCDIRSEP)isascii.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)isascii.obj $(SRCDIRSEP)isascii.c

TARGOBJ += $(OBJDIRSEP)toascii.obj
$(OBJDIRSEP)toascii.obj: $(SRCDIRSEP)toascii.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)toascii.obj $(SRCDIRSEP)toascii.c

TARGOBJ += $(OBJDIRSEP)_ctype.obj
$(OBJDIRSEP)_ctype.obj: $(SRCDIRSEP)_ctype.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_ctype.obj $(SRCDIRSEP)_ctype.c

TARGOBJ += $(OBJDIRSEP)malloc.obj
$(OBJDIRSEP)malloc.obj: $(SRCDIRSEP)malloc.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)malloc.obj $(SRCDIRSEP)malloc.c

TARGOBJ += $(OBJDIRSEP)atoi.obj
$(OBJDIRSEP)atoi.obj: $(SRCDIRSEP)atoi.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)atoi.obj $(SRCDIRSEP)atoi.c

TARGOBJ += $(OBJDIRSEP)atol.obj
$(OBJDIRSEP)atol.obj: $(SRCDIRSEP)atol.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)atol.obj $(SRCDIRSEP)atol.c

TARGOBJ += $(OBJDIRSEP)_itoa.obj
$(OBJDIRSEP)_itoa.obj: $(SRCDIRSEP)_itoa.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_itoa.obj $(SRCDIRSEP)_itoa.c

TARGOBJ += $(OBJDIRSEP)_ltoa.obj
$(OBJDIRSEP)_ltoa.obj: $(SRCDIRSEP)_ltoa.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_ltoa.obj $(SRCDIRSEP)_ltoa.c

TARGOBJ += $(OBJDIRSEP)exit.obj
$(OBJDIRSEP)exit.obj: $(SRCDIRSEP)exit.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)exit.obj $(SRCDIRSEP)exit.c

TARGOBJ += $(OBJDIRSEP)abort.obj
$(OBJDIRSEP)abort.obj: $(SRCDIRSEP)abort.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)abort.obj $(SRCDIRSEP)abort.c

TARGOBJ += $(OBJDIRSEP)abs.obj
$(OBJDIRSEP)abs.obj: $(SRCDIRSEP)abs.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)abs.obj $(SRCDIRSEP)abs.c

TARGOBJ += $(OBJDIRSEP)labs.obj
$(OBJDIRSEP)labs.obj: $(SRCDIRSEP)labs.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)labs.obj $(SRCDIRSEP)labs.c

TARGOBJ += $(OBJDIRSEP)div.obj
$(OBJDIRSEP)div.obj: $(SRCDIRSEP)div.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)div.obj $(SRCDIRSEP)div.c

TARGOBJ += $(OBJDIRSEP)ldiv.obj
$(OBJDIRSEP)ldiv.obj: $(SRCDIRSEP)ldiv.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ldiv.obj $(SRCDIRSEP)ldiv.c

TARGOBJ += $(OBJDIRSEP)rand.obj
$(OBJDIRSEP)rand.obj: $(SRCDIRSEP)rand.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)rand.obj $(SRCDIRSEP)rand.c

TARGOBJ += $(OBJDIRSEP)atexit.obj
$(OBJDIRSEP)atexit.obj: $(SRCDIRSEP)atexit.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)atexit.obj $(SRCDIRSEP)atexit.c

TARGOBJ += $(OBJDIRSEP)getenv.obj
$(OBJDIRSEP)getenv.obj: $(SRCDIRSEP)getenv.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)getenv.obj $(SRCDIRSEP)getenv.c

TARGOBJ += $(OBJDIRSEP)system.obj
$(OBJDIRSEP)system.obj: $(SRCDIRSEP)system.c  
	$(CC) $(CFLAGS) -w068 -o $(OBJDIRSEP)system.obj $(SRCDIRSEP)system.c

TARGOBJ += $(OBJDIRSEP)sbrk.obj
$(OBJDIRSEP)sbrk.obj: $(SRCDIRSEP)sbrk.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)sbrk.obj $(SRCDIRSEP)sbrk.c

TARGOBJ += $(OBJDIRSEP)bsearch.obj
$(OBJDIRSEP)bsearch.obj: $(SRCDIRSEP)bsearch.c  
	$(CC) $(CFLAGS) -w068 -o $(OBJDIRSEP)bsearch.obj $(SRCDIRSEP)bsearch.c

TARGOBJ += $(OBJDIRSEP)qsort.obj
$(OBJDIRSEP)qsort.obj: $(SRCDIRSEP)qsort.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)qsort.obj $(SRCDIRSEP)qsort.c

TARGOBJ += $(OBJDIRSEP)atof.obj
$(OBJDIRSEP)atof.obj: $(SRCDIRSEP)atof.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)atof.obj $(SRCDIRSEP)atof.c

TARGOBJ += $(OBJDIRSEP)strtod.obj
$(OBJDIRSEP)strtod.obj: $(SRCDIRSEP)strtod.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strtod.obj $(SRCDIRSEP)strtod.c

TARGOBJ += $(OBJDIRSEP)_mbchar.obj
$(OBJDIRSEP)_mbchar.obj: $(SRCDIRSEP)_mbchar.c  
	$(CC) $(CFLAGS) -w068 -o $(OBJDIRSEP)_mbchar.obj $(SRCDIRSEP)_mbchar.c

TARGOBJ += $(OBJDIRSEP)memchr.obj
$(OBJDIRSEP)memchr.obj: $(SRCDIRSEP)memchr.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)memchr.obj $(SRCDIRSEP)memchr.c

TARGOBJ += $(OBJDIRSEP)memcmp.obj
$(OBJDIRSEP)memcmp.obj: $(SRCDIRSEP)memcmp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)memcmp.obj $(SRCDIRSEP)memcmp.c

TARGOBJ += $(OBJDIRSEP)memcpy.obj
$(OBJDIRSEP)memcpy.obj: $(SRCDIRSEP)memcpy.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)memcpy.obj $(SRCDIRSEP)memcpy.c

TARGOBJ += $(OBJDIRSEP)memmove.obj
$(OBJDIRSEP)memmove.obj: $(SRCDIRSEP)memmove.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)memmove.obj $(SRCDIRSEP)memmove.c

TARGOBJ += $(OBJDIRSEP)memset.obj
$(OBJDIRSEP)memset.obj: $(SRCDIRSEP)memset.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)memset.obj $(SRCDIRSEP)memset.c

TARGOBJ += $(OBJDIRSEP)strcat.obj
$(OBJDIRSEP)strcat.obj: $(SRCDIRSEP)strcat.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strcat.obj $(SRCDIRSEP)strcat.c

TARGOBJ += $(OBJDIRSEP)strchr.obj
$(OBJDIRSEP)strchr.obj: $(SRCDIRSEP)strchr.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strchr.obj $(SRCDIRSEP)strchr.c

TARGOBJ += $(OBJDIRSEP)strcmp.obj
$(OBJDIRSEP)strcmp.obj: $(SRCDIRSEP)strcmp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strcmp.obj $(SRCDIRSEP)strcmp.c

TARGOBJ += $(OBJDIRSEP)strcpy.obj
$(OBJDIRSEP)strcpy.obj: $(SRCDIRSEP)strcpy.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strcpy.obj $(SRCDIRSEP)strcpy.c

TARGOBJ += $(OBJDIRSEP)strcspn.obj
$(OBJDIRSEP)strcspn.obj: $(SRCDIRSEP)strcspn.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strcspn.obj $(SRCDIRSEP)strcspn.c

TARGOBJ += $(OBJDIRSEP)strerror.obj
$(OBJDIRSEP)strerror.obj: $(SRCDIRSEP)strerror.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strerror.obj $(SRCDIRSEP)strerror.c

TARGOBJ += $(OBJDIRSEP)strlen.obj
$(OBJDIRSEP)strlen.obj: $(SRCDIRSEP)strlen.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strlen.obj $(SRCDIRSEP)strlen.c

TARGOBJ += $(OBJDIRSEP)strncat.obj
$(OBJDIRSEP)strncat.obj: $(SRCDIRSEP)strncat.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strncat.obj $(SRCDIRSEP)strncat.c

TARGOBJ += $(OBJDIRSEP)strncmp.obj
$(OBJDIRSEP)strncmp.obj: $(SRCDIRSEP)strncmp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strncmp.obj $(SRCDIRSEP)strncmp.c

TARGOBJ += $(OBJDIRSEP)strncpy.obj
$(OBJDIRSEP)strncpy.obj: $(SRCDIRSEP)strncpy.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strncpy.obj $(SRCDIRSEP)strncpy.c

TARGOBJ += $(OBJDIRSEP)strpbrk.obj
$(OBJDIRSEP)strpbrk.obj: $(SRCDIRSEP)strpbrk.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strpbrk.obj $(SRCDIRSEP)strpbrk.c

TARGOBJ += $(OBJDIRSEP)strrchr.obj
$(OBJDIRSEP)strrchr.obj: $(SRCDIRSEP)strrchr.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strrchr.obj $(SRCDIRSEP)strrchr.c

TARGOBJ += $(OBJDIRSEP)strspn.obj
$(OBJDIRSEP)strspn.obj: $(SRCDIRSEP)strspn.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strspn.obj $(SRCDIRSEP)strspn.c

TARGOBJ += $(OBJDIRSEP)strstr.obj
$(OBJDIRSEP)strstr.obj: $(SRCDIRSEP)strstr.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strstr.obj $(SRCDIRSEP)strstr.c

TARGOBJ += $(OBJDIRSEP)strtok.obj
$(OBJDIRSEP)strtok.obj: $(SRCDIRSEP)strtok.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strtok.obj $(SRCDIRSEP)strtok.c

TARGOBJ += $(OBJDIRSEP)strtol.obj
$(OBJDIRSEP)strtol.obj: $(SRCDIRSEP)strtol.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strtol.obj $(SRCDIRSEP)strtol.c

TARGOBJ += $(OBJDIRSEP)strtoul.obj
$(OBJDIRSEP)strtoul.obj: $(SRCDIRSEP)strtoul.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strtoul.obj $(SRCDIRSEP)strtoul.c

TARGOBJ += $(OBJDIRSEP)asctime.obj
$(OBJDIRSEP)asctime.obj: $(SRCDIRSEP)asctime.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)asctime.obj $(SRCDIRSEP)asctime.c

TARGOBJ += $(OBJDIRSEP)clock.obj
$(OBJDIRSEP)clock.obj: $(SRCDIRSEP)clock.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)clock.obj $(SRCDIRSEP)clock.c

TARGOBJ += $(OBJDIRSEP)ctime.obj
$(OBJDIRSEP)ctime.obj: $(SRCDIRSEP)ctime.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ctime.obj $(SRCDIRSEP)ctime.c

TARGOBJ += $(OBJDIRSEP)difftime.obj
$(OBJDIRSEP)difftime.obj: $(SRCDIRSEP)difftime.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)difftime.obj $(SRCDIRSEP)difftime.c

TARGOBJ += $(OBJDIRSEP)localtm.obj
$(OBJDIRSEP)localtm.obj: $(SRCDIRSEP)localtm.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)localtm.obj $(SRCDIRSEP)localtm.c

TARGOBJ += $(OBJDIRSEP)mktime.obj
$(OBJDIRSEP)mktime.obj: $(SRCDIRSEP)mktime.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)mktime.obj $(SRCDIRSEP)mktime.c

TARGOBJ += $(OBJDIRSEP)strftime.obj
$(OBJDIRSEP)strftime.obj: $(SRCDIRSEP)strftime.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)strftime.obj $(SRCDIRSEP)strftime.c

TARGOBJ += $(OBJDIRSEP)gmtime.obj
$(OBJDIRSEP)gmtime.obj: $(SRCDIRSEP)gmtime.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)gmtime.obj $(SRCDIRSEP)gmtime.c

TARGOBJ += $(OBJDIRSEP)time.obj
$(OBJDIRSEP)time.obj: $(SRCDIRSEP)time.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)time.obj $(SRCDIRSEP)time.c

TARGOBJ += $(OBJDIRSEP)_tzone.obj
$(OBJDIRSEP)_tzone.obj: $(SRCDIRSEP)_tzone.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_tzone.obj $(SRCDIRSEP)_tzone.c

TARGOBJ += $(OBJDIRSEP)errno.obj
$(OBJDIRSEP)errno.obj: $(SRCDIRSEP)errno.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)errno.obj $(SRCDIRSEP)errno.c

TARGOBJ += $(OBJDIRSEP)_simio.obj
$(OBJDIRSEP)_simio.obj: $(SRCDIRSEP)_simio.c  
	$(CC) $(CFLAGS) -g -w555 -o $(OBJDIRSEP)_simio.obj $(SRCDIRSEP)_simio.c

TARGOBJ += $(OBJDIRSEP)_ioread.obj
$(OBJDIRSEP)_ioread.obj: $(SRCDIRSEP)_ioread.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_ioread.obj $(SRCDIRSEP)_ioread.c

TARGOBJ += $(OBJDIRSEP)_iowrite.obj
$(OBJDIRSEP)_iowrite.obj: $(SRCDIRSEP)_iowrite.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_iowrite.obj $(SRCDIRSEP)_iowrite.c

TARGOBJ += $(OBJDIRSEP)_lseek.obj
$(OBJDIRSEP)_lseek.obj: $(SRCDIRSEP)_lseek.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_lseek.obj $(SRCDIRSEP)_lseek.c

TARGOBJ += $(OBJDIRSEP)_open.obj
$(OBJDIRSEP)_open.obj: $(SRCDIRSEP)_open.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_open.obj $(SRCDIRSEP)_open.c

TARGOBJ += $(OBJDIRSEP)_read.obj
$(OBJDIRSEP)_read.obj: $(SRCDIRSEP)_read.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_read.obj $(SRCDIRSEP)_read.c

TARGOBJ += $(OBJDIRSEP)_write.obj
$(OBJDIRSEP)_write.obj: $(SRCDIRSEP)_write.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_write.obj $(SRCDIRSEP)_write.c

TARGOBJ += $(OBJDIRSEP)clearerr.obj
$(OBJDIRSEP)clearerr.obj: $(SRCDIRSEP)clearerr.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)clearerr.obj $(SRCDIRSEP)clearerr.c

TARGOBJ += $(OBJDIRSEP)_fclose.obj
$(OBJDIRSEP)_fclose.obj: $(SRCDIRSEP)_fclose.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_fclose.obj $(SRCDIRSEP)_fclose.c

TARGOBJ += $(OBJDIRSEP)fclose.obj
$(OBJDIRSEP)fclose.obj: $(SRCDIRSEP)fclose.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fclose.obj $(SRCDIRSEP)fclose.c

TARGOBJ += $(OBJDIRSEP)_filbuf.obj
$(OBJDIRSEP)_filbuf.obj: $(SRCDIRSEP)_filbuf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_filbuf.obj $(SRCDIRSEP)_filbuf.c

TARGOBJ += $(OBJDIRSEP)_flsbuf.obj
$(OBJDIRSEP)_flsbuf.obj: $(SRCDIRSEP)_flsbuf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_flsbuf.obj $(SRCDIRSEP)_flsbuf.c

TARGOBJ += $(OBJDIRSEP)fopen.obj
$(OBJDIRSEP)fopen.obj: $(SRCDIRSEP)fopen.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fopen.obj $(SRCDIRSEP)fopen.c

TARGOBJ += $(OBJDIRSEP)feof.obj
$(OBJDIRSEP)feof.obj: $(SRCDIRSEP)feof.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)feof.obj $(SRCDIRSEP)feof.c

TARGOBJ += $(OBJDIRSEP)ferror.obj
$(OBJDIRSEP)ferror.obj: $(SRCDIRSEP)ferror.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ferror.obj $(SRCDIRSEP)ferror.c

TARGOBJ += $(OBJDIRSEP)fflush.obj
$(OBJDIRSEP)fflush.obj: $(SRCDIRSEP)fflush.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fflush.obj $(SRCDIRSEP)fflush.c

TARGOBJ += $(OBJDIRSEP)fgetc.obj
$(OBJDIRSEP)fgetc.obj: $(SRCDIRSEP)fgetc.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fgetc.obj $(SRCDIRSEP)fgetc.c

TARGOBJ += $(OBJDIRSEP)fgetpos.obj
$(OBJDIRSEP)fgetpos.obj: $(SRCDIRSEP)fgetpos.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fgetpos.obj $(SRCDIRSEP)fgetpos.c

TARGOBJ += $(OBJDIRSEP)fgets.obj
$(OBJDIRSEP)fgets.obj: $(SRCDIRSEP)fgets.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fgets.obj $(SRCDIRSEP)fgets.c

TARGOBJ += $(OBJDIRSEP)_fopen.obj
$(OBJDIRSEP)_fopen.obj: $(SRCDIRSEP)_fopen.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_fopen.obj $(SRCDIRSEP)_fopen.c

TARGOBJ += $(OBJDIRSEP)fprintf.obj
$(OBJDIRSEP)fprintf.obj: $(SRCDIRSEP)fprintf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fprintf.obj $(SRCDIRSEP)fprintf.c

TARGOBJ += $(OBJDIRSEP)fputc.obj
$(OBJDIRSEP)fputc.obj: $(SRCDIRSEP)fputc.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fputc.obj $(SRCDIRSEP)fputc.c

TARGOBJ += $(OBJDIRSEP)fputs.obj
$(OBJDIRSEP)fputs.obj: $(SRCDIRSEP)fputs.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fputs.obj $(SRCDIRSEP)fputs.c

TARGOBJ += $(OBJDIRSEP)fread.obj
$(OBJDIRSEP)fread.obj: $(SRCDIRSEP)fread.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fread.obj $(SRCDIRSEP)fread.c

TARGOBJ += $(OBJDIRSEP)freopen.obj
$(OBJDIRSEP)freopen.obj: $(SRCDIRSEP)freopen.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)freopen.obj $(SRCDIRSEP)freopen.c

TARGOBJ += $(OBJDIRSEP)fscanf.obj
$(OBJDIRSEP)fscanf.obj: $(SRCDIRSEP)fscanf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fscanf.obj $(SRCDIRSEP)fscanf.c

TARGOBJ += $(OBJDIRSEP)fseek.obj
$(OBJDIRSEP)fseek.obj: $(SRCDIRSEP)fseek.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fseek.obj $(SRCDIRSEP)fseek.c

TARGOBJ += $(OBJDIRSEP)fsetpos.obj
$(OBJDIRSEP)fsetpos.obj: $(SRCDIRSEP)fsetpos.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fsetpos.obj $(SRCDIRSEP)fsetpos.c

TARGOBJ += $(OBJDIRSEP)ftell.obj
$(OBJDIRSEP)ftell.obj: $(SRCDIRSEP)ftell.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ftell.obj $(SRCDIRSEP)ftell.c

TARGOBJ += $(OBJDIRSEP)fwrite.obj
$(OBJDIRSEP)fwrite.obj: $(SRCDIRSEP)fwrite.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fwrite.obj $(SRCDIRSEP)fwrite.c

TARGOBJ += $(OBJDIRSEP)getc.obj
$(OBJDIRSEP)getc.obj: $(SRCDIRSEP)getc.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)getc.obj $(SRCDIRSEP)getc.c

TARGOBJ += $(OBJDIRSEP)getchar.obj
$(OBJDIRSEP)getchar.obj: $(SRCDIRSEP)getchar.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)getchar.obj $(SRCDIRSEP)getchar.c

TARGOBJ += $(OBJDIRSEP)gets.obj
$(OBJDIRSEP)gets.obj: $(SRCDIRSEP)gets.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)gets.obj $(SRCDIRSEP)gets.c

TARGOBJ += $(OBJDIRSEP)perror.obj
$(OBJDIRSEP)perror.obj: $(SRCDIRSEP)perror.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)perror.obj $(SRCDIRSEP)perror.c

TARGOBJ += $(OBJDIRSEP)printf.obj
$(OBJDIRSEP)printf.obj: $(SRCDIRSEP)printf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)printf.obj $(SRCDIRSEP)printf.c

TARGOBJ += $(OBJDIRSEP)putc.obj
$(OBJDIRSEP)putc.obj: $(SRCDIRSEP)putc.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)putc.obj $(SRCDIRSEP)putc.c

TARGOBJ += $(OBJDIRSEP)putchar.obj
$(OBJDIRSEP)putchar.obj: $(SRCDIRSEP)putchar.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)putchar.obj $(SRCDIRSEP)putchar.c

TARGOBJ += $(OBJDIRSEP)puts.obj
$(OBJDIRSEP)puts.obj: $(SRCDIRSEP)puts.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)puts.obj $(SRCDIRSEP)puts.c

TARGOBJ += $(OBJDIRSEP)remove.obj
$(OBJDIRSEP)remove.obj: $(SRCDIRSEP)remove.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)remove.obj $(SRCDIRSEP)remove.c

TARGOBJ += $(OBJDIRSEP)rename.obj
$(OBJDIRSEP)rename.obj: $(SRCDIRSEP)rename.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)rename.obj $(SRCDIRSEP)rename.c

TARGOBJ += $(OBJDIRSEP)rewind.obj
$(OBJDIRSEP)rewind.obj: $(SRCDIRSEP)rewind.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)rewind.obj $(SRCDIRSEP)rewind.c

TARGOBJ += $(OBJDIRSEP)scanf.obj
$(OBJDIRSEP)scanf.obj: $(SRCDIRSEP)scanf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)scanf.obj $(SRCDIRSEP)scanf.c

TARGOBJ += $(OBJDIRSEP)setbuf.obj
$(OBJDIRSEP)setbuf.obj: $(SRCDIRSEP)setbuf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)setbuf.obj $(SRCDIRSEP)setbuf.c

TARGOBJ += $(OBJDIRSEP)setvbuf.obj
$(OBJDIRSEP)setvbuf.obj: $(SRCDIRSEP)setvbuf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)setvbuf.obj $(SRCDIRSEP)setvbuf.c

TARGOBJ += $(OBJDIRSEP)sprintf.obj
$(OBJDIRSEP)sprintf.obj: $(SRCDIRSEP)sprintf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)sprintf.obj $(SRCDIRSEP)sprintf.c

TARGOBJ += $(OBJDIRSEP)sscanf.obj
$(OBJDIRSEP)sscanf.obj: $(SRCDIRSEP)sscanf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)sscanf.obj $(SRCDIRSEP)sscanf.c

TARGOBJ += $(OBJDIRSEP)tmpfile.obj
$(OBJDIRSEP)tmpfile.obj: $(SRCDIRSEP)tmpfile.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)tmpfile.obj $(SRCDIRSEP)tmpfile.c

TARGOBJ += $(OBJDIRSEP)tmpnam.obj
$(OBJDIRSEP)tmpnam.obj: $(SRCDIRSEP)tmpnam.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)tmpnam.obj $(SRCDIRSEP)tmpnam.c

TARGOBJ += $(OBJDIRSEP)ungetc.obj
$(OBJDIRSEP)ungetc.obj: $(SRCDIRSEP)ungetc.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ungetc.obj $(SRCDIRSEP)ungetc.c

TARGOBJ += $(OBJDIRSEP)vfprintf.obj
$(OBJDIRSEP)vfprintf.obj: $(SRCDIRSEP)vfprintf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)vfprintf.obj $(SRCDIRSEP)vfprintf.c

TARGOBJ += $(OBJDIRSEP)vprintf.obj
$(OBJDIRSEP)vprintf.obj: $(SRCDIRSEP)vprintf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)vprintf.obj $(SRCDIRSEP)vprintf.c

TARGOBJ += $(OBJDIRSEP)vsprintf.obj
$(OBJDIRSEP)vsprintf.obj: $(SRCDIRSEP)vsprintf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)vsprintf.obj $(SRCDIRSEP)vsprintf.c

TARGOBJ += $(OBJDIRSEP)_doprint.obj
$(OBJDIRSEP)_doprint.obj: $(SRCDIRSEP)_doprint.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_doprint.obj $(SRCDIRSEP)_doprint.c

TARGOBJ += $(OBJDIRSEP)_doflt.obj
$(OBJDIRSEP)_doflt.obj: $(SRCDIRSEP)_doflt.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_doflt.obj $(SRCDIRSEP)_doflt.c

TARGOBJ += $(OBJDIRSEP)cleanup.obj
$(OBJDIRSEP)cleanup.obj: $(SRCDIRSEP)cleanup.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)cleanup.obj $(SRCDIRSEP)cleanup.c

TARGOBJ += $(OBJDIRSEP)_doscan.obj
$(OBJDIRSEP)_doscan.obj: $(SRCDIRSEP)_doscan.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_doscan.obj $(SRCDIRSEP)_doscan.c

TARGOBJ += $(OBJDIRSEP)_getflt.obj
$(OBJDIRSEP)_getflt.obj: $(SRCDIRSEP)_getflt.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_getflt.obj $(SRCDIRSEP)_getflt.c

TARGOBJ += $(OBJDIRSEP)_iob.obj
$(OBJDIRSEP)_iob.obj: $(SRCDIRSEP)_iob.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_iob.obj $(SRCDIRSEP)_iob.c

TARGOBJ += $(OBJDIRSEP)setjmp.obj
$(OBJDIRSEP)setjmp.obj: $(SRCDIRSEP)setjmp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)setjmp.obj $(SRCDIRSEP)setjmp.c

TARGOBJ += $(OBJDIRSEP)longjmp.obj
$(OBJDIRSEP)longjmp.obj: $(SRCDIRSEP)longjmp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)longjmp.obj $(SRCDIRSEP)longjmp.c

TARGOBJ += $(OBJDIRSEP)sin.obj
$(OBJDIRSEP)sin.obj: $(SRCDIRSEP)sin.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)sin.obj $(SRCDIRSEP)sin.c

TARGOBJ += $(OBJDIRSEP)cos.obj
$(OBJDIRSEP)cos.obj: $(SRCDIRSEP)cos.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)cos.obj $(SRCDIRSEP)cos.c

TARGOBJ += $(OBJDIRSEP)tan.obj
$(OBJDIRSEP)tan.obj: $(SRCDIRSEP)tan.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)tan.obj $(SRCDIRSEP)tan.c

TARGOBJ += $(OBJDIRSEP)asin.obj
$(OBJDIRSEP)asin.obj: $(SRCDIRSEP)asin.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)asin.obj $(SRCDIRSEP)asin.c

TARGOBJ += $(OBJDIRSEP)acos.obj
$(OBJDIRSEP)acos.obj: $(SRCDIRSEP)acos.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)acos.obj $(SRCDIRSEP)acos.c

TARGOBJ += $(OBJDIRSEP)atan.obj
$(OBJDIRSEP)atan.obj: $(SRCDIRSEP)atan.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)atan.obj $(SRCDIRSEP)atan.c

TARGOBJ += $(OBJDIRSEP)atan2.obj
$(OBJDIRSEP)atan2.obj: $(SRCDIRSEP)atan2.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)atan2.obj $(SRCDIRSEP)atan2.c

TARGOBJ += $(OBJDIRSEP)sinh.obj
$(OBJDIRSEP)sinh.obj: $(SRCDIRSEP)sinh.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)sinh.obj $(SRCDIRSEP)sinh.c

TARGOBJ += $(OBJDIRSEP)cosh.obj
$(OBJDIRSEP)cosh.obj: $(SRCDIRSEP)cosh.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)cosh.obj $(SRCDIRSEP)cosh.c

TARGOBJ += $(OBJDIRSEP)tanh.obj
$(OBJDIRSEP)tanh.obj: $(SRCDIRSEP)tanh.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)tanh.obj $(SRCDIRSEP)tanh.c

TARGOBJ += $(OBJDIRSEP)_sinus.obj
$(OBJDIRSEP)_sinus.obj: $(SRCDIRSEP)_sinus.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_sinus.obj $(SRCDIRSEP)_sinus.c

TARGOBJ += $(OBJDIRSEP)_atan.obj
$(OBJDIRSEP)_atan.obj: $(SRCDIRSEP)_atan.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)_atan.obj $(SRCDIRSEP)_atan.c

TARGOBJ += $(OBJDIRSEP)exp.obj
$(OBJDIRSEP)exp.obj: $(SRCDIRSEP)exp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)exp.obj $(SRCDIRSEP)exp.c

TARGOBJ += $(OBJDIRSEP)log.obj
$(OBJDIRSEP)log.obj: $(SRCDIRSEP)log.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)log.obj $(SRCDIRSEP)log.c

TARGOBJ += $(OBJDIRSEP)log10.obj
$(OBJDIRSEP)log10.obj: $(SRCDIRSEP)log10.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)log10.obj $(SRCDIRSEP)log10.c

TARGOBJ += $(OBJDIRSEP)pow.obj
$(OBJDIRSEP)pow.obj: $(SRCDIRSEP)pow.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)pow.obj $(SRCDIRSEP)pow.c

TARGOBJ += $(OBJDIRSEP)sqrt.obj
$(OBJDIRSEP)sqrt.obj: $(SRCDIRSEP)sqrt.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)sqrt.obj $(SRCDIRSEP)sqrt.c

TARGOBJ += $(OBJDIRSEP)ceil.obj
$(OBJDIRSEP)ceil.obj: $(SRCDIRSEP)ceil.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ceil.obj $(SRCDIRSEP)ceil.c

TARGOBJ += $(OBJDIRSEP)floor.obj
$(OBJDIRSEP)floor.obj: $(SRCDIRSEP)floor.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)floor.obj $(SRCDIRSEP)floor.c

TARGOBJ += $(OBJDIRSEP)frexp.obj
$(OBJDIRSEP)frexp.obj: $(SRCDIRSEP)frexp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)frexp.obj $(SRCDIRSEP)frexp.c

TARGOBJ += $(OBJDIRSEP)ldexp.obj
$(OBJDIRSEP)ldexp.obj: $(SRCDIRSEP)ldexp.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)ldexp.obj $(SRCDIRSEP)ldexp.c

TARGOBJ += $(OBJDIRSEP)modf.obj
$(OBJDIRSEP)modf.obj: $(SRCDIRSEP)modf.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)modf.obj $(SRCDIRSEP)modf.c

TARGOBJ += $(OBJDIRSEP)fabs.obj
$(OBJDIRSEP)fabs.obj: $(SRCDIRSEP)fabs.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fabs.obj $(SRCDIRSEP)fabs.c

TARGOBJ += $(OBJDIRSEP)fmod.obj
$(OBJDIRSEP)fmod.obj: $(SRCDIRSEP)fmod.c  
	$(CC) $(CFLAGS)  -o $(OBJDIRSEP)fmod.obj $(SRCDIRSEP)fmod.c

SEPOBJ += $(OBJDIRSEP)_doprnts.obj
$(OBJDIRSEP)_doprnts.obj: $(SRCDIRSEP)_doprint.c  
	$(CC) $(CFLAGS) -DSMALL -o $(OBJDIRSEP)_doprnts.obj $(SRCDIRSEP)_doprint.c

SEPOBJ += $(OBJDIRSEP)_doprntm.obj
$(OBJDIRSEP)_doprntm.obj: $(SRCDIRSEP)_doprint.c  
	$(CC) $(CFLAGS) -DMEDIUM -o $(OBJDIRSEP)_doprntm.obj $(SRCDIRSEP)_doprint.c

SEPOBJ += $(OBJDIRSEP)_doprntl.obj
$(OBJDIRSEP)_doprntl.obj: $(SRCDIRSEP)_doprint.c  
	$(CC) $(CFLAGS) -DLARGE -o $(OBJDIRSEP)_doprntl.obj $(SRCDIRSEP)_doprint.c

SEPOBJ += $(OBJDIRSEP)_doscans.obj
$(OBJDIRSEP)_doscans.obj: $(SRCDIRSEP)_doscan.c  
	$(CC) $(CFLAGS) -DSMALL -o $(OBJDIRSEP)_doscans.obj $(SRCDIRSEP)_doscan.c

SEPOBJ += $(OBJDIRSEP)_doscanl.obj
$(OBJDIRSEP)_doscanl.obj: $(SRCDIRSEP)_doscan.c  
	$(CC) $(CFLAGS) -DLARGE -o $(OBJDIRSEP)_doscanl.obj $(SRCDIRSEP)_doscan.c

TARGOBJ += $(OBJDIRSEP)startup.obj
$(OBJDIRSEP)startup.obj: $(SRCDIRSEP)startup.asm  
	$(AS) $(SRCDIRSEP)startup.asm -o $(OBJDIRSEP)startup.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)_copytbl.obj
$(OBJDIRSEP)_copytbl.obj: $(SRCDIRSEP)_copytbl.asm  
	$(AS) $(SRCDIRSEP)_copytbl.asm -o $(OBJDIRSEP)_copytbl.obj $(ASFLAGS) 

TARGOBJ += $(OBJDIRSEP)_wdog.obj
$(OBJDIRSEP)_wdog.obj: $(SRCDIRSEP)_wdog.asm  
	$(AS) $(SRCDIRSEP)_wdog.asm -o $(OBJDIRSEP)_wdog.obj $(ASFLAGS) 

