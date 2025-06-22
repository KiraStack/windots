return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy', -- Load after full startup
    dependencies = {'nvim-tree/nvim-web-devicons'},
    opts = {
        options = {
            theme = 'auto'
        },
        sections = {
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat'}
        }
    },
    config = function(_, opts)
        -- Init lualine and set options
        require('lualine').setup(opts)
    end
}
