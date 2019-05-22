# Powershell Tips and Tricks

## Get Powershell Version

```powershell
$PSVersionTable.PSVersion
```

## Get Windows Versions

Marketed builds like "1803" or "1809", same as `winver`:

```powershell
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
```

Actual system information version:

```
[System.Environment]::OSVersion.Version
```

## Working with objects

### Expand all the properties of an object

```powershell
... | Format-List *
```

### Filter by properties

If `status` is the property you want to filter by:

```powershell
... | Where {$_.status –eq 'running'} | ...
```

## Services

### Stop services only if they're running

```powershell
Get-Service chef-client | Where {$_.status –eq 'running'} | stop-service
```

### Set the startup type of a service to disabled

```
Set-Service -Name "chef-client" -StartupType Disabled
```

## Modules

### Check for specific Modules

```powershell
Get-Module -Name <name>
```

### List all available Modules

Just Modules:

```powershell
Get-Module -ListAvailable
```

With Files too:

```powershell
Get-Module -ListAvailable -All
```

Just Module Names:

```powershell
Get-Module | Get-Member -MemberType Property | Format-Table Name
```

Get modules installed on a remote computer:

```powershell
$s = New-PSSession -ComputerName <computer_name>

Get-Module -PSSession $s -ListAvailable
```

## Blade name from virtual machine

Get list of

```powershell
(get-item "HKLM:\SOFTWARE\Microsoft\Virtual Machine\Guest\Parameters").GetValue("HostName")
```

## List Event Logs and Sources

Source of all events from all logs based on events currently in the viewer:

```powershell
Get-EventLog -LogName * | ForEach-Object {$LogName = $_.Log;Get-EventLog -LogName $LogName -ErrorAction SilentlyContinue | Select-Object @{Name= "Log Name";Expression = {$LogName}}, Source -Unique}
```

Unique'd source of all events currently in the Application log

```powershell
Get-EventLog -LogName Application | Select-Object Source -Unique
```

```powershell
(Get-ChildItem HKLM:\SYSTEM\CurrentControlSet\Services\EventLog\Application).pschildname
```

## Check if Log exists

Ref: <http://msdn.microsoft.com/en-us/library/system.diagnostics.eventlog.exists(v=vs.110).aspx>

```powershell
[System.Diagnostics.EventLog]::Exists('Application');
```

## Check if Source exists
Ref: <http://msdn.microsoft.com/en-us/library/system.diagnostics.eventlog.sourceexists(v=vs.110).aspx>

```powershell
[System.Diagnostics.EventLog]::SourceExists("YourLogSource");
```

## PSSession

```powershell
$qa_creds = Get-Credential tscheffert@qa.echogl.net
$qa3_pltwrk01 = New-PSSession -Credential $qa_creds -ComputerName qa3-pltwrk01.qa.echogl.net
Enter-PSSession $qa3_pltwrk01
[Remote Server]: PS > ...  # Do stuff
[Remote Server]: PS > exit # When you're done
Get-PSSession | Remove-PSSession
```

## ForEach-Object

```
Get-Service Echo.XP.Carrier* | select -ExpandProperty DisplayName | foreach-object { sc.exe delete $_ }
```

## URL ACLs

### List the URL ACLS

<https://docs.microsoft.com/en-us/windows/desktop/http/show-urlacl>

```
netsh http show urlacl
```

### Add to url acl

<https://docs.microsoft.com/en-us/windows/desktop/http/add-urlacl>

Right:

```
PS C:\Windows\system32> netsh http add urlacl url=http://qa2-pltwrk01.qa.echogl.net:6021/ user=QA\svcXpCustWork listen=yes

URL reservation successfully added
```

Wrong:

```
PS C:\Windows\system32> netsh http add urlacl url=http://qa2-pltwrk01.qa.echogl.net:6021 user=QA\svcXpCustWork listen=yes

Url reservation add failed, Error: 87
The parameter is incorrect.
```

## Port Bindings

### List Port Bindings in cmd

*NOTE:* This command requires a session running as administrator

```cmd
netstat -a -b -o
```

Options:

- `a` displays all connections and listening ports
- `b` displays the executable involved in creating each connection or port, this
  can be slow. Use `-n` to only display numerical info and speed it up.
- `o` displays the owning process ID associated with each connection

To find a process and get more details:

```cmd
tasklist /fi "pid eq <pid>"
```

To kill a process if necessary:

```cmd
taskkill /PID <pid> [/F]
```

### GUI Options

#### Resource Monitor

Open 'Resource Monitor' and go to the network tab, open the "Listening Ports" flyout.

#### Sysinternals - TCPView

Open 'TCPView' from a sysinternals portable install

### Windows Event Viewer

`Eventvwr [<computer name>][/v:] [/l:<log file>][/c:] [/f:<filter>][/?]`

`<computer name>` — Specifies the computer name of the machine to view events for. *If this is not*
*given, local machine is assumed.*
`/v:<query or view file>`— Specifies a query or a 'view file' created by event viewer. Query file must
contain a valid Crimson XML query, starts with `<QueryList>`.  View file contains the XML query string
along with other settings, but doesn't contain events.  *This option is mutually exclusive with /c and /l*

`/l:<log file>]` — Specifies the log file to be opened This log file should be an exported EVTX, EVT, or ETL
file. *This option is mutually exclusive with /v and /c*

`/c:<channel>` — Specifies the name of the channel to be selected when the viewer starts. *This*
*option is mutually exclusive with /v and /l*

`/f:<filter>` — If used in conjunction with /c or /l, this specifies the filter to be applied to the channel or
log, in the form of an XPath query; if not in conjunction with /c or /l, this must be a valid Event Log
XML query that starts with <QueryList>.  If the query contains a space, then the entire query must be
enclosed in double quotes.  If the query itself contains double quotes, then you must change the
double quotes in the query to single quotes.  For example. the XML query, specified as `/f: "<QueryList><Query Id="0" Path="SystemA"><Select Path="SystemB">*[System[(Level=2)]</Select></Query></QueryList>"`
/? — Shows this usage message

## NSSM

### List Services

```
Get-WmiObject win32_service | ?{$_.PathName -like '*nssm*'} | select Name, DisplayName, State, PathName
```

## Find Files:

```
Get-ChildItem -Path "Z:" -Recurse | Where-Object { !$PsIsContainer -and [System.IO.Path]::GetFileNameWithoutExtension($_.Name) -eq "hosts" }
```

```
Get-ChildItem -Filter "*consul_1_2_2*" -Path "C:\chef\cache\remote_file" | Remove-Item
```

## Beautify and Lint

### Beautify files from git status

```
gs | awk '{ print $2 }' | xargs --max-args=1 -I _ powershell -Command "Edit-BeautifyFile -Path _"
```

## Searching

### Grep recursively

```
ls * -r | select-string -Pattern "Thing-I-Want-To-Find"
```
