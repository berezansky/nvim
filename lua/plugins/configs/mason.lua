local masonConfig = require 'mason-lspconfig'
local mason = require 'mason'
local lspconfig = require 'lspconfig'

mason.setup {}
masonConfig.setup {}

masonConfig.setup_handlers {
    function(server_name)
        if server_name == "tsserver" then
            server_name = "ts_ls"
        end

        lspconfig[server_name].setup {}
    end,

    ['jdtls'] = function()
        return
    end,
}

lspconfig.sqls.setup {
    on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
    end,

    settings = {
        sqls = {
            connections = {
                {
                    driver = 'postgresql',
                    dataSourceName = os.getenv'DBSourceName',
                },
            },
        },
    }

}

lspconfig.gopls.setup {
    on_attach = function(_, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'GoFormat', function()
            vim.lsp.buf.format({ async = true })
        end, { desc = 'Format the buffer with LSP' })
    end,

}

lspconfig.ts_ls.setup {}

vim.api.nvim_set_keymap('n', '<leader>ai', '<cmd>lua AddAllMissingImports()<CR>', { noremap = true, silent = true })

function AddAllMissingImports()
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.addMissingImports.ts" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end
