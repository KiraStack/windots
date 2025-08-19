local Module = {
	-- Define the base thirty colors for the theme
	base_30 = {
		white = '#eff0ff',
		darker_black = '#0f0f13',
		black = '#16161b',
		black2 = '#1c1c23',
		one_bg = '#252531',
		one_bg2 = '#2f2f3b',
		one_bg3 = '#393945',
		grey = '#474753',
		grey_fg = '#52525e',
		grey_fg2 = '#5d5d69',
		light_grey = '#686874',
		red = '#f74e95',
		baby_pink = '#ff69a8',
		pink = '#ff69a8',
		line = '#2d2d39',
		green = '#5ebdc2',
		vibrant_green = '#5ebdc2',
		nord_blue = '#8bc2fc',
		blue = '#9c9bfa',
		yellow = '#fcf8be',
		sun = '#fcf8be',
		purple = '#c2c1ff',
		dark_purple = '#9c9bfa',
		teal = '#a8f1e3',
		orange = '#cca700',
		cyan = '#a8f1e3',
		statusline_bg = '#1c1c23',
		lightbg = '#2d2d39',
		pmenu_bg = '#9c9bfa',
		folder_bg = '#8bc2fc',
	},

	-- Define the base sixteen colors for the theme
	base_16 = {
		base00 = '#16161b',
		base01 = '#1c1c23',
		base02 = '#252531',
		base03 = '#2f2f3b',
		base04 = '#393945',
		base05 = '#9497ba',
		base06 = '#cccccc',
		base07 = '#eff0ff',
		base08 = '#f74e95',
		base09 = '#cca700',
		base0A = '#fcf8be',
		base0B = '#5ebdc2',
		base0C = '#a8f1e3',
		base0D = '#9c9bfa',
		base0E = '#c2c1ff',
		base0F = '#616482',
	},

	-- Define semantic token colors
	semanticTokenColors = {
		enumMember = { fg = '#eff0ff' },
		['variable.constant'] = { fg = '#eff0ff' },
		['variable.defaultLibrary'] = { fg = '#a8f1e3' },
	},
}

-- Export the module
return Module
