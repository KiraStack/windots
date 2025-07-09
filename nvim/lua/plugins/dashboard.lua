return {
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter', -- Load when vim starts
        dependencies = { 'folke/snacks.nvim', },
        opts = {
            theme = 'hyper',
            config = {
                week_header = { enable = true }, -- ISO-8601 week number display
                project = { enable = false },    -- Disable project.nvim integration
                mru = { enable = false },        -- Skip recent files tracking
                footer = {},                     -- No custom footer text/icon
            }
        },
        config = function(_, opts)
            -- Load required modules
            local dashboard = require('dashboard')
            local snacks = require('snacks')

            -- Set theme and colors first
            vim.cmd("highlight DashboardHeader guifg=#ffffff")

            -- Reusable shortcut config
            local shortcuts = {
                {
                    icon = "󰒲  ",
                    icon_hl = "Boolean",
                    desc = "Update ",
                    group = "Directory",
                    action = "Lazy update",
                    key = "u",
                },
                {
                    icon = "   ",
                    icon_hl = "Boolean",
                    desc = "Files ",
                    group = "Statement",
                    action = snacks.picker.files,
                    key = "f",
                },
                {
                    icon = "   ",
                    icon_hl = "Boolean",
                    desc = "Recent ",
                    group = "String",
                    action = snacks.picker.recent,
                    key = "r",
                },
                {
                    icon = "   ",
                    icon_hl = "Boolean",
                    desc = "Grep ",
                    group = "ErrorMsg",
                    action = snacks.picker.grep,
                    key = "g",
                },
                {
                    icon = "   ",
                    icon_hl = "Boolean",
                    desc = "Quit ",
                    group = "WarningMsg",
                    action = "qall!",
                    key = "q",
                },
            }

            -- Merge shortcuts
            opts.config.shortcut = shortcuts

            -- Apply custom options
            dashboard.setup(opts)
        end,
    },
}
