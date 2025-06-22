return {
    'lopi-py/luau-lsp.nvim',
    event = 'VeryLazy', -- Load after full startup
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        local luau_lsp = require('luau-lsp')

        local function rojo_project()
            return vim.fs.root(0, function(name)
                return name:match '.+%.project%.json$'
            end)
        end

        luau_lsp.setup({
            sourcemap = {
                enabled = true,
                autogenerate = true, -- automatic generation when the server is attached
                rojo_project_file = 'default.project.json',
                sourcemap_file = 'sourcemap.json'
            },
            platform = {
                type = rojo_project() and 'roblox' or 'standard'
            },
            types = {
                roblox_security_level = 'PluginSecurity'
            }
        })

        if rojo_project() then
            vim.filetype.add({
                extension = {
                    lua = function(path)
                        return path:match '%.nvim%.lua$' and 'lua' or 'luau'
                    end
                }
            })
        end
    end
}
