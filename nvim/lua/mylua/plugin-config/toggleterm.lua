local ok, toggleterm = pcall(require, "toggleterm")
if not ok then
	vim.notify("Failed to load plugin 'toggleterm'", "error")
	return
end

toggleterm.setup({
	-- size can be a number or function which is passed the current terminal
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
	open_mapping = [[<c-\>]],
	on_open = nil, -- function to run when the terminal opens
	on_close = nil, -- function to run when the terminal closes
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float',
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local group = vim.api.nvim_create_augroup("set_term_keymaps", {
	clear = true,
})
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	group = group,
	callback = function()
		local opts = { noremap = true, silent = true }
		vim.api.nvim_buf_set_keymap(0, "t", "jj", "<C-\\><C-n>", opts)

		vim.api.nvim_buf_set_keymap(0, "t", "<A-j>", "<C-\\><C-n><C-w>j", opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<A-h>", "<C-\\><C-n><C-w>h", opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<A-k>", "<C-\\><C-n><C-w>k", opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<A-l>", "<C-\\><C-n><C-w>l", opts)
	end,
})

local Terminal = require("toggleterm.terminal").Terminal

local ipython = Terminal:new({
	cmd = "ipython",
	hidden = true,
	direction = "vertical",
	start_in_insert = false,
	on_open = function(term)
		-- initialize slime default config
		if vim.g.slime_default_config == nil then
			vim.g.slime_default_config = { jobid = term.job_id }
		end
	end,
})

function IPythonToggle()
	ipython:toggle()

	-- exit insert mode then jump back to previous window
	vim.api.nvim_command("stopinsert!")
	vim.api.nvim_command("wincmd p")

	-- refresh ipython terminal job id in case the buffer had been closed
	if vim.b.slime_config ~= nil and vim.b.slime_config["jobid"] ~= ipython.job_id then
		vim.b.slime_config = { jobid = ipython.job_id }
	end
end

local function term_has_open(term)
	local wins = vim.api.nvim_list_wins()
	for _, win in pairs(wins) do
		local buf = vim.api.nvim_win_get_buf(win)
		if term.bufnr == buf then
			return true
		end
	end
	return false
end

function IPythonRun(run_cmd)
	-- auto start ipython terminal or open the window if already start
	if not term_has_open(ipython) then
		IPythonToggle()

		-- FIXME: when auto start ipython terminal the send cell headers is not working
		-- need to wait ipython kernel is ready before send command
		vim.wait(500)
	end
	vim.api.nvim_command(run_cmd)
end

-- use neovim terminal
vim.g.slime_target = "neovim"
-- skip confirmation prompt
vim.g.slime_dont_ask_default = 1
-- disable slime default mappings
vim.g.slime_no_mappings = 1
-- fix paste issues in ipython
vim.g.slime_python_ipython = 1
-- send cell header as well
vim.g.ipython_cell_send_cell_headers = 1
