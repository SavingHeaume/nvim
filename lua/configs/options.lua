local opt = vim.opt
local o = vim.o
local g = vim.g

o.laststatus = 3
o.showmode = false
opt.fillchars = { eob = " " }
o.signcolumn = "yes"

o.clipboard = "unnamedplus"
o.mouse = "a"

o.cursorline = true
o.cursorlineopt = "number"

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

o.ignorecase = true
o.smartcase = true

o.number = true
o.numberwidth = 2
opt.whichwrap:append("<>[]hl")

o.splitbelow = true
o.splitright = true

o.undofile = true
o.updatetime = 250

o.timeoutlen = 400
o.ruler = false
opt.shortmess:append("sI")

g.clipboard = {
	name = "win32yank",
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -o --lf",
		["*"] = "win32yank.exe -o --lf",
	},
	cache_enabled = 0,
}
