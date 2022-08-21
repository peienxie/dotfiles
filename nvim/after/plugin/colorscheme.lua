-- dracula
--let g:colors_name = 'dracula'
--vim.opt.background='dark'
--vim.cmd([[ colorscheme dracula ]])
--vim.cmd([[ highlight Normal ctermbg=NONE guibg=NONE ]])
--vim.cmd([[ highlight NonText ctermbg=NONE guibg=NONE guifg=Gray ]])
--vim.cmd([[ highlight Character  NONE ]])
--vim.cmd([[ highlight link Character DraculaYellow ]])

-- ayu
vim.g.ayucolor = "dark"
vim.api.nvim_set_hl(0, "Normal", { bg = "None" })
vim.cmd([[ colorscheme ayu ]])

-- make selected item more visible
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#30353e" })
