return {
  {
    "rcarriga/nvim-notify",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = { event = "msg_show", kind = "search_count" },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      cmdline = {
        view = "cmdline",
      },
      popupmenu = {
        backend = "cmp",
      },
      messages = { view_search = false },
    },
  },
  {
    "SmiteshP/nvim-navic",
    opts = {
      lsp = {
        auto_attach = true,
      },
      separator = " ",
      highlight = true,
      depth_limit = 5,
      icons = require("lazyvim.config").icons.kinds,
    },
  },
}
