; ===========================================================================
; Run a program or switch to it if already running.
;    Target - Program to run. E.g. Calc.exe or C:\Progs\Bobo.exe
;    WinTitle - Optional title of the window to activate.  Programs like
;       MS Outlook might have multiple windows open (main window and email
;       windows).  This parm allows activating a specific window.
;
; SOURCE: http://www.autohotkey.com/board/topic/7129-run-a-program-or-switch-to-an-already-running-instance/
; ===========================================================================
; Copied with <3, but not yet actually used


RunOrActivate(Target, WinTitle = "", Parameters = "")
{
  ; Get the filename without a path
  SplitPath, Target, TargetNameOnly

  Process, Exist, %TargetNameOnly%
  If ErrorLevel > 0
  {
    PID = %ErrorLevel%
  }
  Else
  {
    Run, %Target% "%Parameters%", , , PID
  }

  ; At least one app (Seapine TestTrack wouldn't always become the active
  ; window after using Run), so we always force a window activate.
  ; Activate by title if given, otherwise use PID.
  If WinTitle <>
  {
    SetTitleMatchMode, 2
    WinWait, %WinTitle%, , 3
    TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
    WinActivate, %WinTitle%
  }
  Else
  {
    WinWait, ahk_pid %PID%, , 3
    TrayTip, , Activating PID %PID% (%TargetNameOnly%)
    WinActivate, ahk_pid %PID%
  }


  SetTimer, RunOrActivateTrayTipOff, 1500
}

; Turn off the tray tip
RunOrActivateTrayTipOff:
  SetTimer, RunOrActivateTrayTipOff, off
  TrayTip
Return

RunOnly(Target, WinTitle = "", Parameters = "")
{
  ; Get the filename without a path
  SplitPath, Target, TargetNameOnly

  ; Always run
  Run, %Target% "%Parameters%", , , PID

  If WinTitle <>
  {
    SetTitleMatchMode, 2
    WinWait, %WinTitle%, , 3
    TrayTip, , Activating Window Title "%WinTitle%" (%TargetNameOnly%)
    WinActivate, %WinTitle%
  }
  Else
  {
    WinWait, ahk_pid %PID%, , 3
    TrayTip, , Activating PID %PID% (%TargetNameOnly%)
    WinActivate, ahk_pid %PID%
  }
}

#c::RunOnly("C:\Program Files\ConEmu\ConEmu64.exe")
