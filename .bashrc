#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source .bash_profile always
[ -n "$PS1" ] && source ~/.bash_profile;

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
