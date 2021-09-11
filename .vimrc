" -----
" Startup
" -----


" TODO: Currently getting this error when running without plugins
" Error detected while processing /Users/tscheffert/.vimrc:
" line 1088:
" E185: Cannot find color scheme 'inkpot'
" Press ENTER or type command to continue

" Clear all autocommands
autocmd!

" Detect OS
let g:uname = substitute(system('uname -a'), '\n', '', '')

if has("mac")
  let g:os = 'mac'
elseif has("win32")
  let g:os = 'windows'
elseif g:uname =~ "Linux" && g:uname =~ "Microsoft"
  let g:os = 'wsl'
elseif g:uname =~ "Linux"
  let g:os = 'linux'
elseif g:uname =~ "MINGW64"
  let g:os = 'windows'
else
  " echo "Couldn't detect OS from uname: " . g:uname . ", shits gonna break"
endif

" Session Detection fun
function! InWindowsSession()
  " TODO: Do we need "has('win32')" at all?
  return g:os == 'windows'
endfunction

function! InMacbookSession()
  return g:os == 'mac'
endfunction

function! InConEmuSession()
  return InWindowsSession() && !has('gui_running') && !empty($ConEmuBuild)
endfunction

function! InTmuxSession()
  return $TMUX != ''
endfunction

function! InItermSession()
  " This would work with other programs, Apple_Terminal for one
  return $TERM_PROGRAM =~ "iTerm"
endfunction

" Plugin Alternatives Switches
let s:use_ctrlp = 1
let s:use_unite = 0
let s:use_delimitmate = 1
let s:use_auto_pairs = 0

function! SetGitForWindowsSDKShell()
  " TODO: Fix this for the `Right Click -> Edit with Vim` workflow
  " It works when launching via gvim& from the commandline, but not with the registry hook
  " TODO: Figure out how to determine between "started from gvim& in a MINGW session"
  "       and "started from Right Click -> Edit in Vim"

  " For Git for Windows SDK in ConEmu, get shell like this:
  " cygpath --mixed $(which bash)
  " set shell=C:/git-sdk-64/usr/bin/bash.exe

  set shell=bash
  set shellcmdflag=-c
  set shellredir=>%s\ 2>&1
  set shellpipe=2>&1\|\ tee
  set shellquote=
  set shellxquote=\"
  " set shellxquote='"'
  set shellslash
endfunction

function! SetCmdShell()
  " https://github.com/agkozak/dotfiles/blob/master/.vimrc#L272
  " This shell set causes nerdtree to have issues
  " set shell=cmd
  " set shellquote=
  " set shellxquote=(
  " set shellcmdflag=/c
  " set shellredir=>%s\ 2>&1
  " set shellpipe=>
  " set noshellslash
endfunction

" TODO: Refactor shell setup like this:
"   https://github.com/LucHermitte/vim-system-tools/blob/master/plugin/system_utils.vim
"   https://github.com/LucHermitte/lh-vim-lib/blob/master/autoload/lh/os.vim

" Set up shell based on OS
if has('win64') || has('win32') " Using InWindowsSession() here breaks syntastic
  " " Use cmd as the shell
  " set shell=cmd
  " set shellcmdflag=/c
  let temp_dir=$HOME."/.vim-tmp"
  " Create the temp_dir if it doesn't exist
  if !isdirectory(expand(temp_dir))
    call mkdir(expand(temp_dir), "p")
  endif

  let $TMPDIR=temp_dir
  let $TMP=temp_dir
  let $TEMP=temp_dir

  " Just assume running in a Git for Windows SDK session
  call SetGitForWindowsSDKShell()
else
  " echo "Not windows, default shell"
endif

" Set up vim_path, which is where we host files
" Source: https://github.com/poxar/vimfiles/blob/abdb40ee482f63e3f665c0d7db2e738ad42c51f5/vimrc#L10-16
if InWindowsSession()
  let g:vim_path = "~/vimfiles"
else
  let g:vim_path = "~/.vim"
endif


" Start vim-plug
" TODO: Something like this: https://github.com/agkozak/dotfiles/blob/master/.vimrc#L312
call plug#begin(expand(g:vim_path) . '/bundle/')

" Conditional Activation Function
" Usage:
"   Basic: Plug 'author/thing', Cond(has('depedency'))
"   With Options: Plug 'author/thing', Cond(has('dependency'), { 'on': 'Thing' })

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Colors
" Plug 'vim-scripts/ScrollColors', { 'on': 'LoadColors' }
" Plug 'twerth/ir_black', { 'on': 'LoadColors' }
" Plug 'vim-scripts/moria', { 'on': 'LoadColors' }
" Plug 'vim-scripts/Color-Sampler-Pack', { 'on': 'LoadColors' }
" Plug 'altercation/vim-colors-solarized', { 'on': 'LoadColors' }
" Plug 'tomasr/molokai', { 'on': 'LoadColors' }
Plug 'mhartington/oceanic-next' " , { 'on': 'LoadColors' }
Plug 'ciaranm/inkpot', { 'on': 'LoadColors' }

Plug 'trevordmiller/nova-vim'
if has('gui_running')
  " TODO: Install this wether its gui or not
  Plug 'NLKNguyen/papercolor-theme'
else
  " TODO: Install this wether its gui or not
  Plug 'nanotech/jellybeans.vim'
endif

" Highlights hex codes with their colors
Plug 'lilydjwg/colorizer'

" Code searching
" Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'

" Better Buffer management
Plug 'mhinz/vim-sayonara'
Plug 'vim-scripts/BufOnly.vim'

" Searching for stuff
if s:use_ctrlp
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'FelikZ/ctrlp-py-matcher' " ~22x faster matching
endif

if s:use_unite
  Plug 'Shougo/unite.vim'
  Plug 'Shougo/neomru.vim'
endif

" File management
Plug 'preservim/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin' " Show git marks in nerdtree
Plug 'low-ghost/nerdtree-fugitive' " Adds git menu to nerdtree
Plug 'kopischke/vim-fetch' " Enable vim to open with line numbers appended

" -- Auto parentheses
if s:use_auto_pairs
  Plug 'jiangmiao/auto-pairs'
endif
if s:use_delimitmate
  Plug 'Raimondi/delimitmate'
endif
" delimitmate issues
  " This breaks the dot command
  " cursor goes wild in the terminal
" auto-pairs issues:
  " _always_ inserts the pair, even when I'm at the start of the word.
  " cursor goes wild in the terminal

" Improved Undo functionality
Plug 'sjl/gundo.vim'

" Snippets
if !InConEmuSession() " TODO: Get this working with ConEmu vim
  Plug 'SirVer/ultisnips', Cond(has('python3'))
end

Plug 'ervandew/supertab'

" Language specific
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'tmux-plugins/vim-tmux'
Plug 'pearofducks/ansible-vim'
Plug 'nginx/nginx',   { 'rtp': '/contrib/vim' }
Plug 'PProvost/vim-ps1'
Plug 'ekalinin/dockerfile.vim'
Plug 'OrangeT/vim-csharp', { 'for': ['cs'] }

" Lua Support
" Alternatives:
" - http://www.vim.org/scripts/script.php?script_id=4950
" - https://github.com/xolox/vim-lua-ftplugin
" - https://github.com/xolox/vim-lua-inspect
Plug 'tbastos/vim-lua', { 'for': ['lua'] }

" JS/React/CoffeeScript

" What Peter P. suggested, TODO: Summaries
Plug 'mxw/vim-jsx',                              { 'for': ['javascript', 'js'] }
Plug 'othree/yajs.vim',                          { 'for': ['javascript', 'js'] }
Plug 'mtscout6/vim-cjsx',                        { 'for': ['javascript', 'js'] }
Plug 'jason0x43/vim-js-indent',                  { 'for': ['javascript', 'js', 'typescript', 'tsx'] }
Plug 'pangloss/vim-javascript',                  { 'for': ['javascript', 'js'] }
Plug 'othree/javascript-libraries-syntax.vim',   { 'for': ['javascript', 'js'] }


" Typescript from: https://github.com/Quramy/tsuquyomi#relevant-plugins
Plug 'Quramy/vim-js-pretty-template',            { 'for': ['javascript', 'js', 'typescript', 'tsx'] }
Plug 'leafgarland/typescript-vim',               { 'for': ['javascript', 'js', 'typescript', 'tsx'] }

" Can't connect to repo. No longer public?
" Plug 'git@github.com:othree/es.next.syntax.vim', { 'for': ['javascript', 'js'] }
Plug 'othree/html5.vim',                         { 'for': ['html'] }

" What I had:
" Plug 'kchmck/vim-coffee-script'
" Plug 'mtscout6/vim-cjsx'
" Plug 'jelera/vim-javascript-syntax', { 'for': ['javascript'] }
Plug 'maksimr/vim-jsbeautify', { 'for': ['javascript'] }
" Plug 'jsx/jsx.vim'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-airline-colornum' " Highlight the current line number with the color of the current mode

" Easier file movement
Plug 'Lokaltog/vim-easymotion'
" Look into https://github.com/justinmk/vim-sneak as an alternative

" tpope  rocks
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize' " Improve 'ga' behavior to work with Unicode and other modern stuff

