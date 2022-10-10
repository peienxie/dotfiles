local M = {}

M.register_filetype_keymap = function(pattern, callback)
	local group = vim.api.nvim_create_augroup("DapRunKeymap", { clear = true })
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = pattern,
		callback = callback,
		group = group,
	})
end

M.setup = function()
	local dap_ok, dap = pcall(require, "dap")
	if not dap_ok then
		vim.notify("Failed to load plugin 'dap'", "error")
		return
	end
	local dap_ui_ok, dapui = pcall(require, "dapui")
	if not dap_ui_ok then
		vim.notify("Failed to load plugin 'dapui'", "error")
		return
	end

	local nnoremap = require("mylua.utils.keymap").nnoremap

	nnoremap("<leader>tb", dap.toggle_breakpoint)
	nnoremap("<leader>tB", function()
		dap.set_breakpoint(vim.fn.input("Breakpoint condition > "))
	end)
	nnoremap("<leader>te", function()
		local session = dap.session()
		if session == nil then
			vim.notify("No Dap session available")
		else
			dapui.eval()
		end
	end)
	nnoremap("<leader>tE", function()
		local session = dap.session()
		if session == nil then
			vim.notify("No Dap session available")
		else
			dapui.eval(vim.fn.input("Expression > "))
		end
	end)
	nnoremap("<leader>tU", dapui.toggle)
	nnoremap("<leader>tc", dap.run_to_cursor)
	nnoremap("<leader>tp", dap.pause)
	nnoremap("<leader>tq", dap.close)
	nnoremap("<leader>td", dap.disconnect)
	nnoremap("<F6>", dap.step_back)
	nnoremap("<F7>", dap.continue)
	nnoremap("<F8>", dap.step_into)
	nnoremap("<F9>", dap.step_out)
	nnoremap("<F10>", dap.step_over)
end

return M
