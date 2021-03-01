; Ctrl+Alt+F: Set window style to no border or title
!^f::
WinSet, Style, -0xC40000, A
; WinSet, Style, -0xC00000, A ;This would set it to no title bar but with borders
return

; Ctrl+Shift+o: Run the "Set desktop audio" batch script. "o" for "out".
$^+o::
Run, "C:\Users\Trent\Documents\Places\Utilities\_Speakers-Desk.bat"
return

; Ctrl+Shift+i: Run the "Set headset audio" batch script. "i" for "in".
$^+i::
Run, "C:\Users\Trent\Documents\Places\Utilities\_Speakers-Hel.bat"

return
