local lsp_installer = require('nvim-lsp-installer')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local map = require('dkns.utils').map
local diagnostic = require('vim.diagnostic')
local cmd = vim.cmd
local fn = vim.fn

-- local function on_attach(client, bufnr)
--   -- buffer local keymaps
-- end

diagnostic.config({
  severity_sort = true,
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = true,
  float = {
    border = "single",
    format = function(diag)
      return string.format(
        "%s (%s) [%s]",
        diag.message,
        diag.source,
        diag.code or diag.user_data.lsp.code
      )
    end
  }
})

local sign_char = '•' -- U+2022 BULLET

fn.sign_define('DiagnosticSignError', {
  text = sign_char,
  texthl = 'DiagnosticSignError',
})

fn.sign_define('DiagnosticSignWarn', {
  text = sign_char,
  texthl = 'DiagnosticSignWarn',
})

fn.sign_define('DiagnosticSignInfo', {
  text = sign_char,
  texthl = 'DiagnosticSignInfo',
})

fn.sign_define('DiagnosticSignHint', {
  text = sign_char,
  texthl = 'DiagnosticSignHint',
})

local function on_attach(client)
  if client.resolved_capabilities.document_highlight then
    cmd('autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
    cmd('autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()')
    cmd('autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()')
  end

  map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map('n', '<leader>K', '<cmd>lua vim.diagnostic.open_float()<CR>')
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local enhance_server_opts = {
  ['sumneko_lua'] = function(opts)
    opts.settings = {
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
  end,
  ['tsserver'] = function(opts)
    opts.on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false

      on_attach(client)
    end
  end,
  ['eslint'] = function(opts)
    opts.settings = {
      codeActionOnSave = {
        enable = true,
        mode = "all"
      },
      format = {
        enable = true
      }
    }
    opts.on_attach = function(client)
      map('n', '<leader>fd', '<cmd>EslintFixAll<CR>')

      on_attach(client)
    end
  end,
}

lsp_installer.on_server_ready(function(server)

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }

  if enhance_server_opts[server.name] then
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
end)
