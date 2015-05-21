"----
" Startup
" -----

" Clear all autocommands
autocmd!

" Start with filetype off for plugin loading
filetype off

let s:use_neobundle = 1

if s:use_neobundle
    if has('vim_starting')
        " Required for NeoBundle
        set runtimepath +=~/.vim/bundle/neobundle.vim/
    endif

    " Required for NeoBundle
    call neobundle#begin(expand('~/.vim/bundle/'))

    " Let NeoBundle manage NeoBundle
    NeoBundleFetch 'Shougo/neobundle.vim'

    " My bundles:
    " Colors
    NeoBundle 'twerth/ir_black.git'
    NeoBundle 'vim-scripts/moria.git'
    NeoBundle 'vim-scripts/Color-Sampler-Pack.git'
    NeoBundle 'vim-scripts/ScrollColors.git'
    NeoBundle 'altercation/vim-colors-solarized.git'
    NeoBundle 'tomasr/molokai.git'
    NeoBundle 'nanotech/jellybeans.vim'

    " Search with ack easier
    NeoBundle 'mileszs/ack.vim.git'

    " Buffer management
    NeoBundle 'vim-scripts/BufOnly.vim.git'

    " File management
    NeoBundle 'kien/ctrlp.vim.git'
    NeoBundle 'scrooloose/nerdtree.git'
    NeoBundle 'Xuyuanp/nerdtree-git-plugin' " Show git marks in nerdtree
    NeoBundle 'low-ghost/nerdtree-fugitive' " Adds git menu to nerdtree
    " Forces nerdtree to open with each tab
    " NeoBundle 'jistr/vim-nerdtree-tabs.git'
    NeoBundle 'kopischke/vim-fetch' " Enable vim to open with line numbers appended

    " Auto parentheses
    NeoBundle 'Raimondi/delimitmate.git'

    " Improved Undo functionality
    NeoBundle 'sjl/gundo.vim.git'

    " Snippets
    NeoBundle 'SirVer/ultisnips.git'

    " Language specific
    NeoBundle 'jelera/vim-javascript-syntax.git'
    NeoBundle 'elzr/vim-json.git'
    NeoBundle 'groenewege/vim-less.git'
    NeoBundle 'maksimr/vim-jsbeautify.git'

    " Status bar
    NeoBundle 'bling/vim-airline.git'

    " Easier file movement
    NeoBundle 'Lokaltog/vim-easymotion.git'

    " tpope  rocks
    NeoBundle 'tpope/vim-commentary.git'
    NeoBundle 'tpope/vim-abolish.git'

    " Surrounding shit
    "   Given
    "       "Hello world!"
    "   press
    "       cs"'
    "   to change to
    "       'Hello world!'
    NeoBundle 'tpope/vim-surround.git'

    " If I ever do a lot of json stuff, apparently this is **must** have.
    " https://github.com/tpope/vim-jdaddy
    " NeoBundle 'tpope/vim-jdaddy'

    " Ruby stuff
    NeoBundle 'tpope/vim-rails'
    NeoBundle 'tpope/vim-bundler' " Works with vim-rails and vim-rake for bundler goodness
    NeoBundle 'tpope/vim-rake' " vim-rails (with vim-projectionist) for non rails projects
    NeoBundle 'tpope/vim-projectionist' " Project management for navigation n such
    NeoBundle 'tpope/vim-endwise' " Add matching 'end's for blocks
    NeoBundle 'vim-ruby/vim-ruby' " Ruby support stuff

    " Git!
    NeoBundle 'tpope/vim-fugitive' " Awesome git wrapper
    NeoBundle 'airblade/vim-gitgutter'

    " Syntax
    NeoBundle 'scrooloose/syntastic' " Easy syntax messages
    NeoBundle 'dbakker/vim-lint' " Linting for vim and vimL files.
    NeoBundle 'lilydjwg/colorizer' " Highlights hex codes with their colors

    " Improved searches
    NeoBundle 'inside/vim-search-pulse' " Pulse after searches
    NeoBundle 'haya14busa/incsearch.vim' " Show all matches as typed, auto nohl

    " Easy Alignment!
    NeoBundle 'godlygeek/tabular'

    "Multiple Curosrs!
    " NeoBundle 'terryma/vim-multiple-cursors'
    NeoBundle 'kana/vim-niceblock' " make |v_b_I| and |v_b_A| available in all visual modes

    " Better Text Objects
    NeoBundle 'wellle/targets.vim'

    " Considering!
    " NeoBundle 'tpope/vim-repeat' " Wrap stuff for . command
    " NeoBundle 'AndrewRadev/splitjoin.vim' " Works with ruby to swap single liners into multi lines
    " https://github.com/chrisbra/vim-diff-enhanced " Improved diff's using histogram and patience algorithms

    call neobundle#end()

    " If there are uninstalled bundles found on startup,
    " this will conveniently prompt you to install them.
    NeoBundleCheck

    if !has('vim_starting')
        " Call on_source hook when reloading .vimrc
        call neobundle#call_hook('on_source')
    endif
