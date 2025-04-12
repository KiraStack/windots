return {
    {
        "williamboman/mason.nvim",
        event = "VeryLazy", -- Load after full startup
        dependencies = {"williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig"},
        config = function()
            local servers = {"pyright", "ts_ls"}

            require("mason").setup()
            require("mason-lspconfig").setup({ensure_installed = servers})

            local on_attach = function(client, bufnr)
                -- Enable diagnostics
                vim.diagnostic.config(
                    {
                        virtual_text = true,
                        signs = true,
                        underline = true,
                        update_in_insert = false,
                        severity_sort = true
                    }
                )
            end

            for _, server in ipairs(servers) do
                require("lspconfig")[server].setup(
                    {
                        on_attach = on_attach,
                        capabilities = require("cmp_nvim_lsp").default_capabilities()
                    }
                )
            end
        end
    },
    {
        "stevearc/conform.nvim",
        event = "BufReadPost", -- Load when a buffer is read
        opts = {
            formatters_by_ft = {
                python = {"black"}, -- Black for Python
                javascript = {"prettierd"} -- Prettier for JavaScript
            }
        },
        keys = {
            {"<leader>gf", function()
                    require("conform").format({async = true, lsp_fallback = true})
                end, desc = "Format document"}
        },
        config = function()
            require("conform").setup(opts)
        end
    }
}
