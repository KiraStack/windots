local modules = {
	"core.options",
	"core.lazy",
	"core.keybinds"
}

for _, module in ipairs(modules) do
	require(module)
end
