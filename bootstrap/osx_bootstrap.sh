# Based on the Kevin Suttle's https://github.com/kevinSuttle/dotfiles/blob/master/install.zsh
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
	ln -sf $HOME/.dotfiles/bin $HOME/bin
	ln -sf $HOME/.dotfiles/init $HOME/init
	ln -sf $HOME/.dotfiles/vimfiles $HOME/.vim
	ln -sf $HOME/.dotfiles/.git_template $HOME/.git_template

	# Symlink files
	ln -sf $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
	ln -sf $HOME/.dotfiles/.bash_prompt $HOME/.bash_prompt
	ln -sf $HOME/.dotfiles/.bashrc $HOME/.bashrc
	ln -sf $HOME/.dotfiles/.curlrc $HOME/.curlrc
	ln -sf $HOME/.dotfiles/.editorconfig $HOME/.editorconfig
	ln -sf $HOME/.dotfiles/.gitconfig $HOME/.gitconfig
	ln -sf $HOME/.dotfiles/.gitignore $HOME/.gitignore
	ln -sf $HOME/.dotfiles/.git-prompt.sh $HOME/.git-prompt.sh
	ln -sf $HOME/.dotfiles/.jscs.json $HOME/.jscs.json
	ln -sf $HOME/.dotfiles/.jshintrc $HOME/.jshintrc
	ln -sf $HOME/.dotfiles/.osx $HOME/.osx
	ln -sf $HOME/.dotfiles/.vimrc $HOME/.vimrc
	ln -sf $HOME/.dotfiles/.coffeelint.json $HOME/.coffeelint.json
	ln -sf $HOME/.dotfiles/.slate $HOME/.slate

	echo "Dotfiles have been symlinked to $HOME."
fi

# Setup vimfiles
if [[ -d $HOME/.vim/bundle/neobundle.vim ]]
	then
	echo "Found ~/.vim/bundle/neobundle.vim directory"
	echo "Running NeoBundle Install"
	vim +NeoBundleInstall +qall
	echo "Vim config complete."
fi

# Homebrew!
# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# TODO: Run brew doctor or whatever
# TODO: Run Brewfile and Caskfile with:
# # This unlocks the deprecated commands, we want 'bundle'
# brew tap homebrew/boneyard
# brew tap homebrew/versions
# brew bundle Brewfile
# brew bundle Caskfile
# brew untap homebrew/boneyard
# brew untap homebrew/versions

exec $SHELL -l


# --- Next Steps ---
# 1. There's iTerm2 preferences in the dotfiles
# 2. Download Slate and set it to always startup
# 3. brew install exuberant-ctags
# 4. ripper-tags from https://github.com/lzap/gem-ripper-tags
