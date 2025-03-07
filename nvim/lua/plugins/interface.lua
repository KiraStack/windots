return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"zaldih/themery.nvim",
    	lazy = false,
    	config = function()
      		require("themery").setup({
        		themes = {{ -- Your list of installed colorschemes.
					name = "Latte",
					colorscheme = "catppuccin-latte",
				},
				{
					name = "Frappe",
					colorscheme = "catppuccin-frappe",
				},
				{
					name = "Macchiato",
					colorscheme = "catppuccin-macchiato",
				},
				{
					name = "Mocha",
					colorscheme = "catppuccin-mocha",
				}},
  				livePreview = true, -- Apply theme while picking. Default to true.
      		})
    	end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "BufWinEnter", -- Load when a buffer is read
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("dashboard").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "BufWinEnter", -- Load when a buffer is read
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			vim.defer_fn(function()
				require("lualine").setup({ options = { theme = "auto" } })
			end, 50)
		end,
	},
}
