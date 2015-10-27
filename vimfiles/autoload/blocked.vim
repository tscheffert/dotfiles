" Almost entirely from: https://github.com/AndrewRadev/splitjoin.vim
"   Modified to let you RubyJoinBlock from anywhere in the block, rather than only on the 'do'
" Also code from vim-blockle

" ----- Exposed

" Verbatim from splitjoin
" With cursor on 'do' change the block to '{ ... }' on one line
function! blocked#DoEndToBrackets()
  let do_pattern = '\<do\>\(\s*|.*|\s*\)\?$'

  " Search forwards for 'do' (on this line)
  let do_line_no = search(do_pattern, 'cW', line('.'))

  if do_line_no <= 0
    " Search backwards for 'do' (on this line)
    let do_line_no = search(do_pattern, 'bcW', line('.'))
  endif

  call s:PushCursor()

  if do_line_no <= 0
    " If we're in a word, then go to the beginning of it before searching, similar to a 'b' motion
    call s:PushCursor()
    let current_word = expand('<cword>')
    norm b
    if current_word != expand('<cword>')
      " We weren't in a word, go back to where we were
      call s:PopCursor()
    else
      call s:DropCursor()
    endif

    let curr_line_no = line('.')

    " Search backwards for the 'do' in a do...end pair
    let do_line_no = searchpair(do_pattern, '', '\<end\>', 'bW')
  endif

  if do_line_no <= 0
    echo "Couldn't find a do...end block"
    call s:PopCursor()
    return 0
  endif

  " Search for `end`, leave the cursor on it
  " call searchpair('\<do\>\(\s*|.*|\s*\)\?$', '', '\<end\>', 'W')
  "     if called on an `end` then it goes to the next end!
  let end_line_no = searchpair(do_pattern, '', '\<end\>', 'W')

  let do_distance = end_line_no - do_line_no

  if do_distance > 5
    call s:PopCursor()
    echo 'do_distance too far, exiting'
    " Don't search farther than 5 lines to find a do
    return 0
  endif

  call s:DropCursor()

  let [result, offset] = s:HandleComments(do_line_no, end_line_no)
  if !result
    return 1
  endif
  let do_line_no += offset
  let end_line_no += offset

  let lines = s:GetLines(do_line_no, end_line_no)
  let lines = s:TrimList(lines)
  let lines = s:CompactLines(lines)

  let do_line  = substitute(lines[0], do_pattern, '{\1', '')
  let body     = join(lines[1:-2], '; ')
  let body     = s:Trim(body)
  let end_line = substitute(lines[-1], 'end', '}', '')

  let replacement = do_line.' '.body.' '.end_line

  " shorthand to_proc if possible
  let replacement = substitute(replacement, '\s*{ |\(\k\+\)| \1\.\(\k\+[!?]\=\) }$', '(\&:\2)', '')

  call s:ReplaceLines(do_line_no, end_line_no, replacement)

  return 1
endfunction

" Verbatim from splitjoin
" With cursor on '{', '}', or in-between, change the block to 'do ... end' on multiple lines
function! blocked#BracketsToDoEnd()
  let pattern = '\v\{(\s*\|.{-}\|)?\s*(.*)\s*\}'

  if s:SearchUnderCursor('\v%(\k|!|\-\>|\?|\))\s*\zs'.pattern) <= 0
    return 0
  endif

  let start = col('.')
  normal! %
  let end = col('.')

  if start == end
    " the cursor hasn't moved, bail out
    return 0
  endif

  let body = s:GetMotion('Va{')
  let multiline_block = 'do\1\n\2\nend'

  normal! %
  if search('\S\%#', 'Wbn')
    let multiline_block = ' '.multiline_block
  endif

  let body = join(split(body, '\s*;\s*'), "\n")
  let replacement = substitute(body, '^'.pattern.'$', multiline_block, '')
  " remove leftover whitespace
  let replacement = substitute(replacement, '\s*\n', '\n', 'g')

  call s:ReplaceMotion('Va{', replacement)

  return 1
endfunction



" ----- Universal Helpers

" Surprisingly, Vim doesn't seem to have a "trim" function. In any case, these
" should be fairly obvious.
function! s:Ltrim(s)
  return substitute(a:s, '^\_s\+', '', '')
endfunction
function! s:Rtrim(s)
  return substitute(a:s, '\_s\+$', '', '')
