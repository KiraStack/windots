return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy", -- Load after all core UI events for optimal startup performance
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
			options = {
				close_command = function(n) Snacks.bufdelete(n) end,
				right_mouse_command = function(n) Snacks.bufdelete(n) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "snacks_layout_box",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "storm" },
        config = function()
            vim.cmd("colorscheme tokyonight-storm")
        end,
    },
    {
        "zaldih/themery.nvim",
		cmd = "Themery",  -- Load when the :Themery command is run
		keys = {
			{ "<leader>sh", ":Themery<CR>", "Toggle theme" }
		},
		config = function()
			require("themery").setup({
				themes = {
					{
						name = "Night",
						colorscheme = "tokyonight-night",
					},
					{
						name = "Storm",
						colorscheme = "tokyonight-storm",
					},
					{
						name = "Day",
						colorscheme = "tokyonight-day",
					},
					{
						name = "Moon",
						colorscheme = "tokyonight-moon",
					}
				},
				livePreview = true, -- Apply theme while picking. Default to true.
			})
		end,
	},
	{
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "BufWinEnter",  -- Load when a window is opened
		config = function()
			require("lualine").setup()
		end,
    },
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPost", -- Load when a buffer is read
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	{
        "folke/which-key.nvim",
        lazy = true,
		event = "VeryLazy",  -- Load when Neovim is fully loaded (after startup)
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			defaults = {},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader><tab>", group = "tabs" },
					{ "<leader>c", group = "code" },
					{ "<leader>d", group = "debug" },
					{ "<leader>dp", group = "profiler" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
					{ "<leader>s", group = "search" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
				},
			},
		},
		keys = {
			{
				"<leader>?", function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			}
		},
		config = function(_, opts)
			require("which-key").setup(opts)
		 end,
    }
}