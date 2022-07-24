if !exists('loaded_fugitive')
    finish
endif

" move git status window to bottom and set height to 15 lines
nnoremap <leader>gs :G<CR><C-w>J:resize 15<CR>
nnoremap <leader>gj :diffget //3<CR>
nnoremap <leader>gf :diffget //2<CR>
nnoremap <leader>gc :Gcommit -v<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gl :Gclog<CR>
" stage/unstage select changes
vnoremap <leader>ga :diffput<CR>
vnoremap <leader>gd :diffget<CR>

