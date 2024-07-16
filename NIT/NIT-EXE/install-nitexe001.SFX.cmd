@echo off
set SFXARCH=nitexe001.exe
set PASS=p@ssw0rd
set FOLDERR=C:\pub1\Distrib\Zlovred
if not exist "%FOLDER%\%SFXARCH%" goto Error
"%FOLDER%\%SFXARCH%" -p%PASS%
goto Finish
:Error
echo "File %FOLDER%\%SFXARCH% not found" && exit /b 1
rem pause
:Finish
exit /b 0