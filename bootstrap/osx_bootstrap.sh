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
    #   -f If the target file alre4ady exists, then unlink it so that the link may occur.

	# Symlink directories
	ln -sf $HOME/.dotfiles/bin $HOME/bin
	ln -sf $HOME/.dotfiles/init $HOME/init
	ln -sf $HOME/.dotfiles/vimfiles $HOME/.vim

	# Symlink files
	ln -sf $HOME/.dotfiles/.bash_profile $HOME/.bash_profile
	ln -sf $HOME/.dotfiles/.bash_prompt $HOME/.bash_prompt
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
	echo "Dotfiles have been symlinked to $HOME."
else
	echo "Cloning your dotfiles from GitHub..."
	git clone https://github.com/tscheffe/dotfiles.git $HOME/.dotfiles
	#echo "Cloning Pure Zshell config from GitHub..."
	#git clone https://github.com/sindresorhus/pure $HOME/Code/pure-zsh/
	#echo "Linking Pure Zshell prompt to Zsh functions..."
	#ln -s "$HOME/Code/pure-zsh/pure.zsh" /usr/local/share/zsh/site-functions/prompt_pure_setup
	echo "Dotfiles install complete."
fi

# Setup vimfiles
if [[ -d $HOME/.vim/bundle ]]
	then
	echo "You've already gotten your vim plugins, updating."
	git submodule foreach git pull origin master
	echo "Update complete"
else
    echo "update and init on submodules"
	git submodule update --init
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

# This is really cool but I don't use vundle at the moment
# # Don't try to clone the vundle repo again if it already exists
# if [[ -d $HOME/.vim ]]
	# then
	# echo "You've already set up your vim config."
# else
	# mkdir -p $HOME/.vim/bundle/ && cd $_
	# git init
	# git clone https://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
	# ln -sf $DOTFILES/vimrc $HOME/.vimrc
	# ln -sf $DOTFILES/vimrc.bundles $HOME/.vimrc.bundles
	# ln -sf $DOTFILES/gvimrc $HOME/.gvimrc

	# vim +BundleInstall +qall
	# echo "Vim config complete."
# fi

