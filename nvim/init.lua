require('dkns.plugins')
require('dkns.options')
require('dkns.keybinds')

vim.g.mapleader = " "

local cmd = vim.cmd

local scopes = { o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
    scopes[scope][key] = value
    if scopes ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'scrolloff', 5)
opt('o', 'completeopt', 'menuone,noselect')
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('o', 'ignorecase', true)
opt('o', 'splitright', true)
opt('o', 'splitbelow', true)

cmd 'colorscheme tokyonight'

local ts = require('nvim-treesitter.configs')
ts.setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true
    }
}

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,

    source = {
        path = true,
	buffer = true,
	nvim_lsp = true,
	nvim_lua = true
    }
}

require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end

require('local_config')
