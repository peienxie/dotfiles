-- keymaps for IPython terminal
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>rt", ":lua IPythonToggle()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rl", ":lua IPythonRun('IPythonCellClear')<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rr", ":lua IPythonRun('IPythonCellExecuteCell')<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rj", ":lua IPythonRun('IPythonCellExecuteCellJump')<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rR", ":lua IPythonRun('IPythonCellRestart')<CR>", opts)
vim.api.nvim_set_keymap("n", "]C", ":IPythonCellNextCell<CR>", opts)
vim.api.nvim_set_keymap("n", "[C", ":IPythonCellPrevCell<CR>", opts)

