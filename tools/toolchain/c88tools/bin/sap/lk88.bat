echo off
rem ****************************************************************************
rem *	SMC88 Family Auto Link Execution Utility
rem *						(Ver. 2.00)
rem *					Copyright(C) SEIKO EPSON CORP. 1993-1996
rem ****************************************************************************
rem * customized parameter information
rem * 	parfn=		: input parameter file_name
rem *			 (file_name_lcm) for link88.exe	    i.e. c8316xxx.lcm
rem * 	outfn=		: output file_name which is written
rem *			  in the input parameter file_name  i.e. c8316xxx
rem *	rel=y	y : use rel88 for absolute symbol map generation
rem *	   =n	n : do not use rel88
rem *
rem *	secf=y	y : show physical address and module size with absolute
rem *		    symbolic table after link procedure
rem *	    =n	n : do not show physical address and module size just
rem *		    symbolic table after link procedure
rem **************************************************************************
rem ********** customized parameter area (default) **********
rem *  caution : ustomized parameters value do not check, therefore
rem *		 please be carefully when you set
rem **********
set parfn=sample
set outfn=sample
set rel=y
set secf=y

rem ********** command searching path (do not touch) **********
set drv=c:\

rem **************************************************************************
rem *	main program
rem *		if you want to use another option(s), please append
rem *		option flag(s) at command line
rem **************************************************************************
:start
	echo SMC88 Family Auto Link Execution Utility Ver. 2.00
	echo Copyright (C) SEIKO EPSON CORP. 1993-1996

:error_chk
		if not exist %drv%nul goto exit05
		if not exist %parfn%.lcm goto exit06
		:chk00
		if not exist %drv%link88.exe goto exit07
		if not exist %drv%rel88.exe goto exit08
		if not exist %drv%hex88.exe goto exit9
		if not exist %drv%sym88.exe goto exit10

:link88
%drv%link88<%parfn%.lcm
		if errorlevel 1 goto exit01

rem (rel88 no sec option)
:rel88_01
		if "%rel%"=="n" goto hex88
		if "%secf%"=="y" goto rel88_02
%drv%rel88 -v %outfn%.a>%outfn%.ref
		if errorlevel 1 goto exit02
			goto hex88
rem (rel88 with sec option)
:rel88_02
%drv%rel88 -v +sec %outfn%.a>%outfn%.ref
		if errorlevel 1 goto exit02

:hex88
%drv%hex88 -o %outfn%.sa %outfn%.a
		if errorlevel 1 goto exit03

:sym88
%drv%sym88 %outfn%.ref
		if errorlevel 1 goto exit04
			goto end

	:exit01
	echo Error stop at %drv%link88.exe
		goto skip
	:exit02
	echo Error stop at %drv%rel88.exe
		goto skip
	:exit03
	echo Error stop at %drv%hex88.exe
		goto skip
	:exit04
	echo Error stop at %drv%sym88.exe
		goto skip
	:exit05
	echo Cannot find %drv% installed SMC88 dev. tools directory
		goto skip
	:exit06
	echo Cannot find %parfn% input parameter file
		goto skip
	:exit07
	echo Cannot find %drv%link88.exe
		goto skip
	:exit08
	echo Cannot find %drv%rel88.exe
		goto skip
	:exit09
	echo Cannot find %drv%hex88.exe
		goto skip
	:exit10
	echo Cannot find %drv%sym88.exe
:end
	echo lk88.bat utility has been successfully executed.
:skip
	set parfn=
	set outfn=
	set rel=
	set secf=
	set drv=
