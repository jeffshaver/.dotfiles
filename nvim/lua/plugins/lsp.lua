local servers = { "gopls", "jdtls", "jsonls", "lua_ls", "tsserver", "taplo", "tailwindcss" }
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "i", "<C-l>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "gl",
    '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format{async=true}' ]])
end

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  -- disable virtual text
  virtual_text = false,
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
  width = 60,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
  width = 60,
})

return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = servers
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      for _, server in pairs(servers) do
        local opts = {
          on_attach = function(client, bufnr)
            if client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end

            lsp_keymaps(bufnr)

            require('illuminate').on_attach(client)
            require('lsp-inlayhints').on_attach(client, bufnr)
          end,

          capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities),
        }
        local has_custom_opts, server_custom_opts = pcall(require, "../_lsp.settings." .. server)

        if has_custom_opts then
          opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
        end

        require('lspconfig')[server].setup(opts)
      end
    end
  },
  {
    'nvimtools/none-ls.nvim',
    config = function()
      local none_ls = require('null-ls')
      local formatting = none_ls.builtins.formatting
      local diagnostics = none_ls.builtins.diagnostics
      local code_actions = none_ls.builtins.code_actions

      local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

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
          code_actions.eslint,
          diagnostics.eslint_d,
          formatting.eslint_d,
          formatting.prettierd,
        },
      })
    end
  },
  {
    'lvimuser/lsp-inlayhints.nvim',
    config = function()
      -- need to make a group up front
      vim.api.nvim_create_augroup('LspAttach_inlayhints', {})

      vim.api.nvim_create_autocmd('LspAttach', {
        group = 'LspAttach_inlayhints',
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('lsp-inlayhints').on_attach(client, args.buf)
        end,
      })

      require('lsp-inlayhints').setup {
        inlay_hints = {
          parameter_hints = {
            show = false,
            -- prefix = '<- ',
            separator = ', ',
          },
          type_hints = {
            -- type and other hints
            show = true,
            prefix = '',
            separator = ', ',
            remove_colon_end = false,
            remove_colon_start = false,
          },
          -- separator between types and parameter hints. Note that type hints are
          -- shown before parameter
          labels_separator = '  ',
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 7,
          -- highlight group
          highlight = 'Comment',
        },
        debug_mode = false,
      }
    end
  },
  'davidosomething/format-ts-errors.nvim',
  {
    'fatih/vim-go',
    ft = { 'go' },
    init = function()
      vim.g.go_def_mapping_enabled = 0
    end
  },

  {
    'piersolenski/wtf.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim'
    },
    opts = {},
    keys = {
      {
        'gw',
        mode = {'n', 'x'},
        function()
          require('wtf').ai()
        end,
        desc = 'Debug diagnostic with AI'
      }
    },
  },
}
