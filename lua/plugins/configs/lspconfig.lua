require 'keys/alias'

nm('K', '<cmd>lua vim.lsp.buf.hover()<CR>') -- Ховер для объекта
nm('gf', '<cmd>lua vim.lsp.buf.format{async = true}<CR>') -- Форматировать документ
nm('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- Действия с кодом
nm('gR', '<cmd>lua vim.lsp.buf.rename()<CR>') -- Переименовать объект
nm ('<leader>D', '<cmd>lua vim.diagnostic.open_float()<CR>') -- Открыть попап диагностики
nm ('<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>') -- Открыть попап с помощью