" Surrounding shit
"   Given
"       "Hello world!"
"   press
"       cs"'
"   to change to
"       'Hello world!'
Plug 'tpope/vim-surround'

" If I ever do a lot of json stuff, apparently this is **must** have.
" https://github.com/tpope/vim-jdaddy
" Plug 'tpope/vim-jdaddy'

" Ruby stuff
Plug 'vim-ruby/vim-ruby'                            " Ruby support stuff
Plug 'tpope/vim-rails',         { 'for': ['ruby'] } " Fancy pr
" Plug 'tpope/vim-bundler',       { 'for': ['ruby'] } " Works with vim-rails and vim-rake for bundler goodness


Plug 'tpope/vim-endwise',       { 'for': ['ruby'] } " Add matching 'end's for blocks
" Plug 'tpope/vim-projectionist', { 'for': ['ruby'] } " Project management for navigation n such

" Git!
" TODO: This still doesn't work when openned via right click, edit with vim
" Plug 'airblade/vim-gitgutter'        " Shows git changes in the sign column
Plug 'tpope/vim-git'                 " Git runtime files
Plug 'tpope/vim-fugitive'            " Awesome git wrapper
Plug 'shumphrey/fugitive-gitlab.vim' " Gitlab features for fugitive
Plug 'tpope/vim-rhubarb'             " Github specific features building on fugitive

" TODO: Look at https://github.com/junegunn/gv.vim
Plug 'gregsexton/gitv'               " Enable :gitv! version viewing

" Syntax
Plug 'vim-syntastic/syntastic' " Easy syntax messages
Plug 'dbakker/vim-lint'     " Linting for vim and vimL files.

" Improved searches
Plug 'inside/vim-search-pulse' " Pulse after searches
Plug 'haya14busa/incsearch.vim' " Show all matches as typed, auto nohl

"Multiple Curosrs!
" Plug 'terryma/vim-multiple-cursors'
" Plug 'kana/vim-niceblock' " make |v_b_I| and |v_b_A| available in all visual modes

" Better Text Objects
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'andymass/vim-matchup'
" Plug 'terryma/vim-expand-region' # messes with my _ binding for horizontal splits

" Lets us use 'ir' for _inner_ ruby block text object and 'ar' for _all_ of a ruby block text object
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': ['ruby'] }

" Better Markdown
Plug 'shime/vim-livedown', { 'for': ['markdown'] }
" Plug 'tpope/vim-markdown', { 'for': ['markdown'] }
Plug 'gabrielelana/vim-markdown', { 'for': ['markdown'] }
" Also this: https://github.com/plasticboy/vim-markdown

" Allow . to repeat things more often. Enables plugins (like gitgutter) and I can
"   map it myself
Plug 'tpope/vim-repeat'

" Go!
Plug 'fatih/vim-go', { 'for': ['go'] }

" Api Blueprint
Plug 'kylef/apiblueprint.vim'

" Mimic macvim cursor toggling
" Plug 'jszakmeister/vim-togglecursor'

" Pretty parantheses!
" Plug 'junegunn/rainbow_parentheses.vim'

" Extends `"` and `@` in normal mode and <Ctrl-R> in insert mode to show the contents of the registers
" TODO: Do I like this? Seems invasive and affects standard vim commands
" Plug 'junegunn/vim-peekaboo'

" Remember where the cursor has been
" TODO: Does this work? How do I make use of it again?
" TODO: This collides with my <Leader>j mapping for joining lines
" Plug 'fergdev/vim-cursor-hist'

" Considering!
" https://github.com/chrisbra/vim-diff-enhanced " Improved diff's using histogram and patience algorithms
" https://github.com/thoughtbot/vim-rspec " Sweet rspec integration
" Plug 'yegappan/mru' " :MRU Most Recently Used files
" Plug 'dougnukem/vim-swap-lines' " Swap two lines
" TODO: Investigate this https://github.com/LucHermitte/lh-vim-lib


" No longer using:
" This is almost entirely handled by `rubocop --auto-correct` for ruby files
" Plug 'godlygeek/tabular' " Easy Alignment!

" Update &runtimepath and initialize plugin system. Automatically executes
" `filetype plugin indent on` and `syntax enable`.
call plug#end()

" Forget being compatible with good ol' vi
set nocompatible

" Turn on syntax!
syntax on

" Restore cursor position from last time you editted the file
" TODO: See if we can return the window to the same height too
augroup line_return
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") && &ft!='gitcommit' && &ft!='gitrebase' |
        \       execute 'normal! g`"zvzz' |
        \ endif
augroup END


" -----
" Vim Preferences
" -----

" Allow dirtied buffers to be hidden
set hidden

" Show what you are typing as a command
set showcmd

" Keep some stuff in the history
set history=10000

" Save undo's after file closes
set undofile

" Use lots of undo levels
set undolevels=1000

" Number of lines to save for undo
set undoreload=10000

" Set where to save undo histories
" Fancy undo file location. The trailing '//' makes a unique path by using the
" full path of the original file.
let g:tmp_root = $HOME . "/.vim/tmp"
" Set Undo files directory, Backups, and Swap files directory
let &undodir=g:tmp_root . '/undo//'
let &backupdir=g:tmp_root . '/backup//'
let &directory=g:tmp_root . '/swap//'

" Make those folders automatically if they don't already exist. Will fail if ~/.vim or ~/.vim/tmp do not exist
if !isdirectory(expand(g:tmp_root))
  call mkdir(expand(g:tmp_root))
endif
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir))
endif
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir))
endif
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory))
endif

" Enable backups
set backup
" No More Collisions!
set noswapfile

" Show filename in titlebar of window
set title

" Don't set the title to something weird when we're saving/closing
set titleold=

" Always reload buffer when external changes detected
set autoread

" Last window always has a statusline
set laststatus=2

" Only care about base 10 digits, not octal or hex
set nrformats=

" Various characters are "wider" than normal fixed width characters, but the
" default setting of ambiwidth (single) squeezes them into "normal" width,
" which sucks.  Setting it to double makes it awesome.
" -- From derekwyatt
set ambiwidth=double

" Improve smoothness and swiftness of redrawing, because we use modern terminals
set ttyfast


" -----
" Window/Buffers/Tabs
" -----

" Only apply to .txt files...
augroup HelpInVerticalRightSplit
  autocmd!
  autocmd BufEnter  *.txt   call HelpInVSplit()
augroup END

"Only apply to help files...
function! HelpInVSplit()
  if &buftype == 'help'
    "Convert the help window to right-side veritcal split
    execute "normal \<C-W>L"
  endif
endfunction

" left and right are for switching buffers
noremap <right> :bn<return>
noremap <left> :bp<return>

" ctrl + tab and ctrl + shift + tab too, like firefox/chrome/iterm
noremap <C-Tab> :bn<return>
noremap <C-S-Tab> :bp<return>

" When switching buffers, jump to the first open window that contains the buffer,
" and include tabs in the search.
set switchbuf=useopen,usetab


" -----
" TABS and Whitespace
" -----

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Set the cursor at the same indent as line above
set autoindent

" Try to be smart about indenting (c-style)
set smartindent

" Use existing indents for new indents
set copyindent

" Save as much indent structure as possible
set preserveindent

" Always round indents to multiple of shiftwidth
set shiftround

" Only one space when using "join" commands
set nojoinspaces

augroup VisualEffects
  au!
  " Remove any trailing whitespace that is in the file
  autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

  " TODO: Figure out how to replace mixed spaces and tabs with only spaces,
  " we've already got Airline warning us about it

  " Save when losing focus
  " NOTE: This doesn't work as well as it should. It's a cool idea though.
  "autocmd FocusLost * :wa
  " Same thing, haven't tried this version though
  "autocmd FocusLost * :silent! wall

  " Resize splits when the window is resized
  autocmd VimResized * exe "normal! \<c-w>="
augroup END

" Fix indents when linewrap is on
set breakindent


" -----
" Column length!
" -----

if exists('+colorcolumn')
  set colorcolumn=80
else
  " If we don't support colorcolumn, then highlight the characters past column 80
  highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  match OverLength /\%81v.\+/
endif


" -----
" Common Syntax Groups from :help syntax
" -----

"  *Comment any comment
"  *Constant any constant
"     String     a string constant: "this is a string"
"     Character  a character constant: 'c', '\n'
"     Number     a number constant: 234, 0xff
"     Boolean    a boolean constant: TRUE, false
"     Float      a floating point constant: 2.3e10
"   *Identifier  any variable name
"     Function  function name (also: methods for classes)
"   *Statement  any statement
"     Conditional  if, then, else, endif, switch, etc.
"     Repeat       for, do, while, etc.
"     Label        case, default, etc.
"     Operator     "sizeof", "+", "*", etc.
"     Keyword      any other keyword
"     Exception    try, catch, throw
"   *PreProc  generic Preprocessor
"     Include    preprocessor #include
"     Define     preprocessor #define
"     Macro      same as Define
"     PreCondit  preprocessor #if, #else, #endif, etc.
"   *Type   int, long, char, etc.
"     StorageClass  static, register, volatile, etc.
"     Structure     struct, union, enum, etc.
"     Typedef       A typedef
"   *Special   any special symbol
"     SpecialChar     special character in a constant
"     Tag             you can use CTRL-] on this
"     Delimiter       character that needs attention
"     SpecialComment  special things inside a comment
"     Debug           debugging statements
"   *Underlined text that stands out, HTML links
"   *Ignore  left blank, hidden  |hl-Ignore|
"   *Error  any erroneous construct
"   *Todo  anything that needs extra attention; mostly the keywords TODO FIXME and XXX


