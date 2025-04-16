require'keys.alias'
require'keys.plugins'

im('jj', '<Esc>')
nm('<leader>w', '<cmd>write<CR>')
nm('<leader>q', '<cmd>quit<CR>')
nm('<C-k>', '<C-w><Up>')
nm('<C-j>', '<C-w><Down>')
nm('<C-l>', '<C-w><Right>')
nm('<C-h>', '<C-w><Left>')
nm('<leader>ef', '<cmd>EslintFixAll<CR>')
nm('<leader>cs', '<cmd>colorscheme solarized<CR>')
nm('<leader>ct', '<cmd>colorscheme tokyonight-storm<CR>')

-- Clear Search
nm('//', '<cmd>:noh<cr>')

