return {
	"folke/which-key.nvim",
	cmd = "WhichKey", -- Load only when the command is issued
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
