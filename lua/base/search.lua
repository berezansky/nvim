local opt = vim.opt
local g = vim.g

-----------------------------------------------------------
-- Поиск
-----------------------------------------------------------
-- Игнорировать регистр при поиске
opt.ignorecase = true
-- Не игнорировать регистр, если есть символы в верхнем регистре
opt.smartcase = true
-- Подсвечивать найденные текстовые объекты
opt.showmatch = true