" This plugin helps switch the syntax of ruby hash lines
" TODO: Get the mappings set up in plugin/rubyhash.vim instead of .vimrc and here

" Test lines
"   Before:
"     'string_key'     => 'text in the string'
"   After:
"     string_key:     'text in the string'
"   Before:
"     'long_int_key'   => 99123,
"   After:
"     long_int_key:   99123,
"   Before:
"     'expression_key' => CallModule::ForValue.get(arg: 123)
"   After:
"     expression_key: CallModule::ForValue.get(arg: 123)
"   Before:
      "double_quote_key" => value
"   After:
"     double_quote_key: value
"   Before:
"     'Str1ng Th4t Can't be a symb0l3' => 'value'
"   After:
"     'Str1ng Th4t Can't be a symb0l3' => 'value'
function! rubyhash#ToSymbolKeysLinewise()
  call rubyhash#SearchAndReplaceCurrentLine("['\"]\\([a-z_]\\+\\)['\"]\\(\\s\\+\\)=> \\(.\\+\\)$", "\\1:\\2\\3" )
  silent! call repeat#set("\<Plug>RubyHashConvertToSymbol", -1)
endfunction

nnoremap <silent> <Plug>RubyHashConvertToSymbol :call rubyhash#ToSymbolKeysLinewise()<CR>

" Test lines
"   Before:
"     string_key:     'text in the string'
"   After:
"     'string_key'     => 'text in the string'
"   Before:
"     long_int_key:   99123,
"   After:
"     'long_int_key'   => 99123,
"   Before:
"     expression_key: CallModule::ForValue.get(arg: 123)
"   After:
"     'expression_key' => CallModule::ForValue.get(arg: 123)
function! rubyhash#ToStringKeysLinewise()
  call rubyhash#SearchAndReplaceCurrentLine("\\(\\w\\+\\):\\(\\s\\+\\)\\(.\\+\\)$", "'\\1'\\2=> \\3" )
  silent! call repeat#set("\<Plug>RubyHashConvertToString", -1)
endfunction

nnoremap <silent> <Plug>RubyHashConvertToString :call rubyhash#ToStringKeysLinewise()<CR>

function! rubyhash#SearchAndReplaceCurrentLine(search, replace)

  let line_number = line(".")
  let old_contents = getline(".")

  let new_contents = substitute(old_contents, a:search, a:replace, "g")

  " Only setline if we need to, keep undo history clean
  if new_contents !=# old_contents
    " Save cursor position
    let l:cursor_save = winsaveview()

    call setline(line_number, new_contents)

    " Restore cursor position
    call winrestview(l:cursor_save)
  endif
endfunction
