-- TS_LS
vim.lsp.config.ts_ls = {
    flags = {
        debounce_text_changes = 500,
    },
    init_options = {
        maxTsServerMemory = 8192,
        preferences = {
            includePackageJsonAutoImports = "off",
        },
    },
    settings = {
        typescript = {
            tsserver = {
                maxTsServerMemory = 8192,
            },
            preferences = {
                includePackageJsonAutoImports = "off",
            },
            suggest = {
                includeAutomaticOptionalChainCompletions = false,
            },
        },
        javascript = {
            preferences = {
                includePackageJsonAutoImports = "off",
            },
            suggest = {
                includeAutomaticOptionalChainCompletions = false,
            },
        },
    },
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        vim.keymap.set("n", "<leader>ai", function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.addMissingImports.ts" },
              diagnostics = {},
            },
            filter = function(action)
              return action.kind == "source.addMissingImports.ts"
            end,
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
vim.lsp.config.eslint = {
    flags = {
        debounce_text_changes = 700,
    },
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end,
    settings = {
        format = false,
        quiet = true,
        run = "onSave",
        provideLintTask = false,
        codeActionOnSave = {
            enable = false,
            mode = "all",
        },
        probe = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
        },
        problems = {
            shortenToSingleLine = true,
        },
        execArgv = {
            "--max-old-space-size=4096",
        },
        workingDirectory = {
            mode = "location",
        },
    },
}
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
