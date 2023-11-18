local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "voldikss/vim-floaterm"
plugin.loadEvent = "VeryLazy"

plugin.init = function()
  vim.g.floaterm_opener = "edit"
  local os = utils.getOs()
  if os == "win" then
    vim.g.floaterm_shell = "cmd"
  elseif os == "mac" then
    vim.g.floaterm_shell = "zsh"
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

if utils.getOs() ~= "win" then
  table.insert(plugin.globalMappings, {
    "n",
    "<leader>l",
    function()
      vim.fn.execute("FloatermNew ranger")
    end,
    "ranger",
  })
  table.insert(plugin.globalMappings, {
    "n",
    "<leader>k",
    function()
      vim.fn.execute("FloatermNew ranger .")
    end,
    "ranger",
  })
end

return plugin
