return {
	"nvim-lualine/lualine.nvim",
	event = "BufReadPost", -- Load after the buffer is completely read
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				theme = "onedark", -- You can change the theme as per your preference
			},
		})
	end,
}
