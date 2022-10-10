local M = {}

M.setup = function()
	local ok, lsp_signature = pcall(require, "lsp_signature")
	if not ok then
		vim.notify("Failed to load plugin 'lsp_signature'", "error")
		return
	end

	lsp_signature.setup({
		hint_enable = false,
		hint_prefix = "",
		handler_opts = {
			border = "none", -- double, rounded, single, shadow, none
		},
		always_trigger = true,
		toggle_key = "<C-k>", -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	})
end

return M
