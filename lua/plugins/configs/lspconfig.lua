require 'keys/alias'

nm('K', '<cmd>lua vim.lsp.buf.hover()<CR>') -- Ховер для объекта
vim.keymap.set('n', 'gf', function()
  local ft = vim.bo.filetype
  local preferred = {
    go = 'gopls',
    gomod = 'gopls',
    gowork = 'gopls',
    gosum = 'gopls',
    java = 'jdtls',
    javascript = 'null-ls',
    javascriptreact = 'null-ls',
    typescript = 'null-ls',
    typescriptreact = 'null-ls',
  }

  local preferred_client = preferred[ft]
  if preferred_client then
    vim.lsp.buf.format({
      async = true,
      filter = function(client)
        return client.name == preferred_client
      end,
    })
    return
  end

  vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })
nm('ga', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- Действия с кодом
nm('gR', '<cmd>lua vim.lsp.buf.rename()<CR>') -- Переименовать объект
nm ('<leader>D', '<cmd>lua vim.diagnostic.open_float()<CR>') -- Открыть попап диагностики
nm ('<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>') -- Открыть попап с помощью
