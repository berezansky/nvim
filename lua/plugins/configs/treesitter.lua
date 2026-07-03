local treesitterconfigs = require 'nvim-treesitter.configs'

treesitterconfigs.setup {
  ensure_installed = {
    'lua',
    'vim',
    'vimdoc',
    'query',
    'go',
    'gomod',
    'gowork',
    'gosum',
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

