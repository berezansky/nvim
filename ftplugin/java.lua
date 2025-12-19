local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- 🔥 FIX for Neovim 0.11 + jdtls
capabilities.workspace = capabilities.workspace or {}
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = false,
}

local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end

local HOME = os.getenv("HOME")
local WORKSPACE_PATH = HOME .. "/.cache/jdtls-workspace/"
local JDTLS_LOCATION = HOME .. "/.local/share/nvim/mason/packages/jdtls/"
local SYSTEM = "mac"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- 🔥 правильная проверка
if not root_dir then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Debug / Test bundles
local bundles = {}
local mason_path = HOME .. "/.local/share/nvim/mason/"
vim.list_extend(
  bundles,
  vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n")
)
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
    "\n"
  )
)

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "-javaagent:" .. HOME .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
    "-jar",
    vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    JDTLS_LOCATION .. "/config_" .. SYSTEM,
    "-data",
    workspace_dir,
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  },

  root_dir = root_dir,

  -- 🔥 ВАЖНО
  capabilities = capabilities,

  settings = {
    java = {
      -- ❗ РЕКОМЕНДУЮ 17
      home = "/opt/homebrew/Cellar/openjdk@17/17.0.6/libexec/openjdk.jdk/Contents/Home",

      eclipse = { downloadSources = true },
      maven = { downloadSources = true },

      configuration = {
        runtimes = {
          {
            name = "JavaSE-17",
            path = "/opt/homebrew/Cellar/openjdk@17/17.0.6/libexec/openjdk.jdk/Contents/Home",
            default = true,
          },
        },
      },

      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },

      format = {
        enabled = true,
        url = HOME .. "/.local/share/nvim/mason/packages/google-java-format/google-java-format",
        profile = "GoogleStyle",
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    bundles = bundles, -- 🔥 а не {}
    extendedClientCapabilities = extendedClientCapabilities,
  },
}

jdtls.start_or_attach(config)
require("jdtls.setup").add_commands()
