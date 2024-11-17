return {
    "nvimtools/none-ls.nvim",
    event = "BufReadPost",
	dependencies = { "nvimtools/none-ls-extras.nvim" },
    config = function()
        local null_ls = require("null-ls")

        -- Configure custom diagnostics if builtins aren't available
        null_ls.setup({
            sources = {
                -- Python: Ruff and Black
                require("none-ls.diagnostics.ruff"),
                null_ls.builtins.formatting.black,

                -- JavaScript/TypeScript: Eslint and Prettier
                require("none-ls.diagnostics.eslint_d"),
                null_ls.builtins.formatting.prettier,
            },
        })

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = true,
            update_in_insert = false,
            underline = true,
        })

        vim.diagnostic.config({
            float = {
                source = "always",
                border = "rounded",
            },
        })
    end,
}
