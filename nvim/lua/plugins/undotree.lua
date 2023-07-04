return {
  "mbbill/undotree",
  cmd = { "UndotreeToggle" },
  keys = {
    { "<Leader>fu", "<Cmd>UndotreeToggle<CR>", desc = "Undo History" },
  },
  init = function()
    -- don't open diff window on default
    vim.g.undotree_DiffAutoOpen = 0

    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_WindowLayout = 2
  end,
}
