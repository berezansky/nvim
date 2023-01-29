require'keys/alias'

local neogen = require'neogen'

nm('<leader>Nf', "<cmd>Neogen func<cr>")
nm('<leader>Nt', "<cmd>Neogen type<cr>")
nm('<leader>Nc', "<cmd>Neogen class<cr>")

neogen.setup{
 enabled = true,
 input_after_comment = true,
}
