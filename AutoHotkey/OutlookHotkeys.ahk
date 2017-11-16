SetTitleMatchMode RegEx

; Copy the OneNote "bullet point list" hotkey for Outlook messages
IfWinActive * - Message (HTML)
{
    ^.:: SendInput ^+l
}
