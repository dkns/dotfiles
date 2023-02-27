local opt = vim.opt;

opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.clipboard = 'unnamedplus'
opt.ignorecase = true
opt.inccommand = 'split'
opt.splitright = true
opt.splitbelow = true
opt.completeopt = 'menuone,noselect'
opt.breakindent = true
opt.laststatus = 3
opt.undofile = true
opt.winbar = '%f'
opt.swapfile = false
opt.diffopt:append('algorithm:patience')
opt.diffopt:append('linematch:60')
-- ??????
opt.list = true
opt.listchars = {
  trail = '·'
}

vim.g.cursorhold_updatetime = 100

vim.cmd("colorscheme tokyonight")

vim.cmd("set statusline=%!v:lua.require('dkns.statusline').statusline()")
