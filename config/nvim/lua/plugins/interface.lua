return {
	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                              Dashboard & UI                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                             dashboard-nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			theme = "hyper",
			config = {
				week_header = { enable = true },
				project = { enable = false },
				mru = { enable = false },
				footer = {},
			},
		},
		config = function(_, opts)
			local dashboard = require("dashboard")
			local snacks = require("snacks")

			vim.cmd("highlight DashboardHeader guifg=#ffffff")

			local shortcuts = {
				{
					icon = "󰒲  ",
					icon_hl = "Boolean",
					desc = "Update ",
					group = "Directory",
					action = "Lazy update",
					key = "u",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Files ",
					group = "Statement",
					action = snacks.picker.files,
					key = "f",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Recent ",
					group = "String",
					action = snacks.picker.recent,
					key = "r",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Grep ",
					group = "ErrorMsg",
					action = snacks.picker.grep,
					key = "g",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Quit ",
					group = "WarningMsg",
					action = "qall!",
					key = "q",
				},
			}

			opts.config.shortcut = shortcuts
			dashboard.setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                                UI & Themes                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                             	theme.nvim                                │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"scottmckendry/cyberdream.nvim",
		name = "cyberdream",
		lazy = false,
		priority = 1000,
		opts = {
			variant = "auto", -- Enable auto detection
			transparent = true, -- Enable transparency
			italic_comments = true, -- Enable italic comments
			hide_fillchars = true, -- Hide fill characters
			borderless_pickers = true, -- Hide picker borders
			cache = true, -- Cache colorscheme colors
		},
		config = function(_, opts)
			require("cyberdream").setup(opts) -- Setup theme with options
			vim.cmd.colorscheme("cyberdream") -- Apply Cyberdream colorscheme
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               themery.nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"zaldih/themery.nvim",
		cmd = "Themery",
		keys = {
			{ "<leader>ct", ":Themery<CR>", "Toggle theme" },
		},
		opts = {
			themes = {
				{
					name = "cyberdream",
					colorscheme = "cyberdream",
				},
			},
			livePreview = true,
		},
		config = function(_, opts)
			require("themery").setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               twilight.nvim                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"folke/twilight.nvim",
		event = "BufReadPost",
		opts = {
			dimming = {
				alpha = 0.25, -- Amount of dimming
				color = { "Normal", "#ffffff" },
				term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
				inactive = true, -- When true, other windows will be fully dimmed (unless they contain the same buffer)
			},
			context = 20, -- Amount of context lines to show
		},
		config = function(_, opts)
			require("twilight").setup(opts) -- Setup plugin with options
			vim.cmd("TwilightEnable") -- Enable twilight
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               nvim-cokeline.nvim                         │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for v0.4.0+
			"nvim-tree/nvim-web-devicons",
			"stevearc/resession.nvim",
		},
		config = function(_, opts)
			-- Function to get hex color
			local function get_hex(group, attr)
				return require("cokeline.hlgroups").get_hl_attr(group, attr)
			end

			-- Setup plugin with options
			require("cokeline").setup({
				default_hl = {
					fg = function(buffer)
						return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
					end,
					bg = "NONE",
				},
				components = {
					{
						text = function(buffer)
							return (buffer.index ~= 1) and "▏" or ""
						end,
						fg = function()
							return get_hex("Normal", "fg")
						end,
					},
					{
						text = function(buffer)
							return "    " .. buffer.devicon.icon
						end,
						fg = function(buffer)
							return buffer.devicon.color
						end,
					},
					{
						text = function(buffer)
							return buffer.filename .. "    "
						end,
						bold = function(buffer)
							return buffer.is_focused
						end,
					},
					{
						text = "󰖭",
						on_click = function(_, _, _, _, buffer)
							buffer:delete()
						end,
					},
					{
						text = "  ",
					},
				},
			})

			-- Persist focus
			require("cokeline.history"):last():focus()
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                            smear-cursor.nvim                             │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"sphamba/smear-cursor.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			min_horizontal_distance_smear = 2,
			min_vertical_distance_smear = 2,
			legacy_computing_symbols_support = true,
		},
	},
}
