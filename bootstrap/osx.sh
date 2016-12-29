#!/usr/env/bin bash

echo " --- Bootstrapping ---"
source "$PWD/bootstrap/links.sh"
source "$PWD/bootstrap/apps.sh"
source "$PWD/bootstrap/rbenv_plugins.sh"
source "$PWD/bootstrap/vim.sh"
echo ""
echo " --- Finished Bootstrapping ---"

exec $SHELL -l

# --- Next Steps ---
# 1. Setup iTerm2 to use it's preferences
# 3. Figure out how to install exuberant-ctags
# 4. ripper-tags from https://github.com/lzap/gem-ripper-tags
# 5. brew install zsh zsh-completions
# 6. Add zsh to /etc/shells with 'command -v zsh | sudo tee -a /etc/shells'
# 7. Set zsh to default shell with 'chsh -s "$(command -v zsh)"'
