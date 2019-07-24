# Backup App

## TODO

- Script to capture GitHub directory entries
- Script to capture Tools directory entries
- Script to capture:
  - Gems
  - npm packages
  - pip packages
  - paths
  - Chocolatey packages
- Script to capture pacman, windows, and chocolatey programs
- Somehow get these programs config:
  - Typora Config
  - Gimp config
  - 1Password vault
  - WOX Config
- Font

## Things to backup

### Straight Zips, maybe differentials

- CLI History
  - ZSH: `C:/Users/tscheffert/.zsh_history`
  - Bash: `C:/Users/tscheffert/.bash_history`
  - Powershell
  - ConEmu Logging
  - TMUX
  - Utilities
    - Pry: `C:/Users/tscheffert/.pry_history`
    - IRB: `C:\Users\tscheffert\.irb_history`
    - PSQL
    - osqueryi
  - ssh config
- Projects
  - dotfiles repo
  - GitLab
  - svn
    - This is too large, maybe just the `svn/devops` folder? Only the Trunk branches
      instead of branches and tags maybe?

### Simple output capture

- Projects
  - GitHub file structure
- Programming
  - Gem lists across all versions
  - Global npm packages
  - Pip2 and Pip3 packages
  - System and User paths
- Programs
  - `C:/tools` folder and files structure
  - pacman installed packages list
  - Chocolatey installed packages list
  - Windows installed applications list

### More effort required

- Firefox
  - Profile: `C:\Users\tscheffert\AppData\Roaming\Mozilla\Firefox\Profiles\46ojgpuh.default`
  - Plugins
    - Session Manager Session: `C:/Users/tscheffert/firefox-sessions`
    - Session Manager Config: Export via gui
    - Tab Groups Config: Export via gui
    - Tab Groups Session: Export via gui
    - Reddit Enhancement Suite: Export via gui
    - Tab Mix Plus Config: Export via options
    - Tampermonkey Scripts: Export Zip through `Utilities` tab
    - uBlock Origin Config: Export by clicking `Back up to file` in the Addon GUI
- Windows Config
  - How?
    - Only configure using powershell?
    - Registry entries only with regedit file?
    - Is there a "backup settings" option?
- Programs
  - Typora Config
  - Gimp config
  - 1Password vault
  - WOX Config
- Other
  - Font

## Use This

- <https://github.com/backup/backup>
