return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      -- fast_wrap = {},
    },
    dependencies = {
      {
        "echasnovski/mini.pairs",
        enabled = false,
      },
    },
  },
}
