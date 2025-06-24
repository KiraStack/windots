return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy", -- Load after full startup
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<S-h>", "<cmd> 	<cr>", desc = "Prev Buffer" },
			{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
			{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
			{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
			{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
		},
		opts = {
			-- Enable diagnostics for the current buffer
			options = {
				-- Close the buffer on left click
				close_command = function(bufnr)
					Snacks.bufdelete(bufnr)
				end,

				-- Close the buffer on right click
				right_mouse_command = function(bufnr)
					Snacks.bufdelete(bufnr)
				end,

				-- Use Neovim's built-in diagnostics
				diagnostics = "nvim_lsp",

				-- Always show the bufferline (even if only one buffer is open)
				always_show_bufferline = false,

				-- Define offsets for bufferline groups
				offsets = {
					-- Bufferline group at the left side of the window
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},

					-- Bufferline group at the right side of the window
					{
						filetype = "snacks_layout_box",
					},
				},
			},
		},
		config = function(_, opts)
			-- Load lualine
			local bufferline = require("bufferline")

			-- Apply custom options
			bufferline.setup(opts)
		end,
	},
	{
		"Bekaboo/dropbar.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- Define statusline components
			options = {
				-- Enable auto-theme
				theme = "auto",
			},
		},
		config = function(_, opts)
			-- Load lualine
			local lualine = require("lualine")

			-- Apply custom options
			lualine.setup(opts)
		end,
	},
}
