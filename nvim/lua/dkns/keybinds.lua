local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map('n', '<leader>v', '<cmd>split<cr>')
map('n', '<leader>h', '<cmd>vsplit<cr>')

map('n', '<leader>ev', ':e $HOME/dotfiles/nvim/init.lua<cr>')

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-p>', '<cmd>Telescope find_files<cr>')
map('n', '<leader>r', '<cmd>Telescope oldfiles<cr>')
map('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers{ show_all_buffers = true }<cr>")

map('n', '<leader>nt', '<cmd>NvimTreeToggle<cr>')

map('i', 'jk', '<ESC>')

map('n', '<leader>vr', "require('plenary.reload').reload_module('dkns', true)")

