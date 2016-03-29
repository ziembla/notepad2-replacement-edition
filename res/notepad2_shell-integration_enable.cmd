@echo off

set n2=%~dp0notepad2.exe
if not exist "%n2%" goto nonotepad2

echo You are about to enable shell integration for '%n2%'.
echo Press ENTER to continue or Ctrl-C to abort
pause

reg add "HKCR\*\OpenWithList\Notepad2.exe" /f
if errorlevel 1 goto :regwriteerror

reg add "HKCR\Applications\Notepad2.exe\shell\open\command" /ve /t REG_SZ /d "\"%n2%\" \"%%1\"" /f
if errorlevel 1 goto :regwriteerror

reg add "HKCR\.txt\OpenWithList\Notepad2.exe" /f
if errorlevel 1 goto :regwriteerror

reg add "HKCR\*\shell\Open with Notepad2\command" /ve /t REG_SZ /d "\"%n2%\" \"%%1\"" /f
if errorlevel 1 goto :regwriteerror

echo Shell integration enabled.

goto theend

:nonotepad2
echo Shell integration can not be enabled.
echo '%n2%' not found.
goto theend

:regwriteerror
echo Shell integration can not be enabled.
echo Registry write error.
goto theend

:theend
pause
