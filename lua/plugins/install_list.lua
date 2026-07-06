local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local out = vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })

  if vim.v.shell_error ~= 0 then
    error('Failed to install lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Color schemes
  { 'shaunsingh/solarized.nvim', lazy = false, priority = 1000 },
  { 'folke/tokyonight.nvim', lazy = true },

  -- Icons
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- StatusLine
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'auto' },
      })
    end,
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function() require 'plugins.configs.lspconfig' end,
  },

  {
    'mason-org/mason.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },

  {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason-org/mason.nvim', 'neovim/nvim-lspconfig' },
    config = function() require 'plugins.configs.mason-lspconfig' end,
  },

  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require 'plugins.configs.none-ls'
    end,
  },

  -- LSP progress
  {
    'j-hui/fidget.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins.configs.fidget'
    end,
  },

  -- Auto close tag
  {
    'windwp/nvim-ts-autotag',
    ft = { 'html', 'htmldjango', 'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'xml' },
    config = function()
      require('nvim-ts-autotag').setup({})
    end,
  },

  -- TreeSitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = function()
      local languages = require('plugins.treesitter_languages')
      local treesitter = require('nvim-treesitter')

      treesitter.install(languages.parsers):wait(300000)
      treesitter.update(languages.parsers):wait(300000)
    end,
    config = function()
      require 'plugins.configs.treesitter'
    end,
  },

  -- Colorized
  {
    'norcalli/nvim-colorizer.lua',
    cmd = { 'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer', 'ColorizerReloadAllBuffers', 'ColorizerToggle' },
    config = function()
      require 'plugins.configs.colorizer'
    end,
  },

  -- Symbols outline
  {
    'simrat39/symbols-outline.nvim',
    cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen', 'SymbolsOutlineClose' },
    config = function()
      require 'plugins.configs.symbols-outline'
    end,
  },

  -- Completion
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
    },
    config = function()
      require 'plugins.configs.cmp'
    end,
  },

  -- Completion icons
  {
    'onsails/lspkind-nvim',
    lazy = false,
    config = function()
      require 'plugins.configs.lspkind'
    end,
  },

  -- Navigation
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require 'plugins.configs.neo-tree'
    end,
  },

  -- Documentation
  {
    'danymat/neogen',
    cmd = 'Neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require 'plugins.configs.neogen'
    end,
  },

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require 'plugins.configs.gitsigns'
    end,
  },

  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G', 'Gdiffsplit', 'Gvdiffsplit', 'Gwrite', 'Gsplit', 'Gvsplit', 'GcLog' },
    config = function()
      require 'plugins.configs.fugitive'
    end,
  },

  -- Comments
  {
    'b3nj5m1n/kommentary',
    event = 'BufReadPost',
    config = function()
      require 'plugins.configs.kommentary'
    end,
  },

  -- Auto close brackets and quotes
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require 'plugins.configs.autopairs'
    end,
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function() require 'plugins.configs.telescope' end,
  },

  -- Codex
  {
    'rhart92/codex.nvim',
    config = function()
      require 'plugins.configs.codex'
    end,
  },

  -- Java
  {
    'mfussenegger/nvim-jdtls',
    ft = { 'java' },
  },

  -- StartScreen
  {
    'mhinz/vim-startify',
    lazy = false,
    config = function()
      require 'plugins.configs.startify'
    end,
  },

  -- Useful hotkeys
  { 'tpope/vim-unimpaired', lazy = false },

  -- Text objects around tags/brackets
  { 'tpope/vim-surround', lazy = false },

  -- Diagnostics
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics' },
      { '<leader>xX', '<cmd>Trouble diagnostics_buffer toggle<cr>', desc = 'Buffer diagnostics' },
      { '<leader>xs', '<cmd>Trouble symbols toggle pinned=true<cr>', desc = 'Document symbols' },
      { '<leader>xl', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP list' },
      { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location list' },
    },
    config = function()
      require 'plugins.configs.trouble'
    end,
  },

  -- Database
  {
    'nanotee/sqls.nvim',
    ft = { 'sql', 'mysql', 'plsql' },
  },
  {
    'tpope/vim-dadbod',
    cmd = { 'DB', 'DBUI', 'DBUIToggle', 'DBUIFindBuffer', 'DBUIRenameBuffer', 'DBUILastQueryInfo' },
    config = function()
      require 'plugins.configs.dadbod'
    end,
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    cmd = { 'DBUI', 'DBUIToggle', 'DBUIFindBuffer', 'DBUIRenameBuffer', 'DBUILastQueryInfo' },
    dependencies = { 'tpope/vim-dadbod' },
  },
}, {
  checker = { enabled = false },
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
