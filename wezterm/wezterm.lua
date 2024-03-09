local wezterm = require("wezterm")
local keymaps = require("keymaps")
local options = require("options")
local tabbar = require("tabbar")

local config = wezterm.config_builder()
keymaps.setup(config)
options.setup(config)
tabbar.setup(config)

return config
