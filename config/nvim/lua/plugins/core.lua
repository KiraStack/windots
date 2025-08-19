return {
	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                                Core Plugins                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                                flash.nvim                                │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                              gitsigns.nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = false,
			signcolumn = true,
			numhl = false,
			linehl = false,
			watch_gitdir = { interval = 1000 },
			attach_to_untracked = true,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                            smear-cursor.nvim                             │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"sphamba/smear-cursor.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			min_horizontal_distance_smear = 2,
			min_vertical_distance_smear = 2,
			legacy_computing_symbols_support = true,
		},
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                            todo-comments.nvim                            │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"folke/todo-comments.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup()
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                            nvim-ts-autotag                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"windwp/nvim-ts-autotag",
		event = "BufReadPost",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               trouble.nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		opts = {
			modes = {
				lsp = {
					win = { position = "right" },
				},
			},
		},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
			{
				"<leader>cS",
				"<cmd>Trouble lsp toggle<cr>",
				desc = "LSP references/definitions/... (Trouble)",
			},
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
			{
				"[q",
				function()
					if require("trouble").is_open() then
						require("trouble").prev({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cprev)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Previous Trouble/Quickfix Item",
			},
			{
				"]q",
				function()
					if require("trouble").is_open() then
						require("trouble").next({ skip_groups = true, jump = true })
					else
						local ok, err = pcall(vim.cmd.cnext)
						if not ok then
							vim.notify(err, vim.log.levels.ERROR)
						end
					end
				end,
				desc = "Next Trouble/Quickfix Item",
			},
		},
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                             spellwarn.nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		-- 'ravibrock/spellwarn.nvim',
		-- event = 'VeryLazy',
		-- opts = {
		--     event = {
		--         'CursorHold',
		--         'InsertLeave',
		--         'TextChanged',
		--         'TextChangedI',
		--         'TextChangedP',
		--     },
		--     enable = true,
		--     ft_config = {
		--         alpha = false,
		--         help = false,
		--         lazy = false,
		--         lspinfo = false,
		--         mason = false,
		--     },
		--     ft_default = true,
		--     max_file_size = nil,
		--     severity = {
		--         spellbad = 'WARN',
		--         spellcap = 'HINT',
		--         spelllocal = 'HINT',
		--         spellrare = 'INFO',
		--     },
		--     prefix = 'possible misspelling(s): ',
		--     diagnostic_opts = { severity_sort = true },
		-- },
		-- config = function()
		--     vim.opt.spell = true
		--     vim.opt.spelllang = { 'en' }
		--     require('spellwarn').setup(opts)
		-- end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                           Formatting & Linting                           │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                              conform.nvim                                │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				h = { "clang-format" },
				hpp = { "clang-format" },
				glsl = { "clang-format" },
				css = { "prettierd" },
				go = { "gofmt" },
				html = { "prettierd" },
				java = { "google-java-format" },
				javascript = { "prettierd" },
				lua = { "selene" },
				python = { "ruff" },
				rust = { "rustfmt" },
				typescript = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		keys = {
			{
				"<leader>gf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				desc = "Format document",
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                           Navigation & UI                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                              snacks.nvim                                │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"folke/snacks.nvim",
		event = "VeryLazy",
		opts = {
			bigfile = { enabled = false },
			dashboard = { enabled = false },
			explorer = { enabled = true },
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false },
			notifier = { enabled = false },
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
		keys = {
			-- Pickers & Explorer
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart Find Files",
			},
			{
				"<leader>,",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>:",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>n",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Notification History",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},

			-- Find
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Find Git Files",
			},
			{
				"<leader>fp",
				function()
					Snacks.picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent()
				end,
				desc = "Recent",
			},

			-- Git
			{
				"<leader>gb",
				function()
					Snacks.picker.git_branches()
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					Snacks.picker.git_log()
				end,
				desc = "Git Log",
			},
			{
				"<leader>gL",
				function()
					Snacks.picker.git_log_line()
				end,
				desc = "Git Log Line",
			},
			{
				"<leader>gs",
				function()
					Snacks.picker.git_status()
				end,
				desc = "Git Status",
			},
			{
				"<leader>gS",
				function()
					Snacks.picker.git_stash()
				end,
				desc = "Git Stash",
			},
			{
				"<leader>gd",
				function()
					Snacks.picker.git_diff()
				end,
				desc = "Git Diff (Hunks)",
			},
			{
				"<leader>gf",
				function()
					Snacks.picker.git_log_file()
				end,
				desc = "Git Log File",
			},

			-- Search
			{
				"<leader>sb",
				function()
					Snacks.picker.lines()
				end,
				desc = "Buffer Lines",
			},
			{
				"<leader>sB",
				function()
					Snacks.picker.grep_buffers()
				end,
				desc = "Grep Open Buffers",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			{
				"<leader>s'",
				function()
					Snacks.picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>s/",
				function()
					Snacks.picker.search_history()
				end,
				desc = "Search History",
			},
			{
				"<leader>sa",
				function()
					Snacks.picker.autocmds()
				end,
				desc = "Autocmds",
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>sC",
				function()
					Snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sD",
				function()
					Snacks.picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sh",
				function()
					Snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function()
					Snacks.picker.highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>si",
				function()
					Snacks.picker.icons()
				end,
				desc = "Icons",
			},
			{
				"<leader>sj",
				function()
					Snacks.picker.jumps()
				end,
				desc = "Jumps",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sl",
				function()
					Snacks.picker.loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>sm",
				function()
					Snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sM",
				function()
					Snacks.picker.man()
				end,
				desc = "Man Pages",
			},
			{
				"<leader>sp",
				function()
					Snacks.picker.lazy()
				end,
				desc = "Search for Plugin Spec",
			},
			{
				"<leader>sq",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},
			{
				"<leader>sR",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>su",
				function()
					Snacks.picker.undo()
				end,
				desc = "Undo History",
			},
			{
				"<leader>uC",
				function()
					Snacks.picker.colorschemes()
				end,
				desc = "Colorschemes",
			},

			-- LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"gr",
				function()
					Snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gI",
				function()
					Snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					Snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sS",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},

			-- Other
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle Zen Mode",
			},
			{
				"<leader>Z",
				function()
					Snacks.zen.zoom()
				end,
				desc = "Toggle Zoom",
			},
			{
				"<leader>.",
				function()
					Snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					Snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>cR",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename File",
			},
			{
				"<leader>gB",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Git Browse",
				mode = { "n", "v" },
			},
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>un",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss All Notifications",
			},
			{
				"<c-/>",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{
				"<c-_>",
				function()
					Snacks.terminal()
				end,
				desc = "which_key_ignore",
			},
			{
				"]]",
				function()
					Snacks.words.jump(vim.v.count1)
				end,
				desc = "Next Reference",
				mode = { "n", "t" },
			},
			{
				"[[",
				function()
					Snacks.words.jump(-vim.v.count1)
				end,
				desc = "Prev Reference",
				mode = { "n", "t" },
			},
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd

					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})

			local snacks = require("snacks")
			snacks.setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                                 mini.nvim                                │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"echasnovski/mini.nvim",
		version = false,
		event = "VeryLazy",
		opts = {
			comment = {},
			move = {},
			pairs = {},
		},
		config = function(_, opts)
			for name, config in pairs(opts) do
				require("mini." .. name).setup(config)
			end
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                           Keymaps & Completions                          │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                             which-key.nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts_extend = { "spec" },
		opts = {
			preset = "helix",
			defaults = {},
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader><tab>", group = "tabs" },
					{ "<leader>c", group = "code" },
					{ "<leader>d", group = "debug" },
					{ "<leader>dp", group = "profiler" },
					{ "<leader>f", group = "file/find" },
					{ "<leader>g", group = "git" },
					{ "<leader>gh", group = "hunks" },
					{ "<leader>q", group = "quit/session" },
					{ "<leader>s", group = "search" },
					{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
					{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Keymaps (which-key)",
			},
		},
		config = function(_, opts)
			require("which-key").setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                              wilder.nvim                                 │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"gelguy/wilder.nvim",
		event = "VeryLazy",
		opts = {
			modes = { ":", "/", "?" },
		},
		config = function(_, opts)
			-- Load required modules
			local wilder = require("wilder")

			-- Define gradient
			local gradient = {
				"#f4468f",
				"#fd4a85",
				"#ff507a",
				"#ff566f",
				"#ff5e63",
				"#ff6658",
				"#ff704e",
				"#ff7a45",
				"#ff843d",
				"#ff9036",
				"#f89b31",
				"#efa72f",
				"#e6b32e",
				"#dcbe30",
				"#d2c934",
				"#c8d43a",
				"#bfde43",
				"#b6e84e",
				"#aff05b",
			}

			-- Iterate over gradient
			for idx, hex in ipairs(gradient) do
				-- Get highlight name and attributes
				local name = "WilderGradient" .. idx
				local attributes = {
					{ a = 1 },
					{ a = 1 },
					{ foreground = hex },
				}

				-- Make highlight
				gradient[idx] = wilder.make_hl(name, "Pmenu", attributes)
			end

			-- Popup menu renderer
			wilder.set_option(
				"renderer",
				wilder.popupmenu_renderer(
					wilder.popupmenu_border_theme({
						highlights = {
							border = "Normal",
							gradient = gradient,
						},
						highlighter = wilder.highlighter_with_gradient({
							wilder.basic_highlighter(),
						}),
						border = "rounded",
					}),
					{
						pumblend = 20,
						highlighter = wilder.basic_highlighter(),
					}
				)
			)

			-- Setup wilder
			wilder.setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                           LSP & Language Support                         │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               mason.nvim                                 │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason-lspconfig.nvim",
			"SmiteshP/nvim-navic",
		},
		opts = {
			-- Ensure the following language servers are installed
			servers = {
				"clangd",
				"cssls",
				"html",
				"jdtls",
				"ts_ls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
			},

			-- Automatically enable servers
			automatic_enable = {
				exclude = { "luau_lsp" }, -- Exclude Luau language server
			},

			-- The function to attach to the LSP client
			on_attach = function(client, bufnr)
				require("nvim-navic").attach(client, bufnr) -- Attach nvim-navic

				-- Define diagnostic icons
				local diagnostic_icons = {
					Error = "E", -- previous value: ''
					Warn = "W", -- previous value: ''
					Info = "I", -- previous value: ''
					Hint = "H", -- previous value: ''
				}

				-- Configure signs and virtual text for diagnostics
				for severity, icon in pairs(diagnostic_icons) do
					local highlight_group = "DiagnosticVirtualText" .. severity .. "Border"
					vim.fn.sign_define("DiagnosticSign" .. severity, {
						text = icon,
						texthl = highlight_group,
						numhl = highlight_group,
					})
				end
			end,
		},
		keys = {
			{ "<leader>df", vim.diagnostic.open_float, desc = "Show diagnostic in floating window" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Go to previous diagnostic message" },
			{ "]d", vim.diagnostic.goto_next, desc = "Go to next diagnostic message" },
		},
		config = function(_, opts)
			-- Load required modules
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup necessary plugins
			mason.setup()
			mason_lsp.setup({ ensure_installed = opts.servers, automatic_installation = true })

			-- Iterate over servers
			for _, server in ipairs(opts.servers) do
				lspconfig[server].setup({ on_attach = opts.on_attach, capabilities = default_capabilities }) -- Setup server
			end
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               mason.nvim                                 │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"lopi-py/luau-lsp.nvim",
		event = "VeryLazy",
		dependencies = {},
		opts = {
			platform = {
				type = "standard",
			},
			types = {
				roblox_security_level = "PluginSecurity",
			},
			sourcemap = {
				enabled = true,
				autogenerate = true, -- automatic generation when the server is initialized
				rojo_project_file = "default.project.json",
				sourcemap_file = "sourcemap.json",
			},
			fflags = {
				enable_new_solver = true, -- enables the fflags required for luau's new type solver
				sync = true, -- sync currently enabled fflags with roblox's published fflags
				override = { -- override fflags passed to luau
					LuauTableTypeMaximumStringifierLength = "100",
				},
			},
		},
		config = function(_, opts)
			-- Function to find the Rojo project file
			local function rojo_project()
				-- Match the Rojo project file pattern
				return vim.fs.root(0, function(name)
					return name:match(".+%.project%.json$")
				end)
			end

			-- Check for Rojo project
			if rojo_project() then
				-- Set type to roblox for Rojo projects
				opts.type = "roblox"

				-- Add filetype for Rojo projects
				vim.filetype.add({
					extension = {
						-- Match files depending on their location
						lua = function(path)
							return path:match("%.nvim%.lua$") and "lua" or "luau"
						end,
					},
				})
			end

			require("luau-lsp").setup(opts) -- Setup plugin with options
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                              renamer.nvim                                │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"filipdutescu/renamer.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<F2>", "<cmd>lua require('renamer').rename()<cr>", mode = "i", desc = "Rename in insert mode" },
			{ "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", mode = "n", desc = "Rename in normal mode" },
			{ "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", mode = "v", desc = "Rename in visual mode" },
		},
		config = function()
			require("renamer").setup()
		end,
	},
}
