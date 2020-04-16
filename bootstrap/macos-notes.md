# macos Boostrapping Notes

## Steps

- Install any system updates from Apple -> System Preferences -> Software Update
- Install homebrew from brew.sh
  - Double check it worked with `brew doctor`
  - Ensure homebrew cask is tapped with `brew cask doctor`
- Install macvim: `brew install macvim`
- Clone dotfiles:
  - `cd ~; git clone https://github.com/tscheffert/dotfiles.git .dotfiles`
- Run `bash bootstrap/bootstrap_macos.sh` to get most things set up

## TODO

- Figure out if we want TMUX stuff, in the `bootstrap/macos/apps.sh` file
- Determine how we'll sync up ruby between the shell, the os, and macvim. Optionally with `rbenv`
  - Currently the system default is 2.6.3, and macvim has it's own "keg only" 2.7 version
