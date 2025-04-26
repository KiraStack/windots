return {
	{
        'folke/tokyonight.nvim',
        config = function()
            vim.cmd.colorscheme('tokyonight-storm')
        end,
    },
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
	{
        'nvim-lualine/lualine.nvim',
		event = 'BufReadPost', -- Load when a buffer is read
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
	{
		'akinsho/bufferline.nvim',
		event = 'BufReadPost', -- Load when a buffer is read
		keys = {
			{ '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
			{ '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
			{ '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
			{ '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
			{ '<S-h>', '<cmd> 	<cr>', desc = 'Prev Buffer' },
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
		'nvimdev/dashboard-nvim',
		event = 'VimEnter', -- Load when vim starts
		dependencies = {'nvim-tree/nvim-web-devicons'},
		opts = {
			config = {
				packages = { enable = true },
				project = { enable = false },
				mru = { enable = false },
				footer = {'Momentum drives tasks. Inaction breeds stagnation.'}, -- default: {'Sharp tools make good work.'},
			}
		},
		config = function(_, opts)
			local dashboard = require('dashboard')
			dashboard.setup(opts)
		end,
	},
	{
        'folke/trouble.nvim',
        cmd = 'Trouble',
        opts = {
            modes = {
                lsp = {
                    win = {position = 'right'}
                }
            }
        },
        keys = {
            {'<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)'},
            {'<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)'},
            {'<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)'},
            {'<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)'},
            {'<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)'},
            {'<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)'},
            {
                '[q',
                function()
                    if require('trouble').is_open() then
                        require('trouble').prev({skip_groups = true, jump = true})
                    else
                        local ok, err = pcall(vim.cmd.cprev)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = 'Previous Trouble/Quickfix Item'
            },
            {
                ']q',
                function()
                    if require('trouble').is_open() then
                        require('trouble').next({skip_groups = true, jump = true})
                    else
                        local ok, err = pcall(vim.cmd.cnext)
                        if not ok then
                            vim.notify(err, vim.log.levels.ERROR)
                        end
                    end
                end,
                desc = 'Next Trouble/Quickfix Item'
            }
        }
    },
	{
		'Bekaboo/dropbar.nvim',
		event = 'BufReadPost', -- Load when a buffer is read
		dependencies = {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
	},
	{
		'nvim-tree/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        dependencies = {'nvim-tree/nvim-web-devicons'},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
		},
		opts = {
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			renderer = {
				root_folder_modifier = ":t",
				-- These icons are visible when you install web-devicons
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				width = 30,
				side = "left",
			},
		},
		config = function(_, opts)
			local nvim_tree = require("nvim-tree")
			nvim_tree.setup(opts)
		end,
	},
}