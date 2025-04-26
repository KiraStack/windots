return {
	{
        'nvim-treesitter/nvim-treesitter',
        event = 'BufReadPost', -- Load when a buffer is read
        build = ':TSUpdate',
        config = function()
			local configs = require('nvim-treesitter.configs')
			local servers = {'python'}
			
            configs.setup({
                ensure_installed = servers,
                highlight = {enable = true},
                indent = {enable = true}
            })
        end,
	},
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
					-- virtual_text = {
					--	source = 'if_many',
					--	format = function(diagnostic)
					--		' string.format('%s %s', diagnostic.message:gsub('\n', ' '), diagnostic.source and ('(' .. diagnostic.source ..')') or '')
					--	end,
					-- },
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
	{
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter', -- Load when entering Insert mode
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
                        winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder',
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
	{
		'lopi-py/luau-lsp.nvim',
		event = 'BufReadPost', -- Load when a buffer is read
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local luau_lsp = require('luau-lsp')
		
			local function rojo_project()
				return vim.fs.root(0, function(name)
					return name:match '.+%.project%.json$'
				end)
			end
			
			luau_lsp.setup({
				sourcemap = {
					enabled = true,
					autogenerate = true, -- automatic generation when the server is attached
					rojo_project_file = 'default.project.json',
					sourcemap_file = 'sourcemap.json',
				},
				platform = {
					type = rojo_project() and 'roblox' or 'standard',
				},
				types = {
					roblox_security_level = 'PluginSecurity',
				},
			})

			if rojo_project() then
				vim.filetype.add({
					extension = {
						lua = function(path)
							return path:match '%.nvim%.lua$' and 'lua' or 'luau'
						end,
					},
				})
			end
		end
	},
	{
		'L3MON4D3/LuaSnip', -- Snippet plugin
		event = 'BufReadPost', -- Load when a buffer is read
        dependencies = 'rafamadriz/friendly-snippets',
        opts = {
			history = true,
			updateevents = 'TextChanged,TextChangedI'
		},
        config = function(_, opts)
			local luasnip = require('luasnip')
			luasnip.config.set_config(opts)
        end,
    },
}