# From OneNote
Steps:
- Start installing xcode!
- Wait for XCode
- Install homebrew
- Run brew doctor and ensure it's working
- Git clone dotfiles
TODO: xcode-select --install first
- Maybe run xcode-select --install? Does it hang?

# Previous notes:
1. Setup iTerm2 to use it's preferences
3. Figure out how to install exuberant-ctags
4. Install ripper-tags from https://github.com/lzap/gem-ripper-tags

# Installing a fresh setup with Isela
- Install XCode - takes awhile to download
  - Once finished, open the gui so you can accept TOS and let it finish updating
  - Verify `xcode-select -p` points to `/Applications/Xcode.app/Contents/Developer`
    - Can set it if it doesn't with `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`
- Install homebrew
- Install iterm2 with brew cask
- brew install zsh zsh-completions zsh-syntax-highlighting
  - Add zsh to `/etc/shells`
    - Command: `command -v zsh | sudo tee -a /etc/shells`
  - Set zsh as main shell
    - Command: `chsh -s "$(command -v zsh)"`
- brew install python python3
- rm stuff from python
- brew link --overwrite python3 python
- brew doctor
  - brew missing stuff
  - sudo rm -rf /Library/Frameworks/Python.framework
- Install macvim
- pip install -r requirements.txt
- Run through Brewfile and install stuff

# Photoshop Plugins
Get ico plugin from: http://www.telegraphics.com.au/sw/product/ICOFormat
