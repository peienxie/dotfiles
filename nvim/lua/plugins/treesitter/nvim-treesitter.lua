return {
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<M-y>", desc = "Increment selection" },
      { "<M-S-y>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<M-y>",
          node_incremental = "<M-y>",
          scope_incremental = false,
          node_decremental = "<M-S-y>",
        },
      },
    },
  },
}
