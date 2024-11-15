local wezterm = require 'wezterm'

-- Define color schemes for light and dark appearances
local color_schemes = {
    light = 'Catppuccin Latte',
    dark = 'Catppuccin Frappe',
}

-- Create the configuration object using the builder
local config = wezterm.config_builder()

-- Set color scheme dynamically based on appearance
config.color_scheme = wezterm.gui.get_appearance():find('Dark') and color_schemes.dark or color_schemes.light

-- Configure font and size
config.font = wezterm.font('FiraCode Nerd Font')  -- Optimized syntax for better clarity
config.font_size = 16

-- Configure cursor and default program
config.default_cursor_style = 'BlinkingBar'
config.default_prog = { 'powershell.exe', '-nologo' }

-- Simplify window appearance
config.window_decorations = 'RESIZE'
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Enable automatic configuration reload
config.automatically_reload_config = true

-- Disable all default key bindings
config.disable_default_key_bindings = true

-- Configure leader key and key bindings
config.leader = { key = 'Space', mods = 'CTRL|SHIFT', timeout_milliseconds = 1000, }

-- Use custom key bindings from a utility module
config.keys = {
    -- New tab
    { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
    -- Close current pane with confirmation
    { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane { confirm = true } },
    -- Toggle full screen
    { key = 'n', mods = 'CTRL|SHIFT', action = wezterm.action.ToggleFullScreen },
    -- Horizontal split (Hyper.is style)
    { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    -- Vertical split (Hyper.is style)
    { key = 'e', mods = 'CTRL|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Copy to clipboard
    { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo('Clipboard') },
    -- Paste from clipboard
    { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom('Clipboard') },
}

-- Generate tab activation keybindings dynamically
for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL|ALT',
        action = wezterm.action.ActivateTab(i - 1),
    })
end

-- Return the finalized configuration
return config
