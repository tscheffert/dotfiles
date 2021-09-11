# Windows

## Execution Policy

In Powershell as admin:
```powershell
Set-ExecutionPolicy AllSigned # Enter Y when prompted

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
