local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "neovim/nvim-lspconfig"
plugin.dependencies = {
  "glepnir/lspsaga.nvim",
  "folke/trouble.nvim",
  "whitestarrain/lua-dev.nvim",
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
  },
}
plugin.loadEvent = "VeryLazy"

plugin.config = function()
  -- diagnostic config
  vim.diagnostic.config({
    float = {
      header = "",
      border = "single",
    },
  })
  -- diagnostic sign config
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- lsp handler
  -- help vim.lsp.util.open_floating_preview() and according to the lua source code
  local lsp = vim.lsp
  -- Global handlers.
  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
    border = "single",
    offset_x = 1,
    max_width = 100,
    max_height = 20,
  })

  lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
    border = "single",
    max_width = 100,
    max_height = 20,
  })

  -- config this, [enable under line] will gray out unused variable
  lsp.handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    update_in_insert = false,
    -- virtual_text = { spacing = 4, prefix = "\u{ea71}" },
    virtual_text = false,
    severity_sort = true,
    float = {
      header = "",
      border = "single",
    },
  })
end

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local function buf_set_keymap(...)
    vim.keymap.set(...)
  end
  local function opts(desc)
    return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  buf_set_keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts("code action"))
  buf_set_keymap("n", "<M-enter>", "<cmd>Lspsaga code_action<CR>", opts("code action"))
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts("code action"))

  buf_set_keymap("v", "<leader>ca", ":<C-U><cmd>lua vim.lsp.buf.code_action()<CR>", opts("code action"))
  buf_set_keymap("v", "<M-enter>", ":<C-U><cmd>lua vim.lsp.buf.code_action()<CR>", opts("code action"))

  -- Pressing the key twice will enter the hover window
  buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts("hover"))
  buf_set_keymap("v", "K", "<cmd>Lspsaga hover_doc<CR>", opts("hover"))

  buf_set_keymap("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts("declaration"))

  -- buf_set_keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts("definition"))
  buf_set_keymap("n", "<leader>cp", "<cmd>Lspsaga peek_definition<CR>", opts("definition"))
  buf_set_keymap("n", "<leader>cd", "<cmd>Lspsaga goto_definition<CR>", opts("definition"))

  -- buf_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts("definition"))
  buf_set_keymap("n", "<c-]>", "<cmd>Lspsaga goto_definition<CR>", opts("definition"))

  buf_set_keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts("implementation"))

  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts("references"))
  buf_set_keymap("n", "<leader>cr", "<cmd>Lspsaga finder ref+imp+def<CR>", opts("references")) -- [lspsaga] definition 和 references都会显示

  buf_set_keymap("n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts("signature_help"))

  buf_set_keymap("i", "<c-p>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts("signature_help")) -- <C-p><C-p> to enter hover win

  buf_set_keymap("n", "<leader>ce", "<cmd>Lspsaga rename<CR>", opts("edit signature"))

  -- buf_set_keymap('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap("n", "<leader>ce", "<cmd>Lspsaga show_line_diagnostics<CR>", opts("show diagnostics"))

  -- buf_set_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts("prev diagnostics"))
  -- buf_set_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts("next diagnostics"))

  -- format
  buf_set_keymap("n", "<space>cf", ":Format<CR>", opts("format"))
  buf_set_keymap("v", "<space>cf", ":Format<CR>", opts("format"))
end

local function fidgetSetup()
  if package.loaded["fidget"] ~= nil then
    return
  end
  require("fidget").setup({
    window = {
      blend = 0,
      relative = "editor",
    },
  })
end

local function troubleSetup()
  if package.loaded["trouble"] ~= nil then
    return
  end
  require("trouble").setup({
    mode = "document_diagnostics",
    auto_open = false,
    auto_close = false,
    auto_preview = false,
    auto_fold = false,
    auto_jump = { "lsp_definitions" },
  })
end

local function lspsagaSetup()
  if package.loaded["lspsaga"] ~= nil then
    return
  end
  require("lspsaga").setup({
    symbol_in_winbar = {
      separator = "＞",
    },
    lightbulb = {
      sign = false,
    },
  })
end

local function setupStatusCol()
  require("wsain.plugin.configs.ui.statuscol").setForLspConfig()
end

-- lsp configs are lazy-loaded or can be triggered after LSP installation,
-- so we need a way to make LSP clients attached to already existing buffers.
local attach_lsp_to_existing_buffers = vim.schedule_wrap(function()
  -- this can be easily achieved by firing an autocmd event for the open buffers.
  -- See lspconfig.configs (config.autostart)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local valid = vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buflisted")
    if valid and vim.bo[bufnr].buftype == "" then
      local augroup_lspconfig = vim.api.nvim_create_augroup("lspconfig", { clear = false })
      vim.api.nvim_exec_autocmds("FileType", { group = augroup_lspconfig, buffer = bufnr })
    end
  end
end)

local function ensureDepLoaded()
  setupStatusCol()
  fidgetSetup()
  lspsagaSetup()
  troubleSetup()
end

local function setupLspWrap(fun)
  return function()
    ensureDepLoaded()
    fun()
    attach_lsp_to_existing_buffers()
  end
end

local function setupLuaLsp()
  local lspconfig = require("lspconfig")
  local luadev = require("lua-dev")

  local util = require("lspconfig/util")

  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "?.lua")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")

  local command = "lua-language-server"

  local luadevConfig = luadev.setup({
    lspconfig = {
      cmd = { command },
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      },
      root_dir = function(fname)
        return util.root_pattern(".git")(fname) or util.path.dirname(fname)
      end,
    },
  })

  lspconfig.lua_ls.setup(luadevConfig)
