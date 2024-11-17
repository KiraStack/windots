-- Set essential leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core settings to minimize startup overhead
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Disable netrw and its plugin entirely (saves resources)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
