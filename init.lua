if vim.lsp and vim.lsp.get_clients then
  vim.lsp.buf_get_clients = function(bufnr)
    return vim.lsp.get_clients({ bufnr = bufnr or 0 })
  end
end

if vim.islist then
  vim.tbl_islist = vim.islist
end

if not vim.env.JAVA_HOME or vim.env.JAVA_HOME == "" then
  local java21_homes = vim.fn.glob("/opt/homebrew/Cellar/openjdk@21/*/libexec/openjdk.jdk/Contents/Home", true, true)
  table.sort(java21_homes)
  local latest_java21 = java21_homes[#java21_homes]
  if latest_java21 then
    vim.env.JAVA_HOME = latest_java21
    vim.env.PATH = latest_java21 .. "/bin:" .. vim.env.PATH
  end
end

require'plugins.install_list';
require'base.settings'
require'keys.keymaps';
