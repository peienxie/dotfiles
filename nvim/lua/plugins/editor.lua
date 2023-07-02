return {
  {
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
    -- Disable Leap keymaps
    keys = function()
      return {}
    end,
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      -- leap.add_default_mappings(true)
      -- vim.keymap.del({ "x", "o" }, "x")
      -- vim.keymap.del({ "x", "o" }, "X")
    end,
    opts = {
      -- stylua: ignore
      safe_labels = {
        "f", "n", "u", "t", "/",
        "F", "N", "L", "H", "M", "U", "G", "T", "?", "Z"
      },
      -- stylua: ignore
      leabels = {
        "f", "n",
        "j", "k", "l", "h", "o", "d", "w", "e", "m", "b",
        "u", "y", "v", "r", "g", "t", "c", "x", "/", "z",
        "F", "N",
        "J", "K", "L", "H", "O", "D", "W", "E", "M", "B",
        "U", "Y", "V", "R", "G", "T", "C", "X", "?", "Z"
      },
    },
  },
}
