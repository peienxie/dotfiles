local M = {}

function M.setup()
	local ok, dap_go = pcall(require, "dap-go")
	if not ok then
		vim.notify("Failed to load plugin 'dap-go'", "error")
		return
	end

	-- setup nvim-dap-go
	dap_go.setup()

	-- register keymap for go filetype only
	local register = require("mylua.dap.keymaps").register_filetype_keymap
	local nnoremap = require("mylua.utils.keymap").nnoremap

	register("go", function()
		nnoremap("<leader>tr", "<cmd>lua require('dap-go').debug_test()<CR>", { buffer = 0 })
	end)
end

return M
