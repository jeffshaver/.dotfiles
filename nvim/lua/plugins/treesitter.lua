return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = {
          enable = true, -- false will disable the whole extension
        },
        indent = { enable = true },
      })
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context" },
}
