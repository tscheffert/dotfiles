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

function Invoke-LintFile ($file)
{
  Invoke-ScriptAnalyzer -Path $file
}

function Edit-BeautifyFile ($file)
{
  # TODO: Figure out how to Import better

  # For whatever reason, I can't just import from the absolute path
  $currentDirectory = ($pwd).path
  Set-Location "C:\dev\powershell-scripts\PowerShell-Beautifier\src\"
  Import-Module '.\DTW.PS.Beautifier.psd1'
  Set-Location $currentDirectory

  Edit-DTWBeautifyScript -SourcePath $file
}

function Get-PSVersion
{
  Write-Host $PSVersionTable.PSVersion
}

function Get-HostName($address)
{
  $result = [System.Net.Dns]::GetHostByAddress($address)

  $result.HostName
}

function Get-ADUserMemberOf {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$User,
        [string]$Server="hq.echogl.net"
    )

    Get-ADUser $User -Server $Server -Properties MemberOf | Select -ExpandProperty memberof
}

# From kitchen-hyperv
function Get-VmIP($vm) {
    start-sleep -seconds 10
    $vm.networkadapters.ipaddresses |
        Where-Object {
        $_ -match '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$'
    } |
        Select-Object -First 1
}

# From kitchen-hyperv
function Get-VmDetail {
    [cmdletbinding()]
    param($name)

    Get-VM -Name $name |
        ForEach-Object {
        $vm = $_
        do {
            Start-Sleep -Seconds 1
        }
        while (-not (Get-VmIP $vm))

        [pscustomobject]@{
            Name = $vm.name
            Id = $vm.ID
            IpAddress = (Get-VmIP $vm)
        }
    }
}
