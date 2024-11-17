return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- Light configuration for Telescope to avoid delays
		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				prompt_position = "top", -- Optional: Can make the prompt appear at the top to reduce visual clutter
				-- Further customization here if needed, such as setting `sorting_strategy` or `file_sorter`
			},
		})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "Find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true, desc = "Search project with live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true, desc = "List open buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true, desc = "Find help tags" })
	end,
}
