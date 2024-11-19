return {
    "neovim/nvim-lspconfig",
    event = "BufReadPost", -- Load after the buffer is completely read
	dependencies = {
        "williamboman/mason.nvim",           -- Dependency for managing external LSPs, linters, etc.
        "williamboman/mason-lspconfig.nvim", -- Dependency for integrating Mason with nvim-lspconfig
    },
    config = function()
        local lspconfig = require("lspconfig")

        -- Set up Mason
        require('mason').setup()
        
        -- Set up Mason LSP config
        require('mason-lspconfig').setup({
            ensure_installed = { 'pyright', 'ts_ls' }
        })

        -- Python (Pyright) configuration
        lspconfig.pyright.setup {}

        -- JavaScript/TypeScript (tsserver) configuration
        lspconfig.ts_ls.setup {}
    end
}
