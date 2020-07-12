$key = 'AutoHotkey StartupScript'
$path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'
$value = "$env:userprofile\AutoHotkey\StartupScript.ahk"

Set-ItemProperty -Path $path -Name $key -Value """$value""" -Type String

Write-Output "Setting key: '$key' at path: '$path' to value: '""$value""'"
