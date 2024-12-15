return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gD", "<Cmd>DiffviewFileHistory %<CR>", desc = "Open diffview for current file" },
      { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Open diffview" },
    },
    opts = {
      keymaps = {
        view = {
          ["q"] = "<Cmd>tabclose<CR>",
        },
        file_panel = {
          ["q"] = "<Cmd>tabclose<CR>",
          ["?"] = "<Cmd>h diffview-maps-file-panel<CR>",
        },
        file_history_panel = {
          ["q"] = "<Cmd>tabclose<CR>",
          ["?"] = "<Cmd>h diffview-maps-file-history-panel<CR>",
        },
      },
    },
  },
}
