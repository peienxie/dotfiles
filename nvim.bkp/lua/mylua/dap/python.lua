local M = {}

function M.setup()
	local ok, dap_python = pcall(require, "dap-python")
	if not ok then
		vim.notify("Failed to load plugin 'dap-python'", "error")
		return
	end

	-- setup nvim-dap-python
	dap_python.setup("python")

	-- keymaps
	local nnoremap = require("mylua.utils.keymap").nnoremap
	nnoremap("<leader>tr", dap_python.test_method, { buffer = 0 })
	nnoremap("<leader>tf", dap_python.test_class, { buffer = 0 })
end

return M
