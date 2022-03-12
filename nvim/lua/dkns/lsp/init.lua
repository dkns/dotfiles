local lsp_installer = require('nvim-lsp-installer')
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local function on_attach(client, bufnr)
  -- buffer local keymaps
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
