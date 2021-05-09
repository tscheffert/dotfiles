#!/usr/bin/env bash
# vim: ft=sh

# Install NPM packages that we commonly use. See npm-tools.md for more details
function install_npm_packages {
  npm install -g tldr
  npm install -g livedown
  npm install -g readability-cli
}

install_npm_packages "$@"
