return {
	"nvimtools/none-ls.nvim",
	event = "BufReadPost",  -- Load after the buffer is completely read
	dependencies = { "nvimtools/none-ls-extras.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local builtin = null_ls.builtins

		-- Configure null-ls with formatting and diagnostic sources
		null_ls.setup({
			sources = {
				-- Formatters
				builtin.formatting.stylua,
				builtin.formatting.black,
				builtin.formatting.isort,

				builtin.formatting.prettier.with({
					filetypes = { "html", "json", "yaml", "markdown" },
					extra_filetypes = { "toml" },
				}),

				-- Linters/Diagnostics
				require("none-ls.diagnostics.ruff"),
				require("none-ls.diagnostics.eslint"),
			},
			on_attach = function(client, bufnr)
				-- Enable formatting on save and provide a command for manual formatting
				if client.supports_method("textDocument/formatting") then
					-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
					-- 	vim.lsp.buf.format({ bufnr = bufnr })
					-- end, { desc = "Format the current buffer with LSP" })

					-- Key mapping for manual formatting
					vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>gf", "<cmd>Format<CR>", { noremap = true, silent = true })
				end
			end,
		})

		-- Configure diagnostics appearance
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false, -- Disable inline text
			signs = true, -- Enable signs in the gutter
			update_in_insert = false, -- No updates during insert mode
			underline = true, -- Underline diagnostics
		})

		-- Configure floating window for diagnostics
		vim.diagnostic.config({
			float = {
				source = "always", -- Always show the source in the floating window
				border = "rounded", -- Rounded borders for the floating window
			},
		})
	end,
}
