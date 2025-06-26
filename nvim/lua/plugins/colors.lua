return {

	{

		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Load the colorscheme
			vim.cmd.colorscheme("tokyonight-storm")
		end,
	},

	{

		"zaldih/themery.nvim",
		cmd = "Themery", -- Load when the :Themery command is run
		keys = {
			-- Toggle theme with <leader>ct (C-t)
			{ "<leader>ct", ":Themery<CR>", "Toggle theme" },
		},
		opts = {
			-- Custom themes to be available for selection
			themes = {
				{ name = "Night", colorscheme = "tokyonight-night" },
				{ name = "Storm", colorscheme = "tokyonight-storm" },
				{ name = "Day", colorscheme = "tokyonight-day" },
				{ name = "Moon", colorscheme = "tokyonight-moon" },

				-- Add more themes as needed...
			},
			livePreview = true, -- Enable live preview
		},
		config = function(_, opts)
			-- Load themery
			local themery = require("themery")

			-- Apply custom options
			themery.setup(opts)
		end,
	},
}
