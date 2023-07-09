return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.defaults["<leader><tab>"] = nil
    opts.defaults["<leader>gh"] = nil
    opts.defaults["<leader>gz"] = nil
    opts.defaults["<leader>m"] = "+markdown"
    return opts
  end,
}
