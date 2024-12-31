return {
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          { section = "header" },
          { section = "keys", padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 1, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 1, padding = 1 },
          { section = "startup" },
        },
      },
      scroll = { enabled = false },
      ident = {
        animate = {
          enabled = false,
        },
      },
      input = {
        -- reference: https://github.com/folke/snacks.nvim/discussions/376
        win = {
          keys = {
            i_del_word = { "<C-w>", "delete_word", mode = "i" },
          },
          actions = {
            delete_word = function()
              return "<cmd>normal! diw<cr><right>"
            end,
          },
        },
      },
    },
  },
}
