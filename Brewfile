# Install command-line tools using Homebrew
# Usage: `brew bundle Brewfile`

# Make sure we’re using the latest Homebrew
update

# Upgrade any already-installed formulae
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
install bash
install bash-completion

# Install wget with IRI support
install wget --enable-iri

# Install more recent versions of some OS X tools
install vim --override-system-vi
install homebrew/dupes/grep
install homebrew/dupes/screen
install homebrew/php/php55 --with-gmp

# Install other useful binaries
install ack
#install bfg
#install exiv2
#install foremost
install git
#install hashpump
install imagemagick --with-webp
install nmap # Network Map Hacker Tool - Homepage: http://nmap.org
install node # This installs `npm` too using the recommended installation method
install p7zip # 7zip Executable on Linux/Osx
install pigz # Parallelized Implementation of gzip - Homepage: http://www.zlib.net/pigz/
install pv # Pipe View Utility - Homepage: http://www.ivarch.com/programs/pv.shtml
install rename # Rename Utility - Homepage: http://plasmasturm.org/code/rename/
install tree # Directory Listing - Homepage: http://mama.indstate.edu/users/ice/tree/
install webkit2png # Website Screenshotter - Homepage: http://www.paulhammond.org/webkit2png/
install xpdf # PDF Utilities - Homepage: http://www.foolabs.com/xpdf/
install zopfli # Improved (slow-ass) Compression - Homepage: https://code.google.com/p/zopfli/

install homebrew/versions/lua52

# Remove outdated versions from the cellar
cleanup
