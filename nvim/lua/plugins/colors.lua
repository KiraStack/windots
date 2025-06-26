return {
	{
		"kyomi",
		dir = vim.fn.stdpath("config") .. "/", -- Path to the theme directory
		lazy = false, -- Load immediately
		priority = 10000, -- Highest priority to load before everything else
		config = function()
			-- Load the theme
			local theme = require("kyomi")

			-- Apply custom options
			theme.setup()
		end,
	},
	{
		"zaldih/themery.nvim",
		cmd = "Themery",
		keys = {
			{ "<leader>ct", "<cmd>Themery<CR>", desc = "Toggle theme" },
		},
		opts = {
			themes = {
				{ name = "Kyomi", colorscheme = "kyomi" },
			},
			livePreview = true,
		},
	},
}
