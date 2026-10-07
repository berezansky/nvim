require 'keys/alias'

local previews = {}
local origin_win
local request_id = 0

local function close_preview()
  request_id = request_id + 1
  local preview = table.remove(previews)
  if preview then
    preview.win:close()
  end

  local previous = previews[#previews]
  local win = previous and previous.win.win or origin_win
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_set_current_win(win)
  end
  if #previews == 0 then
    origin_win = nil
  end
end

local function close_previews()
  while #previews > 0 do
    close_preview()
  end
end

local function preview_definition(item)
  local bufnr = item.bufnr or vim.fn.bufadd(item.filename)
  vim.fn.bufload(bufnr)

  if #previews == 0 then
    origin_win = vim.api.nvim_get_current_win()
  end

  local win = Snacks.win({
    text = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false),
    ft = vim.bo[bufnr].filetype,
    width = 0.8,
    height = 0.8,
    zindex = 50 + #previews,
    border = 'rounded',
    title = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ':~:.'),
    enter = true,
    bo = { modifiable = false },
    wo = {
      number = true,
      cursorline = true,
      foldenable = false,
      wrap = true,
    },
    keys = {
      q = close_previews,
      ['<Esc>'] = close_preview,
      o = function(preview)
        local cursor = vim.api.nvim_win_get_cursor(preview.win)
        close_previews()
        vim.bo[bufnr].buflisted = true
        vim.api.nvim_win_set_buf(0, bufnr)
        vim.api.nvim_win_set_cursor(0, cursor)
      end,
    },
    on_win = function(win)
      vim.api.nvim_win_set_cursor(win.win, { item.lnum, item.col - 1 })
      vim.api.nvim_win_call(win.win, function()
        vim.cmd('normal! zt')
      end)
    end,
  })
  previews[#previews + 1] = { win = win, bufnr = bufnr }
end

vim.keymap.set('n', 'K', function()
  local win = vim.api.nvim_get_current_win()
  local preview = previews[#previews]
  local bufnr = preview and preview.win.win == win and preview.bufnr or vim.api.nvim_get_current_buf()
  local method = 'textDocument/definition'
  if #vim.lsp.get_clients({ bufnr = bufnr, method = method }) == 0 then
    vim.notify('Нет LSP для просмотра определения', vim.log.levels.WARN)
    return
  end

  request_id = request_id + 1
  local current_request = request_id
  vim.lsp.buf_request_all(bufnr, method, function(client)
    local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
    params.textDocument = vim.lsp.util.make_text_document_params(bufnr)
    return params
  end, function(results)
    if current_request ~= request_id or not vim.api.nvim_win_is_valid(win) then
      return
    end

    local items = {}
    for client_id, result in pairs(results) do
      if result.result then
        local client = vim.lsp.get_client_by_id(client_id)
        local locations = vim.islist(result.result) and result.result or { result.result }
        vim.list_extend(items, vim.lsp.util.locations_to_items(locations, client.offset_encoding))
      end
    end

    if #items == 0 then
      vim.notify('Определение не найдено', vim.log.levels.INFO)
      return
    end
    if #items == 1 then
      preview_definition(items[1])
      return
    end

    vim.ui.select(items, {
      prompt = 'Выберите определение',
      format_item = function(item)
        return vim.fn.fnamemodify(item.filename, ':~:.') .. ':' .. item.lnum .. ' ' .. item.text
      end,
    }, function(item)
      if item and current_request == request_id then
        preview_definition(item)
      end
    end)
  end)
end, { noremap = true, silent = true, desc = 'Просмотр определения' })
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
