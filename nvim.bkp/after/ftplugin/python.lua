-- keymaps for IPython terminal
local nnoremap = require("mylua.utils.keymap").nnoremap

nnoremap("<leader>rt", ":lua IPythonToggle()<CR>")
nnoremap("<leader>rl", ":lua IPythonRun('IPythonCellClear')<CR>")
nnoremap("<leader>rr", ":lua IPythonRun('IPythonCellExecuteCell')<CR>")
nnoremap("<leader>rj", ":lua IPythonRun('IPythonCellExecuteCellJump')<CR>")
nnoremap("<leader>rR", ":lua IPythonRun('IPythonCellRestart')<CR>")
nnoremap("]C", ":IPythonCellNextCell<CR>")
nnoremap("[C", ":IPythonCellPrevCell<CR>")
