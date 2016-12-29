#!/usr/env/bin bash

echo " --- Bootstrapping ---"
source "$PWD/bootstrap/links.sh"
source "$PWD/bootstrap/apps.sh"
source "$PWD/bootstrap/rbenv_plugins.sh"
source "$PWD/bootstrap/vim.sh"
echo ""
echo " --- Finished Bootstrapping ---"

exec $SHELL -l
