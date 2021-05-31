" rename.vim  -  Rename a buffer within Vim and on the disk
"
" Copyright June 2007 by Christian J. Robinson <infynity@onewest.net>
" Updated August 2011 by Dan Rogers <dan@danro.net>
" Updated June 2013 by Alexandre Fonseca <alexandrejorgefonseca@gmail.com>
" Vendored and Updated 2021 by Trent Scheffert <trent.scheffert@gmail.com>
"   Source: https://github.com/danro/rename.vim
"
" Distributed under the terms of the Vim license.  See ":help license".
"
" Usage:
"
" :rename[!] {newname}

command! -nargs=* -complete=customlist,SiblingFiles -bang Rename :call Rename("<args>", "<bang>")
cabbrev rename <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "Rename" : "rename"<CR>

function! SiblingFiles(A, L, P)
  return map(split(globpath(expand("%:h") . "/", a:A . "*"), "\n"), 'fnamemodify(v:val, ":t")')
endfunction

function! Rename(name, bang)
  let l:curfile = expand("%:p")
  let l:curpath = expand("%:h") . "/"
  let v:errmsg = ""
  silent! exe "saveas" . a:bang . " " . fnameescape(l:curpath . a:name)

  if v:errmsg =~# '^$\|^E329'
    let l:oldfile = l:curfile
    let l:curfile = expand("%:p")
    if l:curfile !=# l:oldfile && filewritable(l:curfile)
      silent exe "bwipe! " . fnameescape(l:oldfile)
      if delete(l:oldfile)
        echoerr "Could not delete " . l:oldfile
      endif
    endif

    " Refresh the NERDTree root
    " if exists('*NERDTree#NERDTreeRefreshRoot')
    " if exists("t:NERDTreeBufName")
    if exists(":NERDTreeRefreshRoot")
      " Should refresh above the file we're renaming only, but refreshing the root seems like the only public interface
      " call NERDTree#NERDTreeRefreshRoot
      NERDTreeRefreshRoot
    endif
  else
    echoerr v:errmsg
  endif
endfunction
