return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim" },
		opts = {
			-- Constants
			servers = { "lua_ls", "pyright", "ts_ls" },
			
			-- Function to be called on attach
			on_attach = function(client, bufnr)
				-- Enable diagnostics
				vim.diagnostic.config({
					virtual_text = true,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true
				})
			end,
		},
		config = function(_, opts)
			-- Modules
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			-- Variables
			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup mason and mason-lspconfig
			mason.setup()
			mason_lsp.setup({ ensure_installed = opts.servers })
			
			-- Configure LSP servers
			for _, server in ipairs(opts.servers) do
				lspconfig[server].setup({ on_attach = opts.on_attach, capabilities = default_capabilities })
			end
		end
	},
	{
		"lopi-py/luau-lsp.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local function rojo_project()
				return vim.fs.root(0, function(name)
					return name:match ".+%.project%.json$"
				end)
			end

			if rojo_project() then
				vim.filetype.add {
					extension = {
						lua = function(path)
							return path:match "%.nvim%.lua$" and "lua" or "luau"
						end,
					},
				}
			end
		end
	},
    {
        "stevearc/conform.nvim",
        event = "BufReadPost", -- Load when a buffer is read
        opts = {
            formatters_by_ft = {
                python = {"black"}, -- Black for Python
				lua = {"stylua"}, luau = {"stylua"},
                javascript = {"prettierd"} -- Prettier for JavaScript
            }
        },
        keys = {
            {"<leader>gf", function()
                    require("conform").format({async = true, lsp_fallback = true})
                end, desc = "Format document"}
        },
        config = function()
            require("conform").setup(opts)
        end
    }
}
