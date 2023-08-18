; Ctrl+Shift+m: Start all the Path of Exile Apps I use
$^+m::
If (!AlreadyStartedFlag)
{
  AlreadyStartedFlag := 1

  ; Lutbot, for ctrl + ` disconnect, F11 for settings, F4 force disconnect
  Run, "C:\Users\Trent\POE-Apps\LutBot\macro.ahk"

  ; Exilence Next - Tracking net worth over time
  ; Run, "C:\Users\Trent\AppData\Local\Programs\exilence-next-app\Exilence Next.exe", "C:\Users\Trent\AppData\Local\Programs\exilence-next-app"

  ; POE Overlay - Trades companion app, community edition
  ; Run, "C:\Program Files\poe-overlay\poe-overlay.exe", "C:\Program Files\poe-overlay"

  ; Run, "C:\Users\Trent\AppData\Local\PoeLurker\PoeLurker.exe", "C:\Users\Trent\AppData\Local\PoeLurker\app-1.9.7"

  ; POE Leveling Helper - Helping Leveling
  ; Run, "C:\Users\Trent\POE-Apps\PoE-Leveling-Guide\current\LevelingGuide.ahk"
}
return
