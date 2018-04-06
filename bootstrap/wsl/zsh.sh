#!/usr/env/bin bash

ensure_latest_zsh() {
  echo ""
  echo " -- Updating apt-get package info from sources --"
  sudo apt-get update

  echo ""
  echo " -- Ensuring Zsh is installed and up to date --"
  if [[ "$(apt list zsh --installed)" =~ '[installed]' ]]; then
    echo "You don't have Zsh installed, installing..."
    sudo apt-get install zsh
  elif [[ "$(apt list --upgradeable zsh)" =~ 'zsh' ]]; then
    echo "Your installed Zsh is outdated, upgrading..."
    sudo apt-get upgrade zsh
  else
    echo "You already have the latest Zsh!"
  fi

  echo ""
  echo " -- Ensuring brewed Zsh is in /etc/shells --"
  local zsh_path=$(command -v zsh)
  if grep "$zsh_path" /etc/shells; then
    echo "Zsh already present!"
  else
    echo "Adding brewed Zsh to /etc/shells"
    sudo echo "$zsh_path" >> /etc/shells
  fi

  echo ""
  echo " -- Ensuring Zsh is set as the preferred shell --"
  chsh -s "$zsh_path"

  echo ""
  echo " -- Ensuring you have an updated zsh-syntax-highlighting installed --"
  if [[ "$(apt list --installed zsh-syntax-highlighting)" =~ '[installed]' ]]; then
    echo "You don't have zsh-syntax-highlighting installed, installing..."
    sudo apt-get install zsh-syntax-highlighting
  elif [[ "$(apt list --upgradeable zsh-syntax-highlighting)" =~ 'zsh-syntax-highlighting' ]]; then
    echo "Your installed zsh-syntax-highlighting is outdated, upgrading..."
    sudo apt-get upgrade zsh-syntax-highlighting
  else
    echo "You already have the latest zsh-syntax-highlighting!"
  fi
}

ensure_latest_zsh
