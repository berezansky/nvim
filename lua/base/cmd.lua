local cmd = vim.cmd
local exec = vim.api.nvim_exec

-----------------------------------------------------------
-- Настройка команд vim
-----------------------------------------------------------
cmd([[
filetype indent plugin on
syntax enable
]])
-- Отключение автокомментирования новых строк
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- Удалить маркер длины строки для указанных типов файлов 
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- Установить 2 пробела для указанных типов файлов
cmd [[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,htmljinja setlocal shiftwidth=2 tabstop=2
]]
-- С этой строкой отлично форматирует html файл, который содержит jinja2
cmd[[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]
-- Запоминает где nvim последний раз редактировал файл
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)
