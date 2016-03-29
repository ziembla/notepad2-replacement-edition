@echo off

set n2=%~dp0notepad2.exe
if not exist "%n2%" goto nonotepad2

echo You are about to set '%n2%' as system notepad replacement.
echo Press ENTER to continue or Ctrl-C to abort
pause

reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v Debugger /t REG_SZ /d "\"%n2%\" /z" /f
if errorlevel 1 goto :regwriteerror

echo Replacement set.

goto theend

:nonotepad2
echo Notepad replacement can not be set.
echo '%n2%' not found.
goto theend

:regwriteerror
echo Notepad replacement can not be set.
echo Registry write error.
goto theend

:theend
pause
