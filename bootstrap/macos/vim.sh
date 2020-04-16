#!/usr/bin/env bash

echo ""
echo " -- Setting up vim config for macOS --"

# Set $INSTALL_PATH and download vim-plug if it doesn't exist there
INSTALL_PATH="$HOME/.vim/autoload/plug.vim"

if [[ ! -f $INSTALL_PATH ]]; then
  echo "Downloading vim-plug to $INSTALL_PATH"
  curl -fLo "$INSTALL_PATH" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "Found existing $INSTALL_PATH"
fi

echo "Running vim-plug Install"
vim +PlugUpgrade +PlugInstall +qall

echo " -- Finished vim config --"
