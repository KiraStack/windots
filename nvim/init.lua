local core_modules = {
	"core.options",
	"core.lazy",
}

for _, module in ipairs(core_modules) do
	require(module)
end
