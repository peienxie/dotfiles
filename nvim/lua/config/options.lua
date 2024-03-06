-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.fileencodings = "utf-8,big5,cp950,gbk,cp936,iso-2022-jp,sjis,euc-jp,japan,euc-kr,ucs-bom,utf-bom,latin1,iso8859-1"

opt.scrolloff = 4
opt.sidescrolloff = 8

opt.winbar = " "
opt.cursorline = true
opt.cursorlineopt = "number"

opt.colorcolumn = "81"

opt.list = true
opt.listchars = { tab = "» ", eol = "↓", trail = "·" }

opt.swapfile = false
