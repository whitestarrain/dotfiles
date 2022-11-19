vim.cmd([[
  Plug 'whitestarrain/md-section-number.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  require("md_section_number").setup({
    max_level = 4,
    ignore_pairs = {
      { "```", "```" },
      { "\\~\\~\\~", "\\~\\~\\~" },
      { "<!--", "-->" },
    },
  })
end
