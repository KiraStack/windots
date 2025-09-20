return {
	name = "Build C++ file",
	builder = function(params)
		return {
			cmd = { "g++", vim.fn.expand("%"), "-o", "a.out" },
			components = { "default" },
		}
	end,
}
