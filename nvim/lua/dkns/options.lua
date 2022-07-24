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
o.winbar = '%f'
o.swapfile = false

vim.cmd("colorscheme nightfox")

vim.cmd("set statusline=%!v:lua.require('dkns.statusline').statusline()")
