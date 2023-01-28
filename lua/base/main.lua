local opt = vim.opt
local g = vim.g
local set = vim.api.nvim_set_keymap

-----------------------------------------------------------
-- Главные
-----------------------------------------------------------
-- Направление перевода с русского на английский
g.translate_source = 'ru'
g.translate_target = 'en'
-- Установка <leader>
set('n', '<Space>', '', {})
g.mapleader = ' '

opt.clipboard = 'unnamedplus'        -- Копировать в буфер обмена
opt.colorcolumn = '120'              -- Разделитель на 120 символов
opt.cursorline = true                -- Подсветка строки с курсором
opt.spelllang= { 'en_us', 'ru' }     -- Словари рус eng
opt.number = true                    -- Включаем нумерацию строк
opt.relativenumber = true            -- Вкл. относительную нумерацию строк
opt.so=999                           -- Курсор всегда в центре экрана
opt.undofile = true                  -- Возможность отката назад
opt.splitright = true                -- vertical split вправо
opt.splitbelow = true                -- horizontal split вниз
opt.completeopt = 'menuone,noselect' -- Автодополнение (встроенное в Neovim)
