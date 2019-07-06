; Startup script for Autohotkey scripts that I want to run on system startup.
;
; Instructions:
;   Right click this .ahk file and hit create shortcut
;   Add the StartupScript.ahk to windows startup
;       Can be done with the registry by adding a string value to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run with the location of this file.
; Running 'Startup.reg' should work as well

; #include C:\Users\%A_UserName%\AutoHotkey\PhotoshopHotkeys.ahk
#include C:\Users\%A_UserName%\AutoHotkey\MusicControls.ahk
#include C:\Users\%A_UserName%\AutoHotkey\OutlookHotkeys.ahk
#include C:\Users\%A_UserName%\AutoHotkey\PhotoshopHotkeys.ahk
