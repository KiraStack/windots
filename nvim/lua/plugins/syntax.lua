return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost",  -- Load when a buffer is read
        build = ":TSUpdate",
    },    
    {
        "stevearc/conform.nvim",
        event = "BufReadPost",  -- Load when a buffer is read
        config = function()
            require("conform").setup {
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = function(bufnr)
                        if require("conform").get_formatter_info("ruff_format", bufnr).available then
                            return {"ruff_format"}
                        else
                            return {"isort", "black"}
                        end
                    end,
                    javascript = { "prettierd", "prettier", stop_after_first = true }
                }
            }
        end,
    }
}