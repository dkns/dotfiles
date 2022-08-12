local M = {}

function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.is_wsl()
  local output = vim.fn.systemlist "uname -r"
  return not not string.find(output[1] or "", "WSL")
end

function M.is_mac()
  return vim.fn.has("maxunic") == 1
end

function M.is_linux(self)
  return not self.is_wsl() and not self.is_mac()
end

return M
