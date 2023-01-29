require'keys/alias'

local telescope = require'telescope'

nm('gd', '<cmd>Telescope lsp_definitions<CR>')                       -- Объявления в LSP
nm('gi', '<cmd>Telescope lsp_implementations<CR>')
nm('<leader>ff', '<cmd>Telescope find_files<CR>')                     -- Поиск файлов
nm('<leader>fb', '<cmd>Telescope git_branches<CR>')                   -- Ветки в Git
nm('<leader>fg', '<cmd>Telescope live_grep<CR>')                      -- Поиск строки

telescope.setup{

}
