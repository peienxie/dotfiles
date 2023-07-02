local ok, neogit = pcall(require, "neogit")
if not ok then
	vim.notify("Failed to load plugin 'neogit'", "error")
	return
end

neogit.setup({
	disable_commit_confirmation = true,
	integrations = { diffview = true },
	disable_insert_on_commit = false,
	sections = {
		stashes = { folded = false },
		unpulled = { folded = false },
		recent = { folded = false },
	},
})

-- keymaps
local nnoremap = require("mylua.utils.keymap").nnoremap

nnoremap("<leader>gs", ":Neogit<CR>")
