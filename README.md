
# Notepad2 "notepad replacement edition"

Simple but very powerfull and quite customizable, handy single-file text editor.

This is a modified version of Florian Balmer's Notepad2 (see <http://www.flos-freeware.ch/notepad2.html>), including a handful of changes that the original author hesitated to bake into the main version of his excellent tool. 

## Notepad2 in a nutshell

### power...

- search and **replace using regular expressions** or metacharacters  
  *e.g. replacing `><` with `>\r\n<` to make sense of XML one-liners quickly*
- **codepage conversion** and auto-detection  
  *e.g. windows, ISO, variants of Unicode - with or without the BOM*
- full range of **useful transformations**: line sorting, trailing blanks removal, joining empty lines...  
  *including "block sort" sorting lines by the substring starting on given column* 
- ...

### and simplicity

- not just portable (no install required) but super-portable: it's a **single .exe tool**     
  *easy to use on multimachine, e.g. virtual, environments*
- **digital signature** (your own or on precompiled version only, obviously)  
  *clean UAC integration, easy virus or damage detection*
- easy to deploy and clean to roll back, **system-wide notepad.exe replacement** from "About" dialog (more in [replacing notepad.exe](#replacing-notepad-exe) section)  
  *taking over all text file editing on a machine*

## original project and scope of modifications

The project is based on version 4.2.25 of the original tool, and includes parts of "Notepad2 Bookmark Edition", created by Dan of 'RL Vision' (see <http://www.rlvision.com/notepad2/>).

All changes applied to the original can be easily traced by git history, parts of code imported from "bookmark edition" are marked with "BOOKMARK_EDITION" conditional compilation flag.

Modifications in regard to original version:

  - added button on About dialog for "one-click" enabling/disabling "notepad replacement mode" (more in [replacing notepad.exe](#replacing-notepad-exe) section)
  - disabled searching directories in PATH variable for settings file (what could lead to hard to identify problems)
  - added information about location of the settings file on About dialog (to allow for easy troubleshooting)  
  - added File menu option for copying current file's path to clipbard (for easy opening in other tools)
  - improved file size calculation (exact for small files, taking into consideration bytes of BOMs and the like)
  - some modifications from Dan of 'RL Vision':
    - 'bookmark feature' with modified keyboard shortcuts and bookmarks
       shown on "Selection margin" (shown up if necessary)
        Alt+.: toggle bookmark on/off for for current line
        Ctrl+Shift+.: jump to next bookmark
        Ctrl+Shift+.,: jump to previous bookmark
    - number of selected lines is reported in the statusbar together 
      with the other statistics ("Sel Ln")
  - reordered list of encodings to place Central European ones just after
    Western European
  - added button on About dialog for extracting support files (License, 
    FAQ, scripts, etc.) to program's directory
  - changed defaults:
        [Settings]
        SaveSettings=0
        SaveRecentFiles=1
        SaveFindReplace=1
        PathNameFormat=1
        WordWrapSymbols=2
        ShowWordWrapSymbols=1
        ShowIndentGuides=1
        TabWidth=4
        MarkLongLines=1
        ViewWhiteSpace=1
        PrintZoom=7
        PrintMarginLeft=1200
        PrintMarginTop=1200
        PrintMarginRight=1200
        PrintMarginBottom=1200
        ToolbarButtons=1 2 3 4 19 0 5 6 0 7 8 9 0 10 11 0 12 0 13 14 0 15 0 22 23
        EncodingDlgSizeY=460
        RecodeDlgSizeY=403
        [Settings2]
        SingleFileInstance=1
        [Default Text]
        Default Style=font:Lucida Console; charset:238; size:8
  - pseudo-handwritten recommendation overlayed on editor contents (just for fun; can be disabled by changing `RecommendationVisible` setting in the `.ini` file to `0`; the setting can be also set to higher values allowing recommendation to stay visible until the size of the file reaches the specified limit)

## replacing notepad.exe
 
Replacing system's notepad.exe can be done in a clean and easy to roll back manner by a clever trick used in fact by Microsoft's own (excellent) tool 'Process Explorer'. 'Image File Execution Option' in system's registry can be configured to run a specified binary whenever a 'notepad.exe' is requested. Restoring the original behavior is as simple as removing this redirection from the registry.

You can read more about that on <http://www.flos-freeware.ch/doc/notepad2-Replacement.html>. 

"Notepad replacement edition" has the functionality of toggling the "replace notepad" state built-in and accessible via a button on the application's "About" dialog (`F1` key can be used to open it quickly). 

A `notepad-replacement-disable.cmd` script can be used in case of "emergency" to delete the redirection after Notepad2 was deleted from the system (administrator priviledges required).

Manual cleanup can be done simply by removing the `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe` key from the registry using `regedt32.exe` or other such tool (administrator priviledges required).

## compilation

### production build

Custom version of the tool can/should be built with the script included in the project.

The only prerequisite is having "Windows Driver Kit Version 7.1.0" installed. Free download is available from <https://www.microsoft.com/en-us/download/details.aspx?id=11800>.  
"Build Environments" is the only component that has to be installed.

*Unfortunately, "Windows Driver Kit 8.1 Update 1" (<https://www.microsoft.com/en-us/download/details.aspx?id=42273>) requires registration before download and "Windows Driver Kit for Windows 10" (<https://msdn.microsoft.com/en-us/windows/hardware/mt612818.aspx>) has a different directory structure*

After adapting `wdkbuild\make.cmd` to make `WDKBASEDIR` variable point to your location of the driver kit, you can build binaries for both 32-bit and 64-bit systems by running the following commands from the command prompt:
```
cd wdkbuild
make.cmd i386
make.cmd amd64
```  

### development with Visual Studio

The project contains solution file for somewhat outdated version of the Visual Studio, but newer versions should be able to upgrate it without problems (checked on VS2015).

The only caveat is that VS defaults to preparing its own version of application manifest that collides with the one included in the project. In such a case:
- open "Tools/Options"
    - navigate to "Projects and Solutions" and
    - change "Show advanced build configurations" to "checked"
- right-click on project in "Solution Explorer" and choose "Properties"
    - in the tree control expand "Configuration properties/Manifest Tool/Input and Output"
    - set "Embed Manifest" to "No".
