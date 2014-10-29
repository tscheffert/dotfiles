"----
" Startup
" -----

" Clear all autocommands
autocmd!

" Start Pathogen
execute pathogen#infect()
execute pathogen#helptags()

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

" function! ResCur()
"     if line("'\"") <= line("$")
"         normal! g`"
"         return 1
"     endif
" endfunction
" augroup resCur
"     autocmd!
"     autocmd BufWinEnter * call ResCur()
" augroup END


" -----
" Vim Preferences
" -----

" Keep all of the temporary and backup files in one place
" set backupdir=~/vimfiles/backup
" set directory=~/vimfiles/tmp

" Why is this not a default
set hidden

" Show what you are typing as a command
set showcmd

" Keep some stuff in the history
set history=1000

" Use lots of undo levels
set undolevels=1000

" Number of lines to save for undo
set undoreload=10000

" Save undo's after file closes
"set undofile
" Set where to save undo histories
set undodir=~/vimfiles/tmp/undo//     " Fancy undo file location. The trailing '//' makes the files saved be path unique
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


" Don't stop and say 'more' for long files
"set nomore

" Show filename in titlebar of window
set title

" Don't set the title to something weird when we're saving/closing
set titleold=

" Always reload buffer when external chagnes detected
set autoread

" Last window always has a statusline
set laststatus=2

" Reload .vimrc when we see it get written!
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC " | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Only care about base 10 digits, not octal or hex
set nrformats=


" -----
" Window/Buffers/Tabs
" -----

" NOTE: This would be great but NerdTree fucks with it :*(
" TODO: Fix this
" Show help files in a new tab
" Only apply to .txt files...
"augroup HelpInTabs
"    autocmd!
"    autocmd BufEnter  *.txt   call HelpInNewTab()
"augroup END

"Only apply to help files...
"function! HelpInNewTab ()
"    if &buftype == 'help'
"        "Convert the help window to a tab...
"        execute "normal \<C-W>T"
"    endif
"endfunction

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

    " Resize splits when the window is resized
    autocmd VimResized * exe "normal! \<c-w>="
augroup END

" Fix indents when linewrap is on
set breakindent


" -----
" File Specific Display stuff like tabs
" -----

" File specific tabs, Do not think this works
au FileType coffee set noexpandtab

" Fold by indentation in CoffeeScript
au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable


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
set wildignore+=*.sw?                           " Vim swap files
set wildignore+=*.gitignore,*.sln,.hg,.git      " Version Control
set wildignore+=*.pyc                           " Python byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " Compiled objects
set wildignore+=*.DS_Store                      " OSX Sucks
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png  " Binary images

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


" -----
" Movement
" -----
" Don't move cursor to start of line when using certain movement commands like
" "<c-d>" or "gg"
set nostartofline


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
    " Set the default font to Consolas (Which is what Visual Studio uses)
    set guifont=Consolas:h11:cANSI
    set background=dark
    colorscheme molokai
    let g:airline_theme='molokai'

    " Set vim to be maximized on opening
    au GUIEnter * simalt ~x

    " Remove the gui from GVim
    :set guioptions-=m " Remove menu bar
    :set guioptions-=T " Remove the toolbar
    :set guioptions-=r " Remove the right-hand scroll bar
    :set guioptions-=L " Remove the left-hand scroll bar...bar[]
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

" Set the easy motion leader key to be ' so it's activated with '
map - <Plug>(easymotion-prefix)

" Using easy motion show all the places where two characters appear, both fwds
" and bwds
map <SPACE> <Plug>(easymotion-s2)

" Set up the Ack path
" NOTE: Unsure if this works still
let g:ackprg="C:\\strawberryPerl\\perl\\bin\\ack.pl -H --nocolor --nogroup --column"


" -----
" Airline
" -----

" Automatically displays all buffers when theres only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_y=' [%n] '
let g:airline_section_z='%3p%% : %3l/%-3L :%4c '
let g:airline#extensions#default#layout = [
            \ [ 'a', 'c' ],
            \ [ 'x', 'y', 'z', 'warning' ]
            \ ]


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


" ---
"  Key Binds!
" ---

" Set the leader key
let mapleader = ","

" Potentially unused keys:
" "\ <space> <bs> Z Q R S X _ !"
" also " - (my leader), H, L, <CR>"
" Keys waiting for a second key could also be used to start a mapping:
" "f t d c g z v y m ' [ ]"

" -----
" Gundo Key Binds
" -----

" Mapping for Gundo
nnoremap <Leader>gu :GundoToggle<CR>

" Shut visualizer when a state is selected
let g:gundo_close_on_revert=1

" Move the layout to the right
let g:gundo_right=1


" -----
" JsBeautify Key Binds
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
" UltiSnips Key Binds
" -----

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" -----
" General Key Binds
" -----

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>j
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>k

"" Don't hlsearch, but when I do search for something set hlsearch, then
"" remove it when entering insert mode
set nohlsearch
noremap / :set hlsearch<CR>/
au InsertEnter * :set nohlsearch

" n and N turn on hlsearch too
noremap n :set hlsearch<CR>nzzzv
noremap N :set hlsearch<CR>Nzzzv

" Quickly open a scratch buffer
map <leader>qs :e ~/buffer<cr>

" cd to the directory containing the file in th buffer
nnoremap <Leader>cd :lcd %:h

" Make the directory that contains the file in the current buffer.
" This is useful when you edit a file in a directory that doesn't
" (yet) exist
nnoremap <Leader>md :!mkdir -p %:p:h

" Compile the coffeescript
nnoremap <Leader>cc :CoffeeCompile<cr>

" Switch ; and : so ; acts as the command leader
noremap ; :
noremap : ;
nnoremap q; q:

nnoremap <Leader>a :%y+<CR>

"TAB navigation like firefox
"nnoremap <C-S-tab> :tabprevious<cr>
"nnoremap <C-tab> :tabnext<cr>
"nnoremap <C-t> :tabnew<cr>

"inoremap <C-S-tab> <ESC>:tabprevious<cr>i
"inoremap <C-tab> <ESC>:tabnext<cr>i
"inoremap <C-t> <ESC>:tabnew<cr>i

" Quickly edit/reload the vimrc file
nnoremap <silent> <Leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <Leader>so :so $MYVIMRC<CR>
nnoremap <silent> <leader>mm :simalt ~x<CR>

"Highlight whitespaces
nnoremap <silent> <leader>st :set list listchars=tab:>.,trail:.,extends:#,nbsp:.<CR>
nnoremap <silent> <Leader>dt :set nolist<CR>

" Close all buffers except current
nnoremap <silent> <Leader>bd :BufOnly<CR>

" Fix ^M line endings
nnoremap <silent> <Leader>le :s%/\r/\r/g<CR>

" Insert a single character and go back to command mode
noremap S i<Space><Esc>r

" <F10> will echo the syntax group for the word under mouse
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
        \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>


" -----
" Insert Mode Keybinds
" -----

" ctrl-'forward' jump to end of line
imap <c-f> <c-O>$
" ctrl-'back' jump to start of line
imap <c-b> <c-O>^

