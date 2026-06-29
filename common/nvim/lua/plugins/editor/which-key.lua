return {
  -- Keymaps popup
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.spec["<leader><tab>"] = nil
      opts.spec["<leader>gh"] = nil
      opts.spec["<leader>gz"] = nil
      return opts
    end,
  },
}
