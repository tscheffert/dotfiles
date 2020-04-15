
# vi: ft=zsh

# --- Platform ---
# use: if [[ $platform == 'windows']]; then
platform='unknown'
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Mac OSX
  platform='osx'
elif [[ "$OSTYPE" == "msys" ]]; then
  # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
  platform='windows'
elif [[ "$OSTYPE" == "cygwin" ]]; then
  # POSIX compatibility layer and Linux environment emulation for Windows
  platform='windows'
elif [[ "$OSTYPE" == "win32" ]]; then
  # I'm not sure this can happen.
  platform='windows'
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  if [[ "$(uname -a)" =~ 'Microsoft' ]]; then
    platform='wsl'
  else
    # Linux
    platform='linux'
  fi
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  # Linux
  platform='linux'
# else
  # Unknown.
fi

# -- Sources --
. ~/.zsh/config
. ~/.zsh/exports
. ~/.zsh/aliases
. ~/.zsh/line-editor
. ~/.zsh/completion
. ~/.zsh/prompt

if [[ $platform == 'osx' ]]; then
  . ~/.zsh/osx
elif [[ $platform == 'windows' ]]; then
  . ~/.zsh/windows
elif [[ $platform == 'wsl' ]]; then
  # . ~/.zsh/wsl-ubuntu
  . ~/.zsh/wsl-centos
fi

# Use .zshrc.local for settings specific to one system
[[ -f ~/.zshrc.local ]] && . ~/.zshrc.local

# Use .zshrc.private for private variables like keys
#   Includes:
#     HOMEBREW_GITHUB_API_TOKEN
[[ -f ~/.zshrc.private ]] && . ~/.zshrc.private

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Set up zsh syntax highlighting, only on osx for now
if [[ "$platform" == 'osx' ]]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$platform" == 'linux' || "$platform" == 'wsl' ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# --- Paths ---

# Don't allow duplicates in the path. Keep the left-most item
typeset -U path

# Don't allow duplicates in the manpath either
typeset -U manpath
