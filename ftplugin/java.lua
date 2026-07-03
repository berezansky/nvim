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

-- Workaround for Neovim 0.11.3 typo in client/unregisterCapability handler
-- (`unregisterations` instead of `unregistrations`) which can crash on jdtls.
vim.lsp.handlers["client/registerCapability"] = function(_, params, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return vim.NIL
  end
  local regs = params and params.registrations or {}
  if type(regs) ~= "table" then
    regs = {}
  end
  client:_register(regs)
  for bufnr in pairs(client.attached_buffers) do
    vim.lsp._set_defaults(client, bufnr)
  end
  return vim.NIL
end

vim.lsp.handlers["client/unregisterCapability"] = function(_, params, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return vim.NIL
  end
  local unregs = params and (params.unregistrations or params.unregisterations) or {}
  if type(unregs) ~= "table" then
    unregs = {}
  end
  client:_unregister(unregs)
  return vim.NIL
end

local HOME = os.getenv("HOME")
local WORKSPACE_PATH = HOME .. "/.cache/jdtls-workspace/"

local function latest_homebrew_jdk(pattern)
  local homes = vim.fn.glob(pattern, true, true)
  table.sort(homes)
  return homes[#homes]
end

local java17_home = latest_homebrew_jdk("/opt/homebrew/Cellar/openjdk@17/*/libexec/openjdk.jdk/Contents/Home")
local any_homebrew_jdk = latest_homebrew_jdk("/opt/homebrew/Cellar/openjdk/*/libexec/openjdk.jdk/Contents/Home")
local jdtls_java_home = latest_homebrew_jdk("/opt/homebrew/Cellar/openjdk@21/*/libexec/openjdk.jdk/Contents/Home")
  or any_homebrew_jdk
  or os.getenv("JAVA_HOME")
local jdtls_java_executable = jdtls_java_home and (jdtls_java_home .. "/bin/java") or "java"

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
    vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls/bin/jdtls"),
    "--java-executable=" .. jdtls_java_executable,
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  -- 🔥 ВАЖНО
  capabilities = capabilities,

  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },

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

if java17_home then
  config.settings.java.home = java17_home
  config.settings.java.configuration = {
    runtimes = {
      {
        name = "JavaSE-17",
        path = java17_home,
        default = true,
      },
    },
  }
end

jdtls.start_or_attach(config)
require("jdtls.setup").add_commands()
