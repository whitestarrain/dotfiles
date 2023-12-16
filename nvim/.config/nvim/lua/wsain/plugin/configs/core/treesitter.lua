local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-treesitter/nvim-treesitter"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  "windwp/nvim-ts-autotag",
}
plugin.opts = {
  auto_install = false,

  additional_vim_regex_highlighting = false,

  highlight = {
    enable = true,
    disable = function(lang, bufnr)
      if lang == "markdown" and vim.api.nvim_buf_line_count(bufnr) > 5000 then
        return true
      end
      return false
    end,
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
  },

  indent = {
    enable = true,
    disable = { "markdown", "html", "php", "python", "c", "cpp" },
  },

  autotag = {
    enable = true,
    disable = { "markdown" },
  },
}
plugin.config = function()
  require("nvim-treesitter.configs").setup(plugin.opts)
  --[[
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 99
 ]]
end
return plugin