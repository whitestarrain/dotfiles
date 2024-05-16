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
      if lang == "vim" then
        local win_type = vim.fn.getcmdwintype()
        -- use vim syntax highlight for cmdwin
        if win_type == ":" then
          return true
        end
      end
      if lang == "markdown" and vim.api.nvim_buf_line_count(bufnr) > 2000 then
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
    -- disable in cmdwin
    is_supported = function()
      local win_type = vim.fn.getcmdwintype()
      if win_type == ":" then
        return false
      end
    end,
  },

  indent = {
    enable = true,
    disable = { "markdown", "html", "php", "c", "cpp" },
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

  lang_module = {
    "awk",
    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "dot",
    "go",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "query",
    "regex",
    "ruby",
    "rust",
    "scss",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "zig",
  }
  vim.api.nvim_create_user_command(
    "TSInstallCustom",
    "TSInstall" .. " " .. table.concat(lang_module, " "),
    { desc = "install default ts parser"}
  )
end

return plugin
