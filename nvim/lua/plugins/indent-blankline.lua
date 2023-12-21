return {
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('ibl').setup({
        indent = {
          tab_char = ''
        }
      })
    end,
    main = 'ibl',
  }
}
