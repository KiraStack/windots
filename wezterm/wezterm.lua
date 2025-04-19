-- Modules
local wezterm = require("wezterm")

-- Service
local config = wezterm.config_builder()

-- References
local themes = {
	Standard = "Tokyo Night",
	Storm = "Tokyo Night Storm",
	Moon = "Tokyo Night Moon",
	Day = "Tokyo Night Day",
	Night = "Tokyo Night Night",
}

-- Settings
local override_theme = nil

-- Auxiliary
local function resolve_scheme()
	if override_theme and themes[override_theme] then
		return themes[override_theme]
	end
	local appearance = wezterm.gui.get_appearance()
	return appearance:find("Dark") and themes.Storm or themes.Day
end

-- Functions
local function bind_tabs(keys, mods)
	local func = wezterm.action.ActivateTab
	for i = 1, 9 do
		keys[#keys + 1] = {key = tostring(i), mods = mods, action = func(i - 1)}
	end
end


-- Variables
config.color_scheme = resolve_scheme()
config.font = wezterm.font("JetBrains Mono")
config.font_size = 16
config.bold_brightens_ansi_colors = true
config.default_cursor_style = "SteadyBar"
config.default_prog = { "powershell.exe", "-nologo" }
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.automatically_reload_config = true
config.disable_default_key_bindings = true

-- Main functions
config.leader = {
  key = "Space",
  mods = "CTRL|SHIFT",
  timeout_milliseconds = 1000,
}

config.keys = {
  { key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
  { key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
  { key = "n", mods = "CTRL|SHIFT", action = wezterm.action.ToggleFullScreen },
  { key = "d", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "e", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
}

bind_tabs(config.keys, "CTRL|ALT")

return config
