local nvim_tree = require'nvim-tree'
local nvim_tree_config = require'nvim-tree.config'
local tree_cb = nvim_tree_config.nvim_tree_callback

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = true,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {}
  },
  system_open = {
    cmd = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {
        { key = { "l" }, cb = tree_cb "edit" },
        { key = { "h" }, cb = tree_cb "close_node" },
      }
    },
    number = false,
    relativenumber = false,
    signcolumn = "yes"
  },
  actions = {
    open_file = {
      resize_window = true,
    }
  },
  renderer = {
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        }
      },
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = false,
      }
    }
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}

-- keymapping
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap("n", "<leader>ee", ":NvimTreeToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ef", ":NvimTreeFindFile<CR>", opts)
