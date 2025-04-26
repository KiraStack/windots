return {
	{
		'windwp/nvim-ts-autotag',
		event = 'BufReadPost', -- Load when a buffer is read
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},
}