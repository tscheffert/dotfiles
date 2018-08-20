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

 # Ensure rust
if ! test_exists cargo; then
  echo " -- Installing Rust --"
  curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
else
  echo "has rust, check"
fi

# Ensure python
if ! test_exists python; then
  # TODO: Look into https://github.com/pyenv/pyenv
  sudo apt-get install python --assume-yes
fi

# Ensure pip, which doesn't come with python for some reason?!?
if ! test_exists pip; then
  sudo apt-get install python-pip python-setuptools --assume-yes

  # Pip versions are busted
  # https://github.com/pypa/pip/issues/5240#issuecomment-381673100
  pip install --upgrade pip==9.0.3
fi

# Ensure python dependencies are installed
if test_exists pip; then
  pip install -r requirements.txt
  pip2 install -r requirements2.txt
  # pip3 install -r requirements3.txt
fi


echo " -- Finished installing apps --"

