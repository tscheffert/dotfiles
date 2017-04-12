#!/usr/env/bin bash

# Symlinks:
# +-- ln(1) link, ln -- make links
# |   +-- Create a symbolic link.
# |   |                         +-- the path to the intended symlink
# |   |                         |   can use . or ~ or other relative paths
# |   |                   +--------------+
# ln -s /path/to/original /path/to/symlink
#       +---------------+
#               +-- the path to the original file/folder
#                   can use . or ~ or other relative paths
#
#   Options:
#   -f If the target file already exists, then unlink it so that the link may occur.

link_directory() {
  local from="$1"
  local to="$2"

  if [[ -d $from ]]; then
    if [[ -h "$to" ]]; then
      echo "Directory '${to}' already exists, skipping link"
    else
      echo "Linking directory ${from} to ${to}"
      ln -sf "$from" "$to"
    fi
  fi
}

link_file() {
  local file="$1"

  ln -sf "$HOME/.dotfiles/$file" "$HOME/$file"
}

link_optional_file() {
  local file="$1"

  if [[ -f "$HOME/.dotfiles/$file" ]]; then
    ln -sf "$HOME/.dotfiles/$file" "$HOME/$file"
  fi
}

link_file_with_directory() {
  local dir="$1"
  local file="$2"

  if [[ ! -d $HOME/$dir ]]; then
    mkdir "$HOME/$dir"
  fi
  ln -sf "$HOME/.dotfiles/$dir/$file" "$HOME/$dir/$file"
}

echo ""
echo " -- Linking dotfiles --"

if [[ ! -d $HOME/.dotfiles ]]; then
  warn "No ~/.dotfiles folder found"
  exit 1
fi

# Symlink directories
link_directory "$HOME/.dotfiles/bin" "$HOME/bin"
link_directory "$HOME/.dotfiles/vimfiles" "$HOME/.vim"
link_directory "$HOME/.dotfiles/.git_template" "$HOME/.git_template"
link_directory "$HOME/.dotfiles/iTerm" "$HOME/iTerm"
link_directory "$HOME/.dotfiles/prompts" "$HOME/.prompts"
link_directory "$HOME/.dotfiles/zsh" "$HOME/.zsh"
link_directory "$HOME/.dotfiles/Alfred" "$HOME/Alfred"

# Symlink files
link_file .bash_profile
link_file .bashrc
link_file .curlrc
link_file .editorconfig
link_file .gitconfig
link_file .gitignore
link_file .jscs.json
link_file .jshintrc
link_file .osx
link_file .vimrc
link_file .slate
link_file .agignore
link_file .pryrc
link_file .gemrc
link_file .rubocop.yml
link_file .rubocop-enabled.yml
link_file .rubocop-disabled.yml
link_file .tmux.conf
link_file .zshrc
link_file .aprc
link_file .inputrc
link_file .irbrc
link_file .psqlrc
link_file .dir_colors
link_file console_config.rb
link_file .yamllint
link_file .ctags

# Symlink Optional files
link_optional_file .zshrc.local
link_optional_file .zshrc.private

# Other links
link_file_with_directory .hammerspoon init.lua
link_file_with_directory .hammerspoon/icons caffeinate-on.png
link_file_with_directory .hammerspoon/icons caffeinate-off.png

# Link karabainer-elements config
# NOTE: This isn't working yet, still have to use vanilla Karabiner
mkdir -p "$HOME/.config/karabiner"
ln -sf "$HOME/.dotfiles/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

# Link karabiner config
mkdir -p "$HOME/Library/Application Support/Karabiner"
ln -sf "$HOME/.dotfiles/karabiner/private.xml" "$HOME/Library/Application Support/Karabiner/private.xml"

echo "Dotfiles have been symlinked to $HOME."

echo " -- Finished linking dotfiles --"
