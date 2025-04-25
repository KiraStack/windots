-- Settings
local path = vim.fn.stdpath("config") .. "/lua/core"  -- Use forward slashes for cross-platform compatibility

-- Variables
local files = {}
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

vim.cmd("silent! lua vim.deprecated.health.check()") -- Suppress deprecation warnings check

if is_windows then
    local cmd = 'dir \"' .. path .. '\" /b /a-d 2>nul'
    for file in io.popen(cmd):lines() do
        table.insert(files, file)
    end
else
    local cmd = 'ls \"' .. path .. '\"'
    for file in io.popen(cmd):lines() do
        table.insert(files, file)
    end
end



for i, file in ipairs(files) do
    if file:match("%.lua$") then
        local mod = "core." .. file:gsub("%.lua$", "")
        local success, err = pcall(require, mod)
		
        if not success then
            print("Error loading module: " .. mod .. " (" .. err .. ")")
        end
    end
end