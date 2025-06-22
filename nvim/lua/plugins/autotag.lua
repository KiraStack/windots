return {
    'windwp/nvim-ts-autotag',
    event = 'BufReadPost', -- Load when a buffer is read
    config = function()
        -- Initiate the plugin with default settings
        require('nvim-ts-autotag').setup()
    end
}
