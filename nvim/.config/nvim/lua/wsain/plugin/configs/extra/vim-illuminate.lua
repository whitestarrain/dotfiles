local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "RRethy/vim-illuminate"
plugin.config = function()
  -- default configuration
  require("illuminate").configure({
    providers = {
      "lsp",
      "treesitter",
      -- "regex",
    },
    delay = 200,
    filetype_overrides = {},
    filetypes_denylist = {
      "dirbuf",
      "dirvish",
      "fugitive",
      "NvimTree",
      "msnumber",
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
    large_file_cutoff = 3000,
    large_file_overrides = nil,
    min_count_to_highlight = 1,
    should_enable = function(bufnr)
      return true
    end,
    case_insensitive_regex = false,
  })
end

return plugin
