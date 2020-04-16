#!/usr/env/bin bash

# Script must be sourced by the bootstrap/macos/apps.sh script to include dependencies

# Ensure rbenv
if ! test_exists rbenv; then
  brew install rbenv
  echo "Run bootstrap/rben-plugins.sh to install rbenv plugins"
else
  echo "has rbenv, check"
fi

# Ensure ruby-build
if ! test_exists ruby-build; then
  brew install ruby-build
fi

# Set up the default-gems
if test_exists rbenv; then
  ln -sf $HOME/.dotfiles/rbenv/default-gems /usr/local/var/rbenv/default-gems
  echo "set up rbenv default-gems"
fi

#
# Install my preferred rbenv plugins!

echo ""
echo " -- Installing rbenv plugins --"

if ! type rbenv >/dev/null 2>&1; then
  warn "rbenv required to install rbenv plugins..."
  exit 1
else
  echo "rbenv found"
fi

ensure_exists() {
  if [[ ! -d $1 ]]; then
    mkdir $1
  fi
}

install_plugin() {
  local github_path=$1
  # Expand parameter to everything before '/'
  local author=${github_path%/*}
  # Expand parameter to everything after '/'
  local plugin=${github_path#*/}

  if [[ ! -d $rbenv_plugins_path/$plugin ]]; then
    echo "Installing $plugin"
    git clone -q https://github.com/$github_path $rbenv_plugins_path/$plugin \
      || echo "Something's fucky with $plugin"
  fi
}

# Assign to $RBENV_ROOT if it exists, else $HOME/.rbenv
rbenv_path=${RBENV_ROOT:-$HOME/.rbenv}

rbenv_plugins_path=$rbenv_path/plugins

ensure_exists $rbenv_path
ensure_exists $rbenv_plugins_path

install_plugin sstephenson/rbenv-gem-rehash
install_plugin sstephenson/rbenv-default-gems
install_plugin nicknovitski/rbenv-gem-update
install_plugin rkh/rbenv-whatis
install_plugin toy/rbenv-update-rubies

echo " -- Finished installing rbenv plugins --"
