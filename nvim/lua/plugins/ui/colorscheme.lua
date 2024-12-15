return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },
  {
    "gruvbox-community/gruvbox",
    enabled = false,
  },
  {
    "dracula/vim",
    name = "dracula",
    enabled = false,
  },
  -- { "ayu-theme/ayu-vim", enabled = false },
  {
    "Luxed/ayu-vim",
    enabled = false,
    init = function()
      -- access the ayu#palette variable first then let plugin autoload this variable
      -- otherwise it is undefined variable
      vim.api.nvim_get_var("ayu#palette")

      -- not sure why this is not working, need use vim.cmd to assign variable
      --vim.g["ayu#palette"]["ui_panel_bg"]["dark"] = "#30353e"

      -- make float windows more visible
      vim.cmd('let g:ayu#palette["ui_panel_bg"]["dark"] = "#30353e"')
      -- make selected item more visible
      vim.cmd('let g:ayu#palette["ui_selection_active"]["dark"] = "#30353e"')
      -- Search and IncSearch
      vim.cmd('let g:ayu#palette["editor_findMatch_active"]["dark"] = "#897199"')
      vim.cmd('let g:ayu#palette["editor_findMatch_inactive"]["dark"] = "#5b5767"')

      vim.g.ayucolor = "dark"
      vim.cmd([[ colorscheme ayu ]])
    end,
  },
}
