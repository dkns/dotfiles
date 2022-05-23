local o = vim.o

o.number = true
o.relativenumber = true
o.scrolloff = 5
o.sidescrolloff = 5
o.clipboard = 'unnamedplus'
o.ignorecase = true
o.inccommand = 'split'
o.splitright = true
o.splitbelow = true
o.completeopt = 'menuone,noselect'
o.breakindent = true
o.laststatus = 3
o.undofile = true

vim.cmd("colorscheme nightfox")
