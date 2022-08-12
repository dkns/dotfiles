local fn = vim.fn
local diagnostic = require('vim.diagnostic')

diagnostic.config({
  severity_sort = true,
  virtual_text = true,
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
