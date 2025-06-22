return {
    'gelguy/wilder.nvim',
    event = 'VeryLazy', -- Load after full startup
    opts = {
        -- Define the modes to enable Wilder in
        modes = {":", "/", "?"},

        -- Define the gradient colors
        colors = {'#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63', '#ff6658', '#ff704e', '#ff7a45', '#ff843d',
                  '#ff9036', '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934', '#c8d43a', '#bfde43', '#b6e84e',
                  '#aff05b'},

        -- Define the key mappings
        next_key = '<Tab>',
        previous_key = '<S-Tab>',
        accept_key = '<Down>',
        reject_key = '<Up>'
    },
    config = function(_, opts)
        -- Set up Wilder with the provided options
        local wilder = require('wilder')
        wilder.setup(opts)

        -- Define the highlight groups for the gradient
        local gradient = {}
        for idx, color in ipairs(opts.colors) do
            gradient[idx] = wilder.make_hl('WilderGradient' .. idx, 'Pmenu', {{a=1}, {a=1}, {foreground=color}})
        end

        -- Set up the menu and bindings
        wilder.set_option('renderer', wilder.popupmenu_renderer(
            wilder.popupmenu_border_theme({
                -- Define the highlights for the border
                highlights = {
                    border = 'Normal',
                    gradient = gradient
                },
                -- Set the border style to rounded
                border = 'rounded',

                -- Highlight the current word in the search result
                highlighter = wilder.highlighter_with_gradient({wilder.basic_highlighter()})
            })))
    end
}