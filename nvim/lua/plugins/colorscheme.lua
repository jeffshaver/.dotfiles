return {
  {
    'EdenEast/nightfox.nvim',
    config = function()
      vim.cmd [[
        try
          colorscheme nightfox
          set background=dark
        catch /^Vim\%((\a\+)\)\=:E185/
          colorscheme default
          set background=dark
        endtry
      ]]
    end
  }
}
