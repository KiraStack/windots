return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "CursorHold", -- Lazy load after initial user interaction
}
