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
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

-- Disable built-in plugins that are not needed
vim.g.loaded_netrw = 1  -- Disable netrw (file explorer)
vim.g.loaded_netrwPlugin = 1  -- Disable the netrw plugin
