function sudo {
  try {
    # $ProcessStartInfo = New-Object System.Diagnostics.ProcessStartInfo

    # $command = $args[0]
    # $ProcessStartInfo.FileName = $command

    # if $args.Length -gt 1 {
    #   $command_args = $args[1..$args.Length]
    #   $ProcessStartInfo.Arguments = $command_args
    # }
    # $ProcessStartInfo.CreateNoWindow = $true
    # $ProcessStartInfo.RedirectStandardError = $True;
    # $ProcessStartInfo.RedirectStandardOutput = $True;
    # $ProcessStartInfo.UseShellExecute = $False;
    # $ProcessStartInfo.WindowStyle = "Hidden";
    # $ProcessStartInfo.Verb = "runas";

    # $process = New-Object System.Diagnostics.Process;
    # $process.StartInfo = $ProcessStartInfo;

    # $process.Start() | Out-Null; # ignore return value with Out-Null
    # $process.WaitForExit();

    # $stdout = $process.StandardOutput.ReadToEnd()
    # $stderr = $process.StandardError.ReadToEnd()
    # Write-Host "stdout: $stdout"
    # Write-Host "stderr: $stderr"
    # Write-Host "exit code: " + $process.ExitCode

    # Asumming actual arguments
    Start-Process $args[0] -ArgumentList $args[1..$args.Length] -Verb "runAs" -Wait
  }
  catch {
    Write-Error $_
  }
  finally {
    #Exit, or you'll have a loop
    exit
  }
}

function isadmin
 {
 # Returns true/false
   ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
 }