endfunction
function! s:Trim(s)
  return s:Rtrim(s:Ltrim(a:s))
endfunction

" Execute s:Trim on each item of a List
function! s:TrimList(list)
  return map(a:list, 's:Trim(v:val)')
endfunction

" Adds the current cursor position to the cursor stack.
function! s:PushCursor()
  if !exists('b:cursor_position_stack')
    let b:cursor_position_stack = []
  endif

  call add(b:cursor_position_stack, getpos('.'))
endfunction

" Restores the cursor to the latest position in the cursor stack, as added
" from the s:PushCursor function. Removes the position from the stack.
function! s:PopCursor()
  call setpos('.', remove(b:cursor_position_stack, -1))
endfunction

" Discards the last saved cursor position from the cursor stack.
" Note that if the cursor hasn't been saved at all, this will raise an error.
function! s:DropCursor()
  call remove(b:cursor_position_stack, -1)
endfunction

" Replace the normal mode "motion" with "text". This is mostly just a wrapper
" for a normal! command with a paste, but doesn't pollute any registers.
"
"   Examples:
"     call s:ReplaceMotion('Va{', 'some text')
"     call s:ReplaceMotion('V', 'replacement line')
"
" Note that the motion needs to include a visual mode key, like "V", "v" or
" "gv"
function! s:ReplaceMotion(motion, text)
  " reset clipboard to avoid problems with 'unnamed' and 'autoselect'
  let saved_clipboard = &clipboard
  set clipboard=

  let saved_register_text = getreg('"', 1)
  let saved_register_type = getregtype('"')

  call setreg('"', a:text, 'v')
  exec 'silent normal! '.a:motion.'p'
  silent normal! gv=

  call setreg('"', saved_register_text, saved_register_type)
  let &clipboard = saved_clipboard
endfunction

" function! s:ReplaceLines(start, end, text) {{{2
"
" Replace the area defined by the 'start' and 'end' lines with 'text'.
function! s:ReplaceLines(start, end, text)
  let interval = a:end - a:start

  return s:ReplaceMotion(a:start.'GV'.interval.'j', a:text)
endfunction

" Searches for a match for the given pattern under the cursor. Returns the
" result of the |search()| call if a match was found, 0 otherwise.
"
" Moves the cursor unless the 'n' flag is given.
"
" The a:flags parameter can include one of "e", "p", "s", "n", which work the
" same way as the built-in |search()| call. Any other flags will be ignored.
"
function! s:SearchUnderCursor(pattern, ...)
  let [match_start, match_end] = call('s:SearchposUnderCursor', [a:pattern] + a:000)
  if match_start > 0
    return match_start
  else
    return 0
  endif
endfunction

" Searches for a match for the given pattern under the cursor. Returns the
" start and (end + 1) column positions of the match. If nothing was found,
" returns [0, 0].
"
" Moves the cursor unless the 'n' flag is given.
"
" Respects the skip expression if it's given.
"
" See s:SearchUnderCursor for the behaviour of a:flags
"
function! s:SearchposUnderCursor(pattern, ...)
  if a:0 >= 1
    let given_flags = a:1
  else
    let given_flags = ''
  endif

  if a:0 >= 2
    let skip = a:2
  else
    let skip = ''
  endif

  let lnum        = line('.')
  let col         = col('.')
  let pattern     = a:pattern
  let extra_flags = ''

  " handle any extra flags provided by the user
  for char in ['e', 'p', 's']
    if stridx(given_flags, char) >= 0
      let extra_flags .= char
    endif
  endfor

  try
    call s:PushCursor()

    " find the start of the pattern
    call search(pattern, 'bcW', lnum)
    let search_result = s:SearchSkip(pattern, skip, 'cW'.extra_flags, lnum)
    if search_result <= 0
      return [0, 0]
    endif
    let match_start = col('.')

    " find the end of the pattern
    call s:PushCursor()
    call s:SearchSkip(pattern, skip, 'cWe', lnum)
    let match_end = col('.')

    " set the end of the pattern to the next character, or EOL. Extra logic
    " is for multibyte characters.
    normal! l
    if col('.') == match_end
      " no movement, we must be at the end
      let match_end = col('$')
    else
      let match_end = col('.')
    endif
    call s:PopCursor()

    if !s:ColBetween(col, match_start, match_end)
      " then the cursor is not in the pattern
      return [0, 0]
    else
      " a match has been found
      return [match_start, match_end]
    endif
  finally
    if stridx(given_flags, 'n') >= 0
      call s:PopCursor()
    else
      call s:DropCursor()
    endif
  endtry
