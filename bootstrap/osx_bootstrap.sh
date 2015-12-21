#! /usr/env/bin bash

link_directory() {
  local from=$1
  local to=$2

  if [[ -d $from ]]; then
    if [[ -h $to ]]; then
      echo "Directory '${to}' already exists, skipping link"
    else
      echo "Linking directory ${from} to ${to}"
      ln -sf $from $to
    fi
  fi
}

link_file() {
  local file=$1

  ln -sf $HOME/.dotfiles/$file $HOME/$file
}

link_optional_file() {
  local file=$1

  if [[ -f $HOME/.dotfiles/$file ]]; then
    ln -sf $HOME/.dotfiles/$file $HOME/$file
  fi
}

test_exists() {
  type $1 >/dev/null 2>&1
}

# Don't try to clone the dotfile repo again if it already exists
if [[ -d $HOME/.dotfiles ]]; then
  # Symlinks:
  # +-- ln(1) link, ln -- make links
  # |   +-- Create a symbolic link.
  # |   |                         +-- the path to the intended symlink
  # |   |                         |   can use . or ~ or other relative paths
  # |   |                   +--------------+
  # ln -s /path/to/original /path/to/symlink
  #       +---------------+
  #               +-- the path to the original file/folder
  #                   can use . or ~ or other relative paths
  #
  #   Options:
  #   -f If the target file already exists, then unlink it so that the link may occur.

  # Symlink directories
  link_directory $HOME/.dotfiles/bin $HOME/bin
  link_directory $HOME/.dotfiles/vimfiles $HOME/.vim
  link_directory $HOME/.dotfiles/.git_template $HOME/.git_template
  link_directory $HOME/.dotfiles/iTerm $HOME/iTerm
  link_directory $HOME/.dotfiles/prompts $HOME/.prompts
  link_directory $HOME/.dotfiles/zsh $HOME/.zsh

  # Symlink files
  link_file .bash_profile
  link_file .bashrc
  link_file .curlrc
  link_file .editorconfig
  link_file .gitconfig
  link_file .gitignore
  link_file .jscs.json
  link_file .jshintrc
  link_file .osx
  link_file .vimrc
  link_file .coffeelint.json
  link_file .slate
  link_file .agignore
  link_file .pryrc
  link_file .gemrc
  link_file .rubocop.yml
  link_file .rubocop-enabled.yml
  link_file .rubocop-disabled.yml
  link_file .tmux.conf
  link_file .zshrc
  link_file .aprc
  link_file .inputrc
  link_file .irbrc
  link_file .psqlrc

  # Symlink Optional files
  link_optional_file .zshrc.local
  link_optional_file .zshrc.private

  echo "Dotfiles have been symlinked to $HOME."
fi

# Ensure Homebrew
if ! test_exists brew; then
  echo "You don't have brew installed!"

  echo "Go to http://brew.sh/ and install it before re-running."
  exit 1
else
  echo "has brew, check"
fi

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

# Ensure rbenv
if ! test_exists rbenv; then
  brew install rbenv
  echo "Run bootstrap/rben-plugins.sh to install rbenv plugins"
fi

# Set up the default-gems
if test_exists rbenv; then
  ln -sf $HOME/.dotfiles/rbenv/default-gems /usr/local/var/rbenv/default-gems
fi

# Ensure ruby-build
if ! test_exists ruby-build; then
  brew install ruby-build
fi

# Setup vimfiles
if [[ ! -d $HOME/.vim/bundle/neobundle.vim ]]; then
  git clone git@github.com:Shougo/neobundle.vim.git $HOME/.vim/bundle/neobundle.vim
fi

echo "Found ~/.vim/bundle/neobundle.vim directory"
echo "Running NeoBundle Install"
vim +NeoBundleInstall +qall
echo "Vim config complete."

exec $SHELL -l

# --- Next Steps ---
# 1. Setup iTerm2 to use it's preferences
# 2. Download Slate and set it to always startup
# 3. Figure out how to install exuberant-ctags
# 4. ripper-tags from https://github.com/lzap/gem-ripper-tags
# 5. brew install zsh zsh-completions
# 6. Add zsh to /etc/shells with 'command -v zsh | sudo tee -a /etc/shells'
# 7. Set zsh to default shell with 'chsh -s "$(command -v zsh)"'
