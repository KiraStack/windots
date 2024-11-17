return {
	"Bekaboo/dropbar.nvim",
	event = "BufReadPost",  -- Load after the buffer is completely read
	-- optional, but required for fuzzy finder support
	dependencies = { build = "make", "nvim-telescope/telescope-fzf-native.nvim" },
}
