local utils = require("../_lsp.utils")
local servers = {
  "bashls",
  "biome",
  "eslint",
  "gopls",
  "jsonls",
  "lua_ls",
  "tailwindcss",
  "taplo",
  "ts_ls",
}
local ensure_intalled = vim.list_extend({
  "prettier",
  "prettierd",
  "stylua",
}, servers)

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
            utils.lsp_keymaps(bufnr)

            if server == "ts_ls" then
              client.server_capabilities.documentFormattingProvider = false
            end

            if client.supports_method("textDocument/inlayHint") then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
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
      { "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },
    },
  },
  { "mfussenegger/nvim-jdtls" },
  { -- Autoformat
    "stevearc/conform.nvim",
    config = function()
      local conform = require("conform")
      local opts = { noremap = true, silent = true }

      conform.setup({
        notify_on_error = false,
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "biome" },
          javascriptreact = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },
        },
      })

      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ lsp_fallback = "always", timeout_ms = 2000 })
      end, opts)
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
