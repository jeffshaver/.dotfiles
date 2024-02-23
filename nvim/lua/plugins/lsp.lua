local servers = {
	"bashls",
	"gopls",
	"jdtls",
	"jsonls",
	"lua_ls",
	"tailwindcss",
	"taplo",
	"tsserver",
}
local ensure_intalled = vim.list_extend({
	"eslint_d",
	"prettier",
	"prettierd",
	"stylua",
}, servers)
local function lsp_keymaps(bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("i", "<C-l>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "󰋽" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
	silent = true,
	width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
	silent = true,
	width = 60,
})

return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			for _, server in pairs(servers) do
				local opts = {
					on_attach = function(client, bufnr)
						lsp_keymaps(bufnr)

						if server == "tsserver" then
							client.server_capabilities.documentFormattingProvider = false
						end

						if client.supports_method("textDocument/inlayHint") then
							vim.lsp.inlay_hint.enable(bufnr, true)
						end
					end,

					capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities),
				}
				local has_custom_opts, server_custom_opts = pcall(require, "../_lsp.settings." .. server)

				if has_custom_opts then
					opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
				end

				require("mason").setup()
				require("mason-tool-installer").setup({ ensure_installed = ensure_intalled })
				require("mason-lspconfig").setup()
				require("lspconfig")[server].setup(opts)
			end
		end,
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local none_ls = require("null-ls")
			local formatting = none_ls.builtins.formatting
			local diagnostics = none_ls.builtins.diagnostics
			local code_actions = none_ls.builtins.code_actions

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			none_ls.setup({
				debug = false,
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
				sources = {
					code_actions.eslint_d,
					diagnostics.eslint_d,
					formatting.eslint_d,
					formatting.prettierd,
					formatting.stylua,
				},
			})
		end,
	},
	"davidosomething/format-ts-errors.nvim",
	{
		"fatih/vim-go",
		ft = { "go" },
		init = function()
			vim.g.go_def_mapping_enabled = 0
		end,
	},
}
