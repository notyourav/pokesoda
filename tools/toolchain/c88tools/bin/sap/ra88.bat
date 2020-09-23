echo off
rem ****************************************************************************
rem *	SMC88 Family Auto Relocatable Assemble Execution Utility
rem *						(Ver. 2.00)
rem *					Copyright(C) SEIKO EPSON CORP. 1993-1996
rem ****************************************************************************
rem * customized parameter information
rem * 	rom=*	 * : rom capacity(32768 max.)
rem * 	ram=*	 * : ram capacity(65536 max.)
rem **************************************************************************
rem ********** customized parameter area (default) **********
rem *  caution : customized parameters value do not check, therefore
rem *		 please be carefully when you set
rem **********
set rom=32768
set ram=65536

rem ********** command searching path (do not touch) **********
set drv=c:\

rem **************************************************************************
rem *	main program
rem *		if you want to use another option(s), please append
rem *		option flag(s) at command line.
rem **************************************************************************
:start
	echo SMC88 Family Auto Relocatable Assemble Execution Utility Ver.2.00
	echo Copyright (C) SEIKO EPSON CORP. 1993-1996

		if "%1"=="" goto usage
:error_chk
		if not exist %drv%nul goto exit04
		if not exist %1.s goto exit05
		if not exist %drv%sap88.exe goto exit06
		if not exist %drv%asm88.exe goto exit07

rem (sap88)
:sap88
%drv%sap88 -o %1.ms %1.s
		if errorlevel 1 goto exit01

rem (asm88)
:asm88
%drv%asm88 -ROM %rom% -RAM %ram% %1.ms
		if errorlevel 1 goto exit02
			goto end

	:usage
	echo usage : ra88 needs [input file_name]
			goto skip
	:exit01
	echo Error stop at %drv%sap88.exe
			goto skip
	:exit02
	echo Error stop at %drv%asm88.exe
			goto skip
	:exit03
	echo Cannot find %drv% installed SMC88 dev. tools directory
			goto skip
	:exit04
	echo Cannot find input file
			goto skip
	:exit05
	echo Cannot find %drv%sap88.exe
			goto skip
	:exit06
	echo Cannot find %drv%asm88.exe
			goto skip
	:end
	echo ra88.bat utility has been successfully executed.
	:skip
	set rom=
	set ram=
	set drv=
