vim.g.colors_name = "dracula"
vim.opt.background = "dark"
vim.cmd([[ colorscheme dracula ]])
vim.cmd([[ highlight Normal ctermbg=NONE guibg=NONE ]])
vim.cmd([[ highlight NonText ctermbg=NONE guibg=NONE guifg=Gray ]])
vim.cmd([[ highlight Character  NONE ]])
vim.cmd([[ highlight link Character DraculaYellow ]])