endif

" Forget being compatible with good ol' vi
set nocompatible

" Get that filetype stuff happening
filetype on

" Syntax and indent by filetype
filetype plugin on
filetype indent on
filetype plugin indent on

" Turn on that syntax highlighting
syntax on

" Restore cursor position from last time you editted the file
augroup line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
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

" Use lots of undo levels
set undolevels=1000

" Number of lines to save for undo
set undoreload=10000

" Save undo's after file closes
"set undofile
" Set where to save undo histories
" Fancy undo file location. The trailing '//' makes a unique path by using the
" full path of the original file.
set undodir=~/vimfiles/tmp/undo//
set backupdir=~/vimfiles/tmp/backup// " Backups
set directory=~/vimfiles/tmp/swap//   " Swap Files
set backup                        " Enable backups
set noswapfile                    " No More Collisions!

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" Show filename in titlebar of window
set title

" Don't set the title to something weird when we're saving/closing
set titleold=

" Always reload buffer when external chagnes detected
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
noremap <right> <ESC>:bn<return>
noremap <left> <ESC>:bp<return>


" -----
" TABS and Whitespace
" -----

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set softtabstop=4
set tabstop=4

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
" File Specific Display stuff like tabs
" -----

augroup CoffeeScriptFiles
    au!
    " File specific tabs, Do not think this works
    au FileType coffee set noexpandtab

    " Fold by indentation in CoffeeScript
    au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
augroup END

augroup XmlFiles
    au!

    let g:xml_syntax_folding=1
    au FileType xml setlocal foldmethod=syntax
augroup END

augroup RubyFiles
    au!
    autocmd Filetype ruby setlocal shiftwidth=2
    autocmd Filetype ruby setlocal softtabstop=2
    autocmd Filetype ruby setlocal tabstop=2
    autocmd Filetype eruby setlocal shiftwidth=2
    autocmd Filetype eruby setlocal softtabstop=2
    autocmd Filetype eruby setlocal tabstop=2

augroup END

augroup RSpecFiles
    au!
    " rails-vim doesn't correctly assign buffer types for all of the files, manually do some of it
    autocmd BufNewFile,BufRead *_spec.rb syntax keyword rubyRailsTestMethod describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let expect it to be eq
augroup END

augroup YAMLFiles
    au!

    autocmd Filetype yaml setlocal shiftwidth=2
    autocmd Filetype yaml setlocal softtabstop=2
    autocmd Filetype yaml setlocal tabstop=2
augroup END

augroup VimFiles
    au!

    " Vim's built in file type stuff doesn't like to respect my settings!
    autocmd Filetype vim setlocal textwidth=0
augroup END

" -----
" Typing Behaviors
" -----

" Use english for spellchecking, but don't spellcheck by default
if version >= 700
    set spl=en spell
    set nospell
endif

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


" -----
" Movement
" -----
" Don't move cursor to start of line when using certain movement commands like
" "<c-d>" or "gg"
set nostartofline

" Don't include _ as a character for movements like 'w', 'b', 'e', '*', etc.
" Defaults are: iskeyword=@,48-57,_,192-255
" This screws up syntax highlighting and stuff
" set iskeyword-=_


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

