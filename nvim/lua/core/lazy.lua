-- Environmental variables
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Configure lazy.nvim installation path
local path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local repo = 'https://github.com/folke/lazy.nvim.git'

if not (vim.uv or vim.loop).fs_stat(path) then
	local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, path })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
			{ out,                            'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})

		vim.fn.getchar()
		os.exit(1)
	end
end

-- Add lazy.nvim to runtimepath
vim.opt.rtp:prepend(path)

require('lazy').setup({
	spec = {
		{ import = 'plugins' }, -- Main plugins specification
	},

	defaults = {
		lazy = false, -- Load plugins immediately by default
		version = false, -- Always use latest version
	},

	install = {
		colorscheme = { 'tokyonight', 'habamax' }, -- Default colorschemes
	},

	checker = {
		enabled = true, -- Automatically check for updates
		notify = false, -- Disable update notifications
	},
})
