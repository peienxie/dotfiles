----- dracula ------
--let g:colors_name = 'dracula'
--vim.opt.background='dark'
--vim.cmd([[ colorscheme dracula ]])
--vim.cmd([[ highlight Normal ctermbg=NONE guibg=NONE ]])
--vim.cmd([[ highlight NonText ctermbg=NONE guibg=NONE guifg=Gray ]])
--vim.cmd([[ highlight Character  NONE ]])
--vim.cmd([[ highlight link Character DraculaYellow ]])

----- ayu ------
-- access the ayu#palette variable first then let plugin autoload this variable
-- otherwise it is undefined variable
vim.api.nvim_get_var("ayu#palette")

-- not sure why this is not working, need use vim.cmd to assign variable
--vim.g["ayu#palette"]["ui_panel_bg"]["dark"] = "#30353e"

-- make float windows more visible
vim.cmd('let g:ayu#palette["ui_panel_bg"]["dark"] = "#30353e"')
-- make selected item more visible
vim.cmd('let g:ayu#palette["ui_selection_active"]["dark"] = "#30353e"')
-- Search and IncSearch
vim.cmd('let g:ayu#palette["editor_findMatch_active"]["dark"] = "#897199"')
vim.cmd('let g:ayu#palette["editor_findMatch_inactive"]["dark"] = "#5b5767"')

vim.g.ayucolor = "dark"
vim.cmd([[ colorscheme ayu ]])
