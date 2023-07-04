return {
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
}
