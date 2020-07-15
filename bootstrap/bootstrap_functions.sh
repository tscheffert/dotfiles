#!/usr/bin/env bash

# TODO: '~/.dotfiles' is hard coded as the folder every, use the "git root folder" instead

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

test_exists() {
  type $1 >/dev/null 2>&1
}
