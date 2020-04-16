#!/usr/env/bin bash


repo_root="$(git rev-parse --show-toplevel)"
source "$repo_root/bootstrap/bootstrap_functions.sh"

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

# source "$repo_root/bootstrap/macos/apps/tmux.sh"
# source "$repo_root/bootstrap/macos/apps/rbenv.sh"

# Ensure ~/.iTermHist
if [[ ! -d ~/.iTermHist ]]; then
  echo "creating ~/.iTermHist"
  mkdir ~/.iTermHist
fi

# Ensure fuzzy finder
if ! test_exists fzf; then
  echo 'installing fzf'
  brew install fzf
else
  echo "has fzf, check"
fi

# Install the packages in ~/Brewfile (can take awhile)
brew bundle install

echo " -- Finished installing apps --"
