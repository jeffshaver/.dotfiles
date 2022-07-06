local options = {
  backspace = "indent,eol,start",
  backup = false,
  clipboard = "unnamedplus",
  cmdheight = 1,
  colorcolumn = "80",
  completeopt = { "menuone", "noselect" },
  conceallevel = 0,
  cursorline = true,
  errorbells = false,
  expandtab = true,
  fileencoding = "utf-8",
  guifont = "monospace:h17",
  hidden = true,
  hlsearch = false,
  incsearch = true,
  laststatus = 3,
  list = true,
  listchars = 'tab:▸ ,trail:·',
  number = true,
  numberwidth = 4,
  pumheight = 10,
  redrawtime = 10000,
  relativenumber = true,
  scrolloff = 16,
  shiftwidth = 2,
  showmatch = true,
  showmode = false,
  showtabline = 2,
  sidescrolloff = 16,
  signcolumn = "yes",
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 100,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
  updatetime = 50,
  wrap = false,
  writebackup = false,
}

vim.g.mapleader = " "
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]]
