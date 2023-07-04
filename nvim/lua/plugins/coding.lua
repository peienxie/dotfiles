return {
  -- Use tpope/vim-surround instead
  {
    "echasnovski/mini.surround",
    enabled = false,
  },
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  -- Set indentation automatically.
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },

  -- Use auto-pairs instead.
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "jiangmiao/auto-pairs",
    event = "VeryLazy",
    init = function()
      vim.g.AutoPairsMultilineClose = 0
      vim.g.AutoPairsShortcutToggle = ""
      vim.g.AutoPairsShortcutJump = ""
      vim.g.AutoPairsShortcutBackInsert = ""
    end,
  },

  -- Use Comment instead.
  {
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      -- Add a space b/w comment and the line
      padding = true,
      -- Whether the cursor should stay at its position
      -- NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
      sticky = true,
      -- Lines to be ignored while comment/uncomment.
      -- Could be a regex string or a function that returns a regex string.
      -- Example: Use '^$' to ignore empty lines
      ignore = "^$",
      -- LHS of toggle mappings in NORMAL + VISUAL mode
      toggler = {
        -- Line-comment toggle keymap
        line = "gcc",
        -- Block-comment toggle keymap
        block = "gbc",
      },
      -- LHS of operator-pending mappings in NORMAL + VISUAL mode
      opleader = {
        -- Line-comment keymap
        line = "gc",
        -- Block-comment keymap
        block = "gb",
      },
      -- LHS of extra mappings
      extra = {
        -- Add comment on the line above
        above = "gcO",
        -- Add comment on the line below
        below = "gco",
        -- Add comment at the end of line
        eol = "gcA",
      },
      -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
      mappings = {
        -- Operator-pending mapping
        -- Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        -- NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        -- Extra mapping
        -- Includes `gco`, `gcO`, `gcA`
        extra = true,
      },
      -- Pre-hook, called before commenting the line
      pre_hook = nil,
      -- Post-hook, called after commenting is done
      post_hook = nil,
    },
  },
}
