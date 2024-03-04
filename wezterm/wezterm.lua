local wezterm = require("wezterm")

local config = {}

-- font settings
config.font = wezterm.font("MesloLGS NF")
config.font_size = 16.0

-- window settings
-- config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
