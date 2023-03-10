local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup {
    snippet = {

        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require 'luasnip'.lsp_expand(args.body) -- Luasnip expand
        end,
    },

    -- Клавиши, которые будут взаимодействовать в nvim-cmp
    mapping = {

        -- Вызов меню автодополнения
        ['<C-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-i>'] = cmp.mapping.confirm({ select = true }),

        -- Используем <C-e> для того чтобы прервать автодополнение
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(), -- Прерываем автодополнение
            c = cmp.mapping.close(), -- Закрываем автодополнение
        }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    },

    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- LSP 👄
        { name = 'nvim_lsp_signature_help' }, -- Помощь при введении параметров в методах 🚁
        { name = 'luasnip' }, -- Luasnip 🐌
        { name = 'buffer' }, -- Буфферы 🐃
        { name = 'path' }, -- Пути 🪤
        { name = "emoji" }, -- Эмодзи 😳
        { name = "buffers" }
    }, {
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    }
}
