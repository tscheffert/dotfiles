# ConEmu - Tasks

## Zsh from Git for Windows SDK

### Open in Directory with Connector

Task contents:

```
>-cur_console:t:"<TITLE>"
-cur_console:d:<DIRECTORY>
set CHERE_INVOKING=1 &
set "PATH=C:\git-sdk-64\usr\bin;%PATH%" &
set MSYSTEM=MINGW64 &
"%ConEmuBaseDirShort%\conemu-msys2-64.exe zsh --login -i"
```

Where:

- All the lines in the snippet are joined to the same line, no newlines
- `<TITLE>` is the title of the tab
- `<DIRECTORY>` is the directory you want to open in
  - Example:
    - `C:\Projects\gitlab\scm\chef-repo`
    - `%userprofile%/.dotfiles`

Could also specify it as a task parameter like this: `/dir "C:\Projects"`


#### Directories I had tasks for:

```
C:\Projects\gitlab\scm\chef-repo
C:\Projects\gitlab\chef-developers
C:\Projects\gitlab\scm\infrastructure-deploy
%userprofile%/.dotfiles
%userprofile%/prj/notes
```

### Open Directory without Connector

All in one line, joined

```
-cur_console:t:"zsh"
set CHERE_INVOKING=1 &
set "PATH=C:\git-sdk-64\usr\bin;%PATH%" &
set MSYSTEM=MINGW64 &
C:\git-sdk-64\usr\bin\zsh.exe --login -i"
```

### `Zsh::CurD`

Basically, just set `CHERE_INVOKING=1` and don't pass any other directories.

Task contents:
```
-cur_console:t:"zsh"
set CHERE_INVOKING=1 &
set "PATH=C:\git-sdk-64\usr\bin;%PATH%" &
set MSYSTEM=MINGW64 &
"%ConEmuBaseDirShort%\conemu-msys2-64.exe zsh --login -i"
```

### `Zsh::All`

Open Multiple tabs all at once like this:

```
>-cur_console:t:"k8s manifests" -cur_console:d:C:\Projects\azure-repos\devops\kubernetes-manifests set CHERE_INVOKING=1 & set "PATH=C:\git-sdk-64\usr\bin;%PATH%" & set MSYSTEM=MINGW64 & "%ConEmuBaseDirShort%\conemu-msys2-64.exe zsh --login -i"

>-cur_console:t:"k8s-yaml" -cur_console:d:C:\Projects\azure-repos\devcenter\k8s-yaml set CHERE_INVOKING=1 & set "PATH=C:\git-sdk-64\usr\bin;%PATH%" & set MSYSTEM=MINGW64 & "%ConEmuBaseDirShort%\conemu-msys2-64.exe zsh --login -i"

-cur_console:t:"devtools" -cur_console:d:C:\Projects\gitlab\devops\devtools set CHERE_INVOKING=1 & set "PATH=C:\git-sdk-64\usr\bin;%PATH%" & set MSYSTEM=MINGW64 & "%ConEmuBaseDirShort%\conemu-msys2-64.exe zsh --login -i"

-cur_console:t:"dotfiles" -cur_console:d:%userprofile%\.dotfiles set CHERE_INVOKING=1 & set "PATH=C:\git-sdk-64\usr\bin;%PATH%" & set MSYSTEM=MINGW64 & "%ConEmuBaseDirShort%\conemu-msys2-64.exe zsh --login -i"

-cur_console:t:"notes" -cur_console:d:C:\Projects\notes set CHERE_INVOKING=1 & set "PATH=C:\git-sdk-64\usr\bin;%PATH%" & set MSYSTEM=MINGW64 & "%ConEmuBaseDirShort%\conemu-msys2-64.exe zsh --login -i"
```

## WSL Bash

### `WSL::24bit`

Task parameters:

```
-icon "%USERPROFILE%\AppData\Local\lxss\bash.ico"
```

Task contents:

```
"%USERPROFILE%\.dotfiles\wsl\wsl-con.cmd"
```

### `WSL::bash` First Version

Task parameters:

```
-icon "%USERPROFILE%\AppData\Local\lxss\bash.ico"
```

Task contents:

```
set "PATH=%ConEmuBaseDirShort%\wsl;%PATH%" & %ConEmuBaseDirShort%\conemu-cyg-64.exe --wsl -cur_console:pm:/mnt -t zsh --login -i
```

### `WSL::bash` Second Version

Task parameters:
```
-icon "%LOCALAPPDATA%\lxss\bash.ico"
```

Task contents:

```
%windir%\system32\bash.exe -cur_console:p
```

### `WSL::wsltty`

Task contents:
```
"%LOCALAPPDATA%\wsltty\bin\mintty.exe" --wsl -o Locale=C -o Charset=UTF-8 -i "%LOCALAPPDATA%\lxss\bash.ico" /bin/wslbridge -C~ -t zsh --login -i
```

## Other Task Examples:

### `Shells::cmd 64/32`

```
> "%windir%\system32\cmd.exe" /k ""%ConEmuBaseDir%\CmdInit.cmd" & echo This is Native cmd.exe"

"%windir%\syswow64\cmd.exe" /k ""%ConEmuBaseDir%\CmdInit.cmd" & echo This is 32 bit cmd.exe -new_console:s50V"
```

### Show ANSI colors

```
cmd /k type "%ConEmuBaseDir%\Addons\AnsiColors16t.ans" -cur_console:n
```
