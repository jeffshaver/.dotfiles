local status_ok, neoscroll = pcall(require, 'neoscroll')
if not status_ok then
  return
end

neoscroll.setup( {easing_function = 'sine' })

local t = {}

t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50" } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50" } }

require('neoscroll.config').set_mappings(t)
