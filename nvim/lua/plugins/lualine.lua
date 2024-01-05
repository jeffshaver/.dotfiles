return {
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			local diagnostics = {
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn" },
				colored = false,
				update_in_insert = false,
				always_visible = true,
			}

			local function diff_source()
				local gitsigns = vim.b.gitsigns_status_dict
				if gitsigns then
					return {
						added = gitsigns.added,
						modified = gitsigns.changed,
						removed = gitsigns.removed,
					}
				end
			end

			local diff = {
				"diff",
				colored = false,
				source = diff_source,
			}

			local filetype = {
				"filetype",
				icons_enabled = false,
				icon = nil,
			}

			local branch = {
				"branch",
				icons_enabled = true,
				icon = "",
			}

			local location = {
				"location",
			}

			local colors = {
				bg = "#212e3f",
				fg = "#aeafb0",
			}

			local config = {
				options = {
					icons_enabled = true,
					theme = {
						normal = {
							a = { bg = colors.bg, fg = colors.fg },
							b = { bg = colors.bg, fg = colors.fg },
							c = { bg = colors.bg, fg = colors.fg },
						},
						insert = {
							a = { bg = colors.bg, fg = colors.fg },
							b = { bg = colors.bg, fg = colors.fg },
							c = { bg = colors.bg, fg = colors.fg },
						},
						visual = {
							a = { bg = colors.bg, fg = colors.fg },
							b = { bg = colors.bg, fg = colors.fg },
							c = { bg = colors.bg, fg = colors.fg },
						},
						command = {
							a = { bg = colors.bg, fg = colors.fg },
							b = { bg = colors.bg, fg = colors.fg },
							c = { bg = colors.bg, fg = colors.fg },
						},
						replace = {
							a = { bg = colors.bg, fg = colors.fg },
							b = { bg = colors.bg, fg = colors.fg },
							c = { bg = colors.bg, fg = colors.fg },
						},
						inactive = {
							a = { bg = colors.bg, fg = colors.fg },
							b = { bg = colors.bg, fg = colors.fg },
							c = { bg = colors.bg, fg = colors.fg },
						},
					},
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
					always_divide_middle = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "filename", branch },
					lualine_c = { diagnostics },
					-- lualine_x = { 'encoding', 'fileformat', 'filetype' },
					lualine_x = { diff, filetype },
					lualine_y = { location },
					lualine_z = { "progress" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				extensions = {},
			}

			require("lualine").setup(config)
		end,
	},
	"arkav/lualine-lsp-progress",
}