" -----
" File Specific Display stuff like tabs
" -----

augroup JavaScriptFiles
  au!

  " Fold by indentation in CoffeeScript
  autocmd BufNewFile,BufRead *.coffee setlocal foldmethod=indent nofoldenable

  " Detect .es6 files
  autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript.jsx
augroup END

augroup XmlFiles
  au!

  let g:xml_syntax_folding=1
  au FileType xml setlocal foldmethod=syntax
augroup END

augroup RSpecFiles
  au!

  " rails-vim doesn't correctly assign buffer types for all of the files, making
  "   highlighting is inconsistent. Do some of it by hand.
  autocmd BufNewFile,BufRead *_spec.rb call RSpecSyntax()
  " Might want to surround the call with `if ! RailsDetect() | ... | endif`
augroup END

function! RSpecSyntax()
  hi def link rubyRailsTestMethod Function

  syntax keyword rubyRailsTestMethod describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let expect it to be eq include
endfunction

augroup RubyFiles
  au!

  " vim-ruby screws up my formatting options
  "   We don't want to continue comments when pressing o/O
  autocmd Filetype ruby setlocal formatoptions-=o
  "   Don't continue comments after pressing <Enter> in insert either
  autocmd Filetype ruby setlocal formatoptions-=r

  " Prefer CRLF line endings
  autocmd Filetype ruby setlocal fileformat=unix

  " Add bang to iskeyword for ruby files, making `w` and autocomplete think it's part of identifiers/words
  " TODO: This makes !Dir.thing fail to highlight :(
  autocmd Filetype ruby setlocal iskeyword+=!

  " Extend ruby syntax highlighting
  autocmd Filetype ruby call RubySyntax()
augroup END

function! RubySyntax()
  hi! def link rubyCapitalizedMethod rubyConstant

  " Differ integers and booleans from strings
  hi! def link rubyBoolean Function
  hi! def link rubyInteger Function

  " Extend OceanicNext colorscheme
  hi! def link rubyCurlyBlockDelimiter Conditional
  hi! def link rubyBlockParameterList Conditional

  " Make OceanicNext interpolation text white
  hi! def link rubyInterpolation rubyMethodBlock
endfunction

augroup YAMLFiles
  au!

  " Prefer CRLF line endings
  autocmd Filetype yaml setlocal fileformat=unix
augroup END

augroup VimFiles
  au!

  " Vim's built in file type stuff doesn't like to respect my settings!
  "   Don't auto wrap test
  autocmd Filetype vim setlocal textwidth=0
  "   We don't want to continue comments when pressing o/O
  autocmd Filetype vim setlocal formatoptions-=o
  "   Don't continue comments after pressing <Enter> in insert either
  autocmd Filetype vim setlocal formatoptions-=r

  " Prefer CRLF line endings
  autocmd Filetype vim setlocal fileformat=unix

  " Override default vim filetype syntax
  autocmd Filetype vim call VimSyntax()
augroup END

function! VimSyntax()
  " Problem: Quoted things are highlighted in vim comments
  " Solution: Set vimCommentString syntax group back to regular
  "   comment highlighting, with bang for force
  hi! def link vimCommentString Comment
endfunction

augroup GitFiles
  au!

  " Highlight the point at which the message is too long
  autocmd Filetype gitcommit setlocal colorcolumn=51
  " Correctly wrap body message lines, at 72 characters
  autocmd Filetype gitcommit setlocal textwidth=72

  " Comment string to comment instead of removing files
  autocmd Filetype gitconfig setlocal commentstring=#%s
augroup END

augroup ZshFiles
  au!

  " Don't continue comments, with o/O or <Enter>, _seriously_
  autocmd Filetype zsh setlocal formatoptions-=ro

  " Prefer CRLF line endings
  autocmd Filetype zsh setlocal fileformat=unix
augroup END

augroup ApiBlueprintFiles
  au!

  " Use 4 spaces for tabs
  autocmd Filetype apiblueprint setlocal shiftwidth=4
  autocmd Filetype apiblueprint setlocal softtabstop=4
  autocmd Filetype apiblueprint setlocal tabstop=4
augroup END

augroup AutoHotkeyFiles
  au!
  autocmd Filetype autohotkey setlocal commentstring=;\ %s
augroup END

augroup BashFiles
  au!

  " Prefer CRLF line endings
  autocmd Filetype sh setlocal fileformat=unix
augroup END

augroup EchoFiles
  au!

  " Set the filetype for encrypted vault files to JSON for syntax and linting
  autocmd BufNewFile,BufRead development.key setlocal filetype=json
  autocmd BufNewFile,BufRead qa.key setlocal filetype=json
  autocmd BufNewFile,BufRead production.key setlocal filetype=json
augroup END

augroup MarkdownFiles
  au!

  " Prefer CRLF line endings
  autocmd Filetype markdown setlocal fileformat=unix
augroup END

augroup PowershellFiles
  au!

  " Prefer CRLF line endings
  autocmd Filetype ps1 setlocal fileformat=unix
augroup END


" -----
" Typing Behaviors
" -----

" Enable enhanced command-line completion. Presumes you have compiled
" with +wildmenu.  See :help 'wildmenu'
"set wildmenu
set wildmode=list:longest,full

