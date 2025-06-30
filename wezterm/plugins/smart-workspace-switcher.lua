local wezterm = require("wezterm")

local M = {}

M.setup = function(config)
  local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
  workspace_switcher.apply_to_config(config)
end

return M
