return {
	{
		"f-person/auto-dark-mode.nvim",
		event = "VimEnter", -- Load when Vim has started
		config = function()
			require("auto-dark-mode").setup({
				update_interval = 1000,
				set_dark_mode = function()
					vim.cmd("set background=dark")
				end,
				set_light_mode = function()
					vim.cmd("set background=light")
				end,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		event = "VimEnter", -- Load when Vim has started
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "frappe",
				},
			})
		end,
	},
	{
		"zaldih/themery.nvim",
    	lazy = false,
		event = "VimEnter", -- Load when Vim has started
    	config = function()
      		require("themery").setup({
        		themes = {{ -- Your list of installed colorschemes.
					name = "Latte",
					colorscheme = "catppuccin-latte",
				},
				{
					name = "Frappe",
					colorscheme = "catppuccin-frappe",
				},
				{
					name = "Macchiato",
					colorscheme = "catppuccin-macchiato",
				},
				{
					name = "Mocha",
					colorscheme = "catppuccin-mocha",
				}},
  				livePreview = true, -- Apply theme while picking. Default to true.
      		})
    	end,
	},
	{
		"nvimdev/dashboard-nvim",
		event = "BufWinEnter", -- Load when a buffer is read
		config = function()
			require("dashboard").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "BufWinEnter", -- Load when a buffer is read
		config = function()
			vim.defer_fn(function()
				require("lualine").setup({ options = { theme = "auto" } })
			end, 50)
		end,
	},
	{
		"andweeb/presence.nvim",
		event = "VimEnter", -- Load when Vim has started
		config = function()
			require("presence"):setup({
				neovim_image_text = "The One True Text Editor",
				main_image = "file",
				editing_text = "Editing %s",
				file_explorer_text = "Browsing %s",
				git_commit_text = "Committing changes",
				plugin_manager_text = "Managing plugins",
				lsp_client_text = "Configuring LSP",
				reading_text = "Reading %s",
				workspace_text = "Working on %s",
				line_number_text = "Line %s out of %s",
			})
		end,
	},
}
