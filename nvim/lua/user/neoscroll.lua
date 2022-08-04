local status_ok, neoscroll = pcall(require, 'neoscroll')
if not status_ok then
  return
end

neoscroll.setup( {easing_function = 'sine' })

local t = {}

t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '50'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '50'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '50'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '50'}}
t['<C-y>'] = {'scroll', {'-0.10', 'false', '50'}}
t['<C-e>'] = {'scroll', { '0.10', 'false', '50'}}
t['zt']    = {'zt', {'50'}}
t['zz']    = {'zz', {'50'}}
t['zb']    = {'zb', {'50'}}

require('neoscroll.config').set_mappings(t)
