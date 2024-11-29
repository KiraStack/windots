return {
    {
        "williamboman/mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
        config = function()
            local servers = { "pyright", "ts_ls" }
    
            require("mason").setup()
            require("mason-lspconfig").setup({ ensure_installed = servers })
    
            for i, server_name in ipairs(servers) do
                require("lspconfig")[server_name].setup {}
            end
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = "BufReadPost",  -- Load when a buffer has been read
        -- dependencies = { "nvimtools/none-ls-extras.nvim" },
        config = function()
            local null_ls = require("null-ls")
    
            -- Configure custom diagnostics if builtins aren't available
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.prettierd,
                }
            })
    
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                virtual_text = false,
                signs = true,
                update_in_insert = false,
                underline = true,
            })
    
            vim.diagnostic.config({ float = { source = "always", border = "rounded", }, })
        end,
    }
}