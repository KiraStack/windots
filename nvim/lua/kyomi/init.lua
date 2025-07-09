-- Imports
local base = require('kyomi.base')
local languages = require('kyomi.languages')

local Module = {
    name = 'kyomi',
    type = 'dark',               -- Choose between 'dark' or 'light'
    semanticHighlighting = true, -- Enable semantic highlighting
}

function Module.setup()
    -- Define the flags to enable syntax highlighting
    vim.o.background = Module.type          -- Set the background color
    vim.o.termguicolors = true              -- Enable true color support
    vim.opt.fillchars:append({ eob = ' ' }) -- Hide tildes

    base.setup()                            -- Apply the base configuration
    languages.setup()                       -- Apply language-specific configurations

    -- Set the colorscheme
    vim.g.colors_name = Module.name -- Set the colorscheme name
end

return Module
