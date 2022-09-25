local ok, telescope = pcall(require, "telescope")
if not ok then
	vim.notify("Failed to load plugin 'telescope'", "error")
	return
end

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")

telescope.setup({
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "  ",
		entry_prefix = "  ",
		results_title = false,
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "top",
			horizontal = {
				width = function(_, max_columns, _)
					return math.min(max_columns, 160)
				end,

				height = function(_, _, max_lines)
					return math.min(max_lines, 40)
				end,
			},
		},
		preview = { hide_on_startup = true },
		mappings = {
			n = {
				["<A-p>"] = actions_layout.toggle_preview,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,
			},
			i = {
				["<A-p>"] = actions_layout.toggle_preview,
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,
			},
		},
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
	},
	pickers = {
		git_files = {
			show_untracked = true,
		},
		find_files = {
			no_ignore = true,
		},
		grep_string = {
			use_regex = true,
		},
		current_buffer_fuzzy_find = {
			tiebreak = function(current_entry, existing_entry)
				return current_entry.lnum > existing_entry.lnum
			end,
		},
		buffers = {
			sort_mru = true,
			mappings = {
				-- TODO: add a keymap to close all buffers except current one? with vim command :%bd|e#
				i = {
					["<C-d>"] = actions.delete_buffer,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
				},
				n = {
					["<C-d>"] = actions.delete_buffer,
					["dd"] = actions.delete_buffer,
				},
			},
		},
	},
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

-- keymaps
local nnoremap = require("mylua.utils.keymap").nnoremap
local vnoremap = require("mylua.utils.keymap").vnoremap

-- TODO: fallback to find_files if not a git directory
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
nnoremap("<C-p>", ':lua require("telescope.builtin").git_files()<CR>')
nnoremap("<leader>ff", ':lua require("telescope.builtin").find_files()<CR>')
nnoremap("<leader>fw", ':lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')
vnoremap("<leader>fw", ':lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })<CR>')
nnoremap("<leader>fg", ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ") })<CR>')
nnoremap("<leader>fl", ':lua require("telescope.builtin").live_grep()<CR>')
nnoremap("<leader>fb", ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>')
nnoremap("<leader>fn", ':lua require("telescope.builtin").buffers()<CR>')
nnoremap("<leader>fh", ':lua require("telescope.builtin").help_tags()<CR>')

nnoremap("<leader>fr", ':lua require("telescope.builtin").resume()<CR>')
nnoremap("<leader>ft", ":Telescope<CR>")
