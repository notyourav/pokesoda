***************************************************************************

                S1C88 Series Development Tool Package version 6.00
                                                                2008/01/18
***************************************************************************

Thank you for purchasing S1C88 Series Development Tool Package. 
This file introduces about restrictions or matters that require attention
in the use. Be sure to read this file before you use this product. 


- System Requirements

  1) Hardware and OS
     IBM PC/AT or compatible PC with Windows 2000/XP
     CPU Pentium1GHz or above
  2) Memory
     RAM 64MB or above
  3) Hard disk
     Free capacity more than 50MB
  4) Display
     800x600 resolution or above


- Installation

  Please close all windows program including the virus check program by all
  means before installing S1C88 Series Development Tool Package.

  1) Carry out SETUP.exe and starts the installer.
  2) Let installation complete according to the instructions of the installer.

 * When installation does not go well by lack of the HDD capacity, please try
   it again after uninstalling current S1C88 Series Development Tool Package.

 * Please specify the destination folder name of installation not to include
   space in less than 8 characters.

  After installation, S1C88 Series Development Tool Package is unfolded by the
  following directory trees into an HDD.

  Epson\S1C88                   README_J.txt, README_E.txt
     +--- BIN                   S1C88 C compiler tool
     |                          WorkBench
     |                          ICE88UR
     |       +--- DB88          Debugger
     |       +--- SAP           Structured Assembler tool
     +--- ETC                   S1C88 default locater definition file
     +--- INCLUDE               S1C88 C compiler header file
     +--- LIB                   S1C88 C compiler Library file
     |       +--- LIBCS         Library object file for SMALL model
     |       +--- LIBCC         Library object file for COMPACT CODE model
     |       +--- LIBCD         Library object file for COMPACT DATA model
     |       +--- LIBCL         Library object file for LARGE model
     |       +--- SRC           Library source file
     +--- DEV                   S1C88 series model locater definition file
     +--- SAMPLES               Sample programs source file
     +--- WRITER                Flash microcomputer writer tool
     +--- ICE
     |       +--- FPGA          FPGA data
     |       +--- ICE88URupd    ICE88UR Firmware update tool
     +--- DOC
             +--- Japanese      Manual(Japanese)
             +--- English       Manual(English)

- Environmental setting
  You have to add the following setting to use the S1C88 developer tool.
  Following setting is necessary to execute compiler tools.

  SET PATH=C:\Epson\S1C88\BIN;%PATH%
  SET C88INC=C:\Epson\S1C88\INCLUDE
  SET C88LIB=C:\Epson\S1C88\LIB
  
  Above setting is described in file addpath.bat.

