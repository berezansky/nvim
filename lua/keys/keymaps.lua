require'keys.alias'
require'keys.plugins'

im('jj', '<Esc>')
nm('<leader>w', '<cmd>write<CR>')
nm('<leader>q', '<cmd>quit<CR>')
nm('<C-k>', '<C-w><Up>')
nm('<C-j>', '<C-w><Down>')
nm('<C-l>', '<C-w><Right>')
nm('<C-h>', '<C-w><Left>')

-- Formatter
nm('<leader>l', '<cmd>Format<CR>')
