if !exists('g:loaded_signify')
    finish
endif

let g:signify_sign_add               = '│'
let g:signify_sign_delete            = '│'
let g:signify_sign_delete_first_line = '│'
let g:signify_sign_change            = '│'

" don't show how many line changes count
let g:signify_sign_show_count = 0

nnoremap <leader>sh :SignifyHunkDiff<CR>
nnoremap <leader>su :SignifyHunkUndo<CR>

autocmd User SignifyHunk call s:show_current_hunk()

function! s:show_current_hunk() abort
    let h = sy#util#get_hunk_stats()
    if !empty(h)
        echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
    endif
endfunction

