-- Declare the main table
local Module = {}

-- Imports
local colors = require("kyomi.colors")

-- Initialize base highlights
function Module.setup()
	-- Define base colors
	vim.api.nvim_set_hl(0, "Normal", { fg = colors.base_16.base05, bg = colors.base_16.base00 })
	vim.api.nvim_set_hl(0, "Comment", { fg = colors.base_16.base03, italic = true })
	vim.api.nvim_set_hl(0, "Constant", { fg = colors.base_16.base09 })
	vim.api.nvim_set_hl(0, "String", { fg = colors.base_16.base0A })
	vim.api.nvim_set_hl(0, "Character", { fg = colors.base_16.base0A })
	vim.api.nvim_set_hl(0, "Number", { fg = colors.base_16.base09 })
	vim.api.nvim_set_hl(0, "Boolean", { fg = colors.base_16.base09 })
	vim.api.nvim_set_hl(0, "Float", { fg = colors.base_16.base09 })
	vim.api.nvim_set_hl(0, "Identifier", { fg = colors.base_16.base08 })
	vim.api.nvim_set_hl(0, "Function", { fg = colors.base_16.base0D })
	vim.api.nvim_set_hl(0, "Statement", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Conditional", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Repeat", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Label", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Operator", { fg = colors.base_16.base05 })
	vim.api.nvim_set_hl(0, "Keyword", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Exception", { fg = colors.base_16.base08 })
	vim.api.nvim_set_hl(0, "PreProc", { fg = colors.base_16.base0A })
	vim.api.nvim_set_hl(0, "Include", { fg = colors.base_16.base0D })
	vim.api.nvim_set_hl(0, "Define", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Macro", { fg = colors.base_16.base08 })
	vim.api.nvim_set_hl(0, "PreCondit", { fg = colors.base_16.base0A })
	vim.api.nvim_set_hl(0, "Type", { fg = colors.base_16.base0A })
	vim.api.nvim_set_hl(0, "StorageClass", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Structure", { fg = colors.base_16.base0E })
	vim.api.nvim_set_hl(0, "Typedef", { fg = colors.base_16.base0A })
	vim.api.nvim_set_hl(0, "Special", { fg = colors.base_16.base0C })
	vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors.base_16.base0F })
	vim.api.nvim_set_hl(0, "Tag", { fg = colors.base_16.base0A })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.base_16.base0F })
	vim.api.nvim_set_hl(0, "SpecialComment", { fg = colors.base_16.base03 })
	vim.api.nvim_set_hl(0, "Debug", { fg = colors.base_16.base08 })
	vim.api.nvim_set_hl(0, "Underlined", { underline = true })
	vim.api.nvim_set_hl(0, "Ignore", {})
	vim.api.nvim_set_hl(0, "Error", { fg = colors.base_16.base08, bg = colors.base_16.base00 })
	vim.api.nvim_set_hl(0, "Todo", { fg = colors.base_16.base0A, bg = colors.base_16.base00 })
end

-- Export the module
return Module
