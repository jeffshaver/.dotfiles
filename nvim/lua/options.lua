vim.o.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fileencoding = "utf-8"
vim.o.foldlevelstart = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.guicursor = ""
vim.o.guifont = "Fira Code Nerd Font:h17"
vim.o.hlsearch = false
vim.o.laststatus = 3
vim.o.mouse = ""
vim.o.number = true
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.scrolloff = 16
vim.o.shiftwidth = 2
vim.o.showmatch = true
vim.o.showmode = false
vim.o.sidescrolloff = 16
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.spell = true
vim.opt.spelllang = { "en_us" }
vim.o.spelloptions = "camel"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeoutlen = 200
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.updatetime = 50
vim.o.wrap = false
vim.o.writebackup = false

vim.opt.listchars:append("trail:·")

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.rustfmt_autosave = 1
vim.opt.shortmess:append("c")

-- nvim tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
