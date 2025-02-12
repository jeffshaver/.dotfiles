return {
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "nvim-tree/nvim-web-devicons",
  "mbbill/undotree",
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  "vim-scripts/BufOnly.vim",
  "windwp/nvim-spectre",
  "ThePrimeagen/vim-be-good",
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("barbecue").setup({
        create_autocmd = false,
        show_modified = true,
      })

      vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",
      }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
          require("barbecue.ui").update()
        end,
      })
    end,
  },
  -- was needed with ghostty
  --[[ { ]]
  --[[   "xiyaowong/transparent.nvim", ]]
  --[[   config = function() ]]
  --[[     require("transparent").setup({ ]]
  --[[       exclude_groups = { ]]
  --[[         "CursorLine" ]]
  --[[       } ]]
  --[[     }) ]]
  --[[]]
  --[[     vim.cmd(":TransparentEnable") ]]
  --[[   end, ]]
  --[[ }, ]]
}
