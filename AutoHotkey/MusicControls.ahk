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

; INFO: This post described the PostMessage solution:
;   https://autohotkey.com/boards/viewtopic.php?t=31259&p=145789

; ctrl + shift + p = play/pause in Spotify
$^+p::
If (!Active2Flag)
{
    ; IfWinExist ahk_class SpotifyMainWindow
    IfWinExist ahk_exe Spotify.exe
    {
        ; Syntax:
        ;   PostMessage, Msg, wParam,  lParam, Control, WinTitle
        ;
        ;   Send the WM_APPCOMMAND message, 0x319. Details about that message: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646275(v=vs.85).aspx
        ;   APPCOMMAND_MEDIA_PLAY_PAUSE = 0xE0000
        ;   APPCOMMAND_MEDIA_PLAY_PAUSE = 14 = 0xE0000 somehow
        ;   APPCOMMAND_MEDIA_NEXTTRACK = 11 = 0xB0000 somehow
        ;   APPCOMMAND_MEDIA_PREVIOUSTRACK = 12 = 0xC0000 somehow
        PostMessage, 0x319, , 0xE0000, , ahk_exe Spotify.exe

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
        PostMessage, 0x319,, 0xB0000,, ahk_exe Spotify.exe ; Next track

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
        PostMessage, 0x319,, 0xC0000,, ahk_exe Spotify.exe ; Previous track

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
