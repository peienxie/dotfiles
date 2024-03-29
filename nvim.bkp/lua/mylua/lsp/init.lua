local M = {}

local lsp_server_configs = require("mylua.lsp.servers")

M.list_servers = function()
	local servers = {}
	for server in pairs(lsp_server_configs) do
		table.insert(servers, server)
	end
	return servers
end

M.setup = function()
	local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
	if not lspconfig_ok then
		vim.notify("Failed to load plugin 'lspconfig'", "error")
		return
	end

	-- display function signature help when typing
	require("mylua.lsp.lsp-signature").setup()

	-- make diagnostic icon looks better
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- It's important that you set up the plugins in the following order:
	-- mason.nvim --> mason-lspconfig.nvim --> lspconfig
	require("mylua.lsp.mason").setup()
	require("mylua.lsp.mason-lspconfig").setup()

	local handlers = require("mylua.lsp.handlers")
	for server, config in pairs(lsp_server_configs) do
		config = vim.tbl_deep_extend("force", {
			on_attach = handlers.on_attach,
			capabilities = handlers.get_capabilities(),
		}, config)

		lspconfig[server].setup(config)
	end
end

return M
