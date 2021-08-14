local o = vim.o
local cmd = vim.cmd

o.scrolloff = 5
o.number = true
o.relativenumber = true
o.ignorecase = true
o.splitright = true
o.splitbelow = true
o.clipboard = 'unnamedplus,unnamed'
o.completeopt = 'menuone,noselect'

cmd 'colorscheme tokyonight'
