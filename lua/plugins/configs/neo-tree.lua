require'keys.alias'

local neotree = require'neo-tree'

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

nm('<leader>nf', '<cmd>Neotree filesystem<cr>')
nm('<leader>nb', '<cmd>Neotree buffers<cr>')
nm('<leader>ng', '<cmd>Neotree git_status<cr>')

neotree.setup{
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  window = {
    position = 'float',
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['o'] = 'open',
    }
  }
}
