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
      -- [Previous nvim-cmp configuration remains unchanged]
      -- ... rest of the config ...
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
