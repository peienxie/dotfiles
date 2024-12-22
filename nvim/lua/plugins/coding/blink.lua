return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lsp", "path", "snippets" },
      },
      completion = {
        menu = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat",
        },
        list = {
          selection = "manual",
        },
        documentation = {
          window = { border = "rounded" },
          auto_show = true,
          auto_show_delay_ms = 0,
        },
        ghost_text = {
          enabled = false,
        },
      },
      signature = {
        window = { border = "rounded" },
      },
      keymap = {
        ["<C-b>"] = {},
        ["<C-f>"] = {},
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
    },
  },
}
