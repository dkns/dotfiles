local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map('n', '<leader>v', '<cmd>split<cr>')
map('n', '<leader>h', '<cmd>vsplit<cr>')
map('n', '<leader>b', '<cmd>Telescope buffers<cr>')
map('n', '<C-p>', '<cmd>Telescope find_files<cr>')

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
