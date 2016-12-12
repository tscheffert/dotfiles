" Inspiration and source come with <3 from: https://github.com/mpyatishev/vim-sqlformat


  " SQL
  " requires 'sudo pip install sqlparse'
  " NeoBundle 'mpyatishev/vim-sqlformat' " Formatting for sql!


if exists("prettysql")
    finish
endif
let prettysql = 1

if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

function! prettysql#Format()
  " TODO: Accept a range of lines if we're in visual mode
  call prettysql#FormatEntireBuffer()
endfunction

function! prettysql#FormatEntireBuffer()
  let l:curw = winsaveview()
  normal! gggqG
  " call prettysql#FormatSQL()
  call winrestview(l:curw)
endfunction

" TODO: Enforce that we have sqlparse available for python
function! prettysql#FormatSQL()

python << EOF

import vim
import sqlparse

start = int(vim.eval('v:lnum')) - 1
end = int(vim.eval('v:count')) + start
buf = vim.current.buffer
NL = '\n'

try:
    sql = NL.join(buf[start:end + 1])
    sql_new = sqlparse.format(sql, reindent=True, keyword_case='upper')

    lines = [line.encode('utf-8') for line in sql_new.split(NL)]
    buf[:] = buf[:start] + lines + buf[end + 1:]
except Exception, e:
    print e
EOF

endfunction
