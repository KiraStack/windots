-- Options are automatically loaded before startup
-- Add any additional options here

-- Core settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

-- Indentation settings
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

-- Disable unnecessary built-in plugins
vim.g.loaded_netrw = 1 -- Disable netrw (file explorer)
vim.g.loaded_netrwPlugin = 1 -- Disable the netrw plugin
