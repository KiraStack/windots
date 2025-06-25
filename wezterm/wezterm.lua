-- Modules
-- Load the wezterm module
local wezterm = require("wezterm")

-- Services
-- Create a new configuration builder
local config = wezterm.config_builder()

-- References
-- Define your favourite themes here
local themes = {
	Standard = "Tokyo Night",
	Storm = "Tokyo Night Storm",
	Moon = "Tokyo Night Moon",
	Day = "Tokyo Night Day",
	Night = "Tokyo Night Night",
}

-- Settings
-- Set the theme to override the default
local override_theme = nil

-- Auxiliary
-- Resolve the theme based on the current appearance
local function resolve_scheme()
	-- Use the override theme if provided, otherwise determine the theme based on the current appearance
	if override_theme and themes[override_theme] then
		return themes[override_theme]
	end

	-- Get the current appearance and set the theme accordingly
	local appearance = wezterm.gui.get_appearance()
	return appearance:find("Dark") and themes.Storm or themes.Day
end

-- Functions
-- Binds tab keys to switch between tabs.
local function bind_tabs(keys, mods)
	-- Get the action for switching to the specified tab
	local func = wezterm.action.ActivateTab

	-- Adjust the index to match the actual tab numbers
	for i = 1, 9 do
		keys[#keys + 1] = { key = tostring(i), mods = mods, action = func(i - 1) }
	end
end

-- Variables
config.color_scheme = resolve_scheme() -- Apply the resolved theme
config.font = wezterm.font("JetBrains Mono") -- Set the font
config.font_size = 16 -- Set the font size
config.bold_brightens_ansi_colors = true -- Enable bold brightening of ANSI colors
config.default_cursor_style = "SteadyBar" -- Set the cursor style
config.default_prog = { "powershell", "-nologo" } -- Set the default program
config.window_decorations = "RESIZE" -- Enable window decorations
config.hide_tab_bar_if_only_one_tab = true -- Hide the tab bar if there's only one tab
config.automatically_reload_config = true -- Automatically reload the configuration when it changes
config.disable_default_key_bindings = true -- Disable default key bindings

-- Define the leader key
config.leader = {
	key = "Space",
	mods = "CTRL|SHIFT",
	timeout_milliseconds = 1000,
}

-- Define your custom key bindings here
config.keys = {
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "n", mods = "CTRL|SHIFT", action = wezterm.action.ToggleFullScreen },
	{ key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
}

-- Bind tab keys
bind_tabs(config.keys, "CTRL|ALT")

return config
