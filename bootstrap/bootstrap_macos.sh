#!/usr/env/bin bash

# This is the script to run for bootstrapping macOS machines

echo " --- Bootstrapping ---"

repo_root="$(git rev-parse --show-toplevel)"
echo "Dotfiles installed at $repo_root"

source "$repo_root/bootstrap/macos/links.sh"
source "$repo_root/bootstrap/macos/apps.sh"
source "$repo_root/bootstrap/macos/vim.sh"
echo ""
echo " --- Finished Bootstrapping ---"

# exec $SHELL -l
