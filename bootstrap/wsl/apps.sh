#!/usr/env/bin bash

test_exists() {
  type $1 >/dev/null 2>&1
}

echo ""
echo " -- Updating apt-get package info from sources --"
sudo apt-get update

echo ""
echo " -- Installing apps --"

# Ensure tmux
# TODO: Upgrade?
if ! test_exists tmux; then
  echo "installing tmux:"
  sudo apt-get install tmux --assume-yes
  # brew install tmux
else
  echo "has tmux, check"
fi

# Set up tmux plugins
if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# Set up the default-gems
# TODO: Upgrade?
# Ensure fuzzy finder
# TODO: Upgrade?
if ! test_exists fzf; then
  echo 'installing fzf'
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
else
  echo "has fzf, check"
fi

echo " -- Finished installing apps --"
