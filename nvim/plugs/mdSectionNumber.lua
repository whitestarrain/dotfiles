vim.cmd([[
  Plug 'whitestarrain/md-section-number.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, md_section_number = pcall(require, "md_section_number")
  if not status then
    return
  end
  md_section_number.setup({
    max_level = 4,
    ignore_pairs = {
      { "```", "```" },
      { "\\~\\~\\~", "\\~\\~\\~" },
      { "<!--", "-->" },
    },
  })
end