" File types to ignore for wildmode
" Note #0: These are from :help ctrlp
" Note #1: the `*/` in front of each directory glob is required.
" Note #2: |wildignore| influences the result of |expand()|, |globpath()| and
" |glob()| which many plugins use to find stuff on the system (e.g. VCS related
" plugins look for .git/, .hg/,... some other plugins look for external *.exe
" tools on Windows). So be a little mindful of what you put in your |wildignore|.
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.gitignore,*.sln,.hg            " Version Control, tpope says don't ignore .git
" set wildignore+=*.gitignore,*.sln,.hg,.git     " Version Control
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " Compiled objects
set wildignore+=*.DS_Store                       " OSX Sucks
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png   " Binary images
set wildignore+=*/.bundle/*                      " Ruby bundle stuff

" Set the forward slash to be the slash of note.  Backslashes suck
" Matters only on Windows
set shellslash

" Allow backspacing over indent, eol, and the start of an insert
set backspace=2

" Hide the mouse pointer while typing
set mousehide

" This is the timeout used while waiting for user input on a
" multi-keyed macro or while just sitting and waiting for another
" key to be pressed measured in milliseconds.
"
" i.e. for the ",d" command, there is a "timeoutlen" wait
"      period between the "," key and the "d" key.  If the
"      "d" key isn't pressed before the timeout expires,
"      one of two things happens: The "," command is executed
"      if there is one (which there isn't) or the command aborts.
"
" The idea here is that if you have two commands, say ",dv" and
" ",d" that it will take 'timeoutlen' milliseconds to recognize
" that you're going for ",d" instead of ",dv"
"
" In general you should endeavour to avoid that type of
" situation because waiting 'timeoutlen' milliseconds is
" like an eternity.
set timeoutlen=500
" Use a different length for key-codes
set ttimeoutlen=50

" Escape from insert mode faster
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=500
augroup END

" These commands open folds
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

" Don't continue comments when pushing o/O
set formatoptions-=o

" Don't continue comments when pressing <Enter>
set formatoptions-=r

" Don't let anything wrap my lines unless I choose to
set formatoptions-=t " Don't automatically wrap
set textwidth=0 " If we were to auto wrap, or something added fo+=t then still don't
set wrapmargin=0 " Similar to textwidth but relative to terminal width

" When it makes sense, remove comment leader when joining lines
set formatoptions+=j

" Use the system clipboard for yanking
set clipboard=unnamed


" -----
" Completion
" :help ins-completion
"   CTRL-Y: Stop completion and accept currently selected entry
"   CTRL-E: Stop completion and return to originally typed text
"   See: :help popupmenu-keys
" More options:
"   pumheight
" Highlight options:
" Pmenu      normal item  |hl-Pmenu|
" PmenuSel   selected item  |hl-PmenuSel|
" PmenuSbar  scrollbar  |hl-PmenuSbar|
" PmenuThumb thumb of the scrollbar  |hl-PmenuThumb|
"
" Look into:
"   let g:rubycomplete_buffer_loading = 1
"   let g:rubycomplete_classes_in_global = 1
" -----

" Use a popup menu to show possible completions one there is one or more matches
"   and show extra information about the currently selected completion
set completeopt=menuone,preview


" -----
" Movement
" -----
" Don't move cursor to start of line when using certain movement commands like
" "<c-d>" or "gg"
set nostartofline

" Include - character in words for use with things like "w", "*", and "[i"
" Defaults are: iskeyword=@,48-57,_,192-255
set iskeyword+=-


" -----
" Searching
" -----

" Incrementally match the search.
set incsearch

" Set the search scan to wrap around the file
set wrapscan

" Ignore case for searching
set ignorecase

" BUT use case if upper case letter is used
set smartcase

" Different characters take on different meanings in search
"   . is any character
"   $ matches end-of-line
"   and a few others. See :help magic
set magic

" ignore all whitespace and sync when searching
"set diffopt=filler,iwhite

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>


" -----
" GUI Settings
" -----

" Make command line one lines high
set cmdheight=1

" Don't update the display while executing macros
set lazyredraw

" Don't show mode, airline does that
set noshowmode

" Show the line number on the bar
set ruler

" Line Numbers please!
set number

" No error bells please
set noerrorbells
set visualbell

" set visual bell OFF
set t_vb=
au GUIEnter * set visualbell t_vb=

" Sets the default size of gvim on open
set lines=50 columns=90

" Set the possible encodings
set fileencodings=ucs-bom,utf-8,latin1

" Set encoding
set encoding=utf-8

" Set whitespace characters to display
"   |<C-k> -,| for the trail digraph
"   |<C-k> sB| for the nbsp digraph
"   |<C-k> <<| for the precedes digraph
" Other options:
" - This fancy tab char which doesn't always work - 'tab:▸-'
" - Fancy end of line "carriage return symbol" - 'eol:↲'
" - Fancy arrow for tab - 'tab:▸\'
" - Fancy end of line thing - 'eol:¬'
set listchars=tab:>-,trail:.,extends:»,precedes:«,nbsp:▪

" From: https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
" set showbreak=↪\
" set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" set listchars=tab:▶\ ,eol:★
" set listchars+=trail:◥
" set listchars+=extends:❯
" set listchars+=precedes:❮
" set listchars=tab:→\ ,trail:·,eol:¬,extends:…,precedes:…


" Actually display them, call :set list! to toggle
set list

" Use english for spellchecking, but don't spellcheck by default. Set spelling after
" setting encoding or the files will be loaded twice.
if version >= 700
  set spelllang=en_us
  set nospell
  " But in case we _do_ use spelling, here is my spellfile
  execute 'set spellfile=' . g:vim_path . '/spell/' . 'code.utf-8.add'

  " Vim requires a binary index of the additional spelling words, create it if it
  " doesn't exist already. Adding new words rebuilds it automatically.
  for f in glob('~/.vim/spell/*.add', 1, 1)
    if !filereadable(f . '.spl')
      silent! execute "mkspell!" f
    endif
  endfor
endif

" Colors and Term stuff!
function! HasColorscheme(name)
  let pat = 'colors/'.a:name.'.vim'
  return !empty(globpath(&rtp, pat))
endfunction

if has('gui_running')
  set background=dark

  if HasColorscheme('OceanicNext')
    colorscheme OceanicNext
    let g:airline_theme='oceanicnext'
    " Default: ctermbg=4 guifg=#556873 guibg=#3C4C55
    " Reset ColorColumn and then set it via my preferences
    " highlight ColorColumn NONE
    " highlight ColorColumn guifg=#C5D4DD guibg=#556873

    " Change rubyInterpolation to base05
    " Change rubySymbol to base0C
    " Change Symbol to base09
    " Change Identifier to base09
  elseif HasColorscheme('nova')
    colorscheme nova
    let g:airline_theme='nova'
    " Default: ctermbg=4 guifg=#556873 guibg=#3C4C55
    " Reset ColorColumn and then set it via my preferences
    highlight ColorColumn NONE
    highlight ColorColumn guifg=#C5D4DD guibg=#556873
  elseif HasColorscheme('PaperColor')
  " if HasColorscheme('PaperColor')
    colorscheme PaperColor
    let g:airline_theme='PaperColorRecharged'
  else
    colorscheme elflord
    let g:airline_theme='luna'
  endif
  " Remove the gui from GVim
  :set guioptions-=m " Remove menu bar
  :set guioptions-=T " Remove the toolbar
  :set guioptions-=r " Remove the right-hand scroll bar
  :set guioptions-=L " Remove the left-hand scroll bar...bar[]

  " Windows Specific stuff
  if InWindowsSession()
    " Set vim to be maximized on opening
    au GUIEnter * simalt ~x
    " Set the default font to Input, which i've custom downloaded, with Consolas Fallback
    set guifont=Input:h14,Consolas:h12:cANSI
  elseif InMacbookSession()
    set guifont=Input:h14,Menlo:h12
  else
    " Set the default font to Source Code Pro (with escaped spaces) which I
    " use everywhere!
    " set guifont=Source\ Code\ Pro\ for\ Powerline:h12
    " set guifont=Source\ Code\ Pro:h12 " Not using the powerline symbols for now

    " TODO: Better font
    " set macligatures
    " set guifont=Operator\ Mono\ Book:h13
  endif
else
  if InConEmuSession()
    " Fix <BS> in ConEmu terminals per http://conemu.github.io/en/VimXterm.html#vim-bs-issue
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
    " Fix arrows/backspace in ConEmu
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
  endif

  if !has('nvim')
    set term=xterm
  endif

  if (has("termguicolors"))
    set termguicolors
  else
    set t_Co=256
  endif

  set background=dark

  " set termencoding=utf8

  " 0 is blinking block
  " 2 is solid block
  " 3 is blinking underline
  " 4 is solid underline
  " 5 is blinking line
  " 6 is solid line

  " From: https://conemu.github.io/en/AnsiEscapeCodes.html
  " 0 - ConEmu's default
  " 1 - blinking block
  " 2 - steady block
  " 3 - blinking underline
  " 4 - steady underline
  " 5 - blinking bar
  " 6 - steady bar

  " TODO: Try this: https://github.com/microsoft/terminal/issues/68#issuecomment-621891237

  " Replace Mode
  let &t_SR=""
  " let &t_SR="[5 q"
  " let &t_SR = "\<Esc>[5 q"
  " let &t_SR = "\e[5 q"

  " Normal Mode
  let &t_EI=""
  " let &t_EI="[1 q"
  " let &t_EI = "\<Esc>[1 q"
  " let &t_EI = "\e[1 q"

  " Insert Mode
  let &t_SI=""
  " let &t_SI="[5 q"
  " let &t_SI = "\<Esc>[5 q"
  " let &t_SI = "\e[5 q"

  " Put terminal in "termcap" mode??
  " let &t_ti="[1 q"
  " let &t_ti="\e[1 q"

  " Out of "termcap" mode???
  " let &t_te="[0 q"
  " let &t_te="\e[0 q"

  " TODO: Is this necessary??

  autocmd VimLeave * silent execute '!echo -ne " \e[5 q"' | redraw!

  if HasColorscheme('jellybeans')
    colorscheme jellybeans
    let g:airline_theme='jellybeans'
  else
    colorscheme inkpot
    let g:airline_theme='luna'
  endif
endif

" Long lines make syntax highlighting slow
set synmaxcol=2048

" When the page starts to scroll, keep the cursor 8 lines from
" the top and 8 lines from the bottom
set scrolloff=8

" Keep some columns visible when horizontally scrolling
set sidescroll=8

" Set off the other paren by FLASHING
" TODO: Pretty sure this doesn't work
highlight MatchParen ctermbg=4

" TODO: Pretty sure this doesn't work either
set showmatch mat=6 " show matching parens for 600ms

" Shows report when any ammount of lines are changed (read always)
set report=0

" 'a' = Shorten messages, 'oO' = overwrite read/write messages (required for vim-fetch),
" 'tT' = truncate messages that are too long, and 'I' = skip the Vim :intro
set shortmess=aoOtTI

" Open new split panes to the right and bottom, feels a lot more natural
set splitbelow
set splitright

" Using the mouse in the terminal
if has('mouse')
  set mouse=a
  if has('mouse_sgr') || v:version > 703 ||
        \ v:version == 703 && has('patch632')
    " Ideal mouse setting, backwards compatible with xterm and xterm2
    if !has('nvim')
      set ttymouse=sgr
    endif
  else
    " Fallback
    if !has('nvim')
      set ttymouse=xterm2
    endif
  endif
endif


" -----
" Visual Mode Better
" -----

" Switch Visual and Visual-Block
nnoremap v <c-v>
nnoremap <c-v> v
vnoremap v <c-v>
vnoremap <c-v> v

"Reselect after indent so it can easily be repeated
vnoremap < <gv
vnoremap > >gv

" Make BS/DEL work as expected in vusal modes (i.e. delete the selected text)
vmap <BS> x

" Make vaa select the entire file
vmap aa VGo1G

" Visual block beyond the characters in the line, ie virtually
set virtualedit=block


" -----
" Custom Functions
" -----

" Sets the arglist to contain each of the files referenced by the quickfix list
"   Source: http://vimcasts.org/episodes/project-wide-find-and-replace/
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction

" Redirect the output of an ex cmd and filter the output before dumping into a scratch buffer
function! s:FilterLines(cmd, filter)
  " From: http://vim.wikia.com/wiki/List_loaded_scripts

  " Execute 'cmd' while redirecting output.
  let save_more = &more
  set nomore
  redir => lines
  silent execute a:cmd
  redir END
  let &more = save_more

  " Display result in a scratch buffer.
  new
  setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
  put =lines

  " Delete any blank lines.
  silent g/^\s*$/d

  " Delete '<whitespace><number>:<whitespace>' from start of each line.
  silent %s/^\s*\d\+:\s*//e

  " Delete all lines that do not match regex 'filter' (if not empty).
  if !empty(a:filter)
    silent execute 'v/' . a:filter . '/d'
  endif
  0
