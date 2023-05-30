local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "neovim/nvim-lspconfig"
plugin.dependencies = {
  "glepnir/lspsaga.nvim",
  "folke/trouble.nvim",
  "simrat39/symbols-outline.nvim",
  "whitestarrain/lua-dev.nvim",
  "jose-elias-alvarez/null-ls.nvim",
  "ray-x/lsp_signature.nvim",
}
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  -- diagnostic config
  vim.diagnostic.config({
    virtual_text = false,
    underline = false,
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
end

local custom_get_format_client = function(bufnr)
  -- prefer null-ls format
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr, name = "null-ls" })
  if #clients > 0 and clients[1]["server_capabilities"]["documentFormattingProvider"] then
    return "null-ls"
  end
  return nil
end

local custom_format = function(bufnr)
  local filter = function(_)
    return true
  end
  local clientName = custom_get_format_client(bufnr)
  if clientName ~= nil then
    filter = function(client)
      return client.name == clientName
    end
  end
  vim.lsp.buf.format({
    filter = filter,
    timeout_ms = 5000,
    bufnr = bufnr,
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

  buf_set_keymap("v", "<leader>ca", ":<C-U><cmd>lua vim.lsp.buf.range_code_action()<CR>", opts("code action"))
  buf_set_keymap("v", "<M-enter>", ":<C-U><cmd>lua vim.lsp.buf.range_code_action()<CR>", opts("code action"))
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts("code action"))

  -- Pressing the key twice will enter the hover window
  buf_set_keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts("hover"))
  buf_set_keymap("v", "K", "<cmd>Lspsaga hover_doc<CR>", opts("hover"))

  buf_set_keymap("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts("declaration"))

  -- buf_set_keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts("definition"))
  buf_set_keymap("n", "<leader>cp", "<cmd>Lspsaga peek_definition<CR>", opts("definition"))
  buf_set_keymap("n", "<leader>cd", "<cmd>Lspsaga goto_definition<CR>", opts("definition"))

  -- buf_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition() <cr>", opts("definition"))
  buf_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition() <cr>", opts("definition"))

  buf_set_keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts("implementation"))

  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts("references"))
  buf_set_keymap("n", "<leader>cr", "<cmd>Lspsaga lsp_finder<CR>", opts("references")) -- [lspsaga] definition 和 references都会显示

  buf_set_keymap("n", "<leader>cs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts("signature_help"))

  buf_set_keymap("i", "<c-p>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts("signature_help")) -- <C-p><C-p> to enter hover win

  buf_set_keymap("n", "<leader>cR", "<cmd>Lspsaga rename<CR>", opts("rename"))

  -- buf_set_keymap('n', 'go', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap("n", "<leader>ce", "<cmd>Lspsaga show_line_diagnostics<CR>", opts("show diagnostics"))

  buf_set_keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts("prev diagnostics"))
  -- buf_set_keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts("prev diagnostics"))
  buf_set_keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts("next diagnostics"))
  -- buf_set_keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts("next diagnostics"))

  -- format
  buf_set_keymap("n", "<space>cf", custom_format, opts("format"))
  buf_set_keymap("v", "<space>cf", custom_format, opts("format"))

  buf_set_keymap("n", "<space>ct", ":SymbolsOutline<CR>", opts("outline"))

  -- lsp signature help
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded",
    },
    floating_window = false,
    hi_parameter = "Error",
  }, bufnr)

  buf_set_keymap("i", "<A-,>", function()
    require("lsp_signature").toggle_float_win()
  end, opts("outline"))
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
  })
end

local function outlineSetup()
  if package.loaded["symbols-outline"] ~= nil then
    return
  end
  require("symbols-outline").setup({
    keymaps = {
      -- These keymaps can be a string or a table for multiple keys
      close = { "<Esc>", "q" },
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "K",
      toggle_preview = "P",
      rename_symbol = "r",
      -- code_actions = "a",
      fold = "h",
      unfold = "l",
      fold_all = "W",
      unfold_all = "E",
      fold_reset = "R",
    },
    symbols = {
      File = { icon = "", hl = "@URI" },
      Module = { icon = "", hl = "@Namespace" },
      Namespace = { icon = "", hl = "@Namespace" },
      Package = { icon = "", hl = "@Namespace" },
      Class = { icon = "ﴯ", hl = "@Type" },
      Method = { icon = "ƒ", hl = "@Method" },
      Property = { icon = "", hl = "@Method" },
      Field = { icon = "ﰠ", hl = "@Field" },
      Constructor = { icon = "", hl = "@Constructor" },
      Enum = { icon = "ℰ", hl = "@Type" },
      Interface = { icon = "ﰮ", hl = "@Type" },
      Function = { icon = "", hl = "@Function" },
      Variable = { icon = "", hl = "@Constant" },
      Constant = { icon = "", hl = "@Constant" },
      String = { icon = "", hl = "@String" },
      Number = { icon = "#", hl = "@Number" },
      Boolean = { icon = "⊨", hl = "@Boolean" },
      Array = { icon = "", hl = "@Constant" },
      Object = { icon = "⦿", hl = "@Type" },
      Key = { icon = "", hl = "@Type" },
      Null = { icon = "NULL", hl = "@Type" },
      EnumMember = { icon = "", hl = "@Field" },
      Struct = { icon = "פּ", hl = "@Type" },
      Event = { icon = "", hl = "@Type" },
      Operator = { icon = "+", hl = "@Operator" },
      TypeParameter = { icon = "", hl = "@Parameter" },
    },
  })
  require("wsain.utils").addCommandBeforeSaveSession("silent! SymbolsOutlineClose")
end

local function nulllsSetup()
  if package.loaded["null-ls"] ~= nil then
    return
  end
  local null_ls = require("null-ls")
  local null_ls_source = {
    -- lua
    null_ls.builtins.formatting.stylua,
    -- bash
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.formatting.shfmt,
    -- frontend
    null_ls.builtins.formatting.prettier.with({
      disabled_filetypes = { "markdown" },
    }),
    -- python
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.autopep8,
  }
  null_ls.setup({
    sources = null_ls_source,
    on_attach = on_attach,
  })
end

local function ensureDepLoaded()
  lspsagaSetup()
  troubleSetup()
  outlineSetup()
  nulllsSetup()
end

local function setupLspWrap(fun)
  return function()
    ensureDepLoaded()
    fun()
    vim.fn.execute("w")
    vim.fn.execute("e")
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
    -- disable shellcheck in bashls
    cmd_env = { SHELLCHECK_PATH = "" },
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
  { "n", "<leader>Sn", nulllsSetup, "null-lsp" },
  { "n", "<leader>Sl", setupLspWrap(setupLuaLsp), "lua" },
  { "n", "<leader>Sb", setupLspWrap(setupBashLsp), "bash" },
  { "n", "<leader>Sc", setupLspWrap(setupCLsp), "c/cpp" },
  { "n", "<leader>Sg", setupLspWrap(setupGoLsp), "go" },
  { "n", "<leader>Sv", setupLspWrap(setupVimLsp), "vim" },
  { "n", "<leader>SF", setupLspWrap(setupFrontEndLsp), "frontend" },
  { "n", "<leader>Sp", setupLspWrap(setupPythonLsp), "python" },
  { "n", "<leader>Spl", setupLspWrap(setupPythonLsp), "pylsp" },
  { "n", "<leader>Spr", setupLspWrap(setupPyright), "pyright" },
  { "n", "<leader>Spj", setupLspWrap(setupJedi), "jedi" },
  { "n", "<leader>Sh", setupLspWrap(setupPhpLsp), "php" },
}

return plugin
