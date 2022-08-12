local map = require('dkns.utils').map
local is_wsl = require('dkns.utils').is_wsl

local recent_finder = function()
  if is_wsl() then
    return '<cmd>Telescope oldfiles<cr>'
  end

  return '<cmd>Telescope frecency<cr>'
end

map('n', '<leader>v', '<cmd>split<cr>')
map('n', '<leader>h', '<cmd>vsplit<cr>')

map('n', '<leader>ev', ':e $HOME/dotfiles/nvim/init.lua<cr>')

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-p>', '<cmd>Telescope find_files hidden=true<cr>')
map('n', '<leader>r', recent_finder())
map('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers{ show_all_buffers = true }<cr>")
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map('n', '<leader>fp', ":lua require('telescope').extensions.project.project{}<cr>")
map('n', '<leader>ff', ":lua vim.lsp.buf.format { async = true }<cr>")

map('n', '<C-J>', '<cmd>TmuxNavigateUp<cr>')
map('n', '<C-K>', '<cmd>TmuxNavigateDown<cr>')
map('n', '<C-L>', '<cmd>TmuxNavigateRight<cr>')
map('n', '<C-H>', '<cmd>TmuxNavigateLeft<cr>')

map('t', '<ESC>', "<C-\\><C-n>")

map('n', '<leader>nt', '<cmd>Neotree toggle<cr>')

map('i', 'jk', '<ESC>')

map('n', '<leader>vr', "require('plenary.reload').reload_module('dkns', true)")