endfunction

" A partial replacement to search() that consults a skip pattern when
" performing a search, just like searchpair().
"
" Note that it doesn't accept the "n" and "c" flags due to implementation
" difficulties.
function! s:SearchSkip(pattern, skip, ...)
  " collect all of our arguments
  let pattern = a:pattern
  let skip    = a:skip

  if a:0 >= 1
    let flags = a:1
  else
    let flags = ''
  endif

  if stridx(flags, 'n') > -1
    echoerr "Doesn't work with 'n' flag, was given: ".flags
    return
  endif

  let stopline = (a:0 >= 2) ? a:2 : 0
  let timeout  = (a:0 >= 3) ? a:3 : 0

  " just delegate to search() directly if no skip expression was given
  if skip == ''
    return search(pattern, flags, stopline, timeout)
  endif

  " search for the pattern, skipping a match if necessary
  let skip_match = 1
  while skip_match
    let match = search(pattern, flags, stopline, timeout)

    " remove 'c' flag for any run after the first
    let flags = substitute(flags, 'c', '', 'g')

    if match && eval(skip)
      let skip_match = 1
    else
      let skip_match = 0
    endif
  endwhile

  return match
endfunction

" Execute the normal mode motion "motion" and return the text it marks.
"
" Note that the motion needs to include a visual mode key, like "V", "v" or
" "gv"
function! s:GetMotion(motion)
  call s:PushCursor()

  let saved_register_text = getreg('z', 1)
  let saved_register_type = getregtype('z')

  exec 'silent normal! '.a:motion.'"zy'
  let text = @z

  call setreg('z', saved_register_text, saved_register_type)
  call s:PopCursor()

  return text
endfunction

" Retrieve the lines from "start" to "end" and return them as a list. This is
" simply a wrapper for getbufline for the moment.
function! s:GetLines(start, end)
  return getbufline('%', a:start, a:end)
endfunction

" Checks if the current position of the cursor is within the given limits.
"
function! s:CursorBetween(start, end)
  return s:ColBetween(col('.'), a:start, a:end)
endfunction

" Checks if the given column is within the given limits.
"
function! s:ColBetween(col, start, end)
  return a:start <= a:col && a:end > a:col
endfunction


" ----- Added Helpers
" Removes empty lines from the list
"
function! s:CompactLines(lines)
  return filter(copy(a:lines), '!empty(v:val)')
endfunction


" ----- Helpers

function! s:HandleComments(start_line_no, end_line_no)
  let start_line_no = a:start_line_no
  let end_line_no   = a:end_line_no

  let [success, failure] = [1, 0]
  let offset = 0

  let comments = s:FindComments(start_line_no, end_line_no)

  if len(comments) > 1
    echomsg "Splitjoin: Can't join this due to the inline comments. Please remove them first."
    return [failure, 0]
  endif

  if len(comments) == 1
    let [start_line_no, end_line_no] = s:MigrateComments(comments, a:start_line_no, a:end_line_no)
    let offset = start_line_no - a:start_line_no
  else
    let offset = 0
  endif

  return [success, offset]
endfunction

function! s:FindComments(start_line_no, end_line_no)
  call s:PushCursor()

  let comments = []

  for lineno in range(a:start_line_no, a:end_line_no)
    exe lineno
    normal! 0

    while search('\s*#.*$', 'W', lineno) > 0
      let col = col('.')

      normal! f#
      if synIDattr(synID(lineno, col('.'), 1), "name") == 'rubyComment'
        let comment = s:GetCols(col, col('$'))
        call add(comments, [lineno, col, comment])
        break
      endif
    endwhile
  endfor

  call s:PopCursor()

  return comments
endfunction

function! s:MigrateComments(comments, start_line_no, end_line_no)
  call s:PushCursor()

  let start_line_no = a:start_line_no
  let end_line_no   = a:end_line_no

  for [line, col, _c] in a:comments
    call cursor(line, col)
    normal! "_D
  endfor

  for [_l, _c, comment] in a:comments
    call append(start_line_no - 1, comment)

    exe start_line_no
    normal! ==

    let start_line_no = start_line_no + 1
    let end_line_no   = end_line_no + 1
  endfor

  call s:PopCursor()

  return [start_line_no, end_line_no]
endfunction

