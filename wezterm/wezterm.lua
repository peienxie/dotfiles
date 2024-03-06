local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- misc
config.default_workspace = "main"
config.window_close_confirmation = "AlwaysPrompt"
-- always prompt confirmation on closing
config.skip_close_confirmation_for_processes_named = {}

if wezterm.target_triple:find("windows") then
	config.default_prog = { "cmd.exe", "/k", "%CMDER_ROOT%/vendor/init.bat" }
	config.window_decorations = "RESIZE|TITLE"
	-- wezterm.on("gui-startup", function()
	-- 	local tab, pane, window = wezterm.mux.spawn_window({})
	-- 	window:gui_window():maximize()
	-- end)
else
	config.window_decorations = "RESIZE"
end

-- font
config.font = wezterm.font_with_fallback({
	{ family = "MesloLGS NF", scale = 1.2, weight = "Medium" },
})
config.font_size = 16

-- appearance
config.window_background_opacity = 0.9
config.inactive_pane_hsb = { saturation = 0.2, brightness = 0.5 }
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.enable_scroll_bar = false

-- tab bar
config.switch_to_last_active_tab_when_closing_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local colors = {
		fg = "#ffffff",
		bg = tab.is_active and "#f07178" or (hover and "#777777" or "#333333"),
	}
	local icon
	if tab.active_pane.is_zoomed then
		icon = "🔎"
	else
		icon = ""
	end

	-- Equivalent to POSIX basename(3)
	-- Given "/foo/bar" returns "bar"
	-- Given "c:\\foo\\bar" returns "bar"
	local basename = function(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	local title
	local cwd = string.gsub(tostring(tab.active_pane.current_working_dir or ""), "^file://[/]?", "")
	-- the dir has a trailing slash on windows
	cwd = string.gsub(cwd, "[/\\]$", "")
	wezterm.log_info("cwd: " .. cwd)
	if tab.tab_title and #tab.tab_title > 0 then
		title = tab.tab_title
	elseif cwd == os.getenv("HOME") then
		title = "~"
	else
		local base_dir = basename(cwd)
		wezterm.log_info("base_dir: " .. base_dir)
		title = base_dir
	end
	return {
		{ Foreground = { Color = colors.fg } },
		{ Background = { Color = colors.bg } },
		{ Text = string.format(" %s%d:%s ", icon, tab.tab_index + 1, title) },
	}
end)

-- status line
wezterm.on("update-status", function(window, pane)
	local colors = {
		fg = (window:leader_is_active() or window:active_key_table()) and "#111111" or "#ffffff",
		bg = (window:leader_is_active() or window:active_key_table()) and "#b9cc52" or "#4b2a92",
	}
	local status_text = window:active_key_table() or window:active_workspace()
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = colors.fg } },
		{ Background = { Color = colors.bg } },
		{ Text = "  " .. status_text .. " " },
	}))
	local datetime_text = wezterm.strftime("%a %m/%d %H:%M:%S")
	window:set_right_status(wezterm.format({
		{ Foreground = { Color = colors.fg } },
		{ Background = { Color = colors.bg } },
		{ Text = "  " .. datetime_text .. " " },
	}))
end)

-- keymaps
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },
	-- { key = "r", mods = "LEADER|SHIFT", action = act.ReloadConfiguration },

	-- Pane keybindings
	{ key = "%", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = '"', mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Right") },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	-- We can make separate keybindings for resizing panes
	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "RESIZE",
			until_unknown = true,
			timeout_milliseconds = 1000,
			one_shot = false,
		}),
	},

	-- Tab keybindings
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	-- navigating tabs
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "l", mods = "LEADER", action = act.ActivateLastTab },
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
	{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
	{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
	{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
	{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },
	{ key = "0", mods = "LEADER", action = act.ActivateTab(9) },
	{
		key = "T",
		mods = "LEADER",
		action = act.ActivateKeyTable({
			name = "TAB",
			until_unknown = true,
			timeout_milliseconds = 1000,
			one_shot = false,
		}),
	},
	-- renaming tab
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "New tab name",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	-- listing workspaces
	{ key = "s", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
	{
		key = "$",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "New workspace name",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
				end
			end),
		}),
	},
	{ key = ")", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(1) },
	{ key = "(", mods = "LEADER|SHIFT", action = act.SwitchWorkspaceRelative(-1) },
}

config.key_tables = {
	["RESIZE"] = {
		{ key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "q", action = "PopKeyTable" },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	["TAB"] = {
		{ key = "n", action = act.ActivateTabRelative(1) },
		{ key = "p", action = act.ActivateTabRelative(-1) },
		{ key = ">", mods = "SHIFT", action = act.MoveTabRelative(1) },
		{ key = "<", mods = "SHIFT", action = act.MoveTabRelative(-1) },
		--{ key = "h", action = act.MoveTabRelative(-1) },
		--{ key = "j", action = act.MoveTabRelative(1) },
		--{ key = "k", action = act.MoveTabRelative(-1) },
		--{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "q", action = "PopKeyTable" },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

return config
