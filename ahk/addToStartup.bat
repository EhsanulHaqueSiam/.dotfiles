@echo off

:: Get the directory where the batch file is located
set "batch_dir=%~dp0"

:: Define the file path for VirtualDesktopMove.ahk in the same directory as the .bat file
set "source_file=%batch_dir%VirtualDesktopMove.ahk"

:: Define the shortcut name
set "shortcut_name=VirtualDesktopMove.lnk"

:: Define the Startup folder
set "startup_folder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Create the shortcut using VBScript
echo Set WshShell = CreateObject("WScript.Shell") > "%temp%\create_shortcut.vbs"
echo Set oShortcut = WshShell.CreateShortcut("%startup_folder%\%shortcut_name%") >> "%temp%\create_shortcut.vbs"
echo oShortcut.TargetPath = "%source_file%" >> "%temp%\create_shortcut.vbs"
echo oShortcut.Save >> "%temp%\create_shortcut.vbs"

:: Run the VBScript to create the shortcut
cscript //nologo "%temp%\create_shortcut.vbs"

:: Clean up the temporary VBScript file
del "%temp%\create_shortcut.vbs"

echo Shortcut created and moved to Startup folder.
