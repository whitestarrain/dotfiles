local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "voldikss/vim-floaterm"
plugin.globalMappings = (function()
  if utils.getOs() ~= "win" then
    return {
      key = "<leader>r",
      cmd = function()
        vim.fn.execute("FloatermNew ranger")
      end,
      desc = "ranger",
    }
  end
  return nil
end)()

plugin.init = function()
  vim.g.floaterm_opener = "edit"
  if utils.getOs() == "win" then
    vim.g.floaterm_shell = "cmd"
  else
    vim.g.floaterm_shell = "bash"
  end

  vim.g.floaterm_position = "center"
  vim.g.floaterm_width = 0.85
  vim.g.floaterm_height = 0.85

  vim.cmd([[
    augroup vime_floaterm_group
      autocmd!
      au FileType floaterm tnoremap <buffer> <silent> <M-h> <c-\><c-n>:FloatermPrev<CR>
      au FIleType floaterm tnoremap <buffer> <silent> <M-l> <c-\><c-n>:FloatermNext<CR>
    augroup END
  ]])
end
plugin.globalMappings = {
  { "n", "<M-+>", ":FloatermNew<cr>" },
  { "n", "<M-=>", ":FloatermToggle<cr>" },
  { "t", "<M-+>", "<c-\\><c-n>:FloatermNew<cr>" },
  { "t", "<M-=>", "<c-\\><c-n>:FloatermToggle<cr>" },
}

return plugin
