local wezterm = require("wezterm")

local M = {}

M.setup = function(config)
  -- misc
  config.default_workspace = "main"
  config.window_close_confirmation = "AlwaysPrompt"
  -- always prompt confirmation on closing
  config.skip_close_confirmation_for_processes_named = {}

  if wezterm.target_triple:find("windows") then
    config.default_prog = { "cmd.exe", "/k", "%CMDER_ROOT%/vendor/init.bat" }
    config.window_decorations = "RESIZE|TITLE"
    wezterm.on("gui-startup", function()
      local _, _, window = wezterm.mux.spawn_window({})
      window:gui_window():maximize()
    end)
  else
    config.window_decorations = "RESIZE"
  end

  -- font
  config.font = wezterm.font_with_fallback({
    { family = "JetBrains Mono", weight = "Medium" },
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
    --{ family = "MesloLGS NF", scale = 1.2, weight = "Medium" },
  })
  config.font_size = 16

  -- appearance
  config.window_background_opacity = 0.9
  config.inactive_pane_hsb = { saturation = 0.2, brightness = 0.5 }
  config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
  config.enable_scroll_bar = false

  config.colors = {
    tab_bar = {
      background = "#283237",
      active_tab = {
        bg_color = "#f07178",
        fg_color = "#eeeeee",
      },
      inactive_tab = {
        bg_color = "#333333",
        fg_color = "#eeeeee",
      },
      new_tab = {
        bg_color = "#333333",
        fg_color = "#eeeeee",
      },
      inactive_tab_hover = {
        bg_color = "#777777",
        fg_color = "#eeeeee",
      },
      new_tab_hover = {
        bg_color = "#777777",
        fg_color = "#eeeeee",
      },
    },
  }
end

return M
