local opts = { noremap = true, silent = true }

return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
		config = function()
			local actions = require("telescope.actions")

			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules", ".git/", "local_jars", "dmlCompare" },
					prompt_prefix = "󰭎 ",
					selection_caret = " ",
					path_display = { "filename_first", "truncate" },
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},

					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-c>"] = actions.close,
							["<esc>"] = actions.close,
						},
					},
				},
				pickers = {
					find_files = { hidden = true },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			require("telescope").load_extension("fzf")
			require("telescope").load_extension("harpoon")
			require("telescope").load_extension("undo")
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, opts)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, opts)
			vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)
			vim.keymap.set("n", "<leader>fd", builtin.buffers, opts)
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, opts)
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)
			vim.keymap.set("n", "<leader>u", function()
				require("telescope").extensions.undo.undo()
			end, opts)
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for install instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "debugloop/telescope-undo.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	},
}
