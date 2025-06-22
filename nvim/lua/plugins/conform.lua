return {
    'stevearc/conform.nvim',
    event = 'VeryLazy', -- Load after full startup
    opts = {
        formatters_by_ft = {
            python = {'black'},
            lua = {'stylua'},
            javascript = {'prettierd'}
        }
    },
    keys = {{
        '<leader>gf',
        function()
            require('conform').format({
                async = true,
                lsp_fallback = true
            })
        end,
        desc = 'Format document'
    }},
    config = function(_, opts)
        require('conform').setup(opts)
    end
}
