#!/usr/env/bin bash

test_exists() {
  type $1 >/dev/null 2>&1
}

echo ""
echo " -- Ensuring that rbenv is installed --"

if ! test_exists rbenv; then
  if [[ ! -d "$HOME/.rbenv" ]]; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv

    pushd ~/.rbenv && src/configure && make -C src
    popd
  else
    echo "~/.rbenv dir already exists but rbenv isn't in the path, check zsh/bash config to ensure \"~/.rbenv/bin\" is added to path"
  fi
else
  echo "rbenv already installed"
fi

if [[ -d "$HOME/.rbenv" ]]; then
  ln -sf $HOME/.dotfiles/rbenv/default-gems "$(~/.rbenv/bin/rbenv root)/default-gems"
  echo "set up rbenv default-gems"
fi

echo ""
echo " -- Ensuring that ruby-build is installed and updated --"

if ! test_exists ruby-build; then
  echo "Installing ruby-build"
  rbenv_plugins_dir="$(~/.rbenv/bin/rbenv root)/plugins"
  mkdir -p "$rbenv_plugins_dir"
  git clone https://github.com/rbenv/ruby-build.git "$rbenv_plugins_dir/ruby-build"

  echo "Updating apt-get package info from sources"
  sudo apt-get update

  echo "Installing dependecies for building ruby on ubuntu"
  # List of dependencies from: https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
  sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev
else
  echo "ruby-build already installed, updating"

  pushd "$(rbenv root)/plugins/ruby-build" && git pull
  popd
fi
