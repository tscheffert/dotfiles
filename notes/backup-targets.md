
# Backup Targets

## Files

- Bash: `C:/Users/tscheffert/.bash_history`
- Powershell `"C:/Users/tscheffert/AppData/Roaming/Microsoft/Windows/PowerShell/PSReadline/ConsoleHost_history.txt"`
- Pry: `C:/Users/tscheffert/.pry_history`
- IRB: `C:/Users/tscheffert/.irb_history`
- less: `C:/Users/tscheffert/.lesshst`

## Directories

- ZSH: `C:/Users/tscheffert/.zsh_history`
- ConEmu Logging: `C:/Users/tscheffert/ConEmu-Logs`
- ssh config: `C:/Users/tscheffert/.ssh`
- svn
  - This is too large, maybe just the `svn/devops` folder? Only the Trunk branches
    instead of branches and tags maybe?
- Notes/Documents
  - `C:/Projects/docs`
  - `C:/Projects/notes`
  - `C:/Projects/powershell-scripts`
  - `C:/Projects/registry-changes`
  - `C:/Projects/scripts`
- Gimp config: `C:/Users/tscheffert/AppData/Roaming/GIMP/2.10` # TODO: Will this dir change after an upgrade?
- Typora Config: `C:/Users/tscheffert/AppData/Roaming/Typora/conf`
- WOX Config: `C:/Users/tscheffert/AppData/Roaming/Wox/Settings`

## Git Directories for now

- devtools:

## Directories after git-clean

- GitLab, Check for big ones, `node_modules` and bin files are bad
- Azure Repos, Check for big ones, `node_modules` and bin files are bad

## Directories with effort

- dotfiles repo `C:/Users/tscheffert/.dotfiles`
  - Check for mega sized files:
    - `C:/Users/tscheffert/.dotfiles/vimfiles/tmp/backup`
    - `C:/Users/tscheffert/.dotfiles/vimfiles/tmp/undo`

## Command Output, trimmed afterwards

- GitHub file structure
  - `(robocopy C:/Projects/github NULL /l /s /ndl /xx /nc /ns /njh /njs /fp) > github-files.txt`
- `C:/tools` folder and files structure
  - `(robocopy C:/tools NULL /l /s /ndl /xx /nc /ns /njh /njs /fp) > tools-files.txt`
- Gem lists across all versions
  - `which gem`, then for each of them: `gem list > ruby-oneclick-gems.txt`
- Global npm packages: `npm -g list > npm-packages.txt`
- Pip2 and Pip3 packages
  - `pip2 list > pip2-packages.txt`
  - `pip3 list > pip3-packages.txt`
- System and User paths
- Chocolatey packages: `choco list --local-only`
- pacman installed packages list
- Windows installed applications list

## Files requiring generation

- Firefox
  - Profile: `C:/Users/tscheffert/AppData/Roaming/Mozilla/Firefox/Profiles/46ojgpuh.default`
  - Plugins
    - Session Manager Session: `C:/Users/tscheffert/firefox-sessions`
      - Only the settings and recently touched sessions
    - Session Manager Config: Export via gui
    - Tab Groups Config: Export via gui to `C:\Users\tscheffert\firefox-tab-groups\`
    - Tab Groups Session: Export via gui to `C:\Users\tscheffert\firefox-tab-groups\`
    - Reddit Enhancement Suite: Export via gui
    - Tab Mix Plus Config: Export via options
    - Tampermonkey Scripts: Export Zip through `Utilities` tab
    - uBlock Origin Config: Export by clicking `Back up to file` in the Settings tab GUI
    - uBlock Origin Static Filters: Export by cling `Back up to file` in the Filters tab of the GUI

## Other

- WSL dotfiles and WSL config
- 1Password vault
- Font
- TMUX??
- PSQL
- osqueryi
- Slack Emoji: <https://gist.github.com/lmarkus/8722f56baf8c47045621>
- Windows Config, but how?
  - Only configure using powershell?
  - Registry entries only with regedit file?
  - Is there a "backup settings" option?
