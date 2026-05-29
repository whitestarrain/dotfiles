local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "williamboman/mason.nvim"
plugin.load_event = "VeryLazy"
plugin.dependencies = {
  "mason-org/mason-registry",
}
plugin.config = function()
  require("mason").setup({
    install_root_dir = vim.g.absolute_config_path .. ".mason",
    ui = {
      border = "single",
    },
    registries = {
      "github:mason-org/mason-registry",
      "github:nvim-java/mason-registry",
    },
  })
  local tools = {
    "basedpyright",
    "bash-language-server",
    "black",
    "checkmake",
    "clangd",
    "clang-format",
    "codelldb",
    "cpplint",
    "cpptools",
    "css-lsp",
    "cssmodules-language-server",
    "darker",
    "debugpy",
    "docformatter",
    "emmet-language-server",
    "emmet-ls",
    "eslint-lsp",
    "firefox-debug-adapter",
    "flake8",
    "go-debug-adapter",
    "goimports",
    "gopls",
    "html-lsp",
    "isort",
    "java-debug-adapter",
    "java-test",
    "jdtls",
    "jedi-language-server",
    "jq",
    "jsonlint",
    "json-lsp",
    "luacheck",
    "lua-language-server",
    "prettier",
    "prettierd",
    "python-lsp-server",
    "ruff",
    "rust-analyzer",
    "selene",
    "shellcheck",
    "shfmt",
    "sqlfluff",
    "sqlfmt",
    "sql-formatter",
    "sqlls",
    "stylua",
    "texlab",
    "typescript-language-server",
    "vetur-vls",
    "vim-language-server",
    "vscode-java-decompiler",
    "vtsls",
    "vue-language-server",
  }
  vim.api.nvim_create_user_command(
    "MasonInstallCustom",
    "MasonInstall" .. " " .. table.concat(tools, " "),
    { desc = "install default tools" }
  )
end

return plugin
