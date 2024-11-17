return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({ theme = "auto" })
	end,
	priority = 999, -- Load immediately for a fast statusline
}
