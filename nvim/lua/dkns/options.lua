local o = vim.o

o.number = true
o.relativenumber = true
o.scrolloff = 5
o.clipboard = 'unnamedplus,unnamed'
o.ignorecase = true
o.splitright = true
o.splitbelow = true
o.completeopt = 'menuone,noselect'

vim.cmd("colorscheme kanagawa")