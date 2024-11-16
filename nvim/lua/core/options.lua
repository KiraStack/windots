-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General options
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Set up indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Keybindings for completion navigation
-- vim.api.nvim_set_keymap('i', '<C-Space>', [[compe#complete()]], { expr = true, noremap = true })
-- vim.api.nvim_set_keymap('i', '<C-e>', [[compe#close('<C-e>')]], { expr = true, noremap = true })