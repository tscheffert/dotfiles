# Example stuff from: https://www.red-gate.com/simple-talk/sysadmin/powershell/persistent-powershell-the-powershell-profile/
# $Shell = $Host.UI.RawUI
# Set-Location C:
# $Shell.WindowTitle="Trent's Powershell"
# new-item alias:np -value C:WindowsSystem32notepad.exe

### Modules
# TODO: Figure out how to only do this when it exists
Import-Module ActiveDirectory

### Functions
# Behave like 'which' from bash/zsh
function which($cmd) { (Get-Command $cmd).Definition }

# Get the AD user with name like $name
function Filter-ADUser($name)
{
  Get-ADUser -filter { name -like $name }
}

# Clear-Host
