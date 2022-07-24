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

--vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--	pattern = "*.lua",
--	command = "!stylua %",
--	group = group,
--})
