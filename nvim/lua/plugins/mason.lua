return {
	{
		'williamboman/mason.nvim',
		event = 'VeryLazy', -- Load after full startup
		dependencies = {'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim'},

		opts = {
			-- Constants
			servers = {'pyright'},
			
			-- Functions
			on_attach = function(client, bufnr)
				vim.diagnostic.config({
					float = {
						border = 'rounded',
						source = 'always',
					},
					virtual_text = true,
					signs = true,
					underline = true,
					update_in_insert = false,
					severity_sort = true,
				})

				-- Constants
				local diagnostic_icons = {
					Error = '',
					Warn  = '',
					Info  = '',
					Hint  = ''
				}
				
				for severity, icon in pairs(diagnostic_icons) do
					local highlight_group = 'DiagnosticVirtualText' .. severity .. 'Border'
					vim.fn.sign_define('DiagnosticSign' .. severity, {
						text = icon,
						texthl = highlight_group,
						numhl = highlight_group
					})
				end
			end,
		},
		keys = {
			{ '<leader>df', vim.diagnostic.open_float, desc = 'Show diagnostic in floating window' },
			{ '[d', vim.diagnostic.goto_prev, desc = 'Go to previous diagnostic message' },
			{ ']d', vim.diagnostic.goto_next, desc = 'Go to next diagnostic message' },
		},
		config = function(_, opts)
			-- Modules
			local mason = require('mason')
			local mason_lsp = require('mason-lspconfig')
			local lspconfig = require('lspconfig')

			-- Variables
			local default_capabilities = require('cmp_nvim_lsp').default_capabilities()

			-- Setup mason and mason-lspconfig
			mason.setup()
			mason_lsp.setup({ ensure_installed = opts.servers, automatic_installation = true })

			-- Configure LSP servers (excluding luau_lsp)
			for _, server in ipairs(opts.servers) do
				if server ~= 'luau_lsp' then
					lspconfig[server].setup({
						on_attach = opts.on_attach,
						capabilities = default_capabilities
					})
				end
			end
		end
	},
}