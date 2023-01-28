require'keys.alias'
local trouble = require('trouble')

trouble.setup{

  mapping = {
    nm('<leader>tt', '<cmd>TroubleToggle<cr>'),
    nm('<leader>tq', '<cmd>TroubleToggle quickfix<cr>'),
    nm('<leader>td', '<cmd>TroubleToggle document_diagnostics<cr>'),
  }

}
