local keymap = require("mylua.utils.keymap")

local neogit = require("neogit")
neogit.setup({
	disable_commit_confirmation = true,
	integrations = { diffview = true },
	disable_insert_on_commit = false,
	sections = {
		stashes = { folded = false },
		unpulled = { folded = false },
		recent = { folded = false },
	},
})

keymap.nnoremap("<leader>gs", ":Neogit<CR>")

local diffview = require("diffview")
diffview.setup({
	keymaps = {
		view = {
			["q"] = "<Cmd>tabclose<CR>",
		},
		file_panel = {
			["q"] = "<Cmd>tabclose<CR>",
			["?"] = "<Cmd>h diffview-maps-file-panel<CR>",
		},
		file_history_panel = {
			["q"] = "<Cmd>tabclose<CR>",
			["?"] = "<Cmd>h diffview-maps-file-history-panel<CR>",
		},
	},
})

keymap.nnoremap("<leader>gd", ":DiffviewOpen<CR>")
keymap.nnoremap("<leader>gh", ":DiffviewFileHistory %<CR>")

require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "│" },
		topdelete = { text = "│" },
		changedelete = { text = "│" },
	},
	current_line_blame = true,
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",
	preview_config = {
		border = "none",
	},
	on_attach = function(bufnr)
		-- issue: https://github.com/lewis6991/gitsigns.nvim/issues/582
		vim.cmd("hi link GitSignsDeleteLn DiffDelete")
		local gs = package.loaded.gitsigns

		local function map(mode, lhs, rhs, opts)
			opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
			opts.buffer = bufnr
			vim.keymap.set(mode, lhs, rhs, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk({ preview = true })
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.next_hunk({ preview = true })
			end)
			return "<Ignore>"
		end, { expr = true })
		--map("n", "]c", gs.next_hunk)
		--map("n", "[c", gs.prev_hunk)

		-- Actions
		map({ "n", "v" }, "<leader>ga", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>gA", gs.stage_buffer)
		map("n", "<leader>gR", gs.reset_buffer)
		map("n", "<leader>gu", gs.undo_stage_hunk)
		map("n", "<leader>gp", gs.preview_hunk)
		map("n", "<leader>gb", function()
			gs.blame_line({ full = true })
		end)
		--map("n", "<leader>hd", gs.diffthis)
		--map("n", "<leader>gD", function()
		--	gs.diffthis("~")
		--end)
		--map("n", "<leader>gtd", gs.toggle_deleted)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