" Colors!
if has('gui_running')
    set background=dark
    colorscheme molokai
    let g:airline_theme='molokai'
    " Remove the gui from GVim
    :set guioptions-=m " Remove menu bar
    :set guioptions-=T " Remove the toolbar
    :set guioptions-=r " Remove the right-hand scroll bar
    :set guioptions-=L " Remove the left-hand scroll bar...bar[]

    " Set the default font to Source Code Pro (with escaped spaces) which I
    " use everywhere!
    " set guifont=Source\ Code\ Pro\ for\ Powerline:h12
    set guifont=Source\ Code\ Pro:h12 " Not using the powerline symbols for now
    " Set the default font to Consolas (Which is what Visual Studio uses)
    " set guifont=Consolas:h11:cANSI

    " Windows Specific stuff
   if has('win32')
        " Set vim to be maximized on opening
        au GUIEnter * simalt ~x
        " Stuff here
        " elseif
    endif
" ConEmu specific
elseif has('win32') && !has('gui_running') && !empty($CONEMUBUILD)
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set background=dark
    colorscheme jellybeans
    let g:airline_theme='jellybeans'
" Everything else
else
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set background=dark
    colorscheme jellybeans
    let g:airline_theme='jellybeans'
endif

" Long lines make syntax highlighting slow
set synmaxcol=2048

" When the page starts to scroll, keep the cursor 8 lines from
" the top and 8 lines from the bottom
set scrolloff=8

" Keep some columns visible when horizontally scrolling
set sidescroll=1
set sidescroll=8

" Set off the other paren by FLASHING
highlight MatchParen ctermbg=4

set showmatch mat=6 " show matching parens for 600ms

" Shows report when any ammount of lines are changed (read always)
set report=0

" Shorten messages and don't show intro
set shortmess=atI

" Open new split panes to the right and bottom, feels a lot more natural
set splitbelow
set splitright

" Using the mouse in the terminal
if has('mouse')
    set mouse=a
    if has('mouse_sgr') || v:version > 703 ||
                \ v:version == 703 && has('patch632')
        " Ideal mouse setting, backwards compatible with xterm and xterm2
        set ttymouse=sgr
    else
        " Fallback
        set ttymouse=xterm2
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
" Plugin settings
" -----

" Disable vim-json conceal settings
let g:vim_json_syntax_conceal = 0

" Set the easy motion leader key to be - so it's activated with -
map - <Plug>(easymotion-prefix)

" Using easy motion show all the places where two characters appear, both fwds
" and bwds
map <SPACE> <Plug>(easymotion-s2)


" -----
" Plugin: Airline
" -----

" Automatically displays all buffers when theres only one tab open
let g:airline#extensions#tabline#enabled = 1

" Ensure symbols dictionary exists
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Set custom symbols
let g:airline_left_sep = '►'
let g:airline_right_sep = '◄'

" Set up status line
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_y=' [%n] '
let g:airline_section_z='%3p%% : %3l/%-3L :%4c '
let g:airline#extensions#default#layout = [
            \ [ 'a', 'c' ],
            \ [ 'x', 'y', 'z', 'warning' ]
            \ ]

" Disable paste detection
let g:airline_detect_paste=1


" -----
" Plugin: Ctrl-p
" -----

" Ignore stuff
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](\.git|\.hg|\.svn|_site)$',
    \ }

" Don't ignore hidden files
let g:ctrlp_show_hidden = 1

" Don't ignore symlinks
let g:ctrlp_follow_symlinks = 0

" Where to do ctrlp caching
let g:ctrlp_cache_dir = $HOME.'/vimfiles/tmp/ctrlp/cache'

" Jump to buffer in the same tab if already open
let g:ctrlp_switch_buffer = 1


" -----
" Plugin: Syntastic
" -----
" Default settings sill
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Always put errors into the location list
let g:syntastic_always_populate_loc_list = 1
" Open the location list when errors are found
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


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
" Plugin: vim-search-pulse
" -----
" Only pulse on matched pattern, not the line
let g:vim_search_pulse_mode = 'pattern'

" Don't create mappings on |n| and |N|, we'll do it ourselves
let g:vim_search_pulse_disable_auto_mappings = 1

let g:vim_search_pulse_color_list = ["#F92672", "#A6E22E", "#AE81FF"]
let g:vim_search_pulse_duration = 400

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

