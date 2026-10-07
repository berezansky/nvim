return {
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  input = { enabled = true },
  lazygit = {
    enabled = true,
    args = { '--screen-mode', 'full', 'status' },
    win = {
      keys = {
        lazygit_hide = {
          'q',
          function(self)
            self:hide()
          end,
          mode = 't',
          desc = 'Hide LazyGit',
        },
      },
    },
    config = {
      os = {
        edit = [[nvim --server "$NVIM" --remote-send '<C-\><C-n>q' && nvim --server "$NVIM" --remote {{filename}}]],
        editAtLine = [[nvim --server "$NVIM" --remote-send '<C-\><C-n>q' && nvim --server "$NVIM" --remote +{{line}} {{filename}}]],
        editInTerminal = false,
      },
      keybinding = {
        universal = {
          quit = 'Q',
          quitWithoutChangingDirectory = '<disabled>',
          edit = 'o',
          prevPage = '<ctrl+u>',
          nextPage = '<ctrl+d>',
          scrollUpMain = { '<pgup>', 'K' },
          scrollDownMain = { '<pgdown>', 'J' },
          openFile = '<disabled>',
        },
      },
    },
  },
  notifier = {
    enabled = true,
    timeout = 3000,
  },
  scratch = { enabled = true },
  terminal = { enabled = true },
  styles = {
    shell_terminal = {
      position = 'float',
      width = 0.85,
      height = 0.85,
      border = 'rounded',
      title = 'Terminal',
      keys = {
        term_normal = false,
        terminal_hide = {
          '<Esc>',
          function(self)
            vim.cmd('stopinsert')
            self:hide()
          end,
          mode = { 'n', 't' },
          desc = 'Hide terminal',
        },
        terminal_normal = {
          'jj',
          function()
            vim.cmd('stopinsert')
          end,
          mode = 't',
          desc = 'Exit terminal mode',
        },
      },
    },
  },

  dashboard = {
    enabled = true,
    width = 60,
    preset = {
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.dashboard.pick("oldfiles")' },
        { icon = ' ', key = 'c', desc = 'Config', action = ':lua Snacks.dashboard.pick("files", { cwd = vim.fn.stdpath("config") })' },
        { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
      header = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    },
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { section = 'startup' },
    },
  },
}
