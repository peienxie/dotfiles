if !exists('g:loaded_telescope')
    finish
endif

nnoremap <C-p> <Cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>pf <Cmd>lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>pg <Cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>pb <Cmd>lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>ph <Cmd>lua require('telescope.builtin').help_tags()<CR>
