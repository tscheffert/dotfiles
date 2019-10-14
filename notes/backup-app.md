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
    - `"C:\Users\tscheffert\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"`
  - ConEmu Logging
    - `"C:\Users\tscheffert\ConEmu-Logs"`
  - TMUX
  - Utilities
    - Pry: `C:/Users/tscheffert/.pry_history`
    - IRB: `C:\Users\tscheffert\.irb_history`
    - PSQL
    - osqueryi
    - less: `C:/Users/tscheffert/.lesshst`
  - ssh config
    - `C:/Users/tscheffert/.ssh`
- Projects
  - dotfiles repo
    - Check for mega sized files:
      - `C:\Users\tscheffert\.dotfiles\vimfiles\tmp\backup`
      - `C:\Users\tscheffert\.dotfiles\vimfiles\tmp\undo`
  - GitLab
  - Azure Repos
  - svn
    - This is too large, maybe just the `svn/devops` folder? Only the Trunk branches
      instead of branches and tags maybe?
- Notes/Documents
  - `C:\Projects\docs`
  - `C:\Projects\notes`
  - `C:\Projects\powershell-scripts`
  - `C:\Projects\registry-changes`
  - `C:\Projects\scripts`

### Simple output capture

- Projects
  - GitHub file structure
    - `(robocopy C:/Projects/github NULL /l /s /ndl /xx /nc /ns /njh /njs /fp) > github-files.txt`
- Programming
  - Gem lists across all versions
    - `gem list > ruby-oneclick-gems.txt`
  - Global npm packages
    - `npm -g list > npm-packages.txt`
  - Pip2 and Pip3 packages
    - `pip2 list > pip2-packages.txt`
    - `pip3 list > pip3-packages.txt`
  - System and User paths
- Programs
  - `C:/tools` folder and files structure
    - `(robocopy C:/tools NULL /l /s /ndl /xx /nc /ns /njh /njs /fp) > tools-files.txt`
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
    - <C:\Users\tscheffert\AppData\Roaming\Typora\conf>
  - Gimp config
  - 1Password vault
  - WOX Config
    - <C:\Users\tscheffert\AppData\Roaming\Wox\Settings>
- Other
  - Font

## Use This

- <https://github.com/backup/backup>
