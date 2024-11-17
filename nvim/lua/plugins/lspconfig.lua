return {
    "neovim/nvim-lspconfig",
    event = "BufReadPost", -- Load after the buffer is completely read
    config = function()
        local lspconfig = require('lspconfig')

        -- Python (Pyright)
        lspconfig.pyright.setup()

        -- JavaScript/TypeScript (ts_ls)
        lspconfig.ts_ls.setup()
    end
}
