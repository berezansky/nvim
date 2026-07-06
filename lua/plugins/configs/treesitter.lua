local treesitter = require('nvim-treesitter')
local languages = require('plugins.treesitter_languages')

treesitter.setup({
  install_dir = vim.fn.stdpath('data') .. '/site',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = languages.filetypes,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
