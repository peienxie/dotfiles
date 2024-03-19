return {
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-cmdline" },
    },
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
    config = function(_, opts)
      local cmp = require("cmp")
      local function get_millisecond()
        local second, microsecond = vim.loop.gettimeofday()
        return 1000 * second + microsecond / 1000
      end
      local last_selection_time = 0
      local function select_or_fallback(select_action)
        return cmp.mapping(function(fallback)
          if cmp.visible() and get_millisecond() - last_selection_time > 1000 then
            select_action()
          else
            cmp.close()
            fallback()
            last_selection_time = get_millisecond()
          end
        end, { "i", "c" })
      end
      local cmdline_mapping = cmp.mapping.preset.cmdline({
        ["<C-n>"] = select_or_fallback(cmp.select_next_item),
        ["<C-p>"] = select_or_fallback(cmp.select_prev_item),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmdline_mapping,
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })
      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noselect,noinsert" },
        mapping = cmdline_mapping,
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
          { name = "buffer" },
        }),
      })
      cmp.setup(opts)
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
