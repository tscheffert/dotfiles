#!/bin/bash

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
    # append_to_PATH 'C:\Users\tscheffert\AppData\Local\Android\android-sdk\platform-tools'

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


# --- Colors ---
# TODO: What do these colors do?
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS="di=1;0;34:ln=0;35:so=32:pi=0;33:ex=0;31:bd=37;46:cd=37;43:su=37;41:sg=37;46:tw=37;42:ow=37;43:or=37;45:mi=37;43:"

if echo hello | grep --color=auto l >/dev/null 2>&1; then
  export GREP_OPTIONS='--color=auto'
  export GREP_COLOR='0;32'
  export GREP_COLORS="sl=0;37:cx=1;32:mt=1;35:fn=0;32:ln=1;34:se=1;33"
fi


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

# Github API Key!
export HOMEBREW_GITHUB_API_TOKEN=b378ad9787685006e70642743a402d838e6fac64;

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
    if [ -f ~/.git-prompt.sh ]; then
        # Enable the __git_ps1
        source ~/.git-prompt.sh

        # Set status line
        export PS1='[\W]$(__git_ps1 "(%s)")$ '
    fi
fi


# --- Aliases ---

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
alias ls="ls -a"

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

# status!
alias gs='git status'

alias ga='git add'

# "Git add patched"
alias gap='git add -p'

# "Git add all"
alias gaa='git add .'

alias gcm='git commit -m'

alias gd='git diff'

alias gds='git diff --staged'

function git-show {
    # Show all of the files that were affected between master and
    #   HEAD (of my branch).

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
    git show --pretty="format:" --name-only --diff-filter=$1 origin/master..HEAD \
        | awk NF \
        | sort \
        | uniq \
        | xargs -n1 bash -c '[ -e $@ ] && echo $@' _
}

# -- Ruby Aliases --
# Run Rubocop gem
alias rbc='rubocop'

# Run Rubocop gem and autocorrect detected violations when available
alias rbca='rubocop --auto-correct'

# Start a rails console
alias rails-c='bundle exec rails c'

# Start a rails server
alias rails-s='bundle exec rails s'

# First part of running a style-crest rake task
function rake-sc {
    eval 'bundle exec rake style_crest:$1'
}

function git-show-exclude-ruby-files {
    # Takes the list of files from git-show AM and removes excluded files with grep.
    git-show AM \
        | grep -vE -e 'routes\.rb|schema\.rb|\.html\.erb|\.yml'
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
