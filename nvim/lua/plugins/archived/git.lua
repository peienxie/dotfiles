return {
  -- Git integrations
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<Leader>gn", "<Cmd>Neogit<CR>", desc = "Open Neogit" },
    },
    opts = {
      disable_commit_confirmation = true,
      integrations = { diffview = true },
      disable_insert_on_commit = false,
      sections = {
        stashes = { folded = false, hidden = false },
        unpulled_upstream = { folded = false, hidden = false },
        recent = { folded = false, hidden = false },
      },
    },
  },

  -- Highlight conflicts and add keymaps for resolving conflicts
  {
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
  },
}
