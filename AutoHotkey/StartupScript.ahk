; Startup script for Autohotkey scripts that I want to run on system startup.
;
; Instructions:
;   Right click this .ahk file and hit create shortcut
;   Add the StartupScript.ahk to windows startup
;       Can be done with the registry by adding a string value to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run with the location of this file.
; Running 'Startup.reg' should work as well

; TODO: Use a "UserProfile" variable like this (these lines don't actually work)
; EnvGet, UserProfile, USERPROFILE
; #include %UserProfile%\AutoHotkey\PhotoshopHotkeys.ahk

; #include C:\Users\tscheffert\AutoHotkey\ProgramLauncher.ahk
#include C:\Users\tscheffert\AutoHotkey\MusicControls.ahk
#include C:\Users\tscheffert\AutoHotkey\OutlookHotkeys.ahk
#include C:\Users\tscheffert\AutoHotkey\PhotoshopHotkeys.ahk
