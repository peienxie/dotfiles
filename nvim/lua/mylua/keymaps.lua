local nnoremap = require("mylua.utils.keymap").nnoremap
local inoremap = require("mylua.utils.keymap").inoremap
local cnoremap = require("mylua.utils.keymap").cnoremap
local vnoremap = require("mylua.utils.keymap").vnoremap

-- use space as leader key
vim.g.mapleader = " "

-- escape
inoremap("jj", "<Esc>")
inoremap("<C-c>", "<Esc>")
nnoremap("<C-c>", "<Cmd>nohl<CR>")

-- show the highlight group of symbol under cursor
nnoremap("<F10>", ":TSHighlightCapturesUnderCursor<CR>")

-- disable some default keymapping which I don't wanna use
nnoremap("Q", "<nop>")
nnoremap("q:", "<nop>")

-- make Y work the same as D and C
nnoremap("Y", "y$")

-- keep cursor center when jumpping search result
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")

-- source myvimrc
nnoremap("<leader><CR>", ":luafile $MYVIMRC<CR>", { silent = false })

-- yank to system clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
-- paste from system clipboard
nnoremap("<leader>p", '"+p')
nnoremap("<leader>P", '"+P')
-- replace current selected text
vnoremap("<leader>dp", '"_dP')

-- delete without copying to clipboard
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')
nnoremap("x", '"_x')
vnoremap("x", '"_xgv')

-- search the word under cursor
nnoremap("<C-f>", "g#N", { silent = false })
vnoremap("<C-f>", 'y/<C-r>"<CR>N', { silent = false })

-- replace selected word
vim.cmd([[ 
function! EscapeAll()
	let @"=escape(@", '\\/.*$^~[]')
	let @"=substitute(@", '\n', '\\n', 'g')
	let @"=substitute(@", '\t', '\\t', 'g')
endfunction
]])
vnoremap("<C-r>", 'y:call EscapeAll()<CR>:%s/<C-r>"//gc<Left><Left><Left>', { silent = false })

-- search in visually hightlighted range
vnoremap("g/", "<Esc>/\\%V", { silent = false })

-- 'n' go down and 'N' go up when searching
nnoremap("n", "'Nn'[v:searchforward]", { silent = false, expr = true })
nnoremap("N", "'nN'[v:searchforward]", { silent = false, expr = true })

-- add and remove \< \> to match whole word
cnoremap("<A-w>", "<Home>\\<<End>\\>", { silent = false })
cnoremap("<A-W>", "<Home><Del><Del><End><Backspace><Backspace>", { silent = false })
nnoremap("<A-w>", "/<Up><Home>\\<<End>\\><CR>N", { silent = false })
nnoremap("<A-W>", "/<Up><Home><Del><Del><End><Backspace><Backspace><CR>N", { silent = false })

-- add and remove \C to match case sensitive
cnoremap("<A-c>", "<End>\\C", { silent = false })
cnoremap("<A-C>", "<End><Backspace><Backspace>", { silent = false })
nnoremap("<A-c>", "/<Up><End>\\C<CR>N", { silent = false })
nnoremap("<A-C>", "/<Up><End><Backspace><Backspace><CR>N", { silent = false })

-- move current line/block up and down
inoremap("<A-j>", "<Esc>:m .+1<CR>gi")
inoremap("<A-k>", "<Esc>:m .-2<CR>gi")
nnoremap("<A-j>", "<Esc>:m .+1<CR>")
nnoremap("<A-k>", "<Esc>:m .-2<CR>")
vnoremap("<A-j>", ":m '>+1<CR>gv")
vnoremap("<A-k>", ":m '<-2<CR>gv")

-- indent but remain in visual mode
vnoremap(">", ">gv")
vnoremap("<", "<gv")
vnoremap("<Tab>", ">gv")
vnoremap("<S-Tab>", "<gv")

-- move around windows
nnoremap("<leader>h", "<C-w>h")
nnoremap("<leader>j", "<C-w>j")
nnoremap("<leader>k", "<C-w>k")
nnoremap("<leader>l", "<C-w>l")
nnoremap("<leader>q", "<C-w>q")
nnoremap("<leader>ss", ":split<CR>")
nnoremap("<leader>sv", ":vsplit<CR>")

-- quickfix and location navigation
nnoremap("]q", ":cnext<CR>")
nnoremap("[q", ":cprev<CR>")
nnoremap("]Q", ":clast<CR>")
nnoremap("[Q", ":cfirst<CR>")
nnoremap("]l", ":lnext<CR>")
nnoremap("[l", ":lprev<CR>")
nnoremap("]L", ":llast<CR>")
nnoremap("[L", ":lfirst<CR>")

-- buffer and tab navigation
nnoremap("]b", ":bnext<CR>")
nnoremap("[b", ":bprev<CR>")
nnoremap("]t", ":tabnext<CR>")
nnoremap("[t", ":tabprev<CR>")

-- add more undo break points
-- note that vscode and ideavim currently is not supported <C-g> command
if vim.fn.has("nvim") then
	inoremap("<Space>", "<Space><C-g>u")
	inoremap("<CR>", "<CR><C-g>u")
	inoremap("<BS>", "<BS><C-g>u")
end
