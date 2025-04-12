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
local disabled_built_ins = {
  "netrw", "netrwPlugin", "gzip", "zipPlugin",
  "tarPlugin", "getscript", "getscriptPlugin",
  "vimball", "vimballPlugin", "2html_plugin",
  "logiPat", "rrhelper", "matchit", "matchparen",
}
for _, plugin in ipairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
