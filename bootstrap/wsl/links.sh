#!/usr/bin/env bash

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
link_directory "$HOME/.dotfiles/.git_template" "$HOME/.git_template"
link_directory "$HOME/.dotfiles/bin" "$HOME/bin"
link_directory "$HOME/.dotfiles/prompts" "$HOME/.prompts"
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
link_file .editorconfig
link_file .gemrc
link_file .gitconfig
link_file .gitignore
link_file .inputrc
link_file .irbrc
link_file .jscs.json
link_file .jshintrc
link_file .pryrc
link_file .psqlrc
link_file .rubocop-disabled.yml
link_file .rubocop-enabled.yml
link_file .rubocop.yml
link_file .tmux.conf
link_file .vimrc
link_file .yamllint
link_file .zshrc
link_file console_config.rb

# Symlink Optional files
link_optional_file .zshrc.private

echo "Dotfiles have been symlinked to $HOME."

echo " -- Finished linking dotfiles --"
