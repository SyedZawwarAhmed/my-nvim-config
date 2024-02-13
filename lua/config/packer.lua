-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use { "catppuccin/nvim", as = "catppuccin" }
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('theprimeagen/harpoon')
  use('tpope/vim-fugitive')
  use('lewis6991/gitsigns.nvim')
  use('mbbill/undotree')

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      --- Uncomment the two plugins below if you want to manage the language servers from neovim
      --- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' }
    }
  }

  use {
    'akinsho/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
  }

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use('vim-airline/vim-airline')

  use { 'neoclide/coc.nvim', branch = 'release' }

  use { "gaelph/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } }

  use("tpope/vim-commentary")

  use('JoosepAlviste/nvim-ts-context-commentstring')

  use("nvim-tree/nvim-tree.lua")

  use("nvim-tree/nvim-web-devicons")

  use("tpope/vim-surround")

  use {
    'mattn/emmet-vim',
    ft = { 'svelte', 'html', 'elixir', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
    config = function()
      vim.g.user_emmet_settings = {
        ['javascript.jsx'] = {
          extends = 'jsx',
        },
        ['javascript.javascriptreact'] = {
          extends = 'jsx',
        },
        ['typescript.typescriptreact'] = {
          extends = 'jsx',
        },
        elixir = {
          extends = 'html'
        },
        eelixir = {
          extends = 'html'
        }
      }
      vim.g.user_emmet_mode = 'inv'
    end
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }
end)
