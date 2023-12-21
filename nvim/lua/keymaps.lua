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
vim.keymap.set('n', '<C-s>', ':w<cr>', { noremap = true })
vim.keymap.set('i', '<C-s>', '<C-c>:w<cr>a', { noremap = true })

--[[ vim.keymap.set('n', '<C-s>', function() ]]
--[[   if vim.tbl_isempty(require('guard.filetype')(vim.bo.ft)) then vim.cmd.write() ]]
--[[   else vim.cmd('GuardFmt') ]]
--[[   end ]]
--[[ end) ]]
--[[]]
--[[ vim.keymap.set('i', '<C-s>', function() ]]
--[[   if vim.tbl_isempty(require('guard.filetype')(vim.bo.ft)) then vim.cmd.write() ]]
--[[   else vim.cmd('GuardFmt') ]]
--[[   end ]]
--[[ end) ]]

-- Insert --
-- Press kj fast to exit insert mode 
vim.keymap.set('i', 'kj', '<ESC>', opts)

vim.keymap.set('i', '<C-k>', '<Up>', opts)
vim.keymap.set('i', '<C-j>', '<Down>', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)

-- Visual --
-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move text up and down
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)
vim.keymap.set('v', '<leader>p', '"_dP', opts)
vim.keymap.set('n', '<leader>y', '\"+y', opts)
vim.keymap.set('v', '<leader>y', '\"+y', opts)
vim.keymap.set('n', '<leader>Y', '\"+Y', opts)

-- Visual Block --
-- Move text up and down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)
vim.keymap.set('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

vim.keymap.set('n', '<leader>nt', ':NvimTreeToggle<cr>', opts)

vim.keymap.set('n', '<C-p>', [[<cmd> lua require('telescope.builtin').find_files()<cr>]], opts)
vim.keymap.set('n', '<leader>fg', [[<cmd> lua require('telescope.builtin').live_grep()<cr>]], opts)
vim.keymap.set('n', '<leader>fr', [[<cmd> lua require('telescope.builtin').lsp_references()<cr>]], opts)
vim.keymap.set('n', '<leader>ff', [[<cmd> lua require('telescope.builtin').find_files({ search_file = vim.fn.expand('<cword>') } )<cr>]], opts)
vim.keymap.set('n', '<leader>fd', [[<cmd> lua require('telescope.builtin').buffers()<cr>]], opts)
vim.keymap.set('n', '<leader>fw', [[<cmd> lua require('telescope.builtin').grep_string()<cr>]], opts)
vim.keymap.set('n', '<leader>fh', [[<cmd> lua require('telescope.builtin').help_tags()<cr>]], opts)
vim.keymap.set('n', '<leader>u', [[<cmd>Telescope undo<cr>]], opts)
vim.keymap.set('n', '<leader>fs', [[<cmd> lua require('spectre').open()<cr> ]], opts)
vim.keymap.set('n', '<leader>gs', [[<cmd> lua require('telescope.builtin').git_stash()<cr>]], opts)
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<cr>',opts)
vim.keymap.set('n', '<C-a>', 'C-^',opts)
vim.keymap.set('n', '<leader>bo', ':BufOnly<cr>', opts)
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opts)

-- NVIM NvimTree
vim.keymap.set('n', '<C-t>', ':NvimTreeFindFileToggle<cr>', opts)
