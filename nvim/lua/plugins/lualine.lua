return {
	{
        'nvim-lualine/lualine.nvim',
		event = 'VeryLazy', -- Load after full startup
		dependencies = {'nvim-tree/nvim-web-devicons'},
		opts = {
			options = {
				theme = 'auto',
			},
		},
		config = function(_, opts)
			require('lualine').setup(opts)
		end,
    },
}