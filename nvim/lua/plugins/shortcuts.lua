return {
	{
		'L3MON4D3/LuaSnip',
		event = 'InsertEnter', -- Load when entering Insert mode
		dependencies = { 'saadparwaiz1/cmp_luasnip', 'rafamadriz/friendly-snippets' },
	},
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter', -- Load when entering Insert mode
		dependencies = { 'hrsh7th/cmp-nvim-lsp' },
		config = function()
			local cmp = require('cmp')
			local luasnip = require('luasnip')

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-e>'] = cmp.mapping.abort(),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
				}),
			})

			require('luasnip.loaders.from_vscode').lazy_load()
		end,
	},
}
