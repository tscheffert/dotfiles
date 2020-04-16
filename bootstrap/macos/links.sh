#!/usr/env/bin bash

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
link_directory "$HOME/.dotfiles/Alfred" "$HOME/Alfred"
link_directory "$HOME/.dotfiles/bin" "$HOME/bin"
link_directory "$HOME/.dotfiles/iTerm" "$HOME/iTerm"
link_directory "$HOME/.dotfiles/vimfiles" "$HOME/.vim"
link_directory "$HOME/.dotfiles/zsh" "$HOME/.zsh"

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
# link_file .inputrc
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

# Link karabainer-elements config
# NOTE: This isn't working yet, still have to use vanilla Karabiner
# mkdir -p "$HOME/.config/karabiner"
# ln -sf "$HOME/.dotfiles/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# Link karabiner config
# mkdir -p "$HOME/Library/Application Support/Karabiner"
# ln -sf "$HOME/.dotfiles/karabiner/private.xml" "$HOME/Library/Application Support/Karabiner/private.xml"

echo "Dotfiles have been symlinked to $HOME."

echo " -- Finished linking dotfiles --"
