# Option 3
# From: https://stackoverflow.com/questions/7690994/powershell-running-a-command-as-administrator

[CmdletBinding(DefaultParametersetName = 'RunWithPowerShellContextMenu')]
param(
  [Parameter(ParameterSetName = 'CallFromCommandLine')]
  [switch]$CallFromCommandLine,

  [Parameter(Mandatory = $false,ParameterSetName = 'RunWithPowerShellContextMenu')]
  [Parameter(Mandatory = $true,ParameterSetName = 'CallFromCommandLine')]
  [string]$ComputerName,

  [Parameter(Mandatory = $false,ParameterSetName = 'RunWithPowerShellContextMenu')]
  [Parameter(Mandatory = $true,ParameterSetName = 'CallFromCommandLine')]
  [uint16]$Port
)

function Assert-AdministrativePrivileges ([bool]$CalledFromRunWithPowerShellMenu)
{
  $isAdministrator = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

  if ($isAdministrator)
  {
    if (!$CalledFromRunWithPowerShellMenu -and !$CallFromCommandLine)
    {
      # Must call itself asking for obligatory parameters
      & "$PSCommandPath" @script:PSBoundParameters -CallFromCommandLine
      exit
    }
  }
  else
  {
    if (!$CalledFromRunWithPowerShellMenu -and !$CallFromCommandLine)
    {
      $serializedParams = [Management.Automation.PSSerializer]::Serialize($script:PSBoundParameters)

      $scriptStr = @"
                `$serializedParams = '$($serializedParams -replace "'", "''")'

                `$params = [Management.Automation.PSSerializer]::Deserialize(`$serializedParams)

                & "$PSCommandPath" @params -CallFromCommandLine
"@

      $scriptBytes = [System.Text.Encoding]::Unicode.GetBytes($scriptStr)
      $encodedCommand = [convert]::ToBase64String($scriptBytes)

      # If this script is called from another one, the execution flow must wait for this script to finish.
      Start-Process -FilePath 'powershell' -ArgumentList "-ExecutionPolicy Bypass -NoProfile -EncodedCommand $encodedCommand" -Verb 'RunAs' -Wait
    }
    else
    {
      # When you use the "Run with PowerShell" feature, the Windows PowerShell console window appears only briefly.
      # The NoExit option makes the window stay visible, so the user can see the script result.
      Start-Process -FilePath 'powershell' -ArgumentList "-ExecutionPolicy Bypass -NoProfile -NoExit -File ""$PSCommandPath""" -Verb 'RunAs'
    }

    exit
  }
}

function Get-UserParameters ()
{
  [string]$script:ComputerName = [Microsoft.VisualBasic.Interaction]::InputBox('Enter a computer name:','Testing Network Connection')

  if ($script:ComputerName -eq '')
  {
    throw 'The computer name is required.'
  }

  [string]$inputPort = [Microsoft.VisualBasic.Interaction]::InputBox('Enter a TCP port:','Testing Network Connection')

  if ($inputPort -ne '')
  {
    if (-not [uint16]::TryParse($inputPort,[ref]$script:Port))
    {
      throw "The value '$inputPort' is invalid for a port number."
    }
  }
  else
  {
    throw 'The TCP port is required.'
  }
}

# $MyInvocation.Line is empty in the second script execution, when a new powershell session
# is started for this script via Start-Process with the -File option.
$calledFromRunWithPowerShellMenu = $MyInvocation.Line -eq '' -or $MyInvocation.Line.StartsWith('if((Get-ExecutionPolicy')

Assert-AdministrativePrivileges $calledFromRunWithPowerShellMenu

# Necessary for InputBox
[System.Reflection.Assembly]::Load('Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a') | Out-Null

if ($calledFromRunWithPowerShellMenu)
{
  Get-UserParameters
}

# ... script code
Test-NetConnection -ComputerName $ComputerName -Port $Port
