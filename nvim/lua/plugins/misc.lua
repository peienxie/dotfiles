return {
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle" },
    keys = {
      { "<Leader>fu", "<Cmd>UndotreeToggle<CR>", desc = "Undo History" },
    },
    init = function()
      -- don't open diff window on default
      vim.g.undotree_DiffAutoOpen = 0

      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 2
    end,
  },
  {
    "ThePrimeagen/harpoon",
    -- stylua: ignore
    keys = {
      { "<leader>HH", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
      { "<leader>Hh", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
      { "<leader>Ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon Add File" },
      { "<leader>1", function() require("harpoon.ui").nav_file(1) end, desc = "which_key_ignore" },
      { "<leader>2", function() require("harpoon.ui").nav_file(2) end, desc = "which_key_ignore" },
      { "<leader>3", function() require("harpoon.ui").nav_file(3) end, desc = "which_key_ignore" },
      { "<leader>4", function() require("harpoon.ui").nav_file(4) end, desc = "which_key_ignore" },
      { "<leader>5", function() require("harpoon.ui").nav_file(5) end, desc = "which_key_ignore" },
      { "<leader>6", function() require("harpoon.ui").nav_file(6) end, desc = "which_key_ignore" },
      { "<leader>7", function() require("harpoon.ui").nav_file(7) end, desc = "which_key_ignore" },
      { "<leader>8", function() require("harpoon.ui").nav_file(8) end, desc = "which_key_ignore" },
      { "<leader>9", function() require("harpoon.ui").nav_file(9) end, desc = "which_key_ignore" },
      { "<leader>0", function() require("harpoon.ui").nav_file(10) end, desc = "which_key_ignore" },
    },
    opts = {},
    dependencies = {
      {
        "folke/which-key.nvim",
        opts = {
          defaults = {
            ["<leader>H"] = "+Harpoon",
          },
        },
      },
    },
  },
}
