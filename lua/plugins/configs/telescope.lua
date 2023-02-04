require 'keys/alias'

local telescope = require 'telescope'

nm('gd', '<cmd>Telescope lsp_definitions<CR>') -- Объявления в LSP
nm('gi', '<cmd>Telescope lsp_implementations<CR>') -- Имлпементация
nm('gr', '<cmd>Telescope lsp_references<CR>') -- Имлпементация
nm('<leader>ff', '<cmd>Telescope find_files<CR>') -- Поиск файлов
nm('<leader>fb', '<cmd>Telescope git_branches<CR>') -- Ветки в Git
nm('<leader>fg', '<cmd>Telescope live_grep<CR>') -- Поиск строки
nm('<leader>d', '<cmd>Telescope diagnostics<CR>')

telescope.setup {
    pickers = {
        find_files = {
            theme = 'dropdown'
        },
        diagnostics = {
            theme = 'dropdown'
        },
        live_grep = {
            theme = 'dropdown'
        },
        lsp_definitions = {
            theme = 'dropdown'
        },
        lsp_implementations = {
            theme = 'dropdown'
        },
        lsp_references = {
            theme = 'dropdown'
        }

    },
    extensions = {
        ['ui-select'] = {
            require 'telescope.themes'.get_dropdown {}
        }
    }
}

telescope.load_extension('ui-select')
