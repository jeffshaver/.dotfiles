local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-i>", ":bnext<CR>", opts)
keymap("n", "<C-o>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to exit insert mode 
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

keymap('n', '<leader>nt', ':NvimTreeToggle<cr>', opts)

keymap('n', '<C-p>', [[<cmd> lua require('telescope.builtin').find_files()<cr>]], opts)
keymap('n', '<leader>fg', [[<cmd> lua require('telescope.builtin').live_grep()<cr>]], opts)
keymap('n', '<leader>ff', [[<cmd> lua require('telescope.builtin').find_files({ initial_mode = "normal", search_file = vim.fn.expand('<cword>') } )<cr>]], opts)
keymap('n', '<leader>fw', [[<cmd> lua require('telescope.builtin').grep_string({ initial_mode = "normal" })<cr>]], opts)
keymap('n', '<leader>fh', [[<cmd> lua require('telescope.builtin').help_tags()<cr>]], opts)
keymap('n', '<leader>fs', [[<cmd> lua require('spectre').open()<cr> ]], opts)
keymap('n', '<C-h>', [[<cmd> lua require('harpoon.ui').toggle_quick_menu()<cr>]], opts)
keymap('n', '<C-n>', [[<cmd> lua require('harpoon.mark').add_file()<cr>]],opts)
keymap('n', '<C-j>', [[<cmd> lua require('harpoon.ui').nav_file(1)<cr>]],opts)
keymap('n', '<C-k>', [[<cmd> lua require('harpoon.ui').nav_file(2)<cr>]],opts)
keymap('n', '<C-l>', [[<cmd> lua require('harpoon.ui').nav_file(3)<cr>]],opts)
keymap('n', '<C-;>', [[<cmd> lua require('harpoon.ui').nav_file(4)<cr>]],opts)
keymap('n', '<C-J><C-J>', ':w<cr>',opts)
keymap('n', '<leader>gd', ':Gvdiffsplit!<cr>',opts)
keymap('i', 'kj', '<esc>',opts)
keymap('n', '<C-a>', 'C-^',opts)
keymap('n', '<leader>bo', ':BufOnly<cr>', opts)