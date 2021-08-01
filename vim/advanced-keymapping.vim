if !has("nvim")
    finish
endif

" add more undo break points
" vscode and ideavim currently is not supported <C-g> command
inoremap <Space> <Space><C-g>u
inoremap <CR> <CR><C-g>u
inoremap <BS> <BS><C-g>u
