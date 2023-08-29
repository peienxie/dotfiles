return {
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      -- update keymaps
      opts.mapping["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
      opts.mapping["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })
      opts.mapping["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      opts.mapping["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      opts.mapping["<C-u>"] = cmp.mapping.scroll_docs(-4)
      opts.mapping["<C-d>"] = cmp.mapping.scroll_docs(4)
      opts.mapping["<C-Space>"] = cmp.mapping.complete()
      opts.mapping["<C-e>"] = cmp.mapping.close()
      opts.mapping["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert })
      opts.mapping["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace })
      -- Uncomment below 2 lines let cmp don't preselect the first item
      -- opts.completion = { completeopt = "menu,menuone,noinsert,noselect" }
      -- opts.preselect = cmp.PreselectMode.None
      return opts
    end,
  },

  -- Snippets
  {
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
  },
}
