return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		-- Key mappings
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
	end,
}
