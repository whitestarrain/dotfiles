local config = require("wsain.treesitter.config")
local ins = require("wsain.treesitter.install")

config.setup({ install_dir = vim.g.absolute_config_path .. ".treesitter-parsers" })

local custom_langs = {
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

vim.api.nvim_create_user_command("TSInstallCustom", function(_)
  ins.install(custom_langs, { max_jobs = 5 })
end, {
  desc = "install treesitter parsers",
})

vim.api.nvim_create_user_command("TSInstall", function(args)
  ins.install(args.fargs, { force = args.bang, summary = true })
end, {
  nargs = "+",
  bang = true,
  bar = true,
  complete = complete_available_parsers,
  desc = "Install treesitter parsers",
})
