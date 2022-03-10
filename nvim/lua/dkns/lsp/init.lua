local lsp_installer = require('nvim-lsp-installer')

local function on_attach(client, bufnr)
  -- buffer local keymaps
end

local enhance_server_opts = {

}

lsp_installer.on_server_ready(function(server)

  local opts = {
    on_attach = on_attach,
  }

  if enhance_server_opts[server.name] then
    enhance_server_opts[server.name](opts)
  end

  server:setup(opts)
end)
