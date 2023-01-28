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

  -- TreeSitter
  use 'nvim-treesitter/nvim-treesitter'

  -- LSP
  use "neovim/nvim-lspconfig"
  use {
    "williamboman/nvim-lsp-installer",
    config = function () require'plugins.configs.lsp-installer' end
  }

  -- Прогресс LSP
	use {
		'j-hui/fidget.nvim',
		config = function()
      require'plugins.configs.fidget'
		end
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
			require'plugins.configs.cmp'
		end
	}

  -- Иконки для автодополнения
	use {
		'onsails/lspkind-nvim',
		config = function()
			require'plugins.configs.lspkind'
		end
	}

  -- Просмотр проблем в файле
  use {
		"folke/trouble.nvim",
		requires = 'nvim-tree/nvim-web-devicons',
		config = function()
		  require'plugins.configs.trouble'	
		end,
	}

  -- Навигация
	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires  = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
    config = function()
      require'plugins.configs.neo-tree'
    end
	}

end)
