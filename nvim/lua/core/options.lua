-- Set up leader keys before loading lazy.nvim for correct mappings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General settings
vim.opt.number = true -- Show line numbers
vim.opt.clipboard = "unnamedplus" -- Use system clipboard

-- Indentation settings
vim.opt.tabstop = 4 -- Set tab width to 4 spaces
vim.opt.shiftwidth = 4 -- Set indentation width to 4 spaces

-- Disable netrw and its plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable true color support in the terminal
vim.opt.termguicolors = true
