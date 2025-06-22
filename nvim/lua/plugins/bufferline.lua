return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {{
        '<leader>bp',
        '<Cmd>BufferLineTogglePin<CR>',
        desc = 'Toggle Pin'
    }, {
        '<leader>bP',
        '<Cmd>BufferLineGroupClose ungrouped<CR>',
        desc = 'Delete Non-Pinned Buffers'
    }, {
        '<leader>br',
        '<Cmd>BufferLineCloseRight<CR>',
        desc = 'Delete Buffers to the Right'
    }, {
        '<leader>bl',
        '<Cmd>BufferLineCloseLeft<CR>',
        desc = 'Delete Buffers to the Left'
    }, {
        '<S-h>',
        '<Cmd>BufferLineCyclePrev<CR>',
        desc = 'Prev Buffer'
    }, {
        '<S-l>',
        '<Cmd>BufferLineCycleNext<CR>',
        desc = 'Next Buffer'
    }, {
        '[b',
        '<Cmd>BufferLineCyclePrev<CR>',
        desc = 'Prev Buffer'
    }, {
        ']b',
        '<Cmd>BufferLineCycleNext<CR>',
        desc = 'Next Buffer'
    }, {
        '[B',
        '<Cmd>BufferLineMovePrev<CR>',
        desc = 'Move Buffer Prev'
    }, {
        ']B',
        '<Cmd>BufferLineMoveNext<CR>',
        desc = 'Move Buffer Next'
    }},
    opts = {
        options = {
            close_command = function(n)
                Snacks.bufdelete(n)
            end,
            right_mouse_command = function(n)
                Snacks.bufdelete(n)
            end,
            diagnostics = 'nvim_lsp',
            always_show_bufferline = false,
            offsets = {{
                filetype = 'neo-tree',
                text = 'Neo-tree',
                highlight = 'Directory',
                text_align = 'left'
            }, {
                filetype = 'snacks_layout_box'
            }}
        }
    },
    config = function(_, opts)
        require('bufferline').setup(opts)
    end
}