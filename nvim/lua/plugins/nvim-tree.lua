return {
	{
		'nvim-tree/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        dependencies = {'nvim-tree/nvim-web-devicons'},
		opts = {
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			renderer = {
				root_folder_modifier = ":t",
				-- These icons are visible when you install web-devicons
				icons = {
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							arrow_open = "",
							arrow_closed = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "",
							staged = "S",
							unmerged = "",
							renamed = "➜",
							untracked = "U",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			view = {
				width = 30,
				side = "left",
			},
		},
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
		},
		config = function(_, opts)
			local nvim_tree = require("nvim-tree")
			nvim_tree.setup(opts)
		end,
	},
}