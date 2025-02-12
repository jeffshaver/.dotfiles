return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- there is a bug in files that are too big that makes this error a lot
    --[[ require("codeium").setup({}) ]]
  end,
}
