local wezterm = require("wezterm")
local keymaps = require("keymaps")
local options = require("options")
local tabbar = require("tabbar")
-- Plugins
local smart_workspace_switcher = require("plugins.smart-workspace-switcher")
local resurrect = require("plugins.resurrect")

local config = wezterm.config_builder()
keymaps.setup(config)
options.setup(config)
tabbar.setup(config)

smart_workspace_switcher.setup(config)
resurrect.setup(config)

return config
