return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["<C-p>"] = false,
        },
        view_options = {
          show_hidden = true,
        },
      })

      vim.keymap.set("n", "t", require('oil').toggle_float)
    end,
  },
}
