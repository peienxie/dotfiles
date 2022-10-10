local M = {}

function M.setup()
	local ok, dap_python = pcall(require, "dap-python")
	if not ok then
		vim.notify("Failed to load plugin 'dap-python'", "error")
		return
	end

	-- setup nvim-dap-python
	dap_python.setup("python")

	local register = require("mylua.dap.keymaps").register_filetype_keymap
	local nnoremap = require("mylua.utils.keymap").nnoremap

	register("python", function()
		nnoremap("<leader>tr", "<cmd>lua require('dap-python').test_method()<CR>", { buffer = 0 })
	end)
end

return M
