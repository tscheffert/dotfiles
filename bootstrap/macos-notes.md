# macOS Bootstrapping Notes

## Steps

- Install Xcode Commandline Tools
  - `sudo xcode-select --install`
- Install any system updates from Apple -> System Preferences -> Software Update
- Install homebrew from brew.sh
  - Double check it worked with `brew doctor`
  - Ensure homebrew cask is tapped with `brew cask doctor`
- Install macvim: `brew install macvim`
- Clone dotfiles:
  - `cd ~; git clone https://github.com/tscheffert/dotfiles.git .dotfiles`
- Run `bash bootstrap/bootstrap_macos.sh` to get most things set up
- Ruby
  - Install appropriate ruby version
    - `rbenv install 2.7.1` or whatever relevant version
  - Set the default ruby version to the one you installed
    - `rbenv global 2.7.1`
- Set up iTerm2
- Set up Alfred
- Set up HammerSpoon
- Set up Karabiner Elements
- Install Greenshot from Mac App Store

## Work Setup

- Start Outlook and login
- Start Teams and login
- Install Horizon client
  - `brew install --cask vmware-horizon-client`

## TODO

- Figure out if we want TMUX stuff, in the `bootstrap/macos/apps.sh` file
- Determine how we'll sync up ruby between the shell, the os, and macvim. Optionally with `rbenv`
  - Currently the system default is 2.6.3, and macvim has it's own "keg only" 2.7 version
- Investigate these cask apps:
  ```
  arq
  cloudup
  hazel
  mailbox
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  screenflick
  seil
  shiori
  tower
  transmit
  ```
- <https://www.titanium-software.fr/en/onyx.html>
- <https://github.com/Mortennn/Dozer>
- <https://gist.github.com/cliss/74782128b9a35366ecac44a7c4b45752>
- <https://medium.com/@satorusasozaki/automate-mac-os-x-configuration-by-using-brewfile-58a78ce5cc53>
- <https://github.com/pstadler/dotfiles/blob/master/Brewfile>

- Figure out iTerm settings after updates
- Sort `Brewfile` alphabetically
- Get VPN working without Anyconnect?
  - Tunnelblick or Viscosity
- Check out VMware Parallels
- Time tracking app: <https://www.klokki.com/>
- Merging app: <https://www.kaleidoscopeapp.com/>

## Settings

- On battery icon, enable show percentage
- On menu bar, open display preferences and turn off the show menu bar icon
- On menu bar, open keyboard preferences and turn off the show menu bar icon
- In trackpad, disable natural scrolling
- In keyboard, use function keys as function keys
- Disable the cmd+space shortcut for spotlight

## Things to check


## Issues

### `compaudit` suggesting insecure directories

Error:

```
zsh compinit: insecure directories, run compaudit for list.
Ignore insecure directories and continue [y] or abort compinit [n]? y%
```

Solution:

Run the fix script:

```
bash bootstrap/fixes/fix_insecure_compaudit.sh
```

Double check it worked by running `compaudit` to see a list of dirs it still thinks are insecure.

## Parallels Set Up

- Install with `brew cask install parallels`
- Install windows 10 via the gui, sign in with Parallels account
- Install anyconnect, only the VPN.
- Run windows updates, restart
- Run more windows updates, restart
- Install git bash
- Install powershell 7
- Install chocolatey
