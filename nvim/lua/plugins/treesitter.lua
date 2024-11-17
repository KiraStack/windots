return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost", -- Load after the buffer is completely read
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {"python", "javascript", "typescript", "lua"},
            highlight = {
                enable = true
            }
        })
    end
}
