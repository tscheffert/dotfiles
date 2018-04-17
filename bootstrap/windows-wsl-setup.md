# Set Up Shell
## Install Windows Subsystem for Linux

### Enable Windows Feature
In powershell
```powershell
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

Reboot when it asks.

### Turn on Developer Mode
Turn on developer mode. Open Settings -> Update and Security -> For developers. Select
the _Developer mode_ radio button.

Then, in `cmd.exe`:
```
C:\Windows\System32\bash.exe
```

This will install Ubuntu and will prompt you for an Ubuntu Username/Password. Install
data located at  `%localappdata%\lxss\`.

### Update WSL Packages
```bash
sudo apt-get update
sudo apt-get upgrade
```

### Update Ubuntu OS
```
sudo -S apt-mark hold procps strace sudo
sudo -S env RELEASE_UPGRADER_NO_SCREEN=1 do-release-upgrade
```

## Set up SSH Keys
Set up ssh keys like this:
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

At Echo I used:
- `id_rsa` for Github
- `id_rsa_echo` for Echo Gitlab

[Github help article regarding SSH keys](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)

### Using non standard ssh key names
You need to set up your _~/.ssh/config_ with entries like:
```
# Echo Gitlab Server
Host git.echo.com
IdentityFile ~/.ssh/id_rsa_echo
```

### Testing SSH connection to Github
```bash
ssh -T git@github.com
```

## Setting up ConEmu Task:
Parameters:
```
-icon "%USERPROFILE%\AppData\Local\lxss\bash.ico"
```

Commands:
```
"%USERPROFILE%\.dotfiles\wsl\wsl-con.cmd"
```

## Install Relevant Software

### Install Zsh
```bash
cd ~/.dotfiles
bash ./bootstrap/wsl/zsh.sh
```

### Install Apps
```bash
cd ~/.dotfiles
bash ./bootstrap/wsl/apps.sh
```

### Install Vim
```bash
cd ~/.dotfiles
bash ./bootstrap/wsl/vim.sh
```

### Troubleshooting:

#### Bad owner or permissions on ~/.ssh/config
If you receive an error that includes the following after any ssh command:
```
Bad owner or permissions on ~/.ssh/config
```

Then you need to set the _~/.ssh/config_ file to user read-writeable only:
```bash
chmod 0600 ~/.ssh/config
```

### Zsh compinit and compaudit
Symptom: Running compinit results in a message like this:
```
... Ignore insecure directories and continue ...
```

Solution:
```bash
compaudit | xargs chown -R "$(whoami)"
compaudit | xargs chmod go-w
```
