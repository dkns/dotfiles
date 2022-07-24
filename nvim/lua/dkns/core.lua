local highlight_group = vim.api.nvim_create_augroup("highlight_yank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank { hlgroup='IncSearch', timeout=550 }",
  group = highlight_group
})
