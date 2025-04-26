return {
	{
		'filipdutescu/renamer.nvim',
		event = 'VeryLazy', -- Load after full startup
		dependencies = {'nvim-lua/plenary.nvim'},
		keys = {
			{'<F2>', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'i', desc = 'Rename in insert mode'},
			{'<leader>rn', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'n', desc = 'Rename in normal mode'},
			{'<leader>rn', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'v', desc = 'Rename in visual mode'},
		},
		config = function()
			require('renamer').setup()
		end,
	},
}