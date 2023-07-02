local M = {}

local function keymap(mode, default_opts)
	default_opts = default_opts or { noremap = true, silent = true }
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", default_opts, opts or {})
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

M.nmap = keymap("n", { noremap = false })
M.vmap = keymap("v", { noremap = false })
M.xmap = keymap("x", { noremap = false })
M.imap = keymap("i", { noremap = false })
M.cmap = keymap("c", { noremap = false })
M.tmap = keymap("t", { noremap = false })

M.nnoremap = keymap("n")
M.vnoremap = keymap("v")
M.xnoremap = keymap("x")
M.inoremap = keymap("i")
M.cnoremap = keymap("c")
M.tnoremap = keymap("t")

return M
