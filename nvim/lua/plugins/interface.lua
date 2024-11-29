return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        event = "BufWinEnter",  -- Triggered when a buffer window is entered
        priority = 1000, -- High priority to load early
        config = function()
            vim.cmd.colorscheme "catppuccin"
        end,
    },    
    {
        "nvimdev/dashboard-nvim",
        event = "BufWinEnter",  -- Triggered when a buffer window is entered
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
          require("dashboard").setup()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "BufWinEnter",  -- Triggered when a buffer window is entered
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            vim.defer_fn(function()
                require("lualine").setup({ options = { theme = 'auto' } })
            end, 50)
        end,
    }    
}
  