- Version Information 
  Compiler tool                    v1.2 r3
  WorkBench        WB88.exe        Ver 2.04
                   WB88649.exe     Ver 1.00
  ICE              DB88.EXE        Ver 1.60
  Writer tool
                   G8F3605A.exe    
                   G8F3605C.exe    
                   rw88f360.exe    Ver 1.10
                   88F360.FRM      Ver 1.25
                   OBPW88.exe      Ver 2.70
                   rw8f360.ini     Ver 1.03
                   rw8f626.ini     Ver 1.00

  FPGA             C88348V1.mcs    Ver 1		(for S1C88317,S1C88348,S1C88832,S1C88862)
                   C88316V1.mcs    Ver 1		(for S1C88104,S1C88112,S1C88308,S1C88316)
                   C88649V2.mcs    Ver 2		(for S1C88649)
                   C88650V2.mcs    Ver 2		(for S1C88650)
                   C88655V1.mcs    Ver 1		(for S1C88655)
                   C8F626V1.mcs    Ver 1		(for S1C8F626)
                   c88816V1.mcs    Ver 1		(for S1C88349,S1C88816,S1C8F360)
                   c88848V1.mcs    Ver 1		(for S1C88848)
                   c8E108V1.mcs    Ver 1		(for S1C8E108)
  DevTool
                   WinFog.EXE      Ver 1.06
                   WinMdc.EXE      Ver 1.05
  88104                            Ver 7
                   FIL88104.EXE    Ver 3.00
                   S1C88104.ini    Ver 1.01
                   88104.PAR       Ver 2.01
  88112                            Ver 7
                   FIL88112.EXE    Ver 3.00
                   S1C88112.ini    Ver 1.01
                   88112.PAR       Ver 2.01
  88308                            Ver 9
                   FIL88308.EXE    Ver 3.00
                   S1C88308.ini    Ver 1.01
                   88308.PAR       Ver 2.01
  88316                            Ver 9
                   FIL88316.EXE    Ver 3.00
                   S1C88316.ini    Ver 1.01
                   88316.PAR       Ver 2.01
  88317                            Ver 3
                   FIL88317.EXE    Ver 2.00
                   S1C88317.ini    Ver 1.02
                   88317.PAR       Ver 1.01
  88348                            Ver 4
                   FIL88348.EXE    Ver 3.00
                   S1C88348.ini    Ver 1.02
                   88348.PAR       Ver 2.01
  88349                            Ver 4
                   FIL88349.EXE    Ver 2.00
                   S1C88349.ini    Ver 1.06
                   88349.PAR       Ver 1.00
  8F360                            Ver 6
                   FIL8F360.EXE    Ver 2.00
                   S1C8F360.ini    Ver 4.00
                   8F360.PAR       Ver 1.01
  88365                            Ver 5
                   FIL88365.EXE    Ver 3.00
                   S1C88365.ini    Ver 1.00
                   88365.PAR       Ver 2.01
  88816                            Ver 5
                   FIL88816.EXE    Ver 2.00
                   S1C88816.ini    Ver 2.02
                   88816.PAR       Ver 1.01
  88832                            Ver 3
                   FIL88832.EXE    Ver 2.00
                   S1C88832.ini    Ver 1.02
                   88832.PAR       Ver 1.01
  88848                            Ver 3
                   FIL88848.EXE    Ver 2.00
                   S1C88848.ini    Ver 1.00
                   88848.PAR       Ver 1.00
  88862                            Ver 4
                   FIL88862.EXE    Ver 3.00
                   S1C88862.ini    Ver 1.02
                   88862.PAR       Ver 2.01
  88408                            Ver 1(DOS)
                   FIL88408.EXE    Ver 2.00
                   88408.PAR       Ver 1.20
  88409                            Ver 4(DOS)
                   FIL88409.EXE    Ver 2.00
                   88409.PAR       Ver 1.01
  88649                            Ver 4
                   FIL88649.EXE    Ver 2.00
                   S1C88649.ini    Ver 3.00
                   88649.PAR       Ver 1.00
  88650                            Ver 6
                   FIL88650.EXE    Ver 1.01
                   S1C88650.ini    Ver 5.01
                   88650.PAR       Ver 5.00
  88655                            Ver 5
                   FIL88655.EXE    Ver 1.00
                   S1C88655.ini    Ver 5.00
                   88655.PAR       Ver 5.00
  8F626                            Ver 3
                   FIL8F626.EXE    Ver 1.00
                   S1C8F626.ini    Ver 1.20
                   8F626.PAR       Ver 1.00
  8E108                            Ver 3
                   FIL8E108.EXE    Ver 1.00
                   S1C8E108.ini    Ver 1.10
                   8E108.PAR       Ver 1.00

- As following informations, please refer to release note rel_xxx.txt of the 
  \doc\english folder.
  - Release history
  - Difference from manual
  - Restrictions that are not mentioned in manual


- Code efficiency of C compiler
  The assembler code which C compiler generates becomes as follows in
  comparison with the code when it is developed with the assembler.
   Small model:code size and processing speed nearly double.
   Large model:code size and processing speed nearly quadruple.
   (CompactCode,CompactData model is the middle value mentioned above)

  When the case that transaction speed is demanded or compact code size is
  demanded, it is recommended to develop the program with the assembler.
  (The code size ratios are different by processing contents, and the above
  code size is one example.)


Copyright(C) 2000-2008 SEIKO EPSON Corporation, All rights reserved.

*  Windows 2000 and Windows XP are trademarks of Microsoft Corporation.
   PC/AT is trademarks of IBM Corporation.
   Adobe and Acrobat Reader are trademarks of Adobe Systems Incorporated.
