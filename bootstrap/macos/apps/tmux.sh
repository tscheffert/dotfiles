#!/usr/env/bin bash

# Script must be sourced by the bootstrap/macos/apps.sh script to include dependencies

# Ensure tmux
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

