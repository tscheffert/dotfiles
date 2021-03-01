; Startup script for Autohotkey scripts that I want to run on system startup.
;
; Instructions:
;   Right click this .ahk file and hit create shortcut
;   Add the StartupScript.ahk to windows startup
;       Can be done with the registry by adding a string value to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run with the location of this file.
; Running 'Startup.reg' should work as well

; Using %A_AppData% instead of %A_UserName% because that returns TScheffert but
; my directory is tscheffert

#include %A_AppData%\..\..\AutoHotkey\MusicControls.ahk
; #include %A_AppData%\..\..\AutoHotkey\OutlookHotkeys.ahk
; #include C:\Users\%A_UserName%\AutoHotkey\PhotoshopHotkeys.ahk
#include %A_AppData%\..\..\AutoHotkey\GenericHotkeys.ahk
#include %A_AppData%\..\..\AutoHotkey\PathOfExile.ahk
