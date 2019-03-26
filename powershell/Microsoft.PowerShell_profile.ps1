# Example stuff from: https://www.red-gate.com/simple-talk/sysadmin/powershell/persistent-powershell-the-powershell-profile/
# $Shell = $Host.UI.RawUI
# Set-Location C:
# $Shell.WindowTitle="Trent's Powershell"
# new-item alias:np -value C:WindowsSystem32notepad.exe

# TODO: Figure out how to import this
# PS C:\Program Files\Microsoft System Center 2012 R2\Virtual Machine Manager\bin\psModules\virtualmachinemanager> Import-Module .\virtualmachinemanager.psd1


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

function Invoke-LintFile ($file)
{
  Invoke-ScriptAnalyzer -Path $file
}

function Edit-BeautifyFile ($file)
{
  # TODO: Figure out how to Import better

  # For whatever reason, I can't just import from the absolute path
  $currentDirectory = ($pwd).path
  Set-Location "C:\Projects\powershell-scripts\PowerShell-Beautifier\src\"
  Import-Module '.\DTW.PS.Beautifier.psd1'
  Set-Location $currentDirectory

  Edit-DTWBeautifyScript -SourcePath $file
}

function Get-PSVersion
{
  Write-Output $PSVersionTable.PSVersion
}

function Get-HostName ($address)
{
  $result = [System.Net.Dns]::GetHostByAddress($address)

  $result.HostName
}

function Get-ADUserMemberOf {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory = $True)]
    [string]$User,
    [string]$Server = "hq.echogl.net"
  )

  Get-ADUser $User -Server $Server -Properties MemberOf | Select-Object -ExpandProperty memberof
}

# From kitchen-hyperv
function Get-VmIP ($vm) {
  Start-Sleep -Seconds 10
  $vm.networkadapters.ipaddresses |
  Where-Object {
    $_ -match '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$'
  } |
  Select-Object -First 1
}

# From kitchen-hyperv
function Get-VmDetail {
  [CmdletBinding()]
  param($name)

  Get-VM -Name $name |
  ForEach-Object {
    $vm = $_
    do {
      Start-Sleep -Seconds 1
    }
    while (-not (Get-VmIP $vm))

    [pscustomobject]@{
      Name = $vm.Name
      Id = $vm.Id
      IpAddress = (Get-VmIP $vm)
    }
  }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path ($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# https://stackoverflow.com/a/37015895
# TODO: Function to find computers across a domain and then services on them
# function Find-Service
# {
#   # TODO: Figure out why it's tabbing like this!!!
#   }

# TODO: Get this working
# function get-chefstacktrace($vm_name)
# {
#   $machine = "TODO: paramiterize this"
#   Import-Module -Name Hyper-V
#   $machineCred = new-object -typename System.Management.Automation.PSCredential -argumentlist "Administrator", (ConvertTo-SecureString "TODO: paramiterize this" -AsPlainText -Force)

#   $machine_computer_name = "WIN-VQTTLU5I930"

#   $currentDirectory = ($pwd).path

#   $remote_session = New-PSSession -VMName $vm_name -Credential (Get-Credential)
#   $stacktrace_path = "C:\Users\Administrator\AppData\Local\Temp\kitchen\cache\chef-stacktrace.out"

#   $destination = ".\temp-stack-trace.txt"

#   Copy-Item -FromSession $remote_session -Path $stacktrace_path -Destination $destination

#   Get-Content $destination

#   Remove-PSSession $remote_session
# }
