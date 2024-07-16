@echo on
rem *******************************************************
rem
rem This Function will be Fully Deleted
rem nitexe001 Installing Files from Computer
rem This Script does not Deleta the Packets to be Installed!
rem *******************************************************
@echo off

rem Set a Variables
rem
set WORKINGDIR=C:\pub1\Distrib
set WORKINGFILE=%WORKINGDIR%\preuninstall-nitexe001.bat

echo Check Integrity...
rem
if not exist %WORKINGFILE% echo %WORKINGFILE% is not found && exit /b 1

echo Run a Payload...
rem
call %WORKINGFILE%
if errorlevel 1 echo %WORKINGFILE% cannot execute && exit /b 2
del /Q /F %WORKINGFILE%

:End
echo The End of the Script %0 with success
exit /b 0
