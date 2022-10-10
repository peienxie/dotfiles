local M = {}

M.setup = function()
	local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
	if not ok then
		vim.notify("Failed to load plugin 'mason-lspconfig'", "error")
		return
	end

	local servers = require("mylua.lsp").list_servers()
	mason_lspconfig.setup({
		ensure_installed = servers,
		automatic_installation = true,
	})
end

return M
