local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "whitestarrain/md-section-number.nvim"
plugin.loadEvent = "VeryLazy"
plugin.opts = {
  max_level = 4,
  min_level = 1,
  ignore_pairs = {
    { "```", "```" },
    { "\\~\\~\\~", "\\~\\~\\~" },
    { "<!--", "-->" },
  },
}
plugin.config = function()
  require("md_section_number").setup(plugin.opts)
  require("wsain.utils").addCommandBeforeSaveSession('lua require("md_section_number.toc").closeToc()')
  require("wsain.plugin.whichkey").register({
    { "<leader>m", group = "markdown" },
    {
      "<leader>mt",
      function()
        require("md_section_number.toc").toggle()
      end,
      desc = "markdownToc",
    },
  })
end

return plugin
