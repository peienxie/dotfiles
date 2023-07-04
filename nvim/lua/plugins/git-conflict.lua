return {
  "akinsho/git-conflict.nvim",
  event = "VeryLazy",
  opts = {
    disable_diagnostics = true,
  },
  config = function(_, opts)
    require("git-conflict").setup(opts)

    -- vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#163333" })
    -- vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#181B20" })
    -- vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#162C43" })
    -- vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "#256b61" })
    -- vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { bg = "#2D2E32" })
    -- vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "#255A8A" })
  end,
}
