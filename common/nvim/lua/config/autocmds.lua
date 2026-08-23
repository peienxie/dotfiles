-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_user_command("LspInfo", function()
  vim.cmd("checkhealth vim.lsp")
end, {
  desc = "Open LSP health information in a new tab.",
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.tabnew({ vim.lsp.log.get_filename() })
end, {
  desc = "Open the Nvim LSP client log in a new tab.",
})
