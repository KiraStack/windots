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