end

local function setupBashLsp()
  local lspconfig = require("lspconfig")
  lspconfig.bashls.setup({
    on_attach = on_attach,
  })
end

local function setupCLsp()
  local lspconfig = require("lspconfig")
  lspconfig.clangd.setup({
    -- https://zhuanlan.zhihu.com/p/84876003
    cmd = {
      "clangd",
      "--background-index",
      "-j=12",
      "--clang-tidy",
      "--all-scopes-completion",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--pch-storage=disk",
    },
    on_attach = on_attach,
  })
end

local function setupGoLsp()
  local lspconfig = require("lspconfig")
  lspconfig.gopls.setup({
    on_attach = on_attach,
    root_dir = lspconfig.util.root_pattern("go.mod"),
  })
end

local function setupVimLsp()
  local lspconfig = require("lspconfig")
  lspconfig.vimls.setup({
    on_attach = on_attach,
  })
end

local function setupFrontEndLsp()
  local lspconfig = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  local servers = {
    tsserver = "typescript-language-server",
    cssls = "vscode-css-language-server",
    htmlls = "vscode-html-language-server",
    emmet = "emmet-ls",
  }

  -- tsserver
  lspconfig.tsserver.setup({
    cmd = { servers.tsserver, "--stdio" },
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    init_options = {
      hostInfo = "neovim",
    },
    capabilities = capabilities,
  })

  -- vue
  lspconfig.vuels.setup({
    on_attach = on_attach,
  })

  -- html lsp
  lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- eslint。eslint-lsp depends on eslint
  lspconfig.eslint.setup({
    capabilities = capabilities,
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "vue",
    },
    on_attach = on_attach,
  })

  -- css lsp
  lspconfig.cssls.setup({
    capabilities = capabilities,
    filetypes = { "css", "scss", "less" },
    on_attach = on_attach,
  })

  -- json lsp
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- tsserver
  lspconfig.tsserver.setup({
    cmd = { servers.tsserver, "--stdio" },
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    init_options = {
      hostInfo = "neovim",
    },
    capabilities = capabilities,
  })

  -- vue
  lspconfig.vuels.setup({
    on_attach = on_attach,
  })
end

local function setupPythonLsp()
  local lspconfig = require("lspconfig")
  lspconfig.pylsp.setup({
    on_attach = on_attach,
    root_dir = function(fname)
      return lspconfig.util.root_pattern(
        ".git",
        "setup.py",
        "setup.cfg",
        "pyproject.toml",
        "requirements.txt",
        "pyrightconfig.json"
      )(fname) or lspconfig.util.path.dirname(fname)
    end,
  })
end

local function setupPyright()
  local lspconfig = require("lspconfig")
  lspconfig.pyright.setup({
    on_attach = on_attach,
    root_dir = function(fname)
      return lspconfig.util.root_pattern(
        ".git",
        "setup.py",
        "setup.cfg",
        "pyproject.toml",
        "requirements.txt",
        "pyrightconfig.json"
      )(fname) or lspconfig.util.path.dirname(fname)
    end,
    -- config document: https://github.com/microsoft/pyright/blob/main/docs/configuration.md
    settings = {
      python = {
        analysis = {
          diagnosticMode = "openFilesOnly",
          typeCheckingMode = "off",
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = "none",
          },
        },
      },
    },
  })
end

local function setupJedi()
  local lspconfig = require("lspconfig")
  lspconfig.jedi_language_server.setup({
    on_attach = on_attach,
    root_dir = function(fname)
      return lspconfig.util.root_pattern(
        ".git",
        "setup.py",
        "setup.cfg",
        "pyproject.toml",
        "requirements.txt",
        "pyrightconfig.json"
      )(fname) or lspconfig.util.path.dirname(fname)
    end,
  })
end

local function setupPhpLsp()
  local lspconfig = require("lspconfig")
  lspconfig.intelephense.setup({
    on_attach = on_attach,
  })
end

plugin.globalMappings = {
  { "n", "<leader>S", name = "lsp server" },
  { "n", "<leader>c", name = "code" },
  { "v", "<leader>c", name = "code" },
  { "n", "<leader>cf", ":Format<cr>", "format" },
  { "v", "<leader>cf", ":Format<cr>", "format" },
  { "n", "<leader>Sl", setupLspWrap(setupLuaLsp), "lua" },
  { "n", "<leader>Sb", setupLspWrap(setupBashLsp), "bash" },
  { "n", "<leader>Sc", setupLspWrap(setupCLsp), "c/cpp" },
  { "n", "<leader>Sg", setupLspWrap(setupGoLsp), "go" },
  { "n", "<leader>Sv", setupLspWrap(setupVimLsp), "vim" },
  { "n", "<leader>SF", setupLspWrap(setupFrontEndLsp), "frontend" },
  { "n", "<leader>Sp", name = "python" },
  { "n", "<leader>Spl", setupLspWrap(setupPythonLsp), "pylsp" },
  { "n", "<leader>Spr", setupLspWrap(setupPyright), "pyright" },
  { "n", "<leader>Spj", setupLspWrap(setupJedi), "jedi" },
  { "n", "<leader>Sh", setupLspWrap(setupPhpLsp), "php" },
}

return plugin
