# dotfiles Ideas and TODO

## TO Review

- <https://github.com/habamax/.vim>
  - Lots of crazy vim stuff

## <https://github.com/tmc/dotfiles/blob/master/.vimrc>

```
silent !test -d ~/.vimrc/.swp || mkdir -p ~/.vim/.{undo,backup,swp}
```

```
Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
```

```
Plug 'mbbill/undotree'
Plug 'Shougo/vinarise.vim'
Plug 'chrisjohnson/vim-grep'

Plug 'lifepillar/vim-mucomplete'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'

Plug 'dbeniamine/cheat.sh-vim'
Plug 'kana/vim-textobj-user'
Plug 'natebosch/vim-lsc'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'somini/vim-textobj-fold'
Plug 'whiteinge/diffconflicts'
Plug 'tmc/vimscripts', { 'rtp': 'git-backups', 'as': 'tmc-git-backups' }
Plug 'tmc/vimscripts', { 'rtp': 'mucomplete-neosnippet', 'as': 'tmc-mucomplete-neosnippet' }
Plug 'w0rp/ale'

Plug 'rhysd/vim-grammarous'
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown'
Plug 'vadv/vim-chef'
```

```
" ctrlp
" also search buffers/tabs
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
\ }
```

```
" mu
nnoremap <leader>m :MUcompleteAutoToggle<CR>
let g:mucomplete#delayed_completion = 1

let g:mucomplete#enable_auto_at_startup = 1
```

## TODO Vim
- Better f, with jumping to next following `f{character}` - <https://github.com/rhysd/clever-f.vim>
- Switch to [vim-polyglot](https://github.com/sheerun/vim-polyglot) instead of the litany of stuff I have already
- Better notes strategy
  - Prefix markdown files with header from file name?
  - [vim-notes plugin investigation](https://github.com/will-ockmore/vim-notes)
- Show bars at indent levels <https://github.com/Yggdroot/indentLine>
- Fancy popup for keys being shown <https://github.com/liuchengxu/vim-which-key>
- Compare with vim-sensible: <https://github.com/liuchengxu/vim-better-default>
- Popup thing? <https://github.com/liuchengxu/vim-clap>
- Replacement for NerdTree? <https://github.com/lambdalisue/fern.vim>


## Zsh Prompt

Review this further: <https://github.com/sindresorhus/pure/blob/master/pure.zsh>

## TODO

### Firefox

- Get that shit IaC

### Vim

- Function to "unsmarten" quotes, probably by straight replacing them
- Get the UltiSnips Ruby snippet for `def self.` to ignore parameters
- Consider using this: <https://github.com/sheerun/vim-polyglot>

### Bin

- `cut_black` improvements
  - Use FFPRobe to make sure everything is okay with the header
  - Use FFMPEG to check for errors:
  - `ffmpeg -v error -i $FILENAME -f null -`
- Get the bootstrapping links to enumerate files in `.dotfiles/bin` and link them file by file into `~/bin` rather than just linking the whole directory.
  - Allows linking from other places to there.
  - Would have to link the subfolders to `~/bin` though, which seems okay

- Replace `which` usage in ruby scripts with: <https://github.com/piotrmurach/tty-which>
  - I'm pretty sure they're using `tty-command` to run `which` anyways...

### Zsh

- Change `zsh/windows` to be unique per PC, I don't have the same utilities installed on every PC in the same way

### PowerShell

- Get Custom hotkeys like ctrl+u clearing line
- Make profile PSReadline aware
  - Are we using it? (Yes I think so?)
  - Set the history file path somewhere better

### Tools

- Start using `git-lint`: <https://www.alchemists.io/projects/git-lint/>
