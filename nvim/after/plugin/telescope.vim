if !exists('g:loaded_telescope')
    finish
endif

nnoremap <C-p> <Cmd>lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>ff <Cmd>lua require('telescope.builtin').find_files({ no_ignore=true })<CR>
nnoremap <leader>fg <Cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep for > ' ), use_regex = true })<CR>
nnoremap <leader>fw <Cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fb <Cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({ previewer = false, sorting_strategy = "ascending" })<CR>
nnoremap <leader>fh <Cmd>lua require('telescope.builtin').help_tags()<CR>

lua << EOF
require'telescope'.setup {
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = false, -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
    }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

EOF
