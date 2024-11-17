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

vim.g.loaded_2html_plugin = 1  -- Disable HTML export plugin
vim.g.loaded_gzip = 1  -- Disable gzip compression plugin
vim.g.loaded_man = 1  -- Disable manual pages plugin
vim.g.loaded_matchit = 1  -- Disable matchit plugin (used for matching words)
vim.g.loaded_matchparen = 1  -- Disable matchparen (for matching parentheses)
vim.g.loaded_logiPat = 1  -- Disable logic pattern plugin
vim.g.loaded_rrhelper = 1  -- Disable rrhelper plugin (for debugging)
vim.g.loaded_tarPlugin = 1  -- Disable tar file plugin
vim.g.loaded_zipPlugin = 1  -- Disable zip file plugin
vim.g.loaded_tutor_mode_plugin = 1  -- Disable the tutor mode plugin
vim.g.loaded_remote_plugins = 1  -- Disable remote plugins (used for language server or external tools)

-- Disable language-specific providers that may not be used
vim.g.loaded_python_provider = 0  -- Disable Python provider if not using Python
vim.g.loaded_perl_provider = 0    -- Disable Perl provider if not using Perl
vim.g.loaded_ruby_provider = 0    -- Disable Ruby provider if not using Ruby
vim.g.loaded_node_provider = 0    -- Disable Node.js provider if not using Node.js

-- Disable legacy completion system (use modern completion plugins instead)
vim.g.loaded_complpeg = 1  -- Disable legacy completion plugin

-- Disable spell-checking plugin if not needed
vim.g.loaded_spellfile_plugin = 1  -- Disable the spell-checking file plugin

-- Disable swap files to prevent disk I/O (speed up startup)
vim.opt.swapfile = false  -- Disable swap files (faster startup, less disk usage)

-- Disable backup files (avoid creating backup copies)
vim.opt.backup = false  -- Disable backup files (no backup on save)
vim.opt.writebackup = false  -- Prevent writing backup files
vim.opt.undofile = false  -- Disable undofiles (no undo history persistence)

-- Disable syntax highlighting and filetype detection to speed up startup
vim.g.syntax_on = 0  -- Disable syntax highlighting (no syntax parsing during startup)
vim.cmd('filetype off')  -- Turn off automatic filetype detection (faster startup)
vim.cmd('filetype plugin off')  -- Disable filetype-specific plugins (faster startup)
vim.cmd('filetype indent off')  -- Disable automatic indentation rules for filetypes

-- Disable clipboard integration if not needed (reduces external dependencies)
vim.opt.clipboard = ""  -- Disable system clipboard integration (no need to interface with system clipboard)

-- Disable autocommands that run automatically when certain events occur (faster startup)
vim.cmd('au!')  -- Clear all autocommands (no unnecessary events triggered at startup)

-- Suppress unnecessary messages during startup (speed up loading)
vim.opt.shortmess:append("c")  -- Avoid "file found" and similar messages (faster loading without interruption)

-- Disable folding if you don't need it (saves processing time on file load)
vim.opt.foldenable = false  -- Disable automatic folding (no need to calculate fold levels)
