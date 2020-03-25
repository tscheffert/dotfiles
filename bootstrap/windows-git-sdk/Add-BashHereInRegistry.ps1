#

# set-location -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\


# Get-Item -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run

# Set-Itemproperty -path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'VMware User Process' -value 'C:\Program Files\VMware\VMware Tools\vmtoolsd.exe'

# Add the drive for HKEY_CLASSES_ROOT cause it's not there by default
New-PSDrive -PSProvider registry -Root "HKEY_CLASSES_ROOT" -Name "HKCR"

$background_shell_path = "HKCR:\Directory\Background\shell"
$shell_name = "Alacritty"
New-Item -Path $background_shell_path -Name $shell_name

$alacritty_path = Join-Path -Path $background_shell_path -ChildPath $shell_name

New-ItemProperty -LiteralPath $alacritty_path -name '(Default)' -Value "Open Alacritty Here"

$alacritty_command = "C:\tools\alacritty\alacritty.exe"
$command_path = Join-Path -Path $alacritty_path -ChildPath "command"
New-Item -Path $alacritty_path -Name "command"
New-ItemProperty -LiteralPath $command_path -name '(Default)' -Value $alacritty_command
