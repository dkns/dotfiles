local function initialize_package_manager()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end

  vim.opt.runtimepath:prepend(lazypath)
end

initialize_package_manager()

return {
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'tpope/vim-commentary',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'airblade/vim-rooter',
  'folke/tokyonight.nvim',
  { 'nvim-treesitter/nvim-treesitter',          build = ':TSUpdate' },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require('gitsigns').setup {} end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  'nvim-telescope/telescope-project.nvim',
  'elianiva/telescope-npm.nvim',
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'tami5/sqlite.lua' }
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup()
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'petertriho/cmp-git'
    }
  },
  {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup({}) end
  },
  {
    'windwp/nvim-ts-autotag',
    config = function() require('nvim-ts-autotag').setup() end
  },
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim"
    },
  },
  {
    'j-hui/fidget.nvim',
    config = function() require('fidget').setup({}) end
  },
  'mg979/vim-visual-multi',
  'vim-test/vim-test',
  'christoomey/vim-tmux-navigator',
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup({
        sources = {
          require('null-ls').builtins.formatting.lua_format,
          require('null-ls').builtins.formatting.prettier,
        }
      })
    end
  },
  {
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
  },
  'antoinemadec/FixCursorHold.nvim',
  {
    "nvim-neotest/neotest",
    dependencies = {
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
  },
  'mfussenegger/nvim-dap',
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = {
      "mfussenegger/nvim-dap"
    },
    config = function()
      require("dap-vscode-js").setup({
        node_path = "node",
        debugger_path = os.getenv("HOME") .. "/.DAP/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })

      local exts = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        -- using pwa-chrome
        "vue",
        "svelte",
      }

      for _, ext in ipairs(exts) do
        require("dap").configurations[ext] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node)",
            cwd = vim.fn.getcwd(),
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with ts-node)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "--loader", "ts-node/esm" },
            runtimeExecutable = "node",
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "run", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with jest)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
            runtimeExecutable = "node",
            args = { "${file}", "--coverage", "false" },
            rootPath = "${workspaceFolder}",
            sourceMaps = true,
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with vitest)",
            cwd = vim.fn.getcwd(),
            program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
            args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
            autoAttachChildProcesses = true,
            smartStep = true,
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test Current File (pwa-node with deno)",
            cwd = vim.fn.getcwd(),
            runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
            runtimeExecutable = "deno",
            attachSimplePort = 9229,
          },
          {
            type = "pwa-chrome",
            request = "attach",
            name = "Attach Program (pwa-chrome, select port)",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            port = function()
              return vim.fn.input("Select port: ", 9222)
            end,
            webRoot = "${workspaceFolder}",
          },
          -- {
          --   type = "pwa-node",
          --   request = "attach",
          --   name = "Attach Program (pwa-node, select pid)",
          --   cwd = vim.fn.getcwd(),
          --   processId = dap_utils.pick_process,
          --   skipFiles = { "<node_internals>/**" },
          -- },
        }
      end
    end
  }
}
