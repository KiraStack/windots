return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPost", -- Load when a buffer is read
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "python", "javascript", "typescript" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = "BufReadPost", -- Load when a buffer is read
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					python = { "black" }, -- Black for Python
					javascript = { "prettierd" }, -- Prettier for JavaScript
				},
			})
		end,
	},
}
