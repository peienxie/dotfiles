-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local function unmap(mode, lhs)
  -- local mappings = vim.api.nvim_get_keymap(mode)
  -- if mappings[lhs] ~= nil then
  --   vim.keymap.del(mode, lhs)
  -- end
  vim.keymap.del(mode, lhs)
end

-- Escape from insert mode
map("i", "jj", "<Esc>")
map("i", "<C-c>", "<Esc>")

-- Delete without copying to clipboard
map("n", "<Leader>d", "\"_d")
map("v", "<Leader>d", "\"_d")
map("n", "x", "\"_x")
map("v", "x", "\"_x")

-- Remap window movement keymaps
unmap("n", "<C-h>")
unmap("n", "<C-j>")
unmap("n", "<C-k>")
unmap("n", "<C-l>")
map("n", "<Leader>h", "<C-w>h", { desc = "which_key_ignore" })
map("n", "<Leader>j", "<C-w>j", { desc = "which_key_ignore" })
map("n", "<Leader>k", "<C-w>k", { desc = "which_key_ignore" })
map("n", "<Leader>l", "<C-w>l", { desc = "which_key_ignore" })

-- Move Lines without autoindent
map("n", "<A-j>", "<Esc>:m .+1<CR>", { desc = "Move down" })
map("n", "<A-k>", "<Esc>:m .-2<CR>", { desc = "Move up" })
map("i", "<A-j>", "<Esc>:m .+1<CR>gi", { desc = "Move down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<CR>gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<CR>gv", { desc = "Move up" })

-- Delete buffer movement keymaps. Use `]b` and `[b` instead.
unmap("n", "<S-h>")
unmap("n", "<S-l>")
unmap("n", "<Leader>`")

-- Search and Replace
map("n", "<C-f>", "g#N", { silent = false, desc = "Search word under cursor" })
map("n", "gw", "g#N", { silent = false, desc = "Search word under cursor" })
map("x", "<C-f>", '"yy/<C-r>y<CR>N', { silent = false, desc = "Search word under cursor" })
map("x", "gw", '"yy/<C-r>y<CR>N', { silent = false, desc = "Search word under cursor" })

vim.cmd([[ 
function! EscapeAll()
	let @"=escape(@", '\\/.*$^~[]')
	let @"=substitute(@", '\n', '\\n', 'g')
	let @"=substitute(@", '\t', '\\t', 'g')
endfunction
]])
map(
  "x",
  "<C-r>",
  'y:call EscapeAll()<CR>:%s/<C-r>"//gc<Left><Left><Left>',
  { silent = false, desc = "Replace word under cursor" }
)

-- Add more undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")
map("i", "<Space>", "<Space><C-g>u")
map("i", "<CR>", "<CR><C-g>u")
map("i", "<BS>", "<BS><C-g>u")

-- Better indenting with tab
--map("v", "<Tab>", ">gv")
--map("v", "<S-Tab>", "<gv")

-- Open lazy.nvim homepage
map("n", "<Leader>L", "<Cmd>Lazy<CR>", { desc = "Lazy" })

-- Toggle Terminal
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
unmap("n", "<C-/>")
unmap("n", "<C-_>")
map("n", "<C-\\>", lazyterm, { desc = "Terminal (root dir)" })

-- Terminal Mappings
unmap("t", "<esc><esc>")
unmap("t", "<C-h>")
unmap("t", "<C-j>")
unmap("t", "<C-k>")
unmap("t", "<C-l>")
unmap("t", "<C-/>")
unmap("t", "<c-_>")
map("t", "<A-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<A-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<A-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<A-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Remap duplicated window splits keymaps and add `s` and `v` to split window
unmap("n", "<Leader>|")
unmap("n", "<Leader>-")
map("n", "<Leader>ws", "<C-w>s", { desc = "Split window below" })
map("n", "<Leader>wv", "<C-w>v", { desc = "Split window right" })

-- Tabs
unmap("n", "<leader><tab>l")
unmap("n", "<leader><tab>f")
unmap("n", "<leader><tab><tab>")
unmap("n", "<leader><tab>]")
unmap("n", "<leader><tab>d")
unmap("n", "<leader><tab>[")
map("n", "[<Tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "]<Tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
