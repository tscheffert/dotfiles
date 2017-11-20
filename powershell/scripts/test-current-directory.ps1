function Get-ScriptDirectory
{
  $Invocation = (Get-Variable MyInvocation -Scope 0).Value;
  if ($Invocation.PSScriptRoot)
  {
    $Invocation.PSScriptRoot;
  }
  elseif ($Invocation.MyCommand.Path)
  {
    Split-Path $Invocation.MyCommand.Path
  }
  else
  {
    Write-Host $Invocation.InvocationName
    $Invocation.InvocationName.Substring(0,$Invocation.InvocationName.LastIndexOf("\"));
  }
}

function Get-AbsolutePath {

  [CmdletBinding()]
  param(
    [Parameter(
      Mandatory = $false,
      ValueFromPipeline = $true
    )]
    [string]$relativePath = ".\"
  )

  if (Test-Path -Path $relativePath) {
    return (Get-Item -Path $relativePath).FullName -replace "\\$",""
  } else {
    Write-Error -Message "'$relativePath' is not a valid path" -ErrorId 1 -ErrorAction Stop
  }

}

Write-Host "1. + " + $PSScriptRoot

$splitPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
Write-Host "2. + " + $splitPath

$scriptDir = Get-ScriptDirectory
Write-Host "3. + " + $scriptDir

Write-Host "4. + " + (Get-Location).Path

Write-Host "5. + " + ($pwd).Path

$WorkingDir = Convert-Path .
Write-Host "6. + " + $WorkingDir


$abs = Get-AbsolutePath
Write-Host "7. + " + $abs

$resolvedPath = (Resolve-Path .\).Path
Write-Host "8. + " + $resolvedPath

$fullName = (Get-Item -Path ".\" -Verbose).FullName
Write-Host "9. + " + $fullName

Write-Host "10. + " + $MyInvocation.MyCommand.Path
