local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "Wansmer/treesj"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  local lang_utils = require("treesj.langs.utils")
  require("treesj").setup({
    use_default_keymaps = false,
    check_syntax_error = true,
    max_join_length = 120,
    cursor_behavior = "hold",
    notify = false,
    dot_repeat = true,
    on_error = nil,
  })
end

plugin.globalMappings = {
  { "n", "<leader>cm", ":TSJToggle<cr>", "multiline toggle" },
}

return plugin
