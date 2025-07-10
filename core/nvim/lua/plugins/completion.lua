return {
  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │                        AI-powered code completion                        │
  -- ╰──────────────────────────────────────────────────────────────────────────╯

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │                           windsuf.nvim                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────╯

  {
    'Exafunction/windsurf.nvim',
    event = 'InsertEnter', -- Load when entering insert mode
    dependencies = { 'nvim-lua/plenary.nvim', 'hrsh7th/nvim-cmp' },
    config = function()
      require('codeium').setup()
    end,
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │                           Core Engines                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────╯

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │                           nvim-cmp                                       │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- Load when entering insert mode
    dependencies = {
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      -- Load required modules
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- Flag to toggle symbols
      local show_symbols = true

      -- Icons for nvim-cmp menu
      local symbols = {
        Namespace = "󰌗",
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰆧",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󱓻",
        File = "󰈚",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
        Table = "",
        Object = "󰅩",
        Tag = "",
        Array = "[]",
        Boolean = "",
        Number = "",
        Null = "󰟢",
        Supermaven = "",
        String = "󰉿",
        Calendar = "",
        Watch = "󰥔",
        Package = "",
        Copilot = "",
        Codeium = "",
        TabNine = "",
        BladeNav = "",
      }

      -- Highlight groups for selection
      vim.api.nvim_set_hl(0, "CmpPmenuSel", { link = "PmenuSel" })

      local options = {
        -- Disable auto-selection of first item
        preselect = cmp.PreselectMode.None,

        -- Configure nvim-cmp behavior
        completion = {
          completeopt = 'menu,menuone,noselect',
        },

        -- Configure luasnip snippets
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Configure nvim-cmp formatting
        formatting = {
          format = function(entry, item)
            local icon = (show_symbols and symbols[item.kind]) or symbols['Text'] or ''
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

        -- Configure nvim-cmp window
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

        -- Configure key mappings
        mapping = {
          ['<Up>'] = cmp.mapping.select_prev_item(),
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
        },

        -- Setup nvim-cmp sources
        sources = {
          { name = 'nvim_lsp' }, -- Language server
          { name = 'luasnip' },  -- Snippets
          { name = 'buffer' },   -- Text within current buffer
          { name = 'path' },     -- File-system paths
          { name = "codeium" }   -- AI-powered code completion
        },
      }

      require('luasnip.loaders.from_vscode').lazy_load() -- Load snippets
      cmp.setup(options)                                 -- Setup nvim-cmp_luasnip
    end,
  },

  -- ╭──────────────────────────────────────────────────────────────────────────╮
  -- │                           LuaSnip                                        │
  -- ╰──────────────────────────────────────────────────────────────────────────╯
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter', -- Load when entering insert mode
    dependencies = { 'rafamadriz/friendly-snippets' },
    opts = {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    },
    config = function(_, opts)
      require('luasnip').config.set_config(opts)
    end,
  }
}
