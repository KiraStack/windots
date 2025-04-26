return {
	{
        'zaldih/themery.nvim',
		cmd = 'Themery',  -- Load when the :Themery command is run
		keys = {
			{ '<leader>ct', ':Themery<CR>', 'Toggle theme' }
		},
		config = function()
			require('themery').setup({
				themes = {
					{
						name = 'Night',
						colorscheme = 'tokyonight-night',
					},
					{
						name = 'Storm',
						colorscheme = 'tokyonight-storm',
					},
					{
						name = 'Day',
						colorscheme = 'tokyonight-day',
					},
					{
						name = 'Moon',
						colorscheme = 'tokyonight-moon',
					}
				},
				livePreview = true, -- Apply theme while picking. Default to true.
			})
		end,
	},
}