require('telescope').setup {
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
