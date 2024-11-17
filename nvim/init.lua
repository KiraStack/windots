local function safe_require(module)
	local success = pcall(require, module)
	if not success then
		vim.api.nvim_err_writeln("Failed to load module: " .. module)
	end
end

-- Define and load core modules in a single call for minimal overhead
local core_modules = {
	"core.options",
	"core.lazy",
}

for _, module in ipairs(core_modules) do
	safe_require(module)
end
