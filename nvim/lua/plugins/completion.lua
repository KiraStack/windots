return {
	{
		"tzachar/cmp-tabnine",
		event = "VeryLazy", -- Load after full startup
		build = (vim.fn.has("win32") == 1) and "powershell -noni .\\install.ps1" or "./install.sh", -- Install script for Windows or Linux respectively
		opts = {
			max_lines = 1000,
			max_num_results = 3,
			sort = true,
		},
		config = function(_, opts)
			-- Load cmp_tabnine
			local cmp_tabnine = require("cmp_tabnine.config")

			-- Apply custom options
			cmp_tabnine:setup(opts)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "VeryLazy", -- Load after full startup
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			-- Modules
			-- Load cmp module
			local cmp = require("cmp")

			-- Load luasnip module
			local luasnip = require("luasnip")

			-- Settings
			-- Flag to enable/disable completion triggers in insert mode.
			local show_icons = true

			-- Constants
			-- Icons for completion items
			local icons = {
				Text = "",
				Function = "󰆧",
				Method = "ƒ",
				Constructor = "",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "",
				Module = "",
				Property = "󰜢",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = "",
			}

			-- Highlight groups for selection
			vim.api.nvim_set_hl(0, "CmpPmenuSel", { link = "PmenuSel" })

			-- Define user configuration
			local options = {
				-- Disable preselect mode
				preselect = cmp.PreselectMode.NONE,

				-- Enable auto-completion
				completion = {
					completeopt = "menu,menuone,noselect",
				},

				-- Enable snippet support
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				-- Define format function for displaying completion items
				formatting = {
					format = function(entry, item)
						local icon = show_icons and icons[item.kind] or ""
						local kind = item.kind or ""

						item.menu = kind
						item.menu_hl_group = "CmpItemKind" .. kind
						item.kind = icon

						if #item.abbr > 30 then
							item.abbr = string.sub(item.abbr, 1, 30) .. "…"
						end

						return item
					end,
				},

				-- Define window settings for cmp
				window = {
					-- Define window settings for completion
					completion = {
						scrollbar = false,
						side_padding = 1,
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None",
						border = "single",
					},

					-- Define window settings for documentation
					documentation = {
						border = "single",
						winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
					},
				},

				-- Define mappings for cmp
				mapping = {
					["<Up>"] = cmp.mapping.select_prev_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
				},

				-- Add the following sources to cmp
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "cmp_tabnine" },
				},
			}

			-- Apply custom options to cmp
			cmp.setup(options)
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		event = "VeryLazy", -- Load after full startup
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			history = true,
			updateevents = "TextChanged,TextChangedI",
		},
		config = function(_, opts)
			-- Load LuaSnip
			local luasnip = require("luasnip")

			-- Apply custom options to LuaSnip
			luasnip.config.set_config(opts)
		end,
	},
}
