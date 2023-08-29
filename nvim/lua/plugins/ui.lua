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
      messages = { view_search = false },
    },
  },
  {
    "SmiteshP/nvim-navic",
    opts = {
      separator = " ",
      highlight = true,
      depth_limit = 0,
      icons = require("lazyvim.config").icons.kinds,
    },
  },
}
