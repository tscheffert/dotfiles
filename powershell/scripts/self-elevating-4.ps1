# Option #4
# From: https://stackoverflow.com/questions/7690994/powershell-running-a-command-as-administrator

param(
  [switch]$IsRunAsAdmin = $false
)

# Get our script path
$ScriptPath = (Get-Variable MyInvocation).Value.MyCommand.Path

#
# Launches an elevated process running the current script to perform tasks
# that require administrative privileges.  This function waits until the
# elevated process terminates.
#
function LaunchElevated
{
  # Set up command line arguments to the elevated process
  $RelaunchArgs = '-ExecutionPolicy Unrestricted -file "' + $ScriptPath + '" -IsRunAsAdmin'

  # Launch the process and wait for it to finish
  try
  {
    $AdminProcess = Start-Process "$PsHome\PowerShell.exe" -Verb RunAs -ArgumentList $RelaunchArgs -Passthru
  }
  catch
  {
    $Error[0] # Dump details about the last error
    exit 1
  }

  # Wait until the elevated process terminates
  while (!($AdminProcess.HasExited))
  {
    Start-Sleep -Seconds 2
  }
}
