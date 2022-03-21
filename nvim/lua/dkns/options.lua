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
--vim.g.material_style = 'deep ocean'

o.undofile = true

vim.cmd("colorscheme nightfox")
