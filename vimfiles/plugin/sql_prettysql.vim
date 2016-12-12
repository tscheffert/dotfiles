" Set up commands and keybinds for prettysql plugin

vnoremap <silent> <buffer> <C-e><C-f> :FormatSQL<CR>
nnoremap <silent> <buffer> <C-e><C-f> :FormatSQL<CR>
command -range=% FormatSQL :call prettysql#FormatSQL(<line1>, <line2>)
