return {
	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                              Dashboard & UI                              │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                             dashboard-nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			theme = "hyper",
			config = {
				week_header = { enable = true },
				project = { enable = false },
				mru = { enable = false },
				footer = {},
			},
		},
		config = function(_, opts)
		    -- Check if center is enabled
		    if not vim.tbl_get(opts, "config", "center") then
                return
            end

            -- Highlight the dashboard header
			vim.cmd("highlight DashboardHeader guifg=#ffffff")

			-- Define shortcuts
			opts.config.shortcut = {
				{
					icon = "󰒲  ",
					icon_hl = "Boolean",
					desc = "Update ",
					group = "Directory",
					action = "Lazy update",
					key = "u",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Files ",
					group = "Statement",
					action = Snacks.picker.files,
					key = "f",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Recent ",
					group = "String",
					action = Snacks.picker.recent,
					key = "r",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Grep ",
					group = "ErrorMsg",
					action = Snacks.picker.grep,
					key = "g",
				},
				{
					icon = "   ",
					icon_hl = "Boolean",
					desc = "Quit ",
					group = "WarningMsg",
					action = "qall!",
					key = "q",
				},
			}

			-- Define projects
			local projects = {
                action = "lua Snacks.picker.projects()",
                desc = " Projects",
                icon = " ",
                key = "p",
            }

            -- Set key format
            projects.desc = projects.desc .. string.rep(" ", 43 - #projects.desc)
            projects.key_format = "  %s"

             -- Add projects to center section
            table.insert(opts.config.center, 3, projects)

            -- Load required module
			require("dashboard").setup(opts)
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                                UI & Themes                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                             	theme.nvim                                │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"scottmckendry/cyberdream.nvim",
		name = "cyberdream",
		lazy = false,
		priority = 1000,
		opts = {
			variant = "auto",
			transparent = true,
			italic_comments = true,
			hide_fillchars = true,
			borderless_pickers = true,
			cache = true,
		},
		config = function(_, opts)
		    -- Load required module
			require("cyberdream").setup(opts)

			-- Set colorscheme
			vim.cmd.colorscheme("cyberdream")
		end,
	},

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               themery.nvim                               │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	-- {
	-- 	"zaldih/themery.nvim",
	-- 	cmd = "Themery",
	-- 	keys = {
	-- 		{ "<leader>ct", ":Themery<CR>", "Toggle theme" },
	-- 	},
	-- 	opts = {
	-- 		themes = {
	-- 			{
	-- 				name = "cyberdream",
	-- 				colorscheme = "cyberdream",
	-- 			},
	-- 		},
	-- 		livePreview = true,
	-- 	},
	-- 	config = function(_, opts)
	-- 	    -- Load required module
	-- 		require("themery").setup(opts)
	-- 	end,
	-- },

	-- ╭──────────────────────────────────────────────────────────────────────────╮
	-- │                               nvim-cokeline.nvim                         │
	-- ╰──────────────────────────────────────────────────────────────────────────╯
	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for v0.4.0+
			"nvim-tree/nvim-web-devicons",
			"stevearc/resession.nvim",
		},
		config = function(_, opts)
			-- Function to get hex color
			local function get_hex(group, attr)
				return require("cokeline.hlgroups").get_hl_attr(group, attr)
			end

			-- Load required module
			require("cokeline").setup({
				default_hl = {
                    fg = function(buffer)
                    return
                        buffer.is_focused
                        and get_hex('ColorColumn', 'bg')
                        or get_hex('Normal', 'fg')
                    end,
                    bg = function(buffer)
                    return
                        buffer.is_focused
                        and get_hex('Normal', 'fg')
                        or get_hex('ColorColumn', 'bg')
                    end,
				},
				components = {
					{
						text = function(buffer) return ' ' .. buffer.devicon.icon end,
						fg = function(buffer) return buffer.devicon.color end,
					},
					{
						text = function(buffer) return buffer.unique_prefix end,
						fg = get_hex('Comment', 'fg'),
						italic = true
					},
					{
						text = function(buffer) return buffer.filename .. ' ' end,
						underline = function(buffer)
							return buffer.is_hovered and not buffer.is_focused
						end
					},
					{
						text = "󰖭",
						on_click = function(_, _, _, _, buffer)
							buffer:delete()
						end,
					},
					{
						text = "  ",
					},
				},
			})

			-- Persist focus
			require("cokeline.history"):last():focus()
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
}
