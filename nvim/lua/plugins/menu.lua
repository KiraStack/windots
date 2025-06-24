return {
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter', -- Load when vim starts
		dependencies = {'nvim-tree/nvim-web-devicons'},
		opts = {
			config = {
				packages = { enable = true },
				project = { enable = false },
				mru = { enable = false },
				footer = {'Momentum drives tasks. Inaction breeds stagnation.'}, -- default: {'Sharp tools make good work.'},
			}
		},
		config = function(_, opts)
			local dashboard = require('dashboard')
			dashboard.setup(opts)
		end,
	},
}