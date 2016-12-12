" Inspiration and source come with <3 from: https://github.com/mpyatishev/vim-sqlformat
" requires 'sudo pip install sqlparse'

if exists("prettysql")
    finish
endif
let prettysql = 1

if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

" TODO: Enforce that we have sqlparse available for python
function! prettysql#FormatSQL(start, end)

python << EOF

import vim
import sqlparse

start = int(vim.eval('a:start')) - 1
end = int(vim.eval('a:end')) - 1
buf = vim.current.buffer
NL = '\n'

try:
    sql = NL.join(buf[start:end + 1])

    # Format options: https://sqlparse.readthedocs.io/en/latest/api/#formatting-of-sql-statements
    sql_new = sqlparse.format(sql,
      reindent=True,
      keyword_case='upper',
      identifier_case='lower',
      indent_width=2,
      wrap_after=80)

    lines = [line.encode('utf-8') for line in sql_new.split(NL)]
    buf[:] = buf[:start] + lines + buf[end + 1:]
except Exception, e:
    print e
EOF

endfunction
