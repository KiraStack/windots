-- ╭──────────────────────────────────────────────────────────────╮
-- │                          Dotfiles                            │
-- │                        KiraStack/dots                        │
-- │                                                              │
-- │       ~ Minimalist ~ Fast ~ Maintainable ~ Lua-powered ~     │
-- ╰──────────────────────────────────────────────────────────────╯

-- ╭──────────────────────────────────────────────────────────────╮
-- │                       Core Settings                          │
-- ╰──────────────────────────────────────────────────────────────╯

vim.opt.number = true -- Show line numbers
-- vim.opt.relativenumber = true -- Show relative line numbers: commented out for now
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.termguicolors = true -- Enable true color support
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.updatetime = 250 -- Faster update time for signs
vim.opt.laststatus = 3 -- Global statusline
vim.opt.statusline = require("core.statusline").statusline -- Custom statusline

-- ╭──────────────────────────────────────────────────────────────╮
-- │                     Indentation Settings                     │
-- ╰──────────────────────────────────────────────────────────────╯

vim.opt.tabstop = 4 -- Number of spaces a tab counts for
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.autoindent = true -- Auto indent new lines
vim.opt.smartindent = true -- Smart auto indenting

-- ╭──────────────────────────────────────────────────────────────╮
-- │                     Diagnostic Signs                         │
-- ╰──────────────────────────────────────────────────────────────╯

vim.diagnostic.config({
	virtual_text = false, -- Disable inline diagnostic text
	signs = {
		error = { text = "E" }, -- Error sign
		warn = { text = "W" }, -- Warning sign
		info = { text = "I" }, -- Information sign
		hint = { text = "H" }, -- Hint sign
	},
	severity_sort = true, -- Sort diagnostics by severity
	float = { border = "rounded" }, -- Rounded borders for diagnostic popups
})

-- ╭──────────────────────────────────────────────────────────────╮
-- │                  Disabled Built-in Plugins                   │
-- ╰──────────────────────────────────────────────────────────────╯

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"gzip",
	"zipPlugin",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logiPat",
	"rrhelper",
	"matchit",
	"matchparen",
}

for _, plugin in ipairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
