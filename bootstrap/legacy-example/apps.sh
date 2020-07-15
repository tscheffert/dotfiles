#!/usr/bin/env bash

test_exists() {
  type $1 >/dev/null 2>&1
}

echo ""
echo " -- Installing apps --"

# Ensure Homebrew
if ! test_exists brew; then
  echo "You don't have brew installed!"

  echo "Go to http://brew.sh/ and install it before re-running."
  exit 1
else
  echo "has brew, check"
fi

# Ensure ~/.iTermHist
if [[ ! -d ~/.iTermHist ]]; then
  echo "creating ~/.iTermHist"
  mkdir ~/.iTermHist
fi

# Ensure tmux
# TODO: Upgrade?
if ! test_exists tmux; then
  echo "installing tmux:"
  brew install tmux
else
  echo "has tmux, check"
fi

# Set up tmux plugins
if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# Ensure rbenv
# TODO: Upgrade?
if ! test_exists rbenv; then
  brew install rbenv
  echo "Run bootstrap/rben-plugins.sh to install rbenv plugins"
else
  echo "has rbenv, check"
fi

# Ensure ruby-build
# TODO: Upgrade?
if ! test_exists ruby-build; then
  brew install ruby-build
fi

# Set up the default-gems
# TODO: Upgrade?
if test_exists rbenv; then
  ln -sf $HOME/.dotfiles/rbenv/default-gems /usr/local/var/rbenv/default-gems
  echo "set up rbenv default-gems"
fi

# Ensure fuzzy finder
# TODO: Upgrade?
if ! test_exists fzf; then
  echo 'installing fzf'
  brew install fzf
else
  echo "has fzf, check"
fi

echo " -- Finished installing apps --"
