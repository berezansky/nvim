require('trouble').setup({
  auto_close = false,
  auto_open = false,
  auto_preview = true,
  auto_refresh = true,
  auto_jump = false,
  focus = false,
  follow = true,
  indent_guides = true,
  max_items = 200,
  multiline = true,
  restore = true,
  warn_no_results = true,
  open_no_results = false,

  keys = {
    ['?'] = 'help',
    r = 'refresh',
    R = 'toggle_refresh',
    q = 'close',
    o = 'jump_close',
    ['<esc>'] = 'cancel',
    ['<cr>'] = 'jump',
    ['<c-s>'] = 'jump_split',
    ['<c-v>'] = 'jump_vsplit',
    p = 'preview',
    P = 'toggle_preview',
    zo = 'fold_open',
    zO = 'fold_open_recursive',
    zc = 'fold_close',
    zC = 'fold_close_recursive',
    za = 'fold_toggle',
    zA = 'fold_toggle_recursive',
    zm = 'fold_more',
    zM = 'fold_close_all',
    zr = 'fold_reduce',
    zR = 'fold_open_all',
    gb = {
      action = function(view)
        view:filter({ buf = 0 }, { toggle = true })
      end,
      desc = 'Toggle Current Buffer Filter',
    },
    s = {
      action = function(view)
        local filter = view:get_filter('severity')
        local severity = ((filter and filter.filter.severity or 0) + 1) % 5

        view:filter({ severity = severity }, {
          id = 'severity',
          template = '{hl:Title}Filter:{hl} {severity}',
          del = severity == 0,
        })
      end,
      desc = 'Toggle Severity Filter',
    },
  },

  modes = {
    diagnostics = {
      auto_open = false,
      auto_close = false,
      win = {
        type = 'split',
        position = 'bottom',
        size = 10,
      },
    },
    diagnostics_buffer = {
      mode = 'diagnostics',
      filter = { buf = 0 },
      win = {
        type = 'split',
        position = 'bottom',
        size = 10,
      },
    },
    symbols = {
      mode = 'lsp_document_symbols',
      focus = false,
      auto_preview = true,
      multiline = false,
      format = '{kind_icon} {symbol.name} {pos}',
      filter = function(items)
        local useful_kinds = {
          Class = true,
          Constant = true,
          Constructor = true,
          Enum = true,
          EnumMember = true,
          Function = true,
          Interface = true,
          Method = true,
          Module = true,
          Namespace = true,
          Object = true,
          Package = true,
          Struct = true,
          Trait = true,
          TypeParameter = true,
          Variable = true,
        }

        return vim.tbl_filter(function(item)
          if item.ft == 'help' or item.ft == 'markdown' then
            return true
          end

          local symbol = item.symbol or {}
          local name = symbol.name or item.text or ''

          if name:lower():find('callback', 1, true) then
            return false
          end

          return useful_kinds[item.kind] == true
        end, items)
      end,
      win = {
        type = 'split',
        position = 'right',
        size = 42,
        wo = {
          wrap = false,
          linebreak = false,
          number = false,
          relativenumber = false,
          signcolumn = 'no',
        },
      },
    },
    lsp = {
      focus = false,
      win = {
        type = 'split',
        position = 'right',
        size = 50,
      },
    },
  },

  icons = {
    indent = {
      top = '│ ',
      middle = '├╴',
      last = '└╴',
      fold_open = ' ',
      fold_closed = ' ',
      ws = '  ',
    },
    folder_closed = ' ',
    folder_open = ' ',
    kinds = {
      Array = ' ',
      Boolean = '󰨙 ',
      Class = ' ',
      Constant = '󰏿 ',
      Constructor = ' ',
      Enum = ' ',
      EnumMember = ' ',
      Event = ' ',
      Field = ' ',
      File = ' ',
      Function = '󰊕 ',
      Interface = ' ',
      Key = ' ',
      Method = '󰊕 ',
      Module = ' ',
      Namespace = '󰦮 ',
      Null = ' ',
      Number = '󰎠 ',
      Object = ' ',
      Operator = ' ',
      Package = ' ',
      Property = ' ',
      String = ' ',
      Struct = '󰆼 ',
      TypeParameter = ' ',
      Variable = '󰀫 ',
    },
  },
})
