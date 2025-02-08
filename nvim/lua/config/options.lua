-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = false

-- LazyVim picker to use.
-- Can be one of: telescope, fzf
-- Leave it to "auto" to automatically use the picker
-- enabled with `:LazyExtras`
vim.g.lazyvim_picker = "telescope"

-- LazyVim completion engine to use.
-- Can be one of: nvim-cmp, blink.cmp
-- Leave it to "auto" to automatically use the completion engine
-- enabled with `:LazyExtras`
vim.g.lazyvim_cmp = "blink.cmp"

local opt = vim.opt

if vim.uv.os_uname().sysname:find("Windows") then
  opt.shell = "cmd.exe /k %CMDER_ROOT%/vendor/init.bat"
end

opt.fileencodings = "utf-8,big5,cp950,gbk,cp936,iso-2022-jp,sjis,euc-jp,japan,euc-kr,ucs-bom,utf-bom,latin1,iso8859-1"

opt.cursorline = true
opt.cursorlineopt = "number"

opt.colorcolumn = "81"

opt.list = true
opt.listchars = { tab = "» ", eol = "↓", trail = "·" }

opt.swapfile = false
