return {
	{
		'folke/twilight.nvim',
		event = 'BufReadPost', -- Load when a buffer is read
		config = function()
			-- Run a command on startup
			vim.cmd('TwilightEnable')
		end,
	},
	{

		'scottmckendry/cyberdream.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			-- Load the plugin
			local cyberdream = require("cyberdream")

			-- Configure the colorscheme
			cyberdream.setup({
				variant            = "auto",
				transparent        = true,
				italic_comments    = true,
				hide_fillchars     = true,
				terminal_colors    = false,
				cache              = true,
				borderless_pickers = true,
				overrides          = function(c)
					return {
						CursorLine   = { bg = c.bg },
						CursorLineNr = { fg = c.magenta },
					}
				end,
			})

			-- Load the colorscheme
			vim.cmd.colorscheme('cyberdream')
		end,
	},
	{

		'zaldih/themery.nvim',
		cmd = 'Themery', -- Load when the :Themery command is run
		keys = {
			-- Toggle theme with <leader>ct (C-t)
			{ '<leader>ct', ':Themery<CR>', 'Toggle theme' },
		},
		opts = {
			-- Custom themes to be available for selection
			themes = {
				{ name = 'Standard', colorscheme = 'cyberdream' },

				-- Add more themes as needed...
			},
			livePreview = true, -- Enable live preview
		},
		config = function(_, opts)
			require('themery').setup(opts)
		end,
	},
}
