local ok, diffview = pcall(require, "diffview")
if not ok then
	vim.notify("Failed to load plugin 'diffview'", "error")
	return
end

diffview.setup({
	keymaps = {
		view = {
			["q"] = "<Cmd>tabclose<CR>",
		},
		file_panel = {
			["q"] = "<Cmd>tabclose<CR>",
			["?"] = "<Cmd>h diffview-maps-file-panel<CR>",
		},
		file_history_panel = {
			["q"] = "<Cmd>tabclose<CR>",
			["?"] = "<Cmd>h diffview-maps-file-history-panel<CR>",
		},
	},
})

-- keymaps
local nnoremap = require("mylua.utils.keymap").nnoremap

nnoremap("<leader>gd", ":DiffviewOpen<CR>")
nnoremap("<leader>gh", ":DiffviewFileHistory %<CR>")
