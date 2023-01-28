local lspInstaller = require'nvim-lsp-installer'
local lspConfig = require'lspconfig'

lspInstaller.setup({
    automatic_installation = true,
    ui = {
        border = "1px solid red",
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Возможности редактора
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Добавляем возможность использовать сниппеты
capabilities.textDocument.completion.completionItem.snippetSupport = true

for _, server in ipairs(lspInstaller.get_installed_servers()) do
  lspConfig[server.name].setup{
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  }
end
