local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
	vim.notify("Failed to load plugin 'nvim-tree'", "error")
	return
end

local nvim_tree_config = require("nvim-tree.config")
local tree_cb = nvim_tree_config.nvim_tree_callback

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
	open_on_setup = true,
	ignore_ft_on_setup = {},
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = true,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l" }, cb = tree_cb("edit") },
				{ key = { "h" }, cb = tree_cb("close_node") },
			},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
			},
			show = {
				git = true,
				folder = true,
				file = true,
				folder_arrow = false,
			},
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

-- keymaps
local nnoremap = require("mylua.utils.keymap").nnoremap

nnoremap("<leader>ee", ":NvimTreeToggle<CR>")
nnoremap("<leader>ef", ":NvimTreeFindFile<CR>")

-- bring back the 'gx' functionality of netrw open URL
-- https://sbulav.github.io/vim/neovim-opening-urls/
if vim.fn.has("mac") == 1 then
	nnoremap("gx", "<Cmd>call jobstart(['open', expand('<cfile>')], {'detach': v:true})<CR>")
elseif vim.fn.has("unix") == 1 then
	nnoremap("gx", "<Cmd>call jobstart(['xdg-open', expand('<cfile>')], {'detach': v:true})<CR>")
elseif vim.fn.has("windows") == 1 then
	nnoremap("gx", "<Cmd>call jobstart(['start', expand('<cfile>')], {'detach': v:true})<CR>")
else
	nnoremap("gx", "<Cmd>lua print('Error: gx is not supported on this OS!')<CR>")
end
