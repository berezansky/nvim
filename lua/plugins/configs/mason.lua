local masonConfig = require'mason-lspconfig'
local mason = require'mason'

mason.setup{}
masonConfig.setup{}

masonConfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {}
  end,
}
