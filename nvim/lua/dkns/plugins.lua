local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'airblade/vim-rooter'

  use {
    "EdenEast/nightfox.nvim",
    config = function()
      require('nightfox').setup({
        dim_inactive = true
      })
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'
  }

  use {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup({
        dimInactive = true
      })
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({})
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('gitsigns').setup {} end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'nvim-telescope/telescope-project.nvim' }
  use {'elianiva/telescope-npm.nvim' }
  use {
    'nvim-telescope/telescope-frecency.nvim',
    requires = { 'tami5/sqlite.lua' }
  }

  use {
    'williamboman/nvim-lsp-installer',
    requires = { 'neovim/nvim-lspconfig' }
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'petertriho/cmp-git'
    }
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup({}) end
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function() require('nvim-ts-autotag').setup() end
  }
  if packer_bootstrap then
    require('packer').sync()
  end
end)
