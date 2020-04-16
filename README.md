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
