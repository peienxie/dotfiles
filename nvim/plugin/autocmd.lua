vim.api.nvim_create_autocmd(
    { "TextYankPost" }, {
    command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=250 }",
    group = vim.api.nvim_create_augroup("Hightlight_Yank", { clear = true }),
})

vim.api.nvim_create_autocmd(
    { "WinEnter", "VimEnter" }, {
    command = "call matchadd('Todo', 'TODO|FIXME|XXX', -1)",
    group = vim.api.nvim_create_augroup("Hightlight_Todo", { clear = true }),
})

vim.api.nvim_create_autocmd(
    { "BufEnter" }, {
    pattern = "COMMIT_EDITMSG",
    command = "startinsert",
    group = vim.api.nvim_create_augroup("StartInsert_Commit", { clear = true }),
})

