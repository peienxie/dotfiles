local M = {}

function M.setup()
	local ok, dap_go = pcall(require, "dap-go")
	if not ok then
		vim.notify("Failed to load plugin 'dap-go'", "error")
		return
	end

	-- setup nvim-dap-go
	dap_go.setup()

	-- keymaps
	local nnoremap = require("mylua.utils.keymap").nnoremap
	nnoremap("<leader>tr", dap_go.debug_test, { buffer = 0 })
end

return M
