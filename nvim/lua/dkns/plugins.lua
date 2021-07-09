local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

local fn = vim.fn
local execute = vim.api.nvim_command

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

local use = require('packer').use

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use 'christoomey/vim-tmux-navigator'
  use 'neovim/nvim-lspconfig'
  use 'airblade/vim-rooter'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-commentary'
  use 'tpope/vim-projectionist'
  use 'tpope/vim-surround'
  use 'tpope/vim-endwise'
  use 'tpope/vim-repeat'
  use 'tpope/vim-rsi'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-dispatch'
  use 'hrsh7th/nvim-compe'
  use {
    'steelsojka/pears.nvim',
    config = function()
      require('pears').setup()
    end
  }
  use 'folke/tokyonight.nvim'
  use 'kabouzeid/nvim-lspinstall'
  use 'machakann/vim-highlightedyank'
  use 'wellle/tmux-complete.vim'
  use 'wakatime/vim-wakatime'
  use 'https://gitlab.com/code-stats/code-stats-vim.git'
  use 'sickill/vim-pasta'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
    "folke/lsp-trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
	fold_open = "v", -- icon used for open folds
	fold_closed = ">", -- icon used for closed folds
	indent_lines = false, -- add an indent guide below the fold icons
	signs = {
	  -- icons / text used for a diagnostic
	  error = "error",
	  warning = "warn",
	  hint = "hint",
	  information = "info"
	},
	use_lsp_diagnostic_signs = false
      }
    end
  }
end)
