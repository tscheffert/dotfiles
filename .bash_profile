#!/bin/bash
# TODO: See if I can platform agnosticize this

# --- Platform ---
# use: if [[ $platform == 'windows']]; then
platform='unknown'
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    platform='osx'
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    platform='windows'
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    platform='windows'
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    platform='windows'
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Linux
    platform='linux'
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # Linux
    platform='linux'
# else
    # Unknown.
fi

# --- Path ---

# Function to safely, idempotently, append to path
prepend_to_PATH () {
    for d; do
        d=$(cd -- "$d" && { pwd -P || pwd; }) 2>/dev/null # canonicalize symbolic links (? what?)
        if [ -z "$d" ]; then continue; fi # skip nonexistent directory
        case ":$PATH:" in
            *":$d:"*) :;;
            *) PATH=$d:$PATH;;
        esac
    done
}

# -- Prepend --

if [[ $platform == 'windows' ]]; then
    # - Windows -

    # Clearly we want vim...
    prepend_to_PATH 'C:\Program Files\Vim\vim74'

fi

# Add `~/bin` to the `$PATH`
prepend_to_PATH "$HOME/bin"

# -- Append --

# Function to safely, idempotently, append to path
append_to_PATH () {
    for d; do
        d=$(cd -- "$d" && { pwd -P || pwd; }) 2>/dev/null # canonicalize symbolic links (? what?)
        if [ -z "$d" ]; then continue; fi # skip nonexistent directory
        case ":$PATH:" in
            *":$d:"*) :;;
            *) PATH=$PATH:$d;;
        esac
    done
}

if [[ $platform == 'windows' ]]; then
    # - Windows -

    # We want IIS Express!
    append_to_PATH 'C:\Program Files (x86)\IIS Express\'

    # Adb for android debugging
    append_to_PATH 'C:\Users\tscheffert\AppData\Local\Android\android-sdk\platform-tools'

    # Python Scripts including pip
    append_to_PATH 'C:\tools\python\Scripts'

    # Xmllint from libxml2
    append_to_PATH 'C:\tools\xmllint'
fi


# --- Options ---
# colors!
declare -x CLICOLOR=1

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Bash checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS
shopt -s checkwinsize

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;


# --- Completion ---
# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
	source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;


# --- Exports ---
if [[ $platform == 'osx' ]]; then
    # Make MacVim the default visual editor.
    # '-f' tells it not to fork a new process. Works better with shell.
    export VISUAL='mvim -f'
fi

# Make vim the default editor
export EDITOR="vim";

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# -- History --
# larger bash history (allow 32^3 entries; default is 500)
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;

# changes how commands are saved on the history list
# ignorespace - lines which begin with a space character are not saved in the history list
# ignoredups - lines matching the previous history entry to not be saved
export HISTCONTROL=ignoredups:ignorespace;

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

# Contains a regular bash command that is executed just before the command prompt is displayed
# make sure the history is updated at every command
# history -a - used instead of "shopt -s histappend" as this appends every line individually rather then when the shell exits
# history -n - append the history lines not already read from the history file to the current history list.
export PROMPT_COMMAND="history -a; history -n;"


# --- Aliases ---

# ls alias for color-mode
alias lh='ls -lhaG'

# simple ip
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\ -f2'

# more details
alias ip1="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# external ip
alias ip2="curl -s http://www.showmyip.com/simple/ | awk '{print $1}'"

# grep with color
# for whatever reason this doesn't work with my grep on windows
#alias grep='grep --color=auto'

# refresh shell
alias reload='source ~/.bash_profile'


# --- Functions ---
# what the hell?
function f {
    find . -type f | grep -v .svn | grep -v .git | grep -i $1
}

# what the hell?
function gr {
    find . -type f | grep -v .svn | grep -v .git | xargs grep -i $1 | grep -v Binary
}

if [[ $platform == 'osx' ]]; then
    # - Mac OSX -

    # open macvim
    function gvim {
        if [ -e $1 ];
            then open -a MacVim $@;
            else touch $@ && open -a MacVim $@;
        fi
    }
fi
