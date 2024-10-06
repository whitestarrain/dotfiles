local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-treesitter/nvim-treesitter"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
}
plugin.opts = {
  auto_install = false,

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
  require("nvim-treesitter.configs").setup(plugin.opts)
  --[[
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 99
 ]]

  local lang_module = {
    "awk",
    "bash",
    "c",
    "c_sharp",
    "commonlisp",
    "cpp",
    "css",
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
end

return plugin
