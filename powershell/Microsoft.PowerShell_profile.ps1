# Example stuff from: https://www.red-gate.com/simple-talk/sysadmin/powershell/persistent-powershell-the-powershell-profile/
# $Shell = $Host.UI.RawUI
# Set-Location C:
# $Shell.WindowTitle="Trent's Powershell"
# new-item alias:np -value C:WindowsSystem32notepad.exe

### Functions
# Behave like 'which' from bash/zsh
function which ($cmd) { (Get-Command $cmd).Definition }

# Get the AD user with name like $name
function Find-FilteredADUser ($name)
{
  Get-ADUser -Filter { name -Like $name }
}

function Search-Help
{
  $pshelp = "$pshome\es\about_*.txt","$pshome\en-US\*dll-help.xml"
  Select-String -Path $pshelp -Pattern $args[0]
}

function Get-DllFullName ($name)
{
  ([System.Reflection.Assembly]::loadfile($name)).FullName
}

# Clear-Host
