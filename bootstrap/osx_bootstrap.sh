#! /usr/env/bin bash
#
# Based on the Kevin Suttle's https://github.com/kevinSuttle/dotfiles/blob/master/install.zsh

link_if_needed() {
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

test_exists() {
    type $1 >/dev/null 2>&1
}

# Don't try to clone the dotfile repo again if it already exists
if [[ -d $HOME/.dotfiles ]]
	then
    # Symlinks:
    # +-- ln(1) link, ln -- make links
    # ¦   +-- Create a symbolic link.
    # ¦   ¦                         +-- the path to the intended symlink
    # ¦   ¦                         ¦   can use . or ~ or other relative paths
    # ¦   ¦                   +--------------+
    # ln -s /path/to/original /path/to/symlink
    #       +---------------+
    #               +-- the path to the original file/folder
    #                   can use . or ~ or other relative paths
    #
    #   Options:
    #   -f If the target file already exists, then unlink it so that the link may occur.

	# Symlink directories
	link_if_needed $HOME/.dotfiles/bin $HOME/bin
	link_if_needed $HOME/.dotfiles/vimfiles $HOME/.vim
	link_if_needed $HOME/.dotfiles/.git_template $HOME/.git_template
	link_if_needed $HOME/.dotfiles/iTerm $HOME/iTerm
	link_if_needed $HOME/.dotfiles/prompts $HOME/.prompts
	link_if_needed $HOME/.dotfiles/zsh $HOME/.zsh

	# Symlink files
	ln -sf $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
	ln -sf $HOME/.dotfiles/.bashrc $HOME/.bashrc
	ln -sf $HOME/.dotfiles/.curlrc $HOME/.curlrc
	ln -sf $HOME/.dotfiles/.editorconfig $HOME/.editorconfig
	ln -sf $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
	ln -sf $HOME/.dotfiles/.gitignore $HOME/.gitignore
	ln -sf $HOME/.dotfiles/.jscs.json $HOME/.jscs.json
	ln -sf $HOME/.dotfiles/.jshintrc $HOME/.jshintrc
	ln -sf $HOME/.dotfiles/.osx $HOME/.osx
	ln -sf $HOME/.dotfiles/.vimrc $HOME/.vimrc
	ln -sf $HOME/.dotfiles/.coffeelint.json $HOME/.coffeelint.json
	ln -sf $HOME/.dotfiles/.slate $HOME/.slate
	ln -sf $HOME/.dotfiles/.ptignore $HOME/.ptignore
	ln -sf $HOME/.dotfiles/.pryrc $HOME/.pryrc
  ln -sf $HOME/.dotfiles/.gemrc $HOME/.gemrc
	ln -sf $HOME/.dotfiles/.rubocop.yml $HOME/.rubocop.yml
	ln -sf $HOME/.dotfiles/.rubocop-enabled.yml $HOME/.rubocop-enabled.yml
	ln -sf $HOME/.dotfiles/.rubocop-disabled.yml $HOME/.rubocop-disabled.yml
	ln -sf $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
	ln -sf $HOME/.dotfiles/.zshrc $HOME/.zshrc
	ln -sf $HOME/.dotfiles/.aprc $HOME/.aprc

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
