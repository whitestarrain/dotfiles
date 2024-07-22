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

local file_exploer = "lf"
if utils.getOs() ~= "win" and vim.fn.executable(file_exploer) == 0 then
  file_exploer = "ranger"
end

plugin.config = function()
  local mappings = {
    { "<M-+>", ":FloatermNew<cr>" },
    { "<M-=>", ":FloatermToggle<cr>" },
    { "<M-+>", "<c-\\><c-n>:FloatermNew<cr>", mode = "t" },
    { "<M-=>", "<c-\\><c-n>:FloatermToggle<cr>", mode = "t" },
  }

  if vim.fn.executable(file_exploer) then
    table.insert(mappings, {
      "<leader>k",
      function()
        vim.fn.execute("FloatermNew " .. " --title=" .. file_exploer .. " " .. file_exploer)
      end,
      desc = "ranger",
    })
    table.insert(mappings, {
      "<leader>K",
      function()
        vim.fn.execute("FloatermNew " .. " --title=" .. file_exploer .. " " .. file_exploer .. " . ")
      end,
      desc = "ranger",
    })
  end
  require("wsain.plugin.whichkey").register({
    mappings,
  })
end

return plugin
