mklink /j %userprofile%\bin %userprofile%\.dotfiles\bin
mklink /j %userprofile%\vimfiles %userprofile%\.dotfiles\vimfiles
mklink /j %userprofile%\.git_template %userprofile%\.dotfiles\.git_template
mklink /j %userprofile%\.prompts %userprofile%\.dotfiles\prompts
mklink /j %userprofile%\.zsh %userprofile%\.dotfiles\zsh
mklink /j %userprofile%\AutoHotkey %userprofile%\.dotfiles\AutoHotkey
mklink %userprofile%\.bash_profile %userprofile%\.dotfiles\.bash_profile
mklink %userprofile%\.bashrc %userprofile%\.dotfiles\.bashrc
mklink %userprofile%\.inputrc %userprofile%\.dotfiles\.inputrc
mklink %userprofile%\.dir_colors mklink %userprofile%\.dotfiles\.dir_colors
mklink "C:\\Program Files\\ConEmu\\ConEmu.xml" %userprofile%\.dotfiles\ConEmu.xml
mklink %userprofile%\.curlrc %userprofile%\.dotfiles\.curlrc
mklink %userprofile%\.editorconfig %userprofile%\.dotfiles\.editorconfig
mklink %userprofile%\.gitconfig %userprofile%\.dotfiles\.gitconfig
mklink %userprofile%\.gitignore %userprofile%\.dotfiles\.gitignore
mklink %userprofile%\.jscs.json %userprofile%\.dotfiles\.jscs.json
mklink %userprofile%\.jshintrc %userprofile%\.dotfiles\.jshintrc
mklink %userprofile%\.vimrc %userprofile%\.dotfiles\.vimrc
mkdir %userprofile%\Documents\WindowsPowerShell
mklink %userprofile%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 %userprofile%\.dotfiles\powershell\Microsoft.PowerShell_profile.ps1
mklink %userprofile%\.agignore %userprofile%\.dotfiles\.agignore
mklink %userprofile%\.pryrc %userprofile%\.dotfiles\.pryrc
mklink %userprofile%\.irbrc %userprofile%\.dotfiles\.irbrc
mklink %userprofile%\console_config.rb %userprofile%\.dotfiles\console_config.rb
mklink %userprofile%\.gemrc %userprofile%\.dotfiles\.gemrc
mklink %userprofile%\.tmux.conf %userprofile%\.dotfiles\.tmux.conf
mklink %userprofile%\.zshrc %userprofile%\.dotfiles\.zshrc
mklink %userprofile%\.aprc %userprofile%\.dotfiles\.aprc
mklink %userprofile%\.ctags %userprofile%\.dotfiles\.ctags
mklink %userprofile%\.yamllint mklink %userprofile%\.dotfiles\.yamllint

pause
