; Rebind a bunch of annoying Photoshop hotkeys such that editting is bareable
#IfWinActive ahk_class Photoshop
; Switch LCtrl and LAlt, because Photoshop uses Alt as the primary chord modifier
; Pressing Alt starts the menu input, send Esc to close it once we're done with chords
LCtrl::LAlt
LAlt UP::SendInput {Esc}
LCtrl UP::SendInput {Esc}
; ! is the Alt modifier
; ^ is the Ctrl modifier
; + is the Shift modifier
; Swap Alt and Ctrl on commenly used hotkeys
<!d::SendInput ^d
<!+d::SendInput ^+d
<!e::SendInput ^e
<!f::SendInput ^f
<!s::SendInput ^s
<!t::SendInput ^t
#IfWinActive
