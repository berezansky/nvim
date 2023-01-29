require 'keys.alias'

vim.ui.select = require "popui.ui-overrider"
vim.ui.input = require "popui.input-overrider"

nm('<leader>d', ':lua require"popui.diagnostics-navigator"()<CR>')

vim.cmd [[ let g:popui_border_style = "double" ]]
