local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "whitestarrain/md-section-number.nvim"
plugin.opts = {
  max_level = 4,
  ignore_pairs = {
    { "```", "```" },
    { "\\~\\~\\~", "\\~\\~\\~" },
    { "<!--", "-->" },
  },
}
plugin.config = function()
  require("md_section_number").setup(plugin.opts)
end
plugin.globalMappings = {
  { "n", "<leader>m", name = "markdown" },
  {
    "n",
    "<leader>mt",
    function()
      require("md_section_number.toc").toggle()
    end,
    "markdownToc",
  },
}

return plugin
