return {
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
      stashes = { folded = false },
      unpulled = { folded = false },
      recent = { folded = false },
    },
  },
}
