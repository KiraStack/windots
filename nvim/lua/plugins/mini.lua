return {
    'echasnovski/mini.nvim',
    version = false,
    event = 'VeryLazy', -- Load after full startup
    opts = {
        ['comment'] = {}, -- Uses `gc` by default
        ['move'] = {}, -- Uses `alt` mappings by default
        ['pairs'] = {} -- Auto pairs by default
    },
    config = function(_, opts)
        for name, config in pairs(opts) do
            require('mini.' .. name).setup(config)
        end
    end
}