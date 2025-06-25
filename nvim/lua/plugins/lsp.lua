return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "neovim/nvim-lspconfig", "williamboman/mason-lspconfig.nvim" },
		opts = {
			-- Constants
			-- List of servers to be installed and configured
			servers = {
				"lua_ls",     	-- Lua language server (LSP)
				"stylua",      	-- Lua formatter

				"clangd",      	-- C/C++ LSP
				"clang-format",	-- C/C++ formatter

				"pyright",     	-- Python LSP
				"black"        	-- Python formatter
			}

			-- Functions
			-- Configure the server settings for servers
			on_attach = function(client, bufnr)
				vim.diagnostic.config({
					float = {
						border = "rounded",
						source = "always",
					},
					virtual_text = true,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				})

				-- Constants
				-- Define diagnostic icons
				local diagnostic_icons = {
					Error = "",
					Warn = "",
					Info = "",
					Hint = "",
				}

				-- Configure signs and virtual text for diagnostics
				for severity, icon in pairs(diagnostic_icons) do
					local highlight_group = "DiagnosticVirtualText" .. severity .. "Border"
					vim.fn.sign_define("DiagnosticSign" .. severity, {
						text = icon,
						texthl = highlight_group,
						numhl = highlight_group,
					})
				end
			end,
		},
		keys = {
			{ "<leader>df", vim.diagnostic.open_float, desc = "Show diagnostic in floating window" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic message" },
			{ "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic message" },
		},
		config = function(_, opts)
			-- Modules
			-- Load mason and mason-lspconfig
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")

			-- Variables
			-- Get the default capabilities for LSP servers
			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup mason and mason-lspconfig
			mason.setup()
			mason_lsp.setup({ ensure_installed = opts.servers, automatic_installation = true })

			-- Configure LSP servers (excluding luau_lsp)
			for _, server in ipairs(opts.servers) do
				-- Exclude luau_lsp as it's not supported by mason-lspconfig yet
				-- This is a workaround until luau_lsp is fully supported by mason-lspconfig
				if server ~= "luau_lsp" then
					lspconfig[server].setup({
						on_attach = opts.on_attach,
						capabilities = default_capabilities,
					})
				end
			end
		end,
	},
	{
		"filipdutescu/renamer.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<F2>", "<cmd>lua require('renamer').rename()<cr>", mode = "i", desc = "Rename in insert mode" },
			{ "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", mode = "n", desc = "Rename in normal mode" },
			{ "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", mode = "v", desc = "Rename in visual mode" },
		},
		config = function()
			-- Load renamer
			local renamer = require("renamer")

			-- Apply custom options
			renamer.setup()
		end,
	},
	{
		"lopi-py/luau-lsp.nvim",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- Load Luau–Lsp
			local luau_lsp = require("luau-lsp")

			-- Handlers for Rojo project detection and filetype setting
			local function rojo_project()
				return vim.fs.root(0, function(name)
					return name:match(".+%.project%.json$")
				end)
			end

			-- Setup Luau–Lsp with Rojo project detection and filetype setting
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

			-- Set fallback filetype for Luau files based on project detection
			if rojo_project() then
				vim.filetype.add({
					extension = {
						lua = function(path)
							return path:match("%.nvim%.lua$") and "lua" or "luau"
						end,
					},
				})
			end
		end,
	},
}
