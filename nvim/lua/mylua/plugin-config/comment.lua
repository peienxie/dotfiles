local ok, comment = pcall(require, "Comment")
if not ok then
	vim.notify("Failed to load plugin 'Comment'", "error")
	return
end

comment.setup({
	---Add a space b/w comment and the line
	padding = true,

	---Whether the cursor should stay at its position
	---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
	sticky = true,

	---Lines to be ignored while comment/uncomment.
	---Could be a regex string or a function that returns a regex string.
	---Example: Use '^$' to ignore empty lines
	ignore = "^$",

	---LHS of toggle mappings in NORMAL + VISUAL mode
	toggler = {
		---Line-comment toggle keymap
		line = "gcc",
		---Block-comment toggle keymap
		block = "gbc",
	},

	---LHS of operator-pending mappings in NORMAL + VISUAL mode
	opleader = {
		---Line-comment keymap
		line = "gc",
		---Block-comment keymap
		block = "gb",
	},

	---LHS of extra mappings
	extra = {
		---Add comment on the line above
		above = "gcO",
		---Add comment on the line below
		below = "gco",
		---Add comment at the end of line
		eol = "gcA",
	},

	---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
	mappings = {
		---Operator-pending mapping
		---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
		---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
		basic = true,
		---Extra mapping
		---Includes `gco`, `gcO`, `gcA`
		extra = true,
	},

	---Pre-hook, called before commenting the line
	pre_hook = nil,

	---Post-hook, called after commenting is done
	post_hook = nil,
})

-- Ref: https://github.com/numToStr/Comment.nvim/wiki/Extended-Keybindings
local api = require("Comment.api")
local map = vim.keymap.set

map("n", "g>", api.call("comment.linewise", "g@"), { expr = true, desc = "Comment region linewise" })
map("n", "g>c", api.call("comment.linewise.current", "g@$"), { expr = true, desc = "Comment current line" })
map("n", "g>b", api.call("comment.blockwise.current", "g@$"), { expr = true, desc = "Comment current block" })

map("n", "g<", api.call("uncomment.linewise", "g@"), { expr = true, desc = "Uncomment region linewise" })
map("n", "g<c", api.call("uncomment.linewise.current", "g@$"), { expr = true, desc = "Uncomment current line" })
map("n", "g<b", api.call("uncomment.blockwise.current", "g@$"), { expr = true, desc = "Uncomment current block" })

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

map("x", "g>", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.locked("comment.linewise")(vim.fn.visualmode())
end, { desc = "Comment region linewise (visual)" })

map("x", "g<", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.locked("uncomment.linewise")(vim.fn.visualmode())
end, { desc = "Uncomment region linewise (visual)" })
