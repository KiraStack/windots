return {
	{
		'williamboman/mason.nvim',
		event = 'VeryLazy', -- Load after full startup
		dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim' },
		opts = {
			-- Constants
			-- List of servers to be installed and configured
			servers = {
				'clangd', -- C/C++
				'cssls', -- CSS
				-- 'gopls', -- Go
				'html', -- HTML
				'jdtls', -- Java
				'ts_ls', -- TypeScript/JavaScript
				'lua_ls', -- Lua
				'pyright', -- Python
				'rust_analyzer', -- Rust
			},

			-- Functions
			-- Configure the server settings for servers
			on_attach = function(client, bufnr)
				-- Constants
				-- Define diagnostic icons
				local diagnostic_icons = {
					Error = 'E', -- previous value: ''
					Warn  = 'W', -- previous value: ''
					Info  = 'I', -- previous value: ''
					Hint  = 'H', -- previous value: ''
				}

				-- Configure signs and virtual text for diagnostics
				for severity, icon in pairs(diagnostic_icons) do
					local highlight_group = 'DiagnosticVirtualText' .. severity .. 'Border'
					vim.fn.sign_define('DiagnosticSign' .. severity, {
						text = icon,
						texthl = highlight_group,
						numhl = highlight_group,
					})
				end
			end,
		},
		keys = {
			{ '<leader>df', vim.diagnostic.open_float, desc = 'Show diagnostic in floating window' },
			{ '[d',         vim.diagnostic.goto_prev,  desc = 'Go to previous diagnostic message' },
			{ ']d',         vim.diagnostic.goto_next,  desc = 'Go to next diagnostic message' },
		},
		config = function(_, opts)
			-- Modules
			-- Load mason and mason-lspconfig
			local mason = require('mason')
			local mason_lsp = require('mason-lspconfig')
			local lspconfig = require('lspconfig')

			-- Variables
			-- Get the default capabilities for LSP servers
			local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Setup mason and mason-lspconfig
			mason.setup()
			mason_lsp.setup({ ensure_installed = opts.servers, automatic_installation = true })

			-- Configure LSP servers (excluding luau_lsp)
			for _, server in ipairs(opts.servers) do
				-- Exclude luau_lsp as it's not supported by mason-lspconfig yet
				-- This is a workaround until luau_lsp is fully supported by mason-lspconfig
				if server ~= 'luau_lsp' then
					lspconfig[server].setup({
						on_attach = opts.on_attach,
						capabilities = default_capabilities,
					})
				end
			end
		end,
	},
	{
		'filipdutescu/renamer.nvim',
		event = 'VeryLazy', -- Load after full startup
		dependencies = { 'nvim-lua/plenary.nvim' },
		keys = {
			{ '<F2>',       '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'i', desc = 'Rename in insert mode' },
			{ '<leader>rn', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'n', desc = 'Rename in normal mode' },
			{ '<leader>rn', '<cmd>lua require(\'renamer\').rename()<cr>', mode = 'v', desc = 'Rename in visual mode' },
		},
		config = function()
			require('renamer').setup()
		end,
	}
}
