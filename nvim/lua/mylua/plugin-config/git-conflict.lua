local ok, gitconflict = pcall(require, "git-conflict")
if not ok then
	vim.notify("Failed to load plugin 'git-conflict'", "error")
	return
end

gitconflict.setup({
	disable_diagnostics = true,
})

vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#163333" })
vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#181B20" })
vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#162C43" })
vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "#256b61" })
vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { bg = "#2D2E32" })
vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "#255A8A" })
