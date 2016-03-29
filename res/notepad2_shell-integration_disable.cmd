@echo off

set n2=%~dp0notepad2.exe
if not exist "%n2%" goto nonotepad2

echo You are about to disable shell integration for '%n2%'.
echo Press ENTER to continue or Ctrl-C to abort
pause

reg delete "HKCR\*\OpenWithList\Notepad2.exe" /f
if errorlevel 1 goto :regwriteerror

reg delete "HKCR\Applications\Notepad2.exe" /f
if errorlevel 1 goto :regwriteerror

reg delete "HKCR\.txt\OpenWithList\Notepad2.exe" /f
if errorlevel 1 goto :regwriteerror

reg delete "HKCR\*\shell\Open with Notepad2" /f
if errorlevel 1 goto :regwriteerror

echo Shell integration disabled.

goto theend

:nonotepad2
echo Shell integration can not be disabled.
echo '%n2%' not found.
goto theend

:regwriteerror
echo Shell integration can not be disabled.
echo Registry write error.
goto theend

:theend
pause
