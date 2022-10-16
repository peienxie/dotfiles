local M = {}

-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.opt.updatetime = 500

-- local diagnostic_float = function()
-- 	local group = vim.api.nvim_create_augroup("lsp_diagnostic_hover", { clear = true })
-- 	vim.api.nvim_create_autocmd("CursorHold", {
-- 		group = group,
-- 		callback = vim.diagnostic.open_float(nil, { focus = false }),
-- 	})
-- end

local document_highlight = function(client, bufnr)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_set_hl(0, "LspReferenceRead", { bold = true, bg = "Grey" })
		vim.api.nvim_set_hl(0, "LspReferenceText", { bold = true, bg = "Grey" })
		vim.api.nvim_set_hl(0, "LspReferenceWrite", { bold = true, bg = "Grey" })

		local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_create_autocmd("CursorHold", {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "none" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "none" })

M.on_attach = function(client, bufnr)
	require("mylua.lsp.keymaps").on_attach(client, bufnr)
	document_highlight(client, bufnr)
end

M.get_capabilities = function(override)
	override = override or {}
	local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not ok then
		vim.notify("Failed to load plugin 'cmp_nvim_lsp'")
		return vim.lsp.protocol.make_client_capabilities()
	else
		return cmp_nvim_lsp.default_capabilities(override)
	end
end

return M
