# Windows Tips And Tricks

## Networking

### Updating the network adapter

```
# netsh interface ip set address name="<name>" static <IP> <subnet> <gateway>
netsh interface ip set address name="Ethernet0" static 172.25.16.200 255.255.255.0 172.25.16.1
```

## Clean up start components with DISM

```
Dism /Online /Cleanup-Image /StartComponentCleanup /ResetBase
```

## Robocopy Some Stuff

```
robocopy "M:Movies" "N:Movies Copy" /E /R:0 /W:0 /log:robocopy-movies.log /Xf *
```

## Windows Service Install/Uninstall

Install:

```
C:\Windows\Microsoft.NET\Framework\v4.0.30319\installutil.exe Wcfhost.exe
pause
```

Uninstall:

```
C:\Windows\Microsoft.NET\Framework\v4.0.30319\installutil.exe -u Wcfhost.exe
pause
```

## Fix CredSSP Issue when RDPing

```
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" /v AllowEncryptionOracle /t REG_DWORD /d 2
```
