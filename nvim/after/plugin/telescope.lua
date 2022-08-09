local nnoremap = require("mylua.utils.keymap").nnoremap

nnoremap("<C-p>", ':lua require("telescope.builtin").git_files({ show_untracked = true })<CR>')
nnoremap("<leader>ff", ':lua require("telescope.builtin").find_files({ no_ignore = true })<CR>')
nnoremap(
	"<leader>fg",
	':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > "), use_regex = true })<CR>'
)
nnoremap("<leader>fw", ':lua require("telescope.builtin").live_grep()<CR>')
nnoremap(
	"<leader>fb",
	':lua require("telescope.builtin").current_buffer_fuzzy_find({ previewer = false, sorting_strategy = "ascending" })<CR>'
)
nnoremap("<leader>fh", ':lua require("telescope.builtin").help_tags()<CR>')

local telescope = require("telescope")

telescope.setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")
