return {
	"folke/which-key.nvim",
	event = "BufReadPost",  -- Load after the buffer is completely read
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
