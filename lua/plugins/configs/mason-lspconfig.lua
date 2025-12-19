-- TS_LS
vim.lsp.config.ts_ls = {
  on_attach = function(client, bufnr)
    vim.keymap.set("n", "<leader>ai", function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.addMissingImports.ts" },
        },
        apply = true,
      })
    end, {
      buffer = bufnr,
      desc = "Add all missing imports",
    })
  end,
}

vim.lsp.enable("ts_ls")

-- ESLINT
vim.lsp.config.eslint = {}
vim.lsp.enable("eslint")
vim.keymap.set("n", "<leader>ef", function()
  vim.lsp.buf.code_action({
    context = {
      only = { "source.fixAll.eslint" },
    },
    apply = true,
  })
end, { desc = "ESLint Fix All" })

-- SQLS
vim.lsp.config.sqls = {
  on_attach = function(client, bufnr)
    require("sqls").on_attach(client, bufnr)
  end,
  settings = {
    sqls = {
      connections = {
        {
          driver = "postgresql",
          dataSourceName = os.getenv("DBSourceName"),
        },
      },
    },
  },
}

vim.lsp.enable("sqls")

-- MASON
require("mason").setup()
require("mason-lspconfig").setup()
