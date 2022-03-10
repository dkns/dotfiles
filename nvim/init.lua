require('impatient_setup')
require('impatient')
local fn = vim.fn
vim.g.mapleader = ' '

require('dkns.plugins')
require('dkns.disable_builtin')
require('dkns.options')
require('dkns.keybinds')
require('dkns.plugins')
require('dkns.telescope')
require('dkns.treesitter')
require('dkns.lsp')

-- local local_config_path = './local_config.lua'

-- if fn.empty(fn.glob(local_config_path)) > 0 then
--   require('local_config')
-- end
