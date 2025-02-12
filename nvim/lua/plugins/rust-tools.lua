return {
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local rust_tools = require("rust-tools")

			rust_tools.setup({
				server = {
					on_attach = function(_, bufnr)
						local opts = { buffer = bufnr, noremap = true, silent = true }

						-- hover actions
						vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })

						-- code action groups
						vim.keymap.set("n", "<leader> a", rust_tools.code_action_group.code_action_group, opts)

						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
						vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
						vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
						vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
						vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
						vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
						vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
						vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
						vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
					end,
				},
			})
		end,
	},
	"rust-lang/rust.vim",
}
