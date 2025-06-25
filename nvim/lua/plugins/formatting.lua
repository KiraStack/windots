return {
	{
		"stevearc/conform.nvim",
		event = "VeryLazy", -- Load after full startup
		opts = {
			-- Formatters by filetype
			formatters_by_ft = {
				c = { "clang-format" },
				css = { "prettierd" },
				go = { "gofmt" },
				html = { "prettierd" },
				java = { "google-java-format" },
				javascript = { "prettierd" },
				lua = { "selene" },
				python = { "ruff" },
				rust = { "rustfmt" },
				typescript = { "prettierd" },
			},

			-- Enable format on save
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		keys = {
			-- Format document using conform
			{
				"<leader>gf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format document",
			},
		},
		config = function(_, opts)
			-- Load conform
			local conform = require("conform")

			-- Apply custom options
			conform.setup(opts)
		end,
	},
}
