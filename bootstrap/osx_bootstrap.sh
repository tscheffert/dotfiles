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
	ln -sf $HOME/.dotfiles/iTerm $HOME/iTerm
	ln -sf $HOME/.dotfiles/prompts $HOME/.prompts

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

	ln -sf $HOME/.dotfiles/.rubocop.yml $HOME/.rubocop.yml
	ln -sf $HOME/.dotfiles/.rubocop-enabled.yml $HOME/.rubocop-enabled.yml
	ln -sf $HOME/.dotfiles/.rubocop-disabled.yml $HOME/.rubocop-disabled.yml

	echo "Dotfiles have been symlinked to $HOME."
fi

# Setup vimfiles
if [[ ! -d $HOME/.vim/bundle/neobundle.vim ]]
    then
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
