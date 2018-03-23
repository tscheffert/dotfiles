; Ignore duplicate presses while this subroutine is already running
#MaxThreadsPerHotkey 1
; Keeps a script permanently running, enabling timers. Closes on ExitApp still
#Persistent
; Ignore attempts to launch already-running script
#SingleInstance, ignore
SetBatchLines, -1
SendMode, Input
; Detect Spotify even if it's minimized
DetectHiddenWindows, On

; NOTE: As of Spotify 1.0.75.483.g7ff4a0dc, released around 2018-03-09,
;   `ahk_class SpotifyMainWindow` doesn't work so I had to replace it temporarily
;   with `ahk_exe Spotify.exe`
;   Reported here: https://community.spotify.com/t5/Ongoing-Issues/Windows-Desktop-app-now-uses-default-chrome-class-name/idi-p/4409722

; ctrl + shift + p = play/pause in Spotify
$^+p::
If (!Active2Flag) ; If the flag is not active do this
{
    ; IfWinExist ahk_class SpotifyMainWindow
    IfWinExist ahk_exe Spotify.exe
    {
        ; Play/Pause via clicking with the SendControl is busted
        ; spotify = ahk_class SpotifyMainWindow
        ; CoordMode, Mouse, Screen
        ; MouseGetPos, OrigX, OrigY
        ; WinActivate, %spotify%
        ; WinGetPos, X, Y, Width, Height, %spotify%
        ; MouseClick, Left, X+81, Y+1377
        ; WinMinimize, %spotify%
        ; MouseMove, OrigX, OrigY

        ; Activate Spotify window, send hotkey, minimize and activate previous window
        ; WinGetTitle, wintit
        ; WinActivate, ahk_exe spotify.exe
        ; Sleep, 50
        ; Send, {Space}, ahk_exe spotify.exe
        ; WinMinimize, ahk_exe spotify.exe
        ; WinActivate, wintit

        ; System wide Play/Pause seems to work but it activates foobar2000 too
        Send {Media_Play_Pause}

        ; Doesn't work with latest spotify update
        ; ControlSend, ahk_parent, {Space}, ahk_class SpotifyMainWindow ; Pause/Unpause
        Tooltip, Spotify Play/Pause
    }
    else
    {
        SetTitleMatchMode 2
        IfWinExist, foobar2000
        {
            ControlSend, ahk_parent, {Space} ; Pause/Unpause
            Tooltip, foobar2000 Play/Pause
        }
    }
    Active2Flag := 1 ; activate the flag
    SetTimer, Reactivate2, -1000 ; Reactivates once in 1000 ms = 1 seconds
}
return


; ctrl + shift + ] = Next Song in music player
$^+]::
If (!Active2Flag) ; If the flag is not active do this
{
    ; IfWinExist ahk_class SpotifyMainWindow
    IfWinExist ahk_exe Spotify.exe
    {
        ControlSend, ahk_parent, ^{Right}
        Tooltip, Spotify Next Song
    }
    else
    {
      ; TODO: Figure out how to set this as an else if, with the match mode
        SetTitleMatchMode 2
        IfWinExist foobar2000
        {
            ControlSend, ahk_parent, ^+]
            Tooltip, foobar2000 Next Song
        }
    }
    Active2Flag := 1 ; activate the flag
    SetTimer, Reactivate2, -1000 ; Reactivates once in 1000 ms = 1 seconds
}
return


; ctrl + shift + [ = Previous Song in music player
$^+[::
If (!Active2Flag) ; If the flag is not active do this
{
    ; IfWinExist ahk_class ahk_class SpotifyMainWindow
    IfWinExist ahk_exe Spotify.exe
    {
        ControlSend, ahk_parent, ^{Left}
        Tooltip, Spotify Previous Song
    }
    else
    {
        SetTitleMatchMode 2
        IfWinExist foobar2000
        {
            ControlSend, ahk_parent, ^+[
            Tooltip, foobar2000 Previous Song
        }
    }
    Active2Flag := 1 ; activate the flag
    SetTimer, Reactivate2, -1000 ; Reactivates once in 1000 ms = 1 seconds
}
return


Reactivate2:
    Active2Flag := 0 ; Deactivates the flag
    Tooltip
return
