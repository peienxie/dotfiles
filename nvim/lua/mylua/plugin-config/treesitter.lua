local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	vim.notify("Failed to load plugin 'nvim-treesitter'", "error")
	return
end

treesitter.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = false,
		disable = {},
	},
	ensure_installed = {
		"go",
		"json",
		"yaml",
	},
})

-- keymaps
local nnoremap = require("mylua.utils.keymap").nnoremap

-- show the highlight group of symbol under cursor
nnoremap("<F10>", ":TSHighlightCapturesUnderCursor<CR>")
