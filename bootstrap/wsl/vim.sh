#!/usr/bin/env bash

echo ""
echo " -- Setting up vim config --"

# --- Platform ---
# copied from .bash_profile
# use: if [[ $platform == 'windows']]; then
platform='unknown'
if [[ "$OSTYPE" =~ "msys" ]]; then
  platform='windows'
elif [[ "$OSTYPE" =~ "cygwin" ]]; then
  platform='windows'
elif [[ "$OSTYPE" =~ "win32" ]]; then
  platform='windows'
fi

# Set $INSTALL_PATH and download vim-plug if it doesn't exist there
if [[ $platform == 'windows' ]]; then
  INSTALL_PATH="$HOME/vimfiles/autoload/plug.vim"
else
  INSTALL_PATH="$HOME/.vim/autoload/plug.vim"
fi
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
