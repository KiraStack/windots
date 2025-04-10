return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufReadPost", -- Load when a buffer is read
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup(
                {
                    ensure_installed = {"python", "javascript", "typescript", "tsx"},
                    highlight = {enable = true},
                    indent = {enable = true}
                }
            )
        end
    }
}
