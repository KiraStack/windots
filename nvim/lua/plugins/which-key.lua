return {
	{
        'folke/which-key.nvim',
        event = "VeryLazy", -- Load after full startup
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
			{
				'<leader>?', function()
					require('which-key').show({ global = false })
				end,
				desc = 'Buffer Keymaps (which-key)',
			}
		},
		config = function(_, opts)
			require('which-key').setup(opts)
		 end,
    },
}