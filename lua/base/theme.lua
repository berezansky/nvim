local M = {}

local check_interval_ms = 30000
local last_system_dark = nil
local timer = nil

vim.opt.termguicolors = true

local function is_macos()
  return vim.loop.os_uname().sysname == 'Darwin'
end

local function refresh_lualine()
  local ok, lualine = pcall(require, 'lualine')
  if not ok then
    return
  end

  lualine.setup({
    options = { theme = 'auto' },
  })
end

function M.system_is_dark()
  if not is_macos() then
    return false
  end

  local result = vim.fn.system({ 'defaults', 'read', '-g', 'AppleInterfaceStyle' })
  return vim.v.shell_error == 0 and result:match('Dark') ~= nil
end

function M.light_theme()
  vim.opt.background = 'light'
  vim.cmd.colorscheme('catppuccin-latte')
  refresh_lualine()
end

M.solarized_light = M.light_theme

function M.tokyonight_dark()
  vim.opt.background = 'dark'
  vim.cmd.colorscheme('tokyonight-storm')
  refresh_lualine()
end

function M.apply_system_theme()
  local system_dark = M.system_is_dark()
  last_system_dark = system_dark

  if system_dark then
    M.tokyonight_dark()
  else
    M.light_theme()
  end
end

function M.sync_if_system_changed()
  local system_dark = M.system_is_dark()

  if system_dark ~= last_system_dark then
    last_system_dark = system_dark

    if system_dark then
      M.tokyonight_dark()
    else
      M.light_theme()
    end
  end
end

function M.start_auto_sync()
  if timer then
    return
  end

  timer = vim.loop.new_timer()
  timer:start(check_interval_ms, check_interval_ms, function()
    vim.schedule(M.sync_if_system_changed)
  end)
end

M.apply_system_theme()
M.start_auto_sync()

return M
