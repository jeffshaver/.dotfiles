vim.loader.enable()

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- when status bar is disabled, show no cmdheight
vim.o.cmdheight = 0
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
-- 0 disables status bar. last set to 3
vim.o.laststatus = 0
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

-- Remap space as leader key
-- Make it so leader does nothing if you press it only once
--  Prevents accidental moving of cursor when using keymaps
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.rustfmt_autosave = 1
vim.opt.shortmess:append("c")

-- nvim tree
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})

local opts = { noremap = true, silent = true }

-- Shorten function name
-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Write buffer
vim.keymap.set("n", "<C-s>", ":w<cr>", opts)
vim.keymap.set("i", "<C-s>", "<C-c>:w<cr>a", opts)

-- Insert --
-- Press kj fast to exit insert mode
vim.keymap.set("i", "kj", "<ESC>", opts)

vim.keymap.set("i", "<C-k>", "<Up>", opts)
vim.keymap.set("i", "<C-j>", "<Down>", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
vim.keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)
vim.keymap.set("v", "<leader>p", '"_dP', opts)
vim.keymap.set("n", "<leader>y", '"+y', opts)
vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>Y", '"+Y', opts)

-- Visual Block --
-- Move text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("x", "<A-j>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "<A-k>", ":m '<-2<CR>gv=gv", opts)

vim.keymap.set("n", "<leader>fs", function()
  require("spectre").open()
end, opts)
vim.keymap.set("n", "<leader>gs", function()
  require("telescope.builtin").git_stash()
end, opts)
vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<cr>", opts)
vim.keymap.set("n", "<C-a>", "C-^", opts)
vim.keymap.set("n", "<leader>bo", ":BufOnly<cr>", opts)
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- force inlay hints to have no background color
vim.cmd([[highlight LspInlayHint guibg=NONE]])

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = vim.api.nvim_create_augroup("DisableNewLineComment", { clear = true }),
})

