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
        win = {
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
