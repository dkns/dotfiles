require('dkns.lsp.diagnostics')

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local map = require('dkns.utils').map

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>K', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local function on_attach(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local flags = {
  debounce_text_changes = 150
}

lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client)
    map('n', '<leader>fd', '<cmd>EslintFixAll<CR>')
    on_attach(client)
  end,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
    format = {
      enable = true
    }
  }
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  flags = flags
})

lspconfig.sumneko_lua.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      },
      telemetry = {
        enable = false
      }
    }
  }
})

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach
})

local border = {
    { "┌", "FloatBorder" },
    { "─", "FloatBorder" },
    { "┐", "FloatBorder" },
    { "│", "FloatBorder" },
    { "┘", "FloatBorder" },
    { "─", "FloatBorder" },
    { "└", "FloatBorder" },
    { "│", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
