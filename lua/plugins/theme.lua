local M = {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		config = function()
			require("onedark").setup({
				-- transparent = true,
				style = "dark",
				diagnostics = {
					background = false,
				},
			})
			require("onedark").load()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = { theme = "onedark" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "encoding", "fileformat", "filetype" },
				},
			})
		end,
	},
	{
		-- noice通知和悬浮命令行
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
					},
				},
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		main = "ibl",
		opts = {
			indent = { char = "│" },
			scope = { char = "│" },
		},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				config = {
					header = {
						"                                                                     ",
						"       ████ ██████           █████      ██                     ",
						"      ███████████             █████                             ",
						"      █████████ ███████████████████ ███   ███████████   ",
						"     █████████  ███    █████████████ █████ ██████████████   ",
						"    █████████ ██████████ █████████ █████ █████ ████ █████   ",
						"  ███████████ ███    ███ █████████ █████ █████ ████ █████  ",
						" ██████  █████████████████████ ████ █████ █████ ████ ██████ ",
						"                                                                       ",
					},
					shortcut = {},
					footer = {},
				},
			})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}

return M
