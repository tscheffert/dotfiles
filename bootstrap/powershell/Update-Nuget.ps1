# From: https://github.com/PowerShell/PSScriptAnalyzer
#   and https://serverfault.com/questions/11879/gaining-administrator-privileges-in-powershell

$script = 'Install-PackageProvider Nuget -force -verbose'

function Run-Elevated ($scriptblock)
{
  $sh = new-object -com 'Shell.Application'
  # Had a -NoExit command but I _do_ want it to exit
  $sh.ShellExecute('powershell', "-Command $scriptblock", '', 'runas')
}

Run-Elevated($script)
