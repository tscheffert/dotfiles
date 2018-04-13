#!/usr/env/bin bash

add_opensuse_zshcompletions_to_apt() {
  local release=$(lsb_release -a 2>1 | ruby -ne '$_.match(/^Release:\s+?(?<version>[0-9]{2}\.[0-9]{2})$/) { |m| print m["version"] }')

  if [[ "$release" != "16.04" ]]; then
    echo "Unsupported WSL/Ubuntu release: $release"
    exit 1
  fi

  sudo sh -c "echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-completions/xUbuntu_16.04/ /' > /etc/apt/sources.list.d/shells:zsh-users:zsh-completions.list"
  sudo apt-get update
}

ensure_latest_zsh() {
  echo ""
  echo " -- Updating apt-get package info from sources --"
  sudo apt-get update

  echo ""
  echo " -- Ensuring Zsh is installed and up to date --"
  if [[ ! "$(apt list zsh --installed)" =~ '[installed]' ]]; then
    echo "You don't have Zsh installed, installing..."
    sudo apt-get install zsh --assume-yes
  elif [[ "$(apt list --upgradeable zsh)" =~ 'zsh' ]]; then
    echo "Your installed Zsh is outdated, upgrading..."
    sudo apt-get upgrade zsh --assume-yes
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
  if [[ ! "$(apt list --installed zsh-syntax-highlighting)" =~ '[installed]' ]]; then
    echo "You don't have zsh-syntax-highlighting installed, installing..."
    sudo apt-get install zsh-syntax-highlighting --assume-yes
  elif [[ "$(apt list --upgradeable zsh-syntax-highlighting)" =~ 'zsh-syntax-highlighting' ]]; then
    echo "Your installed zsh-syntax-highlighting is outdated, upgrading..."
    sudo apt-get upgrade zsh-syntax-highlighting --assume-yes
  else
    echo "You already have the latest zsh-syntax-highlighting!"
  fi

  echo " -- Ensuring you have an updated zsh-completions --"
  if [[ ! "$(apt list --installed zsh-completions)" =~ '[installed]' ]]; then
    echo "You don't have zsh-completions installed, installing..."
    add_opensuse_zshcompletions_to_apt
    sudo apt-get install zsh-completions --assume-yes
  elif [[ "$(apt list --upgradeable zsh-completions)" =~ 'zsh-completions' ]]; then
    echo "Your installed zsh-completions is outdated, upgrading..."
    sudo apt-get upgrade zsh-completions --assume-yes
  else
    echo "You already have the latest zsh-completions!"
  fi
}

ensure_latest_zsh
