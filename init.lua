vim.g.mapleader = " "
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.guicursor =  ""
vim.opt.hidden = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars='tab:▸ ,trail:·'
vim.opt.backup = false
vim.opt.errorbells = false
vim.opt.hlsearch = false
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.redrawtime = 10000
vim.opt.relativenumber = true
vim.opt.scrolloff = 16
vim.opt.shiftwidth = 256
vim.opt.showmatch = true
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.termguicolors = true
vim.opt.undodir = "~/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wrap = false

vim.cmd [[ syntax on ]]

vim.keymap.set('n', '<C-p>', [[<cmd> lua require('telescope.builtin').find_files()<cr>]])
vim.keymap.set('n', '<leader>fg', [[<cmd> lua require('telescope.builtin').live_grep()<cr>]])
vim.keymap.set('n', '<leader>fb', [[<cmd> lua require('telescope.builtin').buffers()<cr>]])
vim.keymap.set('n', '<leader>fh', [[<cmd> lua require('telescope.builtin').help_tags()<cr>]])
vim.keymap.set('n', '<C-h>', [[<cmd> lua require('harpoon.ui').toggle_quick_menu()<cr>]])
vim.keymap.set('n', '<C-n>', [[<cmd> lua require('harpoon.mark').add_file()<cr>]])
vim.keymap.set('n', '<C-j>', [[<cmd> lua require('harpoon.ui').nav_file(1)<cr>]])
vim.keymap.set('n', '<C-k>', [[<cmd> lua require('harpoon.ui').nav_file(2)<cr>]])
vim.keymap.set('n', '<C-l>', [[<cmd> lua require('harpoon.ui').nav_file(3)<cr>]])
vim.keymap.set('n', '<C-;>', [[<cmd> lua require('harpoon.ui').nav_file(4)<cr>]])
vim.keymap.set('n', '<C-J><C-J>', ':w<cr>')
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<cr>')
vim.keymap.set('i', 'kj', '<esc>')
vim.keymap.set('n', '<C-a>', 'C-^')

vim.cmd [[
  " CoC
  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <c-space> coc#refresh()

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Make <Esc> close auto completion menu if open
  inoremap <silent><expr> <Esc> pumvisible() ? "\<C-y>": "\<Esc>"

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> gn <Plug>(coc-diagnostic-next)
  nmap <silent> gp <Plug>(coc-diagnostic-previous)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  nnoremap <leader>bo :BufOnly<CR>

  " NERDTree
  nnoremap <expr> <leader>nt g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NERDTree<CR>' : ':NERDTreeFind<CR>'

  " Spectre
  nnoremap <leader>S <cmd>lua require('spectre').open()<CR>

]]

vim.cmd [[

  call plug#begin()

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'nvim-lua/plenary.nvim'
  Plug 'tami5/sqlite.lua'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'nvim-telescope/telescope-live-grep-args.nvim'
  Plug 'dense-analysis/ale'
  Plug 'tpope/vim-fugitive'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-context'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mbbill/undotree'
  Plug 'ThePrimeagen/harpoon'
  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'vim-scripts/BufOnly.vim'
  Plug 'numToStr/Comment.nvim'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'sickill/vim-pasta'
  Plug 'karb94/neoscroll.nvim'
  Plug 'lewis6991/spellsitter.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'luukvbaal/stabilize.nvim'
  Plug 'windwp/nvim-spectre'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'bluz71/vim-nightfly-guicolors'

  call plug#end()
]]

vim.cmd [[
  colorscheme nightfly
  highlight WinSeparator guibg=NONE
]]

-- ALE

vim.g['ale_fixers'] = {
  javascript = { 'eslint', 'prettier' },
  typescript = { 'eslint', 'prettier' },
}
vim.g.ale_linters = {
  javascript = { 'eslint' },
  typescript = { 'eslint', 'tsserver' },
}
vim.g.ale_typescript_prettier_use_local_config = 1
vim.g.ale_fix_on_save = 1
vim.g.ale_format_on_save = 1
vim.g.ale_linters_explicit = 1
vim.g.ale_disable_lsp = 1
vim.g.ale_lint_delay =0

-- NERDTree
vim.g.NERDTreeWinSize = 60
vim.g.NERDTreeWinPos = 'right'

-- airline
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail'
vim.g['airline_powerline_fonts'] = 1
vim.g['airline_right_alt_sep'] = ''
vim.g['airline_right_sep'] = ''
vim.g['airline_left_alt_sep'] = ''
vim.g['airline_left_sep'] = ''

require'nvim-treesitter.install'.compilers = { 'clang', 'gcc' }

require'nvim-treesitter.configs'.setup({
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    ensure_installed = "all",
    config = {
      javascript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
      tsx = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      },
      typescript = {
        __default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s'
      }
    },
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true }
})

require('neoscroll').setup( { easing_function = "sine" } )

require('spellsitter').setup()

require('gitsigns').setup( { current_line_blame = true } )

require('stabilize').setup()

require('Comment').setup({
  ---@param ctx CommentCtx
  pre_hook = function(ctx)
    -- Only calculate commentstring for tsx filetypes
    if vim.bo.filetype == 'typescriptreact' then
      local U = require('Comment.utils')
      -- Determine whether to use linewise or blockwise commentstring
      local type = ctx.ctype == U.ctype.line and '__default' or '__multiline'
      -- Determine the location where to calculate commentstring from
      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require('ts_context_commentstring.utils').get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require('ts_context_commentstring.utils').get_visual_start_location()
      end

      return require('ts_context_commentstring.internal').calculate_commentstring({
        key = type,
        location = location,
      })
    end
  end,
})

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {"node_modules", ".git", "local_jars", "dmlCompare" },
    path_display = { "truncate" } },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  pickers = {
    find_files = { hidden = true, },
  },
})

require('telescope').load_extension('fzf')
