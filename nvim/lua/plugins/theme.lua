return {
	"navarasu/onedark.nvim",
	config = function()
		vim.cmd("colorscheme onedark")
	end,
	priority = 1000, -- High priority to load early
}
