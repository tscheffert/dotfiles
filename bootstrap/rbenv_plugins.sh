#!/usr/bin/env bash
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
