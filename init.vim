let mapleader = " "
set background=dark
set backspace=indent,eol,start
set colorcolumn=80
set cursorline
set encoding=UTF-8
set expandtab
set hidden
set incsearch
set nobackup
set noerrorbells
set nohlsearch
set noswapfile
set nu
set relativenumber
set scrolloff=8
set shiftwidth=2
set showmatch
set signcolumn=yes
set smartindent
set t_Co=256
set tabstop=2 softtabstop=2
set termguicolors
set undodir=~/.vim/undodir
set undofile
set updatetime=1000
syntax on

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <C-h> <cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>
nnoremap <C-n> <cmd>lua require('harpoon.mark').add_file()<cr>
nnoremap <C-j> <cmd>lua require('harpoon.ui').nav_file(1)<cr>
nnoremap <C-k> <cmd>lua require('harpoon.ui').nav_file(2)<cr>
nnoremap <C-l> <cmd>lua require('harpoon.ui').nav_file(3)<cr>
nnoremap <C-;> <cmd>lua require('harpoon.ui').nav_file(4)<cr>
nnoremap <C-j><C-j> :w<cr>
nnoremap <leader>gd :Gvdiffsplit!<cr>

" Change alternate file to ctrl-a
nnoremap <C-a> <C-^>

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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

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

" Auto-fix/format
nnoremap <C-I> :ALEFix<cr>

" NERDTree
nnoremap <leader>nf :NERDTreeFind<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

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
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'bluz71/vim-nightfly-guicolors'

call plug#end()

colorscheme nightfly

let g:ale_fixers = {
\       'javascript': ['eslint', 'prettier'],
\       'javascriptreact': ['eslint', 'prettier'],
\	'typescript': ['eslint', 'prettier'],
\	'typescriptreact': ['eslint', 'prettier'],
\}
let g:ale_linters = {
\       'javascript': ['eslint'],
\       'javascriptreact': ['eslint'],
\       'typescript': ['eslint', 'tsserver'],
\	'typescriptreact': ['eslint', 'prettier'],
\}
let g:ale_typescript_prettier_use_local_config = 1
let g:ale_fix_on_save = 1
let g:ale_format_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_disable_lsp = 1

let g:NERDTreeWinSize=60

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}
lua << EOF
require('telescope').setup { defaults = { file_ignore_patterns = { "node_modules", ".git", "local_jars", "dmlCompare" }, path_display = { "truncate" } }, extensions = { fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" } }, pickers = { find_files = { hidden = true } } }
require('telescope').load_extension('fzf')
EOF
