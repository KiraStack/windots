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
	-- {
	-- 	"zaldih/themery.nvim",
	-- 	cmd = "Themery",
	-- 	keys = {
	-- 		{ "<leader>ct", ":Themery<CR>", "Toggle theme" },
	-- 	},
	-- 	opts = {
	-- 		themes = {},
	-- 		livePreview = true,
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("themery").setup(opts)
	-- 	end,
	-- },

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
