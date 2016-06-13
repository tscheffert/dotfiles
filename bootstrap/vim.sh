#!/usr/env/bin bash

echo ""
echo " -- Setting up vim config --"

# Setup vimfiles
if [[ ! -d $HOME/.vim/bundle/neobundle.vim ]]; then
  git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
fi

echo "Found ~/.vim/bundle/neobundle.vim directory"
echo "Running NeoBundle Install"
vim +NeoBundleInstall +qall

echo " -- Finished vim config --"
