return {
  -- Git integrations
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
      { "<Leader>gn", "<Cmd>Neogit<CR>", desc = "Open Neogit" },
    },
    opts = {
      disable_commit_confirmation = true,
      integrations = { diffview = true },
      disable_insert_on_commit = false,
      sections = {
        stashes = { folded = false, hidden = false },
        unpulled_upstream = { folded = false, hidden = false },
        recent = { folded = false, hidden = false },
      },
    },
  },

  -- Show git status on signcolumn
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        -- "│", "▎"
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "┃" },
        topdelete = { text = "┃" },
        changedelete = { text = "┃" },
        untracked = { text = "┃" },
      },
      current_line_blame = true,
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",
      preview_config = {
        border = "none",
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, opts)
          opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        local function next_hunk()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk({ preview = true })
          end)
          return "<Ignore>"
        end

        local function prev_hunk()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk({ preview = true })
          end)
          return "<Ignore>"
        end

        local function blame_line()
          gs.blame_line({ full = true })
        end
        -- local function diff_with_head()
        --   gs.diffthis("~")
        -- end

        -- Navigation
        map("n", "]c", next_hunk, { expr = true, desc = "Next Hunk" })
        map("n", "[c", prev_hunk, { expr = true, desc = "Prev Hunk" })
        -- map("n", "]c", gs.next_hunk, { desc = "Next Hunk" })
        -- map("n", "[c", gs.prev_hunk, { desc = "Prev Hunk" })

        -- Actions
        map({ "n", "v" }, "<leader>ga", "<Cmd>Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
        map({ "n", "v" }, "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
        map("n", "<leader>gA", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>gb", blame_line, { desc = "Blame Current Line" })
        -- map("n", "<leader>gd", gs.diffthis, { desc = "Diff This" })
        -- map("n", "<leader>gD", diff_with_head, { desc = "Diff Against Head(~) " })
        -- map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle Deleted" })
        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Hunk Object" })
      end,
    },
  },

  -- A better diffing view
  {
    "sindrets/diffview.nvim",
    enabled = true,
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

  -- Highlight conflicts and add keymaps for resolving conflicts
  {
    "akinsho/git-conflict.nvim",
    event = "VeryLazy",
    opts = {
      disable_diagnostics = true,
    },
    config = function(_, opts)
      require("git-conflict").setup(opts)

      -- vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#163333" })
      -- vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = "#181B20" })
      -- vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#162C43" })
      -- vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { bg = "#256b61" })
      -- vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { bg = "#2D2E32" })
      -- vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { bg = "#255A8A" })
    end,
  },
}
