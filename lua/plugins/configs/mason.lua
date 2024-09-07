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
