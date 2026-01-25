# Windows

## Execution Policy

In Powershell as admin:
```powershell
Set-ExecutionPolicy AllSigned # Enter Y when prompted

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

## Fix Windows Search

- Run `gpedit.msc`
- Open Computer Config -> Administrative Templates -> Windows Components -> Search
- Edit `Do not allow web search` -> enable
- Edit `Don't search the web or display web results in Search` -> enable
- Edit `Allow Cloud Search` -> disable
- Edit `Allow Cortana` -> disable

## Get rid of garbage on lock screen

- Open Settings -> Personalization -> Lock screen
- Set Lock screen status -> None
