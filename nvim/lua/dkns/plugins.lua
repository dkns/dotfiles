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
  use 'folke/tokyonight.nvim'

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
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup()
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'petertriho/cmp-git'
    }
  }

  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup({}) end
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function() require('nvim-ts-autotag').setup() end
  }

  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    },
  }

  use 'mbbill/undotree'

  use {
    'j-hui/fidget.nvim',
    config = function() require('fidget').setup({}) end
  }

  use 'mg979/vim-visual-multi'

  use 'vim-test/vim-test'

  use 'christoomey/vim-tmux-navigator'

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup({
        sources = {
          require('null-ls').builtins.formatting.lua_format,
          require('null-ls').builtins.formatting.prettier,
        }
      })
    end
  }

  use {
    'jose-elias-alvarez/typescript.nvim',
    config = function()
      require('typescript').setup({
        server = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        }
      })
    end
  }

  use {
    'antoinemadec/FixCursorHold.nvim'
  }

  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      'haydenmeade/neotest-jest',
    },
    config = function()
      require('neotest').setup({
        jestCommand = "npm test --",
        jestConfigFile = "custom.jest.config.ts",
        env = { CI = true },
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      })
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
