REM Make sure to check that these are actual links, not just folders that were created by something else
mklink /j %userprofile%\.vim %userprofile%\.dotfiles\vimfiles
mklink /j %userprofile%\vimfiles %userprofile%\.dotfiles\vimfiles

mklink /j %userprofile%\bin %userprofile%\.dotfiles\bin
mklink /j %userprofile%\.git_template %userprofile%\.dotfiles\.git_template
mklink /j %userprofile%\.prompts %userprofile%\.dotfiles\prompts
mklink /j %userprofile%\.zsh %userprofile%\.dotfiles\zsh
mklink /j %userprofile%\AutoHotkey %userprofile%\.dotfiles\AutoHotkey
mklink %userprofile%\.agignore %userprofile%\.dotfiles\.agignore
mklink %userprofile%\.aprc %userprofile%\.dotfiles\.aprc
mklink %userprofile%\.bash_profile %userprofile%\.dotfiles\.bash_profile
mklink %userprofile%\.bashrc %userprofile%\.dotfiles\.bashrc
mklink %userprofile%\.ctags %userprofile%\.dotfiles\.ctags
mklink %userprofile%\.curlrc %userprofile%\.dotfiles\.curlrc
mklink %userprofile%\.dir_colors %userprofile%\.dotfiles\.dir_colors
mklink %userprofile%\.editorconfig %userprofile%\.dotfiles\.editorconfig
mklink %userprofile%\.gemrc %userprofile%\.dotfiles\.gemrc
mklink %userprofile%\.gitconfig %userprofile%\.dotfiles\.gitconfig
mklink %userprofile%\.gitignore %userprofile%\.dotfiles\.gitignore
mklink %userprofile%\.inputrc %userprofile%\.dotfiles\.inputrc
mklink %userprofile%\.irbrc %userprofile%\.dotfiles\.irbrc
mklink %userprofile%\.jscs.json %userprofile%\.dotfiles\.jscs.json
mklink %userprofile%\.jshintrc %userprofile%\.dotfiles\.jshintrc
mklink %userprofile%\.mdlrc %userprofile%\.dotfiles\.mdlrc
mklink %userprofile%\.mdl.style %userprofile%\.dotfiles\.mdl.style
mklink %userprofile%\.pryrc %userprofile%\.dotfiles\.pryrc
mklink %userprofile%\.rubocop-disabled.yml %userprofile%\.dotfiles\.rubocop-disabled.yml
mklink %userprofile%\.rubocop-enabled.yml %userprofile%\.dotfiles\.rubocop-enabled.yml
mklink %userprofile%\.rubocop.yml %userprofile%\.dotfiles\.rubocop.yml
mklink %userprofile%\.tmux.conf %userprofile%\.dotfiles\.tmux.conf
mklink %userprofile%\.vimrc %userprofile%\.dotfiles\.vimrc
mklink %userprofile%\.yamllint %userprofile%\.dotfiles\.yamllint
mklink %userprofile%\.zshrc %userprofile%\.dotfiles\.zshrc
mklink %userprofile%\.zshrc.private %userprofile%\.dotfiles\.zshrc.private
mklink %userprofile%\console_config.rb %userprofile%\.dotfiles\console_config.rb
mkdir %APPDATA%\alacritty
mklink %userprofile%\AppData\Roaming\alacritty\alacritty.yml %userprofile%\.dotfiles\alacritty.yml

mkdir %userprofile%\Documents\WindowsPowerShell
mklink %userprofile%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 %userprofile%\.dotfiles\powershell\Microsoft.PowerShell_profile.ps1

mklink "C:\\Program Files\\ConEmu\\ConEmu.xml" %userprofile%\.dotfiles\ConEmu.xml

pause
