return {
	{
		'echasnovski/mini.nvim',
		version = false,
		event = 'VeryLazy', -- Load after full startup
		opts = {
			comment = {},
			move = {},
			pairs = {},
		},
		config = function(_, opts)
			for name, config in pairs(opts) do
				require('mini.' .. name).setup(config)
			end
		end,
	},
}