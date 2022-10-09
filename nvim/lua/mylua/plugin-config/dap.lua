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

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Expand lines larger than the window
	-- Requires neovim >= 0.7
	expand_lines = true,
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 0.33,
			position = "right",
		},
		{
			elements = {
				"repl",
				"console",
			},
			size = 0.25,
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "□",
		},
	},
	floating = {
		max_height = 0.9,
		max_width = 0.5, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be 'single', 'double' or 'rounded'
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({ reset = true })
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
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

nnoremap("<leader>tr", "<cmd>lua require('dap-go').debug_test()<CR>")
