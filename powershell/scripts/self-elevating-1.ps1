# From: https://stackoverflow.com/questions/7690994/powershell-running-a-command-as-administrator
# Option #1

$winupdfile = 'Windows-Update-' + $(Get-Date -f MM-dd-yyyy) + '.txt'
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"Get-WUInstall -AcceptAll | Out-File $env:USERPROFILE\$winupdfile -Append`"" -Verb RunAs; exit } else { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"Get-WUInstall -AcceptAll | Out-File $env:USERPROFILE\$winupdfile -Append`""; exit }
