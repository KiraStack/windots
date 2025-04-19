return {
	{
		"stevearc/overseer.nvim",
		-- event = "VeryLazy", -- Load after full startup
		cmd = {"OverseerRun", "OverseerToggle"},
		keys = {
			{ "<leader>or", ":OverseerRun<CR>", desc = "Run Overseer Task" },
			{ "<leader>ot", ":OverseerToggle<CR>", desc = "Toggle Overseer Task List" },
		},
		config = function()
			require('overseer').setup()
		end,
	},
	{
		"filipdutescu/renamer.nvim",
		dependencies = {"nvim-lua/plenary.nvim"},
		event = "BufReadPost", -- Load when a buffer is read
		keys = {
			{"<F2>", "<cmd>lua require('renamer').rename()<cr>", mode = "i", desc = "Rename in insert mode"},
			{"<leader>rn", "<cmd>lua require('renamer').rename()<cr>", mode = "n", desc = "Rename in normal mode"},
			{"<leader>rn", "<cmd>lua require('renamer').rename()<cr>", mode = "v", desc = "Rename in visual mode"},
		},
		config = function()
			require('renamer').setup()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "BufReadPost", -- Load when a buffer is read
		config = function()
			require('nvim-ts-autotag').setup()
		end,
	},
    {
        "folke/snacks.nvim",
		lazy = false,
        opts = {
            dim = {enabled = true},
            dashboard = {enabled = true},
            explorer = {enabled = true},
            indent = {enabled = true},
            input = {enabled = true},
            picker = {enabled = true},
            notifier = {enabled = true},
            quickfile = {enabled = true},
            scope = {enabled = true},
            scroll = {enabled = true},
            statuscolumn = {enabled = true},
            words = {enabled = true}
        },
        keys = {
            -- Top Pickers & Explorer
            {"<leader><space>", function()
                    Snacks.picker.smart()
                end, desc = "Smart Find Files"},
            {"<leader>,", function()
                    Snacks.picker.buffers()
                end, desc = "Buffers"},
            {"<leader>/", function()
                    Snacks.picker.grep()
                end, desc = "Grep"},
            {"<leader>:", function()
                    Snacks.picker.command_history()
                end, desc = "Command History"},
            {"<leader>n", function()
                    Snacks.picker.notifications()
                end, desc = "Notification History"},
            {"<leader>e", function()
                    Snacks.explorer()
                end, desc = "File Explorer"},
            -- find
            {"<leader>fb", function()
                    Snacks.picker.buffers()
                end, desc = "Buffers"},
            {"<leader>fc", function()
                    Snacks.picker.files({cwd = vim.fn.stdpath("config")})
                end, desc = "Find Config File"},
            {"<leader>ff", function()
                    Snacks.picker.files()
                end, desc = "Find Files"},
            {"<leader>fg", function()
                    Snacks.picker.git_files()
                end, desc = "Find Git Files"},
            {"<leader>fp", function()
                    Snacks.picker.projects()
                end, desc = "Projects"},
            {"<leader>fr", function()
                    Snacks.picker.recent()
                end, desc = "Recent"},
            -- git
            {"<leader>gb", function()
                    Snacks.picker.git_branches()
                end, desc = "Git Branches"},
            {"<leader>gl", function()
                    Snacks.picker.git_log()
                end, desc = "Git Log"},
            {"<leader>gL", function()
                    Snacks.picker.git_log_line()
                end, desc = "Git Log Line"},
            {"<leader>gs", function()
                    Snacks.picker.git_status()
                end, desc = "Git Status"},
            {"<leader>gS", function()
                    Snacks.picker.git_stash()
                end, desc = "Git Stash"},
            {"<leader>gd", function()
                    Snacks.picker.git_diff()
                end, desc = "Git Diff (Hunks)"},
            {"<leader>gf", function()
                    Snacks.picker.git_log_file()
                end, desc = "Git Log File"},
            -- Grep
            {"<leader>sb", function()
                    Snacks.picker.lines()
                end, desc = "Buffer Lines"},
            {"<leader>sB", function()
                    Snacks.picker.grep_buffers()
                end, desc = "Grep Open Buffers"},
            {"<leader>sg", function()
                    Snacks.picker.grep()
                end, desc = "Grep"},
            {"<leader>sw", function()
                    Snacks.picker.grep_word()
                end, desc = "Visual selection or word", mode = {"n", "x"}},
            -- search
            {"<leader>s\"", function()
                    Snacks.picker.registers()
                end, desc = "Registers"},
            {"<leader>s/", function()
                    Snacks.picker.search_history()
                end, desc = "Search History"},
            {"<leader>sa", function()
                    Snacks.picker.autocmds()
                end, desc = "Autocmds"},
            {"<leader>sb", function()
                    Snacks.picker.lines()
                end, desc = "Buffer Lines"},
            {"<leader>sc", function()
                    Snacks.picker.command_history()
                end, desc = "Command History"},
            {"<leader>sC", function()
                    Snacks.picker.commands()
                end, desc = "Commands"},
            {"<leader>sd", function()
                    Snacks.picker.diagnostics()
                end, desc = "Diagnostics"},
            {"<leader>sD", function()
                    Snacks.picker.diagnostics_buffer()
                end, desc = "Buffer Diagnostics"},
            {"<leader>sh", function()
                    Snacks.picker.help()
                end, desc = "Help Pages"},
            {"<leader>sH", function()
                    Snacks.picker.highlights()
                end, desc = "Highlights"},
            {"<leader>si", function()
                    Snacks.picker.icons()
                end, desc = "Icons"},
            {"<leader>sj", function()
                    Snacks.picker.jumps()
                end, desc = "Jumps"},
            {"<leader>sk", function()
                    Snacks.picker.keymaps()
                end, desc = "Keymaps"},
            {"<leader>sl", function()
                    Snacks.picker.loclist()
                end, desc = "Location List"},
            {"<leader>sm", function()
                    Snacks.picker.marks()
                end, desc = "Marks"},
            {"<leader>sM", function()
                    Snacks.picker.man()
                end, desc = "Man Pages"},
            {"<leader>sp", function()
                    Snacks.picker.lazy()
                end, desc = "Search for Plugin Spec"},
            {"<leader>sq", function()
                    Snacks.picker.qflist()
                end, desc = "Quickfix List"},
            {"<leader>sR", function()
                    Snacks.picker.resume()
                end, desc = "Resume"},
            {"<leader>su", function()
                    Snacks.picker.undo()
                end, desc = "Undo History"},
            {"<leader>uC", function()
                    Snacks.picker.colorschemes()
                end, desc = "Colorschemes"},
            -- LSP
            {"gd", function()
                    Snacks.picker.lsp_definitions()
                end, desc = "Go to Definition"},
            {"gD", function()
                    Snacks.picker.lsp_declarations()
                end, desc = "Go to Declaration"},
            {"gr", function()
                    Snacks.picker.lsp_references()
                end, nowait = true, desc = "References"},
            {"gI", function()
                    Snacks.picker.lsp_implementations()
                end, desc = "Goto Implementation"},
            {"gy", function()
                    Snacks.picker.lsp_type_definitions()
                end, desc = "Goto T[y]pe Definition"},
            {"<leader>ss", function()
                    Snacks.picker.lsp_symbols()
                end, desc = "LSP Symbols"},
            {"<leader>sS", function()
                    Snacks.picker.lsp_workspace_symbols()
                end, desc = "LSP Workspace Symbols"},
            -- Other
            {"<leader>z", function()
                    Snacks.zen()
                end, desc = "Toggle Zen Mode"},
            {"<leader>Z", function()
                    Snacks.zen.zoom()
                end, desc = "Toggle Zoom"},
            {"<leader>.", function()
                    Snacks.scratch()
                end, desc = "Toggle Scratch Buffer"},
            {"<leader>S", function()
                    Snacks.scratch.select()
                end, desc = "Select Scratch Buffer"},
            {"<leader>n", function()
                    Snacks.notifier.show_history()
                end, desc = "Notification History"},
            {"<leader>bd", function()
                    Snacks.bufdelete()
                end, desc = "Delete Buffer"},
            {"<leader>cR", function()
                    Snacks.rename.rename_file()
                end, desc = "Rename File"},
            {"<leader>gB", function()
                    Snacks.gitbrowse()
                end, desc = "Git Browse", mode = {"n", "v"}},
            {"<leader>gg", function()
                    Snacks.lazygit()
                end, desc = "Lazygit"},
            {"<leader>un", function()
                    Snacks.notifier.hide()
                end, desc = "Dismiss All Notifications"},
            {"<c-/>", function()
                    Snacks.terminal()
                end, desc = "Toggle Terminal"},
            {"<c-_>", function()
                    Snacks.terminal()
                end, desc = "which_key_ignore"},
            {"]]", function()
                    Snacks.words.jump(vim.v.count1)
                end, desc = "Next Reference", mode = {"n", "t"}},
            {"[[", function()
                    Snacks.words.jump(-vim.v.count1)
                end, desc = "Prev Reference", mode = {"n", "t"}},
            {
                "<leader>N",
                function()
                    Snacks.win(
                        {
                            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                            width = 0.6,
                            height = 0.6,
                            wo = {
                                spell = false,
                                wrap = false,
                                signcolumn = "yes",
                                statuscolumn = " ",
                                conceallevel = 3
                            }
                        }
                    )
                end,
                desc = "Neovim News"
            }
        }
    },
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy", -- Load after full startup
		opts = {
			modules = {
				["comment"] = {},
				["move"] = {},
				["pairs"] = {},
				-- Disabled by omission:
				-- ["ai"] = {},
				-- ["align"] = {},
				-- ["completion"] = {},
				-- ["operators"] = {},
				-- ["snippets"] = {},
				-- ["splitjoin"] = {},
				-- ["surround"] = {},
				-- ["basics"] = {},
				-- ["bracketed"] = {},
				-- ["bufremove"] = {},
				-- ["clue"] = {},
				-- ["deps"] = {},
				-- ["diff"] = {},
				-- ["extra"] = {},
				-- ["files"] = {},
				-- ["git"] = {},
				-- ["jump"] = {},
				-- ["jump2d"] = {},
				-- ["misc"] = {},
				-- ["pick"] = {},
				-- ["sessions"] = {},
				-- ["visits"] = {},
				-- ["animate"] = {},
				-- ["base16"] = {},
				-- ["colors"] = {},
				-- ["cursorword"] = {},
				-- ["hipatterns"] = {},
				-- ["hues"] = {},
				-- ["icons"] = {},
				-- ["indentscope"] = {},
				-- ["map"] = {},
				-- ["notify"] = {},
				-- ["starter"] = {},
				-- ["statusline"] = {},
				-- ["tabline"] = {},
				-- ["trailspace"] = {},
				-- ["doc"] = {},
				-- ["fuzzy"] = {},
				-- ["test"] = {},
			},
		},
		config = function(_, opts)
			for name, config in pairs(opts.modules) do
				require("mini." .. name).setup(config)
			end
		end,
	},
	{
		"andweeb/presence.nvim",
		event = "VeryLazy", -- Load after full startup
		config = function()
			require("presence"):setup({
				neovim_image_text = "The One True Text Editor",
				main_image = "file",
				editing_text = "Editing %s",
				file_explorer_text = "Browsing %s",
				git_commit_text = "Committing changes",
				plugin_manager_text = "Managing plugins",
				lsp_client_text = "Configuring LSP",
				reading_text = "Reading %s",
				workspace_text = "Working on %s",
				line_number_text = "Line %s out of %s",
			})
		end,
	}
}
