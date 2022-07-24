augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=250 }
augroup END

augroup higlight_todo
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME\|XXX', -1)
augroup END

augroup startinsert_commit
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG startinsert
augroup END
