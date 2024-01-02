return {
	"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	"kyazdani42/nvim-web-devicons",
	"mbbill/undotree",
	{ "kevinhwang91/nvim-bqf", ft = "qf" },
	{
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	},
	"vim-scripts/BufOnly.vim",
	"luukvbaal/stabilize.nvim",
	"windwp/nvim-spectre",
	"RRethy/vim-illuminate",
}
