local map = vim.keymap.set

map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "telescope find file" })

map("n", "<leader>fm", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format File" })
