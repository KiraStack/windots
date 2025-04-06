return {
	{
		'akinsho/bufferline.nvim',
		event = 'VeryLazy', -- Load after all core UI events for optimal startup performance
		keys = {
			{ '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
			{ '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
			{ '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
			{ '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
			{ '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
			{ '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
			{ '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
			{ ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
			{ '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
			{ ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
		},
		opts = {
			options = {
				close_command = function(n) Snacks.bufdelete(n) end,
				right_mouse_command = function(n) Snacks.bufdelete(n) end,
				diagnostics = 'nvim_lsp',
				always_show_bufferline = false,
				offsets = {
					{
						filetype = 'neo-tree',
						text = 'Neo-tree',
						highlight = 'Directory',
						text_align = 'left',
					},
					{
						filetype = 'snacks_layout_box',
					},
				},
			},
		},
		config = function(_, opts)
			require('bufferline').setup(opts)
		end,
	},
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = { style = 'storm' },
        config = function()
            vim.cmd('colorscheme tokyonight-storm')
        end,
    },
    {
        'zaldih/themery.nvim',
		cmd = 'Themery',  -- Load when the :Themery command is run
		keys = {
			{ '<leader>sh', ':Themery<CR>', 'Toggle theme' }
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
	{
        'nvim-tree/nvim-tree.lua',
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
		cmd = 'NvimTreeToggle',  -- Load when the :NvimTreeToggle command is run
		keys = {
			{ '<leader>tt',  '<cmd>NvimTreeToggle<CR>', 'Toggle NvimTree' },
			{ '<leader>tf',  '<cmd>NvimTreeFindFileToggle<CR>', 'Find and toggle file in NvimTree' },
			{ '<leader>tr',  '<cmd>NvimTreeRefresh<CR>', 'Refresh NvimTree' }
		},
		config = function()
			require('nvim-tree').setup()
		end,
    },
	{
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = 'BufWinEnter',  -- Load when a window is opened
    },
	{
		'Bekaboo/dropbar.nvim',
		event = 'BufReadPost', -- Load when a buffer is read
		dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	},
	{
        'folke/which-key.nvim',
        lazy = true,
		event = 'VeryLazy',  -- Load when Neovim is fully loaded (after startup)
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
		'folke/trouble.nvim',
		cmd = { 'Trouble' },
		opts = {
			modes = {
				lsp = {
					win = { position = 'right' },
				},
			},
			warn_no_results = false,
			open_no_results = true,
		},
		keys = {
			{ '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
			{ '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
			{ '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
			{ '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
			{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
			{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
			{ '[q', function()
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
			{ ']q', function()
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
		'folke/todo-comments.nvim',
		cmd = { 'TodoTrouble', 'TodoTelescope' },
		opts = {},
		keys = {
			{ ']t', function() require('todo-comments').jump_next() end, desc = 'Next Todo Comment' },
			{ '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous Todo Comment' },
			{ '<leader>xt', '<cmd>Trouble todo toggle<cr>', desc = 'Todo (Trouble)' },
			{ '<leader>xT', '<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
			{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
			{ '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
		},
	},
	{
		'andweeb/presence.nvim',
		event = 'VimEnter', -- Load when Vim has started
		config = function()
			require('presence'):setup({
				neovim_image_text = 'The One True Text Editor',
				main_image = 'file',
				editing_text = 'Editing %s',
				file_explorer_text = 'Browsing %s',
				git_commit_text = 'Committing changes',
				plugin_manager_text = 'Managing plugins',
				lsp_client_text = 'Configuring LSP',
				reading_text = 'Reading %s',
				workspace_text = 'Working on %s',
				line_number_text = 'Line %s out of %s',
			})
		end,
	},
}