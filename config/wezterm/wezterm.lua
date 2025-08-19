-- ╭──────────────────────────────────────────────────────────────╮
-- │                          Dotfiles                            │
-- │                        KiraStack/dots                        │
-- │                                                              │
-- │       ~ Minimalist ~ Fast ~ Maintainable ~ Lua-powered ~     │
-- ╰──────────────────────────────────────────────────────────────╯

-- ╭──────────────────────────────────────────────────────────────╮
-- │                       Initialization                         │
-- ╰──────────────────────────────────────────────────────────────╯

local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ╭──────────────────────────────────────────────────────────────╮
-- │                       OS Detection                           │
-- ╰──────────────────────────────────────────────────────────────╯

local function get_os()
	local extension = package.cpath:match("%.([a-z]+)$")

	if extension == "dll" then
		return "windows"
	elseif extension == "so" then
		return "linux"
	elseif extension == "dylib" then
		return "macos"
	else
		return "unknown"
	end
end

local host_os = get_os()

-- ╭──────────────────────────────────────────────────────────────╮
-- │                      Theme Management                        │
-- ╰──────────────────────────────────────────────────────────────╯

-- local themes = {
--     Standard = 'Tokyo Night',
--     Storm = 'Tokyo Night Storm',
--     Moon = 'Tokyo Night Moon',
--     Day = 'Tokyo Night Day',
--     Night = 'Tokyo Night Night',
-- }

-- local override_theme = nil
-- local function resolve_scheme()
--     if override_theme and themes[override_theme] then
--         return themes[override_theme]
--     end
--     local appearance = wezterm.gui.get_appearance()
--     return appearance:find('Dark') and themes.Storm or themes.Day
-- end

-- ╭──────────────────────────────────────────────────────────────╮
-- │                       Font Configuration                     │
-- ╰──────────────────────────────────────────────────────────────╯

local emoji_font = "Segoe UI Emoji"
config.font = wezterm.font_with_fallback({ "JetBrains Mono", emoji_font })
config.font_size = 16
config.bold_brightens_ansi_colors = true

-- ╭──────────────────────────────────────────────────────────────╮
-- │                      Color Configuration                     │
-- ╰──────────────────────────────────────────────────────────────╯

-- config.color_scheme = resolve_scheme()
config.colors = require("cyberdream")
config.force_reverse_video_cursor = true

-- ╭──────────────────────────────────────────────────────────────╮
-- │                     Window Configuration                     │
-- ╰──────────────────────────────────────────────────────────────╯

config.window_background_image = (os.getenv("WEZTERM_CONFIG_FILE") or ""):gsub("wezterm.lua", "bg-blurred.png")
config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"
config.default_cursor_style = "SteadyBar"
config.window_close_confirmation = "NeverPrompt"
config.win32_system_backdrop = "Acrylic"
config.hide_tab_bar_if_only_one_tab = true

-- ╭──────────────────────────────────────────────────────────────╮
-- │                     Performance Settings                     │
-- ╰──────────────────────────────────────────────────────────────╯

config.max_fps = 255 -- High max FPS (ensure hardware supports it)
config.animation_fps = 60 -- Smooth animations
config.cursor_blink_rate = 250 -- Cursor blink interval in ms
config.automatically_reload_config = true

-- ╭──────────────────────────────────────────────────────────────╮
-- │                      Tab Bar Configuration                   │
-- ╰──────────────────────────────────────────────────────────────╯

config.enable_tab_bar = true
config.show_tab_index_in_tab_bar = false
config.use_fancy_tab_bar = false

-- ╭──────────────────────────────────────────────────────────────╮
-- │                      Tab Title Formatting                    │
-- ╰──────────────────────────────────────────────────────────────╯

wezterm.on("format-tab-title", function(tab, _, _, _, hover)
	local background = config.colors.brights[1]
	local foreground = config.colors.foreground

	if tab.is_active then
		background = config.colors.brights[7]
		foreground = config.colors.background
	elseif hover then
		background = config.colors.brights[8]
		foreground = config.colors.background
	end

	local title = tostring(tab.tab_index + 1)
	return {
		{ Foreground = { Color = background } },
		{ Text = "█" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Foreground = { Color = background } },
		{ Text = "█" },
	}
end)

-- ╭──────────────────────────────────────────────────────────────╮
-- │                       Key Bindings                           │
-- ╰──────────────────────────────────────────────────────────────╯

config.disable_default_key_bindings = true
config.leader = {
	key = "Space",
	mods = "CTRL|SHIFT",
	timeout_milliseconds = 1000,
}

local function bind_tabs(keys, mods)
	local func = wezterm.action.ActivateTab
	for i = 1, 9 do
		keys[#keys + 1] = { key = tostring(i), mods = mods, action = func(i - 1) }
	end
end

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

-- ╭──────────────────────────────────────────────────────────────╮
-- │                     Shell Configuration                      │
-- ╰──────────────────────────────────────────────────────────────╯

local function resolve_path(cmd)
	if host_os == "windows" then
		return wezterm.run_child_process({ "where.exe", cmd }) and cmd
	else
		return wezterm.run_child_process({ "which", cmd }) and cmd
	end
end

local shell = resolve_path("pwsh") or resolve_path("powershell") or "cmd"
config.default_prog = (host_os == "windows") and { shell, "-nologo" } or { "zsh", "-l" }

-- ╭──────────────────────────────────────────────────────────────╮
-- │                     OS-Specific Overrides                    │
-- ╰──────────────────────────────────────────────────────────────╯

if host_os == "linux" then
	emoji_font = "Noto Color Emoji"
	-- config.default_prog = { 'zsh' }
	config.front_end = "WebGpu"
	config.window_background_image = os.getenv("HOME") .. "/.config/wezterm/bg-blurred.png"
	config.window_decorations = nil -- use system decorations
end

-- ╭──────────────────────────────────────────────────────────────╮
-- │                         Final Export                         │
-- ╰──────────────────────────────────────────────────────────────╯

return config
