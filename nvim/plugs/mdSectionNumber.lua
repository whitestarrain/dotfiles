vim.cmd([[
  Plug 'whitestarrain/md-section-number.nvim', { 'branch': 'master' }
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
  vim.cmd([[
    if exists("g:startify_session_before_save")
      let g:startify_session_before_save +=  ['lua require("md_section_number.toc").closeToc()']
      nnoremap <silent><leader>t :lua require("md_section_number.toc").toggle()<CR>
      let g:which_key_map.t = "markdownToc"
    endif
  ]])
end
