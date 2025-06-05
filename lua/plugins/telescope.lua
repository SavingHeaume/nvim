local M = {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = "Telescope",
		config = function()
			require("telescope").setup({
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			})
		end,
	},
}

return M