" Exit hlsearch when entering insert as well
" TODO: Fix this
" au InsertEnter * :set nohlsearch

" Tell incsearch that we're using 'magic' search
let g:incsearch#magic = '\m'

" Highlight matched pattern separately with forward matches and backward matches
let g:incsearch#separate_highlight = 1


" -----
"  Key Maps
" -----

" Set the leader key
let mapleader = ","

" Potentially unused keys:
" "\ <space> <bs> Z Q R S X _ !"
" also " - (my leader), H, L, <CR>"
" Keys waiting for a second key could also be used to start a mapping:
" "f t d c g z v y m ' [ ]"


" -----
" General Key Maps
" -----

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
if has("mac")
    nnoremap <silent>∆ :set paste<CR>m`o<Esc>``:set nopaste<CR>j
    nnoremap <silent>˚ :set paste<CR>m`O<Esc>``:set nopaste<CR>k
else
    nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>j
    nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>k
endif

" cd to the directory containing the file in th buffer
nnoremap <Leader>cd :lcd %:h

" Make the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
nnoremap <Leader>md :!mkdir -p %:p:h

" Yank all
nnoremap <Leader>a :%y+<CR>

" Quickly edit/reload the vimrc file
nnoremap <silent> <Leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <Leader>sv :so $MYVIMRC<CR>

" Maximize window
" Note: Only works on windows
nnoremap <silent> <leader>mm :simalt ~x<CR>

"Highlight whitespaces
nnoremap <silent> <leader>hws :set list listchars=tab:>.,trail:.,extends:#,nbsp:.<CR>
nnoremap <silent> <Leader>nhws :set nolist<CR>

" Close all buffers except current
nnoremap <silent> <Leader>bd :BufOnly<CR>

" Fix ^M line endings
nnoremap <silent> <Leader>le :s%/\r/\r/g<CR>

" Insert a single character and go back to command mode
noremap S i<Space><Esc>r

" Xml formatting!
autocmd FileType xml noremap <buffer> <c-e><c-f> :silent %!xmllint % --format --recover<CR>


" -----
" Syntax Highlighting Utility Kemaps
" -----

" Return highlight group under cursor, if trans is zero it returns the "effective" group
function! SyntaxItem(trans)
    return synIDattr(synID(line("."), col("."), a:trans), "name")
endfunction

nnoremap <Leader>sg :echo "Syntax Group:" SyntaxItem(1)<CR>
nnoremap <Leader>sh :echo "Syntax Group(trans=0):" SyntaxItem(0)<CR>


" -----
" Override Default Behavior Key Maps
" -----

" Switch ; and :, so ; acts as the command leader
noremap ; :
noremap : ;

" Keep the mental mapping going and use ; as : for
"   ommand-line window too. See `:help cmdline-window`
nnoremap q; q:

" Deleting single character shouldn't squash the paste buffer
nnoremap <silent> x "_x
vnoremap <silent> x "_x


" -----
" Insert Mode Keybinds
" -----

" ctrl-'forward' jump to end of line
imap <c-f> <c-O>$
" ctrl-'back' jump to start of line
imap <c-b> <c-O>^


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

" JsBeautify
map <c-e><c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer> <c-e><c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-e><c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-e><c-f> :call CSSBeautify()<cr>
" for less
autocmd FileType less noremap <buffer> <c-e><c-f> :call CSSBeautify()<cr>
" for json!
autocmd FileType json noremap <buffer> <c-e><c-f> :%!python -m json.tool<cr>
" do it by range in visual mode
autocmd FileType javascript vnoremap <buffer> <c-e><c-f> :call RangeJsBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-e><c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-e><c-f> :call RangeCSSBeautify()<cr>


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
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

" Don't load snipmate snippets.
let g:UltiSnipsEnableSnipMate=0


" -----
" NERDTree Key Maps
" -----
nnoremap <leader>nt :NERDTreeToggle<CR>


" -----
" EasyMotion Key Maps
" -----
"  From: http://www.robati.com/vim/2014/11/03/vimrc.html
" " EasyMotion
" let g:EasyMotion_do_mapping = 0       " Disable default mappings
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
