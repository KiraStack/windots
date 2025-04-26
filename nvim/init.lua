-- Settings
local path = vim.fn.stdpath('config') .. '/lua/core'

-- Check if directory exists
if vim.fn.isdirectory(path) ~= 1 then
	print('Directory does not exist: ' .. path)
	return
end

-- Get all Lua files in the directory
local files = vim.fn.glob(path .. '/*.lua', false, true)

-- Require each module
for _, file_path in ipairs(files) do
	local file = vim.fn.fnamemodify(file_path, ':t')  -- Get just the filename
	if file:match('%.lua$') then
		local mod = 'core.' .. file:gsub('%.lua$', '')
		local success, err = pcall(require, mod)
    
		if not success then
		print('Error loading module: ' .. mod .. ' (' .. err .. ')')
		end
	end
end