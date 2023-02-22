local masonConfig = require 'mason-lspconfig'
local mason = require 'mason'

mason.setup {}
masonConfig.setup {}

masonConfig.setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {}
    end,

    ['jdtls'] = function()
        return
    end,
}

require("lspconfig").sqls.setup {
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