endfunction
command! -nargs=? ScriptNames call s:FilterLines('scriptnames', <q-args>)

" TODO: See if we can simplify
" With Vim 8 we can do this:
" :enew|pu=execute('scriptnames')

" TODO: See if this is better than existing Filter_lines
" The following is a more generic function allowing you to view any ex command in a scratch buffer:
" function! s:Scratch (command, ...)
"    redir => lines
"    let saveMore = &more
"    set nomore
"    execute a:command
"    redir END
"    let &more = saveMore
"    call feedkeys("\<cr>")
"    new | setlocal buftype=nofile bufhidden=hide noswapfile
"    put=lines
"    if a:0 > 0
"       execute 'vglobal/'.a:1.'/delete'
"    endif
"    if a:command == 'scriptnames'
"       %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
"    endif
"    silent %substitute/\%^\_s*\n\|\_s*\%$
"    let height = line('$') + 3
"    execute 'normal! z'.height."\<cr>"
"    0
" endfunction

" command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
" command! -nargs=+ Scratch call <sid>Scratch(<f-args>)


" -----
" Plugin settings
" -----

" Disable vim-json conceal settings
let g:vim_json_syntax_conceal = 0

" Prevent vim.jsx from setting up keymaps
let g:jsx_no_default_key_mappings = 1

" Let JSX run in normal JS files
let g:jsx_ext_required = 0


" ----- My Plugin: blocked
augroup blocked
  autocmd!
  autocmd FileType ruby nnoremap <silent> <buffer> <Leader>bld :call blocked#BracketsToDoEnd()<CR>
  autocmd FileType ruby nnoremap <silent> <buffer> <Leader>blf :call blocked#DoEndToBrackets()<CR>
augroup END


" ----- My Plugin: rubyhash

augroup rubyhash
  autocmd!
  autocmd FileType ruby nnoremap <silent> <buffer> <Leader>rhsy :call rubyhash#ToSymbolKeysLinewise()<CR>
  autocmd FileType ruby nnoremap <silent> <buffer> <Leader>rhst :call rubyhash#ToStringKeysLinewise()<CR>
augroup END


" -----
" Plugin: NERDTree
" -----
" Source: https://github.com/jistr/vim-nerdtree-tabs
" Source: https://github.com/mhinz/vim-sayonara
" Source: https://github.com/preservevim/nerdtree

" TODO: If I open vim with a directory argument I want the NERDTree root to be that directory
" http://stackoverflow.com/questions/5817730/changing-root-in-nerdtree

" Change the CWD whenever the NERDTree root changes
" let NERDTreeChDirMode=1

" Show hidden files by default
let NERDTreeShowHidden=1

" Hide helper text at the top
let NERDTreeMinimalUI=1

" Cascade open while selected directory has only one child thats a directory
let NERDTreeCascadeOpenSingleChildDir=1

" Automatically remove a buffer when a file is deleted or renamed
let NERDTreeAutoDeleteBuffer=1

" Highlight the current cursor line in the NERDTree buffer
let NERDTreeHighlightCursorLine=1

" AutoDelete discarded buffer after a move or rename
let NERDTreeAutoDeleteBuffer=1

augroup NERDTreeCustomization
  autocmd!

  " Open NERDTree if vim is openned without a file specificed
  " Note: I don't think I like this behavior
  " autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  " Close NERDTree
  " This should happen:
  "   When I ZZ the window and only the NERDTree window is left
  autocmd BufEnter * call CloseIfNERDTreeIsPrimary()
augroup END

function! CloseIfNERDTreeIsPrimary()
  if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()
    q
  endif
endfunction


" -----
" Plugin: Airline
" -----

" Don't load extensions based on runtime path
let g:airline#extensions#disable_rtp_load = 1

" Don't load any extensions by default
let g:airline_extensions = [
      \ 'quickfix', 'syntastic', 'ctrlp', 'whitespace', 'tabline'
      \ ]

" 0 is the algorithm number for 'must be all spaces or all tabs'
let g:airline#extensions#whitespace#mixed_indent_algo = 0

" Automatically displays all buffers when theres only one tab open
" TODO: investigate airline-tabline for more options
let g:airline#extensions#tabline#enabled = 1

" Enable syntastic integration
let g:airline#extensions#syntastic#enabled = 1

" TODO: investigate airline-ctrlp for show_adjacent_modes

" Ensure symbols dictionary exists
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Set custom separator symbols
if InConEmuSession()
  let g:airline_left_sep = '>'
  let g:airline_right_sep = '<'
else
  let g:airline_left_sep = '►'
  let g:airline_right_sep = '◄'
endif

" Set up status line
let g:airline#extensions#tabline#left_alt_sep = '|'
" List the buffer number between filemode and position, but I'm not sure if that's useful
" let g:airline_section_y=' [%n] '
let g:airline_section_z='%3p%% : %3l/%-3L :%4c '
" Get rid of b and y sections
" Left:
"   A: Mode + flags like crypt/spell/paste
"   B: Disabled - VCS Info
"   C: FIlename + read-only flag
" Right:
"   X: Filetype
"   Y: Disabled: file encoding[fileformat] (utf-8[unix])
"   Z: Current position in the file
"   Error: from syntastic, shows error info
"   Warning: from syntastic, shows warning info
let g:airline#extensions#default#layout = [
      \ [ 'a', 'c' ],
      \ [ 'x', 'z', 'error', 'warning' ]
      \ ]

" Disable paste detection
let g:airline_detect_paste=1

" Don't draw separators that are empty
" let g:airline_skip_empty_sections = 1

" let g:airline_detect_iminsert=0
" let g:airline_inactive_collapse=1

" Enable the cursorline coloring
:set cursorline
hi clear CursorLine


" -----
" Plugin: Ctrl-p
" -----

if s:use_ctrlp
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

  " Ignore stuff
  let g:ctrlp_custom_ignore = {
        \ 'dir': '\v[\/](\.git|\.hg|\.svn|_site|vimfiles|.vim|tmp|bundle)$',
        \ }

  " Don't ignore hidden files
  let g:ctrlp_show_hidden = 1

  " Don't follow symbolic links
  let g:ctrlp_follow_symlinks = 0

  " Where to do ctrlp caching
  let g:ctrlp_cache_dir = $TMPDIR.'/ctrlp/cache'

  " Always jump to open buffers
  let g:ctrlp_switch_buffer = 'etvh'

  " Working directory as such:
  "   Is the working directory of the owning shell an ancestor of the current
  "   file? Use that. Usually we open gvim/vim where we want the root
  let g:ctrlp_working_path_mode = 'a'

  " Ctrl-Shift-P => Open CtrlP in MRU Mode
  nnoremap <silent> <C-m> :CtrlPMRU<CR>

  if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden

    if InWindowsSession()
      if &shell ==# "cmd"
        " Only need to escape the quotes when using
        let g:ctrlp_user_command = 'ag %s --files-with-matches --hidden --nocolor -g "" --ignore "Alfred/*"'
      elseif &shell ==# "bash"
        " Per ':help win32-quotes', quotes in command line arguments need to be escaped on windows. But only when using bash as the shell it seems.
        let g:ctrlp_user_command = 'ag %s --files-with-matches --hidden --nocolor -g \"\" --ignore \"Alfred/\*\"'
      else
        " echom "Unknown shell: " . &shell . ", not setting ctrlp_user_command"
      end
    else
      " In Windows, the shell commands have a high overhead. Elsewhere, it's fast so turn it off
      let g:ctrlp_use_caching = 0

      let g:ctrlp_user_command = 'ag %s --files-with-matches --hidden --nocolor -g "" --ignore "Alfred/*"'
    endif
  else
    " TODO: Set grepprg here?
    " set grepprg=ag\ --nogroup\ --nocolor\ --hidden

    " TODO: Get this ignoring the Alfred files
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
    let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
      \ }
  endif
endif


" -----
" Plugin: Unite
" -----
if s:use_unite
  " Tons of good shit at https://github.com/bling/dotvim/blob/master/vimrc#L563
  " Look at http://mouki.io/2013/08/15/Vim-CtrlP-behaviour-with-Unite.html


  " Quickfix source:
  " https://github.com/osyo-manga/unite-quickfix

  " Tag source:
  " https://github.com/tsukkee/unite-tag

  " -- Supposed Ctrl-P replacement from https://gist.github.com/meatcar/5667617
  " nnoremap <leader>t :<C-u>Unite file_mru file_rec/async:! -start-insert -buffer-name=files<CR>
  " nnoremap <leader>cd :<C-u>Unite directory_mru directory -start-insert -buffer-name=cd -default-action=cd<CR>

  " -- Source: https://reinteractive.net/posts/166-awesome-vim-plugins
  " Search recently edited files
  nnoremap <silent> <Leader>m :Unite -buffer-name=recent -winheight=10 file_mru<cr>

  " Search open buffers
  nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>

  " Search application
  nnoremap <Leader>f :Unite grep:.<cr>

  " File searching just like Ctrl-P
  if exists(':Unite')
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source('file_rec/async','sorters','sorter_rank')
  endif
  " replacing unite with ctrl-p
  if !s:use_unite
    nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>
  endif

