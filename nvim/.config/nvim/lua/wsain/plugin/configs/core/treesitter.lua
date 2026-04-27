local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "whitestarrain/nvim-treesitter"
plugin.loadEvent = "VeryLazy"
plugin.branch = "main"
plugin.config = function()
  require("nvim-treesitter").setup({ install_dir = vim.g.absolute_config_path .. ".treesitter-parsers" })

  -- stylua: ignore start
  local custom_langs = {
    "awk", "bash", "c", "commonlisp", "cpp", "c_sharp", "css",
    "diff", "dot", "go", "groovy", "html", "ini", "java",
    "javascript", "json", "kotlin", "lua", "make", "markdown",
    "markdown_inline", "nix", "perl", "php", "python", "query",
    "regex", "ruby", "rust", "scala", "scheme", "scss", "sql", "tsx",
    "typescript", "vim", "vimdoc", "vue", "yaml", "zig",
  }
  -- stylua: ignore end

  vim.api.nvim_create_user_command("TSInstallCustom", function(_)
    require("nvim-treesitter").install(custom_langs, { max_jobs = 5 })
  end, {
    desc = "install treesitter parsers",
  })
end

return plugin
