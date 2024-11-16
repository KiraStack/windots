function safe_require(module)
	local success, response = pcall(require, module)
	if success then
		return response
	end

	vim.notify("There were issues reported with your startup file.", vim.log.levels.WARN)
	vim.notify("Failed to load module: " .. module, vim.log.levels.WARN)
end

-- Define the list of core modules
local core_modules = {
	"core.options",
	"core.lazy",
	"core.autocmds",
}

for _, module in ipairs(core_modules) do
	safe_require(module)
end
