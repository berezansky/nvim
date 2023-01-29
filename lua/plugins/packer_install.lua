vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Color scheme
  use 'folke/tokyonight.nvim'

  -- Icons
  use 'nvim-tree/nvim-web-devicons'

  -- StatusLine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = { theme = 'tokyonight' }
      })
    end
  }

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    config = function() require 'plugins.configs.lspconfig' end
  }

  use 'williamboman/mason.nvim'

  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require 'plugins.configs.mason'
    end
  }

  -- Прогресс LSP
  use {
    'j-hui/fidget.nvim',
    config = function()
      require 'plugins.configs.fidget'
    end
  }

  -- Auto close tag
  use {
    'windwp/nvim-ts-autotag',
    config = function()
      require 'nvim-ts-autotag'.setup {}
    end
  }

  -- TreeSitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'plugins.configs.treesitter'
    end
  }


  -- Colorized
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup {}
    end
  }

  -- Symbols outline
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require 'plugins.configs.symbols-outline'
    end,
  }

  -- Автодополнение
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua'
    },
    config = function()
      require 'plugins.configs.cmp'
    end
  }

  -- Иконки для автодополнения
  use {
    'onsails/lspkind-nvim',
    config = function()
      require 'plugins.configs.lspkind'
    end
  }

  -- Навигация
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch   = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config   = function()
      require 'plugins.configs.neo-tree'
    end
  }

  -- Документация
  use {
    "danymat/neogen",
    requires = "nvim-treesitter/nvim-treesitter",
    tag = "*",
    config = function()
      require 'plugins.configs.neogen'
    end,
  }

  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use 'tpope/vim-fugitive'

  -- Комментарии
  use {
    'b3nj5m1n/kommentary',
    config = function()
      require 'plugins.configs.kommentary'
    end,
  }

  -- Плагин для автодополнения скобок и кавычек
  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'plugins.configs.autopairs'
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function() require 'plugins.configs.telescope' end
  }

  use {
    'hood/popui.nvim',
    config = function() require 'plugins.configs.popui' end
  }


end)
