return {
	{
		'Bekaboo/dropbar.nvim',
		event = 'VeryLazy', -- Load after full startup
		dependencies = {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
	},
}