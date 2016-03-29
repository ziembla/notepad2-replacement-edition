@echo off

echo You are about to remove notepad replacement.
echo Press ENTER to continue or Ctrl-C to abort
pause

reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v Debugger /f
if errorlevel 1 goto :regwriteerror

echo Replacement removed.

goto theend

:regwriteerror
echo Notepad replacement can not be removed.
echo Registry write error.
goto theend

:theend
pause
