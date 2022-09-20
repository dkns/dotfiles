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
-- ??????
vim.opt.list = true
vim.opt.listchars = {
  trail = '·'
}

vim.g.cursorhold_updatetime = 100

vim.cmd("colorscheme tokyonight")

vim.cmd("set statusline=%!v:lua.require('dkns.statusline').statusline()")
