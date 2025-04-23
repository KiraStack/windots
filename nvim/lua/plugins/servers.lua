return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = {"neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim"},
		opts = {
			-- Constants
			servers = {"lua_ls", "luau_lsp", "pyright", "ts_ls"},
			
			-- Function to be called on attach
			on_attach = function(client, bufnr)
				vim.diagnostic.config({
					float = {
						border = "rounded",
						source = "always",
					},
					-- virtual_text = {
					--	source = "if_many",
					--	format = function(diagnostic)
					--		return string.format("%s %s", diagnostic.message:gsub("\n", " "), diagnostic.source and ("(" .. diagnostic.source ..")") or "")
					--	end,
					-- },
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				})

				-- Apply the custom highlights
				for severity, icon in pairs({ Error = "", Warn  = "", Info  = "", Hint  = "" }) do
					local highlight_group = "DiagnosticVirtualText" .. severity .. "Border"
					vim.fn.sign_define("DiagnosticSign" .. severity, {
						text = icon,
						texthl = highlight_group,
						numhl = highlight_group
					})
				end

				-- Key mappings to show diagnostics
				vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })
				vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
				vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
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
			mason_lsp.setup({ ensure_installed = opts.servers, automatic_installation = true })

			-- Configure LSP servers (excluding luau_lsp)
			for _, server in ipairs(opts.servers) do
				if server ~= "luau_lsp" then
					lspconfig[server].setup({
						on_attach = opts.on_attach,
						capabilities = default_capabilities
					})
				end
			end
		end
	},
	{
		"lopi-py/luau-lsp.nvim",
		event = "InsertEnter", -- Load when entering Insert mode
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local luau_lsp = require("luau-lsp")
		
			local function rojo_project()
				return vim.fs.root(0, function(name)
					return name:match ".+%.project%.json$"
				end)
			end
			
			luau_lsp.setup({
				sourcemap = {
					enabled = true,
					autogenerate = true, -- automatic generation when the server is attached
					rojo_project_file = "default.project.json",
					sourcemap_file = "sourcemap.json",
				},
				platform = {
					type = rojo_project() and "roblox" or "standard",
				},
				types = {
					roblox_security_level = "PluginSecurity",
				},
			})

			if rojo_project() then
				vim.filetype.add({
					extension = {
						lua = function(path)
							return path:match "%.nvim%.lua$" and "lua" or "luau"
						end,
					},
				})
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
        config = function(_, opts)
            require("conform").setup(opts)
        end
    }
}
