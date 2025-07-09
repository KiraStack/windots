return {
	{
		'folke/which-key.nvim',
		event = 'VeryLazy', -- Load after full startup
		opts_extend = { 'spec' },
		opts = {
			preset = 'helix',
			defaults = {},
			spec = {
				{
					mode = { 'n', 'v' },
					{ '<leader><tab>', group = 'tabs' },
					{ '<leader>c', group = 'code' },
					{ '<leader>d', group = 'debug' },
					{ '<leader>dp', group = 'profiler' },
					{ '<leader>f', group = 'file/find' },
					{ '<leader>g', group = 'git' },
					{ '<leader>gh', group = 'hunks' },
					{ '<leader>q', group = 'quit/session' },
					{ '<leader>s', group = 'search' },
					{ '<leader>u', group = 'ui', icon = { icon = '󰙵 ', color = 'cyan' } },
					{ '<leader>x', group = 'diagnostics/quickfix', icon = { icon = '󱖫 ', color = 'green' } },
					{ '[', group = 'prev' },
					{ ']', group = 'next' },
					{ 'g', group = 'goto' },
					{ 'gs', group = 'surround' },
					{ 'z', group = 'fold' },
				},
			},
		},
		keys = {
			-- Open buffer list
			{
				'<leader>?',
				function()
					require('which-key').show({ global = false })
				end,
				desc = 'Buffer Keymaps (which-key)',
			},
		},
		config = function(_, opts)
			require('which-key').setup(opts)
		end,
	},
	{
		'gelguy/wilder.nvim',
		event = 'VeryLazy', -- Load after full startup
		opts = {
			modes = { ':', '/', '?' },
		},
		config = function(_, opts)
			-- Load wilder
			local wilder = require('wilder')

			-- Constants
			local gradient = {
				'#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
				'#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
				'#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
				'#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
			}

			for idx, hex in ipairs(gradient) do
				local name = 'WilderGradient' .. idx
				local attributes = {
					{ a = 1 }, -- Full opacity
					{ a = 1 }, -- Full opacity background
					{ foreground = hex } -- Gradient color
				}

				gradient[idx] = wilder.make_hl(
					name,
					'Pmenu',
					attributes
				)
			end

			-- Set options for renderer and highlighter
			wilder.set_option(
			-- Renderer to use
				'renderer',

				-- Render the popupmenu in a popup window
				wilder.popupmenu_renderer(
				-- Theme for the popupmenu border
					wilder.popupmenu_border_theme({
						highlights = {
							border = 'Normal', -- highlight to use for the border
							gradient = gradient, -- gradient to use for the border
						},
						highlighter = wilder.highlighter_with_gradient({
							wilder.basic_highlighter(), -- or wilder.lua_fzy_highlighter(),
						}),
						-- 'single', 'double', 'rounded' or 'solid'
						-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
						border = 'rounded',
					}),
					{
						-- Highlighter for the popupmenu items
						pumblend = 20,
						highlighter = wilder.basic_highlighter(),
					}
				)
			)

			-- Apply custom options
			wilder.setup(opts)
		end,
	},
}
