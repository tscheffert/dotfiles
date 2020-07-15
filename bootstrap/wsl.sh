#!/usr/bin/env bash

echo " --- Bootstrapping ---"
source "$PWD/bootstrap/wsl/links.sh"
source "$PWD/bootstrap/wsl/apps.sh"
source "$PWD/bootstrap/wsl/rbenv_plugins.sh"
source "$PWD/bootstrap/wsl/vim.sh"
echo ""
echo " --- Finished Bootstrapping ---"

exec $SHELL -l
