return {
  "nvim-telescope/telescope.nvim",
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      results_title = false,
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
        horizontal = {
          width = function(_, max_columns, _)
            return math.min(max_columns, 160)
          end,

          height = function(_, _, max_lines)
            return math.min(max_lines, 40)
          end,
        },
      },
      preview = { hide_on_startup = true },
      -- stylua: ignore
      mappings = {
        i = {
          ["<M-p>"] = function(...) return require("telescope.actions.layout").toggle_preview(...) end,
          ["<C-Down"] = nil,
          ["<C-j>"] = function(...) return require("telescope.actions").cycle_history_next(...) end,
          ["<C-Up"] = nil,
          ["<C-k>"] = function(...) return require("telescope.actions").cycle_history_prev(...) end,
        },
        n = {
          ["<M-p>"] = function(...) return require("telescope.actions.layout").toggle_preview(...) end,
          ["gg"] = function(...) return require("telescope.actions").move_to_top(...) end,
          ["G"] = function(...) return require("telescope.actions").move_to_bottom(...) end,
        },
      },
    },
    pickers = {
      buffers = {
        sort_mru = true,
        -- stylua: ignore
        mappings = {
          i = {
            ["<C-d>"] = function(...) return require("telescope.actions").delete_buffer(...) end,
            ["<C-j>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
            ["<C-k>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
          },
          n = {
            ["<C-d>"] = function(...) return require("telescope.actions").delete_buffer(...) end,
            ["dd"] = function(...) return require("telescope.actions").delete_buffer(...) end,
          },
        },
      },
    },
  },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}
