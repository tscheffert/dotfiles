#!/usr/env/bin bash

ensure_latest_zsh() {
  local list_zsh=$(brew list zsh)
  local brew_outdated=$(brew outdated)

  echo ""
  echo " -- Ensuring Zsh is installed and up to date --"
  if [[ -z list_zsh ]]; then
    echo "You don't have Zsh installed, installing..."
    brew install zsh
  elif [[ "$brew_outdated" =~ 'zsh' ]]; then
    echo "Your installed Zsh is outdated, upgrading..."
    brew upgrade zsh
  else
    echo "You already have the latest Zsh!"
  fi

  echo ""
  echo " -- Ensuring brewed Zsh is in /etc/shells --"
  local brewed_zsh=$(command -v zsh)
  if grep "$brewed_zsh" /etc/shells; then
    echo "Zsh already present!"
  else
    echo "Adding brewed Zsh to /etc/shells"
    sudo echo "$brewed_zsh" >> /etc/shells
  fi


  echo ""
  echo " -- Ensuring Zsh is set as the preferred shell --"
  chsh -s "$brewed_zsh"
}

ensure_latest_zsh
