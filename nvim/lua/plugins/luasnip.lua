return {
    'L3MON4D3/LuaSnip', -- Snippet plugin
    event = 'VeryLazy', -- Load after full startup
    dependencies = 'rafamadriz/friendly-snippets',
    opts = {
        history = true,
        updateevents = 'TextChanged,TextChangedI'
    },
    config = function(_, opts)
        local luasnip = require('luasnip')
        luasnip.config.set_config(opts)
    end
}