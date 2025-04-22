return {
{
		"L3MON4D3/LuaSnip", -- Snippet plugin
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
			require("luasnip").config.set_config(opts)
        end,
    },
	{
		"saadparwaiz1/cmp_luasnip",
		event = "InsertEnter", -- Load when entering Insert mode
	},
    {
		"hrsh7th/cmp-nvim-lua",
		event = "InsertEnter", -- Load when entering Insert mode
	},
    {
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter", -- Load when entering Insert mode
	},
    {
		"hrsh7th/cmp-buffer",
		event = "InsertEnter", -- Load when entering Insert mode
	},
    {
		"hrsh7th/cmp-path",
		event = "InsertEnter", -- Load when entering Insert mode
	},
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- Load when entering Insert mode
        dependencies = {"hrsh7th/cmp-nvim-lsp"},
        config = function(_, opts)
            local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				completion = { completeopt = "menu,menuone" },
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					},
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
				},
				window = {
					completion = {
						scrollbar = false,
						side_padding = atom_styled and 0 or 1,
						winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
						border = atom_styled and "none" or "single",
					},
					documentation = {
						border = "single",
						winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
					},
				},
				view = {
					entries = {
						follow_cursor = true,
					},
				},
			})
		end,
    }
}
