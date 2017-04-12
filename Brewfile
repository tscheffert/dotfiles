# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Make sure we're using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Note: Overwriting system utils by adding the bin to PATH in my .zshrc
install coreutils

# Install GNU `tar`
# Note: Overwriting system tar by adding the bin to PATH in my .zshrc
install gnu-tar

# Install GNU `find`, `locate`, `updatedb`, and `xargs`
# Note: Overwriting system utils by adding the bin to PATH in my .zshrc
install findutils

# Install GNU `sed`, overwriting the built-in `sed`
# Note: It doesn't look like gnu-sed allows me to do the path stuff
install gnu-sed --with-default-names

# Install some other useful utilities like `sponge`
install moreutils

# Install Bash 4
# Note: Don't forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
# It's defaulted to keg-only, mush be added to /etc/shells if I want to use
# this version as my login shell
install bash
install bash-completion

# Watch executes a program periodically showing output fullscreen
install watch

# Install macvim with applicable options
# Note: No --with-python3 because the brewed install can't do both 2 and 3, so
# let's stick with 2
install macvim --override-system-vim --with-lua --with-luajit
# Then do `brew linkapps macvim`

# install homebrew/dupes/grep

# Install other useful binaries
install ack
install the_silver_searcher # I use this instead of grep or ack, pretty nice
install git
install imagemagick --with-webp
install node # This installs `npm` too using the recommended installation method
install p7zip # 7zip Executable on Linux/Osx
install dos2unix # Great utility to change line endings for files

# Programming utilities
install python
install python3
install lua
# rbenv makes managing versions easier, ruby-build assists by adding "rbenv install"
# Also need https://github.com/sstephenson/rbenv-gem-rehash
install rbenv ruby-build

# Awesome linting tool for bash scripts
install shellcheck

# Fancy utility for displaying organization of a directory, and it's fast
install tree

# Things I haven't installed but could
# install nmap # Network Map Hacker Tool - Homepage: http://nmap.org
# install pigz # Parallelized Implementation of gzip - Homepage: http://www.zlib.net/pigz/
# install pv # Pipe View Utility - Homepage: http://www.ivarch.com/programs/pv.shtml
# install rename # Rename Utility - Homepage: http://plasmasturm.org/code/rename/
# install webkit2png # Website Screenshotter - Homepage: http://www.paulhammond.org/webkit2png/
# install zopfli # Improved (slow-ass) Compression - Homepage: https://code.google.com/p/zopfli/

# For api-blueprint vim plugin syntax checking
# brew install --HEAD \
#   https://raw.github.com/apiaryio/drafter/master/tools/homebrew/drafter.rb

# Remove outdated versions from the cellar
cleanup
