return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<Leader>e", false },
      { "<Leader>E", false },
    },
    opts = {
      window = {
        mappings = {
          ["S"] = "split_with_window_picker",
          ["s"] = "vsplit_with_window_picker",
          ["l"] = "open_with_window_picker",
          ["<CR>"] = "open_with_window_picker",
          ["P"] = { "toggle_preview", config = { use_float = true } },
          -- remap fuzzy_search from `/` to `F`
          ["/"] = {},
          ["F"] = "fuzzy_finder",
        },
      },
    },
    dependencies = {
      {
        -- only needed if you want to use the commands with "_with_window_picker" suffix
        "s1n7ax/nvim-window-picker",
        version = "v1.*",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
            other_win_hl_color = "#589ed7",
            -- whether to show 'Pick window:' prompt
            show_prompt = false,
          })
        end,
      },
    },
  },
}
