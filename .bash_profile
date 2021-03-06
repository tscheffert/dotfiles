#!/bin/bash

test_exists() {
  type $1 >/dev/null 2>&1
}

# I should just _not_ do this, we can start Zsh directly if necessary
# if test_exists zsh; then
#   exec zsh
#   # I don't think we'll ever get here given the `exec zsh`, but if we do
#   exit 0
# else
#   echo "Couldn't find zsh, loading bash profile"
# fi


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
# TODO: Read this https://superuser.com/a/1243332
# TODO: Seek to understand this [[ ":$PATH:" != *":$1:"* ]]
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
  prepend_to_PATH 'C:\Program Files\Vim\vim80'

fi

if [[ $platform == 'osx' ]]; then
  # For homebrewed 'coreutils'
  prepend_to_PATH '/usr/local/opt/coreutils/libexec/gnubin'

  # For man files for 'coreutils'
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# Add `~/bin` to the `$PATH`
prepend_to_PATH "$HOME/bin"

# -- Append --

# Function to safely, idempotently, append to path
append_to_PATH () {
  for d; do
    # Skip directories that don't exist, preventing warnings during the "canonicalize" step
    if [[ ! -d "$d" ]]; then
      continue;
    fi
    d=$(cd -- "$d" && { pwd -P || pwd; }) 2>/dev/null # canonicalize symbolic links (? what?)
    if [[ -z "$d" ]]; then continue; fi # skip nonexistent directory
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
  # append_to_PATH 'C:\Users\tscheffert\AppData\Local\Android\android-sdk\platform-tools'

  # Python Scripts including pip
  append_to_PATH 'C:\tools\python\Scripts'

  # Xmllint from libxml2
  append_to_PATH 'C:\tools\xmllint'

  # pdfimages from XPDF
  append_to_PATH 'C:\tools\xpdf'

  append_to_PATH 'C:\Program Files (x86)\PWGen'

  append_to_PATH 'C:\dev\github\elasticdog\transcrypt'
fi


# --- Options ---
# colors!
# declare -x CLICOLOR=1

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
# shopt -s histappend;

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
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh;

if [[ $platform == 'osx' ]]; then
  # Enable tab completion for `g` by marking it as an alias for `git`
  if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
  fi;

  # Add brew installed bash completion
  [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
fi


# --- Colors ---
# TODO: What do these colors do?
# More examples https://github.com/Bash-it/bash-it/blob/master/lib/appearance.bash
# export CLICOLOR=1
# export LSCOLORS=exfxcxdxbxegedabagacad
# export LS_COLORS="di=1;0;34:ln=0;35:so=32:pi=0;33:ex=0;31:bd=37;46:cd=37;43:su=37;41:sg=37;46:tw=37;42:ow=37;43:or=37;45:mi=37;43:"

# if echo hello | grep --color=auto l >/dev/null 2>&1; then
#   export GREP_OPTIONS='--color=auto'
#   export GREP_COLOR='0;32'
#   export GREP_COLORS="sl=0;37:cx=1;32:mt=1;35:fn=0;32:ln=1;34:se=1;33"
# fi


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

# Load Readline configuration please!
export INPUTRC=~/.inputrc


# -- History --
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#Bash-Variables
# TODO: Investigate these
#   histappend
#   histreedit
#   'cmdhist' or 'lithist' for newline stuff
#   histchars
#   HISTFILE (default ~/.bash_history)
# https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#The-Shopt-Builtin
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#Bash-Variables

# larger bash history (allow 32^3 entries; default is 500)
export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;

# changes how commands are saved on the history list
# ignorespace - lines which begin with a space character are not saved in the history list
# ignoredups - lines matching the previous history entry to not be saved
export HISTCONTROL=ignoredups

# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

# Save timestamp in the history file, in RFC-3339 format (with 3 nanoseconds)
# TODO: This gets truncated when running 'history'
export HISTTIMEFORMAT="[%F %T:%3N%z] "

# Append to PROMPT_COMMAND idempotently
#   PROMPT_COMMAND contains a regular bash command that is executed just before the command prompt is displayed
#   TODO: Determine how we insert ';' as needed
function append_to_PROMPT_COMMAND {
  local new_command="$1"

  # Only do the appending if the new_command is not already in the PROMPT_COMMAND
  if [[ ! "$PROMPT_COMMAND" =~ "$new_command" ]]; then
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}$new_command"
  fi
}

# Allow "sharing" of history between instances by appending then reading history in the PROMPT_COMMAND
#   history -a: Append new history lines to the history file, used instead of
#     'shopt -s histappend' as this appends every line individually rather then when the shell exits
#   history -c: Clear the existing history list
#   history -r: Read the history file, picking up changes from outside this session
append_to_PROMPT_COMMAND "history -a; history -c; history -r"

# # With <3 from http://thirtysixthspan.com/posts/grep-history-for
# # ghf - [G]rep [H]istory [F]or top ten commands and execute one
# # usage:
# #  Most frequent command in recent history
# #   ghf
# #  Most frequent instances of {command} in all history
# #   ghf {command}
# #  Execute {command-number} after a call to ghf
# #   !! {command-number}
# function latest-history { history | tail -n 50 ; }
# function grepped-history { history | grep "$1" ; }
# function chop-first-column { awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' ; }
# function add-line-numbers { awk '{print NR " " $0}' ; }
# function top-ten { sort | uniq -c | sort -r | head -n 10 ; }
# function unique-history { chop-first-column | top-ten | chop-first-column | add-line-numbers ; }
# function ghf {
#   if [ $# -eq 0 ]; then latest-history | unique-history; fi
#   if [ $# -eq 1 ]; then grepped-history "$1" | unique-history; fi
#   if [ $# -eq 2 ]; then
#     `grepped-history "$1" | unique-history | grep ^$2 | chop-first-column`;
#   fi
# }


# --- Ruby Stuff ---
if [[ $platform == 'osx' ]]; then
  # Use Homebrew's directories rather than ~/.rbenv
  export RBENV_ROOT=/usr/local/var/rbenv

  # Enable shims and autocompletion
  if which rbenv > /dev/null ; then eval "$(rbenv init -)"; fi
fi


# --- Postgres ---
if [[ $platform == 'osx' ]]; then
  # Set the required env variable for postgres
  export PGDATA='/usr/local/var/postgres'
  export PGGHOST=localhost
fi


# --- Git Prompt, only on OSX ---
#   Mingw, which I use, already has a nice prompt and it's colorful!
if [[ $platform == 'osx' ]]; then

  prompt=~/.prompts/.git-prompt.sh

  if [ -f "${prompt}" ]; then
    # Enable the __git_ps1
    source $prompt

    # Set status line
    export PS1='[\W]$(__git_ps1 "(%s)")$ '
  fi
fi


# --- Aliases ---

alias cd-d='cd ~/.dotfiles'

# ls alias for color-mode
alias lh='ls -lhaG'

# simple ip
# TODO: Right now this fails, saying "cut: bad delimiter"
# alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\ -f2'

# more details
# TODO: This works, but not sure what it means...
# alias ip1="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# external ip
# TODO: Fix this, getting external IP would be awesome. Right now it just hangs
# alias ip2="curl -s http://www.showmyip.com/simple/ | awk '{print $1}'"

# See hidden files with ls
alias ls="ls -a --color=always"

# grep with color
# for whatever reason this doesn't work with my grep on windows
#alias grep='grep --color=auto'

# refresh shell
alias reload='source ~/.bash_profile'

# -- Postgres Aliases --

alias pg-start='pg_ctl -l $PGDATA/server.log start'
alias pg-stop='pg_ctl stop -m fast'
alias pg-status='pg_ctl status'
alias pg-restart='pg_ctl reload'

# -- Git Aliases --

# Standard!
alias g='git'

# status!
alias gs='git status'

alias ga='git add'

alias gb='git branch'

alias gbd='git branch -d'

# "Git add patched"
alias gap='git add -p'

# "Git add all"
alias gaa='git add .'

alias gc='git commit'

alias gcm='git commit -m'

# --amend changes the latest commit, and --no-edit tells it we don't want to change the messge
alias gca='git commit --amend --no-edit'

alias gd='git diff'

alias gds='git diff --staged'

alias gr='git rebase'

alias grc='git rebase --continue'

alias gp='git pull'

alias gpu='git push'

alias gco='git checkout'

alias gcom='git checkout master'

# Follow it up with a hyphen delimited branch name like: 'gcob my-branch-name'
alias gcob='git checkout -b'

function git-trimmed-origin-head {
  git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
}

# "git checkout origin head"
function gcooh {
  git checkout $(git-trimmed-origin-head)
}

function git-show {
  # Show all of the files that were modified between the origin/head branch
  #   (via git-trimmed-origin-head) and HEAD.

  # Options:
  # --pretty="format:" - The "format:<string>" pretty-format option is like
  #   'printf' in that you can use '%' prefixed placeholders.  An empty string
  #   simply prints without any frills.
  # --name-only - Shows only their names.  --name-status would show operation in
  #   addition to the name.  --diff-filter means we don't really need that.
  # --diff-filter - Added (A), Copied (C), Deleted (D), Modified (M), Renamed (R),
  #   have their type (i.e. regular file, symlink, submodule, …) changed (T),
  #   are Unmerged (U), are Unknown (X), or have had their pairing Broken (B).
  #   Pass in the options you want to see as variables to git-show.  An empty
  #   $1 will default to showing all.

  # | awk NF - Run it through awk which skips lines with no fields thanks to
  #   'NF'.  Discussed here: http://www.thelinuxrain.com/articles/how-to-kill-blank-lines-elegantly
  # | sort - Sorts!  Input has to be sorted for uniq to work
  # | uniq - Ensures that there are no repeats.
  # | "xargs -n1 bash -c '<snippet>' _"
  #     -xargs n1 - Run utility once for each line.
  #     bash -c '<snippet>' _ - Use bash as utility.
  #     <snippet> - Test if the file exists and echo if it does.
  git show --pretty="format:" --name-only --diff-filter=$1 $(git-trimmed-origin-head)..HEAD \
    | awk NF \
    | sort \
    | uniq \
    | xargs -n1 bash -c '[ -e $@ ] && echo $@' _
}

function pipe-modified-to {
  local xargs_command="$1"

  git diff origin/$(git-trimmed-origin-head)..HEAD --name-only \
    | ag -o 'w*?\/\w*?\/' \
    | sort \
    | uniq \
    | xargs "$xargs_command"
}

# -- PowerShell Aliases/Functions --
function ps-lint {
  # Invoke the PSScriptAnalyzer, which is installed via PowerShell Gallery
  powershell -Command "Invoke-ScriptAnalyzer -Path $1"
}

function ps-beautify {
  # Invoke the beautify function defined in my PowerShell profile
  powershell -Command "Edit-BeautifyFile $1"
}

# -- Ruby Aliases --
# Run Rubocop gem
alias rbc='rubocop'

# Run Rubocop gem and autocorrect detected violations when available
alias rbca='rubocop --auto-correct'

# Bundle exec
alias be='bundle exec'

# Bundle exec rake shortcut
alias ber='bundle exec rake'

# Bundle exec rspec
alias be-rspec='bundle exec rspec'

function git-show-exclude-ruby-files {
  # Takes the list of files from git-show AM and removes excluded files with grep.
  git-show AM \
    | grep \.rb$ \
    | grep -vE -e 'routes\.rb|schema\.rb|\.html\.erb|\.yml|Gemfile|Gemfile\.lock|\.json'
}

function rbc-m {
  # Runs rubocop with all of the files
  git-show-exclude-ruby-files \
    | xargs rubocop
}

function rbca-m {
  # Runs rubocop with autocorrect, (-n1) once for each file,
  #   and (-p) while asking permission.
  git-show-exclude-ruby-files \
    | xargs -n1 -p rubocop --auto-correct
}

# -- Other Aliases
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias -- -='cd -'        # Go back

# Colors for TLDR!
alias tldr='tldr --theme base16'

# Doesn't like it when I run the exe directly, run the batch initialization script instead
alias gvim='gvim.bat'

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

# Count of files in folder, ignoring dotfiles.
# Source: http://unix.stackexchange.com/questions/1125/how-can-i-get-a-count-of-files-in-a-directory-using-the-command-line
function filecount {
  local i=0;
  for f in *; do
    let i++;
  done;
  echo "$i";
}

# Check that the specified directory exists – and is in the PATH.
is_dir_in_path()
{
  if  [ -z "${1:-}" ]; then
    printf "The path to a directory must be provided as an argument.\n" >&2
    return 1
  fi

  # Check that the specified path is a directory that exists.
  if ! [ -d "$1" ]; then
    printf "Error: ‘%s’ is not a directory.\n" "$1" >&2
    return 1
  fi

  # Use absolute path for the directory if a relative path was specified.
  if command -v readlink >/dev/null ; then
    dir="$(readlink -f "$1")"
  elif command -v realpath >/dev/null ; then
    dir="$(realpath "$1")"
  else
    case "$1" in
      /*)
        # The path of the provided directory is already absolute.
        dir="$1"
        ;;
      *)
        # Prepend the path of the current directory.
        dir="$PWD/$1"
        ;;
    esac
    printf "Warning: neither ‘readlink’ nor ‘realpath’ are available.\n"
    printf "Ensure that the specified directory does not contain ‘..’ in its path.\n"
  fi

  # Check that dir is in the user’s PATH.
  case ":$PATH:" in
    *:"$dir":*)
      printf "‘%s’ is in the PATH.\n" "$dir"
      return 0
      ;;
    *)
      printf "‘%s’ is not in the PATH.\n" "$dir"
      return 1
      ;;
  esac
}

# TODO:
# Do I want any completions? https://github.com/Bash-it/bash-it/tree/master/completion/available
