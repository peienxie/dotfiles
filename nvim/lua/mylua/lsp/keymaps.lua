local M = {}

M.on_attach = function(client, bufnr)
	local buf_set_keymap = function(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)

	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "<leader>gf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("v", "<leader>gf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

return M
