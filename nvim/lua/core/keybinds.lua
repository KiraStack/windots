local builtin = require("telescope.builtin")
local opts = { noremap = true, silent = true }

-- Fuzzy searching and file navigation (use `f` prefix)
vim.keymap.set("n", "<leader>ff", builtin.find_files, vim.tbl_extend("force", opts, { desc = "Find files" }))
vim.keymap.set("n", "<leader>fg", builtin.live_grep, vim.tbl_extend("force", opts, { desc = "Search project with live grep" }))
vim.keymap.set("n", "<leader>fb", builtin.buffers, vim.tbl_extend("force", opts, { desc = "List open buffers" }))
vim.keymap.set("n", "<leader>fh", builtin.help_tags, vim.tbl_extend("force", opts, { desc = "Find help tags" }))

-- NvimTree file explorer commands (use `t` prefix)
vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle NvimTree" }))
vim.keymap.set("n", "<leader>tf", "<cmd>NvimTreeFindFileToggle<CR>", vim.tbl_extend("force", opts, { desc = "Find and toggle file in NvimTree" }))
vim.keymap.set("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", vim.tbl_extend("force", opts, { desc = "Refresh NvimTree" }))

-- LSP and navigation (use `g` prefix for LSP and navigation commands)
vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", vim.tbl_extend("force", opts, { desc = "Go to definition" }))
vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", vim.tbl_extend("force", opts, { desc = "Find references" }))
vim.keymap.set("n", "<leader>gn", "<cmd>lua vim.lsp.buf.rename()<CR>", vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

-- Formatting (use `g` prefix to remain consistent with LSP group)
vim.keymap.set("n", "<leader>gf", function()
    require("conform").format({ async = true, lsp_fallback = true })
end, vim.tbl_extend("force", opts, { desc = "Format document" }))