endif


" -----
" Plugin: Syntastic
" -----
" Default settings sill
" if exists(':SyntasticStatuslineFlag')
"   " TODO: I don't think this is required, airline does stuff without it
"   set statusline+=%#warningmsg#
"   set statusline+=%{SyntasticStatuslineFlag()}
"   set statusline+=%*
" endif

" Use the sign column for errors
let g:syntastic_enable_signs = 1

" Always put errors into the location list
let g:syntastic_always_populate_loc_list = 1

" Open the location list when errors are found
" let g:syntastic_auto_loc_list = 1

" Check syntastic errors when files are openned
let g:syntastic_check_on_open = 1

" Don't check on :wq, :x, or :ZZ
let g:syntastic_check_on_wq = 0

" Don't use any checkers for python, too slow
let g:syntastic_python_checkers = []

" Use 'yamllint' for yaml files
"   Further Info: http://yamllint.readthedocs.io/en/latest/
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_yaml_yamllint_args = '-c ' . shellescape($HOME . '/.yamllint')

" Use the rbenv ruby instead of system (outdated) ruby
let g:syntastic_ruby_mri_exec = '/usr/local/var/rbenv/shims/ruby'

" Map "errors" (not list)
nnoremap <silent> [e :lprevious<CR>zv
nnoremap <silent> [E :lfirst<CR>zv
nnoremap <silent> ]e :lnext<CR>zv
nnoremap <silent> ]E :llast<CR>zv

" Lua stuff!
"   brew install lua; luarocks install luacheck
" TODO: luac spits out a full page of errors rather than playing nice
" TODO: luacheck returns status code 73 and doesn't work
" let g:syntastic_lua_checkers = ["luac", "luacheck"]
" let g:syntastic_lua_luacheck_args = "--no-unused-args"


" -----
" Plugin: vim-ruby
" -----


" -----
" Plugin: vim-rails
" -----
" we want:
"   components/vendors/style_crest/lib/style_crest/shipping.rb
"   to map to alternate at:
"   spec/components/vendors/style_crest/lib/shipping.rb
let g:rails_projections = {
      \ "components/*.rb": {
      \   "test": "spec/components/{}_spec.rb",
      \ },
      \ "spec/components/*_spec.rb": {
      \   "test": "components/{}.rb"}}


" -----
" Plugin: nerdtree-git-plugin
" -----
" Change the indicators
let g:NERDTreeIndicatorMap = {
      \ "Modified"  : "~",
      \ "Staged"    : "☈",
      \ "Untracked" : "♦",
      \ "Renamed"   : "⁕",
      \ "Unmerged"  : "⥮",
      \ "Deleted"   : "␡",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✓",
      \ "Unknown"   : "?"
      \ }


" -----
" Plugin: vim-surround
" -----
" Enable automatic re-indenting by Vim, = command style
let g:surround_indent = 1

" Don't automatically create insert mode mappings, I'll do that myself if
"   needed
let g:surround_no_insert_mappings = 1


