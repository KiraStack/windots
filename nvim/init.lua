local core_modules = {
	"core.options",
	"core.lazy",
	"core.keybinds"
}

for _, module in ipairs(core_modules) do
	require(module)
end
