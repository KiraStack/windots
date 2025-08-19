return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy", -- Load after full startup
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			local servers = { "c", "css", "go", "html", "java", "javascript", "lua", "python", "rust", "typescript" }

			configs.setup({
				ensure_installed = servers,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
