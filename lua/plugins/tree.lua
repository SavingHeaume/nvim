local M = {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"lua",
					"luadoc",
					"printf",
					"vim",
					"vimdoc",

					"rust",
					"cpp",
				},

				highlight = {
					enable = true,
					use_languagetree = true,
				},

				indent = { enable = true },
			})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		opts = {
			window = {
				width = 30,
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},
		},
	},
}

return M
