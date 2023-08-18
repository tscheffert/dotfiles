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

## Searching with Everything

<https://www.voidtools.com/support/everything/command_line_interface/>


```
es -path .
```

## Pip Install Failure

```
>>> pip install yamllint
Collecting yamllint
  Using cached yamllint-1.28.0-py2.py3-none-any.whl (62 kB)
Collecting pyyaml
  Using cached PyYAML-6.0-cp39-cp39-win_amd64.whl (151 kB)
Collecting pathspec>=0.5.3
  Using cached pathspec-0.10.2-py3-none-any.whl (28 kB)
Requirement already satisfied: setuptools in c:\python39\lib\site-packages (from yamllint) (57.4.0)
Installing collected packages: pyyaml, pathspec, yamllint
  WARNING: Failed to write executable - trying to use .deleteme logic
ERROR: Could not install packages due to an OSError: [WinError 2] The system cannot find the file specified: 'C:\\Python39\\Scripts\\yamllint.exe' -> 'C:\\Python39\\Scripts\\yamllint.exe.deleteme'

WARNING: You are using pip version 21.2.3; however, version 22.3.1 is available.
```

Solution is to grant `<PC>\Users` full control off the `<path>\Scripts` folder so that pip can put the exe there when installing.
