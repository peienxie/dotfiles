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
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    opts = {
      enable = true, -- enable this plugin (can be enabled/disabled later via commands)
      throttle = true, -- throttles plugin updates (may improve performance)
      max_lines = 0, -- how many lines the window should span. values <= 0 mean no limit.
      trim_scope = "outer", -- which context lines to discard if `max_lines` is exceeded. choices: 'inner', 'outer'
      patterns = { -- match patterns for ts nodes. these get wrapped to match at word boundaries.
        -- for all filetypes
        -- note that setting an entry here replaces all other patterns for this entry.
        -- by setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "switch",
          "case",
        },
        markdown = {
          "section",
        },
      },
    },
  },
}
