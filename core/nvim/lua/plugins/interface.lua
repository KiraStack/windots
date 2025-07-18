return {
	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                                UI & Themes                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               twilight.nvim                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"folke/twilight.nvim",
		event = "BufReadPost",
		config = function()
			vim.cmd("TwilightEnable")
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                             catppuccin.nvim                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"catppuccin/nvim", -- Catppuccin theme plugin
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			flavour = vim.opt.background:get() and "latte" or "frappe", -- Theme variant (latte, frappe, macchiato, mocha)
			transparent_background = true, -- Enable transparent background
			term_colors = false, -- Don't override terminal colors
			integrations = { -- Enable integrations with popular plugins
				treesitter = true,
				cmp = true,
				-- gitsigns = true,
				-- telescope = true,
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts) -- Setup theme with options
			vim.cmd.colorscheme("catppuccin") -- Apply Catppuccin colorscheme
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
				{ name = "Catppuccin - Latte", colorscheme = "catppuccin-latte" },
				{ name = "Catppuccin - Frappe", colorscheme = "catppuccin-frappe" },
				{ name = "Catppuccin - Macchiato", colorscheme = "catppuccin-macchiato" },
				{ name = "Catppuccin - Mocha", colorscheme = "catppuccin-mocha" },
			},
			livePreview = true,
		},
		config = function(_, opts)
			require("themery").setup(opts)
		end,
	},

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
}
