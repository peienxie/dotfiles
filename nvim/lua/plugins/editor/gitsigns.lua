return {
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
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "┃" },
        topdelete = { text = "┃" },
        changedelete = { text = "┃" },
        untracked = { text = "┃" },
      },
      signs_staged_enable = true,
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
}
