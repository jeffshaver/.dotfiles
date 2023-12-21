return {
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        actions = {
          open_file = {
            quit_on_open = true,
          }
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        renderer = {
          root_folder_modifier = ':t',
          icons = {
            glyphs = {
              default = '',
              symlink = '',
              folder = {
                arrow_open = '',
                arrow_closed = '',
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
                symlink_open = '',
              },
              git = {
                unstaged = '',
                staged = 'S',
                unmerged = '',
                renamed = '➜',
                untracked = 'U',
                deleted = '',
                ignored = '◌',
              },
            },
          },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
        view = {
          width = 60,
          side = 'right',
        },
      })
    end

  }
}
