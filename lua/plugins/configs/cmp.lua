local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {
    completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged },
    },

    -- Клавиши, которые будут взаимодействовать в nvim-cmp
    mapping = {

        -- Вызов меню автодополнения
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-c>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),

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
    }, {
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        })
    }
}
