return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy", -- Load after full startup
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
			-- Open buffer list
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
		},
		config = function(_, opts)
			-- Load wilder
			local which_key = require("which-key")

			-- Apply custom options
			which_key.setup(opts)
		end,
	},
	{
		"gelguy/wilder.nvim",
		event = "VeryLazy", -- Load after full startup
		opts = {
			modes = { ":", "/", "?" },
		},
		config = function(_, opts)
			-- Load wilder
			local wilder = require("wilder")

			-- Apply custom options
			wilder.setup(opts)

			-- Set options for renderer and highlighter
			wilder.set_option(
				-- Renderer to use
				"renderer",

				-- Render the popupmenu in a popup window
				wilder.popupmenu_renderer(
					-- Theme for the popupmenu border
					wilder.popupmenu_border_theme({
						highlights = {
							border = "Normal", -- highlight to use for the border
						},
						-- 'single', 'double', 'rounded' or 'solid'
						-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
						border = "rounded",
					}),
					{
						-- Highlighter for the popupmenu items
						pumblend = 20,
						highlighter = wilder.basic_highlighter(),
					}
				)
			)
		end,
	},
}
