local map = vim.keymap.set

map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- neotree
map("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "telescope find file" })

-- format
map("n", "<leader>fm", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format File" })

-- term
map({ "n", "t" }, "<C-t>v", function()
	require("configs.term").toggle({ pos = "vsp", id = "vtoggleTerm" })
end, { desc = "terminal toggleable vertical term" })

map({ "n", "t" }, "<C-t>h", function()
	require("configs.term").toggle({ pos = "sp", id = "htoggleTerm" })
end, { desc = "terminal toggleable horizontal term" })

map({ "n", "t" }, "<C-t>f", function()
	require("configs.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggleable float term" })

-- trouble list
map({ "n" }, "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Diagnostics (Trouble)" })

-- bufferline
map({ "n" }, "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map({ "n" }, "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map({ "n" }, "<leader>bc", ":bdelete %<cr>", { desc = "close current buffer" })
map({ "n" }, "<leader>bp", "<cmd>BufferLinePickClose<cr>", { desc = "pick close" })
