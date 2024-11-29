local opts = { noremap = true, silent = true }

-- Helper function to set keymaps
local function map(key, action, desc)
  vim.keymap.set("n", key, action, vim.tbl_extend("force", opts, { desc = desc }))
end

-- Fuzzy searching and file navigation (use `f` prefix)
map("<leader>ff", ":Telescope find_files<CR>", "Find files")
map("<leader>fg", ":Telescope live_grep<CR>", "Search project with live grep")
map("<leader>fb", ":Telescope buffers<CR>", "List open buffers")
map("<leader>fh", ":Telescope help_tags<CR>", "Find help tags")

-- NvimTree file explorer commands (use `t` prefix)
map("<leader>tt", "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree")
map("<leader>tf", "<cmd>NvimTreeFindFileToggle<CR>", "Find and toggle file in NvimTree")
map("<leader>tr", "<cmd>NvimTreeRefresh<CR>", "Refresh NvimTree")

-- LSP and navigation (use `g` prefix for LSP and navigation commands)
map("<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
map("<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", "Find references")
map("<leader>gn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol")

-- Formatting (use `g` prefix to remain consistent with LSP group)
map("<leader>gf", function() require("conform").format({ async = true, lsp_fallback = true }) end, "Format document")

-- Initialize Harpoon
local harpoon = require("harpoon")
harpoon.setup()

-- Harpoon key mappings (use `h` prefix)
-- Harpoon file management commands
map("<leader>ha", function() require("harpoon.mark").add_file() end, "Add current file to Harpoon")
map("<leader>hl", function() require("harpoon.mark").clear_all() end, "Clear all Harpoon files")
-- Harpoon navigation commands
map("<leader>hn", function() require("harpoon.ui").toggle_quick_menu() end, "Toggle Harpoon quick menu")
map("<leader>h1", function() require("harpoon.ui").nav_file(1) end, "Go to Harpoon file 1")
map("<leader>h2", function() require("harpoon.ui").nav_file(2) end, "Go to Harpoon file 2")
map("<leader>h3", function() require("harpoon.ui").nav_file(3) end, "Go to Harpoon file 3")
map("<leader>h4", function() require("harpoon.ui").nav_file(4) end, "Go to Harpoon file 4")
-- Toggle previous & next buffers stored within Harpoon list
map("<C-S-P>", function() harpoon:list():prev() end)
map("<C-S-N>", function() harpoon:list():next() end)
