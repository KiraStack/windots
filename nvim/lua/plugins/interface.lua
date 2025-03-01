return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			local flavours = { light = "latte", dark = "frappe" }
			require("catppuccin").setup({
				flavour = flavours[vim.opt.background:get()]
			})
			vim.cmd.colorscheme("catppuccin")
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
