vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.10.2",
	},
	{ src = "https://github.com/saghen/blink.pairs", version = vim.version.range("*") },
  "https://github.com/saghen/blink.lib"
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("blink", { clear = true }),
	once = true,
	callback = function()
		require("blink.cmp").setup({
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

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		})

    require("blink.pairs").download():pwait(60000)

		require("blink.pairs").setup({
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
		})
	end,
})
