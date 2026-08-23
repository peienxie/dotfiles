return {
  {
    "snacks.nvim",
    keys = {
      { "<Leader>.", false },
      { "<Leader>S", false },
      {
        "<leader>fs",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>fS",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
    },
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
    },
  },
}
