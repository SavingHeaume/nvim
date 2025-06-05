vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("rust-analyzer")

local x = vim.diagnostic.severity
vim.diagnostic.config({
	virtual_text = { prefix = "" }, -- 行内显示错误
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } }, -- 行号旁显示标记
	update_in_insert = false,
})

vim.lsp.inlay_hint.enable()
