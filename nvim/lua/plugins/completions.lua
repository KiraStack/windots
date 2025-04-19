return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- Load when entering Insert mode
        dependencies = {"hrsh7th/cmp-nvim-lsp"},
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({select = true}),
                    ["<C-e>"] = cmp.mapping.abort()
                }),
                sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
				}),
				completion = {
                    completeopt = 'menu,menuone,noinsert',  -- Set completion options
                }
            })
        end
    }
}
