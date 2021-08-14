U = {}
U.keymap = {}

function U.keymap.buf_map(mode, key, cmd, opts)
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_buf_set_keymap(0, mode, key, cmd, options)
end

local function nmap(key, cmd, opts)
    U.keymap.buf_map('n', key, cmd, opts)
end

local function lua_nmap(key, cmd, opts)
    nmap(key, '<cmd>lua ' .. cmd .. '<CR>', opts)
end

local function mappings()
  lua_nmap('gd', 'vim.lsp.buf.definition()')
  lua_nmap('gD', 'vim.lsp.buf.declaration()')
  lua_nmap('gi', 'vim.lsp.buf.implementation()')
  lua_nmap('gr', 'vim.lsp.buf.references()')
  lua_nmap('<leader>ca', 'vim.lsp.buf.code_action()')
  lua_nmap('<leader>rn', 'vim.lsp.buf.rename()')
end

local function config_typescript()
    require('nvim-lsp-ts-utils').setup {}
end

return function(client)
    mappings()

    if client.name == 'typescript' then
	config_typescript()
    end

    if client.name ~= 'efm' then
	client.resolved_capabilities.document_formatting = false
    end
    if client.resolved_capabilities.document_formatting then
	vim.cmd [[autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)]]
    end
end
