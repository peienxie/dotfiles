return {
  {
    "mfussenegger/nvim-jdtls",
    enabled = false,
  },
  {
    "hsanson/vim-android",
    enabled = false,
    init = function()
      vim.g.android_sdk_path = os.getenv("HOME") .. "/Android/Sdk"
    end,
  },
}
