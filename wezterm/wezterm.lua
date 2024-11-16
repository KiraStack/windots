local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Function to determine the color scheme based on appearance
function scheme_for_appearance(appearance)
	return (appearance:find("Dark") and "OneDark (base16)") or "One Light (base16)"
end

-- Set color scheme dynamically based on system appearance
local appearance = wezterm.gui.get_appearance()
config.color_scheme = scheme_for_appearance(appearance)

-- Font settings
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16
config.bold_brightens_ansi_colors = true

-- Cursor and window settings
config.default_cursor_style = "SteadyBar"
config.default_prog = { "powershell.exe", "-nologo" }
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Auto-reload and keybindings
config.automatically_reload_config = true
config.disable_default_key_bindings = true

-- Leader key settings
config.leader = {
	key = "Space",
	mods = "CTRL|SHIFT",
	timeout_milliseconds = 1000,
}

-- Custom key bindings
config.keys = {
	-- Pane and tab management
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") }, -- New tab
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) }, -- Close pane with confirmation

	-- Window management
	{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action.ToggleFullScreen }, -- Toggle fullscreen
	{ key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) }, -- Horizontal split
	{ key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- Vertical split

	-- Clipboard management
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") }, -- Copy to clipboard
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") }, -- Paste from clipboard
}

-- Tab activation (CTRL+ALT+1-8)
for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
