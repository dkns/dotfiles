require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    }
  },
  extensions = {
    fzf = {
      fuzzy = true
    }
  }
}

require('telescope').load_extension('fzf')
require('telescope').load_extension('project')
require('telescope').load_extension('frecency')
require('telescope').load_extension('npm')
