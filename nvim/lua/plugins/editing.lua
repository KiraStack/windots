return {
	{
		'folke/flash.nvim',
		event = 'VeryLazy', -- Load after full startup
		keys = {
			{ 's',     mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,              desc = 'Flash' },
			{ 'S',     mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end,        desc = 'Flash Treesitter' },
			{ 'r',     mode = 'o',               function() require('flash').remote() end,            desc = 'Remote Flash' },
			{ 'R',     mode = { 'o', 'x' },      function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
			{ '<c-s>', mode = { 'c' },           function() require('flash').toggle() end,            desc = 'Toggle Flash Search' },
		},
	},
	{
		'lewis6991/gitsigns.nvim',
		event = 'BufReadPre',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			current_line_blame = false, -- Disabled line blame
			signcolumn = true, -- Always show sign column
			numhl = false,     -- Disable line number highlighting
			linehl = false,    -- Disable line highlighting
			watch_gitdir = { interval = 1000 },
			attach_to_untracked = true,
		},
		config = function(_, opts)
			require('gitsigns').setup(opts)
		end
	},
	{
		'sphamba/smear-cursor.nvim',
		event = { 'BufReadPre', 'BufNewFile' }, -- Load when a buffer is read
		opts = {
			min_horizontal_distance_smear = 2,
			min_vertical_distance_smear = 2,
			legacy_computing_symbols_support = true,
		},
	},
	{
		'folke/todo-comments.nvim',
		event = 'BufReadPost', -- Load when a buffer is read
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('todo-comments').setup()
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
		'folke/trouble.nvim',
		cmd = 'Trouble',
		opts = {
			-- Enable diagnostics in all modes
			modes = {
				-- Show diagnostics in the LSP client
				lsp = {
					-- Toggle diagnostics for current line
					win = { position = 'right' },
				},
			},
		},
		keys = {
			-- Toggle diagnostics (Trouble) for current buffer
			{ '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',              desc = 'Diagnostics (Trouble)' },

			-- Buffer diagnostics (Trouble)
			{ '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },

			-- Toggle symbols in current buffer
			{ '<leader>cs', '<cmd>Trouble symbols toggle<cr>',                  desc = 'Symbols (Trouble)' },

			-- LSP diagnostics in a floating window
			{ '<leader>cS', '<cmd>Trouble lsp toggle<cr>',                      desc = 'LSP references/definitions/... (Trouble)' },

			-- Location List (Trouble)
			{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                  desc = 'Location List (Trouble)' },

			-- For quickfix list, you can also use <C-k> and <C-j> for navigation.
			{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                   desc = 'Quickfix List (Trouble)' },

			-- Navigate through trouble items with cursor movements
			{
				'[q',
				function()
					if require('trouble').is_open() then
						require('trouble').prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = 'Previous Trouble/Quickfix Item',
			},

			-- Next Trouble/Quickfix Item
			{
				']q',
				function()
					if require('trouble').is_open() then
						require('trouble').next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = 'Next Trouble/Quickfix Item',
			},
		},
	},
	{
		'ravibrock/spellwarn.nvim',
		event = 'VeryLazy', -- Load after full startup
		opts = {
			-- Events to refresh diagnostics on
			event = {
				'CursorHold',
				'InsertLeave',
				'TextChanged',
				'TextChangedI',
				'TextChangedP',
			},

			-- Enable spelling diagnostics on startup
			enable = true,

			-- Spell check for specific filetypes only
			ft_config = {
				alpha = false,
				help = false,
				lazy = false,
				lspinfo = false,
				mason = false,
			},

			-- Default option for unspecified filetypes (true to enable diagnostics)
			ft_default = true,

			-- Maximum number of lines to check in a file (nil for no limit)
			max_file_size = nil,

			-- Severity for each spelling error type (false to disable diagnostics for that type)
			severity = {
				spellbad = 'WARN',
				spellcap = 'HINT',
				spelllocal = 'HINT',
				spellrare = 'INFO',
			},

			-- Prefix for each diagnostic message (false to disable prefix)
			prefix = 'possible misspelling(s): ',

			-- Options for diagnostic display (false to disable)
			diagnostic_opts = { severity_sort = true },
		},
		config = function()
			-- Environmental options
			vim.opt.spell = true
			vim.opt.spelllang = { 'en' } -- Set your preferred language(s)

			require('spellwarn').setup(opts) -- Setup spellwarn
		end,
	},
}
