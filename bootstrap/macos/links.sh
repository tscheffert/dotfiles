#!/usr/bin/env bash

repo_root="$(git rev-parse --show-toplevel)"
source "$repo_root/bootstrap/bootstrap_functions.sh"

echo ""
echo " -- Linking dotfiles --"

if [[ ! -d $HOME/.dotfiles ]]; then
  warn "No ~/.dotfiles folder found"
  exit 1
fi

# Symlink directories
link_directory "$HOME/.dotfiles/.git_template" "$HOME/.git_template"
link_directory "$HOME/.dotfiles/Alfred/Alfred.alfredpreferences" "$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences"
link_directory "$HOME/.dotfiles/bin" "$HOME/bin"
link_directory "$HOME/.dotfiles/iTerm" "$HOME/iTerm"
link_directory "$HOME/.dotfiles/vimfiles" "$HOME/.vim"
link_directory "$HOME/.dotfiles/zsh" "$HOME/.zsh"
mkdir -p "$HOME/.config"
link_directory "$HOME/.dotfiles/.config/karabiner" "$HOME/.config/karabiner"

# Symlink files
link_file .agignore
link_file .aprc
link_file .bash_profile
link_file .bashrc
link_file .ctags
link_file .curlrc
link_file .dir_colors
# link_file .editorconfig
link_file .gemrc
link_file .gitconfig
link_file .gitignore
link_file .inputrc
link_file .irbrc
# link_file .jscs.json
# link_file .jshintrc
# link_file .osx
link_file .pryrc
link_file .psqlrc
link_file .rubocop-disabled.yml
link_file .rubocop-enabled.yml
link_file .rubocop.yml
# link_file .slate
# link_file .tmux.conf
link_file .vimrc
link_file .yamllint
link_file .zshrc
link_file Brewfile
link_file console_config.rb

# Symlink Optional files
link_optional_file .zshrc.local
link_optional_file .zshrc.private

# Other links
link_file_with_directory .hammerspoon init.lua
link_file_with_directory .hammerspoon/icons caffeinate-on.png
link_file_with_directory .hammerspoon/icons caffeinate-off.png

echo "Dotfiles have been symlinked to $HOME."

echo " -- Finished linking dotfiles --"
