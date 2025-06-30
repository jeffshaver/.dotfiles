return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        columns = { "icon" },
        keymaps = {
          ["t"] = false,
          ["<C-p>"] = false,
        },
        view_options = {
          show_hidden = true,
        },
      })

      vim.keymap.set("n", "<leader>t", function()
        require("oil").toggle_float(require("oil").get_current_dir())
      end)
    end,
  },
}
