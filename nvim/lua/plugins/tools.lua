return {
    {
        'folke/snacks.nvim',
		event = 'VeryLazy', -- Load after full startup
        opts = {
            notifier = {enabled = true},
        },
        keys = {
            {
				'<leader>n', function()
                    Snacks.notifier.show_history()
                end, desc = 'Notification History'
			},
            {
				'<leader>un', function()
                    Snacks.notifier.hide()
                end, desc = 'Dismiss All Notifications'
			},
            {
				'<c-/>', function()
                    Snacks.terminal()
                end, desc = 'Toggle Terminal'
			},
            {
                '<leader>N', function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = 'yes',
							statuscolumn = ' ',
							conceallevel = 3
                        }
                    })
                end, desc = 'Neovim News'
            }
        }
    },
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
	{
        'stevearc/conform.nvim',
        event = 'BufReadPost', -- Load when a buffer is read
        opts = {
            formatters_by_ft = {
                python = {'black'}, lua = {'stylua'}, javascript = {'prettierd'}
            }
        },
        keys = {
            {
				'<leader>gf',
				function()
                    require('conform').format({async = true, lsp_fallback = true})
				end,
				desc = 'Format document'
			},
        },
        config = function(_, opts)
            require('conform').setup(opts)
        end
    },
	{
		'filipdutescu/renamer.nvim',
		dependencies = {'nvim-lua/plenary.nvim'},
		event = 'BufReadPost', -- Load when a buffer is read
		keys = {
			{'<F2>', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'i', desc = 'Rename in insert mode'},
			{'<leader>rn', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'n', desc = 'Rename in normal mode'},
			{'<leader>rn', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'v', desc = 'Rename in visual mode'},
		},
		config = function()
			require('renamer').setup()
		end,
	},
	{
		'windwp/nvim-ts-autotag',
		event = 'BufReadPost', -- Load when a buffer is read
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},
	{
		'vyfor/cord.nvim',
		event = 'VeryLazy', -- Load after full startup
		build = ':Cord update'
	},
}
