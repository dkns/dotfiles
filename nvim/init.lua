vim.g.mapleader = ' '

local plugins = require('dkns.plugins')

require('lazy').setup(plugins)

require('dkns.disable_builtin')
require('dkns.options')
require('dkns.keybinds')
require('dkns.statusline')
require('dkns.core')
require('dkns.telescope')
require('dkns.treesitter')
require('dkns.lsp')
require('dkns.cmp')
require('dkns.neotree')
