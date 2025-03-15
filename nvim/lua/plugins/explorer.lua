return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		cmd = "Telescope", -- Load only when the Telescope command is run
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})

			-- basic telescope configuration
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set("n", "<leader>hf", function()
				toggle_telescope(harpoon:list())
			end, { desc = "Open harpoon window" })
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		event = "BufReadPost", -- Load when a buffer is read
		dependencies = {
		  "nvim-lua/plenary.nvim",
		  "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
		  "MunifTanjim/nui.nvim",
		  -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	},
	{
		"Bekaboo/dropbar.nvim",
		event = "BufReadPost", -- Load when a buffer is read
		-- optional, but required for fuzzy finder support
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	{
		"ThePrimeagen/harpoon",
		cmd = "Harpoon", -- Load only when the Telescope command is run
		branch = "harpoon2",
	},
}
