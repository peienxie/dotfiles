return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      -- fast_wrap = {},
    },
    dependencies = {
      {
        "nvim-mini/mini.pairs",
        enabled = false,
      },
    },
  },
}
