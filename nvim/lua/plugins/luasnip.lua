return {
  "L3MON4D3/LuaSnip",
  keys = function()
    return {
      {
        "<C-j>",
        function()
          if require("luasnip").jumpable(1) then
            require("luasnip").jump(1)
          end
        end,
        mode = { "i", "s" },
        desc = "Next Snippet",
      },
      {
        "<C-k>",
        function()
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          end
        end,
        mode = { "i", "s" },
        desc = "Previous luasnip",
      },
    }
  end,
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  },
}
