#!/usr/env/bin bash
set -o nounset # Exit instead of using uninitialized variable
set -o errexit # Exit script if any statement returns a non-true value, don't snowball errors

# Ensure we install to global /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew bundle Caskfile
