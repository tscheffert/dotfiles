
# Install Remote Server Administration Tools, like Active Directory module
Get-WindowsCapability -Online |? {$_.Name -like "*RSAT*" -and $_.State -eq "NotPresent"} | Add-WindowsCapability -Online
