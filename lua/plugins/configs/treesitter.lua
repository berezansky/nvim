local treesitterconfigs = require'nvim-treesitter.configs'
local treesitter = require'nvim-treesitter'

treesitter.setup{}

treesitterconfigs.setup{
  highlight = {
    enable = true
  }
}


