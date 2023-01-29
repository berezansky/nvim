require'keys.alias'

local neotree = require'neo-tree'

nm('<leader>nf', '<cmd>NeoTreeFloatToggle filesystem<cr>')
nm('<leader>nb', '<cmd>NeoTreeFloatToggle buffers<cr>')
nm('<leader>ng', '<cmd>NeoTreeFloatToggle git_status<cr>')

neotree.setup{
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  window = {
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['o'] = 'open',
    }
  }
}
