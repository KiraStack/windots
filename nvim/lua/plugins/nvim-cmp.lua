return {
	{
        'hrsh7th/nvim-cmp',
        event = 'VeryLazy', -- Load after full startup
        dependencies = {
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'saadparwaiz1/cmp_luasnip',
		},
		config = function()
            -- Modules
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            
            -- Settings
            local show_icons = true
            
            -- Constants
            local icons = {
                Text = '', Function = '󰆧', Method = 'ƒ', Constructor = '', 
                Field = '󰜢', Variable = '󰀫', Class = '󰠱', Interface = '', 
                Module = '', Property = '󰜢', Unit = '', Value = '', Enum = '',
                Keyword = '', Snippet = '', Color = '', File = '', 
                Reference = '', Folder = '', EnumMember = '', Constant = '', 
                Struct = '', Event = '', Operator = '', TypeParameter = ''
            }
			
			-- Highlight groups for selection
			vim.api.nvim_set_hl(0, "CmpPmenuSel", { link = "PmenuSel" })
            
            local options = {
                preselect = cmp.PreselectMode.None,
                completion = {
                    completeopt = 'menu,menuone,noselect',
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                formatting = {
                    format = function(entry, item)
                        local icon = show_icons and icons[item.kind] or ''
                        local kind = item.kind or ''

                        item.menu = kind
                        item.menu_hl_group = 'CmpItemKind' .. kind
                        item.kind = icon

                        if #item.abbr > 30 then
                            item.abbr = string.sub(item.abbr, 1, 30) .. '…'
                        end
						
                        return item
                    end,
                },
                window = {
                    completion = {
                        scrollbar = false,
                        side_padding = 1,
						winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None',
                        border = 'single',
                    },
                    documentation = {
                        border = 'single',
                        winhighlight = 'Normal:CmpDoc,FloatBorder:CmpDocBorder',
                    },
                },
                mapping = {
                    ['<Up>'] = cmp.mapping.select_prev_item(),
                    ['<Down>'] = cmp.mapping.select_next_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'nvim_lua' },
                    { name = 'path' },
                },
            }
            
            cmp.setup(options)
        end,
    },
}