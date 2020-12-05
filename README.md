# dotfiles

tscheffert's take on .dotfiles

## Installation ###

*Note, this is for me to remember as much as for others to follow!*

### To Start ####

```bash
cd ~

# Note: Must be in a ~/.dotfiles, required for some scripts (unfortunately)
git clone https://github.com/tscheffe/dotfiles.git .dotfiles
```

### For macOS (formerly OSX) ####

```bash
bash bootstrap/bootstrap_macos.sh
```

### For Vanilla Windows ####

```bash
bootstrap/bootstrap.bat
```

### Install Python dependencies

```bash
pip install -r requirements.txt
```

### Install Ruby dependencies

```bash
bundle install
```

## Included Utilities

### Ruby

#### TTY Markdown CLI

Homepage: <https://github.com/piotrmurach/tty-markdown-cli>

Provides `tty-markdown <MARKDOWN FILE>` which outputs a beautiful terminal representation of your markdown. Great for previewing markdown files.
