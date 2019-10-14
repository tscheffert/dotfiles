# Dotfiles Reviews

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

## Zsh Prompt

Review this further: <https://github.com/sindresorhus/pure/blob/master/pure.zsh>

## TODO

### Vim

- Function to "unsmarten" quotes, probably by straight replacing them