" -----
" Plugin: vim-projectionist
" -----
" Doesn't work as expected
" let g:projectionist_heuristics = {
"       \     "app/*.rb": {
"       \         "alternate": "spec/unit/{}_spec.rb",
"       \         "type": "source"
"       \     },
"       \     "spec/unit/*_spec.rb": {
"       \         "alternate": "app/{}.rb",
"       \         "type": "test"
"       \     }
"       \ }


" -----
" Plugin: vim-fugitive && fugitive-gitlab.vim
" -----
let g:fugitive_gitlab_domains = ['http://git.echo.com']


" -----
" Plugin: vim-search-pulse
" -----
" Only pulse on matched pattern, not the line
let g:vim_search_pulse_mode = 'pattern'

" Don't create mappings on |n| and |N|, we'll do it ourselves
let g:vim_search_pulse_disable_auto_mappings = 1

" TODO: Get these for console too
if has('gui_running')
  " Colors matching monokai
  " let g:vim_search_pulse_color_list = ["#F92672", "#A6E22E", "#AE81FF"]

  " Nova colors:
  " let g:terminal_color_0 = "#3C4C55"
  " let g:terminal_color_1 = "#DF8C8C"
  " let g:terminal_color_2 = "#A8CE93"
  " let g:terminal_color_3 = "#DADA93"
  " let g:terminal_color_4 = "#83AFE5"
  " let g:terminal_color_5 = "#9A93E1"
  " let g:terminal_color_6 = "#7FC1CA"
  " let g:terminal_color_7 = "#C5D4DD"
  " let g:terminal_color_8 = "#899BA6"
  " let g:terminal_color_9 = "#F2C38F"
  " let g:terminal_color_10 = "#A8CE93"
  " let g:terminal_color_11 = "#DADA93"
  " let g:terminal_color_12 = "#83AFE5"
  " let g:terminal_color_13 = "#D18EC2"
  " let g:terminal_color_14 = "#7FC1CA"
  " let g:terminal_color_15 = "#E6EEF3"

  " Colors matching nova
  let g:vim_search_pulse_color_list = ["#C5D4DD", "#7FC1CA", "#83AFE5", "#9A93E1", "#D18EC2"]
endif
" elseif InConEmuSession()
"   " Approximate nova colors From: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
"   " 225 is white/grey/pink, 44 is teal, 75 is blue, 171 is purple, 219 is red
"   let g:vim_search_pulse_color_list = [225, 44, 75, 171, 219]
" else
"   " TODO: Validate that these work for "generic console"
"   " I don't think it does!
"   " Approximate nova colors From: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
"   " 225 is white/grey/pink, 44 is teal, 75 is blue, 171 is purple, 219 is red
"   let g:vim_search_pulse_color_list = [225, 44, 75, 171, 219]
" endif

let g:vim_search_pulse_duration = 400

" Configure vim-search-pulse to work with incsearch.vim
augroup SearchPulseOnEnter
  au!

  " Pulses the first match after hitting the enter key
  autocmd User IncSearchExecute :call search_pulse#Pulse()
augroup END


" -----
" Plugin: incsearch.vim
" -----
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Automatically turn off hlsearch after cursor move
set hlsearch
let g:incsearch#auto_nohlsearch = 1

" We could use |n| in other mappings, this is a drop in replacement so don't noremap it
" Include the <Plug>Pulse to call vim-search-pulse as well
map n  <Plug>(incsearch-nohl-n)<Plug>Pulse
map N  <Plug>(incsearch-nohl-N)<Plug>Pulse
map *  <Plug>(incsearch-nohl-*)<Plug>Pulse
map #  <Plug>(incsearch-nohl-#)<Plug>Pulse
map g* <Plug>(incsearch-nohl-g*)<Plug>Pulse
map g# <Plug>(incsearch-nohl-g#)<Plug>Pulse

augroup NoHlOnInsert
  au!

  " Exit hlsearch when entering insert as well
  autocmd InsertEnter * :set nohlsearch

  " Reenable it so that future searchs do hlsearch
  autocmd InsertLeave * :set hlsearch
augroup END

" Tell incsearch that we're using 'magic' search
let g:incsearch#magic = '\m'

" Highlight matched pattern separately with forward matches and backward matches
let g:incsearch#separate_highlight = 1


" -----
" Plugin: vim-go
" -----
let g:go_fmt_command = "goimports"


" -----
" Plugin: vim-livedown
" -----
" To setup:
"   npm install -g livedown

" Should the markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0

" Should the browser window pop-up upon previewing
let g:livedown_open = 1

" Port to run Livedown on
let g:livedown_port = 3030


" -----
" Plugin: vim-markdown
" -----
" Note: These are for tpope/vim-markdown
" Enable syntax highlighting for fenced code blocks
" let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'shell=sh', 'css', 'sass', 'less',
"       \ 'zsh=sh', 'ruby', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript']

" Note: These are for gabrielelana/vim-markdown

" Disable default mappings (enabled by default with: 1)
let g:markdown_enable_mappings = 0

" Disable support for Jekyll files (enabled by default with: 1)
let g:markdown_include_jekyll_support = 0

" Disable the fold expression markdown#FoldLevelOfLine to fold markdown files. This
" is disabled by default because it's a huge performance hit even when folding is
" disabled with the nofoldenable option (disabled by default with: 0)
let g:markdown_enable_folding = 0

" Disable insert mode mappings (enabled by default with: 1)
let g:markdown_enable_insert_mode_mappings = 0

" Disable insert mode leader mappings (disabled by default with: 0)
let g:markdown_enable_insert_mode_leader_mappings = 0

" Enable spell checking (enabled by default with: 1)
let g:markdown_enable_spell_checking = 1

" Disable abbreviations for punctuation and emoticons (enabled by default with: 1)
let g:markdown_enable_input_abbreviations = 0

" Enable conceal for italic, bold, inline-code and link text (disabled by default with: 0)
let g:markdown_enable_conceal = 0

" vim-markdown screws up my formatting options
augroup FixMarkdownFormatOptions
  au!

  " We don't want to continue comments when pressing o/O
  autocmd Filetype markdown setlocal formatoptions-=o
  " Don't continue comments after pressing <Enter> in insert either
  autocmd Filetype markdown setlocal formatoptions-=r
augroup END


" -----
" Plugin: vim-gitgutter
" -----
" Extra commandline arguments for git diff
let g:gitgutter_diff_args = '-w'

nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk


" -----
" Plugin: auto-pairs
" TODO: Investigate http://vimawesome.com/plugin/auto-pairs-gentle for gentle patch example
" -----

if s:use_auto_pairs
  " Which pairs are included in AutoPairs behavior
    " Default:
    " let g:AutoPairs = {'(': ')', '[': ']', '{': '}',"'": "'",'"': '"', '`': '`'}

  " Set buffer level pairs
  " gu Filetype FILETYPE let b:AutoPairs = {"(": ")"}
    " Default:
    " let b:AutoPairs = g:AutoPairs

  " Toggle AutoPairs behavior
    " Default:
    " let g:AutoPairsShortcutToggle = '<M-p>'

  " Fast wrap the word, all pairs will be considered as a black (including `<>`)
    " TODO: How does this work? I can't seem to get it going
    "Default:
    " let g:AutoPairsShortcutFastWrap = '<M-e>'

  " Jump to the next closed pair
    " Default:
    " let g:AutoPairsShortcutJump = '<M-n>'

  " Map <BS> to delete brackets, quotes in pair
    " Default:
    " let g:AutoPairsMapBS = 1

  " Map <C-h> to delete brackets, quotes in pair
    " Default:
    " let g:AutoPairsMapCh = 1

  " Map <CR> to insert a new indented line if cursor in (|), {|} [|], '|', "|"
    " Default:
    " let g:AutoPairsMapCR = 1

  " When g:AutoPairsMapCR is on, center current line after return if the line is at the bottom 1/3 of the window.
    " Default:
    " let g:AutoPairsCenterLine = 1

  " Map <space> to insert a space after the opening character and before the closing one.
    " Default:
    " let g:AutoPairsMapSpace = 1

  " Fly mode will always force closed-pair jumping instead of inserting for ')', '}', and ']'
    " Default:
    " let g:AutoPairsFlyMode = 0

  " When you press the key for the closing pair (e.g. ')') it jumps past it.
  "   If set to 1, then it'll jump to the next line, if there is only whitespace.
  "   If set to 0, then it'll only jump to a closing pair on the same line.
  " let g:AutoPairsMultilineClose = 1

  " Works with FlyMode, insert the key at the Fly Mode jumped position
    " Default:
    " let g:AutoPairsShortcutBackInsert = '<M-b>'
endif


" -----
" Plugin: delimitmate
" -----

" if s:use_delimitmate
" endif

" Tell delimitMate which characters should be considered as quotes
" Default: "\" ' `"
let delimitMate_quotes = "\" '"


" -----
" Plugin: vim-togglecursor
" -----

" Default cursor in all modes except insert is block
let g:togglecursor_default = 'block'

" Cursor in insert mode should be a line
let g:togglecursor_insert = 'line'

" Set the cursor back to a line when exiting
let g:togglecursor_leave = 'line'


" -----
"  Key Maps
" see :help key-notation
" -----

" Set the leader key
let mapleader = ","

" Potentially unused keys:
" "\ <space> <bs> Z Q R S X _ !"
" also " - (my leader), H, L, <CR>"
" Keys waiting for a second key could also be used to start a mapping:
" "f t d c g z v y m ' [ ]"

" Takes a dictionary to map commands across multiple platforms
" Example:
"   call NormalMap({'windows': '<A-[>', 'mac': '<D-[>', 'wsl': '<A-[>', 'perform': ':wincmd W'})
function! NormalMap(keymap)
  " Check for keys that are hard to map generically and fail the mapping
  let invalid = 0
  for k in [a:keymap['windows'], a:keymap['mac'], a:keymap['wsl']]
    if k =~ '|' || k =~ "'" || k =~ '"'
      echo 'Unsupported key: ' . k . ' in: ' . string(a:keymap)
      let invalid=1
    endif
  endfor
  if invalid
    return 1
  endif

  " Use execute to evaluate a string as vimscript which allows us to build up the mapping per platform
  if g:os == 'mac'
    execute 'nnoremap <silent> ' . a:keymap['mac'] . ' ' . a:keymap['perform']
  elseif g:os == 'windows'
    execute 'nnoremap <silent> ' . a:keymap['windows'] . ' ' . a:keymap['perform']
  elseif g:os == 'wsl'
    execute 'nnoremap <silent> ' . a:keymap['wsl'] . ' ' . a:keymap['perform']
  elseif g:os == 'linux'
    echo "Couldn't map" . string(a:keymap) . " because we're not set up for generic Linux yet"
    return 1
  else
    echo "Couldn't map" . string(a:keymap) . " because we're on an unknown platform"
    return 1
  endif
endfunction


" -----
" General Key Maps
" -----

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
" TODO: Maybe not working on windows
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
" call NormalMap({'windows': '<A-j>', 'mac': '∆', 'wsl': '<A-j>', 'perform': ':set paste<CR>m`o<Esc>``:set nopaste<CR>j'})
call NormalMap({'windows': '<A-j>', 'mac': '<D-j>', 'wsl': '<A-j>', 'perform': ':set paste<CR>m`o<Esc>``:set nopaste<CR>j'})
" call NormalMap({'windows': '<A-k>', 'mac': '˚', 'wsl': '<A-k>', 'perform': ':set paste<CR>m`O<Esc>``:set nopaste<CR>k'})
call NormalMap({'windows': '<A-k>', 'mac': '<D-k>', 'wsl': '<A-k>', 'perform': ':set paste<CR>m`O<Esc>``:set nopaste<CR>k'})



" cd to the directory containing the file in th buffer
nnoremap <Leader>cd :lcd %:h

" Make the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
nnoremap <Leader>md :!mkdir -p %:p:h

" Copy last : command to clipboard
" See: |:help quote_:|
nnoremap <Leader>y: :let @+=@:<CR>

" Yank all
nnoremap <Leader>a :%y+<CR>

" Paste all
nnoremap <Leader>p ggVGp

" Quickly edit/reload the vimrc file
nnoremap <silent> <Leader>ve :e $MYVIMRC<CR>
nnoremap <silent> <Leader>vs :so $MYVIMRC<CR>

" Maximize window
" Note: Only works on windows
nnoremap <silent> <leader>mm :simalt ~x<CR>

"Highlight whitespaces
nnoremap <silent> <leader>hws :set list listchars=tab:>.,trail:.,extends:#,nbsp:.<CR>
nnoremap <silent> <Leader>nhws :set nolist<CR>

" Close all buffers except current
nnoremap <silent> <Leader>bo :BufOnly<CR>

" Close the current buffer, preserving the window
nnoremap <silent> <Leader>bd :call BetterBufferDelete()<CR>

function! BufferCount()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function! BetterBufferDelete()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1 && winnr("$") == 2 && BufferCount() == 1
    execute "bdelete" bufnr("%")
    quit
  else
    execute "Sayonara!"
  endif
endfunction

" Fix ^M line endings
nnoremap <silent> <Leader>le :s%/\r/\r/g<CR>

" Change all tab characters to two spaces
nnoremap <silent> <Leader>ts :%s/\t/  /g<CR>

" Fix smart quotes like this '“'

" TODO: Can I combine both smart quoting commands?
nnoremap <silent> <Leader>fss :%s/\(’\|‘\)/'/g<CR>
nnoremap <silent> <Leader>fsq :%s/\(“\|”\|“\|“\|”\)/"/g<CR>

" Fix smart hyphens
nnoremap <silent> <Leader>fs- :%s/–/-/g<CR>


" Insert a single character and go back to command mode
noremap S i<Space><Esc>r

" Xml formatting!
autocmd FileType xml noremap <buffer> <c-e><c-f> :silent %!xmllint % --format --recover<CR>

" Easier vertical splitting with '|'
nnoremap <silent> <Bar> :vsplit<CR>

" Easier horizontal splitting with '_'
nnoremap <silent> _ :split<CR>

" Cycle forwards through windows
call NormalMap({'windows': '<A-]>', 'mac': '<D-]>', 'wsl': '<A-]>', 'perform': ':wincmd w<CR>'})

" " Cycle backwards through windows
call NormalMap({'windows': '<A-[>', 'mac': '<D-[>', 'wsl': '<A-[>', 'perform': ':wincmd W<CR>'})

" Set the buffer to <Scratch>
" TODO: Consider calling this by default when we just open vim with no file specified
" TODO: Investigate
"       https://github.com/vim-scripts/scratch.vim/blob/master/plugin/scratch.vim
"       https://github.com/mtth/scratch.vim/blob/master/autoload/scratch.vim
nnoremap <silent> <Leader>sc :call OpenScratchBuffer()<CR>

function! OpenScratchBuffer()
  exe "edit <Scratch>"
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal nobuflisted
endfunction

" Like gJ, but always remove spaces
" With <3 from: http://vi.stackexchange.com/a/440/9963
function! JoinSpaceless()
  execute 'normal gJ'

  " Character under cursor is whitespace?
  if matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\s'
    " Then remove it!
    execute 'normal dw'
  endif
endfunction

" Join lines but always remove spaces
nnoremap <Leader>j :call JoinSpaceless()<CR>

" Opposite of <shift-J> is <shift-K>, join the line above to the current
"   Normally <s-k> runs a program to lookup keyword under cursor, annoying
"   Commands:
"     :.move -2<CR>  -- Swap the current line with the line above it
"     J              --  Run the normal <shift-J> logic
nnoremap <s-K> :.move -2<CR>J

" Duplicate current line below then comment out current line
nnoremap <silent> <Leader>cc Ypk:Commentary<CR>

" Close help window
nnoremap <silent> <Leader>hc :helpclose<CR>

" nnoremap <silent> <Leader>yp :let @"=expand("%:p")<CR>
" nnoremap <silent> <Leader>yn :let @"=expand("%")<CR>

" Source: https://vim.fandom.com/wiki/Copy_filename_to_clipboard
" Mnemonic: Yank (File) path
nnoremap <silent> <Leader>yp :let @*=expand("%:p")<CR>
" Mnemonic: yank File Name
nnoremap <silent> <Leader>yn :let @*=expand("%")<CR>
" TODO: Why the `*` vs `"` register? Windows seemed to work with `"` but mac required `*`.

" Issue:
"   - Open vim in ~/prj/notes
"   - Open with argument work-echo/emails/2021-06-13_usman-coaching-plan.md
"   - ,yp gives: work-echo/emails/2021-06-13_usman-coaching-plan.md
"   - ,yn gives: /Users/tscheffert/prj/notes/work-echo/emails/2021-06-13_usman-coaching-plan.md


" -----
" Line Width Stuff
" -----

" Source: https://vi.stackexchange.com/a/659/9963
" :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" https://www.vim.org/scripts/script.php?script_id=3238

" Source: https://vi.stackexchange.com/a/11610/9963
" function! ParagraphToEightyChars()
"   while (len(getline(".")) > 80)
"     normal! 0
"     " Find the first white-space character before the 81st character.
"     call search('\(\%81v.*\)\@<!\s\(.*\s.\{-}\%81v\)\@!', 'c', line('.'))
"     " Replace it with a new line.
"     exe "normal! r\<CR>"
"     " If the next line has words, join it to avoid weird paragraph breaks.
"     if (getline(line('.')+1) =~ '\w')
"       normal! J
"     endif
"   endwhile
"   " Trim any accidental trailing whitespace
"   :s/\s\+$//e
" endfunction
" nnoremap <silent><A-J> :call ParagraphToEightyChars()<CR>


" -----
" Macro Key Maps
" -----

" Insert a binding.pry
nnoremap <Leader>pr orequire 'pry'; binding.pry<Esc>


" -----
" Syntax Highlighting Utility Kemaps
" -----

" Return highlight group under cursor, if trans is zero it returns the "effective" group
function! SyntaxItem(trans)
  return synIDattr(synID(line("."), col("."), a:trans), "name")
endfunction

function! SyntaxStack()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction

nnoremap <Leader>sg :echo "Syntax Group:" SyntaxItem(1)<CR>
nnoremap <Leader>sh :echo "Syntax Group(trans=0):" SyntaxItem(0)<CR>
nnoremap <Leader>ss :call SyntaxStack()<CR>


" -----
" Nop Key maps
" -----

" cmd+p on MacVim opens the print preview thing which is annoying
nnoremap <D-p> <Nop>


" -----
" Override Default Behavior Key Maps
" -----

" Switch ; and :, so ; acts as the command leader
noremap ; :
noremap : ;

" Keep the mental mapping going and use ; as : for
"   command-line window too. See `:help cmdline-window`
nnoremap q; q:

" Deleting single character shouldn't squash the paste buffer
nnoremap <silent> x "_x
vnoremap <silent> x "_x

" Pasting in insert shouldn't squash the paste buffer
" TODO: Fix this
" vnoremap <silent> p "_xp

" Ex mode is horrible but repeating the last macro ran isn't
nnoremap Q @@


" -----
" Insert Mode Key Maps
" -----

" ctrl-'forward' jump to end of line
imap <c-f> <c-O>$
" Emacs 'jump to end of line' too
imap <c-e> <c-O>$

" ctrl-'back' jump to start of line
imap <c-b> <c-O>^
" Emacs 'jump to start of line' too
imap <c-a> <c-O>^


" -----
" Buffer Key Maps
" -----

augroup BufferLocalKeyMaps
  au!

  " q to exit the Cmdwin, behaving like other "temporary windows"
  autocmd CmdwinEnter * nnoremap <silent> <buffer> q :quit<CR>
augroup END


" -----
" Gundo Key Maps
" -----

" Mapping for Gundo
nnoremap <Leader>gu :GundoToggle<CR>

" Shut visualizer when a state is selected
let g:gundo_close_on_revert=1

" Move the layout to the right
let g:gundo_right=1


" -----
" JsBeautify Key Maps
" -----

augroup JsBeautifyKeyMaps
  au!

  " JsBeautify for Javascript
  autocmd FileType javascript noremap <buffer> <c-e><c-f> :call JsBeautify()<cr>
  autocmd FileType javascript vnoremap <buffer> <c-e><c-f> :call RangeJsBeautify()<cr>
  " for html
  autocmd FileType html noremap <buffer> <c-e><c-f> :call HtmlBeautify()<cr>
  autocmd FileType html vnoremap <buffer> <c-e><c-f> :call RangeHtmlBeautify()<cr>
  " for css or scss
  autocmd FileType css noremap <buffer> <c-e><c-f> :call CSSBeautify()<cr>
  autocmd FileType css vnoremap <buffer> <c-e><c-f> :call RangeCSSBeautify()<cr>
  " for less
  autocmd FileType less noremap <buffer> <c-e><c-f> :call CSSBeautify()<cr>

  " for json!
  autocmd FileType json noremap <buffer> <c-e><c-f> :%!python -m json.tool<cr>
augroup END

" TODO: Make this work for Windows
" autocmd FileType json noremap <buffer> <c-e><c-f> :call RubyJsonBeautify<cr>
" autocmd FileType json vnoremap <buffer> <c-e><c-f> :call RubyJsonBeautifyRange()<cr>

" function! RubyJsonBeautify(...)
" ruby << EORUBY
"   buffer = Vim::Buffer.current
"   buffer.append(buffer.line, "WHATS UP PARTY PEOPLE")
" EORUBY
" endfunction

" " @param {[Number|String]} a:0 Default value '1'
" " @param {[Number|String]} a:1 Default value '$'
" function! RubyJsonBeautifyRange() range
"   call RubyJsonBeautify(a:firstline, a:lastline)
" endfunction


" -----
" UltiSnips Key Maps and Settings
" -----

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Custom snippets directory
" When you specifiy only one directory then UltiSnips will not search
" the runtimepath, which is faster. It will search for Snipmate snippets on
" the runtimepath though.
if InWindowsSession()
  let g:UltiSnipsSnippetDirectories=[$HOME.'/vimfiles/UltiSnips']
else
  let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
endif

" Don't load snipmate snippets.
let g:UltiSnipsEnableSnipMate=0


" -----
" NERDTree Key Maps
" -----
nnoremap <leader>nt :NERDTreeToggle<CR>


" -----
" vim-livedown (for Markdown) Key Maps
" -----
augroup LivedownMarkdownKeyMaps
  au!

  autocmd FileType markdown nnoremap <Leader>ld :LivedownPreview<CR>
  autocmd FileType markdown nnoremap <Leader>lk :LivedownKill<CR>
augroup END


" -----
" EasyMotion Key Maps
" -----

" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Set the easy motion leader key to be - so it's activated with -
noremap - <Plug>(easymotion-prefix)

" Match and Jump two characters, both forwards and backwards
nmap <Space> <Plug>(easymotion-s2)

" Repeat the last motion
nmap <Leader><Space> <Plug>(easymotion-repeat)

"  From: http://www.robati.com/vim/2014/11/03/vimrc.html
" " EasyMotion
" nmap s <Plug>(easymotion-bd-w)
" nmap t <Plug>(easymotion-t2)
" map  / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)
" map  n <Plug>(easymotion-next)
" map  N <Plug>(easymotion-prev)
" map <Leader>l <Plug>(easymotion-lineforward)
" map <Leader>j <Plug>(easymotion-j)
" map <Leader>k <Plug>(easymotion-k)
" map <Leader>h <Plug>(easymotion-linebackward)
" let g:EasyMotion_startofline = 0      " keep cursor column when JK motion
" let g:EasyMotion_smartcase = 1        " type `l` and match `l`&`L`
" let g:EasyMotion_use_smartsign_us = 1 " type `3` and match `3`&`#`
