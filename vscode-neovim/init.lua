local opt = vim.opt

local map = function(mode, lhs, rhs, opts)
	local default_opts = { noremap = true, silent = true }
	opts = vim.tbl_extend("force", default_opts, opts or {})
	vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

opt.rtp:remove(vim.fn.stdpath("data") .. "/site")
opt.rtp:remove(vim.fn.stdpath("data") .. "/site/after")
-- disable all plugins
-- TODO: should use the `cond` parameter for packer.nvim, enable/disable plugins depends on g:vscode
vim.cmd([[ set packpath= ]])

opt.backup = false
opt.swapfile = false
opt.undofile = false
opt.number = true
opt.relativenumber = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- use space as leader key
vim.g.mapleader = " "

map("n", "<CR>", '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })

-- disable some default keymapping which I don't wanna use
map("n", "Q", "<nop>")
map("n", "q:", "<nop>")

-- make Y work the same as D and C
map("n", "Y", "y$")

-- keep cursor center when jumpping search result
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

-- yank to system clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
-- paste from system clipboard
map("n", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')
-- replace current selected text
map("v", "<leader>dp", '"_dP')

-- delete without copying to clipboard
map("n", "<leader>d", '"_d')
map("v", "<leader>d", '"_d')
map("n", "x", '"_x')
map("v", "x", '"_xgv')

-- search the word under cursor
-- map("n", "<C-f>", "g#N", { silent = false })
-- map("v", "<C-f>", 'y/<C-r>"<CR>N', { silent = false })

-- replace selected word
vim.cmd([[
function! EscapeAll()
	let @"=escape(@", '\\/.*$^~[]')
	let @"=substitute(@", '\n', '\\n', 'g')
	let @"=substitute(@", '\t', '\\t', 'g')
endfunction
]])
map("v", "<C-r>", 'y:call EscapeAll()<CR>:%s/<C-r>"//gc<Left><Left><Left>', { silent = false })

-- search in visually hightlighted range
map("v", "g/", "<Esc>/\\%V", { silent = false })

-- 'n' go down and 'N' go up when searching
map("n", "n", "'Nn'[v:searchforward]", { silent = false, expr = true })
map("n", "N", "'nN'[v:searchforward]", { silent = false, expr = true })

-- indent but remain in visual mode
map("v", ">", ">gv")
map("v", "<", "<gv")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- move around windows
map("n", "<leader>h", '<cmd>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
map("n", "<leader>j", '<cmd>call VSCodeNotify("workbench.action.navigateDown")<CR>')
map("n", "<leader>k", '<cmd>call VSCodeNotify("workbench.action.navigateUp")<CR>')
map("n", "<leader>l", '<cmd>call VSCodeNotify("workbench.action.navigateRight")<CR>')
map("n", "<leader>q", '<cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>')
map("n", "<leader>ss", '<cmd>call VSCodeNotify("workbench.action.splitEditorOrthogonal")<CR>')
map("n", "<leader>sv", '<cmd>call VSCodeNotify("workbench.action.splitEditor")<CR>')

-- Open Explorer and Git
map("n", "<space>ee", '<cmd>call VSCodeNotify("workbench.view.explorer")<CR>')
map("n", "<space>gs", '<cmd>call VSCodeNotify("workbench.view.scm")<CR>')

-- Lsp
map("n", "gD", '<cmd>call VSCodeNotify("editor.action.revealDeclaration")<CR>')
map("n", "gd", '<cmd>call VSCodeNotify("editor.action.revealDefinition")<CR>')
map("n", "<C-w>gd", '<cmd>call VSCodeNotify("editor.action.revealDefinitionAside")<CR>')
map("n", "gI", '<cmd>call VSCodeNotify("editor.action.goToImplementation")<CR>')
map("n", "gy", '<cmd>call VSCodeNotify("editor.action.goToTypeDefinition")<CR>')
map("n", "gr", '<cmd>call VSCodeNotify("editor.action.goToReferences")<CR>')
map("n", "gs", '<cmd>call VSCodeNotify("editor.action.triggerParameterHints")<CR>')
map("n", "gh", '<cmd>call VSCodeNotify("editor.action.showHover")<CR>')
map("n", "ga", '<cmd>call VSCodeNotify("editor.action.quickFix")<CR>')
map("n", "gR", '<cmd>call VSCodeNotify("editor.action.rename")<CR>')

map("n", "[b", '<cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>')
map("n", "]b", '<cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>')

-- Commentary
map("x", "gc", "<Plug>VSCodeCommentary", { noremap = false })
map("n", "gc", "<Plug>VSCodeCommentary", { noremap = false })
map("o", "gc", "<Plug>VSCodeCommentary", { noremap = false })
map("n", "gcc", "<Plug>VSCodeCommentaryLine", { noremap = false })

-- Vscode related
map("n", "<leader>.", '<cmd>call VSCodeNotify("workbench.action.openSettingsJson")<CR>')
map("n", "<leader>;", '<cmd>call VSCodeNotify("workbench.action.showCommands")<CR>')
map("n", "<leader>z", '<cmd>call VSCodeNotify("workbench.action.toggleZenMode")<CR>')

-- Autocmd
local group = vim.api.nvim_create_augroup("MyAutocmdGroup", { clear = true })

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=250 }",
	group = group,
})
