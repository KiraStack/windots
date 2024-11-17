return {
	"Bekaboo/dropbar.nvim",
	event = "BufReadPre", -- Load when opening a file
	-- optional, but required for fuzzy finder support
	dependencies = { build = "make", "nvim-telescope/telescope-fzf-native.nvim" },
}
