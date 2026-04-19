local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-treesitter/nvim-treesitter"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
}

if vim.version().major == 0 and vim.version().minor <= 11 then
  plugin.branch = "master"
else
  plugin.branch = "main"
end

plugin.opts = {
  auto_install = false,

  install_dir = vim.g.absolute_config_path .. ".treesitter-parsers",

  highlight = {
    enable = false,
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    disable = { "markdown" },
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      -- scope_incremental = '<TAB>',
    },
    -- disable in cmdwin
    is_supported = function()
      local win_type = vim.fn.getcmdwintype()
      if win_type == ":" then
        return false
      end
      return true
    end,
  },

  indent = {
    enable = true,
    disable = { "markdown", "html", "php", "c", "cpp", "lua" },
  },
}

plugin.config = function()
  require("nvim-treesitter").setup(plugin.opts)
  --[[
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 99
 ]]

  local lang_module = {
    "awk",
    "bash",
    "c",
    "commonlisp",
    "cpp",
    "c_sharp",
    "css",
    "diff",
    "dot",
    "go",
    "groovy",
    "html",
    "ini",
    "java",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "perl",
    "php",
    "python",
    "query",
    "regex",
    "ruby",
    "rust",
    "scala",
    "scheme",
    "scss",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "vue",
    "yaml",
    "zig",
  }
  vim.api.nvim_create_user_command(
    "TSInstallCustom",
    "TSInstall" .. " " .. table.concat(lang_module, " "),
    { desc = "install default ts parser" }
  )

  -- treesitter fold
  -- vim.opt_local.foldmethod = "expr"
  -- vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

  -- treesitter indent
  -- vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
end

return plugin
