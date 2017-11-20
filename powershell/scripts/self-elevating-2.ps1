# Option #2
# From: https://stackoverflow.com/questions/7690994/powershell-running-a-command-as-administrator

if ([bool]([Security.Principal.WindowsIdentity]::GetCurrent()).Groups -notcontains "S-1-5-32-544") {
  Start Powershell -ArgumentList "& '$MyInvocation.MyCommand.Path'" -Verb runas
}
