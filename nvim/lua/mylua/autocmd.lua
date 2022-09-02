local group = vim.api.nvim_create_augroup("MyAutocmdGroup", { clear = true })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=250 }",
	group = group,
})

vim.api.nvim_create_autocmd({ "WinEnter", "VimEnter" }, {
	command = "call matchadd('Todo', 'TODO|FIXME|XXX', -1)",
	group = group,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "COMMIT_EDITMSG",
	command = "startinsert",
	group = group,
})

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
	group = group,
})
