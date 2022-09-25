-- don't open diff window on default
vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2

-- keymaps
local nnoremap = require("mylua.utils.keymap").nnoremap

nnoremap("<leader>eu", ":UndotreeToggle<CR>")
