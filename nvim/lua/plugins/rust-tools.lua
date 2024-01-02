local opts = { noremap = true, silent = true }

return {
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local rust_tools = require("rust-tools")

			rust_tools.setup({
				server = {
					on_attach = function(_, bufnr)
						-- hover actions
						vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })

						-- code action groups
						vim.keymap.set(
							"n",
							"<leader> a",
							rust_tools.code_action_group.code_action_group,
							{ buffer = bufnr }
						)

						vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"<C-k>",
							"<cmd>lua vim.lsp.buf.signature_help()<CR>",
							opts
						)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
						vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"<leader>ca",
							"<cmd>lua vim.lsp.buf.code_action()<CR>",
							opts
						)
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"[d",
							"<cmd>lua vim.diagnostic.goto_prev({ border = 'rounded' })<CR>",
							opts
						)
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"gl",
							"<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<CR>",
							opts
						)
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"]d",
							"<cmd>lua vim.diagnostic.goto_next({ border = 'rounded' })<CR>",
							opts
						)
						vim.api.nvim_buf_set_keymap(
							bufnr,
							"n",
							"<leader>q",
							"<cmd>lua vim.diagnostic.setloclist()<CR>",
							opts
						)
					end,
				},
			})
		end,
	},
	"rust-lang/rust.vim",
}
