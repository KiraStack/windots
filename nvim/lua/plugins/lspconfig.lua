return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", lazy = false },
        { "williamboman/mason-lspconfig.nvim", lazy = false },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "ts_ls", "lua_ls" },
        })

        local function on_attach(_, bufnr)
            local opts = { noremap = true, silent = true }
            local buf_set_keymap = vim.api.nvim_buf_set_keymap
            buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
            buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")
        local servers = { "pyright", "ts_ls", "lua_ls" }

        for _, server in ipairs(servers) do
            lspconfig[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    telemetry = { enable = false },
                },
            },
        })
    end,
}
