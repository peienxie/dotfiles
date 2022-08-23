require("nvim-treesitter.configs").setup({
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

local nnoremap = require("mylua.utils.keymap").nnoremap

-- show the highlight group of symbol under cursor
nnoremap("<F10>", ":TSHighlightCapturesUnderCursor<CR>")
