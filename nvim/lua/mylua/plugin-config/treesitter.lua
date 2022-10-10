local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	vim.notify("Failed to load plugin 'nvim-treesitter'", "error")
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	ensure_installed = "all",
})

-- keymaps
local nnoremap = require("mylua.utils.keymap").nnoremap

-- toggle treesitter playground
nnoremap("<leader><F9>", ":TSPlaygroundToggle<CR>")
-- show the highlight group of symbol under cursor
nnoremap("<leader><F10>", ":TSHighlightCapturesUnderCursor<CR>")
