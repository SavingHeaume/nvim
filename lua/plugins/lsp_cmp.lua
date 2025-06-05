local M = {
	{
		"mason-org/mason.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					cpp = { "clang-format" },
				},
				-- format_on_save = {
				--   timeout_ms = 500,
				--   lsp_fallback = true,
				-- },
			})
		end,
	},

	{
		"saghen/blink.cmp",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },

			completion = {
				documentation = {
					auto_show = true,
				},
			},

			signature = {
				enabled = true,
			},

			cmdline = {
				completion = {
					menu = {
						auto_show = true,
					},
				},
			},
		},
	},

	{
		"saghen/blink.pairs",
		version = "*",
		dependencies = "saghen/blink.download",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			mappings = {
				enabled = true,
				pairs = {},
			},
			highlights = {
				enabled = true,
				groups = {
					"BlinkPairsOrange",
					"BlinkPairsPurple",
					"BlinkPairsBlue",
				},
				matchparen = {
					enabled = true,
					group = "MatchParen",
				},
			},
			debug = false,
		},
	},

	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
	},
}

return M
