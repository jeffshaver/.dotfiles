local options = {
	backspace = "indent,eol,start",
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 1,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	cursorline = true,
	errorbells = false,
	expandtab = true,
	fileencoding = "utf-8",
	foldlevelstart = 99,
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	guicursor = "",
	guifont = "Fira Code Nerd Font:h17",
	hidden = true,
	hlsearch = false,
	incsearch = true,
	laststatus = 3,
	list = true,
	mouse = "",
	number = true,
	numberwidth = 4,
	pumheight = 10,
	redrawtime = 10000,
	relativenumber = true,
	scrolloff = 16,
	shiftwidth = 2,
	showmatch = true,
	showmode = false,
	showtabline = 1,
	sidescrolloff = 16,
	signcolumn = "yes",
	smartindent = true,
	spell = true,
	spelllang = { "en_us" },
	spelloptions = "camel",
	splitbelow = true,
	splitright = true,
	swapfile = false,
	tabstop = 2,
	termguicolors = true,
	timeoutlen = 200,
	undodir = os.getenv("HOME") .. "/.vim/undodir",
	undofile = true,
	updatetime = 50,
	wrap = false,
	writebackup = false,
}

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

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
