local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")
require("wsain.plugin.whichkey").register({
  { "<leader>d", ":bp|bd #<cr>", desc = "delete buffer" },
  { "<leader>z", group = "+others", mode = "n" },
  { "<leader>z", group = "+others", mode = "v" },
  { "<leader>zp", ":syntax sync fromstart<cr>", desc = "syntax sync" },
  { "<leader>zl", ":%s/\\v(\\n\\s*){2,}/\\r\\r/<cr> :/jkjk<cr>", desc = "compress blank line" },
  { "<leader>zf", ':echo expand("%:p")<cr>', desc = "show file path" },
  { "<leader>zu", require("wsain.utils").openFileUnderCursor, desc = "open file under cursor" },
  { "<leader>zo", require("wsain.utils").openCurrentFile, desc = "open current file" },
  { "<leader>m", group = "markdown" },
  { "<leader>md", group = "download" },
  {
    "<leader>mdi",
    function()
      utils.save_markdown_url_images()
    end,
    desc = "download images",
  },
  {
    "<leader>mdI",
    function()
      utils.save_markdown_url_images(true)
    end,
    desc = "download images using proxy",
  },
  {
    "<leader>e",
    function()
      local path_separator = "/"
      if utils.getOs() == "win" then
        path_separator = "\\"
      end
      vim.api.nvim_feedkeys(":e " .. vim.fn.getcwd() .. path_separator, "n", "false")
    end,
    desc = "edit file",
  },
  {
    "<leader>zs",
    [[:s/[^\x00-\xff]\zs\ze\w\|\w\zs\ze[^\x00-\xff]/ /g<CR>]],
    desc = "wrap english word with space",
    mode = "v",
  },
})

return plugin
